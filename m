From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 2/2] ALSA: hdspm - Provide unique driver id
	based on card serial
Date: Wed,  4 Jan 2012 14:31:17 +0100
Message-ID: <1325683877-16783-2-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1325683877-16783-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1325683877-16783-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

 2 [HDSPM_f1cd85   ]: HDSPM - RME RayDAT_f1cd85
                      RME RayDAT S/N 0xf1cd85 at 0xf7300000, irq 18

In this example, userspace (configuration files) would then use
hw:HDSPM_f1cd85 to choose the right card.

The serial is masked to 24bits, so this string is always shorter than
sixteen chars.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 1609253..a3121c9 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -6872,6 +6872,7 @@ static int __devinit snd_hdspm_probe(struct pci_dev *pci,
 		sprintf(card->shortname, "%s_%x",
 			hdspm->card_name,
 			hdspm->serial);
+		sprintf(card->id, "HDSPM_%x", hdspm->serial);
 		sprintf(card->longname, "%s S/N 0x%x at 0x%lx, irq %d",
 			hdspm->card_name,
 			hdspm->serial,
-- 
1.7.7.3
