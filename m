Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137B0C4450A
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2026 11:33:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57D08601F1;
	Thu, 16 Jul 2026 13:33:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57D08601F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784201598;
	bh=ck5nhgrNEtCKPPzzZs3KGOVB4o07NAjDT20uZXJASJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aA7wVav4ii9PI4+AtpQEgrCizD3Y1xQZj0m8nzllkOceh9DbIwr7hzl7/BxkPmphr
	 SGHr9PzQsRXklHnzTBBFObJbWR7KyUI9VEymAT82GOPlhbqUD9VQ/phWgoZsHz0hWY
	 XSpJ7eksgerfGbBdK/b3JDzFGs/cC9/56siNpajA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4849EF805F7; Thu, 16 Jul 2026 13:32:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 135AAF80602;
	Thu, 16 Jul 2026 13:32:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE7F4F80527; Thu, 16 Jul 2026 13:32:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784201556;
	b=ceAbHskNEKbU1EvDUxujDeRESjelSNgsCy7JKKdw4GpLryz4rrIfeUM8w8tGD9/L8Hi8
	 bPEt5YCeBPz7AqY0LrT8VcKw422Nu1erTew0Ic6V0KCaROSh+bPgnQa89DhaVwWV3Xzz2
	 BGdxsPXM1oZwwp0SmCSDjK0MgERYV925v/E3B/G3uqu+U4Dhd8xdHzTGD/bYPpPipAMG2
	 mFngRuqO96vZykjrFzBnlDHkvF6qUNSU479piUq8yIvK/ptoOYhIcjuLIx5OZI/2as/yw
	 WdE6hN9vStUpUywU2rq7on/HJ5jFvdIjYGRJhTe3sTOPhU+lzwMVlYJ8OZ/xVbT03Mg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784201556;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=ck5nhgrNEtCKPPzzZs3KGOVB4o07NAjDT20uZXJASJc=;
	b=C7LwriRfEmwYPLZe7K1049XHFfrSygg4rKXMqLMhsnBIiNWosqojjeVrC1GjgPGmf/WN
	 VWyR89em0y2VzxoSykLYqJf8WUnFCyhQlCyZG+tunWlPxuVIX1rJRwK/4mR6XVG+PhM8Z
	 jzgFt5hbX3JlY1LVZbDZJ6z4iozk5+Y87/4gn8CBwwQ9SUAkPPkPcf0RNTfXmYnYiGvVx
	 FvYVSX5e4688/9NwuEP+E8For/JoTQhsjJoIR5+/LPnl0RxMbUiCXAdq6wYQZh1AhrGSn
	 EqpMJTXsNCHIdV7iOzYLciae0qImGMhVqAP/25Dqf0a5y2BlPH3U/5y02BAL1AA0UJA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=TevE9gO4;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=CNFTTzGz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 97730F8051E
	for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2026 13:32:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97730F8051E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=TevE9gO4;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=CNFTTzGz
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66G5NiIP191002;
	Thu, 16 Jul 2026 06:32:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=AYV9HA8x9ZnpckPaQx
	Em6ZpHOD0jFRwC8ZXzna1hxm8=; b=TevE9gO4NvJFy4OfYgZujT5iKrwSk3n0dV
	VDRBnS2gAKVtjTznLlWBLVZjvWSWnsC9DTNWTp4AQGU2H9Tj9/0N+J2IfPqcoKgq
	WdCr1kQOaCqY5G7Efr/g0MW8N9/5hNyGNpYMsTYIHY1CRAa1kKY6UGAI2fMqm0wH
	14J+52zR+p38Yu3MT8aKpjxUZpuGkkth3vZTYHmec/wuupR/rtI1J5ngX2UWGPHy
	ouuy/DXH9gu0wc21bbKEAb1P3sbF9Kh5afw0NRHUGOEIXrg1G2F+ocFuvHy61G4N
	sppG4JEW4zyxva0gVPB8nFhkTwFvGv2yT5BuKBmMoIMmux3zPSgA==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11022085.outbound.protection.outlook.com [52.101.48.85])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fbj8fq2fh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Jul 2026 06:32:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kf2Z6+4ryhPpA0Y2DdpxWv32M5wWydnnLjEnbwM2wYJmyh5OVUE/IdjZhRJUlmiv8oCtw1l2p2t4ky3pNolyUDTStdF6F76J2/JVXTfSEInJlRV8iNiV506o4h4GRYDuTsCt7CJxqu6mc9bfZ1zQp0TQDj2QNlmySyLMqapyiN/CDrdhvvJVpvg2UrBbhM8Ip2DKIXV8APXZ0LkzJDEIuxUkBRFChNxqukrdi+Xd8JFDDHZnARHoxZW475O9r5CJ5EaInpySGR18AUbJafb2TicOOdEPgaHCS/KPK3P/U1zGKng3pjGngqT5MRNF+TrmbH/eKyBjL75kvmimUGxfgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYV9HA8x9ZnpckPaQxEm6ZpHOD0jFRwC8ZXzna1hxm8=;
 b=Y3mI32RMdTmDiybUE5TkHdDTd7nx3Q4ew8jJbdq3KQn8yoVpjfKPEZqaeWXXmvrVbg6MekqibLBMlEAi5HwQytoZ7UgpJUaVZKpEbGXp/t3vgkhKf+AR2aUf7QJavZRzgKp/GnC7260KG/dT6t4QNusQi2mKUaZ/Dq8RZm/OtQsXAr4HZvI8NdqzDOrG1CZL/XH15EhuJzszyryMbD8rg5fRG04VwvGJa5Rhge+w3LmHTbD/tUkOlnTyh1r1GbOakN7Q8nBimKkIAUDGgnSzC7xnnqI8FBxthd2EEQ+9KlJ43UHMmOf8ekRHIocZchM5XJBFKuOBTzxQ1tyT4qpegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AYV9HA8x9ZnpckPaQxEm6ZpHOD0jFRwC8ZXzna1hxm8=;
 b=CNFTTzGzfaFHO+ztptve/gQSTI/Rk9O63FHYopn8Z9nxa2ik4+aN8MPKCrD+aKLsk2fKn88ywLgpHNTCijZKZ5080eudt2+QdcGC+jEsO+3UM9dL6CqRWH2g6hyvqw1cVcli4GqlKyXaU+xL52QaPRwqs48uNyoWkQ9gGXVVUR4=
