From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 1/4] ALSA: CA0132: Add SpeakerEQ feature
	firmware loading
Date: Fri, 8 Feb 2013 18:31:42 -0800
Message-ID: <1360377105-2480-2-git-send-email-ian_minett@creativelabs.com>
References: <1360377105-2480-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1360377105-2480-1-git-send-email-ian_minett@creativelabs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Use request_firmware() to fetch an image containing EQ data. 
This is then loaded onto the DSP chip for use by the SpeakerEQ effect.
The DSP will carry on as normal without the EQ settings in the event that 
the SpeakerEQ f/w is missing or fails to load.

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 639a282..a4b61a9 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -73,9 +73,11 @@
 #define SCP_SET    0
 #define SCP_GET    1
 
+#define SPEQ_FILE  "ctspeq.bin"
 #define EFX_FILE   "ctefx.bin"
 
 #ifdef CONFIG_SND_HDA_CODEC_CA0132_DSP
+MODULE_FIRMWARE(SPEQ_FILE);
 MODULE_FIRMWARE(EFX_FILE);
 #endif
 
@@ -2516,6 +2518,42 @@ exit:
 	return status;
 }
 
+/**
+ * Write the SpeakerEQ coefficient data to DSP memories
+ *
+ * @codec: the HDA codec
+ * @x,y:   location to write x and y coeff data to
+ *
+ * Returns zero or a negative error code.
+ */
+static int dspload_get_speakereq_addx(struct hda_codec *codec,
+				unsigned int *x,
+				unsigned int *y)
+{
+	int status = 0;
+	struct { unsigned short y, x; } speakereq_info;
+	unsigned int size = sizeof(speakereq_info);
+
+	snd_printdd(KERN_INFO "dspload_get_speakereq_addx() -- begin");
+	status = dspio_scp(codec, MASTERCONTROL,
+			MASTERCONTROL_QUERY_SPEAKER_EQ_ADDRESS,
+			SCP_GET, NULL, 0, &speakereq_info, &size);
+
+	if (status < 0) {
+		snd_printdd(KERN_INFO "dspload_get_speakereq_addx: SCP Failed");
+		return -EIO;
+	}
+
+	*x = speakereq_info.x;
+	*y = speakereq_info.y;
+	snd_printdd(KERN_INFO "dspload_get_speakereq_addx: X=0x%x Y=0x%x\n",
+		    *x, *y);
+
+	snd_printdd(KERN_INFO "dspload_get_speakereq_addx() -- complete");
+
+	return status;
+}
+
 /*
  * CA0132 DSP download stuffs.
  */
@@ -2602,6 +2640,35 @@ static int dspload_image(struct hda_codec *codec,
 	return status;
 }
 
+static int dspload_speakereq(struct hda_codec *codec)
+{
+	int status = 0;
+	const struct dsp_image_seg *image;
+	unsigned int x, y;
+	const struct firmware *fw_speq;
+
+	snd_printdd(KERN_INFO "dspload_speakereq() -- begin");
+
+	if (request_firmware(&fw_speq, SPEQ_FILE,
+			     codec->bus->card->dev) != 0)
+		return -EIO;
+
+	image = (struct dsp_image_seg *)(fw_speq->data);
+
+	status = dspload_get_speakereq_addx(codec, &x, &y);
+	if (status < 0)
+		goto done;
+
+	status = dspload_image(codec, image, 1, y, 0, 8);
+
+done:
+	release_firmware(fw_speq);
+
+	snd_printdd(KERN_INFO "dspload_speakereq() -- complete");
+
+	return status;
+}
+
 static bool dspload_is_loaded(struct hda_codec *codec)
 {
 	unsigned int data = 0;
@@ -4335,6 +4402,8 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 
 	release_firmware(fw_entry);
 
+	if (dsp_loaded)
+		dspload_speakereq(codec);
 
 	return dsp_loaded;
 }
-- 
1.7.4.1
