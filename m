Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7AAC54F5C
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:59:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2D9060214;
	Wed, 29 Jul 2026 10:59:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2D9060214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785315561;
	bh=mnag4iwuehw67rJshI2B5G0W4lBzD2pI9Gybkemn9OI=;
	h=Date:Subject:From:To:References:Cc:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=L7U6hSJy5UdTGY7aXPHJOPd2/rBE4+JLCXdC368OQPnuNZNEzL6X3HpyOks9lXm+h
	 7sFaXNEI3hiTc/8sefvQOutwkQRVOECtl8eQfya0+vF6a64/ns9pOhymrCxhPoqRvn
	 T7eJFDlwWBh8CLV7fg98SK3p6L0h68Cb+BeaB/+4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E4758F805FA; Wed, 29 Jul 2026 10:59:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EDD71F80602;
	Wed, 29 Jul 2026 10:58:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BC33BF8057A; Wed, 29 Jul 2026 10:58:51 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785315527;
	b=eV+MQArDxSpeH6i2PKPub8pubj/SWTwEo1BAIo02AqskEx9Y/KQC15RWSWHbA48X92uI
	 CWmx9vToGNUl8Zy2oaABVxFMGlTxyWaQ7ltWJx3QKZfDMYxIyZsAUg9jqUd3eq1qR5oke
	 1/FULrm9D4vdZeEhPuWQT3iZgWklhxd6qegLiPf0CdWv4aTh5RCMzrxfiaRbv08QNggTA
	 A7nxW1JY91YaSZf0P4eY9b/NpCAKWS408g8W57cKVApEG6iCLCnNQaccR29WzO2UMta2A
	 v7sYeuSxfHBwKdogpcoScELDyueggbIY+GL99GU8/6hxrPgCM/d9IT28OYPLstWs41Q==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785315527;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 From:To;
	bh=mnag4iwuehw67rJshI2B5G0W4lBzD2pI9Gybkemn9OI=;
	b=pPXGLXa2tVoNapVk6r0jbwW6pqyolP2GT83gfKDPMHtmTu6v850IQt2yUKziwwmiYumM
	 anKK6zpAq3QM5qjFss9po9KUT24mxt0cp7U2brvYeW1VZKcbeKmFTbaaDBlhOyTl4Dz04
	 BR9YpaOzCLhPV2UZQsZSAWs1RfeCu6tInkqk0XR6ETKl2oqsN0Mc37tWhNoIhwI+47Jr0
	 KzVrMN1qW+7zgMuDO0+TXOanhjM4x1Lzztsijtb1oMOCRycYPUprfmSgXP8ofWWgsfy4M
	 huDFITGjMv4aQbHapQejMOdwlluRsKC29eKFn1EJ0oUg+ZWrxTqaqpE+1+j64MK2xGg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=OU5eQIdO;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=ZiPNlU3A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 41D9CF8025A
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2026 10:58:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 41D9CF8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=OU5eQIdO;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=ZiPNlU3A
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SIuCox2832546;
	Wed, 29 Jul 2026 03:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=OemR/eYkoDOr+JRwGW48o7EC5+YCpWeVQEBXEaFr8RU=; b=
	OU5eQIdO4kdE+sequv9vLwF8Xlri9YGiMOFJKtyI0lGPWsnBTgl89dASlU+uzgUc
	oIIe4kac1+Pb0Tz696tpD35nXJxC/EHUah8+1Jv1qD5BKPnSevIb0l006ftRLc5w
	hx9hzDUXeMEITV/1pd6eRhmuqDNWRf7eD9me9Pe4NRRbO+ewr8J3EYm8QDg0Gu9/
	+9QdvHoQ91JXR5mc91f/8dTe2WPuwo6PAi5gbRSJhn7bJ58ZITZU61J5xnwwBjKo
	1hKWKUtTWvdfj91ekAAbC+oQeGDXHcRywLhb4AhxTbb8V11afPY9tGg6DUxGSrfk
	MwyEzaUAgkSQYbQN4lHGRQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11020107.outbound.protection.outlook.com [52.101.56.107])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fmthxd37a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 03:58:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQcKiNZi/jVzxaQMmYJgFLftNvo2ddhGgUa8Y1rilTXXxZOdkW9FqgwNzu+tb+tIaNhElGKPjJ/YbJOfD3xT7ncwKkR/t/UC4j2tZtiyCOyoTjbeSX5nmaxuvxLk+fiwK8fo+BWMr446uBbaTN3rrfXIPXjkojNZpykvjw1MMRtF2Ag+CHkW2aoq0bUmhCZNud17jzU0k8rQQl67LwZJAfEUZq/xrOeTfs0NqK0KNgVDotjmUpAFAdGiqniSMFUEwybb4+1n/ZrMSHo0fXOAFrs3NxtILAZUT9Z2JSuB2uwrHG9KJCxO2xG7NNKudMvhd3S+YhgeWT+bcS7rV887sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OemR/eYkoDOr+JRwGW48o7EC5+YCpWeVQEBXEaFr8RU=;
 b=DnrG8qI17vEjObbxKw2o242M6hHnKtQwv10GaQZ/pJ7vpDcfxnSFqdg4YcQtOwZM7g8Ccic3WuFNQlyQ/VhWHhluaMm5kRhoEnr+VVxMGtk558UogYXk0fv3WWf40ksg50EhlwcfC62D1YHxenB5df7hGzmImkEHSpaIa3Mxowpm6Rw/jMx6KMlvrTkaBaSWLfp+QD2DlMj6e+LzLfEQNequpYL5j+M0PMC5TuxfFsQ6hmiPdSDkiDbMS2YKzDr+JD4VQKnpY4qeXQ1R8p2vmo307UKB4idmpweuHhnz+MyB+xxfTd/CLTcIt42Tse4aWp03sQL2L5GNeLl9dVL9bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OemR/eYkoDOr+JRwGW48o7EC5+YCpWeVQEBXEaFr8RU=;
 b=ZiPNlU3AHId9pnWNzIzs5QIO34fsnzXuCnHhJc1YpY0OwQ2E1UyUzQ6TMlsDbZz8N4WVvSs1+zupXsCw7JEpmowwthlic/OC8FpGVugYoAkCFmhdaHdziUtuAjJ8oWevBIgALgcBFiOLbTFDvtQWCasYFEMVjXUA7FpGC5pO3QA=
