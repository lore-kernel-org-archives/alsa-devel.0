From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8958: Load firmwares simultaneously
Date: Wed, 10 Oct 2012 22:15:36 +0900
Message-ID: <1349874936-4516-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C1502616DA
 for <alsa-devel@alsa-project.org>; Thu, 11 Oct 2012 09:11:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

As of commit 99c2aa (firmware loader: fix creation failure of fw loader
device) we can have more than one firmware request outstanding at once so
there is no need to daisychain our requests any more.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8958-dsp2.c |   31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 2f191a0..b0710d8 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -883,13 +883,6 @@ static void wm8958_mbc_vss_loaded(const struct firmware *fw, void *context)
 		wm8994->mbc_vss = fw;
 		mutex_unlock(&codec->mutex);
 	}
-
-	/* We can't have more than one request outstanding at once so
-	 * we daisy chain.
-	 */
-	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
-				"wm8958_enh_eq.wfw", codec->dev, GFP_KERNEL,
-				codec, wm8958_enh_eq_loaded);
 }
 
 static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
@@ -897,19 +890,11 @@ static void wm8958_mbc_loaded(const struct firmware *fw, void *context)
 	struct snd_soc_codec *codec = context;
 	struct wm8994_priv *wm8994 = snd_soc_codec_get_drvdata(codec);
 
-	if (wm8958_dsp2_fw(codec, "MBC", fw, true) != 0)
-		return;
-
-	mutex_lock(&codec->mutex);
-	wm8994->mbc = fw;
-	mutex_unlock(&codec->mutex);
-
-	/* We can't have more than one request outstanding at once so
-	 * we daisy chain.
-	 */
-	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
-				"wm8958_mbc_vss.wfw", codec->dev, GFP_KERNEL,
-				codec, wm8958_mbc_vss_loaded);
+	if (fw && (wm8958_dsp2_fw(codec, "MBC", fw, true) == 0)) {
+		mutex_lock(&codec->mutex);
+		wm8994->mbc = fw;
+		mutex_unlock(&codec->mutex);
+	}
 }
 
 void wm8958_dsp2_init(struct snd_soc_codec *codec)
@@ -933,6 +918,12 @@ void wm8958_dsp2_init(struct snd_soc_codec *codec)
 	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
 				"wm8958_mbc.wfw", codec->dev, GFP_KERNEL,
 				codec, wm8958_mbc_loaded);
+	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+				"wm8958_mbc_vss.wfw", codec->dev, GFP_KERNEL,
+				codec, wm8958_mbc_vss_loaded);
+	request_firmware_nowait(THIS_MODULE, FW_ACTION_HOTPLUG,
+				"wm8958_enh_eq.wfw", codec->dev, GFP_KERNEL,
+				codec, wm8958_enh_eq_loaded);
 
 	if (pdata->num_mbc_cfgs) {
 		struct snd_kcontrol_new control[] = {
-- 
1.7.10.4
