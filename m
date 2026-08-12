Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8394C5CFDB
	for <alsa-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:41:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73D276020D;
	Wed, 12 Aug 2026 12:41:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73D276020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1786531270;
	bh=sqe/cDqrQ8mvUtSB4AtqIqBWdWGAL555ccEI3wferIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SSMvqPleEbBQmmoGuSqj7HGsTd3b2Aekjfb984ePjOLrtv2UG/iMrF+O79dLwIrJw
	 NN/Cv9PJQ4owj5XSuhaPicMzUecIvDknRl5IWQ1s6dBnElc8MB/sCKHoPlO7QaAS6O
	 h8nUH+uEDW23CjP2Plp2fp27XQb1grN6xkrpUh3U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1728F805FA; Wed, 12 Aug 2026 12:40:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B6D9FF805FF;
	Wed, 12 Aug 2026 12:40:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AA1CF804CF; Wed, 12 Aug 2026 12:40:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1786531225;
	b=lYzo5n+sj7znys34ENq4iD+hyqSa8dQnjFcY0/UGO0trOT/j6koTCNlRNRSmRHIK1Shr
	 X8GV+NKXDonkkEaOlym1qBTPoHrUCMkiChUA2Dg6n5Jl7dvJeObadlBriKe8E8i7iqF89
	 RzD0gt7km9qEJSSTL6Vv2idj1KFrbPf8T8OjRms7ieKWI5irRAKyNlLsBnAC7T5il1QhI
	 IolSIE+6Tz+yuQK74sqU8S+aG4+7qR8NoxS9kcCcG+SNX7qAo0hfS/BeJw76GMoFPkutx
	 +ISTTDnPElrk6/N9YlDnXuX/8HuK4F+ci6Y3KexuB9/AIY0HzDK7XAEP+oHc/tVViQQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1786531225;
	h=DKIM-Signature:Message-ID:Date:Subject:To:From:MIME-Version;
	bh=Edb+VUASgPyio1jm2gEgI/FIjdzke/xfpBYzW+wf5c8=;
	b=CRVOLOqoRuoAnO3O44DiGj/W0L44I0EshpZsjorNvuHns3Z1I4YRn4Xm2azDby6t6AHA
	 55uj2acCk62GDv1ZZqRBqnQEHKLk/PMuAbn5hhUcmbLWHWtNQ5ZvFOYb5OvbEwmjyVH+U
	 aJSgt982eZmvJ+Qlo9p0CTXHB32SiglXD41MijVhEAPj4dBIhuJqXCg6tgylbyPoZU8EI
	 W8TEw66ItyX2fKeVtbt006Yp6YI1tmxi58fdP78zJw27HLsdip7O866EO0twRK8CKu8iJ
	 aYP4SRSU4uMZ6nKxDEMDq5mfEvfOsGuqEy2JNDP+0+X2tSH/REiQJ591x0b/Ys7QvQg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="00/f3DVb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.25
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EC9B8F8014C
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2026 12:40:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC9B8F8014C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=00/f3DVb
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufR7ioDaIpj4q8Kjr3GhNvecUoc0Psd+uuZDvhCtKjMoe1Sdgt5SWf/9wek7wFXesm6ALdSoQ1pj2cTVJpC0URa8WqGRhqI5pupMs426WxQrbmOjiP81I5y479f16U+EHLyTNjLbmjsnfO2oaTzvdzaVvUaKHDrJFE9AGXP/m64D15/v1EbC2lltbFyRUxNogVINVFt8tsw2j8DLVTUksVoUVvJLNyG+Ga844ME2v/53/R6fZN9hbzABSvz+3mUAxX0ow7M99pFP/gfeP644OAteGifqnVK439qS+/kNrU4ThW2ilsL0iiqeG9rVTKNQ5omQ5HZzmsAVbyo70AXriw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PrXxLDN//IySw9LYkIC1zZkP0jvFIMtQNT5f5xQmXIE=;
 b=tCzSzO0QaHb4KQxDqRaxyBbWwUXeI8qV5GiRyhTnW9H0u99LaWp4zn7ilHtf8IrKswlJb5zRSUWuaVqSGq20zq49rArww330mG3VsDNFVllvcN2XxZKizYD2vgO9X+dn4cxO/4JXuqswyUXrZT0izJZKag3mlZuLDNgvEVfZtbsgKiabb3waY2WUiq5wSWcR94HWPhlKv5BYai+2wqFujYvQ3qIQ1rKXBNexrAapdUj/pt94aTp6LYt5TFy/+uAQrZgSM7ukn9oXB2+nVYXzw8VhXq/e5qqooqnOzOH8utzc2eXDEEpJV4bJj1W2fkBaLSedgXUjhGA2LvvqiC5Unw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PrXxLDN//IySw9LYkIC1zZkP0jvFIMtQNT5f5xQmXIE=;
 b=00/f3DVb2hKRXiuORIk5D2V0eBjahedRYDEz0kr4WjLn1JDB2s56EuZgKOcp7HUNVdq5yTtpAygbn72n0DJsmtagvtQZ0ITBGE6E/2YwTCF0Uumv0zvJM3zmUM9sPQYdvkd89mXZCKxEzpgq+pFk6+XmK0d+Kjr46aFH3xnJxpw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5356.namprd12.prod.outlook.com (2603:10b6:408:105::23)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 10:40:15 +0000
