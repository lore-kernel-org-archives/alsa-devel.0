Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19156606A33A
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=a+Up3o1J;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=L3FVI/Yy;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=rMQD5LVK
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73F1360222;
	Wed, 21 Oct 2026 18:19:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73F1360222
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792599564;
	bh=vev0UkNqMtVKTTtVgC9kZFroc/haUslzAl4pqvN2xc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a+Up3o1JX8DoG1iTR4M1ZgJr6+dHXapQ7rGoJlYKGH25yo+UaOEnHOtrSkmv/nn6Y
	 3KGsj2OYwEcgNXg8xMJLsAB6a1jYY+ouAp1E9xsm27PJr7LLECquv3SvZkuSxsO2rH
	 +EfhCG/O9o1I2K5e1AecnDLyVNL6jiZB8hSqRuBs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A1C2F80601; Wed, 21 Oct 2026 18:18:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 465D0F805FA;
	Wed, 21 Oct 2026 18:18:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 27F34F800B6; Wed, 21 Oct 2026 18:18:42 +0200 (CEST)
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
	by alsa1.perex.cz (Postfix) with ESMTPS id 11B6CF80095
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2026 18:18:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11B6CF80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=L3FVI/Yy;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=rMQD5LVK
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JNi6BB3322721;
	Tue, 20 Oct 2026 05:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=dhAdJcj89xOw6+PPAO
	4ZeMzav4eC9Tn0RD1RYLRph8o=; b=L3FVI/YycgfS1dziOygomQBqfFnP9RoQPC
	DK9kLs4wngRizujFrD89cfv2pVnQIzNh+HJyfrQR89qIxTZbY5VplavwIcuFGaCz
	BR485cQc/dUPAYRbJ25VuEpZTuDmWVanGxpTFjl0GEJ4VU1cS8wy05idzIqjNgwI
	L2Wfnl+7r+7iRiVNKCY0xzuXyeSrjD5RZZxO+YyIQ/G3ofqviBtplXIp1VbHA9XJ
	vEU002nlGrl3p5NplgoxNmK3d56KGDAENT9OLvdAjypO8qNxtduTCDLUv2IzIjNx
	BxJ1uswPsgXj+zwnA0tWvXDiCE6vzXGqJ7SsY+rUtw+0naG40E6g==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11020118.outbound.protection.outlook.com [52.101.201.118])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hdw4vrmv3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 05:15:07 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vjweatq5vs6r/115/ME2wfzfBBSJWCr61XyqHg6AF2n/qfJRcMK5qgNgfoBdJj0VKhZKaMl8E244+Kd5+Jjx/FWdqrGfTyfKvfgqblazsy8FpE6uA7opnyrspNgwT5hUmYnZZ1uk00J26hpXQfvRhoe9Ro/lBjH/c3OUms01Vf8Em5uGCbpXevF4rstkzevWCMyoceiuGJcd6P2F2JDd0c6Ljh54tSdNriWnmyTVpJbPEcTZzJUIVBQ+RnTGZKq2MGtodMkSyycihpZbH9vefr/1uEPyEnZUSM6UYDI2FIYS1GYmPwKIse9VnEkW/qmWj2hVCALAo79zJBXxTY6zXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhAdJcj89xOw6+PPAO4ZeMzav4eC9Tn0RD1RYLRph8o=;
 b=DjZHbKSk4cNOOhLi7myJ5bAF88gAQLBEHF+/50nX5dC5lihjAw+kOc13jniNy+WMRBB9r2LuI+yTuGfD2Zlp2PR2XBFFBoBLTZxODzkcKw4dGHF5gu/Dww/MdbaqsQLtJ91VxOFFR+AVo1kHPfPaTu9OkOzbc2zbPEYTB7EmSQqbuBJNeKqSZmmEcC//sfRu7QUzQUjTx1WTHZvlX3DD3LFoM3ALYh9q09SwIlhdyS16rgbRz3efNKe/2FjjDZ8QC8+4HXkkaIFPlrpk7+hu4UujjbAMtSDNyQP/52H6DB0fTG9ZDU5AukQqe3O50Y9B0vQxF54MVfiLpDTntNdWmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhAdJcj89xOw6+PPAO4ZeMzav4eC9Tn0RD1RYLRph8o=;
 b=rMQD5LVK0J5EgBvlMzUPxvINalAh7PdaNI2WLHJVK3BjwW1jPDnKE6P7MNoxhPmbw1+767lpXcV+lpzHTkHqSfK04GX59xQW1rUbSiCRaxhGwrWmbsdjcKOl5GogKsySkfJef7a3ClNp144WkbGLalBHh8VSpU9r+OfRRvaNfOQ=
