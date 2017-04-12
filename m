From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/2] ASoC: fsl ssi doc: Move playback/capture
	dma properties to the optional section
Date: Wed, 12 Apr 2017 10:20:36 -0300
Message-ID: <1492003236-29690-2-git-send-email-fabio.estevam@nxp.com>
References: <1492003236-29690-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0078.outbound.protection.outlook.com [104.47.38.78])
 by alsa0.perex.cz (Postfix) with ESMTP id D42BF266F2E
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 15:20:47 +0200 (CEST)
In-Reply-To: <1492003236-29690-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

Properties 'fsl,playback-dma' and 'fsl,capture-dma' are optional, so move
them to the optional section of the document.

While at it mention that they only apply to Power Architecture.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 1d292d7..d593902 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -20,12 +20,6 @@ Required properties:
                     have.
 - interrupt-parent: The phandle for the interrupt controller that
                     services interrupts for this device.
-- fsl,playback-dma: Phandle to a node for the DMA channel to use for
-                    playback of audio.  This is typically dictated by SOC
-                    design.  See the notes below.
-- fsl,capture-dma:  Phandle to a node for the DMA channel to use for
-                    capture (recording) of audio.  This is typically dictated
-                    by SOC design.  See the notes below.
 - fsl,fifo-depth:   The number of elements in the transmit and receive FIFOs.
                     This number is the maximum allowed value for SFCSR[TFWM0].
  - clocks:          "ipg" - Required clock for the SSI unit
@@ -61,6 +55,14 @@ Optional properties:
                     be connected together, and SRFS and STFS be connected
                     together.  This would still allow different sample sizes,
                     but not different sample rates.
+- fsl,playback-dma: Phandle to a node for the DMA channel to use for
+                    playback of audio.  This is typically dictated by SOC
+                    design.  See the notes below.
+		    Only used on Power Architecture.
+- fsl,capture-dma:  Phandle to a node for the DMA channel to use for
+                    capture (recording) of audio.  This is typically dictated
+                    by SOC design.  See the notes below.
+		    Only used on Power Architecture.
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
-- 
2.7.4
