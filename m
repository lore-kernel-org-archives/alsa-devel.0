From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hisilicon: localize functions without
	external linkage" to the asoc tree
Date: Mon, 15 May 2017 17:02:34 +0900
Message-ID: <E1dAAxe-0002Ps-B4@finisterre>
References: <20170502133303.19622-4-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 18BA42672B4
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 10:02:43 +0200 (CEST)
In-Reply-To: <20170502133303.19622-4-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, John Stultz <john.stultz@linaro.org>, Andy Green <andy.green@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hisilicon: localize functions without external linkage

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

>From 2a54e845f6e5069666e1749bd952abdc0413910d Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 2 May 2017 22:33:02 +0900
Subject: [PATCH] ASoC: hisilicon: localize functions without external linkage

A driver for hi6210 sound interface on hi6220 boards includes some
functions which has no external linkage. These functions should have
static qualifier.

This commit adds the qualifier to localize the functions. This issue is
detected by sparse:

hi6210-i2s.c:100:5: warning: symbol 'hi6210_i2s_startup' was not declared. Should it be static?
hi6210-i2s.c:178:6: warning: symbol 'hi6210_i2s_shutdown' was not declared. Should it be static?
hi6210-i2s.c:527:27: warning: symbol 'hi6210_i2s_dai_init' was not declared. Should it be static?

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/hisilicon/hi6210-i2s.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 45163e5202f5..b193d3beb253 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -97,8 +97,8 @@ static inline u32 hi6210_read_reg(struct hi6210_i2s *i2s, int reg)
 	return readl(i2s->base + reg);
 }
 
-int hi6210_i2s_startup(struct snd_pcm_substream *substream,
-		     struct snd_soc_dai *cpu_dai)
+static int hi6210_i2s_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *cpu_dai)
 {
 	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
 	int ret, n;
@@ -175,8 +175,9 @@ int hi6210_i2s_startup(struct snd_pcm_substream *substream,
 
 	return 0;
 }
-void hi6210_i2s_shutdown(struct snd_pcm_substream *substream,
-		       struct snd_soc_dai *cpu_dai)
+
+static void hi6210_i2s_shutdown(struct snd_pcm_substream *substream,
+				struct snd_soc_dai *cpu_dai)
 {
 	struct hi6210_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
 	int n;
@@ -524,7 +525,7 @@ static struct snd_soc_dai_ops hi6210_i2s_dai_ops = {
 	.shutdown	= hi6210_i2s_shutdown,
 };
 
-struct snd_soc_dai_driver hi6210_i2s_dai_init = {
+static const struct snd_soc_dai_driver hi6210_i2s_dai_init = {
 	.probe		= hi6210_i2s_dai_probe,
 	.playback = {
 		.channels_min = 2,
-- 
2.11.0
