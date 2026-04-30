Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE6ACCFA13
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:04:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5620D601F7;
	Thu, 30 Apr 2026 13:04:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5620D601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777547059;
	bh=6aZQQt4wgmFG6pfFAwiK8twfkZ91JWPyFapaqiKvDFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=MiICKioVnIc6KJ1MzoM4bqPxakW/HBJAnqs7QB8Yj9/9sWsYKe9+wqFynzfK/mBn0
	 J61ynsG7mqER0oQ0l1NlJHLNSfLZ6juJmuIdofyVXRGRvv4MoYNpjefvmVeQbuvSM3
	 JX5sywczBfAgUnvUGP3vu/kKuk7GkyJdqyz0w+O8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4418AF805EE; Thu, 30 Apr 2026 13:03:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D5A86F805E7;
	Thu, 30 Apr 2026 13:03:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E99E0F80524; Thu, 30 Apr 2026 13:03:36 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B127AF800B5
	for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2026 13:03:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B127AF800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=naVJxzzJ;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=nloGSXtm
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63U1mNo6411545;
	Thu, 30 Apr 2026 06:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=VuD0tP6V0Cqaw5E3cgOc/oIDj3D2LuoqlkqzWcthOiM=; b=
	naVJxzzJO+gg5hZM0ZzOZHdxHxAgJHjBkFD2OajoN+JRST2Kg+s0f/PUjA16yiXV
	mBjVaJ1KrNZo9K75YxkrpIB2MYDbzp2UChk4g9gaD+8b+qeOiAsgXwOCDUMDPuIb
	6mDn1jOwlqvtqFJ2utEzvVNs4WlwpX5uI8vF8dw0KrkHiuo31v9HNIvlEDCyBUUK
	V+f66Bp53IyIR6P7YQk7iHz/NBOq4LPfEvIawG1Xzn1n+2J/hAQT/Sezk6Dx265t
	/owAmtEDe+njPxcn/JOGX3HtbVb93b67rKWQ0R19qPUPO+wtng2tktmS1bTrIp0q
	CqrGG4g2LOEqq8phzC2oUw==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020074.outbound.protection.outlook.com [52.101.201.74])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4drt1jq1p9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Apr 2026 06:03:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXnk78cYm5g0NnYup6SLqBDvxFPVuQtHZYtcHu76emBZdjHnNRUo0X8fSMcSSoxdeVxvLp41ObDbh2VghS3PxAZTJkpF8yEw//rmMtVakrlTvAMjW4lVKkQ8o86SpZ6F3RFWaKM/7+/nWTdfBbjUYIMZeQ/uycNXFWf44X8ruTFSne1+K4/kZoJZS3mcCuaQ2v2JWdaGtiPNeOAhrS1uhxDdxfhxx8r1Q1sBXUTEG6RM+H6JHwwavjM81mULlJO2hIW0yqMXovPYiDFZfwx/y8a2OmH1EjssMDPUaEHjJvnA5YFR5UEwvpp1zuT/gh1DI2QehrdAWngc8AyAUgbC6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuD0tP6V0Cqaw5E3cgOc/oIDj3D2LuoqlkqzWcthOiM=;
 b=EaGn9756IUfNv7SSlZYwLkw2LzG6dQzG0JzbIhHz+9a1lqG+Ok2fKT6swnlDTafOKSvNKcNBhwIdRAccfLGXQOgCI24D4jCznNCUsLBXTNifnScUs5kG/4BUxdrzqNQ50bj7Os2Ion6C8TFXeyrOp0XefLsAzNGLsN6ooKWwppG/cjh0iMgXtVVqm588FTWGb0Wy0GVYAIm1S0vb8LnMLU8otmb7Iy0XwDjSlCYcyDP2iItKYPsp+gfNHgfu2wsIOt9Or0jKfEVRnF/dFJ3yWwZzk1ZRLNAKQxad+gf92QmyuN9Fl+qHLrXEyZfpPzynB54ZL/j1GZIUX4PeMJV0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuD0tP6V0Cqaw5E3cgOc/oIDj3D2LuoqlkqzWcthOiM=;
 b=nloGSXtmyvsWWlVWnqqt4VaIhYjvVq/dlGj27nTxBKpogRPFCpR9FBz1On1AtuIkPMHTQ7pIKZ6rsTfW0maDdRXV4WQzeCBBJkWbvShJUJS4ePBNvmp96aiGIVKwC93AaTtD8sbMbjGtswl6ZZ1WOHXnCpRWke6FRx72q5KEKms=