Received: from BLAPR03CA0105.namprd03.prod.outlook.com (2603:10b6:208:32a::20)
 by IA0PR19MB8017.namprd19.prod.outlook.com (2603:10b6:208:489::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 10:15:03 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::1c) by BLAPR03CA0105.outlook.office365.com
 (2603:10b6:208:32a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 20
 Oct 2026 10:15:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 20 Oct 2026 10:15:02 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 46C10406540;
	Tue, 20 Oct 2026 10:15:01 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 3334A82024C;
	Tue, 20 Oct 2026 10:15:01 +0000 (UTC)
Date: Tue, 20 Oct 2026 11:15:00 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Strozek <mstrozek@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Sanyog Kale <sanyog.r.kale@intel.com>, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] soundwire: stream: skip bps mismatch check for
 PDM streams
Message-ID: <atc/JHXFhXnGmKOH@opensource.cirrus.com>
References: <20261020073856.1177749-1-srinivas.kandagatla@oss.qualcomm.com>
 <20261020073856.1177749-6-srinivas.kandagatla@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020073856.1177749-6-srinivas.kandagatla@oss.qualcomm.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|IA0PR19MB8017:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be94e77-29f5-4500-5e80-08df2e93014e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|61400799027|18002099003|22082099003|10067099003|16102099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	V0/pr9VzIis2AZ5mqGbSSytz2B48++Ts2RUmYi5bkNtZl0RJo4M40jMDqFri6oU4PYiA5Ho3CO1yUKidHzvlfXCNGKZpTHJ6B5fOltqwWSpdAP3HL6lTp/gsQfk4g4hI8IGhQY9xlhzcqF3xY7fFLnb9ahakkt3k79RfkeAgr9RT0oC/jqmbc8m4iRwQzFxvkSmalXWjkNykwPx3VOVK3S5gVN06iyGyNrBZI/Umj4IFNpp1F07XolQI3Dr0/KNnfsjFD77BygdBc4RBlHP8yq3vmtDYw4tKk0mM1UMr2nTghOeNm+i+elPWeRhHGGsND4o6+LiaKsh6Nux0c2DepBrjweyiUoGsAuuGRE0krmWLuTY2MlHP3yNsjvgmkKfstNLB4BZS3HC60cEygCJwUCSJgOel2Z7vH8r0fxVaWQER2xshQBg6QJc4QCTMv0kYJ3Lzrp57coknJPclXBRwcmfDHWjFeOvN6Lt0bckud2SJiTMcBW4k+8EBjOKy5M5BZo4ou9mr+yBLexf3sZSmfs2mon5aFNsxDP3KJFzYOlZDlaSjNKH/uo04JvSaaj/fPFr9dsqFgB38sEMt1OIHgz+SO3RJZAKK61f103pD8xu5N0OqP3G4w2Mwc6KXyhZt/aTcMr6gcSi3w8o8pyGbVw8ltVeQqh5ZlkSoWr0vxNGUiLp1efDqMOj8nIJ9N/K78FPF8mflMe9TY8Z36u4LlQ==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(61400799027)(18002099003)(22082099003)(10067099003)(16102099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	a+Un7UNqyelIdCbqMODRzWiRdmvLyK58HLis4v+Y99bnGxH5e3yWbfIcfHbOLD5T5WuSfmMSYnrZtVpHqFaCqPYc342mMNXLab4lp22Nys3vZZmidsDd8TN53/RJDAkfCQjD0CKL5Z8CBW1AH2CMcu+amRACxuZsaOeDXy1hF+42lGl3ifUZCFign2ySGxxDvh9FWsA2J52UMxBLTDFPvzy3rKOtbicHxZ0IR+FWWPvdpIijqNh4uCfUrHP4Ep9bR6ca4J083+KhpyJM40ZEfCDqJrDudL3/nCnK1ytDMIK4gNaLbrIlj27Jqn3wHnLdy2NYW4hTL99YulhSIXHdojp8UegCUlbOC0OFyC10dPVug/kWbCWxy0Kz/+h7apzR/r9usvjwMWkc+FY+PE0iQcKC34yhVPQ+O4hcCLzHGJ464m8BZ1c5Gde2U++zCUSU
X-Exchange-RoutingPolicyChecked: 
	gu9ywQ3rZoMPLN0A67gejqvHMty1eQDoqMHK169ZlS10YPv+WO+jDJ9MiY1Gvk5nzwr1G45OVvM0MY6pHvGfrVoGMlh0yJzrKJCZZ3taS7xXg4cSjp6op9dU+rqkHkEoPGIaQzp1T9QTFFlVITiQHT3nm7HQwpMb6SyQEnmPI3ACSZ0PioQOMsihnBFlmibk5BnDMhsooaronK7KP/dYnb591GFapr61a8+x+Omm2Rw26x3rsvx9NskszNqcqay5xnnyzhOo5cKwSGUhaVv3s+VIB2KWlIefUi/77/PuF0pV7hUkwuTKmThlWoEy/CN7NRD0HXCPYTjMCq8CmhyoPg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 10:15:02.4685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5be94e77-29f5-4500-5e80-08df2e93014e
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB8017
X-Proofpoint-ORIG-GUID: np9DoAovn3gGH_Ao6LQyh2YvPm6hnHFT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfXzbmPjKzIq1/6
 DJhO9R4fx86i6gtit1GrhQk/L38WJ7t4ovtUp0Rjibz31eAVl5m2v2Zs4n8Ip28s0ln7WB+Ulz5
 p7u8S1XyE9WFDaT0+dSkKYYgIOegpA4=
X-Authority-Analysis: v=2.4 cv=H7tOUOYi c=1 sm=1 tr=0 ts=6ad73f2b cx=c_pps
 a=daxDSgogzWWW+9bXC0Fifg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=EUspDBNiAAAA:8 a=w1d2syhTAAAA:8 a=d7I_cDyD37dtnOBkwXQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: np9DoAovn3gGH_Ao6LQyh2YvPm6hnHFT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA0MCBTYWx0ZWRfX6F3fQpnN2Awl
 c+wF9BIxTH6omWbUQwDThKLCHVy48M/AFT01t+RUW5bbZgYIU/GurbIjJUeMm9AxEzO/Xbe7Eyi
 1YlkYeIdVTAw4skAm7yYYHF5lMKCOX3UZpgYlxeRl37KVFhoyucf6wRz2mrd19jBI0q+5fiEBV7
 u5RRbrJrav5fEcxpvEWUeG/2kJmJDucf4ljnuvcp41Wf+glAmtwzFYdgR4S7+y/2UgpfSdriONf
 /2iqJUfLOdrwz/C+P8o1o6mmHxowvLHp/QVE+vbHbZ+CvsrUvUgl/f3ABQTLgQWqEKujPWB8qf6
 R1yglSUmw/3NsVkjmf9zvlsHSem14XVwtziBU578Q3HKJFTaCwq5dAP614gMv2HsUwCML6TRkKj
 L113leirtku87ehOvI3uDEVyHrCDrlPFjhPxgQ0Xqim1/NNOltDy4CfZ40OqO9PjhlELMjvputO
 SPqeOfMaFsppJNt6MwA==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: 46JMQY67PTYRR4JVZ6XRXOAFMZBXA4XD
X-Message-ID-Hash: 46JMQY67PTYRR4JVZ6XRXOAFMZBXA4XD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/46JMQY67PTYRR4JVZ6XRXOAFMZBXA4XD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On Tue, Oct 20, 2026 at 08:38:55AM +0100, Srinivas Kandagatla wrote:
> PDM data-port terminals carry a wire word length defined by the
> stream payload, not by any host-side bps field.
> 
> Skip the sdw_config_stream() bps mismatch check for SDW_STREAM_PDM.
> Behaviour for SDW_STREAM_PCM and SDW_STREAM_BPT is unchanged.
> 
> Assisted-by: LLM
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