Received: from BY3PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:254::25)
 by PH7PR19MB7729.namprd19.prod.outlook.com (2603:10b6:510:246::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:58:38 +0000
Received: from SJ1PEPF00002326.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::96) by BY3PR05CA0020.outlook.office365.com
 (2603:10b6:a03:254::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 08:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002326.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 08:58:37 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 3185E406541;
	Wed, 29 Jul 2026 08:58:36 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 2282382255A;
	Wed, 29 Jul 2026 08:58:36 +0000 (UTC)
Message-ID: <0eb6e134-4dc8-4b67-a90f-7f410aaa39cf@opensource.cirrus.com>
Date: Wed, 29 Jul 2026 09:58:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] ALC285 + CS35L56 (ASUS ROG Zephyrus G14 2025, GA403WR, SSID
 1043:1024), no speaker output despite correct routing, gain, and DSP state
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: Aditya Sharma <aditya122sharma@gmail.com>
References: 
 <CAEF4ZLNsnnATjgGAFYim3t-0qn=LHx=LeEid-jQULEDvN4aQYg@mail.gmail.com>
 <139dca26-4c88-4b60-8af3-5d5d47ef4551@opensource.cirrus.com>
 <CAEF4ZLPMZcb_g4Sn5c-B_eaUYfPkonYjZ-i80waJxb-a7=WhEw@mail.gmail.com>
 <12e7819c-522a-4c75-a744-252ec593413f@opensource.cirrus.com>
 <CAEF4ZLOMwjK2HaAy+bkZHvtHwHqyk_GsE6B_uCdHjVMf0V=_-g@mail.gmail.com>
 <e2e2c039-9b4f-4cec-a98e-a42e04d15a71@opensource.cirrus.com>
