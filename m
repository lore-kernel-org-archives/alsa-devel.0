Return-Path: <SRS0=ClfJ=BA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2AEC433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:47:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1769C2176B
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Jul 2020 03:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Kx9Afguf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1769C2176B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 80BCE15E2;
	Tue, 21 Jul 2020 05:46:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 80BCE15E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595303223;
	bh=ej2+1MRz2UN2OvVKJC0B1tLTp9t0bqcLzsChvshTuho=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kx9Afgufqvx9WHf1mCriIeVcfMxzaJdqxFv8HduNSMy8w9Sj2P2aLr2DafavR7jvA
	 VBzqckc8Sq5nJYXik57zoM/S3f08n891NwzB+t6NsXx7BogxkPyXQ2UJsjV001CR2D
	 X0P311zVCePKjRtRz+2P5BOJfVhsnCLrr6ka7JZU=
Received: from vmi242170.contaboserver.net (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10DCFF80212;
	Tue, 21 Jul 2020 05:46:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 63394F8024A; Tue, 21 Jul 2020 05:46:06 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DC58F80212
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2020 05:46:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DC58F80212
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9FDB420038B;
 Tue, 21 Jul 2020 05:45:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6393D200390;
 Tue, 21 Jul 2020 05:45:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 121134031C;
 Tue, 21 Jul 2020 11:27:12 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] ASoC: bindings: fsl-asoc-card: Support properties for
 configuring dai fmt
Date: Tue, 21 Jul 2020 11:41:50 +0800
Message-Id: <1595302910-19688-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
References: <1595302910-19688-1-git-send-email-shengjiu.wang@nxp.com>
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

In order to support configuring dai fmt through DT, add some properties.
These properiese are same as the properties in simple card.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
index 8a6a3d0fda5e..63ebf52b43e8 100644
--- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
@@ -71,6 +71,11 @@ Optional properties:
 
   - hp-det-gpio		: The GPIO that detect headphones are plugged in
   - mic-det-gpio	: The GPIO that detect microphones are plugged in
+  - bitclock-master	: Indicates dai-link bit clock master; for details see simple-card.yaml.
+  - frame-master	: Indicates dai-link frame master; for details see simple-card.yaml.
+  - dai-format		: audio format, for details see simple-card.yaml.
+  - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
+  - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
 
 Optional unless SSI is selected as a CPU DAI:
 
-- 
2.27.0

