From: Scott Ling <sl@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm0010: Add checking for .dfw info
	record version.
Date: Fri, 23 Nov 2012 12:37:35 +0000
Message-ID: <1353674255-23368-1-git-send-email-sl@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 958242625EB
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 13:37:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, scott.ling@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The info record at the start of the dsp firmware file has been
expanded to incorporate additional version information. We need
to check the version to make sure we understand the layout of
the information in the record. The srec2image tool is currently
used to create this record during creation of the .dfw file.

Signed-off-by: Scott Ling <sl@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm0010.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index d795860..e7e6c2f 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -32,6 +32,9 @@
 #define DEVICE_ID_WM0010	10
 #define S2_LOADER_ID_OFFSET	8

+/* We only support v1 of the .dfw INFO record */
+#define INFO_VERSION		1
+
 enum dfw_cmd {
 	DFW_CMD_FUSE = 0x01,
 	DFW_CMD_CODE_HDR,
@@ -47,6 +50,13 @@ struct dfw_binrec {
 	uint8_t data[0];
 } __packed;

+struct dfw_inforec {
+	u8 info_version;
+	u8 tool_major_version;
+	u8 tool_minor_version;
+	u8 dsp_target;
+};
+
 struct dfw_pllrec {
 	u8 command;
 	u32 length:24;
@@ -343,6 +353,7 @@ static int wm0010_firmware_load(char *name, struct snd_soc_codec *codec)
 	struct completion done;
 	const struct firmware *fw;
 	const struct dfw_binrec *rec;
+	const struct dfw_inforec *inforec;
 	u64 *img;
 	u8 *out, dsp;
 	u32 len, offset;
@@ -357,8 +368,9 @@ static int wm0010_firmware_load(char *name, struct snd_soc_codec *codec)
 	}

 	rec = (const struct dfw_binrec *)fw->data;
+	inforec = (const struct dfw_inforec *)rec->data;
 	offset = 0;
-	dsp = rec->data[0];
+	dsp = inforec->dsp_target;
 	wm0010->boot_failed = false;
 	BUG_ON(!list_empty(&xfer_list));
 	init_completion(&done);
@@ -370,6 +382,17 @@ static int wm0010_firmware_load(char *name, struct snd_soc_codec *codec)
 		goto abort;
 	}

+	if (inforec->info_version != INFO_VERSION) {
+		dev_err(codec->dev,
+			"Unsupported version (%02d) of INFO record\r\n",
+			inforec->info_version);
+		ret = -EINVAL;
+		goto abort;
+	}
+
+	dev_dbg(codec->dev, "Version v%02d INFO record found\r\n",
+		inforec->info_version);
+
 	/* Check it's a DSP file */
 	if (dsp != DEVICE_ID_WM0010) {
 		dev_err(codec->dev, "Not a WM0010 firmware file.\r\n");
--
1.7.9.5
