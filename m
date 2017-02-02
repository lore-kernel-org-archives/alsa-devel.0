From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cht-bsw-rt5645: fix unused variable
	compiler warning" to the asoc tree
Date: Thu, 02 Feb 2017 11:06:39 +0000
Message-ID: <E1cZFDr-0005fD-Nt@debutante>
References: <1485973625-20553-3-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 85D1126742C
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2017 12:06:53 +0100 (CET)
In-Reply-To: <1485973625-20553-3-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cht-bsw-rt5645: fix unused variable compiler warning

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

>From 77e546b7ba3e39e8a739cb18489582044222b7ba Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 1 Feb 2017 12:27:05 -0600
Subject: [PATCH] ASoC: cht-bsw-rt5645: fix unused variable compiler warning

Missed unused variable in previous changes, oops.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index b972b6526176..5bcde01d15e6 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -262,7 +262,6 @@ static int cht_codec_init(struct snd_soc_pcm_runtime *runtime)
 	int jack_type;
 	struct snd_soc_codec *codec = runtime->codec;
 	struct snd_soc_card *card = runtime->card;
-	struct snd_soc_dai *codec_dai = runtime->codec_dai;
 	struct cht_mc_private *ctx = snd_soc_card_get_drvdata(runtime->card);
 
 	if ((cht_rt5645_quirk & CHT_RT5645_SSP2_AIF2) ||
-- 
2.11.0
