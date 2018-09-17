From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hisilicon: fix fall-through
	annotations" to the asoc tree
Date: Mon, 17 Sep 2018 22:21:22 +0100 (BST)
Message-ID: <20180917212122.AD80B440078@finisterre.ee.mobilebroadband>
References: <20180913191107.GA11390@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B60FE2678A9
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 23:21:26 +0200 (CEST)
In-Reply-To: <20180913191107.GA11390@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hisilicon: fix fall-through annotations

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 982e386379f01aa6254e3313cff1edcb04c66685 Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 13 Sep 2018 14:11:07 -0500
Subject: [PATCH] ASoC: hisilicon: fix fall-through annotations

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/hisilicon/hi6210-i2s.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 53344a3b7a60..a69e5b11b3da 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -269,13 +269,13 @@ static int hi6210_i2s_hw_params(struct snd_pcm_substream *substream,
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_U16_LE:
 		signed_data = HII2S_I2S_CFG__S2_CODEC_DATA_FORMAT;
-		/* fallthru */
+		/* fall through */
 	case SNDRV_PCM_FORMAT_S16_LE:
 		bits = HII2S_BITS_16;
 		break;
 	case SNDRV_PCM_FORMAT_U24_LE:
 		signed_data = HII2S_I2S_CFG__S2_CODEC_DATA_FORMAT;
-		/* fallthru */
+		/* fall through */
 	case SNDRV_PCM_FORMAT_S24_LE:
 		bits = HII2S_BITS_24;
 		break;
-- 
2.19.0
