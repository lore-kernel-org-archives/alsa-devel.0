Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC9C43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:03:37 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605E520833
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 12:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CFZzdIbo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605E520833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 084151607;
	Wed,  4 Dec 2019 13:02:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 084151607
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575461014;
	bh=K9ad+Vj5TT+WJiG6W7RdsnquS7LiuRO+bP3MhKTo7i8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CFZzdIboms3JB/jnQRZOeJCGmhH8cKsvImd3qmMjE+YnGoUojayeUhWfrAXSMsTFo
	 VugtAXOG//TUnGmqGs3Kiczwc5IxKPeMRDmUDlkcBYmfQfmDgAACpG1A6HrfOwNFVq
	 oYKY2SvE00ZdGfmezww8gUnoxtnT3L67Bo6rStOg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 478EBF801EC;
	Wed,  4 Dec 2019 13:02:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 66115F80214; Wed,  4 Dec 2019 13:02:41 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF792F800B4
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 13:02:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CF792F800B4
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 79266200421;
 Wed,  4 Dec 2019 13:02:36 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69C7F20010B;
 Wed,  4 Dec 2019 13:02:30 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 086AC402AD;
 Wed,  4 Dec 2019 20:02:22 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
 mark.rutland@arm.com, devicetree@vger.kernel.org
Date: Wed,  4 Dec 2019 20:00:18 +0800
Message-Id: <b9352edb014c1ee8530c0fd8829c2b044b3da649.1575452454.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH v5 1/2] ASoC: dt-bindings: fsl_asrc: add
	compatible string for imx8qm & imx8qxp
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add compatible string "fsl,imx8qm-asrc" for imx8qm platform,
"fsl,imx8qxp-asrc" for imx8qxp platform.

There are two asrc modules in imx8qm & imx8qxp, the clock mapping is
different for each other, so add new property "fsl,asrc-clk-map"
to distinguish them.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2
-none

changes in v3
-use only one compatible string "fsl,imx8qm-asrc",
-add new property "fsl,asrc-clk-map".

changes in v4
-add "fsl,imx8qxp-asrc"

changes in v5
-refine the comments for compatible

 Documentation/devicetree/bindings/sound/fsl,asrc.txt | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index 1d4d9f938689..cb9a25165503 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -8,7 +8,12 @@ three substreams within totally 10 channels.
 
 Required properties:
 
-  - compatible		: Contains "fsl,imx35-asrc" or "fsl,imx53-asrc".
+  - compatible		: Compatible list, should contain one of the following
+			  compatibles:
+			  "fsl,imx35-asrc",
+			  "fsl,imx53-asrc",
+			  "fsl,imx8qm-asrc",
+			  "fsl,imx8qxp-asrc",
 
   - reg			: Offset and length of the register set for the device.
 
@@ -35,6 +40,11 @@ Required properties:
 
    - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
 
+   - fsl,asrc-clk-map   : Defines clock map used in driver. which is required
+			  by imx8qm/imx8qxp platform
+			  <0> - select the map for asrc0 in imx8qm/imx8qxp
+			  <1> - select the map for asrc1 in imx8qm/imx8qxp
+
 Optional properties:
 
    - big-endian		: If this property is absent, the little endian mode
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
