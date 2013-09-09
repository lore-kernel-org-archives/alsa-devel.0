From: <oku@iki.fi>
Subject: [PATCH RFC 1/8] ASoC: davinci-mcasp: Add pinctrl
	support
Date: Mon, 9 Sep 2013 18:12:12 +0300
Message-ID: <6eaf283d62b023c3b7e2f26d937ca0ef602ef200.1378738436.git.jsarha@ti.com>
References: <cover.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 911C32650C0
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:12:25 +0200 (CEST)
In-Reply-To: <cover.1378738436.git.jsarha@ti.com>
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
Cc: Darren Etheridge <detheridge@ti.com>, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org, Joel A Fernandes <agnel.joel@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Joel A Fernandes <agnel.joel@gmail.com>

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Signed-off-by: Joel A Fernandes <agnel.joel@gmail.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 32ddb7f..b849c9d 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1127,6 +1128,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	struct resource *mem, *ioarea, *res;
 	struct snd_platform_data *pdata;
 	struct davinci_audio_dev *dev;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
@@ -1158,6 +1160,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev,
+			 "pins are not configured from the driver\n");
+
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-- 
1.7.9.5
