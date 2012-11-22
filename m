From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ASoC: davinci-mcasp: Add pinctrl support
Date: Thu, 22 Nov 2012 09:34:58 +0530
Message-ID: <1353557099-21599-2-git-send-email-gururaja.hebbar@ti.com>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1353557099-21599-1-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: sudhakar.raj-l0cyMroinI0@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: "Hebbar, Gururaja" <gururaja.hebbar-l0cyMroinI0@public.gmane.org>

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
---
:100644 100644 5715595... 76c05d9... M	sound/soc/davinci/davinci-mcasp.c
 sound/soc/davinci/davinci-mcasp.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 5715595..76c05d9 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -25,6 +25,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -1108,6 +1109,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 	struct resource *mem, *ioarea, *res;
 	struct snd_platform_data *pdata;
 	struct davinci_audio_dev *dev;
+	struct pinctrl *pinctrl;
 	int ret;
 
 	if (!pdev->dev.platform_data && !pdev->dev.of_node) {
@@ -1139,6 +1141,11 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev,
+			"pins are not configured from the driver\n");
+
 	pm_runtime_enable(&pdev->dev);
 
 	ret = pm_runtime_get_sync(&pdev->dev);
-- 
1.7.9.5
