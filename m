From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/2] ASoC: tas2552: Fix typos in the binding doc
Date: Tue, 11 Apr 2017 15:49:35 -0300
Message-ID: <1491936575-5780-2-git-send-email-fabio.estevam@nxp.com>
References: <1491936575-5780-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0048.outbound.protection.outlook.com [104.47.34.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B83F266D8D
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 20:49:47 +0200 (CEST)
In-Reply-To: <1491936575-5780-1-git-send-email-fabio.estevam@nxp.com>
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

Fix the following typos:

"receive its reference clock" and "selected".

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/tas2552.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2552.txt b/Documentation/devicetree/bindings/sound/tas2552.txt
index ea8abf0..2d71eb0 100644
--- a/Documentation/devicetree/bindings/sound/tas2552.txt
+++ b/Documentation/devicetree/bindings/sound/tas2552.txt
@@ -15,11 +15,11 @@ Required properties:
 Optional properties:
 	- enable-gpio - gpio pin to enable/disable the device
 
-tas2552 can receive it's reference clock via MCLK, BCLK, IVCLKIN pin or use the
+tas2552 can receive its reference clock via MCLK, BCLK, IVCLKIN pin or use the
 internal 1.8MHz. This CLKIN is used by the PLL. In addition to PLL, the PDM
 reference clock is also selectable: PLL, IVCLKIN, BCLK or MCLK.
 For system integration the dt-bindings/sound/tas2552.h header file provides
-defined values to selct and configure the PLL and PDM reference clocks.
+defined values to select and configure the PLL and PDM reference clocks.
 
 Example:
 
-- 
2.7.4
