From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hdmi-codec: unlock the device on startup errors" to the asoc tree
Date: Fri,  3 May 2019 07:23:35 +0100 (BST)
Message-ID: <20190503062335.40FE3441D3C@finisterre.ee.mobilebroadband>
References: <20190429132943.16269-3-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429132943.16269-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, patchwork-bot+notify@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hdmi-codec: unlock the device on startup errors

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From 30180e8436046344b12813dc954b2e01dfdcd22d Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 29 Apr 2019 15:29:39 +0200
Subject: [PATCH] ASoC: hdmi-codec: unlock the device on startup errors

If the hdmi codec startup fails, it should clear the current_substream
pointer to free the device. This is properly done for the audio_startup()
callback but for snd_pcm_hw_constraint_eld().

Make sure the pointer cleared if an error is reported.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/hdmi-codec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
index 35df73e42cbc..fb2f0ac1f16f 100644
--- a/sound/soc/codecs/hdmi-codec.c
+++ b/sound/soc/codecs/hdmi-codec.c
@@ -439,8 +439,12 @@ static int hdmi_codec_startup(struct snd_pcm_substream *substream,
 		if (!ret) {
 			ret = snd_pcm_hw_constraint_eld(substream->runtime,
 							hcp->eld);
-			if (ret)
+			if (ret) {
+				mutex_lock(&hcp->current_stream_lock);
+				hcp->current_stream = NULL;
+				mutex_unlock(&hcp->current_stream_lock);
 				return ret;
+			}
 		}
 		/* Select chmap supported */
 		hdmi_codec_eld_chmap(hcp);
-- 
2.20.1
