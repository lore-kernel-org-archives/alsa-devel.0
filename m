From: Felipe Pena <felipensp@gmail.com>
Subject: [PATCH v2] sound: soc: fsl: Fix memory leak in imx-audmux.c
Date: Sat, 12 Oct 2013 19:35:06 -0300
Message-ID: <1381617306-18764-1-git-send-email-felipensp@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Bill Pemberton <wfp5p@virginia.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Felipe Pena <felipensp@gmail.com>
List-Id: alsa-devel@alsa-project.org

When audmux_clk is used and clk_prepare_enable function succeed,
the memory alloc'd to buf variable is leaked

Signed-off-by: Felipe Pena <felipensp@gmail.com>
---
 sound/soc/fsl/imx-audmux.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index d3bf71a..ac86993 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -66,13 +66,10 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 				size_t count, loff_t *ppos)
 {
 	ssize_t ret;
-	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char *buf;
 	int port = (int)file->private_data;
 	u32 pdcr, ptcr;
 
-	if (!buf)
-		return -ENOMEM;
-
 	if (audmux_clk) {
 		ret = clk_prepare_enable(audmux_clk);
 		if (ret)
@@ -85,6 +82,10 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	if (audmux_clk)
 		clk_disable_unprepare(audmux_clk);
 
+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	ret = snprintf(buf, PAGE_SIZE, "PDCR: %08x\nPTCR: %08x\n",
 		       pdcr, ptcr);
 
-- 
1.7.10.4
