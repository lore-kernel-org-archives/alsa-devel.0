Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8F0C7EE25
	for <alsa-devel@archiver.kernel.org>; Fri, 12 May 2023 12:30:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8303C200;
	Fri, 12 May 2023 14:29:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8303C200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683894648;
	bh=XnZOpeLg2jB3NqIeHz+EtsLIk4E/+O+21xYcvDQJ2tI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=DDVoLYNOWpJchI/T2e+3TcosP/Xym95U3+d6SII3lhV8kV7M9f83D79gId4YBSpZ9
	 YsE/8L0XmrkxiV9hDqYPj1f0jiRS1ZVEPykQO//FCsIoH7SYsFNoUVpA65i7ei0/iF
	 tWcUmnE+tR9IJQoAs7O0TqP8lIyxgQp/PlMP1QXM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 45C8BF8057A; Fri, 12 May 2023 14:29:11 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E088FF80567;
	Fri, 12 May 2023 14:29:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33ECDF80551; Fri, 12 May 2023 14:28:56 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4071BF8052E
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2023 14:28:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4071BF8052E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=Ap4aiG0a
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34CCOUoo001858;
	Fri, 12 May 2023 07:28:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=hhGbqr5I8d1WarBJ8Z9M0P99KfkmGBTeVHbqv5amikE=;
 b=Ap4aiG0ah8RcwsjPABIbFRIg+kASR6fLmS8xzdDwefldHDuurFAMk4B5MfWBens19A7F
 XqsvNcGVbfOhOxcWYXKecIBFrSAgJO74wrYn38mIIYAqkA+X+UMxc03E8T/lEUpD8yhz
 HVs7zEEjJChOknZT4gTqALpDXKTALyzYgJpOoIrcvncv/aHU0brRHDfxiy+qK4D6xEtN
 /8J3fSPbHlZJTfGzFpEaAlAmujCaALpN9h42TVooNfelT5aaGs1vYsptfCKgDbU3KUrc
 TBhEdHiK2ZUazkqXvaa+9uON8sgTPRKUvfF8YuVAvSywjrOI919HQNSjPYsYwbkiTgeQ xQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7nb5dqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 May 2023 07:28:40 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 07:28:38 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 07:28:38 -0500
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 24FD345;
	Fri, 12 May 2023 12:28:38 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>
CC: <lgirdwood@gmail.com>, <yung-chuan.liao@linux.intel.com>,
        <sanyog.r.kale@intel.com>, <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 00/10] Add cs42l43 PC focused SoundWire CODEC
Date: Fri, 12 May 2023 13:28:28 +0100
Message-ID: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8-OvAxXkBH6wUG2stbtfU7YbBv3HFIV3
X-Proofpoint-GUID: 8-OvAxXkBH6wUG2stbtfU7YbBv3HFIV3
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: 63DFZXVJ2FJ7BAQKXOTYAR6C4W46YXAL
X-Message-ID-Hash: 63DFZXVJ2FJ7BAQKXOTYAR6C4W46YXAL
X-MailFrom: prvs=0496644b8b=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/63DFZXVJ2FJ7BAQKXOTYAR6C4W46YXAL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch chain adds support for the Cirrus Logic cs42l43 PC focused
SoundWire CODEC. Some supporting work is included in the chain,
including adding an ASoC control notification helper function and
adding support for IRQs generated by the in-band SoundWire alert
mechanism.

The chain is currently based of v6.4-rc1 because I am not 100% sure
which tree we want to send everything through. The CODEC support
has a build dependency on both the SoundWire change and the ASoC
soc-component change.

Thanks,
Charles

Charles Keepax (8):
  ASoC: soc-component: Add notify control helper function
  ASoC: ak4118: Update to use new component control notify helper
  ASoC: wm_adsp: Update to use new component control notify helepr
  dt-bindings: mfd: cirrus,cs42l43: Add initial DT binding
  mfd: cs42l43: Add support for cs42l43 core driver
  irqchip/cs42l43: Add support for the cs42l43 IRQs
  pinctrl: cs42l43: Add support for the cs42l43
  ASoC: cs42l43: Add support for the cs42l43

Lucas Tanure (2):
  soundwire: bus: Allow SoundWire peripherals to register IRQ handlers
  spi: cs42l43: Add SPI controller support

 .../bindings/mfd/cirrus,cs42l43.yaml          |  212 ++
 MAINTAINERS                                   |    7 +
 drivers/irqchip/Kconfig                       |    9 +
 drivers/irqchip/Makefile                      |    1 +
 drivers/irqchip/irq-cs42l43.c                 |  170 ++
 drivers/mfd/Kconfig                           |   23 +
 drivers/mfd/Makefile                          |    3 +
 drivers/mfd/cs42l43-i2c.c                     |   86 +
 drivers/mfd/cs42l43-sdw.c                     |  210 ++
 drivers/mfd/cs42l43.c                         | 1044 ++++++++
 drivers/mfd/cs42l43.h                         |   23 +
 drivers/pinctrl/cirrus/Kconfig                |   11 +
 drivers/pinctrl/cirrus/Makefile               |    2 +
 drivers/pinctrl/cirrus/pinctrl-cs42l43.c      |  614 +++++
 drivers/soundwire/bus.c                       |   31 +
 drivers/soundwire/bus_type.c                  |   12 +
 drivers/spi/Kconfig                           |    7 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-cs42l43.c                     |  287 +++
 include/linux/irqchip/cs42l43.h               |   61 +
 include/linux/mfd/cs42l43-regs.h              | 1172 +++++++++
 include/linux/mfd/cs42l43.h                   |   50 +
 include/linux/soundwire/sdw.h                 |    9 +
 include/sound/cs42l43.h                       |   84 +
 include/sound/soc-component.h                 |    4 +
 sound/soc/codecs/Kconfig                      |   16 +
 sound/soc/codecs/Makefile                     |    4 +
 sound/soc/codecs/ak4118.c                     |   11 +-
 sound/soc/codecs/cs42l43-jack.c               |  946 +++++++
 sound/soc/codecs/cs42l43-sdw.c                |   75 +
 sound/soc/codecs/cs42l43.c                    | 2270 +++++++++++++++++
 sound/soc/codecs/cs42l43.h                    |  117 +
 sound/soc/codecs/wm_adsp.c                    |   20 +-
 sound/soc/soc-component.c                     |   22 +
 34 files changed, 7586 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/cirrus,cs42l43.yaml
 create mode 100644 drivers/irqchip/irq-cs42l43.c
 create mode 100644 drivers/mfd/cs42l43-i2c.c
 create mode 100644 drivers/mfd/cs42l43-sdw.c
 create mode 100644 drivers/mfd/cs42l43.c
 create mode 100644 drivers/mfd/cs42l43.h
 create mode 100644 drivers/pinctrl/cirrus/pinctrl-cs42l43.c
 create mode 100644 drivers/spi/spi-cs42l43.c
 create mode 100644 include/linux/irqchip/cs42l43.h
 create mode 100644 include/linux/mfd/cs42l43-regs.h
 create mode 100644 include/linux/mfd/cs42l43.h
 create mode 100644 include/sound/cs42l43.h
 create mode 100644 sound/soc/codecs/cs42l43-jack.c
 create mode 100644 sound/soc/codecs/cs42l43-sdw.c
 create mode 100644 sound/soc/codecs/cs42l43.c
 create mode 100644 sound/soc/codecs/cs42l43.h

-- 
2.30.2

