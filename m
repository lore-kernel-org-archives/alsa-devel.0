Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87F0C54F4C
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Jul 2026 13:25:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B6648601F9;
	Tue, 28 Jul 2026 15:25:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B6648601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785245141;
	bh=fe9zZ93iDOR20igkVE+4GFnm4MbzU9CEj3G/aXEMEzg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Hnbs9+0yzxtFLu4V3r78mGZRHBNvVgss6wUGpr9eBj5hacYJCZYUb1vXAYO+bTauR
	 KDneRNvDD5vNcwrvw4dWs3ZyhgYWu7/i6Tl4m3Ce8BwF5AhMeKTNDLadrmtl54mEFu
	 uJ+mEOxSAKu3i708M7W+Xqk1D34QO9So+2mey/2w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D36DFF80601; Tue, 28 Jul 2026 15:25:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B623F805F8;
	Tue, 28 Jul 2026 15:25:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D031F80526; Tue, 28 Jul 2026 15:24:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785245093;
	b=LD778K90w3XqdKWxFjmKu38xk06zzkdrlEmy/gS9zjBejaQ0NYmA95rhrwWmf/ka7lG6
	 BKai5L3nrhipIV9CIB45D6qrDM8FJUE+Q8R0jmrG5THOWjaTQ+1cdU9GphQ7okWYcpzBZ
	 W/1PnKHjpfOywZn7GWF46Gt8xx8dzRPUK8M81UN+Rm07XvJYFjZ3yaaoc8K+OqODn45Pq
	 PnSRkchBZCDrgXmPKIJFxROmuMMvtWd3mOgExs2y+U/9ZOiiX4zbvFi/FzE6f8CTkPQug
	 vSF7J4KVGd6Cnb7r71nlydR449HZgoow3hJ4wgK/jDcuv9WJnqfSY57TlGCcIV9P8TA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785245093;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=fe9zZ93iDOR20igkVE+4GFnm4MbzU9CEj3G/aXEMEzg=;
	b=i5Vb1M2mubK/yV7zQlige4rSM++y2tp/oSLKbgthkc5+mK9ptxmxS4S2b9R6zGm9d+Jm
	 DLicpse0TEMtMpU2PxSHJpeu5mr9E0YNjoPh/HvvL1aFRyOiyuwGATlNOcQI8cAqtnjP1
	 jbL54vT3Li0BMS7JJ0mFgZbwQA7CZxTrmdwWNH6/fcS+Kmg22FfJZ05QC8AUJqrkk41c5
	 P1YjDB77yFeDV+5CzRoAnzyDl8B/Hi/u4AAPBpyM1a2zskDAikCd7Ep6IEPeI4dX5yhjj
	 W5VTmrCzXyBS9o7AvKD8Y3SyW/QnIp/Kq736vaPB9q2SZL8z37g8PcZc+Ar8KeTRXvQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=coFo5DCj;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=QoPwYsJb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9BE85F80224
	for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2026 15:24:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BE85F80224
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=coFo5DCj;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=QoPwYsJb
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SCYauC2202288;
	Tue, 28 Jul 2026 08:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=kwL5gmsPUgqgs3e+3ySqWYzmiTD9h4CJD5rl0WZ1TfU=; b=
	coFo5DCj1kbxVzg2+Hqk/Q2vo8D134FUwhPUijieZfhRaYcXtLBtMcxHNdmn6ZRN
	JotLBCHpWIcQravTS6oe0HfVptd+i0nRSlqlK9pP0SsYsPuLnJtJDtAD+P17Ibcn
	xKQ7dXwB4zP8SKmZlvVMIayBzQtkmwZVWopY12MAZE0sCwMG/KKxFbc4WGKqnNw+
	dX/aYARg4n3RPx9yerWaR7jlr8pGSc6bb6CPHP07RJYkYL7R74lYofIryEweETp3
	qbQbE6QvY4OxvCoW2m1NaQYl+CWLURccKCCKuyECIljlgomOWOyk3yXFp1G3fd1g
	JgVk+mTv4xrKX2CPHu4RuA==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11022112.outbound.protection.outlook.com
 [40.107.200.112])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fmthxbsa0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 08:24:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAZd0HL0FSXU0sKwP6ZXbMB3YyYAOLkSCoPUOi0PGEfXgJrLB2UhkJth/04p0l+SCe36wl3M840oUaUyXBHvL8to0hsqjqG3MNHG+Pq3ax07kWD2GYfLV8uHquiW6+O9d7hhmg0+kLzmu9G713cSq5z6dvEG9EmyH9VUkGjvjYNQ47fjG+DGW4HgJDRJwHR0KZpCSC+4QsbpSDsdVziR824Z1YttvMpu5SOKeUJlY5ZC13rqsPBa5UpZhTqyhbXIuM0AXGyfX+0oJ0UDDNgiCQkDtK71vi2fTPLg8YYjSW1k732ZVIGTWViOWc603udMzy+qo1fPCWOihts0w4rZtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwL5gmsPUgqgs3e+3ySqWYzmiTD9h4CJD5rl0WZ1TfU=;
 b=YAQixu66zRnBvUqyVJvKfJ3nNn/L4mUgIVwI/SBXxridqD8jGXaVQWKU82LzPFCgxec0ODvuD7YEEYiwNTFuzQU4e2OhN0ZsJrAJhPQYkkEdXQNQ6nMCwLiFu8w/zTynu8+6bdw2AlSLrddVW/YD1YGB/Fbw9f894SsOcyMQaiTm/LQkdtmfSWrrSyO0ulrIaHULnYykCVNjUzy5zdf8enCdv4/AVWsx9wpcwMgR5FbXv7U8Gxjvk2i79+/MxgzwzylIXWnF/bsVUnPyqQEQpwiZ+IDB9mgjENtCGiHsA77RSfCXhzmEK5bSzjYQNdhLyDvLDVnc+WlA5QpoPiOXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwL5gmsPUgqgs3e+3ySqWYzmiTD9h4CJD5rl0WZ1TfU=;
 b=QoPwYsJbXfGDcTpaZvtgpdRo/WHs2xsL1DQg4bA4RpKjZQEVeEk29zQ74Kd7m8/EOuYJUC+sZGVO2uCfcq7upQaFRF3HfWGqddphlh3qOmUxr+jLLO2fRW2XsYqAG2UtVzc9bxmi1wPUzysWvkn9G4JSZ8jxv2pOvt/zql9BRv4=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by DS0PR19MB6454.namprd19.prod.outlook.com (2603:10b6:8:ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 13:24:42 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:339:cafe::9d) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 13:24:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Tue, 28 Jul 2026 13:24:39 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 6DB46406541;
	Tue, 28 Jul 2026 13:24:38 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 61DD182024C;
	Tue, 28 Jul 2026 13:24:38 +0000 (UTC)
