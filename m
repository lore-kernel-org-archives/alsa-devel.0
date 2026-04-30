Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B980DCCFA13
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:04:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBA2D60211;
	Thu, 30 Apr 2026 13:04:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBA2D60211
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777547074;
	bh=L/TmB71JKSl1NPcbqS6yLD0QXrM6tVtu6ONPrrShLF0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=VvjK7ykayiFFpdxk+UXCpP10hICQ/KgoTONzYGX86zdtGLE3Glnr+/u3nlxjJnYwj
	 yJPyo9w7aiVL73eQnkE+KvGucXxCUBoHiG5N5vs8vSHkzIAly2hHd7gDy2lmnLdjtn
	 Y1BKnZq491Inty8txgvcOXkfUkD+tfGu86ECypg0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 40A3FF8060C; Thu, 30 Apr 2026 13:03:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A17D4F80609;
	Thu, 30 Apr 2026 13:03:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4BBDF802BE; Thu, 30 Apr 2026 13:03:37 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5BDA7F8016D
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2026 13:03:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BDA7F8016D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=AXshl+Ys;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=Px+AV6vQ
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U4Yrex687636;
	Thu, 30 Apr 2026 06:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=IRyqOXevqtUS+gvT
	aZ+03/GG1+xz47TaxxLFr4xC14M=; b=AXshl+Ys2bDlqZ8CTZUJ+1TJ2sO5pcqp
	vnal79P43OOGbEG7detZjT1YjbpqJcmJ1jz5nXSl1QlHfPKsia3WlEI0hZGwrg1W
	FpKv0oac+ysjY6epy5IG7H+2DCqHwn4V/8cSh5E31mGVE+KtgPy76Hlm2U6VA1hi
	3FV4D3QPk/Vwe9Yw235k6uSPTUFkcZ6yx3oxDyv+Uji8OMHF98FNh/jwM9cZ6Qrk
	nrp3DqL8EwP1nbw+ZAH6EC+/I/pH7yRIbJgWLerSiTrmDfqkKPsM9IxM7hdOKTwg
	lVEXwhm2rfoGyPNuxuL2GFDvxnD+K84awU8wq0cNotQZrpdFPTA3gg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021113.outbound.protection.outlook.com [52.101.57.113])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4drt1jq1pb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 06:03:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5r3IIOpX7IdZs7r8N+YQOdvMvSCpqwU5RXqeW0A1WeCPSpFo+ezGZyv9SH99yCqxwGcPKjJg5BhLI08QLIryeyKK2oLX9k5nLINPbFZ12xqc0K2PSFU9jD28Asuszs9yh0tjP++s/kiud0uFcLcJSGYmxiYrg7uM2znpk7IzEZgDg/e53jJrqfHfz9t7bMdljqLYDP6xRGBFuvProVfqVle5STmtumZvHB+Rmtslm9GFzKl0IdrhxYlFFtJTaZlbEOUI0kIoVUqIE8I5DNfa4P6EMIkGgSf3TGc9stCV0R9bN1j2PRBra1RujZEFGn9tBYH6vSaWPe38m+aJ6VNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRyqOXevqtUS+gvTaZ+03/GG1+xz47TaxxLFr4xC14M=;
 b=OFFc12Rx6SiMimoFWXUg7lqa/aIVuyr9wLSnKfqTUr2nRpCc5Pz3hTuc5IpOmDe8pnaljtSe7fjVbXOf+WwpHu1PGZD3vHOHFzCiU+6pVIh71yRhpsTFgww6sFfTOkpdPKL72e3WF/XqUYgTp23kmBnjdPnnmIgXLm4g6IfVZWJ7yM+vrkOC9Word9hZDqu7bAoFxCASIoW/s+8c0uA6AlhUDf2FIcYV5uvn5R9no9S57P1ItrE+zE0TIHg8jdM+4gwr3ImIAcgKINPhbH9ojYWrr8Y1ZNG8XyCqtDLiMtM5Wn20CN/Czra4AkLwqdlMNS4qRJsHwEWArbBdBeUclg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRyqOXevqtUS+gvTaZ+03/GG1+xz47TaxxLFr4xC14M=;
 b=Px+AV6vQXkaAP2FAS27pWuWmVBiRE9BT8WOZtzc823S7P+Z8+jx33vWlusnO83Cfh8/xGFq4bCb0GPD09nsvNCtQGpHRdXGD5Q8jxkgzgzAkAqZDPsMPIlc6TvmGb/s+O3MOycfZQzcaefwsxx5tm04hC0E9jjYZc+5OZfYd6k8=
