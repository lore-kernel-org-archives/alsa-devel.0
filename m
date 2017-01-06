From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr-rt5640: fix settings in
	internal clock mode" to the asoc tree
Date: Fri, 06 Jan 2017 18:16:51 +0000
Message-ID: <E1cPZ4N-0003DE-TL@debutante>
References: <1483566293-27911-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9BBD2677FD
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:16:57 +0100 (CET)
In-Reply-To: <1483566293-27911-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

   ASoC: Intel: bytcr-rt5640: fix settings in internal clock mode

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

>From 60448b077ed93d227e6c117a9e87db76ff0c1911 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Wed, 4 Jan 2017 15:44:52 -0600
Subject: [PATCH] ASoC: Intel: bytcr-rt5640: fix settings in internal clock
 mode

Frequency value of zero did not make sense, use same 24.576MHz
setting and only change the clock source in idle mode

Suggested-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index e33e4777a65c..8d2fb2d6f532 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -142,7 +142,7 @@ static int platform_clock_control(struct snd_soc_dapm_widget *w,
 		 * for Jack detection and button press
 		 */
 		ret = snd_soc_dai_set_sysclk(codec_dai, RT5640_SCLK_S_RCCLK,
-					     0,
+					     48000 * 512,
 					     SND_SOC_CLOCK_IN);
 		if (!ret) {
 			if ((byt_rt5640_quirk & BYT_RT5640_MCLK_EN) && priv->mclk)
-- 
2.11.0
