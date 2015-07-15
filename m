From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH 2/2][linux-next] ASoC: Fix warning caused by a typo in comments of snd_soc_add_platform()
Date: Wed, 15 Jul 2015 23:02:39 +0900
Message-ID: <1436968959-22488-2-git-send-email-standby24x7@gmail.com>
References: <1436968959-22488-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436968959-22488-1-git-send-email-standby24x7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch fix following warnings.
Warning(.//sound/soc/soc-core.c:2855): No description found
for parameter 'platform_drv'
Warning(.//sound/soc/soc-core.c:2855): Excess function parameter
'platform_driver' description in 'snd_soc_add_platform'

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 691fcc4..e7483ee 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2848,7 +2848,7 @@ static void snd_soc_platform_drv_remove(struct snd_soc_component *component)
  * snd_soc_add_platform - Add a platform to the ASoC core
  * @dev: The parent device for the platform
  * @platform: The platform to add
- * @platform_driver: The driver for the platform
+ * @platform_drv: The driver for the platform
  */
 int snd_soc_add_platform(struct device *dev, struct snd_soc_platform *platform,
 		const struct snd_soc_platform_driver *platform_drv)
-- 
2.5.0.rc2.13.g961abca
