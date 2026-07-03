Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031D9C43458
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:52:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66785601F0;
	Fri,  3 Jul 2026 18:52:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66785601F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783097570;
	bh=7A9O9lN3mU3UOmHo66lfx5Ge2JwqT6dRFkveEikJhf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Flg9ZOXrK2z7tKhpBD9JDnnlP19nFuYREMUvAIas2/EeTjEkq054AskPEI3U8aXJ/
	 m5+xjXl/23zUrtMInICwBoO9sl0FM7yCaMj+ppCJ8AQrMvtsDZwZxdIV1Y/z3ptvU/
	 cH7knGMooh4q0KZBvRLS/rRkxs1u6HgmTzCWp93o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CEC96F80608; Fri,  3 Jul 2026 18:52:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DE0CF805F2;
	Fri,  3 Jul 2026 18:52:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D08F4F80579; Fri,  3 Jul 2026 18:52:11 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.34
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783097531;
	b=CHyjk+Re6HclXTpBXKnfNyCmSntIUEpsnvD0slfX7u/P+W4xpkmWrpVQVq2N8Q2fgEpp
	 nvKSBO93Ch5XGcZ9vyaPcEfAB2TFI/COtXBt01SOjHIFVLpsK3jaz4szXm/LN9jYgjaAQ
	 b5SA9QkutxwmAOex1Gp3Mwe8eiN4NtToU0WSLvIS+vC6pjvj7jR0yEqgYPGafSc43MjKt
	 orQ80x5EfnTJDa01f2xuC4coE4Id6GtJeEFRgBXWw2eiHoSl+J33kSwvqBcv2NtyZcFLT
	 TqiaW4Il//hWUh2vG1l4Al751DwvjkxO99Yyg/hF66drPcF6rnVQslOsh8DVi8xpVvQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783097531;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=7A9O9lN3mU3UOmHo66lfx5Ge2JwqT6dRFkveEikJhf0=;
	b=phJ8delyCaq3mg3o011CLwQGNx2fz0Jglrj1/0LrnkizlYEc/cKBWx1UapqzLjqW9BAM
	 ZYAHKRi0npMSUFSALJ/SjooFa2QVC6IIpUiCXzevv23DCqBKEKsDvtdhiIdtsXc0TpmTA
	 e1yvoTvRjkvnhwDttsqGWKPuyHQnxAyy3RGhjzO4roIAzVxeho00t938HxHfPTWBKv7AJ
	 IZ0u2cSUpc3207jQJVCe24tfNGO2sYqoK9A3xEopApPpBfKGD4eTQEwYQz8xE35AnRaFr
	 VyQpxratS1Fu+lyapqSImhtRAOBvsSGCeH2E93USXgPJIxjTI6Kb4lM6KEwAOo8StQw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="V/qlbFLv";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.34
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DBC52F8011B;
	Fri,  3 Jul 2026 18:52:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DBC52F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=V/qlbFLv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMA2O3pP8ga9IZku1f0IMZqVnXbqcPy3K3GaUDfjg2bkrrH3mTZjYt7NgIogJh6AHJuOUwfVtFZBxFawgAtWWuR17rih6khxflDy9FrxUe5XLwZ4oCIZ8EaaHBMx1R3JKJCWNGr1sviWbZCnQ/7qra+BQYPEzYWoX6Zx68UDwh5mytAnODBNWxAfMWge6doPT3BynoOUVvR711C3yeLslrEPdpaQvSXHypX2puM3YKKG/f59xersEniPplI+DA5EGODsSo0QwqLQSxc8+35UTbex2X4Y+SLavmo/gXu1f0AZklXiJQCoRIItFEcMlYAH+AdUdUgfL3yCQYRcIBkXTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=djwN+onx9sT/F5DCWzIsgZcmeYPt1gIeAkHmb4buoUA=;
 b=VN7g35NPv/eeQGjYJBvnrGSi3Zs/o6HqcB92ldryhxDIx34oCC0ap+H7FXmBxF1OIc9PkO8rxYAS5Ejs895T7jcRu+I5WtQpEwiXY5nK9Gq768XFnT7+eiksvwdUwB3NbWi9WDPyQvL9E2IpqCc5WMmH8tMkVR74ZTth7Oegf2ML7IgHnMo5x+Y0X0JGFyC4ydK9NJCKNgKcAGkhXQlM8b7zRxwhf1wyY0sY5/AImr3jSA2+MrhYJGtxVXWAYoLJjmLYG9qerEuMbW2CNsBvCu1gEarX9Kpl/g80DKdgQa3XXQc02AShM0VGO4qm559Be7UlQf3Vup+ozZNja4MuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djwN+onx9sT/F5DCWzIsgZcmeYPt1gIeAkHmb4buoUA=;
 b=V/qlbFLvx2M5oQG7gL0GHZ0rVsZF3ImjWl4xqTFhyoM/8Oo4SW6G1N177UYrfRRwsuFkk8T3guQ8MAzHKU2odI7eAoPksMVv6zUNwAPhtRuGyjWlPR8Ysl+99MRzZO7wySV0nDU7DJEw9+R9LrnnVsdobhZ0M3SmkH3782LaiyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 3 Jul
 2026 16:52:04 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0181.009; Fri, 3 Jul 2026
 16:52:04 +0000
