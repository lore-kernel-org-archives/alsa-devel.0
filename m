From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/2] ASoC: fsl ssi doc: Move 'fsl,
	ssi-asynchronous' to the optional section
Date: Wed, 12 Apr 2017 10:20:35 -0300
Message-ID: <1492003236-29690-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0053.outbound.protection.outlook.com [104.47.32.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 6609D2665D5
 for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2017 15:20:45 +0200 (CEST)
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

Property 'fsl,ssi-asynchronous' is optional, so move it to the optional
section of the document.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 5b76be4..1d292d7 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -28,16 +28,6 @@ Required properties:
                     by SOC design.  See the notes below.
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
@@ -61,6 +51,16 @@ Optional properties:
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
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
-- 
2.7.4
