From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sun4i-codec: pass through clk_set_rate
	error" to the asoc tree
Date: Wed, 30 Sep 2015 20:32:16 +0100
Message-ID: <E1ZhN6u-00062X-TT@finisterre>
References: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 69608266415
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:32:23 +0200 (CEST)
In-Reply-To: <1443555798-16001-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sun4i-codec: pass through clk_set_rate error

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

>From 98a4b665bc91480cc4c054093a59249e153ac17e Mon Sep 17 00:00:00 2001
From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Tue, 29 Sep 2015 21:43:17 +0200
Subject: [PATCH] ASoC: sun4i-codec: pass through clk_set_rate error

The current code, disregarding the clk_set_rate error code, was always
returning -EINVAL. Fix that and return the code in order to have more clue
about what's going on.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sunxi/sun4i-codec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 8d59d83..77408af 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -283,7 +283,7 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct sun4i_codec *scodec = snd_soc_card_get_drvdata(rtd->card);
 	unsigned long clk_freq;
-	int hwrate;
+	int ret, hwrate;
 	u32 val;
 
 	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
@@ -293,8 +293,9 @@ static int sun4i_codec_hw_params(struct snd_pcm_substream *substream,
 	if (!clk_freq)
 		return -EINVAL;
 
-	if (clk_set_rate(scodec->clk_module, clk_freq))
-		return -EINVAL;
+	ret = clk_set_rate(scodec->clk_module, clk_freq);
+	if (ret)
+		return ret;
 
 	hwrate = sun4i_codec_get_hw_rate(params);
 	if (hwrate < 0)
-- 
2.5.0
