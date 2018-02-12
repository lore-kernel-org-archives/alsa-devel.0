From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl_esai: Use 'const _be *' type for
	iprop" to the asoc tree
Date: Mon, 12 Feb 2018 12:52:59 +0000
Message-ID: <E1elDbP-0006bl-0f@debutante>
References: <1518386001-4322-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 211E9268197
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:53:01 +0100 (CET)
In-Reply-To: <1518386001-4322-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, broonie@kernel.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl_esai: Use 'const _be *' type for iprop

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 0600b3e101b718557c1851c4a3ff456aa18e4956 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sun, 11 Feb 2018 19:53:19 -0200
Subject: [PATCH] ASoC: fsl_esai: Use 'const _be *' type for iprop

The 'iprop' variable is passed as an argument to the be32_to_cpup()
function, which expects a 'const _be *' type.

Change the iprop variable type so that the following build warnings
with W=1 are gone:

sound/soc/fsl/fsl_esai.c:860:54: warning: incorrect type in argument 1 (different base types)
sound/soc/fsl/fsl_esai.c:860:54:    expected restricted __be32 const [usertype] *p
sound/soc/fsl/fsl_esai.c:860:54:    got unsigned int const [usertype] *[assigned] iprop

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_esai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index cef79a1a620b..40a700493f4c 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -788,7 +788,7 @@ static int fsl_esai_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct fsl_esai *esai_priv;
 	struct resource *res;
-	const uint32_t *iprop;
+	const __be32 *iprop;
 	void __iomem *regs;
 	int irq, ret;
 
-- 
2.16.1
