Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAE8C001DB
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Aug 2023 12:51:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7840D827;
	Tue, 15 Aug 2023 14:50:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7840D827
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1692103878;
	bh=hfrNqgjpYOKljHNAFPJKSvIEaOCB7aDt9VmDrMD9D8o=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=EHJ5L+wHvF1HpSh0gsR8eA8qz80tayEtBLuebkph1t5edlGNvB67p/Ee7Pjr+0Yq0
	 3S36OoVm1EYdIgXe4a7ZfokQObI4b9eZ8xA6KvmiDUkjFiBDP+E/tgOdSb/XUqzeZo
	 KnfFypeRBygEMOCAuaWSVHfH3ADc5jJdnFvQ+KOw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19F1FF80290; Tue, 15 Aug 2023 14:49:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59622F8016D;
	Tue, 15 Aug 2023 14:49:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47413F80254; Tue, 15 Aug 2023 14:48:40 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6E819F800EE
	for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2023 14:48:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E819F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=nCzLOQlX
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id
 37FC59WE010995;
	Tue, 15 Aug 2023 07:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=Z
	E0qnOdBtKzLQtZ0IT5D4MO9KtCscaiR+dmQHQem3h0=; b=nCzLOQlX7NB+BUncn
	aNHPiKRfrCZ9kaJD25A/TsSCo9qZN+RQrl9YwKNxi3QxOgy5Htj2wsznxg0nH8CT
	1XoeS13Qf9Hwzr2cjav/2o+zR0I0PwUiMwGMF9owHRoPzWwSYhnuynzj644BbiXN
	JOeCqlG84IlnGEkVHvPF73OTDcg/YMxkWvSV6Oi525HolzsgpwxLNmHJOP6aFTVk
	m5bVFe30+HlRxQ+PVHRiQ14vqD5VtXOEfG37uQddpVZkAYkeTvbji4dRhYpmpWLf
	K5Tlm9Nr0Hz3z8YOZcJpr7tGRWAMg01ZHHuwB3ymg91AiHC5D3JQhDeVHIKH34er
	PuHng==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhjxk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Aug 2023 07:48:30 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 15 Aug
 2023 13:48:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 15 Aug 2023 13:48:29 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com
 [198.61.65.68])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0EB9115B4;
	Tue, 15 Aug 2023 12:48:29 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 0/2] ASoC: cs35l56: Don't patch firmware that is already
 patched
Date: Tue, 15 Aug 2023 13:48:24 +0100
Message-ID: <20230815124826.5447-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 5n45QvV6BqyFdfmOYdkMs4OCCp_b1d1h
X-Proofpoint-ORIG-GUID: 5n45QvV6BqyFdfmOYdkMs4OCCp_b1d1h
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: BEK25IQHPOODWRSTAUBKRVLWHEKRORGP
X-Message-ID-Hash: BEK25IQHPOODWRSTAUBKRVLWHEKRORGP
X-MailFrom: prvs=3591ab1424=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BEK25IQHPOODWRSTAUBKRVLWHEKRORGP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Use the FIRMWARE_MISSING flag in the CS35L56 to determine whether it is
safe to download a firmware patch.

Richard Fitzgerald (2):
  ASoC: wm_adsp: Support powering-up DSP without trying to load firmware
  ASoC: cs35l56: Don't overwrite a patched firmware

 sound/soc/codecs/cs35l56.c | 19 ++++++++++++++++---
 sound/soc/codecs/wm_adsp.c | 16 +++++++++-------
 sound/soc/codecs/wm_adsp.h |  2 +-
 3 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.30.2

