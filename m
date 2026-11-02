Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3700606A324
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=uez+ZjGW;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ekODGrop
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 491E560203;
	Mon,  2 Nov 2026 14:52:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 491E560203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793627532;
	bh=Y2t8qn2+2QVtg71lMDZXo1XLgN83yAETR3YC/O8cJx0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uez+ZjGWe1G+egKtXbJaNNGPLGC8ERFc6dxoOXfmmnuuGdPVsPwtzpbQXGVFJ5dT6
	 rDomthTtFfPiD2FcnobIfLDeEVjj0qbXVUGwcvhJkanADgrs5SfnsHFDJCYYUI+56U
	 Tdxbp1S+rzWLyxXp8qT9ZQk8wT26ReMfM6snNaUE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9706EF8064C; Mon,  2 Nov 2026 14:51:15 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C939F8063B;
	Mon,  2 Nov 2026 14:51:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41CEBF8025E; Mon,  2 Nov 2026 14:41:26 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A2C83F80095;
	Mon,  2 Nov 2026 14:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A2C83F80095
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ekODGrop
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsaJ8SKPelOvO6rsNtUZIvnmVh4cXJUwnQzvIISO4EeZPyS3pDptlqjQzSTVqDyd6HQ54Y148yDHZraqm/oABeu5kKHn9A4iR4fSKUEzKyaLPCJJyTFpkRmgSBlN0h2wYI0MqAgpLbgS5Au9HaK7g2yiKhJpTiBVylkItHK486gQf1GEdPw8Bth6HpjjdjAxBJ6MFn/a36BqoW1KhtAq20y84sHW4gjNRvOWjjtM/Jj2gSEiJUsMtiiIOwG99VTctpyREVe2fmC2QXYiyWs1EtWiUCOuWiNzUhUHFGChwmSALFvofNCPO0lT7sNTDeE/7064Ez8qc1KCdn/hx/3eJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P67sC0CE7Bm8wgQmOzVoedv77qGXgv8uuvvWjRVOnoI=;
 b=JHsHf0NAtK4Z/fy8mcTo3msYMvh54BZsYuTp1qcb0OiWHo4dzAENxm1rYHV9yO7AqluDEp76aF478XKz2oAraCDiY6ZjwG52vCsoBKB2hb4PCMMamYrPBW9pYfXaH4dgvehkpQEfm4OBwAQ+eltvmmRMIC5NFJwcgg5CYzuD/PCWvdtEM07pPlrN6EXFAxtNOtXqUu58eD5ahyZgvMfbl2c4pTr7YGwa4RvnjKYrbz3Rv/KzncO1Kx/pi0aprcCO8xk0H8PQiyfL3F6qxR/rG+x3MfczDddKWo9T9FGBOei55UMoLoThHjCkzKCAD2vd25EpFf7y3OscwsknX1Q1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P67sC0CE7Bm8wgQmOzVoedv77qGXgv8uuvvWjRVOnoI=;
 b=ekODGropz1VwNPIxCn1iJqt50sogvpBUiyCuPxoUSGFP2q6I1gLtAIO8P+GR9gdo4IwEEwmEDviinbCVeHaG5XgNqA0sIMinf39LgZ9KUzAVaxEHLOOXGGjANcaAl6SdMzNEX+Zy1YE5EBti3XItMG3sw0spgaYXrvUG0qvtgBs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:58:52 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 05:58:51 +0000
