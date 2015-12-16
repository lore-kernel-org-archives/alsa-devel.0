From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5677: Reconfigure PLL1 after resume"
	to the asoc tree
Date: Wed, 16 Dec 2015 19:24:23 +0000
Message-ID: <E1a9HgV-0006QW-GH@debutante>
References: <1450216285-14875-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BAF07265740
 for <alsa-devel@alsa-project.org>; Wed, 16 Dec 2015 20:24:29 +0100 (CET)
In-Reply-To: <1450216285-14875-1-git-send-email-benzh@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5677: Reconfigure PLL1 after resume

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

>From 1aa844cd56c7a2b94824f02495ff7ae5d52a7e91 Mon Sep 17 00:00:00 2001
From: Ben Zhang <benzh@chromium.org>
Date: Tue, 15 Dec 2015 13:51:25 -0800
Subject: [PATCH] ASoC: rt5677: Reconfigure PLL1 after resume

Sometimes PLL1 stops working if the codec loses power
during suspend (when pow-ldo2 or reset gpio is used).
MX-7Bh(RT5677_PLL1_CTRL2) is cleared and won't be restored
by regcache since it's volatile. MX-7Bh has one status bit
and M code for PLL1. rt5677_set_dai_pll doesn't reconfigure
PLL1 after resume because it thinks the PLL params are not
changed.

This patch clears the cached PLL params at resume so that
rt5677_set_dai_pll can reconfigure the PLL after resume.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5677.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index f73fd125e49c..c404f515376e 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -4792,6 +4792,9 @@ static int rt5677_resume(struct snd_soc_codec *codec)
 	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
 
 	if (!rt5677->dsp_vad_en) {
+		rt5677->pll_src = 0;
+		rt5677->pll_in = 0;
+		rt5677->pll_out = 0;
 		gpiod_set_value_cansleep(rt5677->pow_ldo2, 1);
 		gpiod_set_value_cansleep(rt5677->reset_pin, 0);
 		if (rt5677->pow_ldo2 || rt5677->reset_pin)
-- 
2.6.2
