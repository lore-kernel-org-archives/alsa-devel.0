From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/3] ALSA: emu10k1: Simplify firmware loader
	code
Date: Tue, 15 Nov 2016 08:24:08 +0100
Message-ID: <20161115072409.29531-3-tiwai@suse.de>
References: <20161115072409.29531-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D152266FF1
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 08:24:19 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id BAA25ACE1
 for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2016 07:24:19 +0000 (UTC)
In-Reply-To: <20161115072409.29531-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The EMU1010 support in emu10k1 driver has two request_firmware()
calls, one for the main board and one for the dock.  Both call
patterns are fairly similar, and we can simplify it by introducing a
helper function and a table instead of the open switch/case.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/emu10k1/emu10k1_main.c | 102 +++++++++++++++------------------------
 1 file changed, 40 insertions(+), 62 deletions(-)

diff --git a/sound/pci/emu10k1/emu10k1_main.c b/sound/pci/emu10k1/emu10k1_main.c
index c1b603a8922c..03d793f3b058 100644
--- a/sound/pci/emu10k1/emu10k1_main.c
+++ b/sound/pci/emu10k1/emu10k1_main.c
@@ -662,7 +662,7 @@ static int snd_emu10k1_cardbus_init(struct snd_emu10k1 *emu)
 	return 0;
 }
 
-static int snd_emu1010_load_firmware(struct snd_emu10k1 *emu,
+static int snd_emu1010_load_firmware_entry(struct snd_emu10k1 *emu,
 				     const struct firmware *fw_entry)
 {
 	int n, i;
@@ -708,6 +708,40 @@ static int snd_emu1010_load_firmware(struct snd_emu10k1 *emu,
 	return 0;
 }
 
+/* firmware file names, per model, init-fw and dock-fw (optional) */
+static const char * const firmware_names[5][2] = {
+	[EMU_MODEL_EMU1010] = {
+		HANA_FILENAME, DOCK_FILENAME
+	},
+	[EMU_MODEL_EMU1010B] = {
+		EMU1010B_FILENAME, MICRO_DOCK_FILENAME
+	},
+	[EMU_MODEL_EMU1616] = {
+		EMU1010_NOTEBOOK_FILENAME, MICRO_DOCK_FILENAME
+	},
+	[EMU_MODEL_EMU0404] = {
+		EMU0404_FILENAME, NULL
+	},
+};
+
+static int snd_emu1010_load_firmware(struct snd_emu10k1 *emu, int dock,
+				     const struct firmware **fw)
+{
+	const char *filename;
+	int err;
+
+	if (!*fw) {
+		filename = firmware_names[emu->card_capabilities->emu_model][dock];
+		if (!filename)
+			return 0;
+		err = request_firmware(fw, filename, &emu->pci->dev);
+		if (err)
+			return err;
+	}
+
+	return snd_emu1010_load_firmware_entry(emu, *fw);
+}
+
 static int emu1010_firmware_thread(void *data)
 {
 	struct snd_emu10k1 *emu = data;
@@ -732,34 +766,9 @@ static int emu1010_firmware_thread(void *data)
 			dev_info(emu->card->dev,
 				 "emu1010: Loading Audio Dock Firmware\n");
 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, EMU_HANA_FPGA_CONFIG_AUDIODOCK);
-
-			if (!emu->dock_fw) {
-				const char *filename = NULL;
-				switch (emu->card_capabilities->emu_model) {
-				case EMU_MODEL_EMU1010:
-					filename = DOCK_FILENAME;
-					break;
-				case EMU_MODEL_EMU1010B:
-					filename = MICRO_DOCK_FILENAME;
-					break;
-				case EMU_MODEL_EMU1616:
-					filename = MICRO_DOCK_FILENAME;
-					break;
-				}
-				if (filename) {
-					err = request_firmware(&emu->dock_fw,
-							       filename,
-							       &emu->pci->dev);
-					if (err)
-						continue;
-				}
-			}
-
-			if (emu->dock_fw) {
-				err = snd_emu1010_load_firmware(emu, emu->dock_fw);
-				if (err)
-					continue;
-			}
+			err = snd_emu1010_load_firmware(emu, 1, &emu->dock_fw);
+			if (err < 0)
+				continue;
 
 			snd_emu1010_fpga_write(emu, EMU_HANA_FPGA_CONFIG, 0);
 			snd_emu1010_fpga_read(emu, EMU_HANA_IRQ_STATUS, &tmp);
@@ -881,39 +890,8 @@ static int snd_emu10k1_emu1010_init(struct snd_emu10k1 *emu)
 	}
 	dev_info(emu->card->dev, "emu1010: EMU_HANA_ID = 0x%x\n", reg);
 
-	if (!emu->firmware) {
-		const char *filename;
-		switch (emu->card_capabilities->emu_model) {
-		case EMU_MODEL_EMU1010:
-			filename = HANA_FILENAME;
-			break;
-		case EMU_MODEL_EMU1010B:
-			filename = EMU1010B_FILENAME;
-			break;
-		case EMU_MODEL_EMU1616:
-			filename = EMU1010_NOTEBOOK_FILENAME;
-			break;
-		case EMU_MODEL_EMU0404:
-			filename = EMU0404_FILENAME;
-			break;
-		default:
-			return -ENODEV;
-		}
-
-		err = request_firmware(&emu->firmware, filename, &emu->pci->dev);
-		if (err != 0) {
-			dev_info(emu->card->dev,
-				 "emu1010: firmware: %s not found. Err = %d\n",
-				 filename, err);
-			return err;
-		}
-		dev_info(emu->card->dev,
-			 "emu1010: firmware file = %s, size = 0x%zx\n",
-			   filename, emu->firmware->size);
-	}
-
-	err = snd_emu1010_load_firmware(emu, emu->firmware);
-	if (err != 0) {
+	err = snd_emu1010_load_firmware(emu, 0, &emu->firmware);
+	if (err < 0) {
 		dev_info(emu->card->dev, "emu1010: Loading Firmware failed\n");
 		return err;
 	}
-- 
2.10.2
