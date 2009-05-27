From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V3] Modify mpc5200 AC97 driver to use V9
	of	spin_event_timeout()
Date: Wed, 27 May 2009 01:06:19 -0400
Message-ID: <20090527050619.26595.95343.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B80A24608
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 07:06:21 +0200 (CEST)
Received: by gxk2 with SMTP id 2so8307901gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 22:06:20 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

The function signature for spin_event_timeout() has changed in version V9.
Adjust the mpc5200 AC97 driver to use the new function.
v2 - switch back to udelay() for fixed timeouts.
v3 - forgot about driver being market broken, fix typo

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 sound/soc/fsl/mpc5200_psc_ac97.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/sound/soc/fsl/mpc5200_psc_ac97.c b/sound/soc/fsl/mpc5200_psc_ac97.c
index 9f2df15..794a247 100644
--- a/sound/soc/fsl/mpc5200_psc_ac97.c
+++ b/sound/soc/fsl/mpc5200_psc_ac97.c
@@ -31,13 +31,13 @@ static struct psc_dma *psc_dma;
 
 static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 {
-	int rc;
+	int status;
 	unsigned int val;
 
 	/* Wait for command send status zero = ready */
-	spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
-				MPC52xx_PSC_SR_CMDSEND), 100, 0, rc);
-	if (rc == 0) {
+	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
+				MPC52xx_PSC_SR_CMDSEND), 100, 0);
+	if (status == 0) {
 		pr_err("timeout on ac97 bus (rdy)\n");
 		return -ENODEV;
 	}
@@ -45,9 +45,9 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 	out_be32(&psc_dma->psc_regs->ac97_cmd, (1<<31) | ((reg & 0x7f) << 24));
 
 	/* Wait for the answer */
-	spin_event_timeout((in_be16(&psc_dma->psc_regs->sr_csr.status) &
-				MPC52xx_PSC_SR_DATA_VAL), 100, 0, rc);
-	if (rc == 0) {
+	status = spin_event_timeout((in_be16(&psc_dma->psc_regs->sr_csr.status) &
+				MPC52xx_PSC_SR_DATA_VAL), 100, 0);
+	if (status == 0) {
 		pr_err("timeout on ac97 read (val) %x\n",
 				in_be16(&psc_dma->psc_regs->sr_csr.status));
 		return -ENODEV;
@@ -66,12 +66,12 @@ static unsigned short psc_ac97_read(struct snd_ac97 *ac97, unsigned short reg)
 static void psc_ac97_write(struct snd_ac97 *ac97,
 				unsigned short reg, unsigned short val)
 {
-	int rc;
+	int status;
 
 	/* Wait for command status zero = ready */
-	spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
-				MPC52xx_PSC_SR_CMDSEND), 100, 0, rc);
-	if (rc == 0) {
+	status = spin_event_timeout(!(in_be16(&psc_dma->psc_regs->sr_csr.status) &
+				MPC52xx_PSC_SR_CMDSEND), 100, 0);
+	if (status == 0) {
 		pr_err("timeout on ac97 bus (write)\n");
 		return;
 	}
@@ -82,24 +82,22 @@ static void psc_ac97_write(struct snd_ac97 *ac97,
 
 static void psc_ac97_warm_reset(struct snd_ac97 *ac97)
 {
-	int rc;
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 
 	out_be32(&regs->sicr, psc_dma->sicr | MPC52xx_PSC_SICR_AWR);
-	spin_event_timeout(0, 3, 0, rc);
+	udelay(3);
 	out_be32(&regs->sicr, psc_dma->sicr);
 }
 
 static void psc_ac97_cold_reset(struct snd_ac97 *ac97)
 {
-	int rc;
 	struct mpc52xx_psc __iomem *regs = psc_dma->psc_regs;
 
 	/* Do a cold reset */
 	out_8(&regs->op1, MPC52xx_PSC_OP_RES);
-	spin_event_timeout(0, 10, 0, rc);
+	udelay(10);
 	out_8(&regs->op0, MPC52xx_PSC_OP_RES);
-	spin_event_timeout(0, 50, 0, rc);
+	udelay(50);
 	psc_ac97_warm_reset(ac97);
 }
