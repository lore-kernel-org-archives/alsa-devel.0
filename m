Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DBAC7EE23
	for <alsa-devel@archiver.kernel.org>; Wed, 31 May 2023 14:11:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99BFB83B;
	Wed, 31 May 2023 16:11:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99BFB83B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685542312;
	bh=Nlqt6nv5jTxRnarCLA92t10azHvVgULOESMvKRPcpo8=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TxFWDzXVlgQcg778GFU+a/7SMvut/iy6pnAx8YFQ9MN7OL0H5LMxp6GkdQoBluSxM
	 im2y+sDEfbwrQEO/O/sn6XZqtBmUVF/zf5NL/DAPsLJ8E8+4tXB5eHOX1/Jg06oZEj
	 Vg9Ff1BsvMzCbHU4/wFi3yy4RyEWRbMnMfzFetUM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8107CF8056F; Wed, 31 May 2023 16:10:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E46F1F8055C;
	Wed, 31 May 2023 16:10:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B9FBF8042F; Wed, 31 May 2023 16:09:57 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8F25CF800DF
	for <alsa-devel@alsa-project.org>; Wed, 31 May 2023 16:09:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F25CF800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector1 header.b=H1CJ09HT
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34VCImYD001501;
	Wed, 31 May 2023 16:09:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=prF5Y1wurMLlqq34fQzZcB6OviCE9Oi8RI5OEOhQF2o=;
 b=H1CJ09HTw3sEPZlbQbJfuPTeyEJdZMM01HYE/XZTapsG+juAwIxOYfrU0N5D+y+9gWzI
 Zv/qiDGWzU7VKm73MYgncgMjLb2pPuJUUN1r6p8J+FE8CKBV/XQRc8cq8zrAAl0n2SfR
 0hAgBEKw1BTbjtKCCfQWnMkrNhMu/I/boRb1NoKOTQ5957LNe8MRUh79WVuhWq40UKsL
 yhDn4u4BncEbCjIff8EEyNHJdl7pxyAx+Xkx52o+K2F+ASr9BukeH1qNIgKWJk1ywGne
 ZiLUWAMum4OlAI1MHsdNB0b8LaGaAULO2r4NHopgGPByd9mK3ISFMsTkSqqbiFphNPY0 mw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qweqe9170-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 May 2023 16:09:50 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C14A10002A;
	Wed, 31 May 2023 16:09:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED2A524B8AE;
	Wed, 31 May 2023 16:09:48 +0200 (CEST)
Received: from localhost (10.252.16.99) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 31 May
 2023 16:09:48 +0200
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: Alexandre Torgue <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] ASoC: stm32: fix dtbs_check warnings
Date: Wed, 31 May 2023 16:09:09 +0200
Message-ID: <20230531140912.819373-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.16.99]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_03,2023-05-22_02
Message-ID-Hash: WEYDEBNFRF3APYJAE25KZTZWH2RAAZVU
X-Message-ID-Hash: WEYDEBNFRF3APYJAE25KZTZWH2RAAZVU
X-MailFrom: prvs=451568473a=olivier.moysan@foss.st.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WEYDEBNFRF3APYJAE25KZTZWH2RAAZVU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fix dtbs_check warnings in STM32MP15 DK boards Devices Trees for
STM32 I2S and Cirrus CS42L51 codec.

- Add OF graph port property in I2S and CS42L51 DT bindings.
  Fixes warnings:
  audio-controller@4000b000: Unevaluated properties are not allowed 
  ('port' was unexpected)
  cs42l51@4a: Unevaluated properties are not allowed
  ('port' was unexpected)
- Correct OF graph DAI audio format property for STM32MP15x Dkx I2S node

Olivier Moysan (3):
  ASoC: dt-bindings: stm32: document audio of graph port for i2s
  ASoC: dt-bindings: document audio of graph port for cs42l51
  ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx

 Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml | 4 ++++
 Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml   | 4 ++++
 arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                      | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.25.1

