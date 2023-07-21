Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF847EB64DC
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Jul 2023 09:08:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 735CCE93;
	Fri, 21 Jul 2023 11:07:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 735CCE93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1689930506;
	bh=pNtmDQRqLN0kXWVHsflignrMdRWeZoE5gaXDOPkYs0c=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aGBweLkGMtGQ4EJstC3X3+QWiCOOGErPBlhaX9AmUYCuC8h6cTbRDqkNNPtVmmZfT
	 ub27kqnyOPbHUjTPOiN55rzq46bn5CPEH/Qcru8e5R7n1+sVUZUJs6C/5aZDGxVxWO
	 DBB3fPRCb8SyeFxU+k9NklXkI5beD7eQGGtLohDo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91DEDF8027B; Fri, 21 Jul 2023 11:07:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E70F5F8032D;
	Fri, 21 Jul 2023 11:07:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3DE53F8047D; Fri, 21 Jul 2023 11:07:03 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E552F8007E
	for <alsa-devel@alsa-project.org>; Fri, 21 Jul 2023 11:06:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E552F8007E
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36L96TqeC027193,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36L96TqeC027193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
	Fri, 21 Jul 2023 17:06:29 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Jul 2023 17:06:39 +0800
Received: from ubuntu.localdomain (172.22.102.209) by RTEXMBS01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 21 Jul
 2023 17:06:39 +0800
From: <shumingf@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
CC: <alsa-devel@alsa-project.org>, <lars@metafoo.de>, <flove@realtek.com>,
        <oder_chiou@realtek.com>, <jack.yu@realtek.com>,
        <derek.fang@realtek.com>, <Vijendar.Mukunda@amd.com>,
        <pierre-louis.bossart@linux.intel.com>,
        "Shuming
 Fan" <shumingf@realtek.com>
Subject: [PATCH v2 0/5] fix for JD event handling in ClockStop Mode0
Date: Fri, 21 Jul 2023 17:06:33 +0800
Message-ID: <20230721090633.128196-1-shumingf@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.209]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
Message-ID-Hash: RRA575VLWZE2F2W5U7W7IO2TXDTOIVXZ
X-Message-ID-Hash: RRA575VLWZE2F2W5U7W7IO2TXDTOIVXZ
X-MailFrom: shumingf@realtek.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RRA575VLWZE2F2W5U7W7IO2TXDTOIVXZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Shuming Fan <shumingf@realtek.com>

Currently, the codec driver could re-enables SDCA interrupt mask and 
the bus driver re-enables Imp-defined interrupt mask when the devices are re-attached.
If the manager uses ClockStop Mode0 to peripherals, 
the SDCA/Imp-defined interrupt mask will not be enabled when the system resumes.
These patches will fix this issue.
--
v2 - modify the commit messages

Shuming Fan (5):
  ASoC: rt5682-sdw: fix for JD event handling in ClockStop Mode0
  ASoC: rt711: fix for JD event handling in ClockStop Mode0
  ASoC: rt711-sdca: fix for JD event handling in ClockStop Mode0
  ASoC: rt712-sdca: fix for JD event handling in ClockStop Mode0
  ASoC: rt722-sdca: fix for JD event handling in ClockStop Mode0

 sound/soc/codecs/rt5682-sdw.c     |  9 ++++++++-
 sound/soc/codecs/rt711-sdca-sdw.c | 10 +++++++++-
 sound/soc/codecs/rt711-sdw.c      |  9 ++++++++-
 sound/soc/codecs/rt712-sdca-sdw.c | 10 +++++++++-
 sound/soc/codecs/rt722-sdca-sdw.c | 10 +++++++++-
 5 files changed, 43 insertions(+), 5 deletions(-)

-- 
2.34.1

