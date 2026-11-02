Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113B9606A324
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=AljtRtSi;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bzka4RC+
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C8C7B601EF;
	Mon,  2 Nov 2026 14:44:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C8C7B601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793627065;
	bh=PCAsHE08X81+SVD9kGRb6UMcFQp9sI4wn9HJ7vIFey0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AljtRtSiye2uI6d9JbQCfc+CPXr3QnRKjCBlVsIfC3gBr5y0vPM+cSb0tUuDdSo50
	 BoRK1se1nfa7Tr077OZwX9ZC4qal/caEQJp3qoS/3mSbRPQShKz47u32xiJjo1xtbb
	 0i8cDIgb/ePCZP1zc8dRjkYnurq4TZgo2NwWLC0A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D3CEAF80605; Mon,  2 Nov 2026 14:43:46 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D947F804B4;
	Mon,  2 Nov 2026 14:43:46 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DAD9FF80424; Mon,  2 Nov 2026 14:43:41 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012050.outbound.protection.outlook.com
 [40.93.195.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8AE30F8012B;
	Mon,  2 Nov 2026 14:43:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AE30F8012B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=bzka4RC+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aKkaCuK2sEz2QrSVgEyUsurjssay1j+/LlOdXAZfaa97bqsGXWuXg308nQ30jOxKs7EAkYTO/8Q6u/kf8IPSUQv+9lqWwDw7yUfVbJ1yTftG65JORDgVEyoqqAkAb+cRrDe9IDUX1m/2X+OKzy/7PhOwSCNEqXc3N1MLWAutBO23tNy+H545PvTxcCQL/Dvja/CGoIdLh6lzqpwEJcD+JHHFWmqyS+NCl4PyXQRoZPxm1w9rGx5Rf4elDAP4rOmLAfJ9DreOdrYYtulCJLpM+Rvk6YX/k9d9Sinzul1S3zgTrAsdCmkxSCI9NC2LVUzJgwUCkrTQ2Fmit8/cnNobCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpWhoecmVyd71CSvsgU+LM3fnFQdbxavgjylKIsZ6AU=;
 b=ebJ32QX+IK1SgDd9hT2MTXJSy7Nt3yfJ82iy08suYUi1s9h2dTwJ5pepY0cke4HwLN7uAZ3FvBGEnrtdn27q/MpJd28hYUbTzZbVmUhCttGtTPKxB43a5pRF4D+LYdUzR1wlYBZ+SgBd9iHUm5Vh3Ov0KhoPUk2nE5z0k4KheBzsdvMrGtIVXpqQ/9a0NePeepJzz0eHNNwGsMApnCA5NZz789L2/TTjERCg7e5oC3SBWhD/gsKQ2Ui+6OjKZAmfVpJgt2osOrwxoBPGEOUfT9exRILgstMexl21vTkhLk1rAF4ykm2rJDT8slj+3l9gW3+GxdzlTDwP+lhWHjYs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpWhoecmVyd71CSvsgU+LM3fnFQdbxavgjylKIsZ6AU=;
 b=bzka4RC+MZaJnP30FnO/vDftVoCUaX8gOSJJrlR8tlpPFTKDMZm3SxWS/2rOD0vDnwTIyHi/iGptFSIu9vpkU8F8J3XbVfF6GFoCzEeyzjCcd2gLmB+VtOxLDbQTww2fqSeimnnys7YQ+6QQ+Cya+MuzmK6oaBHZRjcpycNS3HE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 2 Nov
 2026 05:40:32 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 05:40:32 +0000
Message-ID: <c97688fa-1212-46c2-ad58-5117632e01b2@amd.com>
Date: Mon, 2 Nov 2026 11:12:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/16] ASoC: amd: acp: add PDM controller selection for
 ACP7.B/7.F SoundWire machine driver
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
 <20261030094714.1123396-7-Vijendar.Mukunda@amd.com>
 <15653bef-65b0-486f-aecd-ad7618d99cbd@linux.dev>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <15653bef-65b0-486f-aecd-ad7618d99cbd@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::10) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: b130c05a-bf7b-48af-42c9-08df38a3cf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|261026140227099003|22082099003|6133799003|18002099003|10067099003|261028144727099003|3023799007|56012099006|261021121427099003|11063799006|4143699003|261022105027099003|261021123027099003|261022075727099003|261009223027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: 
	o44Rfu2uHksagpW9DtT22mcGq1sdqOMKmMz3POJsEVsaugvYbFA3BA/fZeCoVaX0YR15lFcz+Guwp0CWNkxq3ZkzIulnk17GM/9hQnlHuRUAds5yocumQ8RsV/93+GAwlHQU9sUJbfRM6i2idGrctwCUMIOpOaZP9LGY0Wp4U+O3/Fi4avCHT+wC+WDc2H/3NrwmpUOIb5esCwunWrt50gKEoCeSHfY/w3m1F9+PfSarvMOr1GGeYoztjwvLYq1yqZ3UzMqMj6rZuDj0HJnI9meV1U/iJ2Qg9jTdcBqUvMuuWT2VQszwVEan8Q0WvSiMGJkXDElZegJ8J5uPFELcWRJ89u3XKqkZGuByZWwI5TYg57vhCxM0f+W0T+7pcCEYeA+XmpKoOA+Z7qRpLKpgD5Qm7eWLb1pID9p9JUNM4BAdfdL3XEUZ3A6SPaXs3oveuNd/JMGl6+g7d96SlbzK8p0PifPnJAW7aBQYspzE+xvZidzjx9RZ4+v4V5mCKpYqEhFHPcgKLLBCwzGc+tVXvKuJ44lSO/kKRf37GkDarj+hbNNDhi4+TCGutgS0lT/TUuuB6N8HzIfdpUPOynPDCPhFn+jnP99GcgvcruXUsCWDA54wJxAcp9dfiiIzP8E+FI8NsFHeqfR1ZGIbZAf+hxLixtVlgeObram2EZZ6i4g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(261026140227099003)(22082099003)(6133799003)(18002099003)(10067099003)(261028144727099003)(3023799007)(56012099006)(261021121427099003)(11063799006)(4143699003)(261022105027099003)(261021123027099003)(261022075727099003)(261009223027099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QjB2d0NoV1dWbXdLWXk1LzFOeDd1YTJsOCtNeWZUZWRnNGZmWkVhdFJaMzly?=
 =?utf-8?B?MDdkWjVOQmVkRGtwSlBCUHlSM1RQVkQvNEs2RzBGNHFvdVRJQS92dEM5TFcz?=
 =?utf-8?B?cGlDWSs3VHpGUERmVVZnQU11V3QweUVDOThJNm1JVFVvbXFBdStSd05BSkZL?=
 =?utf-8?B?S0o3UjRiTXVrRi84UmhTckdnZEVqNDc2Sm1pa1J1Q0RyOXl1dFJVUm5YaUNG?=
 =?utf-8?B?MkQ0N0NqcnNCdjNxOVJHczNnQ2JwamVRaHREWFlXNklDVWM4RWM4MW51R0xh?=
 =?utf-8?B?bzIrMmR4YVZoVDNjYkwzbzNxa3pWS2ZGa1pKYXBnK3AvY1JVVFhVTHhQYUVj?=
 =?utf-8?B?OGpJd0FvZktxQkY2VUx2YkFWUTF1Y3BhSEZkZUJ0NjVRQUNORUJRWGdVRXdE?=
 =?utf-8?B?YUJJNkVtb21lam81V0szZVRuejUwR2RNeFdTRXBYRFl0SERMRzhhckx4K0Vk?=
 =?utf-8?B?aFVCSHBIZS84ODJtK0h4bzZ4OGxiTGQyRGhaTkN4RFNVNUdlc0Q3NTZNUGxJ?=
 =?utf-8?B?aWJzM1ArQ1VaNmtoZDlEMEs2eldJdkp6VUtFZysyRlJUS3hZZTBwOFZxUVhP?=
 =?utf-8?B?TVlyV3hicU53TDZqclRzZUpQNmtkTjNNTHNGRXBqS3o4YjhMNEM4ejI2Umww?=
 =?utf-8?B?MjhMekVkRE5yZGJzK29vR1VJRXlqUlptaVphNHpacWFRSG43bmFGbmwxdWxZ?=
 =?utf-8?B?Y3dnNmdVZjZGOWt3Y1o2L3U3YU9GVG4rU2dMSXFDQnphUzg2SHNaWXRHbWVX?=
 =?utf-8?B?TURZV0Q2MXY4b2h1Vlp4QlZ4MWFxdlord0hRTFZrVjZNa1pPWFRyT2hDM05j?=
 =?utf-8?B?TlBpSGduTk1tbzMyZDJTZE5yektFTS84SGw2VHh4QktKVVIvakxYUDJJN2d6?=
 =?utf-8?B?ZXhCNU13ZU05YUJ3dm5hM1VvVWRWcGhNYTQvQnIzWlNvdlgwRC9ETVpRcEVl?=
 =?utf-8?B?S3UzeWlOd2V1Z0I5UjdGNEplTTZCU2w3dThZWHppSUZtYytQODdqakwyS1hl?=
 =?utf-8?B?a2ltcVhJSDM1YmtjbnczcFBZMEJFNmZ0aThjcEgvVzFJbHNiYm1XVlhST2to?=
 =?utf-8?B?aStxVkhkS0liVjVRTzZqQkZrdGxlUUY1TCtoNk16Z2xGcTBGY2hhbFVIdisv?=
 =?utf-8?B?UitscmI4N293TEdCNGk2Qm1MUEJFbm5xSk5Udms5aGNOaXFxNzRFempzdXAy?=
 =?utf-8?B?Tis4NkN1ZGJXTGNTKzRyaUM3QU9HV0lkbHVpK2tzaU9GS3M0Y0wwZnNZQ1FN?=
 =?utf-8?B?MVUxTksyQTlmNm5EU0NLMFRsNmFaMnk4UHpUZ2JXbTZuZStNQlFydXRhVlg3?=
 =?utf-8?B?ZTdKYk5heXN0TzUvQUN0OUdoWU1CMnJTNk9RaHZJMW9NQk9UK3BXWG41UXcy?=
 =?utf-8?B?L2RYL3g2anJWOHl1S3JHRDA1NmVodmxmbUZlTExraVBYM0QyR3E1WDNxaXVz?=
 =?utf-8?B?RSt2T2VQb1lnTS9wV3lVRGp4SEhrOTBrQ0dENzJrTTV6Tkp4OEhMU28rMzB2?=
 =?utf-8?B?dmFIVVJzN3piZGE4d0huNzV5N3ZpdFBJYjVsSHNvdmR0akxMeExVaXJoVnR6?=
 =?utf-8?B?MFVFR0V4djhkLzh0OUJ6Zyt3aTJyYlJzYlM2VnlqRVFEa0dEajIrTjhxcXRQ?=
 =?utf-8?B?dnFvaFgySDVHMXhZbGwzRlppVnpGdXdpNWdmR0NQMzhjdVdWQjVSZWFLNzR1?=
 =?utf-8?B?c2RCcmRIMExoYVhmWWFjRTV1UktBc25MY05aMEcrM1gwalRvdDFPMkxFUVRP?=
 =?utf-8?B?VHZ2dTUwTlFldW9HWEhlcmF5V29QanUvM2Z1QkJtVEdOSTBuR1duWE1ERmR1?=
 =?utf-8?B?ZGF4RGxaL0tTRHlMaC9UYlVFSE5hWWllbTU1WXo0aGR5K2VMVVVnSTJndVp6?=
 =?utf-8?B?RjE3TGllY05zaHZhWkhaa2lmaFhEQzZOUjVjUWJPTy8zVlNFdFBnYVJHRUhh?=
 =?utf-8?B?c1djWVV1elNBbVNaSzl2VE5EWUYrRVlqdW04NFNBbmhNTFdQekJBb0F1NmhC?=
 =?utf-8?B?TFBTTXVwVU5QWXJBY291QVZqUmhzMWFQRHN5NTYvUXJJQkk3T3Aya25hZ3l5?=
 =?utf-8?B?TUUxSDI2L0VaTHZRbDlSQ3FrM0orUktxZUFuZFQ1eGdrNXZBTW5lMUp2QXZ2?=
 =?utf-8?B?NUJ3UDhMb1diV0YzYWRVNGErMFpjenpodmMxZnJHWjNUd04yc2lIS25YSHFG?=
 =?utf-8?B?dWVuL010enJHZ3JyODducTkyNTVEQmkvNkNoUWFFYXZvR2k1eFUwREFpeGEr?=
 =?utf-8?B?RGlnWHZ2VEx4ZDZTVU96Mm90eFI3aGFYU3c1ZlMydUYrVUZFaGxpRE9OUUJ3?=
 =?utf-8?B?UmdpSU1SZDFjQW1qT201QUJNY3NKdVNPd2FtNE5KV2krcUpiem56dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b130c05a-bf7b-48af-42c9-08df38a3cf5e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:40:32.3487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 ZrjOhBJmEKiSzGyMrT88phH/bPR7mVUT6RCR85j3oDnkYHlRpdFxIFaYVVxwLhZ4HJ2n7lhIiE//vJk72es5BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
Message-ID-Hash: HYB5KTX3G2VVJPJYDUYF53H4P5443PT3
X-Message-ID-Hash: HYB5KTX3G2VVJPJYDUYF53H4P5443PT3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HYB5KTX3G2VVJPJYDUYF53H4P5443PT3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 01/11/26 23:58, Pierre-Louis Bossart wrote:
> On 10/30/26 10:45, Vijendar Mukunda wrote:
>> Add ASOC_SDW_ACP_DMIC1 quirk bit (BIT(6)) and pdm_sel field to
>> amd_mc_ctx to support per-controller DMIC DAI selection on ACP7.B/7.F
>> platforms.
>>
>> In mc_probe(), read the active PDM controller from mach->pdata
>> (populated via ACPI acp-audio-ep-port _DSD). When ACPI does not set
>> pdm_sel, derive it from the quirk bits after dmi_check_system() and
>> quirk_override are applied: ASOC_SDW_ACP_DMIC1 selects DMIC1;
>> ASOC_SDW_ACP_DMIC selects DMIC0. Since only one PDM controller is
>> active at a time, DMIC1 is checked first.
> nit-pick: it'd be useful to explain the mapping between PDM controllers
> and PDM microphones. Is this one controller:2mics?

>
> Also does anything prevent DMIC and DMIC1 from being active simultaneously?
Yes, each PDM controller supports two microphones, i.e. a 2-channel
DMIC configuration. PDM0 and PDM1 are alternative controllers, with
the OEM/platform configuration determining which controller is used.
Only one PDM controller is selected for a given platform, so DMIC and
DMIC1 are not expected to be active simultaneously.

Will add a comment in the code to clarify this and post a supplemental
patch.
>
>> In create_dmic_dailinks(), select the SOF CPU DAI name based on
>> pdm_sel: "acp-sof-dmic1" for ACP7X_PDM_DMIC1, "acp-sof-dmic0"
>> otherwise on ACP7.B/7.F; all other platforms use "acp-sof-dmic".
>>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  sound/soc/amd/acp/acp-sdw-sof-mach.c   | 44 +++++++++++++++++++++++++-
>>  sound/soc/amd/acp/soc_amd_sdw_common.h |  3 ++
>>  2 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
>> index 97b2e224492f..34a71f7a8c54 100644
>> --- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
>> +++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
>> @@ -265,11 +265,31 @@ static int create_dmic_dailinks(struct snd_soc_card *card,
>>  				struct snd_soc_dai_link **dai_links, int *be_id, int no_pcm)
>>  {
>>  	struct device *dev = card->dev;
>> +	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
>> +	struct amd_mc_ctx *amd_ctx = (struct amd_mc_ctx *)ctx->private;
>> +	const char *cpu_dai_name;
>>  	int ret;
>>  
>> +	/*
>> +	 * For ACP7.B/7.F platforms the PDM controller is selected from ACPI
>> +	 * acp-audio-ep-port and stored in amd_ctx->pdm_sel. Use the
>> +	 * matching SOF DAI name ("acp-sof-dmic0" or "acp-sof-dmic1").
>> +	 * All other platforms use the generic "acp-sof-dmic" DAI.
>> +	 */
>> +	switch (amd_ctx->acp_rev) {
>> +	case ACP7B_PCI_REV:
>> +	case ACP7F_PCI_REV:
>> +		cpu_dai_name = (amd_ctx->pdm_sel == ACP7X_PDM_DMIC1) ?
>> +				"acp-sof-dmic1" : "acp-sof-dmic0";
>> +		break;
>> +	default:
>> +		cpu_dai_name = "acp-sof-dmic";
>> +		break;
>> +	}
>> +
>>  	ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, "acp-dmic-codec",
>>  					    0, 1, // DMIC only supports capture
>> -					    "acp-sof-dmic", platform_component->name,
>> +					    cpu_dai_name, platform_component->name,
>>  					    "dmic-codec", "dmic-hifi", no_pcm,
>>  					    asoc_sdw_dmic_init, NULL);
>>  	if (ret)
>> @@ -378,6 +398,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
>>  static int mc_probe(struct platform_device *pdev)
>>  {
>>  	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
>> +	struct amd_pdm_pdata *pdm_pdata;
>>  	struct snd_soc_card *card;
>>  	struct amd_mc_ctx *amd_ctx;
>>  	struct asoc_sdw_mc_private *ctx;
>> @@ -398,6 +419,10 @@ static int mc_probe(struct platform_device *pdev)
>>  		amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
>>  		break;
>>  	}
>> +	if (mach->pdata) {
>> +		pdm_pdata = mach->pdata;
>> +		amd_ctx->pdm_sel = pdm_pdata->pdm_sel;
>> +	}
>>  	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>>  	if (!ctx)
>>  		return -ENOMEM;
>> @@ -419,6 +444,23 @@ static int mc_probe(struct platform_device *pdev)
>>  		sof_sdw_quirk = quirk_override;
>>  	}
>>  
>> +	/*
>> +	 * If ACPI did not set pdm_sel (no acp-audio-ep-port in _DSD), derive
>> +	 * it from the quirk bits. ACPI takes priority: quirks are only
>> +	 * consulted when pdm_sel is still zero. PDM controller selection is
>> +	 * only meaningful on ACP7B/7F platforms.
>> +	 * ASOC_SDW_ACP_DMIC selects DMIC0 (default); ASOC_SDW_ACP_DMIC1
>> +	 * overrides to DMIC1.
>> +	 */
>> +	if (!amd_ctx->pdm_sel &&
>> +	    (amd_ctx->acp_rev == ACP7B_PCI_REV ||
>> +	     amd_ctx->acp_rev == ACP7F_PCI_REV)) {
>> +		if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC1)
>> +			amd_ctx->pdm_sel = ACP7X_PDM_DMIC1;
>> +		else if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC)
>> +			amd_ctx->pdm_sel = ACP7X_PDM_DMIC0;
>> +	}
>> +
>>  	log_quirks(&pdev->dev);
>>  
>>  	ctx->mc_quirk = sof_sdw_quirk;
>> diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
>> index c979adf4e978..07837a2cfa54 100644
>> --- a/sound/soc/amd/acp/soc_amd_sdw_common.h
>> +++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
>> @@ -29,6 +29,7 @@
>>  #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
>>  #define ASOC_SDW_FOUR_SPK		BIT(4)
>>  #define ASOC_SDW_ACP_DMIC		BIT(5)
>> +#define ASOC_SDW_ACP_DMIC1		BIT(6)	/* select DMIC1 controller for ACP7.B/7.F */
>>  #define ASOC_SDW_CODEC_SPKR		BIT(15)
>>  
>>  #define AMD_SDW0	0
>> @@ -94,6 +95,8 @@
>>  struct amd_mc_ctx {
>>  	unsigned int acp_rev;
>>  	unsigned int max_sdw_links;
>> +	/* PDM controller selection, copied from amd_pdm_pdata at probe time */
>> +	unsigned int pdm_sel;
>>  };
>>  
>>  int get_acp63_cpu_pin_id(u32 sdw_link_id, int be_id, int *cpu_pin_id, struct device *dev);