Message-ID: <139dca26-4c88-4b60-8af3-5d5d47ef4551@opensource.cirrus.com>
Date: Tue, 28 Jul 2026 14:24:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ALC285 + CS35L56 (ASUS ROG Zephyrus G14 2025, GA403WR, SSID
 1043:1024), no speaker output despite correct routing, gain, and DSP state
To: Aditya Sharma <aditya122sharma@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de
References: 
 <CAEF4ZLNsnnATjgGAFYim3t-0qn=LHx=LeEid-jQULEDvN4aQYg@mail.gmail.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: 
 <CAEF4ZLNsnnATjgGAFYim3t-0qn=LHx=LeEid-jQULEDvN4aQYg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|DS0PR19MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbbd55d-649a-4523-e3e8-08deecab941e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|61400799027|376014|23010399003|13003099007|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007|16102099003;
X-Microsoft-Antispam-Message-Info: 
	dSPjEdXsHIERa35mMiVyw49wQrJAtgMB/wWTMwfyvCp78nfbm2J1Q7pjHzNe8Pl9EZEYymsN3GXL8lQtJDPikyE2PXMiRMDIv9nUY8ehFGse7aLOCrjjoZeQUGLrKaebBILVLFxNr19V0T3VrmzNdMWECYFPpIrDXKwtB+6V2GQ4mHms7RcUYNMdVBEnizOHFlIjA+UIbCzBriNa5NXfNpUhZHqdbY5sRutiM3CTI3KcjXETSAF5nUcgij9HSL+whPzILP7N0nlMslXt4aHIA+gqcNrs1+KeK4gGzkcIDVeS3EjCjdaFDAZc1MRjnELw6+OsNh0KlazgIVHGyikpSTtk4/beKH1Q22qGkFzX2LR/UKMyc/t4Jh4UrSRcmPQIJzSqUSf/tQGgCcd6YBWtUhezgUaCjrTTPfr2LlyueLbHCTzjeFWOduS4zgbSDC/hICzEjmE8rdcDAxMApZ+dNoNsC7dHmn6WIxpHJAfItlyNtfuaqUUPts0D7ZqweSkantDtaMXx5YkhUAjQoIMd8yUmBrLfBU806iYMkJ3x8opNXgn5/cySute5W39UjCEHI7FDLhPecIpbHxZ6dnj3ruhgRjoi/guH+TmSLV67p667AkZu0ksH5UFpGqlf8B9+I9kje1h1JC/35hWtyCLZUqlaEATitAqvKzJp2ylhksM=
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(61400799027)(376014)(23010399003)(13003099007)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	MjN/updsVYHc9O7WSu4tIvVL8Mj+hH7w0sYQ3XPwm6KlchiLChsSMKLM4lyG10MMpHh+ZJ+O6sBNcsYHQ7IOIg+FIFmfQhYMqYOqb9AR3E8zuY8jdAy+MKrjmFC+gva6dEk+OCrj02S66ukN7EgOKMJkyr+draXhdroz2U+xlx35wFdaEPPftqqNZmhAsvVgJuvIHPVvYiV3a9SNVr8DCW7IpSQZgWmG0jB6PbfuadjYfPvRFWew0qU2sz0fea/M+VxebmX6Tjb+z4lGDwHnDZWyEvmQ+8W1qSzg2ZXe6BXj891LbXj5HOE/BTU+N5YZmDwIiLE+ClK4xEcMcoDYocbjn3oy39gOnl+CP6okYSydrHdgejjdXdCltrBn/5LBrj66rgUAwwztiAWrbsISjmXchpa4cuR/q6hpesCsqDnUgUc7ghV516osF/3dKcBW
X-Exchange-RoutingPolicyChecked: 
	Vt9tREGKZcz+PeJuNrG6cofh1UJvG6duc7ZAIHm7zHjSUlEbWgdr1hEfqO0ANrVvPA/HaYOwbSGGqxaqXWkvViEUxIcZEh+ZmuLeAFuXUIYl1j/Wvf1QDik/jx5bwt/cCl7uSfbcXMNEPZvftA6OMJL49Z8WLVvwuEzyanc3/fYGiwZowJ7HDNEaLPKYam/PtuG7D0C06hcFt2sEHpk3+15GHwONXADuxzdIh1Y+7/fsGp/A8Y1M/VCHWlF6t6D7jIGqKOMa4dgSGRh4RTLHu+97Si1z5EXpSl3sEerOteJIlG2h6AdCAwheUIjSgmTDJl66szv0ox0mD/KpaNyr4g==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:24:39.8574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cdbbd55d-649a-4523-e3e8-08deecab941e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB6454
