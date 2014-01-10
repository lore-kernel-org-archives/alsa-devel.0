From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH] ASoC: simple-card: fix one bug to writing to the platform data
Date: Fri, 10 Jan 2014 10:05:17 +0800
Message-ID: <1389319517-12128-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

It's a bug that writing to the platform data directly, for it should
be constant. So just copy it before writing.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 sound/soc/generic/simple-card.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 406e4ea..5b65324 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -9,9 +9,10 @@
  * published by the Free Software Foundation.
  */
 #include <linux/clk.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/module.h>
+#include <linux/string.h>
 #include <sound/simple_card.h>
 
 #define asoc_simple_get_card_info(p) \
@@ -204,36 +205,37 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct device_node *of_cpu, *of_codec, *of_platform;
 	struct device *dev = &pdev->dev;
+	int ret;
 
 	cinfo		= NULL;
 	of_cpu		= NULL;
 	of_codec	= NULL;
 	of_platform	= NULL;
+
+	cinfo = devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
+	if (!cinfo)
+		return -ENOMEM;
+
 	if (np && of_device_is_available(np)) {
-		cinfo = devm_kzalloc(dev, sizeof(*cinfo), GFP_KERNEL);
-		if (cinfo) {
-			int ret;
-			cinfo->snd_card.dev = &pdev->dev;
-			ret = asoc_simple_card_parse_of(np, cinfo, dev,
-							&of_cpu,
-							&of_codec,
-							&of_platform);
-			if (ret < 0) {
-				if (ret != -EPROBE_DEFER)
-					dev_err(dev, "parse error %d\n", ret);
-				return ret;
-			}
-		} else {
-			return -ENOMEM;
+		cinfo->snd_card.dev = dev;
+
+		ret = asoc_simple_card_parse_of(np, cinfo, dev,
+						&of_cpu,
+						&of_codec,
+						&of_platform);
+		if (ret < 0) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(dev, "parse error %d\n", ret);
+			return ret;
 		}
 	} else {
-		cinfo = pdev->dev.platform_data;
-		if (!cinfo) {
+		if (!pdev->dev.platform_data) {
 			dev_err(dev, "no info for asoc-simple-card\n");
 			return -EINVAL;
 		}
 
-		cinfo->snd_card.dev = &pdev->dev;
+		memcpy(cinfo, pdev->dev.platform_data, sizeof(cinfo));
+		cinfo->snd_card.dev = dev;
 	}
 
 	if (!cinfo->name	||
-- 
1.8.4
