From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Add missed MODULE_LICENSE("GPL") for
	imx-pcm-fiq
Date: Mon, 12 Dec 2011 16:01:15 +0800
Message-ID: <1323676875.8204.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FAAD1038E7
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 09:01:22 +0100 (CET)
Received: by yenm9 with SMTP id m9so4005267yen.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2011 00:01:21 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

This driver can be built as module and the file header indicates that
the driver is published under the GPL.
Thus add MODULE_LICENSE("GPL") for it.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/imx/imx-pcm-fiq.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/imx-pcm-fiq.c b/sound/soc/imx/imx-pcm-fiq.c
index d7ea0b3..456b7d7 100644
--- a/sound/soc/imx/imx-pcm-fiq.c
+++ b/sound/soc/imx/imx-pcm-fiq.c
@@ -332,3 +332,5 @@ static struct platform_driver imx_pcm_driver = {
 };
 
 module_platform_driver(imx_pcm_driver);
+
+MODULE_LICENSE("GPL");
-- 
1.7.5.4
