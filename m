From: Vishal Thanki <vishalthanki@gmail.com>
Subject: [PATCH] ASoC: utils: Add DT support
Date: Tue,  2 May 2017 10:08:28 +0200
Message-ID: <1493712508-27919-1-git-send-email-vishalthanki@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id C3C8A266D09
 for <alsa-devel@alsa-project.org>; Tue,  2 May 2017 10:06:58 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id u65so2301689wmu.3
 for <alsa-devel@alsa-project.org>; Tue, 02 May 2017 01:06:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc: Vishal Thanki <vishalthanki@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add device tree support for the dummy codec
driver.

Signed-off-by: Vishal Thanki <vishalthanki@gmail.com>
---
 sound/soc/soc-utils.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 644d9a9..c76b938 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -19,6 +19,8 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <linux/module.h>
+#include <linux/of.h>
 
 int snd_soc_calc_frame_size(int sample_size, int channels, int tdm_slots)
 {
@@ -359,9 +361,19 @@ static int snd_soc_dummy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id dummy_dt_ids[] = {
+	{ .compatible = "linux,snd-soc-dummy", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dummy_dt_ids);
+#endif
+
+
 static struct platform_driver soc_dummy_driver = {
 	.driver = {
 		.name = "snd-soc-dummy",
+		.of_match_table = of_match_ptr(dummy_dt_ids),
 	},
 	.probe = snd_soc_dummy_probe,
 	.remove = snd_soc_dummy_remove,
-- 
2.4.11
