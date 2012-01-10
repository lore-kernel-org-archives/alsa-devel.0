From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/1] ALSA: hdspm - Provide unique driver id
	based on card serial
Date: Tue, 10 Jan 2012 20:58:40 +0100
Message-ID: <1326225520-6678-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <4F0C9733.8060300@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4F0C9733.8060300@drcomp.erfurt.thur.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Before, /proc/asound looked like this:

 2 [Default        ]: HDSPM - RME RayDAT_f1cd85
                      RME RayDAT S/N 0xf1cd85 at 0xf7300000, irq 18

In case of a second HDSPM card, its name would be Default_1. This is
cumbersome, because the order of the cards isn't stable across reboots.

To help userspace tools referring to the correct card, this commit
provides a unique id for each card:

 2 [HDSPMxf1cd85   ]: HDSPM - RME RayDAT_f1cd85
                      RME RayDAT S/N 0xf1cd85 at 0xf7300000, irq 18

In this example, userspace (configuration files) would then use
hw:HDSPMxf1cd85 to choose the right card.

The serial is masked to 24bits, so this string is always shorter than
sixteen chars.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 1609253..cc9f6c8 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6783,6 +6783,25 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 	tasklet_init(&hdspm->midi_tasklet,
 			hdspm_midi_tasklet, (unsigned long) hdspm);
 
+
+	if (hdspm->io_type != MADIface) {
+		hdspm->serial = (hdspm_read(hdspm,
+				HDSPM_midiStatusIn0)>>8) & 0xFFFFFF;
+		/* id contains either a user-provided value or the default
+		 * NULL. If it's the default, we're safe to
+		 * fill card->id with the serial number.
+		 *
+		 * If the serial number is 0xFFFFFF, then we're dealing with
+		 * an old PCI revision that comes without a sane number. In
+		 * this case, we don't set card->id to avoid collisions
+		 * when running with multiple cards.
+		 */
+		if (NULL == id[hdspm->dev] && hdspm->serial != 0xFFFFFF) {
+			sprintf(card->id, "HDSPMx%06x", hdspm->serial);
+			snd_card_set_id(card, card->id);
+		}
+	}
+
 	snd_printdd("create alsa devices.\n");
 	err = snd_hdspm_create_alsa_devices(card, hdspm);
 	if (err < 0)
@@ -6867,8 +6886,6 @@ static int __devinit snd_hdspm_probe(struct pci_dev *pci,
 	}
 
 	if (hdspm->io_type != MADIface) {
-		hdspm->serial = (hdspm_read(hdspm,
-				HDSPM_midiStatusIn0)>>8) & 0xFFFFFF;
 		sprintf(card->shortname, "%s_%x",
 			hdspm->card_name,
 			hdspm->serial);
-- 
1.7.8.2
