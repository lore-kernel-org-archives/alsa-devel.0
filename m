From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH RESEND 7/9] ASoC: mxs-saif: adopt pinctrl
	support
Date: Mon,  7 May 2012 09:16:12 +0800
Message-ID: <1336353374-28939-8-git-send-email-shawn.guo@linaro.org>
References: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B2761104159
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2012 03:16:58 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so8111574pbb.38
	for <alsa-devel@alsa-project.org>; Sun, 06 May 2012 18:16:57 -0700 (PDT)
In-Reply-To: <1336353374-28939-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Olof Johansson <olof@lixom.net>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Cc: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 sound/soc/mxs/mxs-saif.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 53f4fd8..7fd224b 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -25,6 +25,7 @@
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <linux/fsl/mxs-dma.h>
+#include <linux/pinctrl/consumer.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -625,6 +626,7 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	struct resource *iores, *dmares;
 	struct mxs_saif *saif;
 	struct mxs_saif_platform_data *pdata;
+	struct pinctrl *pinctrl;
 	int ret = 0;
 
 	if (pdev->id >= ARRAY_SIZE(mxs_saif))
@@ -650,6 +652,12 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		saif->master_id = saif->id;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		ret = PTR_ERR(pinctrl);
+		return ret;
+	}
+
 	saif->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(saif->clk)) {
 		ret = PTR_ERR(saif->clk);
-- 
1.7.5.4
