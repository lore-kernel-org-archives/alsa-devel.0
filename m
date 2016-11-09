From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: msm8916-wcd-analog: Update correct
	register setting for MIC BIAS Internal1" to the asoc tree
Date: Wed, 09 Nov 2016 14:58:57 +0000
Message-ID: <E1c4UL3-0002ae-Nt@finisterre>
References: <1478330935-14724-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E80E7266B53
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 15:59:13 +0100 (CET)
In-Reply-To: <1478330935-14724-1-git-send-email-axel.lin@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: msm8916-wcd-analog: Update correct register setting for MIC BIAS Internal1

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

>From b4f89a0cce0d579fda6c1f6db72202c6bf2ae95f Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 5 Nov 2016 15:28:55 +0800
Subject: [PATCH] ASoC: msm8916-wcd-analog: Update correct register setting for
 MIC BIAS Internal1

pm8916_wcd_analog_enable_micbias_int1() should set micbias1_cap_mode
rather than micbias2_cap_mode.

Also change the order of pm8916_wcd_analog_enable_micbias_int1/init2
functions for better readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 50ad75ab10ea..d8e8590746af 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -349,7 +349,7 @@ static int pm8916_wcd_analog_enable_micbias_ext2(struct
 
 }
 
-static int pm8916_wcd_analog_enable_micbias_int2(struct
+static int pm8916_wcd_analog_enable_micbias_int1(struct
 						  snd_soc_dapm_widget
 						  *w, struct snd_kcontrol
 						  *kcontrol, int event)
@@ -358,10 +358,10 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
 	struct pm8916_wcd_analog_priv *wcd = snd_soc_codec_get_drvdata(codec);
 
 	return pm8916_wcd_analog_enable_micbias_int(codec, event, w->reg,
-						     wcd->micbias2_cap_mode);
+						     wcd->micbias1_cap_mode);
 }
 
-static int pm8916_wcd_analog_enable_micbias_int1(struct
+static int pm8916_wcd_analog_enable_micbias_int2(struct
 						  snd_soc_dapm_widget
 						  *w, struct snd_kcontrol
 						  *kcontrol, int event)
-- 
2.10.2
