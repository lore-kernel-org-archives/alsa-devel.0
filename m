Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FCCC53200
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2026 09:00:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31156601ED;
	Wed, 29 Jul 2026 11:00:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31156601ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785315635;
	bh=LS3CJtqVLPMnpD0t1t03zqSEqfEaVOoZ/1eo42Q+Wj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=OH0P5U+lvlsYkVonbDNcty8RvNrsu8L16fszrmXzYpRbFoDnPUBEjQwsEqgHqjBVU
	 7qidNMrP9UupcTf40Ef74+WKkYrqYZM09PniGJqDhVQyleVRfWiMU0FHoUOaKCHdTT
	 Ffbx1BW6xUbPtnUNmwZukQk++8+jpqMnaCKprndo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FF52F80601; Wed, 29 Jul 2026 10:59:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 060DDF805FE;
	Wed, 29 Jul 2026 10:59:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BEFAF80571; Wed, 29 Jul 2026 10:59:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785315584;
	b=Klulx5xVJ28K/2tqkdnFg6dPjxdN5rH5lxetSGrwo67uOQpB94Jalks/GOt53NRCeKUr
	 PAXxQWpp12xT10IdjfWHxcK//mmHxxMGOJ544u4YmLVxWjXtKHHFciIRYdqesjhNuAhJ3
	 Lo0uAkM2kMDZv3XBDB1Q76ISlCV/cfr8gkTpAgRuxBAPxp8nFO7o8QCVj2whvwBB8uFS5
	 VQLUPKJgocwC1ImjWjezrQIATwhlCDRbXpzzZrgR9KUySGq67h/xX/ay/gOHXiZWSU+w7
	 kBKf8TwOUJ3Gp9cp55uM5FYAGW9TKKX9Ok6iMEDcJ0FriFujSwyx4VULfgVmjvybNHA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785315584;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=LS3CJtqVLPMnpD0t1t03zqSEqfEaVOoZ/1eo42Q+Wj0=;
	b=nkV9HF208N6wFs5u1Evm+1WXI6b4r2n6TDKRXoeX/KWVjJI/U5LU/qUrMWvNGZPbeYOZ
	 smYoENXyovgubsoqCrDdmSYgXg2QEfQFWRmbYlTniQibsHHE78E4sfcytpfjpzRY8zYXq
	 LXVD69G5UefyXnOiMCE0Hfu4B76/Zfu2yPvUTr6Pz0Eyq7CL5yaZC7PfcIXWnAvL+ZBmp
	 D+Y0hPgcd035AirE8gPdDhdanj3engEpms99PHwg2+Rpc2b2DcmsvQi2b1mWbTwgo9Rqf
	 oyzGn6EQjV6slrCtwXpiAmN3Xuvpfs7IRVCVGx+Bvv7R9nWx1JkMk4lydGFAXdNY9Tw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=jrPDY4Sk;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=S7QlIGzn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.149.25
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40111F80537
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2026 10:59:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40111F80537
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=jrPDY4Sk;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=S7QlIGzn
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T5OTfG3860455;
	Wed, 29 Jul 2026 03:59:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=GfxCLodb5UG62qN+fhlCSpPyiJkgG7m0jM7+tHHqBRg=; b=
	jrPDY4Skdj/Bscwx3yUZbWcOIgFuatxcmme+/Eiz7DkyYCWLQ8rwT14n795u2QLG
	+QD5ViQVfVDs4uNgYeiQU02+xMNzOb9nyrqBmHHwxLjji44VvgCwLP5ElVL3IHEl
	IzYbbre+mtv2KT3ttQZ4t/iU+WR1Uokn3LpC2TeURpJG5pFeL6Y7DogFdt2gahIj
	bxN6/ILBSQlr52FQOq5PRSlgZvZWwoaz7UBl5LbBkveP8mIYnadMRhdP27R78FMP
	0L1yI5m7p1W2si1a16GklUO5ERxot3zgbGHEF4rCOEwAUDAGfu0wZkdfNgNqgNdH
	+BdgGRtvUGGF0FTN1NzCtA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11020122.outbound.protection.outlook.com
 [40.93.198.122])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fmthxd383-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 03:59:41 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k28uBgP5Prfng4X+LFkPMI+epHvywEdV1Q+ENveIV1ZlLZcT5sVaGYm1xncms/CL9A+tLsZcislDCGuVOMOI03wxioSm4HCK5PeNGzEo1WkwWxwSqsK6DkG07g9jZr0sLlo1r81POrrqH+hPpkFVkO5zTsCa3qunbVgbUUVz8/k+jTEAc9tsUFUdomfJDO6XwlTD/JWwx7+nRpgHBRRSD7s0QvmVzRec1x2mTqo60EAVuJewfQTepymgxyTHE4c8gY4HJnCp29cFzmmR+U338431KSOjGnXyTqdKT3Rp7uTPVikWen4oLgClAZQsCevK/jmX2IURh47uMEP+azgDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfxCLodb5UG62qN+fhlCSpPyiJkgG7m0jM7+tHHqBRg=;
 b=kb/U97M32zKiTzgRPEAstdAtRzqbyj2PhOaDj1CuISy0P1ugih/dWkcuQBDyS9b8sCy7CPG0A1DauD5iOEc8jBHf/wO/yHjPpKPdJ5Jzlp9IfCoeF9col4fdsT/zVwvR/f5uQmyf8hfWhgdZ1smFcjkTiCHOZRhSGcGh6L3DTzRGKcmnNk7Cr95SWbpphpnbllhZvz4oYA3mwkmr1mDj8O+usZdxZJwFc9f4Io7kB7x/gfsovwXFpU1ScRdeHnT6upV0CKSotQCLEx1Iawf5daby88nlhD23b1R0r/TAnoPufvof5tXqIrW0Oh7RBWq4KyNQG6alhLisYJiQEy/e7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfxCLodb5UG62qN+fhlCSpPyiJkgG7m0jM7+tHHqBRg=;
 b=S7QlIGznk4HynAWfclFxuyMDAPGf0gF1h2SqutbB4M2s8HGmv9G1Ssbw9jVXnqdBc1FZJslZ/zPDCH20U7WA/m+ywFdL08/irH6SGwsyeZoeU5mThPafjr1zswYqG4Z8yL5JWM+HbM5DfqfI+JfOzGqBaKoSgX3IKbB1VNUFpyM=
