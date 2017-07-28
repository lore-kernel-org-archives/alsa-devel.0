From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Enabling 4 slot IV feedback for
	max98927 on Kabylake platform" to the asoc tree
Date: Fri, 28 Jul 2017 13:43:37 +0100
Message-ID: <E1db4cD-0005gf-Jz@finisterre>
References: <1501102065-11083-4-git-send-email-harshapriya.n@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE110267673
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 14:43:51 +0200 (CEST)
In-Reply-To: <1501102065-11083-4-git-send-email-harshapriya.n@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Harsha Priya <harshapriya.n@intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Enabling 4 slot IV feedback for max98927 on Kabylake platform

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

>From cc4db0e257d6a5d5ae2e2f042ac8d261caaf08fc Mon Sep 17 00:00:00 2001
From: Harsha Priya N <harshapriya.n@intel.com>
Date: Thu, 27 Jul 2017 17:41:27 -0700
Subject: [PATCH] ASoC: Intel: Enabling 4 slot IV feedback for max98927 on
 Kabylake platform

This patch enables 4 slot IV feedback for max98927 speaker amp codec.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 3fe4a0807095..74bbc008c965 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -365,11 +365,18 @@ static int kabylake_ssp0_hw_params(struct snd_pcm_substream *substream,
 				return ret;
 			}
 		}
-		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME) ||
-			!strcmp(codec_dai->component->name, MAXIM_DEV1_NAME)) {
-			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xF0, 3, 8, 16);
+		if (!strcmp(codec_dai->component->name, MAXIM_DEV0_NAME)) {
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x30, 3, 8, 16);
 			if (ret < 0) {
-				dev_err(rtd->dev, "set TDM slot err:%d\n", ret);
+				dev_err(rtd->dev, "DEV0 TDM slot err:%d\n", ret);
+				return ret;
+			}
+		}
+
+		if (!strcmp(codec_dai->component->name, MAXIM_DEV1_NAME)) {
+			ret = snd_soc_dai_set_tdm_slot(codec_dai, 0xC0, 3, 8, 16);
+			if (ret < 0) {
+				dev_err(rtd->dev, "DEV1 TDM slot err:%d\n", ret);
 				return ret;
 			}
 		}
-- 
2.13.2
