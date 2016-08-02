From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 1268/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 20:33:08 +0800
Message-ID: <20160802123308.2568-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, davem@davemloft.net, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, aryabinin@virtuozzo.com
List-Id: alsa-devel@alsa-project.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 sound/soc/codecs/cs42l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index eec1ff8..a6a8edf 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -1050,7 +1050,7 @@ static ssize_t cs42l56_beep_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(beep, 0200, NULL, cs42l56_beep_set);
+static DEVICE_ATTR(beep, S_IWUSR, NULL, cs42l56_beep_set);
 
 static void cs42l56_init_beep(struct snd_soc_codec *codec)
 {
-- 
2.9.2
