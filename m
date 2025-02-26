Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016CEC19F32
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:36:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7DBD76035E;
	Wed,  5 Mar 2025 10:36:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7DBD76035E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741167397;
	bh=ghC9vqNPJzkei9Zug19J2vWknOTg5ZDVCIur60SjExw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mpRH9czUSYzTP4ZvyoYpwEr8SZsAXqgsCr31NLNjoc7JRz37MeY0SdAxQhYQ0uJ/o
	 91OnWeh4lZn55YP8HLvoOD04NP9aN7txquSlLD939JBsKYWaZZZgRonHFA2Y4BecwP
	 d0Z8ACSQPxxRRRkUCorzWg0oTBCftHg8tu2ONmRM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86FCBF805EF; Wed,  5 Mar 2025 10:35:48 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F3AFF805E9;
	Wed,  5 Mar 2025 10:35:48 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1CF4EF801F5; Wed, 26 Feb 2025 11:50:25 +0100 (CET)
Received: from smtp134-86.sina.com.cn (smtp134-86.sina.com.cn
 [180.149.134.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4C38F80116
	for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2025 11:49:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4C38F80116
Received: from unknown (HELO
 zy-virtual-machine.localdomain)([180.159.108.137])
	by sina.net (10.185.250.30) with ESMTP
	id 67BEF1CF00003A73; Wed, 26 Feb 2025 18:49:52 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: 27DDB0DFC561489B80BEEB61A4BB4788
X-SMAIL-UIID: 27DDB0DFC561489B80BEEB61A4BB4788-20250226-184952
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	yangxiaohua@everest-semi.com,
	zhuning@everest-semi.com,
	zhangyi@everest-semi.com
Subject: [PATCH 0/2] ASoC: codecs: add ES8389 codec driver
Date: Wed, 26 Feb 2025 18:49:47 +0800
Message-Id: <20250226104949.16303-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: QSUIZ4Z5NDSMOEMEK7XCLK4N2JTZY6JJ
X-Message-ID-Hash: QSUIZ4Z5NDSMOEMEK7XCLK4N2JTZY6JJ
X-Mailman-Approved-At: Wed, 05 Mar 2025 09:35:41 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QSUIZ4Z5NDSMOEMEK7XCLK4N2JTZY6JJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The driver is for codec ES8389 of everest-semi.

Zhang Yi (2):
  ASoC: codecs: add support for ES8389
  ASoC: dt-bindings: Add Everest ES8389 audio CODEC

 .../bindings/sound/everest,es8389.txt         |  68 ++
 sound/soc/codecs/Kconfig                      |   5 +
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/es8389.c                     | 977 ++++++++++++++++++
 sound/soc/codecs/es8389.h                     | 139 +++
 5 files changed, 1191 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/sound/everest,es8389.txt
 create mode 100755 sound/soc/codecs/es8389.c
 create mode 100755 sound/soc/codecs/es8389.h

-- 
2.17.1

