From: Jon Smirl <jonsmirl@gmail.com>
Subject: [PATCH V1 05/13] Add a few more mpc5200 PSC defines
Date: Wed, 13 May 2009 21:59:10 -0400
Message-ID: <20090514015910.28145.90717.stgit@terra>
References: <20090514015729.28145.30483.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 13B002438A
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 03:59:20 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 6so732020yxn.2
	for <alsa-devel@alsa-project.org>; Wed, 13 May 2009 18:59:20 -0700 (PDT)
In-Reply-To: <20090514015729.28145.30483.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: grant.likely@secretlab.ca, broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a few more mpc5200 PSC defines. More bit fields defines for mpc5200 PSC registers

Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
---
 arch/powerpc/include/asm/mpc52xx_psc.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index a218da6..c323f4f 100644
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
