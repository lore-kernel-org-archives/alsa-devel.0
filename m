From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/11] ASoC: mpc5200_psc_ac97: Remove unused
	on-stack snd_ac97 device
Date: Mon, 10 Nov 2014 22:41:43 +0100
Message-ID: <1415655713-29842-2-git-send-email-lars@metafoo.de>
References: <1415655713-29842-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-111.synserver.de (smtp-out-111.synserver.de
 [212.40.185.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 28E6D261ACA
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 22:42:16 +0100 (CET)
In-Reply-To: <1415655713-29842-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Sangbeom Kim <sbkim73@samsung.com>, patches@opensource.wolfsonmicro.com, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Li.Xiubo@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The mpc5200_psc_ac97 driver puts a snd_ac97 device on the stack in the
driver probe function, initializes the private data member of the device and
the never uses the device again. It should be safe to remove it.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/fsl/mpc5200_psc_ac97.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 24eafa2..640801a 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -282,7 +282,6 @@ static const struct snd_soc_component_driver psc_ac97_component = {
 static int psc_ac97_of_probe(struct platform_device *op)
 {
 	int rc;
-	struct snd_ac97 ac97;
 	struct mpc52xx_psc __iomem *regs;
 
 	rc = mpc5200_audio_dma_create(op);
@@ -304,7 +303,6 @@ static int psc_ac97_of_probe(struct platform_device *op)
 
 	psc_dma = dev_get_drvdata(&op->dev);
 	regs = psc_dma->psc_regs;
-	ac97.private_data = psc_dma;
 
 	psc_dma->imr = 0;
 	out_be16(&psc_dma->psc_regs->isr_imr.imr, psc_dma->imr);
-- 
1.8.0
