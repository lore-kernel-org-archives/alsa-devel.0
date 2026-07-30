Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422BCC54FDF
	for <alsa-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:43:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45E6260201;
	Thu, 30 Jul 2026 10:43:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45E6260201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785401011;
	bh=eizZOL2qK7HyNVmrBP8+KCfKjWI03Ljf4bMPGc2BoJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=nTgY/DaaPE+7YHjGOlbXCN7HBkSNJBRA2u3KuWr1RAT98UEU0+QmNL0OjPzJ5YNPF
	 YqvH4pAQsqt1KyXWrGlaay0pvuETUrO03GOR8jwDDgXTW29x4PhEa9n32q87ErBPzh
	 OFT2rGmS6Rkl4mUjvqMtJBYz3oVxWsMAx7z3xacM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E5FBAF805FD; Thu, 30 Jul 2026 10:42:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EDCDF805EE;
	Thu, 30 Jul 2026 10:42:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B5A92F80496; Thu, 30 Jul 2026 10:42:44 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785400960;
	b=Tog5XQi8bU51SApZoO7k454oBPZ6SzqRfQZ1H4tfOEvwM/8118GErkgyXXG9b9DaAesf
	 /hV7Bhuc5DxzTvaIP5BcvLaw8TecVd3KT72VHfQhbzG1fyM+CqSoNsB/+MdW70BTUtOSH
	 psYbSvjNUxgIoUNPOhEj+VzRu1+Vq5Fli9UqjvrbRrL8d50LBYvoWx8sTn97YaOeqGP+t
	 qwjYfO0lBkqwS76wGskq5fptzV5uWgxEmP9DqhoqBeD6yNgF/mSKFVP0pm1zvRskdc60e
	 JJjKPqWCNCcaheTiGj63vq60SPuGyOyfN7bbUqD4XUtK6edYOudEp4ztQv8FC/Kkp+w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785400960;
	h=DKIM-Signature:DKIM-Signature:Date:From:To:Subject:Message-ID:
	 MIME-Version;
	bh=eizZOL2qK7HyNVmrBP8+KCfKjWI03Ljf4bMPGc2BoJw=;
	b=Aj7cDreYkUEjHP9esz1bg4Ir+wBHGCd/xBRbzklcPGtNAigOvW2HZ5q47Gn2jfODf8JO
	 xsqHjhxaveaUx247AqU6L9spyxa4ypeDjDcLCi/LQEwh4l9J7Iup4sb3yKW/4TPq3AF79
	 MVvK1gBSb87/jT0DpVnTsiKOqqwoPs0SC9yE0kvA3ZRHV3+5lvuLvqfehyc4TJRP3X8n4
	 ef9Z4WHAMQ1KySgFTBv6/2zcIpoCdWYtwbDEfTh+jNJVotzkSNkm508/4eGRODPa/gH3m
	 HnYbzMmB5SAV9en9FQ5CH07mNuqO0MS/22xxp17+5vkDBT7txMD7iuyMwv9qAoiX4VA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=YJ8a02pG;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=DeBLAkus;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 37C78F800F3
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 10:42:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37C78F800F3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=YJ8a02pG;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=DeBLAkus
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U8fMsq2331935;
	Thu, 30 Jul 2026 03:42:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=uUcpayayXLNenpufAr
	GEFiKLmDaZ0RvSFTy6X/7l+2Y=; b=YJ8a02pGaCz4V1ImrxQlpWU6FkEkFHRxD0
	7J9Pxn3fBXT3B5FpJY8uL4xKbhYr3MHn8FjsjgEzb/Obz54JT8qb3BqrhoQi4LKu
	L60HaG9QdizXXBNp2VE64mcOjfemWXVsSZzRcDEnBt8U0BT4QCVFkUWvkNoutJW2
	71gqL7JjD/6RX4t08GmjuTYprBbTrcln/8NXPoXyWOYhpFvpMhdDHxVJuyZn3S2U
	KIh7wFs+y6f6WMc9BR2Pssx0ZysToPYcDA6Pqs8LpK+ZVpGhjijFbagqTeG4OVWo
	XbDDHF/jIwS6KD1ILHWJXwbKRQZTzMAZBAHsrPrV8Bg8wPHHd03Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021127.outbound.protection.outlook.com [52.101.57.127])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fr3ah001q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 03:42:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLQpwa/Lp5un7DxoQPzye6pI3SWgfPY1e37qKKBUgT1ncZdElmC0mUXAp2v3xzLMm2Le0sMQbautf3AH4G3JZyVIP/UDIHAqPmfImP2NUn7Aewdq4mUSSU5nqhV4P49pITKvQu9ASXQC9om6LENX5L89A4NHkpyMVQldFxcIwX8Zhn3244MJPoT8GvqUpGPI9rzfK8fTgfga9h0aGfuZwOCaQLQUnsqcv8+RiMAo1uly/cYM8nQnLeP1EsvQiOkWCuN8BNWE0/DET0a8dj4p3EPTsRN+UxWJ8WO3HiW7txG9nYaxbaBSd9d115ilceUWRRr7K0CkFPJ0sJ2ovSUBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUcpayayXLNenpufArGEFiKLmDaZ0RvSFTy6X/7l+2Y=;
 b=tEsTRqz6NqzRnE5569q9nIyZH0MrHizyE9hSfpaE2r9phQDE1JtHsbBMJEq/3CAi7VGSEWBL+jkMYABTTLCNZqbls5ua+bohVT3Z1eyU0beGTumAiAHGgfDo5Cg23QlySMleA6a6FBzkvscRQrggiOKVHAAYnEYVXml0hdBqDnF79JN/bKyasD+IFMjR48bVJT9hbXcYWYvPMIpi1n5YzlpMTwbTBv9t34xb7byD3ABDRjMnMQtZbYmXbtVwYXR4CU+29BU92o7Qmn35mUfh81sRFOycVpf/GkmacjK5WhvyKjrEdtSWRwqtumOSLZD90TgWAM+iZDTW3yV6rK4H0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUcpayayXLNenpufArGEFiKLmDaZ0RvSFTy6X/7l+2Y=;
 b=DeBLAkusdYw0PTI/jsFClrMVh2neJfepqTp5rdaNDqKRRnzRVPM9WAd07PhawKh1llPP4bWTMEPLlBYY/NQ/yVdbeMjENinD8L1J4rf6dP03+m2rsEmNwpYEDeT2zmlu0aHm5ZKwSEEiLPnWYPL/v0Fm+80j0wqHYEcCL3R3TqM=