Received: from BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e]) by BN9PR12MB5356.namprd12.prod.outlook.com
 ([fe80::8e9c:2f3d:9679:942e%5]) with mapi id 15.21.0315.008; Wed, 12 Aug 2026
 10:40:15 +0000
Content-Type: multipart/mixed; boundary="------------ixTgtzvIyDXMDdwxUn2QB0KJ"
Message-ID: <0e32d0ab-4ab0-44ec-939b-6792e694bd14@amd.com>
Date: Wed, 12 Aug 2026 16:10:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/BUG] ALSA: acp6x: Add DMI/PCI quirk for HP 255R G10
 internal microphone (103c:8d22)
To: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>,
 Alexandru <eraleexxx@gmail.com>
Cc: mario.limonciello@amd.com,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 alsa-devel@alsa-project.org
References: 
 <CAB-5r0nx0fxnvoYqwHHfuGMuXngPk_AuXa=Q2RjCun2xRpt5og@mail.gmail.com>
 <6e623581-664b-4d79-b9de-429b3b433472@amd.com>
Content-Language: en-US
From: Syed Saba Kareem <syed.sabakareem@amd.com>
In-Reply-To: <6e623581-664b-4d79-b9de-429b3b433472@amd.com>
X-ClientProxiedBy: PN4PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::17) To BN9PR12MB5356.namprd12.prod.outlook.com
 (2603:10b6:408:105::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5356:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: c11e8e34-4322-474c-3f71-08def85e1831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6049299003|4053099003|4143699003|6133799003|10067099003|8096899003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	60nFIkTCGJH08PL0AMENNUgxEPXtRbHAcY1hDIJargzyjsR7GK7c6maTPZz7KHgNScZE03DAoyupXDOHZ6T5LoTFly/BkCWeF5GsNeFmantRTM8h9FzAQs+ItcPdyurNOlT47aXnZNmx4vFJoB3nXHEJ1ZH6lC6o9svzU+q+S1J7KBbTFhn6l5/YRSzG8Bpr5vAOQng8xax2KpO9W+KYra5nrAkyv8ba9byXCskRcEAZTg+/048+KIzwW23KRy+Z2ep3aDTv5YRYtXNhwnfhBiXCTsjl+HrQJKPNg6i7+CY3Tef/ogitTCtR6YCP9nefU1T20aj+k2ppJuf41Deq2tb5iwb7LeSvo+RcopEnDasF6f6DFJplMIlDfx7t8DV+ojLXiMYSKJzy6OzADToNwQ2XCTkTArg+6xH+o9GBJzKr+Qi51e/Reg8ff5zfgJWEwHtuJH6yOZJus6MbFYshcy1I47MOFVUeygBXuv8fcY9Te6+YzGux3L/EIC4lvz1cLoPOPKfDUgbExWqkcCAETtG/9ANt09J3RMKZlwKDly2ez7c5j3fhMdN2iOaFKNf8hvmPXilTBOIjg8Dh1CsxOQUnlzcD4X+2VDmmX/STLMp7GGWjVvFnbMy8d1wtsz2ZPgjR7Yn1XgCGm8mlZKugFFQVH5CyuiCkkjmD+TdCmhw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6049299003)(4053099003)(4143699003)(6133799003)(10067099003)(8096899003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nzd3U2pHVFUrRDZXdjBmRi9Rd294b0lOS25GeEtXc2JqVmVKcUFqYmJwM0Vp?=
 =?utf-8?B?TlZEd2c1RnFFRDVYYnphbDZvK0R0aGcwNkVwQk01b01CUW5nUTR3TnJjNjli?=
 =?utf-8?B?THJXbE9yeFkrVVZmY2VWWEV4dlpsN1REa241ZnNpM2xjZ2dBOVUxTW5aVUsw?=
 =?utf-8?B?UXI0NVB0MjI4T3pGU3h0eXlDakhwMzBlemRLUDk4UWpmWDU2T05KMk9wOENF?=
 =?utf-8?B?MHBEejAvZDFGaUU0TWdZdXF0MVlxZXI5RFRjZTlGTGRmODZlOG9XTFZKa0du?=
 =?utf-8?B?bVc0cG9IbDUyRVZsUG9QVzRzVS9WMzN1ZUFldm9DeWtCQ0pHVFkxQTV3R3d5?=
 =?utf-8?B?L3hpSlR6djEyaytqeTdEUnZORHZEVysxT2E4WVdzUUlrd05qa01IemQ5KzBq?=
 =?utf-8?B?cG5HSXZjNnlUaWlKcFd5d2VXdS9EQ3N4K1ExZ1lDclhGRTk2YmtpMytKNTg2?=
 =?utf-8?B?eGhpenBFbC84c0pCQm81eTA3YTUxMFNHSktjVlRQbnpzdmZZTmIwcmdrYmtB?=
 =?utf-8?B?dkwrdU5xVnNoK0RUR0VzcVc1dXB0WEhYMlJ1SFJRb0ZSc1RkQ2RmTGRqNVZO?=
 =?utf-8?B?ZDRjL28zeUdmMlFESTNTQUJiZUhXUURDY2FYWStyVE5RTjkxQXREUytIVXA5?=
 =?utf-8?B?aFd6NG9aWndDemtCY3JBQTNtamNQUVpubVhZTFE3MGJIQ0ZKOEhqcGtkQTBW?=
 =?utf-8?B?ZWxCQzdKNU5TTDNFbm5idzJPaUtiamU3amFpWDBNbkIvWXp2NEYxZkthVGw4?=
 =?utf-8?B?eUNqS3UyOERqcDdCdWZCWjdyRVhmMW5kTXVvdFpRM3EyRHRFb2FHdmU1ekFw?=
 =?utf-8?B?SGJjcFlFNlg4SXZPWjBqY3B5TDdqUXJNTzhDL3BuZVNYS0s2YU1jUDVMbnBN?=
 =?utf-8?B?QXVJbS9tUEV4dnN6aXNyTXNxdjg3Tks2aVhTb0hYTUNWZ0VnNFJZdDA2OEZh?=
 =?utf-8?B?WXprRURlM3U1RHVaRjI0QXJweE8rUHlGeThWb1QrLzZXUThneDhBQXh3ZDVM?=
 =?utf-8?B?aytRMUJTMHhsZkNYSFNLZWhJMUVkYXFpb0VDbmVodmtLOXlKaWxEbjBpaEVW?=
 =?utf-8?B?S2Y4ZWpUcnhtQ1BkRE9zaWg4WFcrQWhqRWpMeEJzYk15endFSEhEMW9jV0tG?=
 =?utf-8?B?T2VBNkxRNnZlb2xGdTRlSld1bTBtWVBZcWVFYjJTL3JTUmdLajdsSVdGczVk?=
 =?utf-8?B?MzVLTnNySGN0c1VIRlRmZEE2cGhWdEE0bUM2WFNaQUo3aWptcmNHaWk2citm?=
 =?utf-8?B?aFdXYlZ0ZWY5K1VUOTZoQkxZNWlOUE1ac2Z2NEJURkRrN2ZYQmoxdGl2eEdM?=
 =?utf-8?B?OG9kRURVbmhLVlU2QVRNMDQzb1VDS25KWTMrb2cxa1ZZbXFDN3FlSjdJU2Iv?=
 =?utf-8?B?RlE2cVZ5M1RLaTJsWWNjUS9VNnhlenlveTIvOGw0bmVoT3NzYWZZV0RGMFNl?=
 =?utf-8?B?bEpnQmd4ekluT28zWEJrUzY0T0c5aElRYWliNmE2N2VRZ0g1VWtjdDJ3M1VE?=
 =?utf-8?B?TUdoTnRzaXUxQUg4N1A3Mkg4eGdmQ0NFNzlRS1NqS1QrZ3V4K3ZIRE5aKzZh?=
 =?utf-8?B?OElFSEU5QlVIdHhoL1NKN0Q4R1Nzc21SbVJjKzMwazkrYjhHbjhOaTJOOTNs?=
 =?utf-8?B?V2JSdkRvckVQMmZEK3FCNHI5K2xwSTVuNm1uV1FTd09GYXRmbnNPWGYrQWdq?=
 =?utf-8?B?Tk9hMFF2WkQzNmc3SmVjMkdmVExaVHNVZzlYdmJBdGx3ZTBGRFA4MCtsUmJR?=
 =?utf-8?B?Y1EyR04yVDJmWjJOOTA2YUM2QTNzUWxxSE9nWHp2QUtYbW9IVjQ5Y0g1OUE5?=
 =?utf-8?B?b2lrVWw3YmVBZitvY0tKMUVuclc3TEFrVytIQmhuM3dkZjVuK2RwV2FQSTBJ?=
 =?utf-8?B?aTc4Rm1IZklOdG5BTEYveWN4ZVh1RG5ySmgrMHZQMnZCSjN6aXkza25seGhC?=
 =?utf-8?B?Zk1Rb2NtUXZNL1JFcDJVV0ZhVkVhUzZJN1JBaDQ1V3NHQjdwWEhHRjlab1Q0?=
 =?utf-8?B?RTBpT1puTTJIb0REbWlxNWx6SkVTdnpKcUVRSjI4Yyt5QmFKS3F2NzJlcTRT?=
 =?utf-8?B?Ui93elo0U01oWnJIVjlUazdEZWFZeDdMV2hnbk1HWDZxbUl2ZXRzMy9ScXZ5?=
 =?utf-8?B?ZHU0Q3dtWjE1UHZHYW1VU3M4Y3NLeW1mVVY0ZGVyVzlINmIrY2FkMmpNODkw?=
 =?utf-8?B?ajhZaDZkVTBrU1JzVHhsYklPVUExQXdnRjBCRXY5dmdoVThGamVkZHNpdWt1?=
 =?utf-8?B?ZG81K1h6RFZ3Q2Jsa0hETC92M0NjZms5alMzQjB6QStMRVJOY2J3ckhqV05X?=
 =?utf-8?B?OG9rUEJVK0d5Z2RDNW5wYzR1dVNNQXJsNkhjb0FTOCt2SFUxTnQ1Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c11e8e34-4322-474c-3f71-08def85e1831
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 10:40:15.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Ob7RW8QiU143KPZ4Q346/odmnjtR/yFRSrX5ORZJHyJ5u8qlvDEucGKr796d6tx+Exro19G1ex3UEMMefFs+Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948
Message-ID-Hash: KNL5PRAZMJONQWA3M34PSKNEHIOQE276
X-Message-ID-Hash: KNL5PRAZMJONQWA3M34PSKNEHIOQE276
X-MailFrom: Syed.SabaKareem@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KNL5PRAZMJONQWA3M34PSKNEHIOQE276/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--------------ixTgtzvIyDXMDdwxUn2QB0KJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/10/26 11:06, Mukunda,Vijendar wrote:
>
>
> On 8/9/26 18:22, Alexandru wrote:
>> Hello,
>>
>> The internal digital microphone (DMIC/PDM) on the HP 255R G10 laptop 
>> is not detected/working under Linux.
>>
>> SYSTEM INFORMATION:
>> - Model: HP 255R G10
>> - CPU: AMD Ryzen 7 7735U (Rembrandt-R / Yellow Carp)
>> - ACP PCI Device: 1022:15e2 (rev 60)
>> - Subsystem ID: 103c:8d22
>> - Tested Kernels: 6.x / 7.x (CachyOS / Arch Linux)
>>
>> PROBLEM DESCRIPTION:
>> The AMD ACP 6.x PCI device (1022:15e2) is bound by the 
>> `snd_pci_acp6x` driver, but no ALSA DMIC/PDM PCM capture device is 
>> instantiated (`arecord -l` only lists the HDA ALC236 codec).
>>
>> In Windows, the internal microphone works properly through the AMD 
>> Audio CoProcessor driver (amdacpbus.sys) using HP DMIC extensions 
>> (`amddmicextt_hp_*.inf`) and is presented as "Microphone Array (AMD 
>> Audio Device)".
>>
>> In Linux, the board subsystem ID (103c:8d22) appears to be missing 
>> from the DMI match table in `sound/soc/amd/yc/acp6x-mach.c` (or 
>> equivalent ACP 6.x machine driver).
>>
>> DMI / PCI DETAILS:
>> Vendor ID: 0x1022
>> Device ID: 0x15e2
>> Subsystem Vendor: 0x103c
>> Subsystem Device: 0x8d22
>>
>> `lspci -nnk -s 03:00.5`:
>> 03:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. 
>> [AMD] Audio Coprocessor [1022:15e2] (rev 60)
>> Subsystem: Hewlett-Packard Company Device [103c:8d22]
>> Kernel driver in use: snd_pci_acp6x
>> Kernel modules: snd_pci_acp6x, snd_soc_acp6x_mach
>>
>> Requesting to add a quirk/entry for DMI_BOARD_NAME "8D22" / Subsystem 
>> 103c:8d22 to enable ACP PDM/DMIC support for this laptop model.
> @kareem: Add a machine driver quirk patch and share it for validation.

