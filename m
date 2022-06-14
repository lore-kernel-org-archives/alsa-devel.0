Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F82C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jun 2022 04:27:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 441A518DC;
	Tue, 14 Jun 2022 06:26:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 441A518DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655180845;
	bh=8YBl6tiPpOxpEUAqpG5GE0vGwBCIUWkQkG4hWPxnsdM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PSdYybUiwZqL/nGxOyduUU8DRe8Hz1emCYXy1LvtsfjU2e3dEKR5ErVHWXDXlw1DJ
	 XgXkEUcfjqdjTGtxDPrRZJFyTN7KO76EquT19qDA1ddNURozgBMk+pDGTU4tNPtg2k
	 ZNu1623fNLbHwkVByRZOal2vZ5+RwLx5V8YAaPak=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E98B8F80534;
	Tue, 14 Jun 2022 06:25:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 90A60F80535; Tue, 14 Jun 2022 06:25:49 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C28ADF80528
 for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2022 06:25:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C28ADF80528
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 36DCC1A2682;
 Tue, 14 Jun 2022 06:25:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E0B631A2685;
 Tue, 14 Jun 2022 06:25:35 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 05267180222C;
 Tue, 14 Jun 2022 12:25:33 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 6/7] ASoC: dt-bindings: fsl-sai: Add new property to configure
 dataline
Date: Tue, 14 Jun 2022 12:11:23 +0800
Message-Id: <1655179884-12278-7-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
References: <1655179884-12278-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

"fsl,dataline" is added to configure the dataline of SAI.
It has 3 value for each configuration, first one means the type:
I2S(1) or PDM(2), second one is dataline mask for 'rx', third one is
dataline mask for 'tx'. for example:

fsl,dataline = <1 0xff 0xff 2 0xff 0x11>,

it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
rx mask is 0xff, tx mask is 0x11 (dataline 1 and 4 enabled).

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index c71c5861d787..4c66e6a1a533 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -49,6 +49,14 @@ Required properties:
 			  receive data by following their own bit clocks and
 			  frame sync clocks separately.
 
+  - fsl,dataline        : configure the dataline. it has 3 value for each configuration
+                          first one means the type: I2S(1) or PDM(2)
+                          second one is dataline mask for 'rx'
+                          third one is dataline mask for 'tx'.
+                          for example: fsl,dataline = <1 0xff 0xff 2 0xff 0x11>;
+                          it means I2S type rx mask is 0xff, tx mask is 0xff, PDM type
+                          rx mask is 0xff, tx mask is 0x11 (dataline 1 and 4 enabled).
+
 Optional properties:
 
   - big-endian		: Boolean property, required if all the SAI
-- 
2.17.1

