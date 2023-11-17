Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34BDC197A0
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Nov 2023 14:16:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6A9FDF6;
	Fri, 17 Nov 2023 15:15:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6A9FDF6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1700230567;
	bh=vG/llSBtFE3mcFyYgV6MSAyGo2lYnAbbP8C0sIgg29Q=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=YwjdDI31GFZn1qsRdhOomAZCiTWTkH3fxSMdua9YzBzTtm8znj9blPUg+s0/pXMyg
	 OrjQaOqBZT/7EmTnhDMO3KH8mNYzZ9IfFh+h1fsB9o29xuqJZLnbiNBPrxMzv6lGdu
	 zPQxqCeNtLoddFynx9cTK2eTDPMV4espbUijGbww=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 63F8DF8059F; Fri, 17 Nov 2023 15:14:09 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 69D71F805A1;
	Fri, 17 Nov 2023 15:14:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16ED8F80549; Fri, 17 Nov 2023 15:14:00 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4E245F8022B
	for <alsa-devel@alsa-project.org>; Fri, 17 Nov 2023 15:13:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E245F8022B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=S7y+KHND
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 3AH8IefK017599;
	Fri, 17 Nov 2023 08:13:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=F
	wPEmYl6wbAvf5HjePnJT1k0yWGDTyNaKGDv//NqY0c=; b=S7y+KHNDlGvP5McII
	R7J5BOt/RQmu57E/ZrwWpws8PZ+/lFJp05S9gt+eHLwhpUT9e40eQbyaggRjXE1D
	S/pLbTmd6Z1wnpfA8Fd2iTtMfqVclm+85mg8Pk/FnH6JMLx0NMQKEiaNP9xdLrt7
	0FVjGuE7jRskK7S3Kv0WtKnKcv3ZxcnfHsXa702D8eFXTNF/jx0iciCnv7GO/opg
	f7xXNXqMAUnCeOcBLdOAqIGZDTj1OiSUfnkIyTZpb9SunvAwlqb4qZNZ8r52s2Ez
	QZc5CDwdRRzJDqVPmKJ3vtJ1TotYAbEVRosSfoaTlUH34wIFHcUrfl51hd6BVhMZ
	7GCxg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ua7w2qj86-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 08:13:50 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 14:13:46 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.39 via Frontend
 Transport; Fri, 17 Nov 2023 14:13:46 +0000
Received: from upx-tgl-008-ubuntu.ad.cirrus.com
 (upx-tgl-008-ubuntu.ad.cirrus.com [198.90.251.167])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A49A915A0;
	Fri, 17 Nov 2023 14:13:46 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: James Schulman <james.schulman@cirrus.com>,
        David Rhodes
	<david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Maciej Strozek
	<mstrozek@opensource.cirrus.com>
Subject: [PATCH 0/7] ASoC: cs43130: Fixes and improvements
Date: Fri, 17 Nov 2023 14:13:37 +0000
Message-ID: <20231117141344.64320-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: saRXQWLGibz-4ixkRKO05Tbv7HBcjCFf
X-Proofpoint-GUID: saRXQWLGibz-4ixkRKO05Tbv7HBcjCFf
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: 4BT7BZFFHORXKLSAJRGHZCXYOU73WJCH
X-Message-ID-Hash: 4BT7BZFFHORXKLSAJRGHZCXYOU73WJCH
X-MailFrom: prvs=668552b693=mstrozek@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4BT7BZFFHORXKLSAJRGHZCXYOU73WJCH/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patchset aims to add minor fixes (first two patches) and
introduce general improvements to the driver (rest of the patches)

Maciej Strozek (7):
  ASoC: cs43130: Fix the position of const qualifier
  ASoC: cs43130: Fix incorrect frame delay configuration
  ASoC: cs43130: Allow configuration of bit clock and frame inversion
  ASoC: cs43130: Store device in private struct and use it more
    consistently
  ASoC: cs43130: Add handling of ACPI
  ASoC: cs43130: Allow driver to work without IRQ thread
  ASoC:cs43130: Add switch to control normal and alt hp inputs

 sound/soc/codecs/cs43130.c | 311 ++++++++++++++++++++++++-------------
 sound/soc/codecs/cs43130.h |   3 +
 2 files changed, 204 insertions(+), 110 deletions(-)

--
2.34.1

