Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD871CDE000
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:08:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2718A601E0;
	Thu, 25 Jun 2026 14:08:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2718A601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782389324;
	bh=ImGhuAm8LXHJ1Pjdu2Lzk693zcYt4CwtZnY4Qbbd+l8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=hjeh+454DjsCP16QedPf09FZxivU++9+r7xPCVQwgoQ2u38crFQkLGgYaNCcHdysg
	 3o/wWnZSVReb//xtXZ/BDspyLMXrB7wRbDD6+Dk0aF/Zu6v+3/jQ53pBtp5AzCH6lx
	 TJDQJsZF1EFRsZ4VKfaRVp9hnKg0d1uHSJ2jSodc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 111C5F805F0; Thu, 25 Jun 2026 14:08:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E3F0F805F2;
	Thu, 25 Jun 2026 14:08:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2F6FDF80510; Thu, 25 Jun 2026 14:08:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782389283;
	b=PZhofgeHeAdnoUqqRfeL7kmm3fRWzHk+mSL6peox0FYg4ggP3rr32rd8VcWexyBK7yu/
	 3/liubuSp3Mtx+i09VHy1Fn/DTysv+kRd+GEpIH+FtOwrfZriE77ovMco1TtaY5FlEFAC
	 jlLPUI8k5IxatpyRyrCubT9hjIBIehw2EV3czqZvAd5rSOWX3TASxQT5NkheU5kkOHMKU
	 yYLv0uwAVrPRJtZhAVZ+QA8JQS4Z2Iaz0pmbw8Uyag/FOyEIrkIbAIsv+mm4eri9Ltc5N
	 mW3h+pPkxQrgUUQoMxaTysoG5dTVABQTem+DiP1bUYOV6ELi5bbf+vZj29ZrMWVIQew==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782389283;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=ImGhuAm8LXHJ1Pjdu2Lzk693zcYt4CwtZnY4Qbbd+l8=;
	b=RXODDzSCxzLEInsksAXo5ABhQjrVEKx5BsTIxmV7LBpYBzUYqMqWbhHGWJI/WEPkvWw6
	 k9Fx4NzpUZR0kh2tv3IEJfFtoj0gCySml1zG8BZcij8HBcF+t9H5pYR1/yq5tbbYxV/hi
	 /RO2oDigshpVMp5a9OpadTxmgM9MZqgym2ydPIWV05DmaMmvv26fCTOFy/kaW3hQR4jM7
	 T5Hg9htQ0FqEKMh3PG1wiqOr8zIJ813IVcVLUHGzA4+Rzp1WjzuckPMnEtK6Ii5pcur1v
	 Kw6WXEJQGOhiYEdlPGZjQipvqHm04cS9bUtsDdSncUnJVFdADxgcUUo+1be4fBBbSjw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=mF1dCMXW;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=JKH9oOWp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3A8E1F80217
	for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2026 14:08:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A8E1F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=mF1dCMXW;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=JKH9oOWp
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P70cjW2010049;
	Thu, 25 Jun 2026 07:07:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=IRyqOXevqtUS+gvT
	aZ+03/GG1+xz47TaxxLFr4xC14M=; b=mF1dCMXWB/K4ALxAxswMMn23GlLlG1BG
	CR0FxzB4eJE0QRUS5qfYyp4XXd648/5sC9ntadPCdLJ7eSn5so9tXFcCJOpfrVMa
	D9HFKRvQi7esR6Vdw33aVlwdO9T5gBmJaNHAuoQx3AB//OaqQ399iaeMf26WkHbA
	Ev1vHQynjWFZbWfk2hrHcYb8pfJrNrgFAlWWr/c4125NGR24YWnLpOwNKdPFNb5b
	a0MS5lUH06OLKb+U/dy06U4EoEMfX9Svsp7ezlLjP/V45V1wGBXroIk1zgA+brK1
	fYJMLmYh08fyYQ7RbM1kPOxglgVkj/UE4dwAiMmYgRYKpC+AemYKoA==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11023105.outbound.protection.outlook.com
 [40.107.201.105])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4ewq9jpk77-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 07:07:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4KTolOWCeK1HRK82x0ZwbHj0RmW2rGnFi5YHUIgy2Xc9De/WY00ehC34ZqDItUZSAEtXip8C8ih2iQxWm95QgejxuqQk8P4VbKAE4bgHe/BHDv/gDSuc9qc2M0syRxAQua5qTTVmpFLtQh5iAK5vtpPCUMR75YTi+yE27pTHY9SMp+TMAss7n+uxog2P9o63o9g9v7DCgXjbnDG/UnLQOY/emoH6cTW6+gHZszWPP2FWDWKO4g0EtQQKHviSwRCv8w5gJgwWpNGFuxpLeKOqmbSReielKxPEF+iyDskwi4EnUM5nsTMnDBoA+DPHOhRyqHYuSa2S0NiHr1u3xnBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRyqOXevqtUS+gvTaZ+03/GG1+xz47TaxxLFr4xC14M=;
 b=H+l2BF8fGFQzjQSjycL539gjsulim+2l3FpHZRCxFnphvXOOvdNZSEyzR5oqPt7s1KD6Ip+QbbPz/5R1jppg8BaP7Cr0cueCgR6YgEOQmnX9DeuC/Tf33Bq8zpEydK/87L/lYdYRoEzDq3TWwXn34t8jQr+OOD45Nt3IyeXjRuQV4dJbXDp667dXzoOzRpRAJE1pEHByYrAt4V40TalnjOmW97dhPny0HaTo4XJL27f6vDYOV+pCsaWvm6RgggVTkqUFdQ+1jFBzGURtZteWZC3djDiBo3d5ALLHLu7ZoOdSJblVH1aSiuSdBGd/hTBDiSIl9k/43PDNY4DEHWqZ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRyqOXevqtUS+gvTaZ+03/GG1+xz47TaxxLFr4xC14M=;
 b=JKH9oOWpouvUYkcVZ9t+OlhA7MzuR8bh/gByerNlCJJCVyLvgto2Om7b1rmxC5rCInYcMabvtscptaav3zT2/H9f1uiDfY4SzmoX7GftTQ9IR/BvP+HGEEwuKjXikgw+sJ+6xpt4ij8ABuaxBmnr+w1Pb9jBW/Y+BSxP1PaO07M=
