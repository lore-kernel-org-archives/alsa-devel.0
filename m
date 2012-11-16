From: Bo Shen <voice.shen@atmel.com>
Subject: [Resend v6 PATCH 2/2] ASoC: atmel-ssc: add pinctrl consumer
Date: Fri, 16 Nov 2012 14:03:57 +0800
Message-ID: <1353045837-19474-2-git-send-email-voice.shen@atmel.com>
References: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <1353045837-19474-1-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com, plagnioj@jcrosoft.com, nicolas.ferre@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

Add pinctrl consumer for atmel ssc peripheral

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Resend:
  Split one patch into two.
    - one add pinctrl nodes
    - one add pinctrl consumer
---
 drivers/misc/atmel-ssc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
index a769719..3b3d0e0 100644
--- a/drivers/misc/atmel-ssc.c
+++ b/drivers/misc/atmel-ssc.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 
 #include <linux/of.h>
+#include <linux/pinctrl/consumer.h>
 
 /* Serialize access to ssc_list and user count */
 static DEFINE_SPINLOCK(user_lock);
@@ -131,6 +132,13 @@ static int ssc_probe(struct platform_device *pdev)
 	struct resource *regs;
 	struct ssc_device *ssc;
 	const struct atmel_ssc_platform_data *plat_dat;
+	struct pinctrl *pinctrl;
+
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl)) {
+		dev_err(&pdev->dev, "Failed to request pinctrl\n");
+		return PTR_ERR(pinctrl);
+	}
 
 	ssc = devm_kzalloc(&pdev->dev, sizeof(struct ssc_device), GFP_KERNEL);
 	if (!ssc) {
-- 
1.7.9.5

