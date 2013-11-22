From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH] ASoC: dapm: Use SND_SOC_DAPM_INIT_REG_VAL in SND_SOC_DAPM_MUX
Date: Fri, 22 Nov 2013 10:29:18 -0700
Message-ID: <1385141358-21956-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, ac100@lists.launchpad.net, Stephen Warren <swarren@nvidia.com>, stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

SND_SOC_DAPM_MUX() doesn't currently initialize the .mask field. This
results in the mux never affecting HW, since no bits are ever set or
cleared. Fix SND_SOC_DAPM_MUX() to use SND_SOC_DAPM_INIT_REG_VAL() to
set up the reg, shift, on_val, and off_val fields like almost all other
SND_SOC_xxx() macros. It looks like this was a "typo" in the fixed
commit linked below.

This makes the speakers on the Toshiba AC100 (PAZ00) laptop work again.

Fixes: de9ba98b6d26 ("ASoC: dapm: Make widget power register settings more flexible")
Cc: <stable@vger.kernel.org> # v3.12+
Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 include/sound/soc-dapm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 2037c45adfe6..56ebdfca6273 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -104,7 +104,8 @@ struct device;
 	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_MUX(wname, wreg, wshift, winvert, wcontrols) \
-{	.id = snd_soc_dapm_mux, .name = wname, .reg = wreg, \
+{	.id = snd_soc_dapm_mux, .name = wname, \
+	SND_SOC_DAPM_INIT_REG_VAL(wreg, wshift, winvert), \
 	.kcontrol_news = wcontrols, .num_kcontrols = 1}
 #define SND_SOC_DAPM_VIRT_MUX(wname, wreg, wshift, winvert, wcontrols) \
 {	.id = snd_soc_dapm_virt_mux, .name = wname, \
-- 
1.8.1.5
