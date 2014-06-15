From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 2/2] ARM: dts: imx6: remove non-working spdif
	rxtx4 and rxtx6 clocks
Date: Mon, 16 Jun 2014 02:39:45 +0300
Message-ID: <1402875585-29025-2-git-send-email-anssi.hannula@iki.fi>
References: <1402875585-29025-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CAC32652DA
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 01:40:06 +0200 (CEST)
In-Reply-To: <1402875585-29025-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

The S/PDIF rxtx4 and rxtx6 clock inputs are "ESAI_HCKT" and "MLB clock",
respectively, according to the SoC documentation, and they are currently
mapped to clocks "esai" and "mlb".

However, they do not seem to actually work correctly. Testing on a
Cubox-i system with fsl_spdif driver forced to select one of those as
input will result in I/O errors on audio playback, which I believe means
missing clock signal.

Possibly the "ESAI_HCKT" and "MLB clock" refer to some other clocks
related to ESAI and MLB, or we are missing something else.

Since audio playback will not work if fsl_spdif selects these clocks
(which happens rarely), set the inputs do dummy clocks, at least for
now.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: Mark Brown <broonie@kernel.org>
---

Does anyone know what is wrong here? i.e. are the clocks actually wrong
or are we maybe doing something wrong with their setup?

Also, is this the correct way to "fix" the issue, or should we rather
modify the driver to not select rxtx4/rxtx6 for now (assuming no one knows
how to fix this properly, of course)?
(I haven't been involved with device trees before)


 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 3aef9a2f5fda..f0d1c2334952 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -182,8 +182,8 @@
 					dma-names = "rx", "tx";
 					clocks = <&clks 197>, <&clks 3>,
 						 <&clks 197>, <&clks 0>,
-						 <&clks 0>,   <&clks 118>,
-						 <&clks 0>,  <&clks 139>,
+						 <&clks 0>,   <&clks 0>,
+						 <&clks 0>,  <&clks 0>,
 						 <&clks 0>;
 					clock-names = "core",  "rxtx0",
 						      "rxtx1", "rxtx2",
-- 
1.8.4.5
