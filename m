Return-Path: <SRS0=iLk1=HA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C42CC433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 18:29:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8984264E04
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Jan 2021 18:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8984264E04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 09F741688;
	Fri, 29 Jan 2021 19:28:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 09F741688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611944988;
	bh=xWkU+Iqo/Yj05/Y7eTh3sVKmg1U4pbZTYfWzjBa4FII=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r2ysoEd0y3m/nYYXbNCc44FyvXw829rVkCtadBRdEYskYO1IhYFpqFmaraKGx7po6
	 m+/9wBrGAhlxrP3PR/Th4GxbCACT+dmdTkdnXbmy0WyAEN0IFENl21Iz08YecjmQME
	 AXXxYlQVgQFWQeRP5yyHWsIijRugt7jjTSPn13ro=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9758FF80269;
	Fri, 29 Jan 2021 19:28:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6876F80269; Fri, 29 Jan 2021 19:28:06 +0100 (CET)
Received: from hqnvemgate26.nvidia.com (hqnvemgate26.nvidia.com
 [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2007AF80218
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2021 19:27:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2007AF80218
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com
 header.b="i4yH0KXW"
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B601453ad0001>; Fri, 29 Jan 2021 10:27:57 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Jan
 2021 18:27:57 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 29 Jan 2021 18:27:53 +0000
From: Sameer Pujar <spujar@nvidia.com>
To: <thierry.reding@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
 <lgirdwood@gmail.com>
Subject: [PATCH v2 1/9] ASoC: dt-bindings: rt5659: Update binding doc
Date: Fri, 29 Jan 2021 23:57:38 +0530
Message-ID: <1611944866-29373-2-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611944866-29373-1-git-send-email-spujar@nvidia.com>
References: <1611944866-29373-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611944877; bh=zegRvFdxvHED4R5W9t6yg7pqQzJOMHOZG7j3dYTBods=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Type;
 b=i4yH0KXWNRsm312/LZZRpSOdcsW8RktQXqjcZ38Jgc1FIHzH3dOx8EwF5V8LveRWz
 jT+vYmI6pI1kH/YBHw26NljetP+uxbuwK3iHgDSgsMAyZI4tfoz4BxWoArg2ELpHe+
 8LQph4dBG6gQnC1OBJL0gO3KZKJtj2ZwOZt0HHdJ0SZALP/uqrDK7qRv274omWhNRr
 YoN9henEr7HxxDw3rcq0e92tC9KnLHdv5oHXXvj/6JFUzlgmfn4FbqbLCXe88w/DhP
 nJcndz6rfPDpdqkM47I9kbYoOCCw4QwpnhT/zImvysAhMZCc5iyOwYvcDRvvGc3GcR
 caDPHF4wjOeNw==
Cc: Oder Chiou <oder_chiou@realtek.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
 Sameer Pujar <spujar@nvidia.com>, jonathanh@nvidia.com, sharadg@nvidia.com,
 linux-tegra@vger.kernel.org, Bard Liao <bardliao@realtek.com>
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

Update following in rt5659.txt binding doc
  - Add JD source for Intel HDA header: Commit 041e74b71491
    ("ASoC: rt5659: Add the support of Intel HDA Header")
    added driver support. Add missing info here.

  - sound-name-prefix: Used to prefix component widgets/kcontrols
    with given prefix.

  - ports: Helps to use the Codec with audio graph card

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5659.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Documentation/devicetree/bindings/sound/rt5659.txt
index 56788f5..c473df5 100644
--- a/Documentation/devicetree/bindings/sound/rt5659.txt
+++ b/Documentation/devicetree/bindings/sound/rt5659.txt
@@ -37,10 +37,21 @@ Optional properties:
 - realtek,jd-src
   0: No JD is used
   1: using JD3 as JD source
+  2: JD source for Intel HDA header
 
 - realtek,ldo1-en-gpios : The GPIO that controls the CODEC's LDO1_EN pin.
 - realtek,reset-gpios : The GPIO that controls the CODEC's RESET pin.
 
+- sound-name-prefix: Please refer to name-prefix.txt
+
+- ports: A Codec may have a single or multiple I2S interfaces. These
+  interfaces on Codec side can be described under 'ports' or 'port'.
+  When the SoC or host device is connected to multiple interfaces of
+  the Codec, the connectivity can be described using 'ports' property.
+  If a single interface is used, then 'port' can be used. The usage
+  depends on the platform or board design.
+  Please refer to Documentation/devicetree/bindings/graph.txt
+
 Pins on the device (for linking into audio routes) for RT5659/RT5658:
 
   * DMIC L1
-- 
2.7.4

