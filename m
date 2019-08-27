From: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH] ASoC: cs42xx8: Force suspend/resume during system suspend/resume
Date: Tue, 27 Aug 2019 18:13:46 -0400
Message-ID: <1566944026-18113-1-git-send-email-shengjiu.wang@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Use force_suspend/resume to make sure clocks are disabled/enabled
accordingly during system suspend/resume.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/cs42xx8.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
index 5b049fcdba20..94b1adb088fd 100644
--- a/sound/soc/codecs/cs42xx8.c
+++ b/sound/soc/codecs/cs42xx8.c
@@ -684,6 +684,8 @@ static int cs42xx8_runtime_suspend(struct device *dev)
 #endif
 
 const struct dev_pm_ops cs42xx8_pm = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(cs42xx8_runtime_suspend, cs42xx8_runtime_resume, NULL)
 };
 EXPORT_SYMBOL_GPL(cs42xx8_pm);
-- 
2.21.0
