From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 1/2] ALSA: hdspm - Refactor serial number to
	avoid code duplication
Date: Wed,  4 Jan 2012 14:31:16 +0100
Message-ID: <1325683877-16783-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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

The serial number is used multiple times in hdspm.c. Since it belongs
to the card, let's store it in struct hdspm and refer to it whenever
necessary.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index d623451..1609253 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -941,6 +941,8 @@ struct hdspm {
 
 	cycles_t last_interrupt;
 
+	unsigned int serial;
+
 	struct hdspm_peak_rms peak_rms;
 };
 
@@ -4694,7 +4696,7 @@ snd_hdspm_proc_read_madi(struct snd_info_entry * entry,
 
 	snd_iprintf(buffer, "HW Serial: 0x%06x%06x\n",
 			(hdspm_read(hdspm, HDSPM_midiStatusIn1)>>8) & 0xFFFFFF,
-			(hdspm_read(hdspm, HDSPM_midiStatusIn0)>>8) & 0xFFFFFF);
+			hdspm->serial);
 
 	snd_iprintf(buffer, "IRQ: %d Registers bus: 0x%lx VM: 0x%lx\n",
 			hdspm->irq, hdspm->port, (unsigned long)hdspm->iobase);
@@ -6266,8 +6268,7 @@ static int snd_hdspm_hwdep_ioctl(struct snd_hwdep *hw, struct file *file,
 		hdspm_version.card_type = hdspm->io_type;
 		strncpy(hdspm_version.cardname, hdspm->card_name,
 				sizeof(hdspm_version.cardname));
-		hdspm_version.serial = (hdspm_read(hdspm,
-					HDSPM_midiStatusIn0)>>8) & 0xFFFFFF;
+		hdspm_version.serial = hdspm->serial;
 		hdspm_version.firmware_rev = hdspm->firmware_rev;
 		hdspm_version.addons = 0;
 		if (hdspm->tco)
@@ -6866,12 +6867,14 @@ static int __devinit snd_hdspm_probe(struct pci_dev *pci,
 	}
 
 	if (hdspm->io_type != MADIface) {
+		hdspm->serial = (hdspm_read(hdspm,
+				HDSPM_midiStatusIn0)>>8) & 0xFFFFFF;
 		sprintf(card->shortname, "%s_%x",
 			hdspm->card_name,
-			(hdspm_read(hdspm, HDSPM_midiStatusIn0)>>8) & 0xFFFFFF);
+			hdspm->serial);
 		sprintf(card->longname, "%s S/N 0x%x at 0x%lx, irq %d",
 			hdspm->card_name,
-			(hdspm_read(hdspm, HDSPM_midiStatusIn0)>>8) & 0xFFFFFF,
+			hdspm->serial,
 			hdspm->port, hdspm->irq);
 	} else {
 		sprintf(card->shortname, "%s", hdspm->card_name);
-- 
1.7.7.3
