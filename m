From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 1/2] ASoC: wm8782: add device-tree matching
	table
Date: Mon, 21 May 2018 23:54:49 +0200
Message-ID: <20180521215450.30557-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 885C7267380
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 23:55:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org

This is needed when the codec is instanciated from from a device tree.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 sound/soc/codecs/wm8782.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 7949703f3d04..317db9a149a7 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -67,9 +67,18 @@ static int wm8782_probe(struct platform_device *pdev)
 			&soc_component_dev_wm8782, &wm8782_dai, 1);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id wm8782_of_match[] = {
+	{ .compatible = "wlf,wm8782", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8782_of_match);
+#endif
+
 static struct platform_driver wm8782_codec_driver = {
 	.driver = {
 		.name = "wm8782",
+		.of_match_table = of_match_ptr(wm8782_of_match),
 	},
 	.probe = wm8782_probe,
 };
-- 
2.14.3
