From: Timur Tabi <timur@freescale.com>
Subject: [PATCH 1/2] powerpc/8610: add probing for individual
	DMA channels, not just DMA controllers
Date: Mon,  3 May 2010 16:54:15 -0500
Message-ID: <1272923655-31807-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C96324722
	for <alsa-devel@alsa-project.org>;
	Mon,  3 May 2010 23:54:34 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kumar.gala@freescale.com, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

A future version of the MPC8610 HPCD's ASoC DMA driver will probe on individual
DMA channel nodes, so the DMA controller nodes' compatible string must be listed
in mpc8610_ids[] for the probe to work.

Also remove the "gianfar" compatible from mpc8610_ids[], since there is no
gianfar (or any other networking device) on the 8610.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Kumar, the ASoC mainters are willing to pick up this patch, but they want an
ACK from you first.  Or, you could pick it up, since by itself it's harmless.

 arch/powerpc/platforms/86xx/mpc8610_hpcd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 5abe137..018cc67 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -83,7 +83,8 @@ static struct of_device_id __initdata mpc8610_ids[] = {
 	{ .compatible = "fsl,mpc8610-immr", },
 	{ .compatible = "fsl,mpc8610-guts", },
 	{ .compatible = "simple-bus", },
-	{ .compatible = "gianfar", },
+	/* So that the DMA channel nodes can be probed individually: */
+	{ .compatible = "fsl,eloplus-dma", },
 	{}
 };
 
-- 
1.6.5
