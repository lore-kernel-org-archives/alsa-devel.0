From: Xavi Drudis Ferran <xdrudis@tinet.cat>
Subject: Setting some clocks back to DUMMY fixes spdif output
 on imx6q wandboard rev B1
Date: Sun, 28 Aug 2016 18:00:55 +0200
Message-ID: <20160828160055.GA2122@begut>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.tinet.org (mx2.tinet.org [195.77.216.147])
 by alsa0.perex.cz (Postfix) with ESMTP id 27FB0266A69
 for <alsa-devel@alsa-project.org>; Mon, 29 Aug 2016 19:58:33 +0200 (CEST)
Received: from smtp01.tinet.org (smtp01.tinet.org [195.77.216.131]) by
 mx2.tinet.org with ESMTP id ESUfLVImCAKF6RxH for
 <alsa-devel@alsa-project.org>; Sun, 28 Aug 2016 18:00:56 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Shengjiu Wang <shengjiu.wang@freescale.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello. 

Sorry for my unfamiliarity with the kernel community. I'm afraid I'll
be getting the procedure wrong...

I was using linux-libre-3.19 (implies no working sdma) with a
wandboard quad (Freescale imx6q). Spidf output worked fine.

When I upgraded to linux-libre-4.7 spdif output was supressed without
any error (precisely, with the same errors about sdma that 3.19 gave).

I saw someone else reporting the same elsewhere with linux-4.4
https://forum.digikey.com/thread/34240
(but I don't have a login there) 

This patch fixes it for me and sound works again on spdif. 

But I don't know if it can break (or fix?) something for some other
boards or kernels or cases... I hardly know what I'm doing.

The commits that might have caused the problem for me might be 

commit 833f2cbf7091099baee28136dc68678e974c0ac5
Author: Shengjiu Wang <shengjiu.wang@freescale.com>
Date:   Sat Oct 10 18:15:07 2015 +0800

    ARM: dts: imx6: change the core clock of spdif
    
    The correct core clock of spdif is SPDIF_GCLK, which is added to
    clock tree. So the dts also need to be updated.
    
    Signed-off-by: Shengjiu Wang <shengjiu.wang@freescale.com>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

(the commit changed more clocks than SPDIF_GCLK) 

It might have to do with vendor commit 

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/arch/arm/boot/dts/imx6qdl.dtsi?h=imx_4.1.15_1.0.0_ga&id=dd7ebdf5bf0458e08f0be62fd49bc6f1ca9b2f25

The issue is fixed for me with this patch but I'm not sure what's the
best way to help fix any issue someone else may have or what other
info or test you might need. Any guidance welcome. 

Thank you for linux. 

--SLDf9lqlvOQaIe6s
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="wandboard-quad-recover-spdif-output.diff"

--- linux-4.7-no-spdif-out/arch/arm/boot/dts/imx6qdl.dtsi	2016-07-25 00:19:43.000000000 +0200
+++ linux-4.7/arch/arm/boot/dts/imx6qdl.dtsi	2016-08-28 17:59:14.276774409 +0200
@@ -240,9 +240,9 @@
 					       <&sdma 15 18 0>;
 					dma-names = "rx", "tx";
 					clocks = <&clks IMX6QDL_CLK_SPDIF_GCLK>, <&clks IMX6QDL_CLK_OSC>,
-						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_ASRC>,
-						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_ESAI_EXTAL>,
-						 <&clks IMX6QDL_CLK_IPG>, <&clks IMX6QDL_CLK_MLB>,
+						 <&clks IMX6QDL_CLK_SPDIF>, <&clks IMX6QDL_CLK_DUMMY>,
+						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
+						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_DUMMY>,
 						 <&clks IMX6QDL_CLK_DUMMY>, <&clks IMX6QDL_CLK_SPBA>;
 					clock-names = "core",  "rxtx0",
 						      "rxtx1", "rxtx2",

--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--SLDf9lqlvOQaIe6s--
