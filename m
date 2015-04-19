From: Jie Yang <yang.jie@intel.com>
Subject: [PATCH] ASoC: add static inline funcs to fix a
	compiling issue
Date: Sun, 19 Apr 2015 09:45:48 +0800
Message-ID: <1429407948-14158-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CF9A2612D0
 for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2015 03:42:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

When CONFIG_PM_SLEEP is not selected, calling funcs
snd_soc_suspend and _resume will generate a compiling
issue.

Here add static inline stub functions to fix it.

Signed-off-by: Jie Yang <yang.jie@intel.com>
---
 include/sound/soc.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 2afdd2e..64041f5 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -387,8 +387,20 @@ int snd_soc_codec_set_pll(struct snd_soc_codec *codec, int pll_id, int source,
 int snd_soc_register_card(struct snd_soc_card *card);
 int snd_soc_unregister_card(struct snd_soc_card *card);
 int devm_snd_soc_register_card(struct device *dev, struct snd_soc_card *card);
+#ifdef CONFIG_PM_SLEEP
 int snd_soc_suspend(struct device *dev);
 int snd_soc_resume(struct device *dev);
+#else
+static inline int snd_soc_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static inline int snd_soc_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
 int snd_soc_poweroff(struct device *dev);
 int snd_soc_register_platform(struct device *dev,
 		const struct snd_soc_platform_driver *platform_drv);
-- 
1.9.1
