From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: imx-audmux: Check the return value
	from clk_prepare_enable()
Date: Sun, 21 Jul 2013 13:39:08 -0300
Message-ID: <1374424748-4438-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f177.google.com (mail-gg0-f177.google.com
 [209.85.161.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BA8726082D
 for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2013 18:39:16 +0200 (CEST)
Received: by mail-gg0-f177.google.com with SMTP id i1so1857224ggn.36
 for <alsa-devel@alsa-project.org>; Sun, 21 Jul 2013 09:39:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/imx-audmux.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index e260f1f..1a5da1e 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -73,8 +73,11 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (!buf)
 		return -ENOMEM;
 
-	if (audmux_clk)
-		clk_prepare_enable(audmux_clk);
+	if (audmux_clk) {
+		ret = clk_prepare_enable(audmux_clk);
+		if (ret)
+			return ret;
+	}
 
 	ptcr = readl(audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	pdcr = readl(audmux_base + IMX_AUDMUX_V2_PDCR(port));
@@ -224,14 +227,19 @@ EXPORT_SYMBOL_GPL(imx_audmux_v1_configure_port);
 int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 		unsigned int pdcr)
 {
+	int ret;
+
 	if (audmux_type != IMX31_AUDMUX)
 		return -EINVAL;
 
 	if (!audmux_base)
 		return -ENOSYS;
 
-	if (audmux_clk)
-		clk_prepare_enable(audmux_clk);
+	if (audmux_clk) {
+		ret = clk_prepare_enable(audmux_clk);
+		if (ret)
+			return ret;
+	}
 
 	writel(ptcr, audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	writel(pdcr, audmux_base + IMX_AUDMUX_V2_PDCR(port));
-- 
1.8.1.2
