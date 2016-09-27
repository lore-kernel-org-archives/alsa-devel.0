From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: add static qualifier for file
	local symbols" to the asoc tree
Date: Tue, 27 Sep 2016 09:18:10 -0700
Message-ID: <E1bov58-0003fT-6G@finisterre>
References: <1469540517-32466-5-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 44852266917
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 18:18:23 +0200 (CEST)
In-Reply-To: <1469540517-32466-5-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: add static qualifier for file local symbols

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

>From b74e7a26311a14f61fbcd516fb475dd79ea9c4b0 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 27 Sep 2016 07:45:10 +0900
Subject: [PATCH] ASoC: rt5616: add static qualifier for file local symbols

Sparse reports below warnings.

rt5616.c:1270:24: warning: symbol 'rt5616_aif_dai_ops' was not declared. Should it be static?
rt5616.c:1277:27: warning: symbol 'rt5616_dai' was not declared. Should it be static?

These two symbols are just used inner the file, thus it's better to add
static qualifier.

This commit adds it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5616.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5616.c b/sound/soc/codecs/rt5616.c
index f527b5b2817b..98ae326c62fa 100644
--- a/sound/soc/codecs/rt5616.c
+++ b/sound/soc/codecs/rt5616.c
@@ -1267,14 +1267,14 @@ static int rt5616_resume(struct snd_soc_codec *codec)
 #define RT5616_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
 			SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S8)
 
-struct snd_soc_dai_ops rt5616_aif_dai_ops = {
+static struct snd_soc_dai_ops rt5616_aif_dai_ops = {
 	.hw_params = rt5616_hw_params,
 	.set_fmt = rt5616_set_dai_fmt,
 	.set_sysclk = rt5616_set_dai_sysclk,
 	.set_pll = rt5616_set_dai_pll,
 };
 
-struct snd_soc_dai_driver rt5616_dai[] = {
+static struct snd_soc_dai_driver rt5616_dai[] = {
 	{
 		.name = "rt5616-aif1",
 		.id = RT5616_AIF1,
-- 
2.9.3
