Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14327C531F9
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Jul 2026 21:12:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2097E60201;
	Fri, 24 Jul 2026 23:12:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2097E60201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784927564;
	bh=AbCpdC2ezi9hR+6iBckPACp39p4YRj3t6uiq+Yevihc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=FRwrAUQrFl7fBkqQhHnpYa7lgeJLTvu6IBeIbDdm3iHAwqWp8qk3eIX+ZulaLVRPa
	 5x7hB8+2Inx4AKal+lNW/iUEfHAbIZnpyHijt68xFHRXdOm/W8STKkuu1A6kbu25pA
	 MXXSKuizyST3eymXygdgz+f4oVQOEfT10jmfbnBw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B6176F80617; Fri, 24 Jul 2026 23:11:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B51AF8061E;
	Fri, 24 Jul 2026 23:11:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6955EF805BF; Fri, 24 Jul 2026 13:31:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.27
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1784892688;
	b=UYVFIeIh6nZowkYywBBkN5Mt9yBAi3BDRmrz/0RKE24SjiGQvC47NY0ITnsfuBf9zyU7
	 Fokq4yt6OQx9Rg//fSSqmaLshzhFVuBQgtU+6Ve8C9asgOCo3KJ2viv1wGZm7+Ulr3pIr
	 9PhqLjUF0t7XlBwv0J85vz/mkiBm/qNQt1XsgZ7wfAq6yHXufEEyadyyKHazXHp0/bBWX
	 jucd/vp2A5oi1nf1dWZRlOTlzR6rQpWNfrHNtwmIJ+8EQQDyFrCxr6pqjvg+qbCWZ42q1
	 KYix1dEmLCfxZdmqAd5ZtALSPWursDpNkGAXTACvknJ3xHSRHNs3XuuOxZWZuv0gzsg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1784892688;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AbCpdC2ezi9hR+6iBckPACp39p4YRj3t6uiq+Yevihc=;
	b=S+KAtVZaTvfI8gtRKCgLS8w9CLIIYdweEd/EZvZnxgGN1/94vaBw33kGh3AyaaPeOOz0
	 nMvZhvY4UlQhd/hDU5s2/pxc77HJicapVd18cN1VWO3BXZ9+gwkMIwoZQCSXDDPfkA4q/
	 O7xqz57eDWgMZ7XYphU5M76fQ8cvV1exWD5WddsehCx2t7vg4aCqUq8LKwMJROxXZ8MEh
	 aUC+Y81xQcmlmNMDJKvSK8yxfvkuUYVeKfzb7gblLAt8+BkdVOJxmIxwl4mvPPmOivHBC
	 pyRswtB86kkr6QqfKCfXD5tErdKpoFO35mwLW9LXP6vDHoaOTcYNXlzIRsI92PaeUCA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=b12aXCDM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.27
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azolkn19011027.outbound.protection.outlook.com [52.103.12.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E9434F802BE
	for <alsa-devel@alsa-project.org>; Fri, 24 Jul 2026 13:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E9434F802BE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=b12aXCDM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb/Ppzyp0w6OnRsKwo5q0/lnG+5Z0ucorVYBtzZX/UavfH7CinLCGdzCOZIc/eHrk+tvf0BjnzLP01DfDAOA1DUea5PlwgSvaIChuXn7MoihZsQL8ss83wCdPx19+K9kvjo5WtejUVl46u4ldkcjUNRRhVTgLzEbqd3Ni7Ibgqgoi0zRFz8NGDrV9gKkTz/JcpVxBDjDE6wyvZFBYKZwPsC0KuItPNM1McvaqKDeSBwncSzd3HKb3tnbHm5XawOnO9F5ZielCwOxnq7ihMoLF3pWDEvibIvAmbLGGmjIBVtXKzOdHB2Dsosq4BRrKewu7lBHy4c865cfaH8j1FrYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbCpdC2ezi9hR+6iBckPACp39p4YRj3t6uiq+Yevihc=;
 b=vHbxjBG3rt0lM76iuOKsckzm0j3uSyWo7aFIC8t8AZyL5XsyNxxZwq2Xa7U/bflRZylGuYWG61qWvQ5coAnqEJ/ZYImMMsgGHiVPxUjheJWGvawFmlt1raCG42+OpaB96WPebzrSg7baww2S5hknlL/VEcA0D1K8K3n17/3HA2NPCJdp6dXB4J3waVgk0kkMab0FuS87E/BiNXDjLDwnBWNS9N9rPCLrrFoPuGAvKF2BxKSEK8jp2aXIT7WFwBamfLKu64PnGD3mJr08aLdhpSzE1lmUUm5XqcKhD5oPD8oXfsp+r9pli5FnyaMZ6gvkTQV6X2GnxY870TPWE+0ujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbCpdC2ezi9hR+6iBckPACp39p4YRj3t6uiq+Yevihc=;
 b=b12aXCDMUUuzvQ5fbj/+qGmzhFbHPz8Q+wGtI7d+74JVa3KZabC7nQZ7Nokwwn2CH9e4GC85feqa9s9MAyI2AKXTlmgqhkoViVQvznAgBKmrLlrLFCh1vEq6O6s2U+eduQnTErbRycsMW39u+XT4yuPJIxFcnHbmXiDfTzSpihhaNjNuhJm35UkHtqyxioGsiZ+aULOzuEhn00ORvP1+xkvV1QBxBJAwLqFntZfwOqHsjETWTzwfeTB0mwfuklf86fAzvObWenBFFlq63U3z/4PnPi2n3bFgS8Pnq8iRQC4UPFpa2uw2VtmAX2pmETepENEQPPFnuEeeHUkSGdlUaw==
Received: from MWHPR04MB10298.namprd04.prod.outlook.com (2603:10b6:303:29d::9)
 by IA3PR04MB9474.namprd04.prod.outlook.com (2603:10b6:208:514::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 11:31:23 +0000
Received: from MWHPR04MB10298.namprd04.prod.outlook.com
 ([fe80::826f:f28d:3ebb:895f]) by MWHPR04MB10298.namprd04.prod.outlook.com
 ([fe80::826f:f28d:3ebb:895f%6]) with mapi id 15.21.0245.012; Fri, 24 Jul 2026
 11:31:22 +0000
From: Demon Player <DemonPlayer0@outlook.com>
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
CC: "regressions@leemhuis.info" <regressions@leemhuis.info>, Mingyou Chen
	<qby140326@gmail.com>, Mario Limonciello <superm1@kernel.org>,
	"Vijendar.Mukunda@amd.com" <Vijendar.Mukunda@amd.com>, Takashi Iwai
	<tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Subject: 
 =?gb2312?B?u9i4tDogW1JFR1JFU1NJT05dIHNuZF9oZGFfaW50ZWw6IDE1cyBhdWRpbyBy?=
 =?gb2312?Q?esume_delay_on_AMD_Conexant_SN6140?=
Thread-Topic: [REGRESSION] snd_hda_intel: 15s audio resume delay on AMD
 Conexant SN6140
Thread-Index: AQHdG15oljGbxskmukyFauVxJSiXS7Z8iQAH
Date: Fri, 24 Jul 2026 11:31:22 +0000
Message-ID: 
 <MWHPR04MB1029801AFD77D790D33C53E1592CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
References: 
 <MWHPR04MB102982652A66D828B734EBC4C92CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
In-Reply-To: 
 <MWHPR04MB102982652A66D828B734EBC4C92CF2@MWHPR04MB10298.namprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB10298:EE_|IA3PR04MB9474:EE_
x-ms-office365-filtering-correlation-id: affd5dd9-6d77-48fb-fa91-08dee977167e
x-microsoft-antispam: 
 BCL:0;ARA:14566002|15030799006|15080799012|19101099003|51005399006|6050399003|8060799015|22091999003|24121999003|8062599012|31061999003|19110799012|3412199025|440099028|102099032|40105399003|3430499035|26121999007;
x-microsoft-antispam-message-info: 
 =?gb2312?B?MVlSY0lmYzRLdlM1aE1wOHJuelhoMUxTWU1qcDNTa2UrckVmZWsyc0hnb3hq?=
 =?gb2312?B?RWZXRDVTeUtZNzFMZkN4Q3hwSHBOWEpGc2tEd2tvQ2FwUkNMRjFKaW5JS0xt?=
 =?gb2312?B?SStrcFplVmdMMUZMSkUrQnZXZHRqV0YzSnMwSkFQRVRKZkdTbytlR0RXSVhp?=
 =?gb2312?B?UTJxVGxZN2ZDS1c0NDFYSWhVQ29JWnBVNEpFSVpkODk5MWtLNXdHTjg0WUVZ?=
 =?gb2312?B?VWRUQ3FUcS9saXE3c2R6dkk5emxleXk4OGtjd0lyMFFKWGgrTE9IOUwvSlgz?=
 =?gb2312?B?aHFuMWZySkU0Ulg4elZOcmRaWEtTZGk0bzRSbStpQ1RWQjJwbGwyRkZvRkgv?=
 =?gb2312?B?LytTaHdOQUJ5ZFJPVWF6dlVXeWhwUFJEMnl5LzFQTTNoMXNET2lOYWFldzcx?=
 =?gb2312?B?QThHQjVIVVM0MTZhNWtmVFZLdFNuQUNSUWc5RVFIOVEvZ0hTSCtuUjZMK3V5?=
 =?gb2312?B?QVlta0ZUSmFvZG1EZ2owT0ZobjEycHBQc0VxUXZnRUdQL1Y1SDN4eGhkY0JR?=
 =?gb2312?B?MGR1YitmZEQwM0ZKU0RibThmeGZ4eVlKa1c3b0hKRHc5RG1JcXJoM3hNRDdq?=
 =?gb2312?B?bktYRVlxa0oyN2J4R25uM1p1STN5UGhZdXlXajBIWEs5d3d5Vzg0bW1BMWha?=
 =?gb2312?B?c3BQWWwwM3d6ajdJSDZIeXVYSmdQdy9Va0U1NXBQTFRaNlI4eG5MVHNYVUxx?=
 =?gb2312?B?V201UU94Qk1rb0tHcm5nOE9DTXlkemVtVkFPV2FWcGE5RFlHU1JqS3hycHJs?=
 =?gb2312?B?WTd4Q1BDMitDLy82dDVTaC9KdStDUVo2OHBFc3MwZzM0clk5TzRwNHBIYnhq?=
 =?gb2312?B?WTYybnBWRmZFRktuaXZRRU1mejZJbThkc2dhYzZKZnZZenI0OHJZc2lrYXhv?=
 =?gb2312?B?bDdSNWIveGx4czNEK2Nac3RHZElTOTJCYncvK2laUFpHTzZYR3J5Qk9qWVFC?=
 =?gb2312?B?dHRxUEhVbGdKd2plNDZkQVdycndNbkdRQk4rWVdyKzZMQWtBNnhRTDgrNEpk?=
 =?gb2312?B?aEZvRVdORktHdXFVWHRkVGtkT3hjOXNzTXI0QWpKZSt2cStIVnNQenRtSW9p?=
 =?gb2312?B?a1VLRXRZMjVTYmgrZ2N1M3BhTzBWaGpLOVA5eFhOVStmT2VIRHdnbWZ5bTg4?=
 =?gb2312?B?MlpaYWN4ZFpCTmhjMmdFNDM1YUtuVjNQY0FsRXdJWFp5NmNjbW5HOTc1T2dS?=
 =?gb2312?B?amc3YjIvMzV3bUNGU2NzMTR4MndQWGNDcm9rc1IwT1AwZlJ3c2laN1RVTzJ4?=
 =?gb2312?B?ZmV5RHMwRE1HWTlST2NIYTc0QWFuZU5rY2c5VktQVVE5SzlYdUdyMklJWUhk?=
 =?gb2312?B?RzB5NUhleE5FT1BKTkNVK3hTclJNZ3hhZ0NwblJBamFpRmFHTnJETDErajlU?=
 =?gb2312?B?eTEvQ1lMWnJjZHF6b3doaEVIRUhRZkJOTlNwQ1dHZG5aUWs5UWdxMW1VNnlu?=
 =?gb2312?Q?CX5pAb2f?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?UC9PYU1sVGdZUEhlSldmeEMyRDFyQ2NzOXpLVzNOY2VGaEQrZjhrb28zbEVO?=
 =?gb2312?B?ZEhzVkFVZEhvOGt5cWQyQXdIUGRwM3UycmEyS0Y0TWsrbitqQXJ4VzZTdzQ0?=
 =?gb2312?B?UmltNWVBUGRyeEtDOVJWU2dVajJQZWZEUnRGUHRRdGQxOEJITUtWd1pTS0pF?=
 =?gb2312?B?T3FPN0pzSXIxZFEwSzBsSEJqV284SldIbFRUSUtzdlc0M0VCbk1rUVg1UVhE?=
 =?gb2312?B?K3pnYkE3UVRONGN5MW1mMHdKUGpuREp2VTQ0UWJkL3Y3ZXdTYWIxUlpuanp4?=
 =?gb2312?B?aGJCRjROMFB6Tm1WelRLeWtIOHpFZFFKbnlYUUxlMkgyWnRqMktyNXYyQUxi?=
 =?gb2312?B?dmQ2ME1aUU9tTTlsSW5aZ1F4QWNsaVFjMno5ZzFibzFYcEtaSDlFd1NWSHpB?=
 =?gb2312?B?ck9TdStkN2JPeWpsdjBnSk9ZSjJydk9VUllPU2pKSXdPaGl3NFFGRFZ1N3FS?=
 =?gb2312?B?V0d1VkNUWlFXaEllRTZJbjJ0dERkKzB2ZDJjVERDVDZjelRHK3lMMkZFa1hS?=
 =?gb2312?B?ZTloWGpEOU4rZDdraWV2UUg1UWZFNFk1d09MbGxtVndIWGNsbGcyUE1qYVFU?=
 =?gb2312?B?RFhtdU5Lb1REbS9haDhwc3gwd0ZmdnlIN0NwUEs2d0hPbUxzRHcxUkNmb3h5?=
 =?gb2312?B?VUVvZmI1VEowUlJMY3lJTk1ZVllDOVRld1NwS3ViMThGK01jRm1rVHBmbW1X?=
 =?gb2312?B?SEdGTHg0YnQyYUdPbUJpdFFXS2V6cnVERy9taldjZ3lkMWtqR25oVWR6UHhT?=
 =?gb2312?B?VW8yV3JKeE1zNkJHMGZ6Njc4ZnhVQWQwUEtMWFZXNkRrZ2l5K0RDeGlqaW94?=
 =?gb2312?B?dnRHdmRkWjA2L1l0Z3lxeXBCZ1p6STZnVERrM2hTYitzWU1NNFNmTHJVVmsv?=
 =?gb2312?B?L0MvMWdVd2RkYVFBcys2OVRRT3plWW81b1pMQnZnWldaZ1E4QkZ0anJXOHJQ?=
 =?gb2312?B?blpkVFRrQ1VidTZGMlFzd0N3WVI4N1BwazAwNjBuYUhhUm9jZjdWTkx0NmR5?=
 =?gb2312?B?UEY4K0VFYk1iWElaQ0NoVG1TdkxNSC9NSU1iMnQ0VHd2b1IxSnc3aUxTb2hE?=
 =?gb2312?B?UmNzMnRnU0ROVkpwK0M1YU1TN2IvTnU1YmtmNWJNZUZ5cEVtR01BLy9lLzNC?=
 =?gb2312?B?UmF4cy9GeWFWSS9mT3NWeThKNllLTDhVcWJIMWhzQlFWU3V1VTVLV2h0ZlBB?=
 =?gb2312?B?YytzQTIzUGE4c245QnRKYjRJQWtiaWt1MDhRVUNHa3c0NG4xZDVsTE52R0lw?=
 =?gb2312?B?NWdFU1FUcnBnUVBaQ0hsVFRHWUZUTlhsK3JjWTZGSzdKMEV5cnVaMnJVNEJU?=
 =?gb2312?B?RkRQTW1salR4RDlrSkdnZks3K1U1elR2N2xDOWZaWXMyQ0NwSVowbFErQXZJ?=
 =?gb2312?B?blNYY1M3RDRFeFB2RXRJKytWVWtiUktvVnF3T1QzV0lGL1p3UDBBbzMvd1gv?=
 =?gb2312?B?c3pQalNsbUM2OElzRm93VVVmYXNSdnF3a1d5c1NQN1VsMEtvWlRhN2RxSEJI?=
 =?gb2312?B?aHpLVDlxKzFBV0Q5MUpDM2hMejd0UEZ1dngvL1JYZUVGZ1hlaVNySVhUVTNM?=
 =?gb2312?B?dERBOCt5SjgrdkdLZld0dUNGc1c0bzcyZ2tPbVVUSXpGS2I2Zzh5Z2JwcmVS?=
 =?gb2312?B?eFZINEtuRksxRStjNWRrRVJUb1REV29oNHRnVjhmdCtaTE83WFdlR3Y3Wkcw?=
 =?gb2312?B?cVJsaVlVODJvZy9ZRW15SEdaeVZLRFNQVE1rMHFOc3loNFVEaTR4MFhyMzZE?=
 =?gb2312?B?dlh2WUZMMHhZRE5RZ0QwbVM3MHhranF1NlpmWkZ2eVhZaVhUMHhBeXA0UTFn?=
 =?gb2312?Q?N06PUWN6abC1FuFNy7Qp3K2doQkErPE835qF8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB10298.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 affd5dd9-6d77-48fb-fa91-08dee977167e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 11:31:22.0886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9474
X-MailFrom: DemonPlayer0@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 25QOQYJK6KMCDYQVLIL2G6TSKX3LUBQ7
X-Message-ID-Hash: 25QOQYJK6KMCDYQVLIL2G6TSKX3LUBQ7
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:11:49 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7HZ7SSEKBKWVH626N7TQZTPYI7MKRZ3H/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

DQpTdWJqZWN0OiBSZTogW1JFR1JFU1NJT05dIHNuZF9oZGFfaW50ZWw6IDE1cyBhdWRpbyByZXN1
bWUgZGVsYXkgb24gQU1EIENvbmV4YW50IFNONjE0MA0KDQpIaSwNCg0KUGxlYXNlIGFsbG93IG1l
IHRvIGNvcnJlY3QgYSBkZXRhaWwgaW4gbXkgb3JpZ2luYWwgcmVwb3J0Lg0KDQpUaGUgc3VzcGVu
ZCBzdGF0ZSB1c2VkIGR1cmluZyB0ZXN0aW5nIGlzIFMyaWRsZSAoTW9kZXJuIFN0YW5kYnkpLCBu
b3QgUzMgKFN1c3BlbmQgdG8gUkFNKS4NCg0KSSBjb25maXJtZWQgdGhpcyB3aXRoOg0KJCBjYXQg
L3N5cy9wb3dlci9tZW1fc2xlZXANCltzMmlkbGVdDQoNCkFsbCBiaXNlY3QgYW5kIHRlc3QgcmVz
dWx0cyB3ZXJlIGNvbmR1Y3RlZCB1bmRlciB0aGUgUzJpZGxlIHN0YXRlLiBUaGUgcmVncmVzc2lv
biByZW1haW5zIHJlcHJvZHVjaWJsZSBleGNsdXNpdmVseSB1bmRlciBTMmlkbGUuDQoNCkFwb2xv
Z2llcyBmb3IgdGhlIGNvbmZ1c2lvbi4gUGxlYXNlIGxldCBtZSBrbm93IGlmIGFueSBhZGRpdGlv
bmFsIGxvZ3MgYXJlIG5lZWRlZC4NCg0KI3JlZ3pib3QgczJpZGxlDQoNCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCreivP7IyzogRGVtb24gUGxheWVyDQq3osvNyrG8
5DogMjAyNsTqN9TCMjTI1SAxOToyNQ0KytW8/sjLOiByZWdyZXNzaW9uc0BsaXN0cy5saW51eC5k
ZXYNCrOty806IHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm87IE1pbmd5b3UgQ2hlbjsgTWFyaW8g
TGltb25jaWVsbG87IFZpamVuZGFyLk11a3VuZGFAYW1kLmNvbTsgVGFrYXNoaSBJd2FpOyBNYXJr
IEJyb3duOyBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmcNCtb3zOI6IFtSRUdSRVNTSU9OXSBz
bmRfaGRhX2ludGVsOiAxNXMgYXVkaW8gcmVzdW1lIGRlbGF5IG9uIEFNRCBDb25leGFudCBTTjYx
NDANCg0KU3ViamVjdDogW1JFR1JFU1NJT05dIHNuZF9oZGFfaW50ZWw6IDE1cyBhdWRpbyByZXN1
bWUgZGVsYXkgb24gQU1EIENvbmV4YW50IFNONjE0MA0KDQpIaSwNCg0KSSdtIHJlcG9ydGluZyBh
IHJlZ3Jlc3Npb24gaW4gdGhlIHNuZF9oZGFfaW50ZWwgYXVkaW8gZHJpdmVyIHRoYXQgSSBiaXNl
Y3RlZCBvbiBteSBBTUQgcGxhdGZvcm0uDQoNCkxhc3QgZ29vZCBrZXJuZWw6IHY3LjAuMTQNCkZp
cnN0IGJhZCBrZXJuZWw6IHY3LjEtcmMxDQpCaXNlY3RlZCBmaXJzdCBiYWQgY29tbWl0OiBkZjQx
NDhhNWEzY2YNCiAgKCJBU29DOiBBZGQgRE1JQyBzdXBwb3J0IGZvciB0aGUgQU1EIFJQTCBwbGF0
Zm9ybSIpDQoNCkhhcmR3YXJlOg0KMDE6MDAuMSBBdWRpbyBkZXZpY2UgWzA0MDNdOiBOVklESUEg
Q29ycG9yYXRpb24gR0IyMDYgSGlnaCBEZWZpbml0aW9uIEF1ZGlvIENvbnRyb2xsZXIgWzEwZGU6
MjJlYl0gKHJldiBhMSkgKHByb2ctaWYgMDAgW0hEQSBjb21wYXRpYmxlXQ0KKQ0KICAgICAgIFN1
YnN5c3RlbTogTlZJRElBIENvcnBvcmF0aW9uIERldmljZSBbMTBkZTowMDAwXQ0KICAgICAgIFBo
eXNpY2FsIFNsb3Q6IDANCiAgICAgICBGbGFnczogYnVzIG1hc3RlciwgZmFzdCBkZXZzZWwsIGxh
dGVuY3kgMCwgSVJRIDEwNywgSU9NTVUgZ3JvdXAgMTQNCiAgICAgICBNZW1vcnkgYXQgZmMwODAw
MDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9MTZLXQ0KICAgICAgIENhcGFiaWxp
dGllczogWzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMw0KICAgICAgIENhcGFiaWxpdGll
czogWzQ4XSBNU0k6IEVuYWJsZS0gQ291bnQ9MS8xIE1hc2thYmxlKyA2NGJpdCsNCiAgICAgICBD
YXBhYmlsaXRpZXM6IFs2MF0gRXhwcmVzcyBFbmRwb2ludCwgSW50TXNnTnVtIDANCiAgICAgICBD
YXBhYmlsaXRpZXM6IFs5Y10gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MTQgPD8+
DQogICAgICAgQ2FwYWJpbGl0aWVzOiBbMTAwXSBEYXRhIExpbmsgRmVhdHVyZSA8Pz4NCiAgICAg
ICBDYXBhYmlsaXRpZXM6IFsxMGNdIEFkdmFuY2VkIEVycm9yIFJlcG9ydGluZw0KLS0NCjA2OjAw
LjEgQXVkaW8gZGV2aWNlIFswNDAzXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1E
L0FUSV0gUmFkZW9uIEhpZ2ggRGVmaW5pdGlvbiBBdWRpbyBDb250cm9sbGVyIFsxMDAyOjE2NDBd
IChwcm9nLWlmIDAwIFtIREENCmNvbXBhdGlibGVdKQ0KICAgICAgIFN1YnN5c3RlbTogQUlzdG9u
ZSBHbG9iYWwgTGltaXRlZCBEZXZpY2UgWzFkMDU6NTAwNV0NCiAgICAgICBGbGFnczogYnVzIG1h
c3RlciwgZmFzdCBkZXZzZWwsIGxhdGVuY3kgMCwgSVJRIDEwOSwgSU9NTVUgZ3JvdXAgMjANCiAg
ICAgICBNZW1vcnkgYXQgZmM1YzgwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW3NpemU9
MTZLXQ0KICAgICAgIENhcGFiaWxpdGllczogWzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRp
b246IExlbj0wOCA8Pz4NCiAgICAgICBDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVu
dCB2ZXJzaW9uIDMNCiAgICAgICBDYXBhYmlsaXRpZXM6IFs2NF0gRXhwcmVzcyBMZWdhY3kgRW5k
cG9pbnQsIEludE1zZ051bSAwDQogICAgICAgQ2FwYWJpbGl0aWVzOiBbYTBdIE1TSTogRW5hYmxl
KyBDb3VudD0xLzEgTWFza2FibGUtIDY0Yml0Kw0KICAgICAgIENhcGFiaWxpdGllczogWzEwMF0g
VmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBJRD0wMDAxIFJldj0xIExlbj0wMTAgPD8+DQog
ICAgICAgQ2FwYWJpbGl0aWVzOiBbMmEwXSBBY2Nlc3MgQ29udHJvbCBTZXJ2aWNlcw0KICAgICAg
IEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBzbmRfaGRhX2ludGVsDQotLQ0KMDY6MDAuNSBNdWx0aW1l
ZGlhIGNvbnRyb2xsZXIgWzA0ODBdOiBBZHZhbmNlZCBNaWNybyBEZXZpY2VzLCBJbmMuIFtBTURd
IEF1ZGlvIENvcHJvY2Vzc29yIFsxMDIyOjE1ZTJdIChyZXYgNjIpDQogICAgICAgU3Vic3lzdGVt
OiBBSXN0b25lIEdsb2JhbCBMaW1pdGVkIERldmljZSBbMWQwNTo1MDA1XQ0KICAgICAgIEZsYWdz
OiBmYXN0IGRldnNlbCwgSVJRIDI1NSwgSU9NTVUgZ3JvdXAgMjQNCiAgICAgICBNZW1vcnkgYXQg
ZmM1ODAwMDAgKDMyLWJpdCwgbm9uLXByZWZldGNoYWJsZSkgW2Rpc2FibGVkXSBbc2l6ZT0yNTZL
XQ0KICAgICAgIENhcGFiaWxpdGllczogWzQ4XSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246
IExlbj0wOCA8Pz4NCiAgICAgICBDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2
ZXJzaW9uIDMNCiAgICAgICBDYXBhYmlsaXRpZXM6IFs2NF0gRXhwcmVzcyBFbmRwb2ludCwgSW50
TXNnTnVtIDANCiAgICAgICBDYXBhYmlsaXRpZXM6IFthMF0gTVNJOiBFbmFibGUrIENvdW50PTEy
OC8xIE1hc2thYmxlLSA2NGJpdCsNCiAgICAgICBDYXBhYmlsaXRpZXM6IFsxMDBdIFZlbmRvciBT
cGVjaWZpYyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49MDEwIDw/Pg0KICAgICAgIENh
cGFiaWxpdGllczogWzJhMF0gQWNjZXNzIENvbnRyb2wgU2VydmljZXMNCiAgICAgICBLZXJuZWwg
bW9kdWxlczogc25kX3BjaV9hY3AzeCwgc25kX3JuX3BjaV9hY3AzeCwgc25kX3BjaV9hY3A1eCwg
c25kX3BjaV9hY3A2eCwgc25kX2FjcF9wY2ksIHNuZF9wY2lfcHMsIHNuZF9zb2ZfYW1kX3Jlbm9p
ciwgc25kXw0Kc29mX2FtZF9yZW1icmFuZHQsIHNuZF9zb2ZfYW1kX3ZhbmdvZ2gsIHNuZF9zb2Zf
YW1kX2FjcDYzLCBzbmRfc29mX2FtZF9hY3A3MA0KLS0NCjA2OjAwLjYgQXVkaW8gZGV2aWNlIFsw
NDAzXTogQWR2YW5jZWQgTWljcm8gRGV2aWNlcywgSW5jLiBbQU1EXSBSeXplbiBIRCBBdWRpbyBD
b250cm9sbGVyIFsxMDIyOjE1ZTNdIChwcm9nLWlmIDAwIFtIREEgY29tcGF0aWJsZV0pDQogICAg
ICAgRGV2aWNlTmFtZTogUmVhbHRlayBBTEMxMjIwDQogICAgICAgU3Vic3lzdGVtOiBBSXN0b25l
IEdsb2JhbCBMaW1pdGVkIERldmljZSBbMWQwNTozMDEwXQ0KICAgICAgIEZsYWdzOiBidXMgbWFz
dGVyLCBmYXN0IGRldnNlbCwgbGF0ZW5jeSAwLCBJUlEgMTEwLCBJT01NVSBncm91cCAyNQ0KICAg
ICAgIE1lbW9yeSBhdCBmYzVjMDAwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT0z
MktdDQogICAgICAgQ2FwYWJpbGl0aWVzOiBbNDhdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlv
bjogTGVuPTA4IDw/Pg0KICAgICAgIENhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50
IHZlcnNpb24gMw0KICAgICAgIENhcGFiaWxpdGllczogWzY0XSBFeHByZXNzIEVuZHBvaW50LCBJ
bnRNc2dOdW0gMA0KICAgICAgIENhcGFiaWxpdGllczogW2EwXSBNU0k6IEVuYWJsZSsgQ291bnQ9
MS8xIE1hc2thYmxlLSA2NGJpdCsNCiAgICAgICBDYXBhYmlsaXRpZXM6IFsxMDBdIFZlbmRvciBT
cGVjaWZpYyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9MSBMZW49MDEwIDw/Pg0KICAgICAgIENh
cGFiaWxpdGllczogWzJhMF0gQWNjZXNzIENvbnRyb2wgU2VydmljZXMNCg0KSXNzdWUgZGVzY3Jp
cHRpb246DQpBZnRlciByZXN1bWluZyBmcm9tIHN1c3BlbmQgKFMzKSwgdGhlIG9uYm9hcmQgYXVk
aW8gZGV2aWNlIHRha2VzIGFwcHJveGltYXRlbHkgMTUgc2Vjb25kcyB0byBiZWNvbWUgYXZhaWxh
YmxlLiBEdXJpbmcgdGhpcyBkZWxheSwgYXBsYXkgLWwgc2hvd3MgdGhlIGRldmljZSB3aXRoIFN1
YmRldmljZXM6IDAvMSwgb3IgdGhlIGRldmljZSAoQ29uZXhhbnQgU042MTQwKSBpcyBjb21wbGV0
ZWx5IG1pc3NpbmcgZnJvbSB0aGUgbGlzdC4NCg0KZG1lc2cgZXJyb3JzIChmcm9tIHRoZSBicm9r
ZW4ga2VybmVsKToNClsgICAzNi4zNjI1NjhdIHNuZF9oZGFfaW50ZWwgMDAwMDowNjowMC42OiBD
T1JCIHJlc2V0IHRpbWVvdXQjMiwgQ09SQlJQID0gNjU1MzUNCg0KU3RlcHMgdG8gcmVwcm9kdWNl
Og0KMS4gQm9vdCBpbnRvIGFueSBrZXJuZWwgZnJvbSB2Ny4xLXJjMSBvciBsYXRlciAoaW5jbHVk
aW5nIHRoZSBiYWQgY29tbWl0KS4NCjIuIFN1c3BlbmQgdGhlIHN5c3RlbTogc3lzdGVtY3RsIHN1
c3BlbmQNCjMuIFJlc3VtZSBhZnRlciB+MTAgc2Vjb25kcy4NCjQuIFJ1biBhcGxheSAtbCBhbmQg
b2JzZXJ2ZSB0aGF0IHRoZSBzb3VuZCBjYXJkIGVpdGhlciBzaG93cyBTdWJkZXZpY2VzOiAwLzEg
b3IgaXMgbWlzc2luZy4NCjUuIFdhaXQgfjE1IHNlY29uZHMsIHJ1biBhcGxheSAtbCBhZ2Fpbi4g
VGhlIGRldmljZSBhcHBlYXJzIGFuZCB3b3JrcyBub3JtYWxseS4NCg0KQWRkaXRpb25hbCBub3Rl
czoNCi0gSSBjb25maXJtZWQgdGhlIGlzc3VlIHBlcnNpc3RzIG9uIHRoZSBsYXRlc3QgbWFzdGVy
IGJyYW5jaC4NCi0gSSBjb25maXJtZWQgdGhhdCByZXZlcnRpbmcgY29tbWl0IGRmNDE0OGE1YTNj
ZiByZXNvbHZlcyB0aGUgcHJvYmxlbS4NCi0gVGhlIGlzc3VlIGRvZXMgTk9UIG9jY3VyIG9uIHY3
LjAuMTQgb3IgZWFybGllci4NCg0KUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSBuZWVkIGFueSBh
ZGRpdGlvbmFsIGxvZ3MgKGFsc2EtaW5mbywgZnVsbCBkbWVzZywga2VybmVsIGNvbmZpZykuDQoN
CiNyZWd6Ym90IGludHJvZHVjZWQ6IHY3LjAuMTQuLnY3LjEtcmMxDQo=
