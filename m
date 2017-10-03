From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: [PATCH] ASoC: codecs: msm8916-wcd-analog: fix module autoload
Date: Tue,  3 Oct 2017 11:49:51 +0200
Message-ID: <20171003094951.10692-1-nicolas.dechesne@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, srinivas.kandagatla@linaro.org, Nicolas Dechesne <nicolas.dechesne@linaro.org>
List-Id: alsa-devel@alsa-project.org

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo snd_soc_msm8916_analog | grep alias
$

After this patch:

$ modinfo snd_soc_msm8916_analog | grep alias
alias:          of:N*T*Cqcom,pm8916-wcd-analog-codecC*
alias:          of:N*T*Cqcom,pm8916-wcd-analog-codec

Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>
---
 sound/soc/codecs/msm8916-wcd-analog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 549c269acc7d..d79e5b35e003 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1241,6 +1241,8 @@ static const struct of_device_id pm8916_wcd_analog_spmi_match_table[] = {
 	{ }
 };
 
+MODULE_DEVICE_TABLE(of, pm8916_wcd_analog_spmi_match_table);
+
 static struct platform_driver pm8916_wcd_analog_spmi_driver = {
 	.driver = {
 		   .name = "qcom,pm8916-wcd-spmi-codec",
-- 
2.11.0
