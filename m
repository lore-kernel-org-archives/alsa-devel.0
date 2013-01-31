From: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 4/4] ASoC: davinci: remove __dev* attributes
Date: Thu, 31 Jan 2013 16:53:13 +0530
Message-ID: <1359631394-9511-5-git-send-email-gururaja.hebbar@ti.com>
References: <1359631394-9511-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359631394-9511-1-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
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
To: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
List-Id: alsa-devel@alsa-project.org

CONFIG_HOTPLUG is going away as an option.  As result the __dev*
markings will be going away.

Remove use of __devexit_p and __devexit.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
---
Changes in v3
	 - New patch

:100644 100644 e6009a4... 37b8e78... M	sound/soc/davinci/davinci-evm.c
 sound/soc/davinci/davinci-evm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index e6009a4..37b8e78 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -390,7 +390,7 @@ static int davinci_evm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit davinci_evm_remove(struct platform_device *pdev)
+static int davinci_evm_remove(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = platform_get_drvdata(pdev);
 
@@ -401,7 +401,7 @@ static int __devexit davinci_evm_remove(struct platform_device *pdev)
 
 static struct platform_driver davinci_evm_driver = {
 	.probe		= davinci_evm_probe,
-	.remove		= __devexit_p(davinci_evm_remove),
+	.remove		= davinci_evm_remove,
 	.driver		= {
 		.name	= "davinci_evm",
 		.owner	= THIS_MODULE,
-- 
1.7.9.5
