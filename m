From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2 15/16] ASoC: fsl-ssi: Update binding
	documentation
Date: Sat, 15 Mar 2014 13:44:23 +0100
Message-ID: <1394887464-969-16-git-send-email-mpa@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C70892650D7
 for <alsa-devel@alsa-project.org>; Sat, 15 Mar 2014 13:45:59 +0100 (CET)
In-Reply-To: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

A lot of bindings where changed without an update of the binding
documentation. This patch adds those changes to the documentation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index b93e9a9..3aa4a8f 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -20,15 +20,6 @@ Required properties:
                     have.
 - interrupt-parent: The phandle for the interrupt controller that
                     services interrupts for this device.
-- fsl,mode:         The operating mode for the SSI interface.
-                    "i2s-slave" - I2S mode, SSI is clock slave
-                    "i2s-master" - I2S mode, SSI is clock master
-                    "lj-slave" - left-justified mode, SSI is clock slave
-                    "lj-master" - l.j. mode, SSI is clock master
-                    "rj-slave" - right-justified mode, SSI is clock slave
-                    "rj-master" - r.j., SSI is clock master
-                    "ac97-slave" - AC97 mode, SSI is clock slave
-                    "ac97-master" - AC97 mode, SSI is clock master
 - fsl,playback-dma: Phandle to a node for the DMA channel to use for
                     playback of audio.  This is typically dictated by SOC
                     design.  See the notes below.
@@ -47,6 +38,9 @@ Required properties:
                     be connected together, and SRFS and STFS be connected
                     together.  This would still allow different sample sizes,
                     but not different sample rates.
+ - clocks:          "ipg" - Required clock for the SSI unit
+                    "baud" - Required clock for SSI master mode. Otherwise this
+		      clock is not used
 
 Required are also ac97 link bindings if ac97 is used. See
 Documentation/devicetree/bindings/sound/soc-ac97link.txt for the necessary
@@ -64,6 +58,15 @@ Optional properties:
 		    Documentation/devicetree/bindings/dma/dma.txt.
 - dma-names:	    Two dmas have to be defined, "tx" and "rx", if fsl,imx-fiq
 		    is not defined.
+- fsl,mode:         The operating mode for the SSI interface.
+                    "i2s-slave" - I2S mode, SSI is clock slave
+                    "i2s-master" - I2S mode, SSI is clock master
+                    "lj-slave" - left-justified mode, SSI is clock slave
+                    "lj-master" - l.j. mode, SSI is clock master
+                    "rj-slave" - right-justified mode, SSI is clock slave
+                    "rj-master" - r.j., SSI is clock master
+                    "ac97-slave" - AC97 mode, SSI is clock slave
+                    "ac97-master" - AC97 mode, SSI is clock master
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
-- 
1.9.0
