From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V2 4/9] Add a few more mpc5200 PSC defines
Date: Sat, 23 May 2009 19:13:03 -0400
Message-ID: <20090523231303.17919.35877.stgit@terra>
References: <20090523231148.17919.46103.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f206.google.com (mail-gx0-f206.google.com
	[209.85.217.206])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BB17103803
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 01:13:04 +0200 (CEST)
Received: by mail-gx0-f206.google.com with SMTP id 2so4866181gxk.8
	for <alsa-devel@alsa-project.org>; Sat, 23 May 2009 16:13:04 -0700 (PDT)
In-Reply-To: <20090523231148.17919.46103.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Add a few more mpc5200 PSC defines. More bit fields defines for mpc5200 PSC registers. This patch is going in via Grant's tree.

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 0 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index a218da6..fb84120 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -28,6 +28,10 @@
 #define MPC52xx_PSC_MAXNUM	6
 
 /* Programmable Serial Controller (PSC) status register bits */
+#define MPC52xx_PSC_SR_UNEX_RX	0x0001
+#define MPC52xx_PSC_SR_DATA_VAL	0x0002
+#define MPC52xx_PSC_SR_DATA_OVR	0x0004
+#define MPC52xx_PSC_SR_CMDSEND	0x0008
 #define MPC52xx_PSC_SR_CDE	0x0080
 #define MPC52xx_PSC_SR_RXRDY	0x0100
 #define MPC52xx_PSC_SR_RXFULL	0x0200
@@ -61,6 +65,12 @@
 #define MPC52xx_PSC_RXTX_FIFO_EMPTY	0x0001
 
 /* PSC interrupt status/mask bits */
+#define MPC52xx_PSC_IMR_UNEX_RX_SLOT 0x0001
+#define MPC52xx_PSC_IMR_DATA_VALID	0x0002
+#define MPC52xx_PSC_IMR_DATA_OVR	0x0004
+#define MPC52xx_PSC_IMR_CMD_SEND	0x0008
+#define MPC52xx_PSC_IMR_ERROR		0x0040
+#define MPC52xx_PSC_IMR_DEOF		0x0080
 #define MPC52xx_PSC_IMR_TXRDY		0x0100
 #define MPC52xx_PSC_IMR_RXRDY		0x0200
 #define MPC52xx_PSC_IMR_DB		0x0400
@@ -117,6 +127,7 @@
 #define MPC52xx_PSC_SICR_SIM_FIR		(0x6 << 24)
 #define MPC52xx_PSC_SICR_SIM_CODEC_24		(0x7 << 24)
 #define MPC52xx_PSC_SICR_SIM_CODEC_32		(0xf << 24)
+#define MPC52xx_PSC_SICR_AWR			(1 << 30)
 #define MPC52xx_PSC_SICR_GENCLK			(1 << 23)
 #define MPC52xx_PSC_SICR_I2S			(1 << 22)
 #define MPC52xx_PSC_SICR_CLKPOL			(1 << 21)
