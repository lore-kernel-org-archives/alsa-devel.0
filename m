From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 9/9] ASoC: tas2552: Update DT binding
	document regarding clkock configuration
Date: Mon, 8 Jun 2015 15:19:56 +0300
Message-ID: <1433765996-28930-10-git-send-email-peter.ujfalusi@ti.com>
References: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AB4A260481
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 14:20:19 +0200 (CEST)
In-Reply-To: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add overview of tas2552's clock configuration and selection.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2552.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2552.txt b/Documentation/devicetree/bindings/sound/tas2552.txt
index 55e2a0af5645..c49992c0b62a 100644
--- a/Documentation/devicetree/bindings/sound/tas2552.txt
+++ b/Documentation/devicetree/bindings/sound/tas2552.txt
@@ -14,6 +14,12 @@ Required properties:
 Optional properties:
 	- enable-gpio - gpio pin to enable/disable the device
 
+tas2552 can receive it's reference clock via MCLK, BCLK, IVCLKIN pin or use the
+internal 1.8MHz. This CLKIN is used by the PLL. In addition to PLL, the PDM
+reference clock is also selectable: PLL, IVCLKIN, BCLK or MCLK.
+For system integration the dt-bindings/sound/tas2552.h header file provides
+defined values to selct and configure the PLL and PDM reference clocks.
+
 Example:
 
 tas2552: tas2552@41 {
-- 
2.4.2
