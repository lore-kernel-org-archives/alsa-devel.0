Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359F3E7735F
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Sep 2023 08:14:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 72218EA5;
	Sat, 30 Sep 2023 10:13:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 72218EA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696061676;
	bh=U9nNeFBQBnJja8pOD6VLsm5axmCeMsTugGxp7nFit6Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NAuWGajL9YOLUbkQJ4jC9y+Hzab6bcGs6VrW6wzLkjj5oj3zt7Wj1hizoUbt60+vp
	 I6ePAzWnvmUDVVSEJJ2JpNoITgIkyic/4YdxlKABq0U+reS7QUEfr+tEOs4GkFZEVp
	 4LJssoDGGaD6CVgzQ1eRfSsWhaUtkZrRh8dhX6Ng=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CECAFF805B5; Sat, 30 Sep 2023 10:12:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8176F8057D;
	Sat, 30 Sep 2023 10:12:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2D89F8047D; Thu, 28 Sep 2023 05:41:55 +0200 (CEST)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by alsa1.perex.cz (Postfix) with ESMTP id D5D11F800AE
	for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2023 05:41:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D5D11F800AE
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1978106:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256);
 Thu, 28 Sep 2023 11:41:10 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Thu, 28 Sep
 2023 11:41:09 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Thu, 28 Sep 2023 11:41:09 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, ChiYuan Huang <cy_huang@richtek.com>, Allen Lin
	<allen_lin@richtek.com>, <devicetree@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: rtq9128: Add TDM input source slect
 property
Date: Thu, 28 Sep 2023 11:41:07 +0800
Message-ID: <1695872468-24433-2-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
References: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MailFrom: prvs=1631658C43=cy_huang@richtek.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ABJXZPIXZG7YQVJ4XEROGWC7VKLK4NHM
X-Message-ID-Hash: ABJXZPIXZG7YQVJ4XEROGWC7VKLK4NHM
X-Mailman-Approved-At: Sat, 30 Sep 2023 08:11:56 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ABJXZPIXZG7YQVJ4XEROGWC7VKLK4NHM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: ChiYuan Huang <cy_huang@richtek.com>

Create a boolean property to select TDM input source coms from 'DATA2'.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/sound/richtek,rtq9128.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml b/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
index d117f08fff30..d54686a19ab7 100644
--- a/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
+++ b/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
@@ -28,6 +28,13 @@ properties:
   enable-gpios:
     maxItems: 1
 
+  richtek,tdm-input-data2-select:
+    type: boolean
+    description:
+      By default, if TDM mode is used, TDM data input will select 'DATA1' pin
+      as the data source. This option will configure TDM data input source from
+      'DATA1' to 'DATA2' pin.
+
   '#sound-dai-cells':
     const: 0
 
-- 
2.34.1

