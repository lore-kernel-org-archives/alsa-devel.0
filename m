Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1287BD116F5
	for <alsa-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:01:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A2C460181;
	Mon,  1 Dec 2025 12:01:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A2C460181
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1764586880;
	bh=8r2cz961nsC0cNe19rdESv9XFy7If29g71vEelE+Y/4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=EPhpqTbESimxicsWCVmNa0YHm2FDyvruFSVBMkRxlEerytSxNMY8auoSDI1/t+zaU
	 mYTzf/yJrhrlkt3PVxJr4q1THvFR0D/EvluhoII0pIVyix0RV5q1sAWFx46jDj245+
	 yUp2Vf+E9R8TG3zB8sAAWtN4w2818USGqPKK1U9U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 04B2AF805F9; Mon,  1 Dec 2025 12:00:32 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id ACEF1F805EE;
	Mon,  1 Dec 2025 12:00:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72625F804FF; Mon,  1 Dec 2025 11:58:21 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E71A6F80448
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2025 11:58:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E71A6F80448
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=realtek.com header.i=@realtek.com header.a=rsa-sha256
 header.s=dkim header.b=ExEQ3QTn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5B1AvvZ832042567,
 This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764586677; bh=dhT0pZQ7+FUA2QobktyRUIDGF0JquEOJ7p/lovReEkk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ExEQ3QTngGrackKUHi2U+YunbV+9cjHQHDYcavE9F9ZWAzhVmKlrgoHpag5buCK4S
	 i+M+sa22U5v3v/MlwEHkik4PLA0GyH25gjsbH11i+C/JnYtiynbyG5LtYvHAx58Ps5
	 DNyJVnIOaj/ZiGtAnUDS00FDVqnwjV+tX8wlvEroZWPTg1kjJ408FwnB2QTnf81e99
	 8WXzfEAbJ45P7gAmRM0hLCYYgtC3rq/TfV9VtA1LuWYzRn9iaIBCDqPRV2xc92l+8/
	 M/Y2elIpZBMpSzbGjCBDTYu7g1CCQcLZCh1aC9pCaHx6IlKwQew2oz3dIN3L4sXtzz
	 rFhBD2uXfC88A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5B1AvvZ832042567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Dec 2025 18:57:57 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 1 Dec 2025 18:57:57 +0800
Received: from sw-server.localdomain (172.24.54.4) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server id
 15.2.1544.27 via Frontend Transport; Mon, 1 Dec 2025 18:57:57 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <cezary.rojewski@intel.com>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <perex@perex.cz>, <linux-sound@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <flove@realtek.com>, <shumingf@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Subject: [PATCH v8 0/2] ASoC: rt5575: Add the codec driver for the ALC5575
Date: Mon, 1 Dec 2025 18:59:24 +0800
Message-ID: <20251201105926.1714341-1-oder_chiou@realtek.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: V34TFICGGGGRTR4U4JZFI3JRDYWSHPS4
X-Message-ID-Hash: V34TFICGGGGRTR4U4JZFI3JRDYWSHPS4
X-MailFrom: oder_chiou@realtek.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V34TFICGGGGRTR4U4JZFI3JRDYWSHPS4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi all,

This patch series adds support for the Realtek ALC5575 audio codec.

Changes in v8:
- Patch 1/2:
  - remove the variable rt5575_spi_ready
  - use the multiple compatible names to distinguish between w/wo flash
- Patch 2/2
  - add compatible enum "realtek,rt5575-with-spi"

Changes in v7:
- Patch 1/2:
  - add a caption for the tristates
  - remove the redundant enum of the SPI command
  - add the error log in the request firmware failure
  - change the function name rt5575_spi_fw_loaded to rt5575_fw_load_by_spi
  - minor fixes
- Patch 2/2
  - modify commit message
- Link to v7: https://lore.kernel.org/all/20251121084112.743518-1-oder_chiou@realtek.com/

Changes in v6:
- Patch 1/2:
  - modify commit message
  - add select SND_SOC_RT5575 to config SND_SOC_RT5575_SPI in the Kconfig
  - revise the boiler plate in the head of the file
  - sort the include files
  - use a structure to transfer the spi data
  - use the poll() related function instead the for-loop
  - revise the UUID to the private ID
  - minor fixes
- Patch 2/2
  - modify description
- Link to v6: https://lore.kernel.org/all/20251031073245.3629060-1-oder_chiou@realtek.com/

Changes in v2 to v5:
- Patch 1/2:
  - move the firmware to the subdirectory
  - remove the empty functions
  - remove the cache_type in the regmap_config
  - add the error log in the run firmware failure
- Patch 2/2:
  - nothing
- Link to v5: https://lore.kernel.org/all/20251015103404.3075684-1-oder_chiou@realtek.com/

Oder Chiou (2):
  ASoC: rt5575: Add the codec driver for the ALC5575
  ASoC: dt-bindings: realtek,rt5575: add bindings for ALC5575

 .../bindings/sound/realtek,rt5575.yaml        |  44 ++
 sound/soc/codecs/Kconfig                      |  10 +
 sound/soc/codecs/Makefile                     |   4 +
 sound/soc/codecs/rt5575-spi.c                 |  84 ++++
 sound/soc/codecs/rt5575-spi.h                 |  16 +
 sound/soc/codecs/rt5575.c                     | 375 ++++++++++++++++++
 sound/soc/codecs/rt5575.h                     |  54 +++
 7 files changed, 587 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/realtek,rt5575.yaml
 create mode 100644 sound/soc/codecs/rt5575-spi.c
 create mode 100644 sound/soc/codecs/rt5575-spi.h
 create mode 100644 sound/soc/codecs/rt5575.c
 create mode 100644 sound/soc/codecs/rt5575.h

-- 
2.52.0

