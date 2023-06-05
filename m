Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3BDC77B73
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Jun 2023 15:31:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E1CF4843;
	Mon,  5 Jun 2023 17:30:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E1CF4843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1685979071;
	bh=qhOq+ubXIkuJFdPKoS/KpkgO9mXL67uUIfzPkiQhIH0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Na5LVo6dUbhzRtMMkBjaW2YqICxDkSAySxG6R87JZpnmnz2BbsflbOGwq5zD8SsjC
	 Nmyy84zEWuqN/K/pO1TWa9zgCOPCkETiTorQ6hnI7Cxd1EhKdlmM/vhhfuLUouIze2
	 Wp13c56dcf3ekr55D5tcDhA5ecoP5etEZ2obxhn0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 364F4F80570; Mon,  5 Jun 2023 17:29:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D8176F80570;
	Mon,  5 Jun 2023 17:29:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6D83F80199; Mon,  5 Jun 2023 17:29:16 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5BF39F8016C
	for <alsa-devel@alsa-project.org>; Mon,  5 Jun 2023 17:29:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BF39F8016C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=dVtrbMyX
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3558sEEF030588;
	Mon, 5 Jun 2023 10:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=S1uQnmsd6XI75wdABbJ0fjbAZApoBOSHGSUOv9rvCkk=;
 b=dVtrbMyXYgCf4pul4d65ZGFaruSCWu/pqTUtKD/pbep5bu8ide2FFp5mDfXVSAJbuRPH
 hUO28lFwXB5H9IHnEdmaemODkRtKWTG5wAJaRd+IhYzfENYyYqY6rMJTz9dv1Z7XhPdI
 JOZJmzOJ4vhoZbVZJl/PXgJV8B/0Ci1YSaPHIvfuZXyM5EojmRaSyH0+8qTujOTMxyID
 24TbKPg4twUXhnxD6TsXNrYufiHLGB7pVU3rbor5trCGCUs8DpwuxBoUbfAPggs7JMKp
 myPz5ASYpkS6TX54I7o/E4OH9Fl/qEt7TecqDnXs09N07dfOHx5IC15egsjp5lkd3cIi qw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3r01xna179-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jun 2023 10:29:04 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Mon, 5 Jun
 2023 16:29:03 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Mon, 5 Jun 2023 16:29:03 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (NEWNC1SL3J3.ad.cirrus.com
 [198.90.238.20])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B4E3011AA;
	Mon,  5 Jun 2023 15:29:02 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Stefan Binding
	<sbinding@opensource.cirrus.com>
Subject: [PATCH v2 0/3] Fixes and cleanup for CS35L41 HDA
Date: Mon, 5 Jun 2023 16:28:52 +0100
Message-ID: <20230605152855.448115-1-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Ah15Nc8gmTzw_xqjB7ubQJvp2NZAMdxh
X-Proofpoint-GUID: Ah15Nc8gmTzw_xqjB7ubQJvp2NZAMdxh
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: PZ4N7WNBTUS57QU7RJDBJAQUHG6AZSET
X-Message-ID-Hash: PZ4N7WNBTUS57QU7RJDBJAQUHG6AZSET
X-MailFrom: prvs=1520dfaea3=sbinding@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PZ4N7WNBTUS57QU7RJDBJAQUHG6AZSET/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Several minor issues were found during additional testing and
static analysis. These patches fix these minor issues.

CHANGES SINCE V1:
Patch 2:
- Removed unnecessary cast

Stefan Binding (3):
  ALSA: hda: cs35l41: Clean up Firmware Load Controls
  ALSA: hda: cs35l41: Fix endian conversions
  ALSA: hda/realtek: Delete cs35l41 component master during free

 sound/pci/hda/cs35l41_hda.c   | 32 ++++++++++++++------------------
 sound/pci/hda/patch_realtek.c |  2 ++
 2 files changed, 16 insertions(+), 18 deletions(-)

-- 
2.34.1