Message-ID: <68d6745f-8bfd-4b1e-b4f1-33190038566d@amd.com>
Date: Fri, 3 Jul 2026 22:21:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] ASoC: SOF: amd: add system and runtime PM ops for
 ACP7x
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 perex@perex.cz, tiwai@suse.com, Basavaraj.Hiregoudar@amd.com,
 Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
 mario.limonciello@amd.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, sound-open-firmware@alsa-project.org
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
 <20260701095759.1012929-17-Vijendar.Mukunda@amd.com>
 <58e4579d-f87c-48db-9682-fec99c4706af@sirena.org.uk>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <58e4579d-f87c-48db-9682-fec99c4706af@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::12) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: c7697bf0-072a-458e-2f4e-08ded92368d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|4143699003|11063799006|18002099003|56012099006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	j6fwNBeJwx0pvBKvUnSQjm03fdoMp7RIKLFct1ttFhXj2bpNhmn7c2z/uF0cdg6G6FInlrtkk+UdyFwYSfWf7mEDK+Z/KyjeQzOe05OKRwfa2BwRFFtqMpzU3Pjc93NL3WC5G5HR/awqJTfIjvuX6ehXjpEYuaFC8WnewosoBSxzWAXGNZgJa7CmzJ9o9luRRpRqRrVec8Jrteb4N1tbGW14ayyFBS+QDyFNp0s6+ufoJt72qixqZ2y1cIB9ofNPR6RIfAA/AMEPcQALJ1G3MgxIWVX1JNLfJzDlUebAWFXQWcgOAiWG0tWlLLJioZBGEsqt4blns2PEIFQBx+GWRYpc9jCPKqPuN7mwmGZALR2J6wDMIHbcX4NsDoAzJ5DuLx8k1Glk4sOxvLKCDoYX8Nmjpqm/VnDJ76SaO+XG6Gnmt8WVfSWDnki3cXzNadd5Qlx0empXGkLXVGo/j8YKo0wvldngg31HO8M8A1iRFtgxc5/BbJMrqh7U44zZMZVbYjMnZCIRGQ8fOmxVyJvRgG51iBhJqvjXGhRpatcXjF5wdGmenZGoQdI9o9YgTb9zOJuQ5OhLzb6xjwo8yO/1ZaKALgSHY6+6kjsSxWnpjnfRec7rqMiDp31g4Cp34kGyyfucDRGKVav3HpiV4vhZUiO9EB/LAlxHcOqmI//0YIw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(4143699003)(11063799006)(18002099003)(56012099006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2MxaGtXNGx5ZWZ2YksycndTMSttTnUvQXd1OHdBdXBabi9HRkE1VzU5T2tn?=
 =?utf-8?B?OXlSYUtPU2t6SGk4TnNlNWRmWDM3Q0R1Zi9IUjVsNXpscGFPcXZoZlBQZG5M?=
 =?utf-8?B?UHBrSGx4b0NacEprNmdXQ0tBTE9jY2JzbGg0WFY1U3lMaDFwUDE5c1F3bW1Y?=
 =?utf-8?B?ajZneWV3VCt6dHRwbHY3WWRtMThLNGZaWktUZ2I3UjNCNDBCVU5ucXRZd1E5?=
 =?utf-8?B?WTVRcnJSbVpPUEFhcDFHTTdmMXFvcjg3UVN3ZmJiM0p1TjNjd2YvWU9DTmU3?=
 =?utf-8?B?TC90b3dIVU1JRHQ4eTFnNURFRnNPcm1NWWNNUGsvWE9BYmJ5ejh6T3JscWUy?=
 =?utf-8?B?Z1RrNjJqTkk0TDZ2VWNhZXhqV09iZXViZU96ekx4VzF5bkFhcFBXdzdIQ1VT?=
 =?utf-8?B?ZlpSM01paGRyRC9vOTdndktJMFJrUDJINGdtTURKdDlqVUdGcUdsNzA3a1Fn?=
 =?utf-8?B?Y1BrZ3crdmpmTkJmWFIyRkYyNStWQ0FoWWxhMXZzQXVlWVJPaU45bDJINmtW?=
 =?utf-8?B?cmpocnd5enJjRFdBSGM4YUNBUDNXMy90UWEzN3BqOGJGZmxjZjVXdG05Q3kw?=
 =?utf-8?B?ajNWT24wd1dMQXEzR0Y4clJBeERNYWRYY3FYNDJqZDFESUdmeUFudnNHQmFF?=
 =?utf-8?B?eU05empKenJsNFB0Q2Nqd0tVNVNrRS9DQVNMWStCYW5ONmRhSFdhUzYxVDN4?=
 =?utf-8?B?YTgwOUN0ckZvRGtLbEZjUzFERjQ0UVRiT0xZTnlRWjQ5RWFHMzgzeGV3YzRE?=
 =?utf-8?B?S1FFVHU1cmR3NVB4emZjNG8rVkZZWnZMVUtlSTErVlFYdzZWbzRKTzZRd1lB?=
 =?utf-8?B?R0JPMnZST0NUc1NGNVp1b0V0OHRkcTZqV05TTFBOeERVcG1RQ042dG9uM0Fl?=
 =?utf-8?B?RTBVL3pOM0c3SmEzOCswR0UzRldMZlJ4RTI3Vk12eEJCeEUzOTZjNzduaE1q?=
 =?utf-8?B?ajl6b0Jkd3F1SFZwV0h1aWh3ZjYyUXMvNHF6ZnhGMk1xMWxrOEZRNWx3Z1N2?=
 =?utf-8?B?WXFLVHRKQlJiaVdqSGtsYzhtVDM0WTdyZTZiajNmNTRleHF6Ty9VWGx4eXcy?=
 =?utf-8?B?RnBETEhZbWVYem9LN1cvTFdOUVNtVUVZZ3JLdy8yTTJwTUhad0xISjlzdmFm?=
 =?utf-8?B?UWRhWlJucWNxQkV6czloWjl1UkU4R1B3UE5maXBBVzhWTEdXaWhMTVFGdlhl?=
 =?utf-8?B?Y3pnSmJLWDNYYWlrR093c29KMGpEcHdmV0FzeDN3KzFFcVBmR25JRm0wZWht?=
 =?utf-8?B?bFA3cUFPS2hOWkpNMWU1eW9ZNWhISVFsT1JiYlkvOVJETTM0TnNHdmprbHZW?=
 =?utf-8?B?bm0wdTNsQmlINkExR1E3ejN5UC84Q3pJYWsyYVZDVHdVN1pTeURHa0xnMCs5?=
 =?utf-8?B?NUVjSEpDclp5R20xRVhjbmo5aER6WlZHN1RxazhySzducENqN2tMRGpiRFJ1?=
 =?utf-8?B?TGxmdXJScWw2UElMYXVVTjVXVHBrUWlad2k4ekE0VDRCUE5Pc0VFeXQvM2My?=
 =?utf-8?B?ZUkzcDJJQU9ZcTFUK1A5a0ovNWZFNU5iRnhzV0l3bmtVb0tMcXB2MmJET1RS?=
 =?utf-8?B?cjl3VDJydmJDR1h5OUxuOHdtNkdsWDN1RDBFaldzUWkrTTJodVREQllsdUU5?=
 =?utf-8?B?OTFYWG0xMWRXSFB2WG0wTFVzMVJKZjQ3R0dmMHZCTDJtcEpNTHU4YUpnR0ll?=
 =?utf-8?B?V2xwcGFkRXA3VVJmdWZTOVcvajcxY0x6Zkd1L3NQSGo2Sml3eGg4M0JVMTI0?=
 =?utf-8?B?MDZnME5uWWRpS3NVUXFzdkR4SVdQckh2UkxWUi9tL0R4SFdlYUdUa3VRUlFu?=
 =?utf-8?B?Uy9FdTBYZk8xQW41a2pxbHFPNlhzNldxOWpLdDNibG44NXlNT2RJR1crYmNI?=
 =?utf-8?B?WE1scS9TN2UzTC90eHB4NkxaZTJkeWNlbmhOaTZDSzYxYW50VC9ZYkJoZEh2?=
 =?utf-8?B?T01MMEErVGkrWkdkc082Y09URkg1ZWp4S21uMDFNeGo4eW9sRjZmbjhuSW5H?=
 =?utf-8?B?aHJLWjVmanBLMzl4UlIxU0g0R1ZGUXJ4RXg0MUlJcHljVjhNYTZiamdETnpk?=
 =?utf-8?B?YTJycUNkdjBjZ0I5dmp4YWhoRkJEcmZOa3J2dHoyVkhTaGIxdi9ONkttdzNj?=
 =?utf-8?B?QzJnTXV5Z09GTVFQVDFXWjJ5WGo1RFArZ2RjTm9BcDFJb3RNUE1EYlVFUG5R?=
 =?utf-8?B?dXlaQjBweVNwWXJyTS9kcFBHd3RTcHpzVVVmVTMrWEowbUI5eGg2a2cvWHRr?=
 =?utf-8?B?ckJaNDdOS2RmTnFsNmhYYVVBRS9PMW1TalI4Z0FzbEcvQkFWZGJsc0VpZUtH?=
 =?utf-8?B?anZqRG0wYnJoZWtOYnY5NEJZdVdReXRoVDh3eHYzRFZNa1I3SlNxdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c7697bf0-072a-458e-2f4e-08ded92368d4
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 16:52:04.2664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 EUtIEvxFMKXQ4PoBW8hC3nKTLCi4ymV6rTZ6p0beJpoOGvQlJI0oZ9TX6B36GWK9B+UpqhINjDBNWF25IWi9Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
Message-ID-Hash: TIEIFFKK4EQPMVPWRFGVJ2IIDLSJQ222
X-Message-ID-Hash: TIEIFFKK4EQPMVPWRFGVJ2IIDLSJQ222
X-MailFrom: Vijendar.Mukunda@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TIEIFFKK4EQPMVPWRFGVJ2IIDLSJQ222/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/3/26 21:58, Mark Brown wrote:
> On Wed, Jul 01, 2026 at 03:25:17PM +0530, Vijendar Mukunda wrote:
>> Add amd_sof_acp7x_suspend() and amd_sof_acp7x_resume() for ACP7.B/7.F
>> platforms power management.
> The interrupt is requested with IRQF_SHARED so probably worth double
> checking if the interrupt handler is safe to run while the suspend and
> resume callbacks are running, I see we reset the device during suspend
> so there might be some risk of corrupted register reads?
There won't be any corrupted register reads when acp reset sequence
is executed,  all the acp registers are set to default values. i.e 
Interrupt
control registers are disabled. This sequence ensures that till interrupt
masks are enabled during resume sequence, no interrupt will be asserted
for ACP IP.