X-Authority-Analysis: v=2.4 cv=Js7Bas4C c=1 sm=1 tr=0 ts=6a68ad9f cx=c_pps
 a=thPb+1yXIQ2gbI/xx6itCA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=foHCeV_ZAAAA:8 a=0dxst4vNKFTkaOcp3AoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=h8a9FgHX5U4dIE3jaWyr:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDExOCBTYWx0ZWRfX/1869HzTGqgw
 oHEzWuMPu0Erdw7yTjx+9xaL8YDjlVfJRzKKylK/jUXanQRPNJ+S14IFamvd0dbvNmcVmk3vg67
 Co56+WgUTAd8CwwOS4lzYm+48MHfn22yTB7yxyPUL3090AgXRRPWplksZkrwGwwb2d3Gu0LHGOo
 +gRnlhvtahezxMzA7/cC/YPP7c7C0y7f3f3dBR4zbjw1xrXvI6U8C7GueELanXfLa7sMZ8V6Z4b
 ouTewsqTMPH0aHbaf3ngMdkU5+gperEKb0AFOwVWxlDzEqBpiqv5q0vp71DkDIY6+dUcXaYYv6Q
 F9fONYz2/CU1hBLkSzbHxpFhRPC5t2JHFlVO3D+7spLRCfj1YGN03GPCVtA0MgSzcylnHPMVfY/
 omwTu/8rfViUhOGRyCJ81bNwDurScMIxwtZoe/JUCZQxb7o20m/lIy4OlE+5TQWROsnsoFQLqrC
 ETl7sd1WqyeNFKDt2ZA==
X-Proofpoint-ORIG-GUID: Xbi_dZZHiiX7t9M-uHb5tt16XM-T85dP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDExOCBTYWx0ZWRfX9jngpk2yoGsl
 wIUFS7dtsewF77cKUS6Fjd5z2u5yb3iDemEl8Z6I61xz7ihRbSPpSWtp+nadlVA1gB1ipWWQv7D
 BvK/wtxiTfpPd97ADKSY6CLckZjeIhw=
