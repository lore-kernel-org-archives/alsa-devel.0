From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2] ASoC: fsl ssi doc: Move optional properties
	to the correct section
Date: Wed, 12 Apr 2017 10:32:00 -0300
Message-ID: <1492003920-30038-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0068.outbound.protection.outlook.com [104.47.37.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 3375C266F7C
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 15:32:07 +0200 (CEST)
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

Properties 'fsl,ssi-asynchronous', 'fsl,playback-dma' and 'fsl,capture-dma'
are optional, so move them under the optional section of the document.

While at it mention that 'fsl,playback-dma' and 'fsl,capture-dma'
only apply to Power Architecture.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Combine the two previous changes into a single patch
- Fix identation

 .../devicetree/bindings/sound/fsl,ssi.txt          | 34 ++++++++++++----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 5b76be4..d415888 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -20,24 +20,8 @@ Required properties:
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
-- fsl,ssi-asynchronous:
-                    If specified, the SSI is to be programmed in asynchronous
-                    mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
-                    all be connected to valid signals.  In synchronous mode,
-                    SRCK and SRFS are ignored.  Asynchronous mode allows
-                    playback and capture to use different sample sizes and
-                    sample rates.  Some drivers may require that SRCK and STCK
-                    be connected together, and SRFS and STFS be connected
-                    together.  This would still allow different sample sizes,
-                    but not different sample rates.
  - clocks:          "ipg" - Required clock for the SSI unit
                     "baud" - Required clock for SSI master mode. Otherwise this
 		      clock is not used
@@ -61,6 +45,24 @@ Optional properties:
 - fsl,mode:         The operating mode for the AC97 interface only.
                     "ac97-slave" - AC97 mode, SSI is clock slave
                     "ac97-master" - AC97 mode, SSI is clock master
+- fsl,ssi-asynchronous:
+                    If specified, the SSI is to be programmed in asynchronous
+                    mode.  In this mode, pins SRCK, STCK, SRFS, and STFS must
+                    all be connected to valid signals.  In synchronous mode,
+                    SRCK and SRFS are ignored.  Asynchronous mode allows
+                    playback and capture to use different sample sizes and
+                    sample rates.  Some drivers may require that SRCK and STCK
+                    be connected together, and SRFS and STFS be connected
+                    together.  This would still allow different sample sizes,
+                    but not different sample rates.
+- fsl,playback-dma: Phandle to a node for the DMA channel to use for
+                    playback of audio.  This is typically dictated by SOC
+                    design.  See the notes below.
+                    Only used on Power Architecture.
+- fsl,capture-dma:  Phandle to a node for the DMA channel to use for
+                    capture (recording) of audio.  This is typically dictated
+                    by SOC design.  See the notes below.
+                    Only used on Power Architecture.
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
-- 
2.7.4
