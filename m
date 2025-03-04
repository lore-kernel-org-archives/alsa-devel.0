Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379CAC19F32
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Mar 2025 09:41:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D32CF60414;
	Wed,  5 Mar 2025 10:40:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D32CF60414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1741167667;
	bh=p7UcvrmLrFb5QFopWcUy3pdx7/ZuRSmSns7L/OEbAPA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HmzS58v5nbJepvP+mzV7j4nPxnOXOe8qswvEDbDn4ik9kpfTmDGwElffG9534f8f4
	 EUsSQX5KcE/C7sdPC08UFA4ITAtIPR4l6eKMNCBUq3dBkIwZilNSVyuSE3ui8cfgNP
	 9EPvld/5oe3lWSUupirWQ72OnItbxLdDBtzL9vwc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBC35F80C6F; Wed,  5 Mar 2025 10:37:08 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9ECD2F8061C;
	Wed,  5 Mar 2025 10:37:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77417F80544; Tue,  4 Mar 2025 07:27:56 +0100 (CET)
Received: from smtp134-100.sina.com.cn (smtp134-100.sina.com.cn
 [180.149.134.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1ABC6F8051F
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2025 07:27:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1ABC6F8051F
Received: from unknown (HELO
 zy-virtual-machine.localdomain)([180.159.108.137])
	by sina.net (10.185.250.32) with ESMTP
	id 67C69D5A00005F29; Tue, 4 Mar 2025 14:27:40 +0800 (CST)
X-Sender: zhangyi@everest-semi.com
X-Auth-ID: zhangyi@everest-semi.com
Authentication-Results: sina.net;
	 spf=none smtp.mailfrom=zhangyi@everest-semi.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=zhangyi@everest-semi.com
X-SMAIL-MID: CD134A4D078D477EA9B6F133B72FC3D5
X-SMAIL-UIID: CD134A4D078D477EA9B6F133B72FC3D5-20250304-142740
From: Zhang Yi <zhangyi@everest-semi.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org,
	devicetree@vger.kernel.org
Cc: tiwai@suse.com,
	amadeuszx.slawinski@linux.intel.com,
	robh@kernel.org,
	Zhang Yi <zhangyi@everest-semi.com>
Subject: [PATCH v3 0/2] ASoC: codecs: add support for ES8389
Date: Tue,  4 Mar 2025 14:27:35 +0800
Message-Id: <20250304062737.51701-1-zhangyi@everest-semi.com>
X-Mailer: git-send-email 2.17.1
X-MailFrom: zhangyi@everest-semi.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: QBDRDDZQZZTXMQFHGHKYIONJAKG2DE3H
X-Message-ID-Hash: QBDRDDZQZZTXMQFHGHKYIONJAKG2DE3H
X-Mailman-Approved-At: Wed, 05 Mar 2025 09:36:54 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QBDRDDZQZZTXMQFHGHKYIONJAKG2DE3H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The driver is for codec ES8389 of everest-semi.

change in v3:
- Added reg_format at everest,es8389.yaml

Zhang Yi (2):
  ASoC: codecs: add support for ES8389
  ASoC: dt-bindings: Add Everest ES8389 audio CODEC

 .../bindings/sound/everest,es8389.yaml        |  82 ++
 sound/soc/codecs/Kconfig                      |   6 +-
 sound/soc/codecs/Makefile                     |   2 +
 sound/soc/codecs/es8389.c                     | 971 ++++++++++++++++++
 sound/soc/codecs/es8389.h                     | 139 +++
 5 files changed, 1199 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es8389.yaml
 create mode 100644 sound/soc/codecs/es8389.c
 create mode 100644 sound/soc/codecs/es8389.h

-- 
2.17.1

