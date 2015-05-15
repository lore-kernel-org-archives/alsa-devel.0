From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: skip legacy dai naming if dai driver has all the information
Date: Fri, 15 May 2015 10:38:27 +0100
Message-ID: <1431682707-26452-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Original issue is that the id field in the dai is not same as the id
in dai_driver when dai driver count == 1. This is due to the legacy
dai naming check, which could possibly cause issues if the audio drivers
written in assumption that dai->id would be always equal to dai_driver->id.
This assumption is true only if the dai driver count is greater than 1,
and false if dai driver count is 1. On Qcom Lpass driver we hit such
issue while adding support to apq8016.

The code path which falls back to legacy naming for cases where num_dai
== 1 does not check if there is any valid information in the dai_driver.
This patch fixes that by checking if the dai_driver has valid id and
name before falling back to legacy dai naming
Although the drivers can work around this issue by only using
dai->driver->id, but this patch attempts to fix the actual issue.

Suggested-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/soc-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2373252..7d028e8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2599,7 +2599,8 @@ static int snd_soc_register_dais(struct snd_soc_component *component,
 		 * the same naming style even though those DAIs are not
 		 * component-less anymore.
 		 */
-		if (count == 1 && legacy_dai_naming) {
+		if (count == 1 && legacy_dai_naming &&
+			(dai_drv[i].id == 0 || dai_drv[i].name == NULL)) {
 			dai->name = fmt_single_name(dev, &dai->id);
 		} else {
 			dai->name = fmt_multiple_name(dev, &dai_drv[i]);
-- 
1.9.1
