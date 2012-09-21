From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 06/10] ALSA: Add firmware caching to CA0132
	codec.
Date: Thu, 20 Sep 2012 20:29:17 -0700
Message-ID: <1348198161-9256-7-git-send-email-ian_minett@creativelabs.com>
References: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1348198161-9256-1-git-send-email-ian_minett@creativelabs.com>
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


Signed-off-by: Ian Minett <ian_minett@creativelabs.com>

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index f5aea78..4d8a7ed 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2025,6 +2025,24 @@ static int dspload_image(struct hda_codec *codec,
 	return status;
 }
 
+static const struct firmware *fw_efx;
+
+static int request_firmware_cached(const struct firmware **firmware_p,
+	const char *name, struct device *device)
+{
+	if (*firmware_p)
+		return 0;  /* already loaded */
+	return request_firmware(firmware_p, name, device);
+}
+
+static void release_cached_firmware(void)
+{
+	if (fw_efx) {
+		release_firmware(fw_efx);
+		fw_efx = NULL;
+	}
+}
+
 static bool dspload_is_loaded(struct hda_codec *codec)
 {
 	unsigned int data = 0;
@@ -2542,18 +2560,15 @@ static bool ca0132_download_dsp_images(struct hda_codec *codec)
 {
 	bool dsp_loaded = false;
 	const struct dsp_image_seg *dsp_os_image;
-	const struct firmware *fw_entry;
 
-	if (request_firmware(&fw_entry, EFX_FILE, codec->bus->card->dev) != 0)
+	if (request_firmware_cached(&fw_efx, EFX_FILE,
+				    codec->bus->card->dev) != 0)
 		return false;
 
-	dsp_os_image = (struct dsp_image_seg *)(fw_entry->data);
+	dsp_os_image = (struct dsp_image_seg *)(fw_efx->data);
 	dspload_image(codec, dsp_os_image, 0, 0, true, 0);
 	dsp_loaded = dspload_wait_loaded(codec);
 
-	release_firmware(fw_entry);
-
-
 	return dsp_loaded;
 }
 
@@ -2665,6 +2680,7 @@ static int __init patch_ca0132_init(void)
 
 static void __exit patch_ca0132_exit(void)
 {
+	release_cached_firmware();
 	snd_hda_delete_codec_preset(&ca0132_list);
 }
 
-- 
1.7.4.1
