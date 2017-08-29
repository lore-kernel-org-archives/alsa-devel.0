From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Guard Hotword Model bytes
	loading" to the asoc tree
Date: Tue, 29 Aug 2017 20:29:38 +0100 (BST)
Message-ID: <20170829192938.A19E94400E7@finisterre.ee.mobilebroadband>
References: <20170828071350.160958-1-hychao@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A65E1266F89
 for <alsa-devel@alsa-project.org>; Tue, 29 Aug 2017 21:29:41 +0200 (CEST)
In-Reply-To: <20170828071350.160958-1-hychao@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hsin-Yu Chao <hychao@chromium.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Guard Hotword Model bytes loading

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eb33869c720656c16e614ea40a175a014f60007b Mon Sep 17 00:00:00 2001
From: Hsin-Yu Chao <hychao@chromium.org>
Date: Mon, 28 Aug 2017 15:13:50 +0800
Subject: [PATCH] ASoC: rt5514: Guard Hotword Model bytes loading

If the rt5514-spi driver is not enabled in kernel, hotword model will
not be loaded when "DSP Voice Wake Up" is set to turn on DSP mode, and
an error is logged instead.

Signed-off-by: Hsin-Yu Chao <hychao@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 0e239e8c7bf8..23fccdf3e84a 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -302,7 +302,6 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 	struct rt5514_priv *rt5514 = snd_soc_component_get_drvdata(component);
 	struct snd_soc_codec *codec = rt5514->codec;
 	const struct firmware *fw = NULL;
-	int ret = 0;
 
 	if (ucontrol->value.integer.value[0] == rt5514->dsp_enabled)
 		return 0;
@@ -340,6 +339,9 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 			}
 
 			if (rt5514->model_buf && rt5514->model_len) {
+#if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
+				int ret;
+
 				ret = rt5514_spi_burst_write(0x4ff80000,
 					rt5514->model_buf,
 					((rt5514->model_len / 8) + 1) * 8);
@@ -348,13 +350,22 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
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
2.13.2
