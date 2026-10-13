Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E98ECC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:31:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A1AE60237;
	Tue, 13 Oct 2026 12:31:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A1AE60237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791887496;
	bh=yAgdKeJxF0PQfNfbY/nhPpp8VFB6d3PpTyQxpH6deP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Jr0Ppx4LPp49Bgu8MS0skN+gmXiEzWeFVePhOS4IIMtknygKPDh1CFmWSAbkq0nBj
	 y2XSgh2R7zq8/me9sTItvdJnuVYrVJwTZIR+NDtHRHfM73JIxj/QEmUwTnIHwzj69D
	 UzvzPX/DFahjJcMjU1W/rFTiMuBbV2MIgnbp1IV4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 14758F800B0; Tue, 13 Oct 2026 12:31:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5BA5AF805F3;
	Tue, 13 Oct 2026 12:31:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 08265F8045D; Tue, 13 Oct 2026 12:30:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791887450;
	b=bN7F36jFy8NWZgeN0lVQBwTF73Lna1XgMs/ylCX99m4tekLvW8zsq7x9+46mTlpbunCO
	 W/1UiBH0BUqONCK1x2EebULjniRoDKahVnAIe/Mx80qrdX4DpO4MKxft8j/t0f4s/opJk
	 JskPfPHKiuxoKMZSYMitYfPC5gnzCqUQWlePoAgCB4Z1jynfh5buUicvA7gE8xW60Rz1S
	 cc/nYRtnm5HjjXBX1/acpnCiV51BbN4bETy46DKdKqbgvGgGKGA675vJ6T6wQKqEdp2U7
	 t6dBdM++gTnejz2Db6bFuXSF5xQWPj+nzDsFx6ZKW86Q3fJqxgW3zoHnH8MQDAdFwVg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791887450;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:
	 To:From;
	bh=yAgdKeJxF0PQfNfbY/nhPpp8VFB6d3PpTyQxpH6deP4=;
	b=ZecBqQT02vbTcriPEDImURBgiFUSf+ska+eVho6dLCgsixPivnFS7qkrIW0RAsG06poz
	 1a9ARA+JRDeS7/WeB6rTPUQTvxuBd3JyyKfQXfDmyY4IefRRK6bCCMjlvdNaOZVwS6W5w
	 xFWEmeW6a1QwF7J/R5gYYrNfvexqU8b5VnSkzhbO9QrpX/dFtufraxwsdP+w+EyBFZ2vV
	 q59ExCRjtVw4lP8plqOiEdrpvIC4eTExsnt2wy6lbWAnJAKf9AMbgz7sU2/P7L7AuYTbt
	 NobfoYVoH7pFmOR/YDsMCezE5YKbYMloY2lkniWtoWkiSV8eFkNNaZ5X1NeDX0q/AOA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=MQ35ORev;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=QgVvkZxh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 743B0F800B0
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:30:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 743B0F800B0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=MQ35ORev;
	dkim=pass (1024-bit key,
 unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com
 header.b=QgVvkZxh
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D4xRuh3610135;
	Tue, 13 Oct 2026 05:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=yAgdKeJxF0PQfNfbY/nhPpp8VFB6d3PpTyQxpH6deP4=; b=
	MQ35ORevZ+towTmKE5gGDVpA4PIZRBOF+aqc8efaC3K7ymzj6jyklgVIgrgGWPm+
	STITKIZMMU2YHxJfefQsrrTPIsU4BFgXQbKIHyS3vnauaS0dmHoa8Wyy8lyOImd0
	DkzPIzxnepmKvycrF8I8lIn7ACdG428ePBVYsUIIjRtvJOjwzsySAWytJzd/bB3p
	nzz3YDOFD5IVkHay9cc0qXes+rXqQLQP650zf4eE/TxsHK7yaB1Au5ZILvDQh5DA
	sJGdvD1W5N2IivcwDqs0rtcKv5f+Ucz8D6HMLc+V69IqaBWKrt24wuFkj4IQYyzU
	lDtKtSN0SxBMTkk/Kvu1dg==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11021102.outbound.protection.outlook.com [52.101.57.102])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4h7hsg3khq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 05:30:47 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmaarzaAfOyVMqQ8dlkTJkICqGY5IHctnqve23tdPlWtrpX+w17Eb5ejbSFMaMQNczaZrStWG9jfpG41EMcDa/nOnNUwwelqsWeWTWOhUwyVNLYsknnn0yflr4eRrCPr+n8RfsIbMT/ASGDTawM7QsbIpX+eFqQRPJeXVgLpXKJgZaV0BdTnwqVS+zDjPWixCiI7oc3irUgpl5/JMPvviPJ2FB8Qjq7VYpr+0I8bFE0rUOJPfGNQiBUrwrx76ZqCms+qfGPlY+22Qnle25QJNuIgTJomWwGOVEMifKKtuMzdsTqdZ9Q/KGSfkFntqVIa1WZJJRj8waCGxLcCzTQfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAgdKeJxF0PQfNfbY/nhPpp8VFB6d3PpTyQxpH6deP4=;
 b=NBzyChc017wDudG6chtuLPB3xo8TSKj5HnK2P65Pd3k8CTeQCamXfs5V+7xwOCH/NWJece0ysKZpEHvWjwIo5hYLa7enu67j0rOivfY+OZKYJgb1BOx+DogzPAijSQOqxm4/TqdDaJ2AWaWonXUJ6CSV8j4aSf3o+gh5B+16YIU9CxvDanFALsoAyIkRU7zmWZ7oWziZOf9/dHHO84KPQELLNHHaksr2CVoMKSAp7tR1j4viB0ffzFoXCM2F1LwWy4Mpchcn5I7Ti36Wu+rtUp9kr5SESFHMcEuc0Yib9uND+yAVh1rtvX4bB1qG56sMY0c4tHYpCG+ezvHh1jK8qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=alsa-project.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAgdKeJxF0PQfNfbY/nhPpp8VFB6d3PpTyQxpH6deP4=;
 b=QgVvkZxhiVU72TGl/dDyZhrMdDltMXPVFrTK7BWZDcrlnhpWpeQMagWpmCWJfDM1jiFX1Zk2o2BRh0mqtR4EvOfJqbZ/ajESPemohLIBCo5c6Fq7l6yOfXX+K4KuNksX1xN00etSyl4qwIZC3DNR8pMNxJ96yz5zv26YTN+6/dc=