@Alexandru: Please find the attached patch for the addition of the DMI id's.

Kindly test it and let us know the results. Once validated, we will 
upstream the changes.

>>
>> Best regards,
>> Alex
>
--------------ixTgtzvIyDXMDdwxUn2QB0KJ
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ASoC-amd-yc-Add-DMI-entry-for-HP-255R-G10-laptop.patch"
Content-Disposition: attachment;
 filename*0="0001-ASoC-amd-yc-Add-DMI-entry-for-HP-255R-G10-laptop.patch"
Content-Transfer-Encoding: base64

RnJvbSA5OGVmOWI3YmY0NWVmMzNkN2ZiOWEwNGY0NzAxMWI4NGU5ZTFiMTg3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTeWVkIFNhYmEgS2FyZWVtIDxTeWVkLlNhYmFLYXJlZW1AYW1k
LmNvbT4KRGF0ZTogV2VkLCAxMiBBdWcgMjAyNiAxNTo0NjowNSArMDUzMApTdWJqZWN0OiBbUEFU
Q0hdIEFTb0M6IGFtZDogeWM6IEFkZCBETUkgZW50cnkgZm9yIEhQIDI1NVIgRzEwIGxhcHRvcAoK
VGhlIEhQIDI1NVIgRzEwIGxhcHRvcCBoYXMgYW4gaW50ZXJuYWwgRE1JQyBjb25uZWN0ZWQKdG8g
dGhlIEFNRCBBQ1A2eCBhdWRpbyBjb3Byb2Nlc3Nvci4KQWRkIGEgRE1JIHF1aXJrIGVudHJ5IHNv
IHRoZSBpbnRlcm5hbCBtaWNyb3Bob25lIGlzCnByb3Blcmx5IGRldGVjdGVkIG9uIHRoaXMgbW9k
ZWwuCgpSZXBvcnRlZC1ieTogZXJhbGVleHh4QGdtYWlsLmNvbQpTaWduZWQtb2ZmLWJ5OiBTeWVk
IFNhYmEgS2FyZWVtIDxTeWVkLlNhYmFLYXJlZW1AYW1kLmNvbT4KLS0tCiBzb3VuZC9zb2MvYW1k
L3ljL2FjcDZ4LW1hY2guYyB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9hbWQveWMvYWNwNngtbWFjaC5jIGIvc291bmQv
c29jL2FtZC95Yy9hY3A2eC1tYWNoLmMKaW5kZXggM2Y4NTIzOTNmYzk5Li4yZWI1ZmJjZWFjNjkg
MTAwNjQ0Ci0tLSBhL3NvdW5kL3NvYy9hbWQveWMvYWNwNngtbWFjaC5jCisrKyBiL3NvdW5kL3Nv
Yy9hbWQveWMvYWNwNngtbWFjaC5jCkBAIC04NzgsNiArODc4LDEzIEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgZG1pX3N5c3RlbV9pZCB5Y19hY3BfcXVpcmtfdGFibGVbXSA9IHsKIAkJCURNSV9NQVRD
SChETUlfQk9BUkRfTkFNRSwgIlRNMjQyMyIpLAogCQl9CiAJfSwKKwl7CisJCS5kcml2ZXJfZGF0
YSA9ICZhY3A2eF9jYXJkLAorCQkubWF0Y2hlcyA9IHsKKwkJCURNSV9NQVRDSChETUlfQk9BUkRf
VkVORE9SLCAiSFAiKSwKKwkJCURNSV9NQVRDSChETUlfUFJPRFVDVF9OQU1FLCAiOEQyMiIpLAor
CQl9CisJfSwKIAl7fQogfTsKIAotLSAKMi40My4wCgo=

--------------ixTgtzvIyDXMDdwxUn2QB0KJ--
