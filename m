Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFE0C41535
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Dec 2023 16:23:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9347E81;
	Tue, 19 Dec 2023 17:23:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9347E81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1703003023;
	bh=clbUH14W6X7NKipr4wm+DGbnSZe7Z6VFFIB2ff03yoY=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=IDPTd8nUtmeiq3b43MR/8uNEFsQmMlSDCkDB9w9ebO4fnXp0R61qci+rxsCYpYYRj
	 q2ehNjMiVLCfEQswtFKheaURqC0bQBkJFigl02E/1cz94iJEKpT51giGgrXdool1pa
	 cMJhG3/nVwlTVpGdJQ7bZSRsp/bkZdSKMD/gEIKQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D632F805BB; Tue, 19 Dec 2023 17:23:03 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C883CF805C8;
	Tue, 19 Dec 2023 17:23:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93E87F80431; Tue, 19 Dec 2023 17:22:55 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C6EFEF8016E
	for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2023 17:22:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C6EFEF8016E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=BERi9JCK
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 3BJ6vo39022423;
	Tue, 19 Dec 2023 10:22:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=7
	YIxxkfA4bPuu0sworASkEd0gQH6RkGNmJfmMmpm8xE=; b=BERi9JCKd5mx+0dz7
	SgKJpnrgNeQSpewV8tUg2UXvEyQY9Bc8TyyOxroOvDu7t302nyuHLGL50bcpnz1g
	VDLjFw/gjJ/KLslpL5DBN4txPDdYtz2A1Un+Wo8alUL935fBXKunds5YXsn4QhO5
	4DV7o15ufmiKRh/dclKv/EZdNkRaDPBL7R1ELSXJO9Nm5cL0wqGBRDhe7rxs5sHr
	OiH7v7F9tHL7BEQzx3ZU5ezq121XbqMDjgk99l2QVXV5KNgn7SEPjgFfjWehNP8D
	zXv3HjA3bSB/un5G62nKbI86aybJNnT77oNf7pNZgu/SmwvlzlUqL/gIOfVNmJbL
	vxgJw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3v1a6249gs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 10:22:46 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 16:22:43 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Tue, 19 Dec 2023 16:22:43 +0000
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.77])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BB00411D1;
	Tue, 19 Dec 2023 16:22:42 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Stefan
 Binding" <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 0/2] Minor fixes for CS35L41 HDA Property driver
Date: Tue, 19 Dec 2023 16:22:30 +0000
Message-ID: <20231219162232.790358-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: -5EAAZfSyYZHV5abJOOe12J-CYt5sVg4
X-Proofpoint-ORIG-GUID: -5EAAZfSyYZHV5abJOOe12J-CYt5sVg4
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: DRYIJZUXKX2LTKFLAENFOQFFRP2JWNW5
X-Message-ID-Hash: DRYIJZUXKX2LTKFLAENFOQFFRP2JWNW5
X-MailFrom: prvs=7717b54677=sbinding@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DRYIJZUXKX2LTKFLAENFOQFFRP2JWNW5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Minor issues were found in static analysis.
First fix ensures unitialised variables will never be freed.
Second fix only compiles in the SPI workaround if SPI is enabled in the
kernel.

Stefan Binding (2):
  ALSA: hda: cs35l41: Do not allow uninitialised variables to be freed
  ALSA: hda: cs35l41: Only add SPI CS GPIO if SPI is enabled in kernel

 sound/pci/hda/cs35l41_hda_property.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.34.1

