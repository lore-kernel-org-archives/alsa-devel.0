From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: imx-audmux: Use uintptr_t for port
	numbers
Date: Fri,  1 Aug 2014 17:56:50 +0100
Message-ID: <1406912210-30223-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A439265681
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 19:22:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Since we pass the port number through file private data for debugfs we cast
it to and from a pointer so use uintptr_t in order to ensure that the
types are compatible, avoiding warnings on 64 bit platforms where pointers
are 64 bit and unsigned integers 32 bit.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/imx-audmux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index 267717a..46f9beb 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -67,7 +67,7 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 {
 	ssize_t ret;
 	char *buf;
-	int port = (int)file->private_data;
+	uintptr_t port = (uintptr_t)file->private_data;
 	u32 pdcr, ptcr;
 
 	if (audmux_clk) {
@@ -147,7 +147,7 @@ static const struct file_operations audmux_debugfs_fops = {
 
 static void audmux_debugfs_init(void)
 {
-	int i;
+	uintptr_t i;
 	char buf[20];
 
 	audmux_debugfs_root = debugfs_create_dir("audmux", NULL);
@@ -157,10 +157,10 @@ static void audmux_debugfs_init(void)
 	}
 
 	for (i = 0; i < MX31_AUDMUX_PORT7_SSI_PINS_7 + 1; i++) {
-		snprintf(buf, sizeof(buf), "ssi%d", i);
+		snprintf(buf, sizeof(buf), "ssi%lu", i);
 		if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
 					 (void *)i, &audmux_debugfs_fops))
-			pr_warning("Failed to create AUDMUX port %d debugfs file\n",
+			pr_warning("Failed to create AUDMUX port %lu debugfs file\n",
 				   i);
 	}
 }
-- 
2.0.0