Received: from SN7PR04CA0190.namprd04.prod.outlook.com (2603:10b6:806:126::15)
 by BY1PR19MB7750.namprd19.prod.outlook.com (2603:10b6:a03:531::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Thu, 25 Jun
 2026 12:07:54 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:126:cafe::9f) by SN7PR04CA0190.outlook.office365.com
 (2603:10b6:806:126::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Thu,
 25 Jun 2026 12:07:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Thu, 25 Jun 2026 12:07:52 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3B815406541;
	Thu, 25 Jun 2026 12:07:51 +0000 (UTC)
Received: from ediswws03.ad.cirrus.com (ediswws03.ad.cirrus.com
 [198.90.251.35])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 226CE82254D;
	Thu, 25 Jun 2026 12:07:51 +0000 (UTC)
From: Maciej Strozek <mstrozek@opensource.cirrus.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Maciej Strozek <mstrozek@opensource.cirrus.com>
Subject: [PATCH RESEND v4 1/2] ALSA: control: tidy up whitespaces
Date: Thu, 25 Jun 2026 13:07:40 +0100
Message-ID: <20260625120741.3404473-1-mstrozek@opensource.cirrus.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|BY1PR19MB7750:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 484c65fa-49da-444d-fbe1-08ded2b26233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|61400799027|18002099003|16102099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	YcDbFZyjMGRV/jEREqo8W7ivaCWK2bfPoXiXHFe9p7h2iE09YFLLNsH1ZV4rADt8LeS0wlSlWkqzMJyhSsanRRBrmi8OL0Z3VkL3sPUGasrliKmX/398TiYp3xV+ItCRjd6XDWDTEiZyRWAfw4pGtyH3lHxIcepj4ewQ1QAu/coKqJm6DAfnyKfGQL/vgvvA2YYZo9svHvVYsuz92iQI9sjfIA202xkn7OG+7j9OPXIC/IxgW4g+lcfut6Ig5eYQoQbgK/OtkiOXV87CsR1cjGUdIZ9mgBhf3mpcYON6C0As/ITpHeVsYYHtab6o2KayNW24RE5mbBJpnkx8Y3QqViSp3EQfFnoch2E//c0Ig9eqVsyoO2h/DLd1DGebRBXVeOb6+lUQ3ndFSNDRIaxcWM1h2ZGglHcM3/wd4N+G5pt7bL3iD6WXhSPVfcy/dll1R0dmJBqkEC/Z0mnN0F+B69B8SLgIVXsPc9VsTDqE9x5WTcGc31MQK+j/XoCKp4oaulF5n/9r/EeVMZLwDDTfdN+U5Myy/dvMopRSRR7mIIq2O1VcIErZq2lr6orIU+uRrXzv91YYvzqCoYq5oX1AIKpQPyN299FVPhm5MaqIyUTBDXQS70jP18WmOEozFoQW6oGupVuOdOuxvm0TK33U6Cuf06lZOE7nMnwoRPNWOjhqxw0xt150LzeZx374BCW8tZIjWfErpkqjGXt0E1lEng==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(61400799027)(18002099003)(16102099003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qKWVKEMdSDlUwYXFknkdF5W7iUlrRjvRGmg4868qiq205AFxL5YOcV5rgn7F7uFLPvqgVK82hRDLSa7o0IKsLBmJDJIUcB8TXwPl9Cs63c0oONkOrA00GeEiVN1GDpzea9xCvQAr+xXYwm6a68enTdCPzcm1aHWP2SMFNNhaRf0hSAuBrILGQJ1Q30Iah6ZCfsY2vEGs0q2fsgfKayrYlh9T6j14OHgHvMQcHt2Wdc0kTgNAzdEyhrJDTGOb0kc6SLC2rf9c/8Uua3PrqDPLpLMqUQp1Q+59e9pG0XcxSB4acp+txG0YMiwvzjeJtQ94YsBKuViQr6q6KJ5i8ShA40w0LtwBkWf/e8Jgx56pmeC6TfqzP8mh+zr4RIMIlE6LEB6ewRXx3NhPWhI1qZdepl6NjUUnQr5skCi0UoMEDiu7u5m/RAq3uLjBV05HS3Cx
X-Exchange-RoutingPolicyChecked: 
	OMN+xd/NIkoNPZqqBSJRNyyXM4m6kiNjrpe+EWZI/F+/f9KWPzc8mbDLgQuiG/bfbfkdXMfVRJBE1iY4xXbPtMnTV/3TH2JC3d9aCpXPM6h+VTi5ieGK+Hqf91UFTNI0RBKDT+xpDiSYrasML6YMxG2h1tt9tcKZ90v3YST9aUS4ej9hRCoE9urmVvWOIkSLPArIAcItAV1K++OEEwdsy6eUK2DTk2UKQ0n8ilF1dV1BTXuwOOUrFj+NQfY0LDtYya66EbXk3TxXKqfOMw+jPq20Da6KY12XTIwRNrCC/hjhypY7fG2gTv2Rzlnmt4bE2eiozoinIxEJoE69oe9Cig==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 12:07:52.3973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 484c65fa-49da-444d-fbe1-08ded2b26233
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR19MB7750
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEwNCBTYWx0ZWRfX9kmxDDz0UNkm
 C/D/gNsMimGLjFrOUNIqzQ7+PN0tskjNFl6J43zNIvV/BZmYJrVXal7yYvG4tFNQgt3uX4iWViz
 Rm1irDR+EJ7SkEniyqtlGXQiMkr6DyFwSsec340PhorjwjZS2w2D8q+D2S4mWiRRze/b6Jigtpn
 vgcffWGpwB8e5tchUM953QlsCqCUhrSy+VHJ/Cb7nh4VI8fhFWYGvpV8hknVWZUhl2up5B4gTV1
 9JWw+yyl8WxnGr3kvCoyM5gqKCXDY7O5NS0+lBZUiVScvgnIWtm4Zhh0NZLe1GUC2i7xZ3c6+sd
 ynri3GBGIKLS5jbyB3FmU3UxIC0obtsthUTdcH1w6EF8pjd8oDPwl2OStwtYUMvtcipJsgjtASo
 tpgx2GU0ISHrs2kaCIN0iRHjpzM+liVzOa5Hwu/9s4DtW2HVO3PDmu9jYNTqEmII2gCzKiJrH5v
 GLTuURMvsr/CpnqMCnA==
X-Proofpoint-ORIG-GUID: lNZJk_-RqB3M0AhxPK3so5dC5tQ0WLRV
X-Authority-Analysis: v=2.4 cv=SajHsPRu c=1 sm=1 tr=0 ts=6a3d1a1e cx=c_pps
 a=mXWPUgXNGD4LDRIkHGcDmw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=w1d2syhTAAAA:8 a=UOLwL_aBn4USr_LkpIIA:9
X-Proofpoint-GUID: lNZJk_-RqB3M0AhxPK3so5dC5tQ0WLRV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEwNCBTYWx0ZWRfXzdr4gXddXVdk
 p2lpuxDVNPU2yEfLsv6t8RoahoQoF7UMFxYuc+sCKDLMJxnLwsF8bn2nPt9e6RaWrdtEtWYyvt0
 8ZhFlRrFbxHAy4f5jmH2RPEeeRth+2Q=
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: LJKR42SYCOWVXUF7SE3R2RJNAYRCCA4K
X-Message-ID-Hash: LJKR42SYCOWVXUF7SE3R2RJNAYRCCA4K
X-MailFrom: prvs=763683fa41=mstrozek@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LJKR42SYCOWVXUF7SE3R2RJNAYRCCA4K/>
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

