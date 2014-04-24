From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: imx-audmux: Fix section mismatch
Date: Thu, 24 Apr 2014 08:25:56 +0200
Message-ID: <1398320756-18123-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-171.synserver.de (smtp-out-175.synserver.de
 [212.40.185.175])
 by alsa0.perex.cz (Postfix) with ESMTP id C53E5261673
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 08:26:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Sascha Hauer <s.hauer@pengutronix.de>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

audmux_debugfs_init() is marked as __init, but is called from imx_audmux_probe()
which is not marked as __init. This creates a section mismatch and a potential
runtime crash (if imx_audmux_probe() is called after the .init section was
dropped). This patch removes the __init annotation from audmux_debugfs_init(),
which fixes the following warning:
	WARNING: sound/soc/built-in.o(.text+0x86960): Section mismatch in reference
	from the function imx_audmux_probe() to the function
	.init.text:audmux_debugfs_init()

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/imx-audmux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index ac86993..267717a 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -145,7 +145,7 @@ static const struct file_operations audmux_debugfs_fops = {
 	.llseek = default_llseek,
 };
 
-static void __init audmux_debugfs_init(void)
+static void audmux_debugfs_init(void)
 {
 	int i;
 	char buf[20];
-- 
1.8.0
