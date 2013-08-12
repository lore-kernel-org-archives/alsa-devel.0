From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 5/5] ASoC: pxa: add DT bindings for pxa2xx-pcm
Date: Mon, 12 Aug 2013 10:42:41 +0200
Message-ID: <1376296961-20564-6-git-send-email-zonque@gmail.com>
References: <1376296961-20564-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D2E67260845
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2013 10:42:53 +0200 (CEST)
In-Reply-To: <1376296961-20564-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, eric.y.miao@gmail.com, arnd@arndb.de, s.neumann@raumfeld.com, Daniel Mack <zonque@gmail.com>, haojian.zhuang@linaro.org, rmk+kernel@arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

The bindings do not carry any resources, as the module only registers
the ASoC platform driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt         | 15 +++++++++++++++
 sound/soc/pxa/pxa2xx-pcm.c                                | 13 +++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt b/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
new file mode 100644
index 0000000..551fbb8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
@@ -0,0 +1,15 @@
+DT bindings for ARM PXA2xx PCM platform driver
+
+This is just a dummy driver that registers the PXA ASoC platform driver.
+It does not have any resources assigned.
+
+Required properties:
+
+	- compatible		'mrvl,pxa-pcm-audio'
+
+Example:
+
+	pxa_pcm_audio: snd_soc_pxa_audio {
+		compatible = "mrvl,pxa-pcm-audio";
+	};
+
diff --git a/sound/soc/pxa/pxa2xx-pcm.c b/sound/soc/pxa/pxa2xx-pcm.c
index 0aa2d69..806da27 100644
--- a/sound/soc/pxa/pxa2xx-pcm.c
+++ b/sound/soc/pxa/pxa2xx-pcm.c
@@ -13,6 +13,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/dmaengine.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/soc.h>
@@ -133,10 +134,18 @@ static int pxa2xx_soc_platform_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id snd_soc_pxa_audio_match[] = {
+	{ .compatible   = "mrvl,pxa-pcm-audio" },
+	{ }
+};
+#endif
+
 static struct platform_driver pxa_pcm_driver = {
 	.driver = {
-			.name = "pxa-pcm-audio",
-			.owner = THIS_MODULE,
+		.name = "pxa-pcm-audio",
+		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(snd_soc_pxa_audio_match),
 	},
 
 	.probe = pxa2xx_soc_platform_probe,
-- 
1.8.3.1
