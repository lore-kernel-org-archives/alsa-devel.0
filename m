Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB71CC46CA1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Sep 2023 16:00:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0B87DFA;
	Mon, 18 Sep 2023 17:59:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0B87DFA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695052849;
	bh=cy5P25cz3r5IaXvoe3bsdIGWs3gH7tzrKzMRYe2drqQ=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=AyGzW4568oTT9/nUu/UqzjVXL7usVxhqS80rc6ihu75Oy9eVwpeZiBHDWrFpCkyx7
	 k1m7nutvHkVy/9x9h+d/72EvsaQg2AVd5O8GL4yDzhSQA9SeLodwiFqeY/d+NYTC04
	 l3ilBba+M1up63j1P0yh6HF8GitvBi/jihuiKuS0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55F88F805C6; Mon, 18 Sep 2023 17:58:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B6F3FF805C6;
	Mon, 18 Sep 2023 17:58:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9B915F8025A; Mon, 18 Sep 2023 11:46:50 +0200 (CEST)
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by alsa1.perex.cz (Postfix) with ESMTP id D4013F801F5
	for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2023 11:46:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4013F801F5
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(1978114:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256);
 Mon, 18 Sep 2023 17:45:51 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 18 Sep
 2023 17:45:50 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.25 via Frontend
 Transport; Mon, 18 Sep 2023 17:45:50 +0800
From: <cy_huang@richtek.com>
To: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ChiYuan
 Huang <cy_huang@richtek.com>, Allen Lin <allen_lin@richtek.com>,
	<alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: Add rtq9128 audio amplifier
Date: Mon, 18 Sep 2023 17:45:39 +0800
Message-ID: <1695030341-20711-1-git-send-email-cy_huang@richtek.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-MailFrom: prvs=16244D1BD6=cy_huang@richtek.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: UJLFDAZDWSXMUUKQXN73RNCN4CSF5Q2M
X-Message-ID-Hash: UJLFDAZDWSXMUUKQXN73RNCN4CSF5Q2M
X-Mailman-Approved-At: Mon, 18 Sep 2023 15:57:48 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UJLFDAZDWSXMUUKQXN73RNCN4CSF5Q2M/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: ChiYuan Huang <cy_huang@richtek.com>

This patch series adds Richtek rtq9128 automotive audio amplifier
support. It can deliver up to 4x75W into 4Ohm speaker from a 25V
supply in automotive applications.

ChiYuan Huang (2):
  ASoC: dt-bindings: Add Richtek rtq9128 audio amplifier
  ASoC: codecs: Add Richtek rtq9128audio amplifier support

 .../bindings/sound/richtek,rtq9128.yaml       |  51 ++
 sound/soc/codecs/Kconfig                      |  15 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/rtq9128.c                    | 742 ++++++++++++++++++
 4 files changed, 810 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
 create mode 100644 sound/soc/codecs/rtq9128.c


base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70
-- 
2.34.1