Received: from MN0PR02CA0002.namprd02.prod.outlook.com (2603:10b6:208:530::29)
 by DS2PR19MB9481.namprd19.prod.outlook.com (2603:10b6:8:2d2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 11:03:26 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:530:cafe::f4) by MN0PR02CA0002.outlook.office365.com
 (2603:10b6:208:530::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.21 via Frontend Transport; Thu,
 30 Apr 2026 11:03:25 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48
 via Frontend Transport; Thu, 30 Apr 2026 11:03:24 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 02245406550;
	Thu, 30 Apr 2026 11:03:24 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com
 [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D34B382025A;
	Thu, 30 Apr 2026 11:03:23 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH v4 2/2] ALSA: control: add ioctl to retrieve full card
 components
Date: Thu, 30 Apr 2026 12:03:01 +0100
Message-ID: <20260430110302.3745917-2-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260430110302.3745917-1-mstrozek@opensource.cirrus.com>
References: <20260430110302.3745917-1-mstrozek@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS2PR19MB9481:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 391c3569-8a32-4405-1308-08dea6a819c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700016|61400799027|13003099007|56012099003|22082099003|16102099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	WjsT89GA4D6DweIHbOjDZ6GC9lgCCVVxAGapZ1usjeyCK4TERM1TKz5geRHSQYqKL96zQ5KXzjIhFyvAL/78ZHzj0OKZ+pLDkgJroFl1pWSPXPmOI4yvSbt7DCXgkEamvcPnCMsi/AJS3QLUiu98Add/wGfQBxbcnvwaMeTYfXjjEBmN4YOz/TymqwrRsbRGsgKHYohUN6Jmsa3VMetaHlfa+Kecf8wz9aV3mlXn9njBEhDHXhKchp7rEkCR4Z9uvWPEYnM9HREIcNjfAg6pn9Ro9sVOKFpQ5h8Fj1lianDNPEdtgd9nEk2DWHABraMAwD5H6Zsx/sSZv9The+UiXtAcvvjElPon7vN9+WT8mr/yCTvrQJE6sFPWlT/PIank1Ca91CIl5UfP8eswDHE5N6aEovUFYpRtt5AUcOBgku6RVBkGt6IO31lA8Kl9SPKMvUzH4D9f5CA9nhRYDZlC4O4XwojpRHMj65ttb7RKCaxVRIut5rGfimxF373siHVqUPFqe7Cn2w5bnshBujO87nkwze5SUmXdf25Yu+7ZJLg9TPOHXcvx6YOBGxXhCn2NCeEatmXDGb2/hel0etyTIs1qN8mNZYsvzsJm0GmgbAOp/to3vafGNi+WgiaMtr3EI6tGIv3xlbANO0mAzs1aLhGwLmiAD8UWHX/e94dEkK+ksZf6in0JQxDZ1Q7tOt3T6vy1XkpSMUZa/+esz1tb8fHymNenm+HBiEALtHxHnj9nFOnpWqCa+ohXHnv7sJrlDj/DCSzcTEDrDfEKVLVQzg==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(61400799027)(13003099007)(56012099003)(22082099003)(16102099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qOUVbJqRa6fv1VtQUXUToIrHIOKvvSpvydavsb/LYUVJYWjIOJIM19D5Lfijlzc3fE8dBt23eAFwzA5SgtlWZdfI4O3uykCr1lina9bbETyZVw3p83o04WFSqHVKmN6GrRh6Sbb07G/aYaNirLp9C6NHzQgpfpV94yoBtzL9mO3MhO33NEqvs7brkSrKF+lGBR7FTWLp34JFprU9L+TtWSwUfXY8eRBDfVLrFMw7gzh6IxFo7tLngZhNbP+bgoKPqUZlzUW9JkPmkj7vcxuFQLrc2lZdPQwxTtu7u508LDbxkaxNlEvwV6PvVTuw3hv0W02n57plpG1kYGD9ELRiBvJ3i6FpJdBICA20ItGRZFZ8c/Bhh6yK8RXt4BA17r1820lPBCuhZ7bkz7rbk/miPRhhLELT6ycHy1OxmWSPkyHo/QA9YRFWIbQuOLttfwi7
X-Exchange-RoutingPolicyChecked: 
	QAwUOxWFV/ZDC33mSx6WT8kQ5zIeNCz2u2bZmduwv0DfCgpNGZKZP4GNXUTRfTCQkXLKY7yALMlcHN9hAcC+Yh+SYa1HTlBtGMm6MBg2kXV4G5BytQyPQNtvMMON8DUzNUbWzAI/2vfoxqAXTtqQwQIGxITUkl8lxnzjU0qX+deF85pM78r9MkeJge5+8ncjWGU2ywgNAHjXKxFfeahSATzkEi2CxS7C9NKdDdE1gHbiBXdo0HFSF2k9IGNypROsnYPkT3OMzWinjWW1ZhyN5PIrRShpr9zMp0wPgW1urEMnCJc9UC2iUet0kxJF9Vd/9+eW/A34uMLUzOwOZPvXJg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 11:03:24.8002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 391c3569-8a32-4405-1308-08dea6a819c2
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR19MB9481
X-Authority-Analysis: v=2.4 cv=fbudDUQF c=1 sm=1 tr=0 ts=69f33703 cx=c_pps
 a=9mF5moCRh3baUhQ7ZsOuTg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=A5OVakUREuEA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=NEAV23lmAAAA:8 a=iox4zFpeAAAA:8 a=w1d2syhTAAAA:8 a=sefg8_7nxHGFjYeqZrUA:9
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: shPA1klq0a0fJI4SSCk6OGIWoR5U5DSH
X-Proofpoint-ORIG-GUID: shPA1klq0a0fJI4SSCk6OGIWoR5U5DSH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDExMiBTYWx0ZWRfX3ZdBjsEMpeMc
 u/1vMeepd6LKibobd6Jvd4paIARy2td8/Ku36NaarYIvDy4cES8tDvGIqKM6pRk4uAXUJyLdmvq
 brNbj7AwxHk4IGIVHZwd3kfYMe7GQxk8itfhQE2WaK8PsEe2y3PBJEQU6JD2zXQwSLe/E0RzddZ
 64Of25KK71KPnIjIFRt0XWwbkmFYpkxUigCJqU1cawOMTh6yvj0S1A19VVdIx3+h6Rshx/B9THR
 E7j4JGgvZx0kxZGRQGuYuP/8pbPuC7pd6GkiPJFA14hsKZN3Zkh2KHvI0RJvBqOm8cLfhFv7VXT
 Yv7CbYzRFqQS3JludRSi3b38LYD7aAQAD88wORqJ87RTZ0k0kRPguuPRtk3UjGChLA1IDDeXjcx
 XIm4ZvDXaTBtNp4UnX7gStV9o5XuYzQ7aYMU/qZPdHl4Pnl8oTiIK3W/RbjlTCZwgUNUSHg9wAA
 VP6VM7fKh9HxZPgYjtA==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: OUWKQNJ2A7P2RDN2253EHLWAPDZAYOVK
X-Message-ID-Hash: OUWKQNJ2A7P2RDN2253EHLWAPDZAYOVK
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OUWKQNJ2A7P2RDN2253EHLWAPDZAYOVK/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The fixed-size components field in SNDRV_CTL_IOCTL_CARD_INFO can be too
small on systems with many audio devices.

Keep the existing struct snd_ctl_card_info ABI intact and add a new
ioctl SNDRV_CTL_IOCTL_CARD_BYTES that carries a variable-length payload
selected by a type discriminator. The first defined type
SND_CTL_CARD_BTYPE_COMPONENTS returns the full components string. The
ioctl is designed to be reused for other variable-length card payloads
in the future.

The user-space caller may set data_allocated == 0 (or data == NULL) to
query the required length; otherwise the kernel copies the payload into
the user buffer and writes back the actual length in data_len.

When the legacy components field in struct snd_ctl_card_info is
truncated, '>' is written just before the NUL terminator to signal to
user-space that the full string is available via the new ioctl.

card->components is now dynamically allocated and grown in 32 byte
increments via krealloc(), capped at 512 bytes.

Link: https://github.com/alsa-project/alsa-lib/pull/494
Suggested-by: Jaroslav Kysela <perex@perex.cz>
Suggested-by: Takashi Iwai <tiwai@suse.com>
Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
---
Changes for v4:
 - replaced snd_ctl_card_components with snd_ctl_card_bytes for possible
   future extensions
 - support query mode (data_allocated == 0 or data == NULL)
 - added compat 32-bit
 - renamed card->components_ptr / components_ptr_alloc_size to
   card->components / components_alloc_size
Changes for v3:
 - change components field to a dynamic array resizable in 32 byte
   increments
 - removed SNDRV_CTL_COMPONENTS_LEN define
 - sanity check if 'components' requests more than 512 bytes
 - added a commit to clean up trailing whitespaces
 - alsa-utils link no longer needed
Changes for v2:
 - do not modify existing card->components field
 - add a new ioctl and struct to keep the full components string
 - handle the split/trim in snd_ctl_card_info()
---
 include/sound/core.h        |  4 +--
 include/uapi/sound/asound.h | 21 ++++++++++++++-
 sound/core/control.c        | 52 ++++++++++++++++++++++++++++++++++++-
 sound/core/control_compat.c | 27 +++++++++++++++++++
 sound/core/init.c           | 34 ++++++++++++++++++++----
 5 files changed, 129 insertions(+), 9 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 4093ec82a0a12..8a6a0e86da5e5 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -87,8 +87,8 @@ struct snd_card {
 	char longname[80];		/* name of this soundcard */
 	char irq_descr[32];		/* Interrupt description */
 	char mixername[80];		/* mixer name */
-	char components[128];		/* card components delimited with
-								space */
+	char *components;		/* card components, space-delimited */
+	unsigned int components_alloc_size;	/* current allocation size of components */
 	struct module *module;		/* top-level module */

 	void *private_data;		/* private data for soundcard */
diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index d3ce75ba938a8..a6b695a798f07 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -1058,7 +1058,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/

-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 9)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 10)

 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -1072,6 +1072,24 @@ struct snd_ctl_card_info {
 	unsigned char components[128];	/* card components / fine identification, delimited with one space (AC97 etc..) */
 };

+/*
+ * Card components can exceed the fixed 128 bytes in snd_ctl_card_info.
+ * Use SNDRV_CTL_IOCTL_CARD_BYTES with type SND_CTL_CARD_BTYPE_COMPONENTS
+ * to retrieve the full string.
+ */
+
+/* Type values for struct snd_ctl_card_bytes::type */
+enum {
+	SND_CTL_CARD_BTYPE_COMPONENTS	= 1,	/* full card components string */
+};
+
+struct snd_ctl_card_bytes {
+	unsigned int type;		/* SND_CTL_CARD_BTYPE_* */
+	unsigned int data_allocated;	/* size of @data buffer in bytes */
+	unsigned int data_len;		/* in/out: actual data length in bytes */
+	unsigned char *data;		/* user buffer */
+};
+
 typedef int __bitwise snd_ctl_elem_type_t;
 #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
 #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
@@ -1198,6 +1216,7 @@ struct snd_ctl_tlv {

 #define SNDRV_CTL_IOCTL_PVERSION	_IOR('U', 0x00, int)
 #define SNDRV_CTL_IOCTL_CARD_INFO	_IOR('U', 0x01, struct snd_ctl_card_info)
+#define SNDRV_CTL_IOCTL_CARD_BYTES	_IOWR('U', 0x02, struct snd_ctl_card_bytes)
 #define SNDRV_CTL_IOCTL_ELEM_LIST	_IOWR('U', 0x10, struct snd_ctl_elem_list)
 #define SNDRV_CTL_IOCTL_ELEM_INFO	_IOWR('U', 0x11, struct snd_ctl_elem_info)
 #define SNDRV_CTL_IOCTL_ELEM_READ	_IOWR('U', 0x12, struct snd_ctl_elem_value)
diff --git a/sound/core/control.c b/sound/core/control.c
index 5e51857635e62..9a3772f1126d8 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -876,9 +876,13 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
 {
 	struct snd_ctl_card_info *info __free(kfree) =
 		kzalloc(sizeof(*info), GFP_KERNEL);
+	ssize_t n;

 	if (! info)
 		return -ENOMEM;
+
+	static_assert(sizeof(info->components) >= 2);
+
 	scoped_guard(rwsem_read, &snd_ioctl_rwsem) {
 		info->card = card->number;
 		strscpy(info->id, card->id, sizeof(info->id));
@@ -886,13 +890,57 @@ static int snd_ctl_card_info(struct snd_card *card, struct snd_ctl_file * ctl,
 		strscpy(info->name, card->shortname, sizeof(info->name));
 		strscpy(info->longname, card->longname, sizeof(info->longname));
 		strscpy(info->mixername, card->mixername, sizeof(info->mixername));
-		strscpy(info->components, card->components, sizeof(info->components));
+		n = strscpy(info->components, card->components, sizeof(info->components));
+		if (n < 0) // mark the truncation with '>' before NULL terminator
+			info->components[sizeof(info->components) - 2] = '>';
 	}
 	if (copy_to_user(arg, info, sizeof(struct snd_ctl_card_info)))
 		return -EFAULT;
 	return 0;
 }

+static int snd_ctl_card_bytes(struct snd_card *card,
+			      struct snd_ctl_card_bytes *info,
+			      unsigned int __user *data_len_out)
+{
+	unsigned int data_len;
+
+	switch (info->type) {
+	case SND_CTL_CARD_BTYPE_COMPONENTS:
+		scoped_guard(rwsem_read, &snd_ioctl_rwsem) {
+			data_len = strlen(card->components) + 1;
+
+			if (!info->data || info->data_allocated == 0)
+				break;
+
+			if (info->data_allocated < data_len)
+				return -ENOMEM;
+
+			if (copy_to_user(info->data, card->components, data_len))
+				return -EFAULT;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (put_user(data_len, data_len_out))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int snd_ctl_card_bytes_user(struct snd_card *card,
+				   struct snd_ctl_card_bytes __user *_info)
+{
+	struct snd_ctl_card_bytes info;
+
+	if (copy_from_user(&info, _info, sizeof(info)))
+		return -EFAULT;
+
+	return snd_ctl_card_bytes(card, &info, &_info->data_len);
+}
+
 static int snd_ctl_elem_list(struct snd_card *card,
 			     struct snd_ctl_elem_list *list)
 {
@@ -1992,6 +2040,8 @@ static long snd_ctl_ioctl(struct file *file, unsigned int cmd, unsigned long arg
 		return put_user(SNDRV_CTL_VERSION, ip) ? -EFAULT : 0;
 	case SNDRV_CTL_IOCTL_CARD_INFO:
 		return snd_ctl_card_info(card, ctl, cmd, argp);
+	case SNDRV_CTL_IOCTL_CARD_BYTES:
+		return snd_ctl_card_bytes_user(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST:
 		return snd_ctl_elem_list_user(card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO:
diff --git a/sound/core/control_compat.c b/sound/core/control_compat.c
index 4ad571087ff59..9077482d67440 100644
--- a/sound/core/control_compat.c
+++ b/sound/core/control_compat.c
@@ -19,6 +19,30 @@ struct snd_ctl_elem_list32 {
 	unsigned char reserved[50];
 } /* don't set packed attribute here */;

+struct snd_ctl_card_bytes32 {
+	u32 type;
+	u32 data_allocated;
+	u32 data_len;
+	u32 data;
+};
+
+static int snd_ctl_card_bytes_compat(struct snd_card *card,
+				     struct snd_ctl_card_bytes32 __user *data32)
+{
+	struct snd_ctl_card_bytes data = {};
+	compat_caddr_t ptr;
+
+	/* type, data_allocated, data_len */
+	if (copy_from_user(&data, data32, 3 * sizeof(u32)))
+		return -EFAULT;
+	/* data */
+	if (get_user(ptr, &data32->data))
+		return -EFAULT;
+	data.data = compat_ptr(ptr);
+
+	return snd_ctl_card_bytes(card, &data, &data32->data_len);
+}
+
 static int snd_ctl_elem_list_compat(struct snd_card *card,
 				    struct snd_ctl_elem_list32 __user *data32)
 {
@@ -426,6 +450,7 @@ enum {
 	SNDRV_CTL_IOCTL_ELEM_WRITE32 = _IOWR('U', 0x13, struct snd_ctl_elem_value32),
 	SNDRV_CTL_IOCTL_ELEM_ADD32 = _IOWR('U', 0x17, struct snd_ctl_elem_info32),
 	SNDRV_CTL_IOCTL_ELEM_REPLACE32 = _IOWR('U', 0x18, struct snd_ctl_elem_info32),
+	SNDRV_CTL_IOCTL_CARD_BYTES32 = _IOWR('U', 0x02, struct snd_ctl_card_bytes32),
 #ifdef CONFIG_X86_X32_ABI
 	SNDRV_CTL_IOCTL_ELEM_READ_X32 = _IOWR('U', 0x12, struct snd_ctl_elem_value_x32),
 	SNDRV_CTL_IOCTL_ELEM_WRITE_X32 = _IOWR('U', 0x13, struct snd_ctl_elem_value_x32),
@@ -456,6 +481,8 @@ static inline long snd_ctl_ioctl_compat(struct file *file, unsigned int cmd, uns
 	case SNDRV_CTL_IOCTL_TLV_WRITE:
 	case SNDRV_CTL_IOCTL_TLV_COMMAND:
 		return snd_ctl_ioctl(file, cmd, (unsigned long)argp);
+	case SNDRV_CTL_IOCTL_CARD_BYTES32:
+		return snd_ctl_card_bytes_compat(ctl->card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_LIST32:
 		return snd_ctl_elem_list_compat(ctl->card, argp);
 	case SNDRV_CTL_IOCTL_ELEM_INFO32:
diff --git a/sound/core/init.c b/sound/core/init.c
index 593c05895e118..a683803bcf96a 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -590,6 +590,9 @@ static int snd_card_do_free(struct snd_card *card)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_FREE);
 #endif
 	snd_device_free_all(card);
+	kfree(card->components);
+	card->components = NULL;
+	card->components_alloc_size = 0;
 	if (card->private_free)
 		card->private_free(card);
 #ifdef CONFIG_SND_CTL_DEBUG
@@ -1036,16 +1039,37 @@ int snd_component_add(struct snd_card *card, const char *component)
 {
 	char *ptr;
 	int len = strlen(component);
+	unsigned int cur_len, need_len;

-	ptr = strstr(card->components, component);
-	if (ptr != NULL) {
-		if (ptr[len] == '\0' || ptr[len] == ' ')	/* already there */
-			return 1;
+	if (card->components) {
+		ptr = strstr(card->components, component);
+		if (ptr) {
+			if (ptr[len] == '\0' || ptr[len] == ' ')	/* already there */
+				return 1;
+		}
+		cur_len = strlen(card->components) + 1;
+	} else {
+		cur_len = 0;
 	}
-	if (strlen(card->components) + 1 + len + 1 > sizeof(card->components)) {
+
+	need_len = cur_len + len + 1;
+	if (need_len > 512) {
 		snd_BUG();
 		return -ENOMEM;
 	}
+
+	if (need_len > card->components_alloc_size) {
+		unsigned int new_alloc = roundup(need_len, 32);
+
+		ptr = krealloc(card->components, new_alloc, GFP_KERNEL);
+		if (!ptr)
+			return -ENOMEM;
+		if (!card->components)
+			ptr[0] = '\0';
+		card->components = ptr;
+		card->components_alloc_size = new_alloc;
+	}
+
 	if (card->components[0] != '\0')
 		strcat(card->components, " ");
 	strcat(card->components, component);
--
2.47.3

