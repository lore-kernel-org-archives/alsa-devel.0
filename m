From: Timur Tabi <timur@freescale.com>
Subject: [PATCH] powerpc/85xx: fix compatible properties of the
	P1022DS DMA nodes used for audio
Date: Fri, 3 Dec 2010 10:52:14 -0600
Message-ID: <1291395134-12435-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 3577C103B80
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 17:53:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kumar.gala@freescale.com, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In order to prevent the fsl_dma driver from claiming the DMA channels that the
P1022DS audio driver needs, the compatible properties for those nodes must say
"fsl,ssi-dma-channel" instead of "fsl,eloplus-dma-channel".

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Kumar, please pick up this patch for 2.6.37.

 arch/powerpc/boot/dts/p1022ds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 2bbecbb..69422eb 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -291,13 +291,13 @@
 			ranges = <0x0 0xc100 0x200>;
 			cell-index = <1>;
 			dma00: dma-channel@0 {
-				compatible = "fsl,eloplus-dma-channel";
+				compatible = "fsl,ssi-dma-channel";
 				reg = <0x0 0x80>;
 				cell-index = <0>;
 				interrupts = <76 2>;
 			};
 			dma01: dma-channel@80 {
-				compatible = "fsl,eloplus-dma-channel";
+				compatible = "fsl,ssi-dma-channel";
 				reg = <0x80 0x80>;
 				cell-index = <1>;
 				interrupts = <77 2>;
-- 
1.7.2.3
