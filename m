From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: force using PLL if MCLK is not
	suitable" to the asoc tree
Date: Mon, 17 Jul 2017 17:06:15 +0100
Message-ID: <E1dX8XH-00053g-Ux@debutante>
References: <1500014192-1411-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A7BEF267483
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 18:06:40 +0200 (CEST)
In-Reply-To: <1500014192-1411-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: force using PLL if MCLK is not suitable

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

>From fa05899c12d54d3a1befa742f62d3188e551a87c Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 14 Jul 2017 14:36:32 +0800
Subject: [PATCH] ASoC: rt5665: force using PLL if MCLK is not suitable

Idealy PLL will be set in machine driver if MCLK doesn't meet the
requirement of codec. To let the codec driver be more general, we
can use a common PLL setting once sysclk/pll doesn't set properly
in machine driver.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 370ed54d1e15..d3103efcb135 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -4098,9 +4098,12 @@ static int rt5665_hw_params(struct snd_pcm_substream *substream,
 	rt5665->lrck[dai->id] = params_rate(params);
 	pre_div = rl6231_get_clk_info(rt5665->sysclk, rt5665->lrck[dai->id]);
 	if (pre_div < 0) {
-		dev_err(codec->dev, "Unsupported clock setting %d for DAI %d\n",
-			rt5665->lrck[dai->id], dai->id);
-		return -EINVAL;
+		dev_warn(codec->dev, "Force using PLL");
+		snd_soc_codec_set_pll(codec, 0, RT5665_PLL1_S_MCLK,
+			rt5665->sysclk,	rt5665->lrck[dai->id] * 512);
+		snd_soc_codec_set_sysclk(codec, RT5665_SCLK_S_PLL1, 0,
+			rt5665->lrck[dai->id] * 512, 0);
+		pre_div = 1;
 	}
 	frame_size = snd_soc_params_to_frame_size(params);
 	if (frame_size < 0) {
-- 
2.13.2