Message-ID: <5facbf63-1b08-42a2-ab39-cc79e3be7e28@amd.com>
Date: Mon, 2 Nov 2026 11:31:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] ASoC: amd: acp: ACP7.B/7.F SoundWire machine
 driver support
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, yung-chuan.liao@linux.intel.com,
 Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
 venkataprasad.potturu@amd.com, Syed.SabaKareem@amd.com,
 Mario.Limonciello@amd.com, Richard.Gong@amd.com, Poojitha.N@amd.com,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
 <3f3d7e4b-dd5a-4ef9-806e-5bc98a40d2d3@linux.dev>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <3f3d7e4b-dd5a-4ef9-806e-5bc98a40d2d3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::17) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: e68a3c30-0fd2-4d72-b9ed-08df38a65e5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	v258Vt5O32UrBcc+6CCVM/LFqFABtwQFa01cNk3mGFdVa69KizxNlLNg3ua+3O50goPNIFnLy5RSknyWu917/htQhSwkOX4FIa4HXmawW31xq/L8o+BxZvDkP1RYjsg2jUXzmepFGOh0CvHlcQDeL5IQ2d18gI2uXYlSSxfUwompwFr4hASRyKUKfCbfaPRTrU0nHfCQfTqf5R7ZEDly8sXurx9pNKX7btCHoCj80HeFprnHopIZOB5xyXPNU3JUqTXsx2595AXX2GuEx+1j575iDL5gNaP+rd2c5I3a6g6ShkSwduo2IF+cfeVjwXZ+UKJZrk6nt1SIJu2CzTVl6aM4n4gjI8L8Aa5Xd1gdyZrSD36Y1JNsSrf3ru6K6DsoOU5DMcwizaOcMBNo/CQ2J1oQFgyZdrsz6Ek//gSETtspuDAsx3XkHJRZDTNU1z7ltG1hkFoa5A53L76HubDF+lCLOXXKqbXUb4x5KngRUySv1zWNwKOmajELDBX8V0UFV2QtjhUKgftUUnmDqHAUXeZ+pq9RKgXuJpn/WTWuOPXqkt3gU6j5oJC67vt3V0aGHviijW3PNZiRPoS9Y+Qw8A2s011T1RJQKyYYQfy6LAcMeqtThliFse5AMfdrbqsWD4t3vMkPP7n86gjCe7BowKymVljkNG8MB6t2pHATb3g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TzVrRDFlWnVnWlRCaFhKSitXeHpqQVZ6c0NnWS9GSlo2RHd2Q3NsS2xab0pz?=
 =?utf-8?B?cjJEYzRYOWxTSjkvZ3RBT0lGeHNzNkw4bXdIdXFXRjF3UitMQjFTRndoMk0y?=
 =?utf-8?B?c3kvelZ2VkdzK3ZkZy9FbFhVZmI1SVgrMVVsRHFpeVRqSDVNUmllVEltcVc4?=
 =?utf-8?B?RTdyKzByK3pQVGJoQjdudkFqWVFMdVB5cExVbHRJaEptTHZSVGNJa1M5MGFL?=
 =?utf-8?B?bG13emRZc1FUUFAzcHE0eVdhVnh3VzM3dERXOUUzV2trSk1WOEk5UjBXMHBW?=
 =?utf-8?B?Ty9uTThmOG10eitiN2o5UTJla3FJdDVieHBPZzFiV0Nna1hoZm05c1RFZGZP?=
 =?utf-8?B?RlQwb1IrNWkvdGdtWkJDRzZmRDB3dmQxMGNZS3kyeUZ4TEZsR2NiOTRrOWYx?=
 =?utf-8?B?RGZqcFRRM2xob3Y2MzV5emRsQnJJVzljazJ6cXBWUk5vOTZqcmNWdE0yTlk1?=
 =?utf-8?B?bXlFMkZSVDFrOStGdHNMbG9OOXozOU1pQTdBSkhaRDF1ZDRiTFFFc3pYMHNE?=
 =?utf-8?B?cDEvQ3VjQVg5ZmlhUVliM1I3dmRpc0tncjFPK1JQQUdIaStvMXhWZWh6OUVO?=
 =?utf-8?B?di9HRm5yTFNGQkQ2cmhqSnFlQWJGOFpFUHNWc1dmMjY5WVZYS3RTK1AxUGhO?=
 =?utf-8?B?VXRoNGk4YjJieWNTbTk5M0ZIZm4yMnE0UVRhdWFpaWJXTy9HZTVuWXdjNndW?=
 =?utf-8?B?TFdMUHB1cmFKSzFJSU0zUkp4SmNuY2ROaWdFQ3U2V2JTSWgvMENZSTcyQUFh?=
 =?utf-8?B?cWsyY1BWQU9TMEZjQ0Z3dklpZFRsR05ENHRFNVVJaGtCZitjamgxWWVweDBH?=
 =?utf-8?B?QmJkUFQzRmx2MW5TWDc4Mzgybk10eG5YOTcydXB4d1VQN20yKzZJeWxCOW9j?=
 =?utf-8?B?NHluOFdMZzVEQjg2WndDN0NIdytDa1FJY3l5b0F2TW1JeFh0WnFXRFFBSUhq?=
 =?utf-8?B?WlVkeGdlVWhGQTFtY2xyaWFBMFhWVHdNUmF1dTJNN28xcWhHamw2K0k2RCtH?=
 =?utf-8?B?RVRXSDJPMnhKVithMlpyVVB4R1F0N1ZEVmN0Yktqd1ppdjFVY0N5V3cwL0hF?=
 =?utf-8?B?RjEvZkFDeVl1aWtJY3J4TGlaY1R5NjhSeWdtOWhVbi90WVB4Vi9MdW1TRXZn?=
 =?utf-8?B?ayt4bGJnMXFZaTBsMVExdk91d1VlQlZyaEpkczlKUHZmcGlibUlhYmxhMDhj?=
 =?utf-8?B?cW4vSmdEQk1wTXQwZzN6V09IZVhuS214UUpsMjdvUmZNdXp4d0wxcktncmFt?=
 =?utf-8?B?RDNGUkhhZ1FQU3FIc053T3JndHhYVlQxYkptT0Q5UGlWZ1YzZEFnRGx4UjRs?=
 =?utf-8?B?TFR5bTNTaUladGdkUWN5dytxNmhjeks1K0FiV2RsLy85dG4ybkY3TkFyRGxU?=
 =?utf-8?B?S3d1SjV1ZHloOGN4cWhwNEJLL3ZudXBDVVJNVU1lejF1amlPYndnY1pzYWNr?=
 =?utf-8?B?bno2eDRET1JueXpJemMzQ0FKYVlSYUpUWFZCZFVPTHdjN01BbHRyS2NkT1RI?=
 =?utf-8?B?d0FlL0xtQ1FjR01FZ3dNR3NGV3JRL0FlcktISzVaVlY0T2oyYUNkb0lZd2c5?=
 =?utf-8?B?d3E3ZlI5djZWSFI3aUlWM3VESldWKy9ORnBINFRtZDhldkx1aVJKZDhlRGxO?=
 =?utf-8?B?Wm1pd2ZJbHFuNm54YzROOHlTWVFMRWVQSWs2YS9PTVNKNURwVExJYk1aMDFG?=
 =?utf-8?B?VjFuclUvT2JOd0lxMUdDM0ljTSs1Wk5CamgrOTBXaTBueFFrbnc0K1Nwemty?=
 =?utf-8?B?RktFTTZtVmFmNk5DOG9rQW0rQldtMzBSSEVXdmt5eVEvWGZHQnFoODd3ak84?=
 =?utf-8?B?RG5Zczdray82S2dwVWdHZnBaOERBdXRITDNnMjFRZ3VvYzUwMDkrdldKczdY?=
 =?utf-8?B?U2xjSDg5QVR2bG5UYlJVSnJlVEt6RURWQzNreURGNmZXdmg2NWFyZ2Vvam5o?=
 =?utf-8?B?YzhqQTlFNEpvcC9EZk1OVmJDSUk0ZWJLbml1WnNZWG0waFdBNlZoQUZGTTBm?=
 =?utf-8?B?MXZoQlRqOTQ1Ly9TNGU5b1RkRzUvd1ViVGh4TDZmSUN2U0E5Q3BLTVh0UDEx?=
 =?utf-8?B?RnBDcGoxbCtwTlNVWmdiRWtRYy9OZkRnQ2NOUUNTMHQ3YklCMnFSRE96eWxL?=
 =?utf-8?B?UzR5dWxpaFJYMmhSdDJTR0lqdXd2TE02S2pOOEtOZFRnN28xWE1uZmZuWUhx?=
 =?utf-8?B?UUovdHJMVWhCZTNqczJ6aDFOUlM0QjZuMTRzOW42RFVnN29qbnd5VDVONTRl?=
 =?utf-8?B?dUZGeHJxQzU2T3FvNkt0S1ZJZUhYcUc0Vis0Qk1OTmJrOUhoYm9rZHBocHl2?=
 =?utf-8?B?VkxzUzEyanZMZ3VoZnNTUUk5VEFtcWlFZUdsK293aXlzaU1lV0pVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e68a3c30-0fd2-4d72-b9ed-08df38a65e5d
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:58:51.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 ZrHTrKfczGfT5S43xaDG94bqXt0uoHvPLqCCxOKe3I19JuU2/M3pNyQO9Bqg5qN0WI+0oq8wBKcRDvjBN8LxcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231
Message-ID-Hash: HZQTYKE2N5NWBC5ICYLJL5BFDYWLJ62H
X-Message-ID-Hash: HZQTYKE2N5NWBC5ICYLJL5BFDYWLJ62H
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HZQTYKE2N5NWBC5ICYLJL5BFDYWLJ62H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 02/11/26 00:04, Pierre-Louis Bossart wrote:
> On 10/30/26 10:45, Vijendar Mukunda wrote:
>> This series adds SoundWire machine driver support for ACP7.B and ACP7.F
>> platforms. It extends the existing AMD ACP SoundWire infrastructure with
>> per-platform CPU pin ID lookup, PDM controller selection via ACPI and DMI
>> quirks, DMIC DAI link and components string handling, PCI subsystem ID
>> propagation, and ACPI machine tables for RT721/RT722/RT1320 codec
>> configurations on both platforms.
>>
>> Changes in v4:
>>   - Patch 1: fix missing asoc_sdw_mc_dailink_exit_loop() cleanup on
>>     devm_kasprintf() failure in acp-sdw-sof-mach.c mc_probe() (new).
>>   - Patch 2: fix missing asoc_sdw_mc_dailink_exit_loop() cleanup on
>>     both devm_kasprintf() failure paths in acp-sdw-legacy-mach.c
>>     mc_probe(); update commit message to reference the correct function
>>     name soc_card_dai_links_create() instead of sof_card_dai_links_create()
>>     (new).
>>   - Patch 3: remove unused ACP63_SDW_MAX_CPU_DAIS define (new).
>>   - Patch 5 (was 2): add comments above ACP7X_SW_AUDIO* define block
>>     and get_acp7x_cpu_pin_id() to document the dedicated per-port DMA
>>     layout and the port-to-use-case mapping.
>>   - Patch 9 (was 6): replace misleading "No functional change" claim
>>     with an accurate description of the behavioural change for platforms
>>     where ignore_internal_dmic is true (dmic_num now stays zero at the
>>     gate rather than reaching the dmic_num > 0 block).
>>
>> Changes in v3:
>>   - Patch 3: update subject and changelog to accurately describe the new
>>     PDM controller selection infrastructure being added.
>>   - Patch 5: fix commit subject prefix from "amd: acp7x:" to "amd: acp:"
>>     since the change is in the generic ACP SoundWire machine driver
>>     (acp-sdw-sof-mach.c), not the ACP7x-specific SOF driver.
>>
>> Changes in v2:
>>   - Patch 6: simplify the DMIC enable condition as suggested by Pierre:
>>     evaluate the three-way boolean once and nest the ignore_internal_dmic
>>     check inside, avoiding the double-tested condition from v1.
>>
>> Vijendar Mukunda (16):
>>   ASoC: amd: acp: fix missing cleanup on devm_kasprintf() failure in
>>     mc_probe()
>>   ASoC: amd: acp: fix missing cleanup on devm_kasprintf() failure in
>>     legacy SDW machine driver
>>   ASoC: amd: sdw: remove unused ACP63_SDW_MAX_CPU_DAIS define
>>   ASoC: amd: acp: add ACP7.B/7.F SoundWire link count for machine driver
>>   ASoC: amd: acp: add ACP7.B/7.F SoundWire DAI link support
>>   ASoC: amd: acp: add PDM controller selection for ACP7.B/7.F SoundWire
>>     machine driver
>>   ASoC: amd: acp: log ASOC_SDW_ACP_DMIC1 quirk in SOF SoundWire machine
>>     driver
>>   ASoC: amd: acp: enable DMIC DAI link based on PDM controller selection
>>   ASoC: amd: acp: move ignore_internal_dmic gate to DMIC enable
>>     condition
>>   ASoC: amd: acp: add DMIC components string for SOF SoundWire machine
>>     driver
>>   ASoC: amd: acp: set PCI subsystem ID for SOF SoundWire machine driver
>>   ASoC: amd: acp: fix MODULE_AUTHOR missing closing angle bracket
>>   ASoC: amd: acp: add ACPI machine tables for ACP7.F SoundWire
>>   ASoC: SOF: amd: add alt_machines for ACP7.F SOF SoundWire
>>   ASoC: amd: acp: add SoundWire machine table for ACP7.B platform
>>   ASoC: SOF: amd: register SoundWire alt_machines for ACP7.B
>>
>>  sound/soc/amd/acp/Makefile               |   2 +-
>>  sound/soc/amd/acp/acp-sdw-legacy-mach.c  |   8 +-
>>  sound/soc/amd/acp/acp-sdw-mach-common.c  |  48 ++++++
>>  sound/soc/amd/acp/acp-sdw-sof-mach.c     | 109 +++++++++++--
>>  sound/soc/amd/acp/amd-acp7x-acpi-match.c | 198 +++++++++++++++++++++++
>>  sound/soc/amd/acp/soc_amd_sdw_common.h   |  45 +++++-
>>  sound/soc/amd/mach-config.h              |   2 +
>>  sound/soc/sof/amd/pci-acp7x.c            |   2 +
>>  8 files changed, 396 insertions(+), 18 deletions(-)
>>  create mode 100644 sound/soc/amd/acp/amd-acp7x-acpi-match.c
> For the patchset:
>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
>
> I added two nit-pick comments on naming and DMIC0/DMIC1 explanations, in
> case you respin a v5.
Thanks for the review. Will address the naming and DMIC0/DMIC1
clarification comments with supplemental patches.


