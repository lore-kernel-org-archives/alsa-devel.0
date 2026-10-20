Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9169B606A31E
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=E/1swu28;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=aa/gPZBO;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=ZlCtUtb2
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB4EB60227;
	Wed, 21 Oct 2026 18:20:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB4EB60227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792599621;
	bh=jbd/qFVl2X1kuPjNtxY6i2afE4Tx9aZ5W/RUZxdEO0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=E/1swu28d9T1VNvttb8h+g9FNBY5SDmFE/8ZZLXIZwb+grmA6RjnwdRnq2H2srb09
	 Jo+poQZfbo+5/LWBV8ev+hDRPd0CDzu5m2RVSZqtjl9Py59xa5sHGEfatQlSwMZoOg
	 ciE8ON7DoFR6IMkjADA9sd3IINP3SUy1w9xSDv7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 115F5F80601; Wed, 21 Oct 2026 18:19:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 94DD6F805F8;
	Wed, 21 Oct 2026 18:19:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C2ABF8014E; Wed, 21 Oct 2026 18:19:41 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5A3C3F800B6
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:19:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A3C3F800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=aa/gPZBO;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=ZlCtUtb2
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69K5974A3871095;
	Tue, 20 Oct 2026 05:05:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=hZPvA4/V3RKIzz0Fno
	DVC/jEB/OfASO5NiNKS3+6yXw=; b=aa/gPZBOWseGrh97dY5KOIeLOtoR7ZtK6x
	Vqhg8j8ogwbNHNlXeD6PvqT9PRt5XHsScia0jney69D4UQSV4NWD7vEzyYFD0iM3
	lPTRPBB7WIdnNTMAHida6IvL6NXkjzKhK0Auczcpkkjw4KeQ+VE9lzXiioDtMa0P
	Me+JTFe3GqvZ8MNjpD3PvCxEaEEoqYgcWxoDnYy7HQup53JemDsshap/v+esayzN
	4AoPY3vtBE35cfsyEYbqocVxZcJvbIUXmG14bBE4P368OZETiniiZSABY/Q9Clwu
	drn1m/JXqPpRzc6NWxsjT7oaf0Rzeh6zVNAzMo43Ey804TyXcRvw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11022130.outbound.protection.outlook.com
 [40.93.195.130])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hdw4vrmh0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 05:05:45 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN2CPmHFHc2RklOr8P13AtecBqMjA+HKKBeXGZVUGyxT9fbOvcGvvka5HWxzFyndRQMWFy7WBylngaM5iyzAPa5IMuwbFpP7pWO6fR3DpJfIIQZFlehgO47yhr5wwmvEYUvDzRjFUAc/DGVE8SjEawR+oUF+gxwCvKOveHUN+hwhe2gr5kAK/jRmzB1tsvRi9TPdbp08Sls37HBe1uG4aq4HhPyD4tMK1l0Cae2TUA7/edv3VEbGq8FXpMjRPofVC6ZYzrOsTlsopSjP2kH7ZtEYyIWCGyLX0SNfFysPatvBjnoY2Y4p955xvG+aFpEvo9fVlo4gE1HpvnHnCzdnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZPvA4/V3RKIzz0FnoDVC/jEB/OfASO5NiNKS3+6yXw=;
 b=I16YwTunulV7L07/YXeGFeJrbYaN+Ps+IgvIAMsGkWSx5dZQC1zXjg4Fqg1GC4COJQyU/HNYpsRuWhYR0+1nWxaWP6VcdZ/FdlLPRysAijB4/9sXojKlA+k3ge5KwxqV9LCP/lVtEGsvphEozy5G4UkF+Ab/GcOGNpU98DZie4SA79mn+d3k8WUkTeSlzHULKdrTQJ1nj4tnz4FC7sMs/YZYqJ+t6r2ZMrZ6Us9Ay6c332AaQVpyWERLWLE4RO8BnNsFiU4jgtoYzanRdQXASPuAdFO91iRzmtyIEc9/vTB4PAxXrtK6gYN4kqqySrS3E8IrJyrIxgVR1GleWc72oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZPvA4/V3RKIzz0FnoDVC/jEB/OfASO5NiNKS3+6yXw=;
 b=ZlCtUtb25/Nh51pfT9GDKpzG90vdQ1bpXZEPN5rUKJw+F9m19XYAxmxaNPa27cIuOCjUq2XgZ2BJslVQd15wAxwa03//ZASAKm+uth7wn/YUzBLz0x45UW8TiVHc/F86f09otMyHobGuOjxkzjHoQIaMWC/V747UuF2QqQpR8CM=
