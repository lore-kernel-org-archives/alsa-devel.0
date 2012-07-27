From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 04/18] ASoC: Ux500: Enable ux500 PCM driver for
	Device Tree
Date: Fri, 27 Jul 2012 13:45:48 +0100
Message-ID: <1343393162-11938-5-git-send-email-lee.jones@linaro.org>
References: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 421D8265F74
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 14:46:12 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id x10so1840692wey.38
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 05:46:14 -0700 (PDT)
In-Reply-To: <1343393162-11938-1-git-send-email-lee.jones@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ola.o.lilja@stericsson.com, alsa-devel@alsa-project.org, linus.walleij@stericsson.com, arnd@arndb.de, broonie@opensource.wolfsonmicro.com, olalilja@yahoo.se, STEricsson_nomadik_linux@list.st.com, Lee Jones <lee.jones@linaro.org>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

This simple patch ensures the PCM driver will be probed during
boot-up when Device Tree is enabled.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/ux500/ux500_pcm.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 1a04e24..557da2d 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -304,10 +304,16 @@ static int __devinit ux500_pcm_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ux500_pcm_match[] = {
+       { .compatible = "stericsson,ux500-pcm", },
+       {},
+};
+
 static struct platform_driver ux500_pcm_driver = {
 	.driver = {
 		.name = "ux500-pcm",
 		.owner = THIS_MODULE,
+		.of_match_table = ux500_pcm_match,
 	},
 
 	.probe = ux500_pcm_drv_probe,
-- 
1.7.9.5