Received: from BN9PR03CA0577.namprd03.prod.outlook.com (2603:10b6:408:10d::12)
 by PH0PR19MB7317.namprd19.prod.outlook.com (2603:10b6:510:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 10:30:42 +0000
Received: from BN6PEPF00000073.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::81) by BN9PR03CA0577.outlook.office365.com
 (2603:10b6:408:10d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 10:30:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN6PEPF00000073.mail.protection.outlook.com (10.167.248.200) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 10:30:40 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com
 [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id DB7A0406544;
	Tue, 13 Oct 2026 10:30:39 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id D4ED582024B;
	Tue, 13 Oct 2026 10:30:39 +0000 (UTC)
Message-ID: <61099011-43c1-4316-9931-9ab4e891b3c5@opensource.cirrus.com>
Date: Tue, 13 Oct 2026 11:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] firmware: cs_dsp: add a KUnit test for the
 cs_dsp_run() error path
To: Mingxuan Guo <gmx472@qq.com>,
        Simon Trimmer
 <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20261013102359.1711142-1-gmx472@qq.com>
 <tencent_113ABD187DD2A0C99CB7D4003B81AB94DC07@qq.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <tencent_113ABD187DD2A0C99CB7D4003B81AB94DC07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000073:EE_|PH0PR19MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1d142b-a95b-42e6-41ac-08df291507a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|61400799027|376014|22082099003|10067099003|18002099003|16102099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	SZMQaEQLZwdhqZs128pN/HL12sqSmKQv9smWmC/j+SsQROd7LORZSnTqBixdEfQxnemyoxRynUN/2/mmG1AAK+hnQ2JxUjiGD2QEJMUfYNoOsbWOaBN70HvJRuguqDn/Qdm6d4GMptWcpjWfQvmPJt/a2Nn8AM7Vjdg39/3c3Sg6UeVp/9SdbNKfdYVvXsP1rkXzMwUKxA0Rg/xFi0WrvH2p9fo8DEzT2K+C/rnODRyJGBBh3g7f+55IswvGs/sH0UHLTaBl6QX1FG0Op0FKm6Ce1tgcN56iu4JpWqMGxZWqbN/2zvHtkPWFgARWkMtLc8TRexuXDEtrPgADC89oO4/F70GXrfhsoLB/fILK7VHfLpSYf6NdxMflqlYUq7Nii4P6zgUkVybNrt5Hi7OaOuWFCYgtveT4pI2Df/Lo5NtzHZAlGraXnXL8dD3rXfzn1NcECX/GP0EzmbsJ16bmZfg5PRyWoqWa/jLRQ01o3V45JTbieo4EJRFblb6XVWd1R1T4UK5XU0CHfNTMJCrUIBpmZ4+ij/Js0eo5K5uQ3gQ4yjiCCC7RwuNCaRNjyY9zyc34fzlYztegz2Hqawq/a9WjMnokPNyKBwY1ZTokUNUC/RsJLvdv8RRCOkYTmpy73MUxqVooo9PL3QEerzNWU1Som/LFNYC4p5pJeNYtCvgLx+ktVNDJocYQwKkMjtQTXMjPDjZKcDCMhbZ9LNAHRQ==
X-Forefront-Antispam-Report: 
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(61400799027)(376014)(22082099003)(10067099003)(18002099003)(16102099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	FR9wamuSHv+xqUiyjvXJSLOWDSHfsL/Od4m5M0swRkHXM1idhyofrve797ogoCgi893MY/WJ+w3uZPrn7uGdM2F3Ewnv81K98HvuTVSVo87VwGqqia8Bspn6dKcmrqP4QW6SrNOa1BzM+MS8U6wkdVSBYY/qprRffWtLuyl1ELpb6qeZ97S37YkKzZKl+e4Y+y6e5YRxTNkKWhi+fs+uEtap7Otr8HzPO53f1lHwf2HlgJualRtLZDuBGOtu8KEoiW31JLZJmwPDo1DfDwD2KZLCbQBlSvStmkClplkW5VNMFMB2GfHeJZaMnT6l9Bo0cCCo9V8rBJke4rU8q/hEUA1loXHMs66GQB8me/noJp6vGLVl+vOeXTx30ZYJhjVkhMa6uEMOSdd9+Hx2qGnskzzfiPTVXUEXRH1VftA02e5VzgrInMpJjNJjjY+eGDn9
X-Exchange-RoutingPolicyChecked: 
	X9/2iS8YHEHCdJLfN8kGQdAJT7kCj85w7hO2Iyl3an+ZooZEf+5g7oi0z+WSy+OXSSlK6LtxGBL7qKqA5wVF1qkQwv74RDu9/hNQI56EXvguS2e5odt1NSwgXIVpw5yBEKsMZDcjnuu37Sm067Hona3jg75/mW6X24d+fEOdhWhINHy9220S+/IdrtkLJxkgkylVoaCA2ec15XJMMzQN4hNtktYU8LxvHDViiHoV/yGzKaZic8iYNI0fIF/fWqgqD+u9y+6D8w3fpzU12UicNfj6271Nlptd7AfkPf+XfRq6ETpLsb4bSswi7B7Vu6m8PRveYc2/TXlP3DhjwG80tw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:30:40.7287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ec1d142b-a95b-42e6-41ac-08df291507a8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: 
 TreatMessagesAsInternal-BN6PEPF00000073.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB7317
X-Proofpoint-ORIG-GUID: g7AALEV6kKPmVKZiqkGf9bNHZIE38jw1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX3HdyuhuC87D3
 t2yajVbJ9d5RCaqULwZ2vAilneaB0KXT9JKtf5V4aul/tExonHtxbauf2sWz06YGSoMlkXDSud3
 9zUAzZ48s7nRtshXT5DPiOIm3tpE0vM=
X-Proofpoint-GUID: g7AALEV6kKPmVKZiqkGf9bNHZIE38jw1
X-Authority-Analysis: v=2.4 cv=QufLTlyd c=1 sm=1 tr=0 ts=6ace0857 cx=c_pps
 a=FCTj0ZxOUpDcrOysB+wcjA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=w1d2syhTAAAA:8 a=9aSPW4Fz4sPC2A3b_ggA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MSBTYWx0ZWRfX2CapKBbr9WKY
 SLY5k8GAnAVocexIvzcTxEsEXbbunenohT5nvEjkOd3P1Uibo4BGS0K6VuLSoxwopn9lVtkdYaV
 P85x+zQ0IP85jxp4pR3Ugd9H9f8HtzRd3ECQW30pHac9tAnXYqTG3IUCFutcx+hvO2vpnKEpSyv
 x9Vq4Ur25NwJABrSVsbGd7Oy0FOJGlfV1upj2fXhorWBWG+4zAKnhTWPhBreUuMfe+Obo5Qbvbx
 QtX3VLsLeC7khcaZIu6GBseU60R7pb+QRrwMX0a5OpiFdphi8q/Rvg/P1xb4qRpcesMMB1PsCo7
 EPe0iyFGahtjMzAjsCwfY2B7+5TMiB7m+j65/MxJJUxMfnwdR736M+ytY1WdCDLS9Vky3QGlNjZ
 OxYhLYIUcmNCr48uOY6mz4kYstF/z5mJvTp5M93ldUV3/eU6hAhT0iSuBtjxn3fogrz9zzwHYul
 BPVZ9NCNYy4q2od0hdw==
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: F7MFUO4DMOL23U4F6YPSE63PTOUGRXAO
X-Message-ID-Hash: F7MFUO4DMOL23U4F6YPSE63PTOUGRXAO
X-MailFrom: prvs=174672dc46=rf@opensource.cirrus.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F7MFUO4DMOL23U4F6YPSE63PTOUGRXAO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On 13/10/2026 11:23 am, Mingxuan Guo wrote:
> Cover the case where the post_run client hook fails: cs_dsp_run() must
> return the error and the DSP must not be left marked as running, and a
> subsequent run must be able to start it again.

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