Received: from MW3PR05CA0025.namprd05.prod.outlook.com (2603:10b6:303:2b::30)
 by MN0PR19MB6285.namprd19.prod.outlook.com (2603:10b6:208:3c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 08:40:23 +0000
Received: from MWH0EPF000A672E.namprd04.prod.outlook.com
 (2603:10b6:303:2b:cafe::66) by MW3PR05CA0025.outlook.office365.com
 (2603:10b6:303:2b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Thu, 30
 Jul 2026 08:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 MWH0EPF000A672E.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Thu, 30 Jul 2026 08:40:21 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 47B58406542;
	Thu, 30 Jul 2026 08:40:20 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2184F82025A;
	Thu, 30 Jul 2026 08:40:20 +0000 (UTC)
Date: Thu, 30 Jul 2026 09:40:18 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] mfd: cs42l43: cancel boot work during remove
Message-ID: <amsN8vJB+96MI6b+@opensource.cirrus.com>
References: <20260728065556.1508-1-getshell@seu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728065556.1508-1-getshell@seu.edu.cn>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672E:EE_|MN0PR19MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ce550b-0dfa-4edc-f04c-08deee163167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|61400799027|82310400026|376014|36860700016|16102099003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	xoEBDn+8h17qZNOWhlmhRGPMCiafrJPskvSMJofokuc45M/IP/xSkNOaFYY1x7hN5t5sTzYWIf2ccPgJ8tB32fWa1Ls6vzxcF/j5pQSNvATiKw9uk39k73Fj9NzlU4avM2tZOUH2Nn3gXVCYgneKOikAQi2tnv+MBKUKoIXIIhd9eWRBvCeGgmtPuoxY9htWC2CjS3yPHo+gGWrCxWK1rqNV2of+8mri69Fzk7Muc8wK3nKKMta04Z7Xe3o+xP0zSTS8qcP3W6fVyhKhfjiZQFNQJ658AV9u05Stp2g56vKkBEAvdiVDP762Kt1p1TFdwBgW/xEmEI/V//bPQjSU7WuSz/pKVDcfEKnA9udjkCGjutoe7y7C4rGMGKrjFGhkx8qHUON/jLJWG5uo4U6MXgL0HyAyjij3Sabbkl92yPa7hSGfeglm+aj2g1+cwHK7bEfWmOufUegULhvL9MjoaeFYOI3y0jvS6YIiKPgxz0CXTLa1dR+CF6TdUMtOlw0JVgXYZoNCAz1EGyGs2KoqG5kAUKZcebeNaFb8NSu2BqdlDdFzrMY0eXjqvf8csJyCKjMAZ/+5QPweMkvQJqskwwrUFp3+V/7NLoj0UBkJaV5ICpSqGI4XEsWiqaZD9vWSxaQb4HIaohST1BcKC6aIZxE7JExODKu21lMY9HhClLaPegxM/R2ZxLZl25us0KaOW11aN/45TByO9Hu+CgQIuw==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(61400799027)(82310400026)(376014)(36860700016)(16102099003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	xLa4yOJWxFwwGl5GJ3dAHdDDPdjU8t24XHU8TRvGd6dIdKicU9CVdfbcFS+Q5eRHivvODLBVjh6GLlNLT86diNjkSLWRztVl6ERm9PZRZf3/xI/h0dStpl3JgM/nJweyusHiBCXz6O3l4OKCBiWN0sfDB4xQIGAfBrQT7/RR+3gsFz6O6LTHaNrlr86q5sxnhr4qffO9jQSpCciDkJ+euJX1PeoNkJ/colP4BQEGcSYwKBFs1roOopAz0RSP7dMWKR5fFN+FWkY68+0uSuEgSOSzNivTwivKc5zeUSBLJWQncrHjfGhyclj/thlJaXBVWXGkI8ddl0MVI6z2n/R7rR+Edt31ja/nCpWmD9RIdO8EgnefcGe8ChMufy7AfDdYdP3JuCoHz3HFdmdz8ebrtXVXGWhU9bf04GHB+mVguR1zqheDt+bFG9aKg2IFzqYm
X-Exchange-RoutingPolicyChecked: 
	CCYkm2Jrbpw0VRtFAL/yglj+6xnsw+w/5hNvGNtGn/Gqc7bjbPb3MQNBZ2oW2m1nYMRjxGBFF3Zbm4JeJrK/Aff5tLle93QpUFDOy/kDjJ689lTAHxXaUM4iE2AUiAenYbyWRufRupDM2xbPPaPcyWOF5v3I3ZULLK5AMnDNMFn2iEg6+4vTJhl9mGjJLo1by3Tkmw9ljtU2rdy5G/u9EBnX+LwhCfljMGr7AChM+ON4Kx2CRxwxeYxZ7XrSQJNojNh9chEykg6EtAMeFgGbiOAKu07DQEaRL1bU/DYQMvtPT8vd4eLtz3hnQmhxXGCbxXilNmG+PEnnv5ZrFiplCA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 08:40:21.5589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 82ce550b-0dfa-4edc-f04c-08deee163167
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-MWH0EPF000A672E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR19MB6285
X-Proofpoint-ORIG-GUID: i6YwNEUKg58aBjsCoU8Zlz0EF7lqszGV
X-Proofpoint-GUID: i6YwNEUKg58aBjsCoU8Zlz0EF7lqszGV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA2MiBTYWx0ZWRfX2yeRmDWr4UNc
 JMi7/cAuQ/9EF+J7FAs9T2qoErFf/k9fYnZs7NL92MsKVqLnoPyNu4Qyv2MknZPTQzxf/Ql0WNv
 QdEnFOo3kLNRWVOCr0mDy9knG/Yo3A4=
X-Authority-Analysis: v=2.4 cv=daewG3Xe c=1 sm=1 tr=0 ts=6a6b0e7b cx=c_pps
 a=xvWGx4l5kSAHGoio3+sB9Q==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=sf6qQw_CFoJwOYdCUokA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA2MiBTYWx0ZWRfX951bM88m4DHp
 3IHn10/ILAj1as3dFooVoQ0jqf3tIc4RLskq6EKdgWRmsiY2QkIQGaET8NOFJQ/38/Zbt+c2qNj
 b2rSJt7MSQ9A31zuD6TemTqi+00W/SkmsA01BunwJJXrlIlYnPEAZXYGy+FU2tfnl+fkTTGtlBS
 KKHzjxrbPp+rYmd5P4lyN4X3icWj6uwswtR+A/BHFkk7wJTNc8ykCpis6JKyS1dR5JqbiPc0GAK
 i+23pYkj2mGP2GxtEjfWv6S0XKrIfHXRsggYavzHDL4Mib+mFilf4J39HmE9g2ChtUF3qGabsPY
 bdQrz4qn+LTpdrI9MMzp3r/dHyvPZUlQ6YjY9Dmv3Yy2uGXjE0tFDIWt41PI0jccHzX0jj5oKVj
 PRNTDDrsY9f4CrzAM3bEk22BUEFf2Icxi0sxEVIj1Jdy0nHr2YNXt1IhbnKlvYEYPBjIvGGdMTR
 NFS9TFYLc6vdhjPNv0w==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: YWF2K73HVDNCBQBSYR3WL56OYIOD36DS
X-Message-ID-Hash: YWF2K73HVDNCBQBSYR3WL56OYIOD36DS
X-MailFrom: prvs=96716a7d46=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YWF2K73HVDNCBQBSYR3WL56OYIOD36DS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Tue, Jul 28, 2026 at 02:55:56PM +0800, Hongyan Xu wrote:
> Probe queues boot_work on system_long_wq, but both transport remove
> callbacks release the devm-allocated CS42L43 data without waiting for it.
> 
> Cancel the work before powering the device down. Balance the runtime-PM
> reference when pending work is cancelled, and have the worker call the
> power-down helper directly on error to avoid cancelling itself.
> 
> This issue was found by a static analysis tool.
> 
> Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> ---
>  drivers/mfd/cs42l43.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
> index 7b6d07c..411566e 100644
> --- a/drivers/mfd/cs42l43.c
> +++ b/drivers/mfd/cs42l43.c
> @@ -868,6 +868,8 @@ static int cs42l43_irq_config(struct cs42l43 *cs42l43)
>  	return 0;
>  }
>  
> +static int cs42l43_power_down(struct cs42l43 *cs42l43);
> +
>  static void cs42l43_boot_work(struct work_struct *work)
>  {
>  	struct cs42l43 *cs42l43 = container_of(work, struct cs42l43, boot_work);
> @@ -937,7 +939,7 @@ static void cs42l43_boot_work(struct work_struct *work)
>  
>  err:
>  	pm_runtime_put_sync(cs42l43->dev);
> -	cs42l43_dev_remove(cs42l43);
> +	cs42l43_power_down(cs42l43);
>  }
>  
>  static int cs42l43_power_up(struct cs42l43 *cs42l43)
> @@ -1069,6 +1071,8 @@ EXPORT_SYMBOL_NS_GPL(cs42l43_dev_probe, MFD_CS42L43);
>  
>  void cs42l43_dev_remove(struct cs42l43 *cs42l43)
>  {
> +	if (cancel_work_sync(&cs42l43->boot_work))
> +		pm_runtime_put_noidle(cs42l43->dev);
>  	cs42l43_power_down(cs42l43);
>  }

This looks like it is based off a very old kernel, this was
already fixed back in October 2024. Please make sure to rebase
your submissions on ideally the maintainers tree, but at a
minimum Linus's tree.

Thanks,
Charles