Received: from CY5PR19CA0094.namprd19.prod.outlook.com (2603:10b6:930:83::20)
 by CH3PR19MB7681.namprd19.prod.outlook.com (2603:10b6:610:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:03:27 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:83:cafe::e6) by CY5PR19CA0094.outlook.office365.com
 (2603:10b6:930:83::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 11:03:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.18
 via Frontend Transport; Thu, 30 Apr 2026 11:03:25 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E861C40654A;
	Thu, 30 Apr 2026 11:03:23 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com
 [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C3FC8820244;
	Thu, 30 Apr 2026 11:03:23 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH v4 1/2] ALSA: control: tidy up whitespaces
Date: Thu, 30 Apr 2026 12:03:00 +0100
Message-ID: <20260430110302.3745917-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|CH3PR19MB7681:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 45b07f3e-9c8e-4ded-346a-08dea6a81a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|61400799027|376014|18002099003|16102099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	lt6/Ayo2mpo4kIldwrYteIWeuFUEHcLQxAkCmzNVLqKXL5ns3zUdwZ7AlcayUkNRkB3RHPoU33ZSUqI5GGamL4ZZYCnAdrKqcsu9KxJr7zOxp0uwgRUPrdjWQ/7MV9tp+9A5+v3MJ5dHAqXRKAO2pm2/sQnYUJG0CH7xugwokZgELow2+oRCOrdb8pNS4uRG5m6VYW/Vqk3oK7ouRT+5p3w+eyzprDmpBvBGHtyywM7Q+SuPWbXSykHJRnP4mQch02tLusoFTr1ycuEq5F7LyiWBRPqNOpyyBSd5LQMCofkXVu04c0t97AJuX+nACW0eoRsVyrZnRLEWVEK+aF6d6NEVrVntVqVMQZz/BnfV2KTikw5U6Kg8IAT0u5Z7EAdx8UIeqhc09djixEoDO5HIBvzWd5CaAMpT5QjT+Uz1J5LF+WEX3EJrJXtso7C9hh2pgrEqZ+zJyQKBqXk+x+Qz9RSaHeKAg7yrsN+n3BvQz2QNTdpkqdvC6uvgbkZwA36wlN2sY/b/+FGdJch3v5cCQGT/MVtKrhQnExoZLZcq8WyAQXotP587mSjEzWIOlRwgcUHIw57faJY4DC17qfCn7W43kDqf6E3I2NgZHmtx/Ysld8gAFe2jMwrwGhSmsgKW3sw6R45L93ge1C20K4yrqHgHJFuRgEsm1xdFhaLSFIoQPyE71nDBLTPSUt8R5eHXpv94+iyZSW+v89gey9DMWZdlGQT7EATFKD4lrK+xIP+7Y+PwfcWNbcA7icly5rJKAM+NhoO4uIjRQgo3irqCJw==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(61400799027)(376014)(18002099003)(16102099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	uIRCIunAdaQzaKxO6tadX7FpeVbDxei7UbCwGN/n+Zpul4Ue6gVPz6ihwo2c85nqCq2MPaAnDGGcwyH9JH2jZA2Rs3gVqvlh47tp41F2OuCKayPlhVWFCa0p/kDbd/QYfqzZSgmbFSY4Eq5CxqQ6HGaWgtp5ctuQl1ymh4d97/Kg7rZ0R7cLXNiFtVKiSYLDs7UK9Jx5IHDc1H1Is9thpGa1FE7I0LjAHNP/VwHz9nEZO2QphRlTuzFGwMAvy37/qpCJPAmPZ/AzurpLSacAuOSzU6Exi5C83GfCv8VbVhdNRZlgfZewCPnTI5Gkt7uEqmg2G4g8bwIi5x5VIdP2lfcYd/tzDGIQdyvYyg5VZT3mJAPLkHzymDECXMmExmnbH3Bp6ov4mKayokQnYsUohtDn+1G3ey271KmVsVIO5s4HEGYkr5es+3vuoR0UI2tO
X-Exchange-RoutingPolicyChecked: 
	Uw6lBL0Xuk1C9SXkl3mBGD/w8LUbR1NmcmOjyN39SEmUhpy5oLDjxbkOmz25ITLQ/ZTEIT3Ac88iTDiP5Pd5xlJ12qMX5t2/b2XyWoz3oKJC9Z0711oD3PLRtSZQcOhfnTAUyYis1SmPE0R7pNRCf4DnwSnPVnJkSbFo57wE1TDMKx4rgI1wpqAWsQ8BfFt0EBBw/shgFWtjbLmVgd8IxoZKcnoHqrDDGuvGdv5uGWaVPKqPXld7bGwOIwEpQHfx2yZtyFVGVFDvkhmuflbiAIwWcBSX4Z5xbn6FXS0LJo/Kf0ctBT8hZLcMZ/PY7BqTDjN/fnfxIrq4dvbuZBt/Sw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:03:25.6749
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 45b07f3e-9c8e-4ded-346a-08dea6a81a55
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7681
X-Authority-Analysis: v=2.4 cv=fbudDUQF c=1 sm=1 tr=0 ts=69f33704 cx=c_pps
 a=I4gKhz1MVFc1Ib3WWZpdnQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=A5OVakUREuEA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=w1d2syhTAAAA:8 a=UOLwL_aBn4USr_LkpIIA:9
X-Proofpoint-GUID: CGLY41VmL68b8w2Ckxmby7Uy5EWRM2b3
X-Proofpoint-ORIG-GUID: CGLY41VmL68b8w2Ckxmby7Uy5EWRM2b3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDExMiBTYWx0ZWRfX6ElVbyQVSfLh
 fZMSX5Vi/qRgsaiMsswzip9AhcGMYDvhE2k6/+HUiWHyXWLzBtumndxLqzLcTmXDLxaarelCT+P
 K6Y2QBbWbC8N9lgQ2UXOoct5mcu21FRqSDl8zr3cW3/OWyMEiV26JkkGux0pL4iENNGtOU1Oa/J
 qWL8iuc1Gk3caH+SY9p7Vvzl7nTcsa/s/ARl76EAkXhqZW8Skz12KIrjPX7GbEr0Uop5zUdlady
 vLC4L2XI9ANnXG2r0OtJo4Jw+/9VS+dGjWMbyydRKfLgoGe4+yYJath3KxhleFKDludXBMcRCOB
 7zW7JBV3obKipqeRA9LArCyXLFvxO+4vLei2dodKKax+8ERr8L4816+1t7H0M+Lfjh+8txJH0pK
 c6uHs/DADNV+E3gquO+bFwZE0hvoYIMTNVrcthB54dzyAqZHewP1xlYuxlr1po9HE0SuFX4vO5L
 NdmXoabtHI/fIyFOW/Q==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: QOETEDKXDMZCFBXEEMFA3LXXDHYCTWCQ
X-Message-ID-Hash: QOETEDKXDMZCFBXEEMFA3LXXDHYCTWCQ
X-MailFrom: prvs=6580d7481d=mstrozek@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QOETEDKXDMZCFBXEEMFA3LXXDHYCTWCQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Clean up trailing whitespace in preparation for the card components
changes.

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
 sound/core/control_compat.c | 2 +-
 sound/core/init.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 16bc80555f265..4ad571087ff59 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -417,7 +417,7 @@ static int snd_ctl_elem_add_compat(struct snd_ctl_file *file,
 		break;
 	}
 	return snd_ctl_elem_add(file, data, replace);
-}
+}

 enum {
 	SNDRV_CTL_IOCTL_ELEM_LIST32 = _IOWR('U', 0x10, struct snd_ctl_elem_list32),
diff --git a/sound/core/init.c b/sound/core/init.c
index 0c316189e9476..593c05895e118 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -722,7 +722,7 @@ static void snd_card_set_id_no_lock(struct snd_card *card, const char *src,
 	int len, loops;
 	bool is_default = false;
 	char *id;
-
+
 	copy_valid_id_string(card, src, nid);
 	id = card->id;

@@ -1031,7 +1031,7 @@ int __init snd_card_info_init(void)
  *
  *  Return: Zero otherwise a negative error code.
  */
-
+
 int snd_component_add(struct snd_card *card, const char *component)
 {
 	char *ptr;
--
2.47.3

