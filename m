From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 3/3] ALSA: hdspm - Enable all firmware ranges
	for PCI MADI/AES cards
Date: Thu, 27 Oct 2011 21:57:54 +0200
Message-ID: <1319745474-31542-3-git-send-email-adi@drcomp.erfurt.thur.de>
References: <1319745474-31542-1-git-send-email-adi@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1319745474-31542-1-git-send-email-adi@drcomp.erfurt.thur.de>
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

>From the Windows INF file, we know the firmware ranges for all RME
cards. For PCIe, a single revision ID per device (RayDAT, MADI, AIO,
AES) is used. Contrary, the older PCI versions use ranges, that is,
one revision ID per firmware version.

Instead of listing all possible revisions individually, match the range.

This commit enables all MADI and AES PCI versions ever shipped.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 60a0b7d..15a6c3b 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -520,16 +520,9 @@ MODULE_SUPPORTED_DEVICE("{{RME HDSPM-MADI}}");
 #define HDSPM_DMA_AREA_BYTES (HDSPM_MAX_CHANNELS * HDSPM_CHANNEL_BUFFER_BYTES)
 #define HDSPM_DMA_AREA_KILOBYTES (HDSPM_DMA_AREA_BYTES/1024)
 
-/* revisions >= 230 indicate AES32 card */
-#define HDSPM_MADI_ANCIENT_REV	204
-#define HDSPM_MADI_OLD_REV	207
-#define HDSPM_MADI_REV		210
 #define HDSPM_RAYDAT_REV	211
 #define HDSPM_AIO_REV		212
 #define HDSPM_MADIFACE_REV	213
-#define HDSPM_AES_REV		240
-#define HDSPM_AES32_REV		234
-#define HDSPM_AES32_OLD_REV	233
 
 /* speed factor modes */
 #define HDSPM_SPEED_SINGLE 0
@@ -6503,13 +6496,6 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 	strcpy(card->driver, "HDSPM");
 
 	switch (hdspm->firmware_rev) {
-	case HDSPM_MADI_REV:
-	case HDSPM_MADI_OLD_REV:
-	case HDSPM_MADI_ANCIENT_REV:
-		hdspm->io_type = MADI;
-		hdspm->card_name = "RME MADI";
-		hdspm->midiPorts = 3;
-		break;
 	case HDSPM_RAYDAT_REV:
 		hdspm->io_type = RayDAT;
 		hdspm->card_name = "RME RayDAT";
@@ -6525,17 +6511,25 @@ static int __devinit snd_hdspm_create(struct snd_card *card,
 		hdspm->card_name = "RME MADIface";
 		hdspm->midiPorts = 1;
 		break;
-	case HDSPM_AES_REV:
-	case HDSPM_AES32_REV:
-	case HDSPM_AES32_OLD_REV:
-		hdspm->io_type = AES32;
-		hdspm->card_name = "RME AES32";
-		hdspm->midiPorts = 2;
-		break;
 	default:
-		snd_printk(KERN_ERR "HDSPM: unknown firmware revision %x\n",
+		if ((hdspm->firmware_rev == 0xf0) ||
+			((hdspm->firmware_rev >= 0xe6) &&
+					(hdspm->firmware_rev <= 0xea))) {
+			hdspm->io_type = AES32;
+			hdspm->card_name = "RME AES32";
+			hdspm->midiPorts = 2;
+		} else if ((hdspm->firmware_rev == 0xd5) ||
+			((hdspm->firmware_rev >= 0xc8)  &&
+				(hdspm->firmware_rev <= 0xcf))) {
+			hdspm->io_type = MADI;
+			hdspm->card_name = "RME MADI";
+			hdspm->midiPorts = 3;
+		} else {
+			snd_printk(KERN_ERR
+				"HDSPM: unknown firmware revision %x\n",
 				hdspm->firmware_rev);
-		return -ENODEV;
+			return -ENODEV;
+		}
 	}
 
 	err = pci_enable_device(pci);
-- 
1.7.7.1
