From: Hsin-Yu Chao <hychao@chromium.org>
Subject: [PATCH] ASoC: rt5514: Guard Hotword Model bytes loading
Date: Mon, 28 Aug 2017 15:13:50 +0800
Message-ID: <20170828071350.160958-1-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f182.google.com (mail-pf0-f182.google.com
 [209.85.192.182])
 by alsa0.perex.cz (Postfix) with ESMTP id E8305266D12
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 09:13:56 +0200 (CEST)
Received: by mail-pf0-f182.google.com with SMTP id k3so13736552pfc.3
 for <alsa-devel@alsa-project.org>; Mon, 28 Aug 2017 00:13:56 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Hsin-Yu Chao <hychao@chromium.org>
List-Id: alsa-devel@alsa-project.org

If the rt5514-spi driver is not enabled in kernel, hotword model will
not be loaded when "DSP Voice Wake Up" is set to turn on DSP mode, and
an error is logged instead.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
---
 sound/soc/codecs/rt5514.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 7482df8ff737..250581082e9d 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -299,7 +299,6 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 	struct rt5514_priv *rt5514 = snd_soc_component_get_drvdata(component);
 	struct snd_soc_codec *codec = rt5514->codec;
 	const struct firmware *fw = NULL;
-	int ret = 0;
 
 	if (ucontrol->value.integer.value[0] == rt5514->dsp_enabled)
 		return 0;
@@ -337,6 +336,9 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 			}
 
 			if (rt5514->model_buf && rt5514->model_len) {
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
+				int ret;
+
 				ret = rt5514_spi_burst_write(0x4ff80000,
 					rt5514->model_buf,
 					((rt5514->model_len / 8) + 1) * 8);
@@ -345,13 +347,22 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 						"Model load failed %d\n", ret);
 					return ret;
 				}
+#else
+				dev_err(codec->dev,
+					"No SPI driver for loading firmware\n");
+#endif
 			} else {
 				request_firmware(&fw, RT5514_FIRMWARE3,
 						 codec->dev);
 				if (fw) {
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 					rt5514_spi_burst_write(0x4ff80000,
 						fw->data,
 						((fw->size/8)+1)*8);
+#else
+					dev_err(codec->dev,
+						"No SPI driver to load fw\n");
+#endif
 					release_firmware(fw);
 					fw = NULL;
 				}
-- 
2.12.2