Received: from SJ0PR03CA0347.namprd03.prod.outlook.com (2603:10b6:a03:39c::22)
 by BLAPR19MB4290.namprd19.prod.outlook.com (2603:10b6:208:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Wed, 29 Jul
 2026 08:59:37 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::ab) by SJ0PR03CA0347.outlook.office365.com
 (2603:10b6:a03:39c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 08:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Wed, 29 Jul 2026 08:59:35 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 80957406541;
	Wed, 29 Jul 2026 08:59:34 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7B8BD82255A;
	Wed, 29 Jul 2026 08:59:34 +0000 (UTC)
Message-ID: <fd757dfa-9643-460a-a557-597d26c2a438@opensource.cirrus.com>
Date: Wed, 29 Jul 2026 09:59:34 +0100
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
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|BLAPR19MB4290:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b1c1e07-dbe0-4274-af03-08deed4fb701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|61400799027|82310400026|376014|23010399003|36860700016|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003|16102099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	+/NjTrl/GfqWsWndapkxpVJ2h014JuwcyJYPE0lWmG2u0YdvDa8z+oDY3SMv0Fv8ONuKGxKR8mcHRqeg19ZAwXkbPKSfVm53BOzBmho7EUElKCJkbK2N4P7YIFKsm3Eaghv0vw3KWvP40FFmff2GCiU/Ys5QQX0mJ2Z49YANLjP8eiGsJ5ZHgYqI7n9KH6R7OzobOs/kbphLx5re4tRKylfCF8ZT4vtid8P+eRz/1NhGDW2MV3q4dg5CUfjk3Q/EMbTC+5JJem4b/c/56kfXb8bJW1Wjs2M5SY5EXfIThu4K+O/6kxcwJeDjaFiSl+nHS1uNR0n1UFjJR8/Ve/qSJ7d8BKxYw9Ttp8Ek6n8Srpy/SYG4I0sJMAFFBGVRwIQf9Rb3keHXlYzvIV+YPPMsgozHyc88LAqyPigJC3PhPr75gpDWPLuMDJFiOhlVO8SkIchBbdMn6komvLWnuQBWLCqiQ9xHSc0gY0sJI6GUGbqigBmAZK08AC8gaUwY3Oh/9E0xTXnFg4jA0+Gf5SM4OyKJfdct2qsbkokifyeYZwKz6XoKtp54rrN1OYPhilX9Ruf2yMLuoztDngZ8q9KWksnhGkx14IENNQtg3Ah+vRu+fvFf/tQY0ppN/qda8UjO7bcttI71+/IrNq3Jx3nCJzGlk8//1Qlkrc2zhFKG0vgeTY53Mc248Pnsre3irN5V0qkzPqZr3P/joMWN5WXyDg==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(23010399003)(36860700016)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003)(16102099003)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Doz2BtgtYY6eoxKfBkL+5tlP2meoKFW7UzPXW3rVGh58NNAeuGz0VL1vGR7DW1pFq9W/IVOUPUbWRy6e6NwW39QIBlys0h9TTMxVGSnvXkYJ7Pyc4dy7q6urny/XMfPsDIev8iYnimF4ntV/zy+LSAGQLzPJrIgLlypm+Enr2yHkUqaZbnxDAXpT8yeyIp+Nj/kdrB7A7pmxuc015wxnBI6XyAWIBAduho4cBjrLe5W2cvR/9Tc/dsQX7Z59qCQfNKIYLZhK4jo+Umo6m6yp8S8ltL3Y/Zvq7S5ghaM0eu0RRrLmKdfTG6sUp41iwbteMGdXNFTmrwBG5pdSyiXt44dE47aBrtmbEQTgTHTS39O53HuM+kbz7+1JP21kW9hYzTriFve+G8nYo8Cibv95qKYwBb3mFHtJSsf2etsHwa3sTAbrnVGpfVn6jkurDRhR
X-Exchange-RoutingPolicyChecked: 
	PjsV7kNerRxRgcAyFGp11cNGtpJ3aLLdgVcBjG1fkUVROSAOlgXraVG+rZfofSI3us1o7zmBC86SeEwfOHwUNfBFCQZ2tjBjYYJ+xrjVnxMHynCOfJQCX0klDYztXdK61+BLtKaufxjJE2th0mseHxvUj/Acv9ztvLVpshTIqpUvOyxeDEZzdxNTtpMnoMtZuAjtX3DGyq2wSCr9sRLcgNyOkY71EpyFHnBtj+0pkA83FgZCyehZWZIOX4WJBV/qGZRT1nc3Kz+cPQ030i/Sx7F8miCan/NUxifHjh0wedSa7XB9IPbwnnk1ArcdFPOqlJNLPIFgELftMTfgoIlXlw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:59:35.8492
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4b1c1e07-dbe0-4274-af03-08deed4fb701
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR19MB4290
X-Authority-Analysis: v=2.4 cv=Js7Bas4C c=1 sm=1 tr=0 ts=6a69c0fd cx=c_pps
 a=NDowVQyA5LMHuT8sjPEy7w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=MEZ8rWnTcSKzUFmcpS8A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA3MyBTYWx0ZWRfX74//gG6xw08Y
 JrMfg22ZsgZE3HvqOjyYFre7lWDQZvUc+mp4lXuIg+EooiQsNO8xTvuqP8RX2vdCmpO+DrDFUu0
 B+zQAgnKkqGPKeg0PS1XD4aPaDfQCj/mWS3Tz565sl64LQcw3HP11fniq4VLEPHW+wuwDH1yB++
 +RbJrsy9At5Ta7+Vs0kD+emrk/pKM8TzdQeOQeDVVXVvjgY/+k+WHAjz4pWftwQCEPR76L7+P5X
 JUl62hWy8OJ2Bu35ORPBqfKtqzhRrRhUD8FDs3v15j0EaCSuy0yB5o9zSVvvUelgxN5bkCYoXLt
 vfn3/ewOzy0O3OYtx/9Wm2bnQYxh/D/o1m8uhvXk8TiOpRiVCSKs0fb8AXnVbEkg+LqMyT4wtt3
 lHSE4jRqaTLrtYy7fb9+deTcJvy8C5cJdrVl9IMRkhOZW91cN6iNZ8uWHyPhxiWC51Miz/Iz9Kh
 9n5iMYbJ1bd35LTh/Qw==
X-Proofpoint-ORIG-GUID: 6xEtWC3I4calBV-SNMN-wCFQyQA6YWFu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA3MyBTYWx0ZWRfX0HvAZ6248i/Z
 CPAIRCt7BlyddoeQ17q+5nmm59tatMTi9N1BKdTRkT16AvZ3NpdDlFjp1hMkG+6mIfuKaq7VT6v
 bEyl2O0llqodC+9y+gPRXvMD+XdA2uI=
X-Proofpoint-GUID: 6xEtWC3I4calBV-SNMN-wCFQyQA6YWFu
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: HZLQUDHYPLY6RZMYP6JXES3BZ2SN7UJ2
X-Message-ID-Hash: HZLQUDHYPLY6RZMYP6JXES3BZ2SN7UJ2
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HZLQUDHYPLY6RZMYP6JXES3BZ2SN7UJ2/>
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

There is a similar report on bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=221793
