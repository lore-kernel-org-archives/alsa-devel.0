From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr-rt5640: enable ASRC" to
	the asoc tree
Date: Tue, 05 Jan 2016 17:49:16 +0000
Message-ID: <E1aGVjQ-00037R-Aj@debutante>
References: <1450406156-22246-17-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BC08260622
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 18:49:24 +0100 (CET)
In-Reply-To: <1450406156-22246-17-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr-rt5640: enable ASRC

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

>From 0ec66e2d74aadaaee7e218861ca86effcd029435 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 4 Jan 2016 17:20:27 -0600
Subject: [PATCH] ASoC: Intel: bytcr-rt5640: enable ASRC

Sound is noisy when using BCLK as reference, enable ASRC in rt5640
codec

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index a81389d10e17..0f2385f6f6ac 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -153,6 +153,11 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime *runtime)
 
 	card->dapm.idle_bias_off = true;
 
+	rt5640_sel_asrc_clk_src(codec,
+				RT5640_DA_STEREO_FILTER |
+				RT5640_AD_STEREO_FILTER,
+				RT5640_CLK_SEL_ASRC);
+
 	ret = snd_soc_add_card_controls(card, byt_rt5640_controls,
 					ARRAY_SIZE(byt_rt5640_controls));
 	if (ret) {
-- 
2.7.0.rc3