Received: from CH2PR07CA0051.namprd07.prod.outlook.com (2603:10b6:610:5b::25)
 by SA1PR19MB997343.namprd19.prod.outlook.com (2603:10b6:806:4c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:05:42 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::73) by CH2PR07CA0051.outlook.office365.com
 (2603:10b6:610:5b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 10:05:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Tue, 20 Oct 2026 10:05:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8E9C8406540;
	Tue, 20 Oct 2026 10:05:39 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 70E7182024C;
	Tue, 20 Oct 2026 10:05:39 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:05:38 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Sanyog Kale <sanyog.r.kale@intel.com>, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ASoC: SDCA: drop pm_runtime reference on probe
 failure path
Message-ID: <atc88vuPMheYK83F@opensource.cirrus.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
 <20261020073856.1177749-3-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020073856.1177749-3-srinivas.kandagatla@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|SA1PR19MB997343:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e62ec99-c2b0-4355-5f1f-08df2e91b265
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|61400799027|376014|7416014|23010399003|82310400026|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info: 
	4NQX3PUILO/PWGFNUReoVP7JlN/4bvJOGjd05uu6U2/aLcLxjdrEoBpZ0eTDwX/cLWlvMHo9/gNotdORTjHQREVNUDZcKM0VtRxBcyfXMGHu5/X9+MELsggs80CUh2QhNKpdT4eO+f8WhoXCGIjDEadVKFmngixqvEJSyQIptW/v+1pnvXD5S4KYKbKRR086Y0UfoL/w+tsnjb1ChdvJmVynEB5j/ffkiyWervyVjm7qjs6y9GBZfIKy9G6b3Ztcfo4IP7o48BSqFZ/2WX+ewv20w4llsmljb3aiU+zsiI5+2jWalg9BdtZsM9uyWHlin+kCEBzmInXnIKL3usNeHg2Vn7kaFoQZysKmxmmks+BFHLWor9FRur1D2b7cBn//2cW4MhwmyUtFEfpiTC6z3Avaa6+EFEklAYCsV6UBSmzzmt34BXKtP36Hk7ZZkcfJ02hdCtmoQUYXKjtkKEk3hLVxTOEE6G5Dw7XYpaQlz+49O3t2Q3S0xxIIfwASnzXBsaD4TQpl678demnVLPO/2K91VeqmF33fxQQjrwOJ6e+YGsOiiCQHrzcTEpYbJ9/l+fTafa4C1vffsYAFPHm16dix1hr4LI1IpKh1luSxFDgzI7MNqiRrEp+n4KopsX7epJXHY34tVCg/xZZE+cvLHKffeS26X8bzA1SSKj1oJDigvi2VClAv1xhyQfPMQpS3mLOxgao/pfPwFDU0r1ydig==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(376014)(7416014)(23010399003)(82310400026)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Rs0cXIAF+77E7Fkrb7CFPEyQAOElkEgl1N/AJJYsyEzzejhRENlz9h2qXmG2jsDiJ1cBIt8gRgRATGCLBZkgSw3ne3ItMNvfsAPRIYGRhNTpO8hLxcBq4MGT100RpFfBh2PHWL+MmrbhkwYdSDHtXJiN2hTP9nH6kesB/v6k6todwzmH4KeRSOR+ZS3vLdLTnvuaj9dua6j6P1f126AmbaUxOGE6ecPYJaYwUbTE6y0HW44a3T7d6CFsZd4FmOpU/hgYrEdnaAl/FgBUqQtlxXU+cgtx7RL3KQjucFrf/lsKPW6jJEPfS1Q2Fsdj6rw5mAoop2saApwewUdna0CW1YbuY1q9awGOQBsA8WXLY0HUAFqH60Bqr4U/qLm+T5q8c1YgYvPKCcudJ9gdaJqqiFHcB0WK6oLdRxbopYV89tcssbLDFxd1fc0rLqhM7wSN
X-Exchange-RoutingPolicyChecked: 
	kWYe3/8fs7MSdHxFF2Tsp9XHd5VFpsxL5ZMM/c6G9qVVKZYS1eu7LHodr2mb2dFwdfefX1TsNIgddwiqmeuw/1iN88PUx3/hfnVByobMtUT5A2jdFXbiFW/iUpcC0YJIH7Dj6p5c0/ENhWsEN6U105yyalN0iYOhrKBB/VkMv0kVIG2oy3mwLaWR6uTDdg6ikLFRtR9ANFe4KXByNUZsFQLAGG07YkvuizAp8LN0h0D3H+wOvQ6maSBnsXVywe37gGsJbV9hSNuNs/nt42sS9jNoozvdiGnJUvqySsg3rlJ/3E0NxuTXo5bg180k1FLq2mzxHxfB2cIXpBNjQ9nztw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:05:40.5659
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8e62ec99-c2b0-4355-5f1f-08df2e91b265
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB997343
X-Proofpoint-ORIG-GUID: lOGMhI0SrGo7B2-TMuf0ljDpPlgELuZX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzOSBTYWx0ZWRfX/7H3wMXDY2qY
 qOxVMDcBIKL04nAW2J862ge8bv895w9X7/8GGlsNmnMMxErxIAdCoiPbtD7wXk0PWIYH1dvEAAH
 J8F09R+WfXiCcC1gIUTQJSyjblg6JCk=
X-Authority-Analysis: v=2.4 cv=H7tOUOYi c=1 sm=1 tr=0 ts=6ad73cf9 cx=c_pps
 a=3EBeExtWu2EVQLokDhbCbw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=w1d2syhTAAAA:8 a=ABzkLlDp1WoNhEOj82cA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: lOGMhI0SrGo7B2-TMuf0ljDpPlgELuZX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzOSBTYWx0ZWRfX1oW5rJP/0/iR
 TNl0uiRSwN3qiHMiaF3A7NtTDhd/zaNC2xtcGFZ2pOaDZTjwYu4YZwAPx+dvKsyU5p8G//OmwNm
 jQ0hWgSKlvRgJf5X5+W3wpwurcHeNIHO82he1Ny0fJjzXPWvk98uaya7xD1SaqYWdiBztI5uWAy
 PBKpLoIzuYK9vJTT+gzQFv1KKgXevDrho3+lf4DHHnU0MDH+KSHMpzRdgbBNXU8tF3yqJv4Nzo+
 4lWvfmyImMf3/o4aN49c/vUKY+O/TZOeSkmBzm+Ys9wDL9gE7jz6PU24IWENUOl0iQjEBb/etjH
 /SOVYLmMgCqna0ajG/auj7iBdSqOOxpAbhkPSVZPISdsWKi1R3gyob7/EH6K5KAatwQdpPq3DSJ
 mrT1F5CJWeVH4Ckrbk8zSBTsguXpO9n9P/mRipNeTgeGQcpiZrjT2MBM+y2yDN/yJYUQVRfNx0x
 0ugwpAKDY/2AJI2iujQ==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: E6IHF3EUMXJ47SW6LPBAPTMIISWXBK7P
X-Message-ID-Hash: E6IHF3EUMXJ47SW6LPBAPTMIISWXBK7P
X-MailFrom: prvs=1753b3f352=ckeepax@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E6IHF3EUMXJ47SW6LPBAPTMIISWXBK7P/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, Oct 20, 2026 at 08:38:52AM +0100, Srinivas Kandagatla wrote:
> sdca_class_probe() takes an extra usage count with
> pm_runtime_get_noresume() to keep the device powered on until the
> deferred boot work has run. If devm_pm_runtime_enable() then fails,
> that reference is never dropped.
> 
> Drop it on the error path.
> 
> Fixes: 2d877d0659cb ("ASoC: SDCA: Add basic SDCA class driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
