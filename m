Return-Path: <SRS0=GNy4=BY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD18DC433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:39:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 574C620781
	for <alsa-devel@archiver.kernel.org>; Fri, 14 Aug 2020 09:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OVIz/zhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574C620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5B23165E;
	Fri, 14 Aug 2020 11:38:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5B23165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597397976;
	bh=RZ6oQItKSqK3SnWxxH5EXqppplUTUPfxt9S7k3kii6Y=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=OVIz/zhXyWJ3sYlsk7l5k1TfskEDkQpp4SbQLM+sEIjZo1jwENW3T3Fx3pyeasOz3
	 JTvgYZ8rhwfuZtJcnc/SHTx8T5FUagD3BPu2wxfA6QewYKHMkF2tqzZ1r9F+3Nmc3M
	 lDfx03M3APgP/6cQ8QauhqRjP43JR5eY0OPWm/xs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 50733F80146;
	Fri, 14 Aug 2020 11:38:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 896EAF8022B; Fri, 14 Aug 2020 11:38:07 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 54D14F80146
 for <alsa-devel@alsa-project.org>; Fri, 14 Aug 2020 11:37:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 54D14F80146
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 73E181A0391;
 Fri, 14 Aug 2020 11:37:56 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 132D51A0387;
 Fri, 14 Aug 2020 11:37:53 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 82B3B402C1;
 Fri, 14 Aug 2020 11:37:48 +0200 (CEST)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] ASoC: dt-bindings: ak4458: Add power supply property
Date: Fri, 14 Aug 2020 17:32:40 +0800
Message-Id: <1597397561-2426-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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

AVDD-supply is for Analog power supply
DVDD-supply is for Digital power supply

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/ak4458.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ak4458.txt b/Documentation/devicetree/bindings/sound/ak4458.txt
index e5820235e0d5..8f6c84f21468 100644
--- a/Documentation/devicetree/bindings/sound/ak4458.txt
+++ b/Documentation/devicetree/bindings/sound/ak4458.txt
@@ -10,6 +10,8 @@ Required properties:
 Optional properties:
 - reset-gpios: A GPIO specifier for the power down & reset pin
 - mute-gpios: A GPIO specifier for the soft mute pin
+- AVDD-supply: Analog power supply
+- DVDD-supply: Digital power supply
 
 Example:
 
-- 
2.27.0