X-Proofpoint-GUID: Xbi_dZZHiiX7t9M-uHb5tt16XM-T85dP
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: QSNQIQ7LRAGCZFM5ACTLCJ2RKHWXEAKV
X-Message-ID-Hash: QSNQIQ7LRAGCZFM5ACTLCJ2RKHWXEAKV
X-MailFrom: prvs=96693516e0=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QSNQIQ7LRAGCZFM5ACTLCJ2RKHWXEAKV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 28/07/2026 1:57 pm, Aditya Sharma wrote:
> Hi,
> 
> I'm seeing complete silence from the built-in speakers on an ASUS ROG
> Zephyrus G14 2025 (GA403WR), despite every layer of the audio signal chain
> checking out correct on inspection. Headphones work perfectly. The same
> physical hardware produces normal speaker output under Windows (dual-boot),
> which rules out a hardware fault.
> 
> *Hardware:*
> 
>     - ASUS ROG Zephyrus G14 2025, GA403WR_GA403WR, BIOS GA403WR.309
>     - Realtek ALC285 codec, PCI SSID 1043:1024
>     - 2x Cirrus Logic CS35L56 amplifiers (i2c-CSC3556:00-cs35l56-hda.0/.1)
> 
> *Kernel:* 7.1.5-1-cachyos (CachyOS, based on stable v7.1.5)
> 
> *What I've verified, in order, all confirmed correct:*
> 
>     1. *Kernel quirk applies correctly.* ALC285_FIXUP_ASUS_GA403U_HEADSET_MIC
>     is present in the fixup table for SSID 1043:1024 and its chained
>     alc285_fixup_speaker2_to_dac1 executes — confirmed via
>     /proc/asound/card2/codec#0, Node 0x17 connection list shows 0x02*
>     selected (the expected DAC1 override), matching what the fixup function
>     sets. (Note: the "picked fixup [blank] for PCI SSID" dmesg line is
>     misleading — the fixup name is only populated with
>     CONFIG_SND_DEBUG_VERBOSE, which is off by default; the fixup ID itself
>     is still applied regardless.)
>     2. *EAPD correctly asserted* on both speaker pins (0x14, 0x1b) —
>     confirmed via hda-verb ... GET_EAPD_BTLENABLE returning 0x2.
>     3. *No amp faults logged* — dmesg | grep cs35l56 shows clean firmware
>     load, no fault/error/protect/thermal messages.
>     4. *CS35L56 DSP firmware fully operational on both amps* — via debugfs (
>     /sys/kernel/debug/sound/i2c-CSC3556:00-cs35l56-hda.{0,1}/DSP1/): booted=Y,
>     running=Y, hibernating=N, fw_id=0x001a00d6, fw_version=0x00030b10.
>     5. *Hardware-strapped speaker ID correctly detected* as spkid0 (read
>     from onchip GPIO straps per cs35l56_read_onchip_spkid()), and the
>     matching tuning files (cs35l56-b0-dsp1-misc-10431024-spkid0*) load
>     without error.
>     6. *PCM stream actively running* — /proc/asound/card2/pcm0p/sub0/status
>     shows state: RUNNING with moving hw_ptr/appl_ptr during speaker-test.
>     7. *DAC-level gain register confirmed at full scale* — Node 0x02
>     (Speaker Playback Volume): Amp-Out vals: [0x57 0x57] (max, 0dB), after
>     setting via amixer. ALSA-level Speaker, Master, Bass Speaker mixer
>     controls all unmuted at 100%. AMP1/AMP2 Speaker DSP-side gain controls
>     also confirmed at 85% (-4.75dB), non-zero.
> 
> Despite all of the above, no audible output whatsoever from the internal
> speakers. Headphones (Node 0x21) work normally at all volume levels.
> 
> Full alsa-info.sh dump (codec proc dump, amixer state, dmesg, alsactl
> state) is here:
> https://alsa-project.org/db/?f=cc6c08116d9a9c466039679d2142d0df1c12fa77
> 
> Given that routing, EAPD, DSP state, hardware ID, and gain all check out
> correct at every layer I can inspect from userspace, but Windows produces
> correct output on the same hardware, I suspect there's an initialization
> step or register sequence the Linux driver isn't replicating that Windows'
> Cirrus driver performs — possibly something not exposed via the standard
> ALSA controls (an additional calibration/init step, a missed I2C write
> sequence, or something specific to this board's implementation of the
> two-amp DAC1-shared configuration).
> 
> Happy to test patches, pull additional debugfs/regmap dumps, or compare
> against a Windows-side driver trace if that would help narrow this down.
> 
> Thanks,
> Aditya :]
> 

Your alsa-info.sh dump shows that speaker output is muted.

Simple mixer control 'Speaker',0
   Capabilities: pvolume pswitch
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 87
   Mono:
   Front Left: Playback 0 [0%] [-65.25dB] [on]
   Front Right: Playback 0 [0%] [-65.25dB] [on]
