Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC68CA5FE2
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2026 06:42:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84EEB601B4;
	Mon,  5 Oct 2026 08:42:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84EEB601B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791182554;
	bh=5XN79OiwLUqGRygZd/23ni5B4SKdH9SAB7V5Nw8xwcY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Z/qE9APPhagUGsWjV43Q5tEiSGUuKE+DC7L6aWw+f8VnhUBd+h4+RCjzuuPOyhni0
	 9PqYh26APZXpeMb/bsTVJT7QmhyrPMD/5AawrWzGgnJNJ6QEVZXyZk4b7cs9cTIJhd
	 leeV+I++03ap1h5K3YfZsCb6h7SSvmSsUnB9I6xM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4452AF805F7; Mon,  5 Oct 2026 08:42:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 08952F805EC;
	Mon,  5 Oct 2026 08:42:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24623F80588; Mon,  5 Oct 2026 08:42:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.64
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791182520;
	b=C+T0ehMrtYWLFK+UGXAYWhVZaIy+p27G/YuRn+ogx9lebSquJiln5xkHEV8GCe40nBi7
	 TCnuk5cv9N8i+wZGTILzrRpe9SwCTeu9dyJ4WLRAzF9DE8ryBBf29833cwdOQ5darHJQ7
	 aqxGdR4J0+p9Rr3o06LPBL9FAUt9i/xlfzo5Qz6ORtv6CbmcH/9glaT6vJp5hzvtWFxvv
	 dgkmSU20nGgGMT0VJZBSYAO69zp7gq0FfEyU8yo6LqO/7KH4lERgDmVpJOir+A6r2XznQ
	 pF/+TL63hfj5dy9JbhvIjOkgLOJ957tKlemnK2hbXkaaN0OQwTKa6giR1X+rfjV1QiQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791182520;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=5XN79OiwLUqGRygZd/23ni5B4SKdH9SAB7V5Nw8xwcY=;
	b=BCndid4EeIXPqLz/V9JT6H5bkBn2JPrrYKDzle0rnEBGVhZZxrR1GGmmDPMgNlPpvC2U
	 5/3wM+Qi1lWvOKFhXVp/PcqeSvTvxVtSNmMenNpXYqVzzYJ8p3cseNP1NYo/+wnLCC5P3
	 vOurd8UYkPt5mh80GIzuLU25LTKwIYYrVwf8HtyGWyKJ/yw75hzYpmDBrXZDq9dyFz3rn
	 LhKwhXblT2E6NMvvlhygzMlkywFFySJ4hCmMyYjybgvZu4HdD0pV3koHzcFO49XqZ+DAj
	 gaarpGa/lvJ6EHlGK+QyDOuPxjF2rWOmMH443+gsD9KPkhHa1/KhmHde24Tn4LOQu9A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hpCOWB1h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.64
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011064.outbound.protection.outlook.com
 [40.93.194.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 00294F8024C
	for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2026 08:41:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 00294F8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hpCOWB1h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dW6/QqTHK74Z9em2DfkIY73sM5HKVfSzXIvT3UlMqmXe6ff2q8OJHck+znyrn90/9Lqup8Q/Qb3DXYQup4QW+ClsNpn9p2FsiA6bhx+/G0M6hL8mHZJG0nGNtc1b0ofFC85qO4pCXzCOcFjGyqLq9Kl+gAeKauArI6H7l0XfWLjA8KKj1yvuOMdpkRVqQVlIC7uA5wHOlBbBIvhro5L5IQJfy/UpcMArfAMEaRihfjz8CFg46hhdXFmzC9Emu2bL74Iu4/UzGIUwi84PcC/c2LoH+NEg//eJU97JaQzWF/9XF2jz++xZSka/jJ4XAa4I10lb9lNkPNgKIBZa8L1/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JV6pwxrrzehBs2eeuwYBDNO92eesjFvn2NVQ6mTHruo=;
 b=nwMftQwKeOj/oxr6VWbG5DcVysjna50ENVdPxpkicx62D0ZrFI09neyyRMyh0JvlmlciJ5z9su3S2OqbjLmpSWIa+762/tCUc/Y3oK/+s4YUL+yR0GdHkF3sUUHHx8fG1x/8QeIPWvXUFDyofizsnvCfDd0BwYVc5sZdix9NUFCuKyLrg+lbnqMa3gep4Uqnvdyc7Gj38u8TLjZpkGJ0ouFx1v788zQciCaRXb4l+MNCjvYQD5zb2Er5RFfctxd2xo6pVpCuc+LiwjdpvAnuXjvv2fJ9I6cWUUwhlpSSJXaQPYFI1/4TZS/32zj+ZY+Ity3Ews6z9s/yVNkVWQvO+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV6pwxrrzehBs2eeuwYBDNO92eesjFvn2NVQ6mTHruo=;
 b=hpCOWB1h7CBF0qmxOug3hrkxvn93Vw+fbCsnObAfgcRSARluvkw1220NQDy0PJZZ6zLlTO2xoTmOSQdWG71XcALKmMYbTVurxD1BgDv4aljFbaOz09IEL2M6ncSoduu17qaPgUaItNDILUpLXVPvDjs/q77GJsI3lUY6dP+j+0Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Mon, 5 Oct
 2026 06:41:53 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 06:41:53 +0000
Message-ID: <80c430e6-ba24-45c0-9912-37bd319da0a3@amd.com>
Date: Mon, 5 Oct 2026 12:13:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] soundwire: amd: introduce struct amd_sdw_hw_ops
 dispatch framework