Content-Language: en-GB
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>
In-Reply-To: <e2e2c039-9b4f-4cec-a98e-a42e04d15a71@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002326:EE_|PH7PR19MB7729:EE_
X-MS-Office365-Filtering-Correlation-Id: f51d9815-e7f7-4cf0-5cab-08deed4f9445
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|61400799027|22082099003|16102099003|18002099003|6133799003|4143699003|56012099006|11063799006|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	DjFG5dB/9QUDuqwhcWU6L8r2D8TIEcfu9TGvOzF74X7du+WNJWc+3Y048jBj+4Hgl119rrqQDoFNAi7aHLRkn2GcO3i1Dvuxzp1cN4GGp0rG3N2SPN6I/bLKSZJP1Ttc3K8alKE5nVwXbez7VVs8R4JFXmY8fk4GQcXMwf15BF4deoRjJAANiHLtoydK1dp9czc7bjNUI1b12op92UWqlAy7N7WHkqLW3wTeCms+s7hU4gaS1WOO/jyCRfr8ldSpFNcbljyyP/RIM5NFmwMZROcTrTPCmwsAbQvQ3qWSqCctuidqHDZEh+QeJgvVF8oGkmTSDSkMObvudaZeBeQONv7DcsOpI1e5RcDbZxaZb9wvE0QCfq997C1wTxyDqtmtb39elss7pkDCAocKr7euNQOZEOZ73EpkhnRXf/glwpL4gn35LYX48XJbh8zsIQrKO+UGi17fQ111dkpIKD6t4jE7pqJ8tuzYH8o9lTMVQvSc5PIWdx/qWm+Ni9zDbiLCakyJNuW7RgdsziVAiKqT1ajEz546+YNXZnQ7titrrqddi5PeErwViyVDRVSIeclGNW1pVPsjsCdgOqm6IPaIfQRI/gPwVBiiI0CQjMN/E3z7IGRkWzHPYHfxF+A74LjDR2pfdD70n9M040ltuAIe1g==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(61400799027)(22082099003)(16102099003)(18002099003)(6133799003)(4143699003)(56012099006)(11063799006)(10067099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	wraE8ilwMThC0NHAwfnCqgTJRNVvM/dGZgieWeYBVGyr3ZFEH8gH86RtcYqYN6cJn1U0p8u1kW0tZkw/P3Ojfgn2unWdYc/Y3j6NrqTvmq3ueRSlhJFq1g3yF21nO2jSDcuxa5MN8LmgPzp02xK/s8vAC1AbY2G2K4aSzKp+EZGJ14XFJxB92+4/d1wsOCtwW99HGbwlOjzkAH3lTEaq8l46Yim1sK5FIPS2q5SrZRLcPvOcfyHza1OqZuspa2NMrIzhGHGOt6dn4acqclQ0KWJMUsPW5q299y0xw3cwqhtkaGlmmRqJoEBqcUfXnIemg9sQEEm0NyAKjhgGceon/Bh+PF6Tn26D/KlK3HULYKn66k9TkDZHoWx87WQau8rn3ko6LcjZtMNtcD5FRNFHs74OEb3Luf8e/zPw3EAzLxvx/V/h8EyYpSj8baNnHHml
X-Exchange-RoutingPolicyChecked: 
	kxEiBYPzu/bFweC9IYX0NPit6gMi7HkCNI4ETYVMfNTPrPqdr4Rv82RFjN2k1y0hkC2WJ8zuWkL5HrAhg+p8OUlCAjryGBItntJ5dxnaXObP3983dYcCWL1aZ3iZFe8kmTLWSRqkG8l+0GVpEdeuRSm+oe6fE8bcgd99gQkvzuHOJJTVA5e4r2GZWHRhSf/2pbls+bMzgS13ymeBQnQWdKZWFDDMuz5VsDuM9Aj/UCFFf4eKG5u2tJdKDALDpD1GO+nflhg6YywG+JrTd40+fmgdhB91UDMp+7u745hq78bI/DIquWqjN7cUGiJe7FTF61V02KeA0tU8le5yU26OiQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:58:37.5741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f51d9815-e7f7-4cf0-5cab-08deed4f9445
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-SJ1PEPF00002326.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB7729
X-Authority-Analysis: v=2.4 cv=Js7Bas4C c=1 sm=1 tr=0 ts=6a69c0c3 cx=c_pps
 a=5/VQbJzMw90GIObl+oL5Zw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=UHee4tOLAAAA:8 a=yXpOqjdSHbVuzwxE_74A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=KNK9wNnfpSf3szJNvdWp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3MiBTYWx0ZWRfX4eOGK4dPHihL
 p/PI6rfr7NGrRYysyB07TbD7N9F8a6bJ4+Hhz4F0lmD1sCclJIn7CUEDQyWgDz2A4Rua4qQgOqs
 vMhnGxtDSXOJm4u2LaFguFUvHt6FvjwTK8WCyLTSxrssvYYyDisWbOfKgFWF7X1rqc+3IMCoxnZ
 2phv6Mfhoh/ggmZ0GJjGl3X/k9Wn5oaa6AvH23fZUrPBjC/+H4mj5mXYcH3Xe2yqartWeZgw10e
 0Iz4N4lZMeAb2C2jWxMJvwyi9uI64uKxKtJAIGStUSzcm4HO2KhRUNUDyc44T93bn8qiM+fjHvg
 zJFUwSs79/+yS2S1xurNnnRSV12y1tnoX1sbxSE4M+2x0m82TyU+E3daA0ornVtPYKS5tM7VQ/0
 pY16fm5I0kuPcBxurVklyNcs2e0PTiDbmYMG6Yq9FRanaLnOV0sa6ZdeA2T1GQSN0Ql22JbSgkV
 c4KBn12qWaYgCispq7A==
X-Proofpoint-ORIG-GUID: ZX6tW6LRgqhgNA0mH0r3YcZvHAtUR_k9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3MiBTYWx0ZWRfXzojk1b9XN4V9
 BtunwOrlE6j+CgEMrqgni5Dgm6tGOaGX0FfaMwThQoD4+W426cUp5GqDeiMYTAid2VqtUNlGVE4
 Wn2Ltbd310Xp04av2XM4Qy9e7MWcw9M=
X-Proofpoint-GUID: ZX6tW6LRgqhgNA0mH0r3YcZvHAtUR_k9
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: 5E64PFVVEWP2RXJISP3USWQUDU7CQVUZ
X-Message-ID-Hash: 5E64PFVVEWP2RXJISP3USWQUDU7CQVUZ
X-MailFrom: prvs=9670350787=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/5E64PFVVEWP2RXJISP3USWQUDU7CQVUZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 28/07/2026 3:17 pm, Richard Fitzgerald wrote:
> On 28/07/2026 2:44 pm, Aditya Sharma wrote:
>> Hi Richard,
>>
>> Here's the registers dump for amp 0, captured while speaker-test -c 2 
>> -t wav
>> was actively running:
>>
>> https://termbin.com/1nsu
>>
> 
> Amp state all looks ok.
> Amp is powered-up
> I2S interface is enabled and set as the source of audio
> PLL is locked.
> Firmware is in play state.
> Audio is unmuted.
> 
> The state implies that the Realtek is providing I2S BCLK but
> not audio.

Copying this reply to the mailing list for anyone who might be following
this thread.
