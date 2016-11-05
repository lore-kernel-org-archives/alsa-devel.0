From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] ASoC: msm8916-wcd-analog: Update correct
	register setting for MIC BIAS Internal1
Date: Sat,  5 Nov 2016 15:28:55 +0800
Message-ID: <1478330935-14724-1-git-send-email-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 81F592614A0
 for <alsa-devel@alsa-project.org>; Sat,  5 Nov 2016 08:29:16 +0100 (CET)
Received: by mail-pf0-f194.google.com with SMTP id 144so1705286pfv.0
 for <alsa-devel@alsa-project.org>; Sat, 05 Nov 2016 00:29:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Axel Lin <axel.lin@ingics.com>, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

pm8916_wcd_analog_enable_micbias_int1() should set micbias1_cap_mode
rather than micbias2_cap_mode.

Also change the order of pm8916_wcd_analog_enable_micbias_int1/init2
functions for better readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Srinivas,
I don't have this h/w.
Appreciate if you can review and test this patch.

Axel
 sound/soc/codecs/msm8916-wcd-analog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index d9f999b..70ae687 100644
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
2.7.4
