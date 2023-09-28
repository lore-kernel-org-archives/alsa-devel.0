Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8779E7735F
	for <alsa-devel@archiver.kernel.org>; Sat, 30 Sep 2023 08:15:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BAF01089;
	Sat, 30 Sep 2023 10:14:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BAF01089
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1696061711;
	bh=dWKzDoh+O4BtjIBu1AXDbYqKseh/++jtxtyxYU+GI1o=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=frKRLKd0udzdA821zsm6n53DoXDpYVJamF7JRQBMdx1togMIw0sEXKHiQ+5Sme/sO
	 SKyrCxir9RYFsgqPZsXGaGM9EAi+EXHe4XHjMiOGTKV50qQOlzrDaJBO07YvXphOmr
	 nFK99ucxNwPOF4DidNJjF7acUoA7ogsuqMjMQ/fA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 01730F80588; Sat, 30 Sep 2023 10:12:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A843F805ED;
	Sat, 30 Sep 2023 10:12:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6A05F801D5; Thu, 28 Sep 2023 05:43:02 +0200 (CEST)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by alsa1.perex.cz (Postfix) with ESMTP id F1E34F8016A
	for <alsa-devel@alsa-project.org>; Thu, 28 Sep 2023 05:41:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1E34F8016A
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.46
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1978118:0:AUTH_RELAY)
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
Subject: [PATCH 0/2] ASoC: codecs: rtq9128: Add TDM input source select
Date: Thu, 28 Sep 2023 11:41:06 +0800
Message-ID: <1695872468-24433-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-MailFrom: prvs=1631658C43=cy_huang@richtek.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 5WTL6YBSJWTHSJWZDPWDWKU4MAIZGT52
X-Message-ID-Hash: 5WTL6YBSJWTHSJWZDPWDWKU4MAIZGT52
X-Mailman-Approved-At: Sat, 30 Sep 2023 08:11:56 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5WTL6YBSJWTHSJWZDPWDWKU4MAIZGT52/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series create a TDM source select property and use it to
decide which TDM data source is connected.

Following by the below patch disccuion
https://lore.kernel.org/lkml/1695780376-32301-1-git-send-email-cy_huang@richtek.com/#t
It may not be a good choice to add the user controlable mixer control
item. Since it follows the board design, make it as a device property.

ChiYuan Huang (2):
  ASoC: dt-bindings: rtq9128: Add TDM input source slect property
  ASoC: codecs: rtq9128: Add TDM input source select

 .../bindings/sound/richtek,rtq9128.yaml          |  7 +++++++
 sound/soc/codecs/rtq9128.c                       | 16 +++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)


base-commit: 3efcb471f871cc095841d411f98c593228ecbac6
-- 
2.34.1