Content-Language: en-US
To: Vinod Koul <vkoul@kernel.org>
Cc: broonie@kernel.org, alsa-devel@alsa-project.org,
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260917090407.3828816-1-Vijendar.Mukunda@amd.com>
 <20260917090407.3828816-7-Vijendar.Mukunda@amd.com>
 <asC1JwByZaJ8B2Pr@parshuram>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <asC1JwByZaJ8B2Pr@parshuram>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::8) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: db327997-8e28-4c47-8d8e-08df22abbdb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|6133799003|56012099006|10067099003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ncj7/h2hqaMyeTGFEVVkYWWQRmP1x1EpJ1KRRtUvrqNH0EH1G9gm45wBkQNomZZMW2IwZAAbXfNCjAzkoDTehNSiTgwWHntgvMovuQD81gJRdHNG3dWnmxg7QYTFnmez5IUfFKRk27ZQFUTJxIbHwqSjbKWRl7rfWcVHATcah03I1+JBqyLNtfpQacz1mDWTQmLpam7lpPDnCDJRdHJmTUA9hgvv3vMlAH1Ci6qcaKhD6f6lN9V74ZwmUD+aTHItiqAOnuEEU0SlRxlivt0JsR9aIsw6flA1h/RYtRk28EEzg5DuhLmK4xw/Dgjddv09SdwOu9lHQhBszJmzOBVaejcNAeMp9mHWA4mJQhAl5AeR7ZuQLFcdudDUGXJ1cL+wk/P9q/78YLDbidmH+4DVkoGEF8Odcrye4K7tQbhPmilznzrmgto+/TYb4qtxiZr7rvxn6Tq8eKVAjzChZ9ztItvkNvK5N36RmqB2bx2yDvzC+FkrNVjPIPJovHJfIw1Cih7cK1/AKpnqg1OFxJKuql58oEkrfU1dVJYv4RNbIsn3YlUTP2bIHznrz4pLQrXrh334iZUpqMI4DrZgUJ97v02SI0E/Aym9qejHuoKRyOyH/99aX2yaZ1ScNCDeyq4bToTF+v4rhmV0KRamYanpVt3sO1k1V+AgT5Hcug1qmu8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9567.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(6133799003)(56012099006)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QmJXZzFDSk4wLy9qc3lpSS82ZjEvQWltQTZ1c1k2eHVaek5NK0pLaEI4YnRo?=
 =?utf-8?B?b3dvTTMzVmlxc1FhWjNLOXA0TjRYTWZwZnExa20xQUlBMTFrL0pGTHNPTkJ4?=
 =?utf-8?B?cm9LRm9ob2o5Wi9aMnBCeWVBZ2RaZjNHMnBSRkRSejBQZmdlWmR5Nys2MWFC?=
 =?utf-8?B?VWIwWURxbEhsZVozNXZmRDBwSUZIamdyTXI0RklFenlKNEticGp4a09MbDlv?=
 =?utf-8?B?Wi9mVFVYLzA1MTM4WU1GbDJIU1hCWWQ0VnpiZXdZc3lsVkkxNzJFRTQ1b1F4?=
 =?utf-8?B?OFoyekE3RVZWRGJIa0R4c0MrMWNRTTdubk53UU1ScDJNKzZFblFXci85REpu?=
 =?utf-8?B?UGNUZkM2ODZYWGZvTS9Obzh0ZWNkUTdtYm9yQmpTeVZwRmNmQmZPcG96aWlM?=
 =?utf-8?B?aVdESkZjKzNOMVBad1Y1bXdDZlZNcVJjSkRNMG9kZXIyS3Y1OFhNUEZlN3ln?=
 =?utf-8?B?b1dna1hDQzVRWmU4VHRiMEhiVlZoVTl6RW1ueGVybDErWHM1R0tOSVJzS3l6?=
 =?utf-8?B?SlgvclAzTW5GVDZ1REx2L0RnQVlBNG1pbmdneitneGJyQ0haVGtpc1djby9J?=
 =?utf-8?B?MGlYdDUrOEJJWlp5NzNhbWdlNlJObmNBelpyRTZaK2o0eWRNb2ZWWUdERnE0?=
 =?utf-8?B?QlJwS202bGZrK3h3UDhmTWRKNXNabFFuZnFoZ0RVUUI4UEtUREs4aGtzOUFT?=
 =?utf-8?B?bjEzc0twaUFBeFFac3RBbGg0SmUzQW9nVTlFVEM0enFqcEZJcDZyS0RoZk5a?=
 =?utf-8?B?Ykc4UnBIQmNOYkhFTDJNV0plcVdXRVVzTXU5S2d5aDlLd3Z1b1RqWlM3UktK?=
 =?utf-8?B?cjYvb1JpcmErMFp3c05IK3FKeGU2dVNlbk9EMUtVS2gxKzRHNFgrdFhoVVRm?=
 =?utf-8?B?dWhjd1pyeS9yYmlTNVgvNkZrZG1RS2ZSMGtRRDJOMlBMSDJOR3diSXNGRDJT?=
 =?utf-8?B?NFpQQnZMWENFbkhXV1dKUXZoMGttYkNIYVJaYnk4N1h5VjhaVmh6eTR1eEZh?=
 =?utf-8?B?TVZpVkNvMDhCaVNTazA3cVNOQ2VPUlVTRXNmNWJkN1JkS3VmZlREK3ZpbDdW?=
 =?utf-8?B?dFVYUFdSZVF3S29nMk43eHNXUUJKcVBUOXF3L2ZNRVhSRHBOcWNxTzVsUjMy?=
 =?utf-8?B?SW9OTmdDZFhYNUxmWFJMQWZxd1ZuMjJYbXplKzVWWEtVcFlHVjZmOHZHT2VR?=
 =?utf-8?B?czF2dkZTYjl3MXYwUTVDdXVXMHZhcEdidlIxMmxMdXFHcEpIM2toYkl6bE1U?=
 =?utf-8?B?ZENod2xMRVJzZVhwTlNhOGtTbFJjNXFHNnNVeHRXd09yaVdPZDdzRDBJdVUy?=
 =?utf-8?B?YXVXR0NZbUIzMkd5T01Md0wyVlM3M2FhNnZ0ZEUvbnFTUlFUUW1XMHhjMWEw?=
 =?utf-8?B?aENhZHYyM2ZtbE9VR2lCbzRLTVRzMmxhWkxHVmlBY1owbGdVaC9FOVhzZHVB?=
 =?utf-8?B?VUdoUkNsalMzUFphT3MxYW9ncjJhK0Q3K1NYNldkK3FBdmw1U01jWmNwcmxj?=
 =?utf-8?B?Y0dDdGpLdUdwa3ZWVHJLZnl4Rml1ako2dzJYaGtSK0w0QzRUMnFCM251RFY4?=
 =?utf-8?B?NEYvakQ1YmxwQkszM2Z1MUFMU3FQQ1JRUlRqZ3JUc0tGMGY4MUtTOVZwZXNr?=
 =?utf-8?B?b3ZxVjNabldtNE9NQlZsaUxSVmRxTHdPb2ozemw4NWV0STlKalZPaGcvWXZO?=
 =?utf-8?B?TTlSY3pROFVrL3Z0cForai90bDZrTVVsTG5qa1VuQ0dzUTdGOUZYYUhjZ3Jp?=
 =?utf-8?B?d1gwWjQ1dW1GTjNuVEdxeTRsTTkzN2JHaktCMzFESkg0TXpGV0RkRTVmRnB2?=
 =?utf-8?B?RGNOaVplell4RXM1a3dYM2hwcDdTUG9qSHhnUnFFeTVJcTk4T0JWdzlLbW1n?=
 =?utf-8?B?S1ZMSW84Mzl5cEFCei9lRUVPWXE5ZGV6MXZQd29pVU02Kzh3YlYrVFQyR3dH?=
 =?utf-8?B?V21ZSFpZb3Yxelp1Nmt6UW5KWFhUSnJselhMcmlrYWFOVVhWaVFobEJaMWtz?=
 =?utf-8?B?MHR5OWh1MnZ6RGM1WFczMENTYklxMGpGY251eUpUT1M1U2NKS1hyblFqSWh4?=
 =?utf-8?B?S25yQU5nakFVN0hQY1RYN3l6aHVIQ1hKalFhTU9YRlB6MmIwL3c2L2NxV3lX?=
 =?utf-8?B?d0FrU2MxTStOL3BCOEtsRXl2YVI2MFRkcFh2dmJGOXdHekhXcWVCYmpMYnZE?=
 =?utf-8?B?eW8yTnNGWVNWaDNXWlU2OUV2N1VsZkxuSFUxQzRnS2RQcHFIajdsUWpWeXJE?=
 =?utf-8?B?SjBZcURlSU1ucHVnT1Q1eW1YbDJLRDBiN3YzVHBvdHZYSHFDazZPa0pCSnpY?=
 =?utf-8?B?SlYzaitOSGd2bmhyNkdVL0VtWDkyZ0RWblYxM3ZsVkxnRHRNQzJ0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 db327997-8e28-4c47-8d8e-08df22abbdb3
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:41:53.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 7BRxOhV475jf+kCvkzTXmUS1uKwF2GjcoM2OvJontgFFGAIu9wP1vC51ITdH400G6gZkokOsnc1Q9n2DtJ12hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096
Message-ID-Hash: IFUVIYEPRBWVD5H5GOLEKBC5U2CEFHN3
X-Message-ID-Hash: IFUVIYEPRBWVD5H5GOLEKBC5U2CEFHN3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IFUVIYEPRBWVD5H5GOLEKBC5U2CEFHN3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 03/10/26 13:26, Vinod Koul wrote:
> On 17-09-26, 14:32, Vijendar Mukunda wrote:
>> Add struct amd_sdw_hw_ops, a function-pointer dispatch table for
>> hardware-revision-specific SoundWire manager operations. Add inline
>> dispatch helpers for each callback and a const hw_ops pointer in
>> struct amd_sdw_manager.
>>
>> The irq_thread and update_slave_status_work slots take
>> struct amd_sdw_manager * so that different ACP revisions can register
>> different handler logic. hw_ops is populated and call sites are wired
>> through the dispatch helpers in subsequent patches.
> Lets solve with one more level! Do you really need this...
Agreed.  We can drop it.  Will modify the code and respin the patch series.
>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>  drivers/soundwire/amd_manager.h   | 193 ++++++++++++++++++++++++++++++
>>  include/linux/soundwire/sdw_amd.h |   4 +
>>  2 files changed, 197 insertions(+)
>>
>> diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
>> index 63fecff62079..2d08c6edd018 100644
>> --- a/drivers/soundwire/amd_manager.h
>> +++ b/drivers/soundwire/amd_manager.h
>> @@ -274,4 +274,197 @@ static u32 sdw_manager_reg_mask_array[AMD_ACP63_SDW_MAX_MANAGER_COUNT] =  {
>>  		AMD_SDW0_EXT_INTR_MASK,
>>  		AMD_SDW1_EXT_INTR_MASK
>>  };
>> +
>> +#define AMD_SDW_HW_OPS(amd_manager, cb)	((amd_manager)->hw_ops->cb)
>> +
>> +/**
>> + * struct amd_sdw_hw_ops - hardware-revision-specific SoundWire manager ops
>> + *
>> + * @init_sdw_manager: enable the SoundWire manager hardware and perform bus reset
>> + * @enable_sdw_manager: set the manager enable bit and wait for it to assert
>> + * @disable_sdw_manager: clear the manager enable bit and wait for it to deassert
>> + * @enable_sdw_interrupts: unmask ACP-level and per-manager interrupt bits
>> + * @disable_sdw_interrupts: mask ACP-level and per-manager interrupt bits
>> + * @set_frameshape: write the row/column frame-shape register
>> + * @send_cmd_get_resp: issue an immediate command and return the response;
>> + *   returns 0 on success with the raw u64 response in @response,
>> + *   or negative on hardware timeout
>> + * @wake_enable: enable or disable the in-band SoundWire wake interrupt
>> + * @host_wake_enable: enable or disable the host-side wake interrupt
>> + * @set_device_state: write the D0/D3 device power state for the manager instance
>> + * @read_and_process_ping_status: issue a PING command and process the slave
>> + *   attach/detach status; called from the IRQ work path
>> + * @process_wake_event: handle an in-band wake notification from a slave
>> + * @irq_thread: hw_ops callback invoked by the thin work_struct wrapper on
>> + *   each interrupt; reads status registers and dispatches slave events
>> + * @update_slave_status_work: hw_ops callback invoked by the status-update
>> + *   work item; reads slave status and updates the SoundWire core
>> + * @clk_init_ctrl: set the clock divider and update the frame shape registers
>> + *   based on the current bus clock frequency
>> + * @clock_stop_exit: restart the SoundWire bus clock after a CLK_STOP_MODE
>> + *   suspend; implementation differs across ACP revisions
>> + * @suspend: system-suspend hook; stops the bus and powers down the manager
>> + * @suspend_runtime: runtime-suspend hook; same sequence as @suspend
>> + * @resume_runtime: runtime-resume hook; reinitialises the manager and restarts
>> + *   the bus after a POWER_OFF_MODE or CLK_STOP_MODE suspend
>> + */
>> +struct amd_sdw_hw_ops {
>> +	int (*init_sdw_manager)(struct amd_sdw_manager *amd_manager);
>> +	int (*enable_sdw_manager)(struct amd_sdw_manager *amd_manager);
>> +	int (*disable_sdw_manager)(struct amd_sdw_manager *amd_manager);
>> +	void (*enable_sdw_interrupts)(struct amd_sdw_manager *amd_manager);
>> +	void (*disable_sdw_interrupts)(struct amd_sdw_manager *amd_manager);
>> +	void (*set_frameshape)(struct amd_sdw_manager *amd_manager);
>> +	int (*send_cmd_get_resp)(struct amd_sdw_manager *amd_manager, u32 lower_data,
>> +				 u32 upper_data, u64 *response);
>> +	void (*wake_enable)(struct amd_sdw_manager *amd_manager, bool enable);
>> +	int (*host_wake_enable)(struct amd_sdw_manager *amd_manager, bool enable);
>> +	int (*set_device_state)(struct amd_sdw_manager *amd_manager, u32 target_device_state);
>> +	void (*read_and_process_ping_status)(struct amd_sdw_manager *amd_manager);
>> +	void (*process_wake_event)(struct amd_sdw_manager *amd_manager);
>> +	void (*irq_thread)(struct amd_sdw_manager *amd_manager);
>> +	void (*update_slave_status_work)(struct amd_sdw_manager *amd_manager);
>> +	int (*clk_init_ctrl)(struct amd_sdw_manager *amd_manager);
>> +	int (*clock_stop_exit)(struct amd_sdw_manager *amd_manager);
>> +	int (*suspend)(struct amd_sdw_manager *amd_manager);
>> +	int (*suspend_runtime)(struct amd_sdw_manager *amd_manager);
>> +	int (*resume_runtime)(struct amd_sdw_manager *amd_manager);
> I would suggest splitting the driver and add common code to a lib and
> have specific drivers for older and new gen platforms...
 Agreed. We will restructure the code and respin the patch series.
>

