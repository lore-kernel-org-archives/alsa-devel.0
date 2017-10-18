From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcht_es8316: remove useless
	code" to the asoc tree
Date: Wed, 18 Oct 2017 12:31:14 +0100
Message-ID: <E1e4mZ8-0003w6-VN@debutante>
References: <20171012233805.30055-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4067426744B
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 13:31:21 +0200 (CEST)
In-Reply-To: <20171012233805.30055-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcht_es8316: remove useless code

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

>From 8a2eca50c618ef2affc140b38dc7fdc63d423e89 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:38:01 -0500
Subject: [PATCH] ASoC: Intel: bytcht_es8316: remove useless code

get_codec_dai() is not used, remove it

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_es8316.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 52635462dac6..9ed4400c13b8 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -37,20 +37,6 @@ struct byt_cht_es8316_private {
 	struct clk *mclk;
 };
 
-#define CODEC_DAI1	"ES8316 HiFi"
-
-static inline struct snd_soc_dai *get_codec_dai(struct snd_soc_card *card)
-{
-	struct snd_soc_pcm_runtime *rtd;
-
-	list_for_each_entry(rtd, &card->rtd_list, list) {
-		if (!strncmp(rtd->codec_dai->name, CODEC_DAI1,
-			     strlen(CODEC_DAI1)))
-			return rtd->codec_dai;
-	}
-	return NULL;
-}
-
 static const struct snd_soc_dapm_widget byt_cht_es8316_widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 
-- 
2.14.1