Received: from BN9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::18)
 by SJ0PR19MB6840.namprd19.prod.outlook.com (2603:10b6:a03:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 11:32:28 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::a1) by BN9P223CA0013.outlook.office365.com
 (2603:10b6:408:10b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 11:32:28 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 11:32:27 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 867F2406543;
	Thu, 16 Jul 2026 11:32:26 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 77F5F820244;
	Thu, 16 Jul 2026 11:32:26 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------uiWAg02dM007x2p93ekG57xq"
Message-ID: <6ba76470-9329-42e8-8418-a7578446db9e@opensource.cirrus.com>
Date: Thu, 16 Jul 2026 12:32:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION_7=2E2-rc3=5D_ASoC=3A_cs35l56=3A_compo?=
 =?UTF-8?Q?nent_probe_waits_for_an_init=5Fcompletion_that_cannot_be_signalle?=
 =?UTF-8?Q?d_until_the_wait_ends_=E2=80=94_whole_sof=5Fsdw_card_fails?=
To: "Salman S. Tahir" <salman.abusaad@gmail.com>
Cc: patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        alsa-devel@alsa-project.org
References: <1bb9628e-3c3b-4b43-906b-0f5bc2f6e4d5@opensource.cirrus.com>
 <c730789d-2a46-4fe7-ba98-fab990361e90@gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <c730789d-2a46-4fe7-ba98-fab990361e90@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|SJ0PR19MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: bceaaa53-f13c-4695-d2db-08dee32dea2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|61400799027|6049299003|36860700016|376014|4053099003|4143699003|56012099006|5023799004|11063799006|22082099003|18002099003|10067099003|16102099003;
X-Microsoft-Antispam-Message-Info: 
	oZVPdhjsYZnRgJTa5JxNUpAQ2c4EaDnFBokZV38GgbvACQ7mBbfxaVCDrxzuqEOVX22Z7ng3t9YXNa8EZwIWIrt7L4hZe0sGJR1fC+Tuaq4IYRqhQ6T49uCdZ2Jqa+BWCqBQbhFjJUY+ZbyKwpL6crqSenHgSmIYvP2UpM90gAgtU/bzujtcAaolZpvTg3/bhRSNIStkVRaCkMKpEWCfkqcGnT1bPNQSYHNVCWflun+aTeGN1or1Ia5Ld72nkak9JFWc9JWDIjzeekekpejy/KlVPfE0W8n6q7NJBzXkjrt2X3kzTE1aJYTGU6ntEOhSL4wAz2rT0PU5lPJWI4JpGSteLQi/J5sKPaB2+dQHfLg7fZjXQEaxqGxzKyzA6xF2gwUV735iARsavgzMGlPk3dHkY6DXFwCC0o8Y0lkATvQkugh1mtHaXVP6A7UwmVcMBj3KHrkKA39aJSZB9QkmgcKqDn7tMP5iqfpWAaVTl0J14iMeGegCoL9QDK3GxqK7FWJ5oVL5ZgFp/MXTxFp6eHJmPL16pSebrVOI3UAhyKtb40YlQFXEyM62+8TROkFcNKNeLIlZSEUxsdhMTrEvV7tyOoqP4cn2YbWbuZvkrw3oPdhdtN4yvyHDfDm2Q2BQ88JI/VKXa6lIaAnt0TE8ZbjHPPqWJyKSR1frxzKTybO8G1Zkv8x3vQzDr3XJ24I66aVVpkBTz6n7L5IyX4T8Aw==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(61400799027)(6049299003)(36860700016)(376014)(4053099003)(4143699003)(56012099006)(5023799004)(11063799006)(22082099003)(18002099003)(10067099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	n017B5cFdeDNsf0UkWB4axOW80kwuJaEX5FSbjrRTWg/vgLF5RdBPBNZDge2FUUA/jgYM4Yn+cWuWUTj90ebNkzEElghJbkrEIWgZntpAZv/BV1+A3fbBZ+QdpNImtoKR0oCmHtw5T9BBZFDvf3M1iR35ssxEBaQwHj1/uqa6VEt7AkSoT3v4FbPQjp0ZwGLYnSUfTHbKtSjxbwdH5kS/BeeSJ1SeYf6DzRYpWFgcoC6TLnOANT9fRRP+O7ZmoY252LXU5ac8YebKaHXNASxMpERpgBxkVhgWNIwPvdF4yUUfsUHAc9K9NveTTZoXfvZTFlkwr5QL8U7IB40tlT3rlNGFERiYl3QWlnQxu/IhMBS63jx7BrEP/2OCoWvsh0DoXn2SMzQyjn0FzC6FlqV0VC6GRj04L050z+ikB8P0Nrg+u0o8xxHIwawT9hjkve/
X-Exchange-RoutingPolicyChecked: 
	mvqCB+lbCBFx/BhXP+p97Hy/6mfN/4LA1kvUTrhekHhvROrPBvOUMRDgSanhtRTmPFCaKUo66mFD8SMkarRLwDiG35TFZ8004JQnAYG3gs9ibdjG8QLHXphcBzG1LqxfBJaJFp6ML8Fn1l4G+9kUpETG6OmqAp/JVMoUeirwrIQH8JCRpJpr+sZMy3xN+KghblAtetQebqfhBg4a99JOqlHcOQc8nBadr2PkgeegIlqDfxPFHgPseXHhsdsjYN3t0QVl9wF7XauK/0oQPWeQ5QqCYzEpRSaBvLkawmA2D2TzC1zLL2nZot57kgTNz1k8hjyMGV+t0HsGLtoUYB649w==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 11:32:27.2979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bceaaa53-f13c-4695-d2db-08dee32dea2d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB6840
X-Proofpoint-GUID: U1hvKrmq3jRAaIcX_V461cePtrthpxWs
X-Proofpoint-ORIG-GUID: U1hvKrmq3jRAaIcX_V461cePtrthpxWs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDExOSBTYWx0ZWRfXw3+HpyhBD2AM
 Nm4tSkBAqGBFRxqG17qwJALHDKUvQXTwaM81DTLFBmxRuPRe3XBH7rEKxI3CotLUmD93mjIPh9N
 D9PksU8pIU8X43B86O6laaGxCWnTwR0=
X-Authority-Analysis: v=2.4 cv=M7597Sws c=1 sm=1 tr=0 ts=6a58c150 cx=c_pps
 a=k/qEcsOZaAb73X0OMcDaoA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=p8B4ZfjjwVxbjijj:21 a=RAioF0-LDSMA:10 a=5KLPUuaC_9wA:10 a=s63m1ICgrNkA:10
 a=RWc_ulEos4gA:10 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22
 a=KfkQE9S9VqCBgivYGm0O:22 a=r77TgQKjGQsHNAKrUKIA:9 a=Ej3ngyLgEUZ-gFl6Ky8A:9
 a=QEXdDO2ut3YA:10 a=C2aAri4MTQEGWM1FsOMA:9 a=B2y7HmGcmWMA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDExOSBTYWx0ZWRfX7haj/r8Ep9W6
 qh0KSSN6u3C1+JwMG5fFBhOPudt5fefJGXZfQfuN0VLA++OPbCjK/v8j+p+Dspi3NHdvFUx7bAR
 UxPuzQyceGTQrD82zQMaL6afJIqho+OITp5xr7WJAch9+OrJvpy4rAoScgs9gQ3+O5Oqmv7FZRN
 o57yWGqPNAt1c04Nmu1wgohiabTRcasl0Ex4nBJ2FBfTegbyq6jgUfl1S0+KwAZF+EJM3RqRvZf
 lw/WpBRVFhdmbvRiHc6gIWs72MJn94JcFTb4Iu9Ez38qRH8q/Tq3a0VXZjf6vbbPI8Cv9UglInU
 kFmmSZkaQtzsWvfqbYWFAhuf1l4GmNjEN/rDpX2kcR41jEkay7tY1/Wj48yXE2MNWDDbCgcv+9Y
 +ZimYQhsWVefSR2mumfdju/1RleW/bnF60RNeFkvnqfcjYnG3AAjYNQLZPH4b6moAMC+WoISG+X
 th/c4rEdwDFb8aKu+aQ==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: BD67UMVNJCYYC6K2SPOKGB3ARO6UQZKZ
X-Message-ID-Hash: BD67UMVNJCYYC6K2SPOKGB3ARO6UQZKZ
X-MailFrom: prvs=8657838951=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BD67UMVNJCYYC6K2SPOKGB3ARO6UQZKZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This is a multi-part message in MIME format.
--------------uiWAg02dM007x2p93ekG57xq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/07/2026 9:06 am, Salman S. Tahir wrote:
> Hi Richard,
> 
> Thanks for the diagnosis and the complete() -> complete_all() suggestion. I
> tested it before replying, and I'm sorry to report it does not fix the 
> failure
> on this machine (Lenovo Yoga 9i 14ILL10, two SPI CS35L56 B0 amps, 7.2-rc3).
Can you try the attached patch?

--------------uiWAg02dM007x2p93ekG57xq
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ASoC-cs35l56-Fix-possible-probe-deadlock.patch"
Content-Disposition: attachment;
 filename="0001-ASoC-cs35l56-Fix-possible-probe-deadlock.patch"
Content-Transfer-Encoding: base64

RnJvbSAxYzVkYWExNjQ1ZmNiMzM0YWJiNDVjNmZjMzgzYzUyYzE5MTk0NmE2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBSaWNoYXJkIEZpdHpnZXJhbGQgPHJmQG9wZW5zb3Vy
Y2UuY2lycnVzLmNvbT4KRGF0ZTogVGh1LCAxNiBKdWwgMjAyNiAxMTowMjowNiArMDEwMApT
dWJqZWN0OiBbUEFUQ0hdIEFTb0M6IGNzMzVsNTY6IEZpeCBwb3NzaWJsZSBwcm9iZSgpIGRl
YWRsb2NrCgpPbiBJMkMvU1BJIGNhbGwgY3MzNWw1Nl9pbml0KCkgYmVmb3JlIGNhbGxpbmcK
c25kX3NvY19yZWdpc3Rlcl9jb21wb25lbnQoKSB0byBwcmV2ZW50IHRoZSBwb3RlbnRpYWwg
Zm9yIGEgZGVhZGxvY2sKb24gaW5pdF9jb21wbGV0aW9uLgoKRm9yIG1vc3QgYnVzZXMgYWxs
IHRoZSBoYXJkd2FyZSB3b3VsZCBiZSByZWFkeSB3aGVuIHByb2JlKCkgcmV0dXJucywKYnV0
IG9uIFNvdW5kV2lyZSwgcHJvYmUoKSBtdXN0IHJldHVybiBiZWZvcmUgdGhlIFNvdW5kV2ly
ZSBidXMgZHJpdmVyCndpbGwgZW51bWVyYXRlIHRoZSBkZXZpY2UuIEFsbCBhY2Nlc3MgdG8g
dGhlIHJlZ2lzdGVycyBtdXN0IGJlIGRlZmVycmVkCnVudGlsIHRoZSBkcml2ZXIgcmVjZWl2
ZXMgYW4gQVRUQUNIRUQgbm90aWZpY2F0aW9uLiBCdXQgYW55dGhpbmcgdGhhdApjb3VsZCBy
ZXR1cm4gLUVQUk9CRV9ERUZFUiBtdXN0IGJlIGNhbGxlZCBkdXJpbmcgcHJvYmUsIGFuZCB0
aGF0IGluY2x1ZGVzCnNuZF9zb2NfcmVnaXN0ZXJfY29tcG9uZW50KCkuIEJlY2F1c2Ugb2Yg
dGhhdCwgb24gU291bmRXaXJlIHRoZSBBU29DCmNvbXBvbmVudCBjYW4gYmUgY3JlYXRlZCBi
ZWZvcmUgdGhlIHJlZ2lzdGVycyBhcmUgYWNjc3NpYmxlLCBzbwpjczM1bDU2X2NvbXBvbmVu
dF9wcm9iZSgpIHdhaXRzIGZvciBpbml0X2NvbXBsZXRpb24gdG8gc2lnbmFsIHRoYXQgdGhl
CnJlZ2lzdGVycyBhcmUgYWNjZXNzaWJsZS4KCk9uIEkyQy9TUEkgdGhpcyAyLXN0YWdlIHN0
YXJ0dXAgaXNuJ3QgcmVxdWlyZWQgc28gdGhlaXIgcHJvYmUoKQpmdW5jdGlvbnMgc2ltcGx5
IGNhbGxlZCBjczM1bDU2X2NvbW1vbl9wcm9iZSgpIGFuZCB0aGVuIGNzMzVsNTZfaW5pdCgp
LgpUaGUgcHJvYmxlbSB3aXRoIHRoaXMgd2FzIHRoYXQgc25kX3NvY19yZWdpc3Rlcl9jb21w
b25lbnQoKSB3YXMgc3RpbGwKY2FsbGVkIGVhcmx5LiBJZiB0aGlzIHRyaWdnZXJlZCBBU29D
IHRvIGNyZWF0ZSB0aGUgY2FyZCwgQVNvQyB3b3VsZCBjYWxsCmNzMzVsNTZfY29tcG9uZW50
X3Byb2JlKCkgd2hpY2ggd2FpdHMgb24gaW5pdF9jb21wbGV0aW9uIC0gYnV0IHRoaXMgd291
bGQKYmUgcnVubmluZyBpbnNpZGUgdGhlIGNzMzVsNTYgZHJpdmVyIHByb2JlKCkgc28gYmxv
Y2tpbmcgaXQgZnJvbSByZWFjaGluZwp0aGUgY29kZSB0aGF0IHNpZ25hbHMgaW5pdF9jb21w
bGV0aW9uLCBjYXVzaW5nIGEgZGVhZGxvY2suCgpGaXhlczogZTQ5NjExMjUyOTAwNiAoIkFT
b0M6IGNzMzVsNTY6IEFkZCBkcml2ZXIgZm9yIENpcnJ1cyBMb2dpYyBDUzM1TDU2IikKUmVw
b3J0ZWQtYnk6IFNhbG1hbiBTLiBUYWhpciA8c2FsbWFuLmFidXNhYWRAZ21haWwuY29tPgpD
bG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXNvdW5kLzk1YzIxNTc0LTk3
ZDUtNDMxMS05MjYzLTllMTc0ZDIyZDIyY0BvcGVuc291cmNlLmNpcnJ1cy5jb20vVC8jdQpT
aWduZWQtb2ZmLWJ5OiBSaWNoYXJkIEZpdHpnZXJhbGQgPHJmQG9wZW5zb3VyY2UuY2lycnVz
LmNvbT4KLS0tCiBzb3VuZC9zb2MvY29kZWNzL2NzMzVsNTYtaTJjLmMgfCAgNCArLS0tCiBz
b3VuZC9zb2MvY29kZWNzL2NzMzVsNTYtc3BpLmMgfCAgNCArLS0tCiBzb3VuZC9zb2MvY29k
ZWNzL2NzMzVsNTYuYyAgICAgfCAxNSArKysrKysrKysrKysrKysKIDMgZmlsZXMgY2hhbmdl
ZCwgMTcgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zb3Vu
ZC9zb2MvY29kZWNzL2NzMzVsNTYtaTJjLmMgYi9zb3VuZC9zb2MvY29kZWNzL2NzMzVsNTYt
aTJjLmMKaW5kZXggMGY2NGFiNjI4YjAzYi4uNGY2ZGRmMWM1YTNmNiAxMDA2NDQKLS0tIGEv
c291bmQvc29jL2NvZGVjcy9jczM1bDU2LWkyYy5jCisrKyBiL3NvdW5kL3NvYy9jb2RlY3Mv
Y3MzNWw1Ni1pMmMuYwpAQCAtNTUsOSArNTUsNyBAQCBzdGF0aWMgaW50IGNzMzVsNTZfaTJj
X3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpCiAJaWYgKHJldCAhPSAwKQogCQly
ZXR1cm4gcmV0OwogCi0JcmV0ID0gY3MzNWw1Nl9pbml0KGNzMzVsNTYpOwotCWlmIChyZXQg
PT0gMCkKLQkJcmV0ID0gY3MzNWw1Nl9pcnFfcmVxdWVzdCgmY3MzNWw1Ni0+YmFzZSwgY2xp
ZW50LT5pcnEpOworCXJldCA9IGNzMzVsNTZfaXJxX3JlcXVlc3QoJmNzMzVsNTYtPmJhc2Us
IGNsaWVudC0+aXJxKTsKIAlpZiAocmV0IDwgMCkKIAkJY3MzNWw1Nl9yZW1vdmUoY3MzNWw1
Nik7CiAKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9jb2RlY3MvY3MzNWw1Ni1zcGkuYyBiL3Nv
dW5kL3NvYy9jb2RlY3MvY3MzNWw1Ni1zcGkuYwppbmRleCA5YmM5YjdjOTgzOTBkLi5iMWVi
OTI0YTViNmNjIDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL2NzMzVsNTYtc3BpLmMK
KysrIGIvc291bmQvc29jL2NvZGVjcy9jczM1bDU2LXNwaS5jCkBAIC00NCw5ICs0NCw3IEBA
IHN0YXRpYyBpbnQgY3MzNWw1Nl9zcGlfcHJvYmUoc3RydWN0IHNwaV9kZXZpY2UgKnNwaSkK
IAlpZiAocmV0ICE9IDApCiAJCXJldHVybiByZXQ7CiAKLQlyZXQgPSBjczM1bDU2X2luaXQo
Y3MzNWw1Nik7Ci0JaWYgKHJldCA9PSAwKQotCQlyZXQgPSBjczM1bDU2X2lycV9yZXF1ZXN0
KCZjczM1bDU2LT5iYXNlLCBzcGktPmlycSk7CisJcmV0ID0gY3MzNWw1Nl9pcnFfcmVxdWVz
dCgmY3MzNWw1Ni0+YmFzZSwgc3BpLT5pcnEpOwogCWlmIChyZXQgPCAwKQogCQljczM1bDU2
X3JlbW92ZShjczM1bDU2KTsKIApkaWZmIC0tZ2l0IGEvc291bmQvc29jL2NvZGVjcy9jczM1
bDU2LmMgYi9zb3VuZC9zb2MvY29kZWNzL2NzMzVsNTYuYwppbmRleCBmNDZmZDhlN2JjMDM5
Li4wYjdiMDgwOTM5YTE4IDEwMDY0NAotLS0gYS9zb3VuZC9zb2MvY29kZWNzL2NzMzVsNTYu
YworKysgYi9zb3VuZC9zb2MvY29kZWNzL2NzMzVsNTYuYwpAQCAtMjAwOSw2ICsyMDA5LDE2
IEBAIGludCBjczM1bDU2X2NvbW1vbl9wcm9iZShzdHJ1Y3QgY3MzNWw1Nl9wcml2YXRlICpj
czM1bDU2KQogCQlnb3RvIGVycjsKIAl9CiAKKwkvKgorCSAqIE9uIFNvdW5kV2lyZSB0aGUg
Y3MzNWw1Nl9pbml0KCkgY2Fubm90IGJlIHJ1biB1bnRpbCBhZnRlciB0aGUKKwkgKiBkZXZp
Y2UgaGFzIGJlZW4gZW51bWVyYXRlZCBieSB0aGUgU291bmRXaXJlIGNvcmUuCisJICovCisJ
aWYgKCFjczM1bDU2LT5zZHdfcGVyaXBoZXJhbCkgeworCQlyZXQgPSBjczM1bDU2X2luaXQo
Y3MzNWw1Nik7CisJCWlmIChyZXQpCisJCQlnb3RvIGVycl9yZW1vdmVfd21fYWRzcDsKKwl9
CisKIAlyZXQgPSBzbmRfc29jX3JlZ2lzdGVyX2NvbXBvbmVudChjczM1bDU2LT5iYXNlLmRl
diwKIAkJCQkJICZzb2NfY29tcG9uZW50X2Rldl9jczM1bDU2LAogCQkJCQkgY3MzNWw1Nl9k
YWksIEFSUkFZX1NJWkUoY3MzNWw1Nl9kYWkpKTsKQEAgLTIwMjMsNiArMjAzMywxMSBAQCBp
bnQgY3MzNWw1Nl9jb21tb25fcHJvYmUoc3RydWN0IGNzMzVsNTZfcHJpdmF0ZSAqY3MzNWw1
NikKIAl3bV9hZHNwMl9yZW1vdmUoJmNzMzVsNTYtPmRzcCk7CiAKIGVycjoKKwlpZiAocG1f
cnVudGltZV9lbmFibGVkKGNzMzVsNTYtPmJhc2UuZGV2KSkgeworCQlwbV9ydW50aW1lX2Rv
bnRfdXNlX2F1dG9zdXNwZW5kKGNzMzVsNTYtPmJhc2UuZGV2KTsKKwkJcG1fcnVudGltZV9k
aXNhYmxlKGNzMzVsNTYtPmJhc2UuZGV2KTsKKwl9CisKIAlncGlvZF9zZXRfdmFsdWVfY2Fu
c2xlZXAoY3MzNWw1Ni0+YmFzZS5yZXNldF9ncGlvLCAwKTsKIAlyZWd1bGF0b3JfYnVsa19k
aXNhYmxlKEFSUkFZX1NJWkUoY3MzNWw1Ni0+c3VwcGxpZXMpLCBjczM1bDU2LT5zdXBwbGll
cyk7CiAKLS0gCjIuNDcuMwoK

--------------uiWAg02dM007x2p93ekG57xq--
