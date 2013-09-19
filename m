From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH] ASoC: fsl: imx-sgtl5000: fix error path if
	codec driver not found
Date: Thu, 19 Sep 2013 07:52:25 -0500
Message-ID: <1379595145-30241-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FC70261ACF
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 14:52:35 +0200 (CEST)
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
 by relay1.mentorg.com with esmtp
 id 1VMdij-0006BM-UZ from Andrew_Gabbasov@mentor.com
 for alsa-devel@alsa-project.org; Thu, 19 Sep 2013 05:52:33 -0700
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Handling of this error condition should make some cleanup on function exit
instead of immediate return.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 sound/soc/fsl/imx-sgtl5000.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 46c5b4f..7ea5658 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -119,7 +119,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	codec_dev = of_find_i2c_device_by_node(codec_np);
 	if (!codec_dev) {
 		dev_err(&pdev->dev, "failed to find codec platform device\n");
-		return -EPROBE_DEFER;
+		ret = -EPROBE_DEFER;
+		goto fail;
 	}
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-- 
1.7.10.4
