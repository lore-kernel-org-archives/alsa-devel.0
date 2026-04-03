Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7B3EDB7CC
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:10:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3FCC8601EA;
	Tue,  7 Apr 2026 11:10:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3FCC8601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775553012;
	bh=xKEfj8+y1kfI0VccFFueHhdG68nWqpL4DYOeg3Imggk=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=AdgvZ4g84ZELnlAKErhwYj+liuRUCt7YOVNc0k27fqpUdrHEzSE+XtFg/cAmwcGs3
	 b4SPUszI6PXmlfw/m8nNk3O3rrfCTjwXBDwR3twFkvNgcb9MPURkDXUjESU2LgkTzc
	 5wGcj4uN5qPgdQe7xFvCpWt0CQ8hQ5GfLy5e0exA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 450D2F80606; Tue,  7 Apr 2026 11:09:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BBE6F805F1;
	Tue,  7 Apr 2026 11:09:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A044FF8055B; Fri,  3 Apr 2026 16:08:18 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29511F800FE
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 16:08:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29511F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=arrow.com header.i=@arrow.com header.a=rsa-sha256
 header.s=selector1 header.b=w6vl/OPz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcDj/Pwa08R/kpMJ0ytz+a570ccemgdLztKICj/WjqSSYd+jD2SMv8h0m8BLbg8oIIFLFeAnE/cIXNOXC0MQTju9IpVJ4863WvVJwnQbS8nsqkS73RIRXW0/g/kta3UvWRB5bPJdlZHfSI97ODo0BOrcFelLM5Z+kamw3oExFjDChjmBUFBJujw/JnYqjCdgPWCAN7HnzLyme8lbLCfdqGz5LIr+cZq+saIGEyhZ89U+2JJpyrScOLwAWFJZFIsWwzumlRRhV0n04n53Q2ppIhy4qH9VL0N3Lg4ONk69MGG+L0VqiHMs6wHiIeRp+9LjQAmY3mHP7kNEiWVXCVxZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpVUczbyb5bI/bGU8w+5bqiYjmOIkt2SNZBeP415Qv4=;
 b=AAKQgb0hc5OKVoZ+XPn9C0Dj1r9FHzDVEV8YuumuKgwe27Pv0hDKS8qnSEvmlyBEL5R5YNzp0zOv4+FbNfQvKUejwlPBXCc6xbMaP3USKvOIAAXSNV+pbJZsPJmLSvRnu9346m/ZImtOInCTYorj6WO4Q97vjR/+0JemKOqRm6TFG99FVw+LlNTJjPDhpjeBrsUlVJXwdYLav1yPdfUiGcWbwscyvNnis44QubV8txfi72fGWGBIP2AMGCo5NhczPoYkEVYn9HoPfqwhLmFWtpSMMAsTjNgAT1NWNjr0MM6SLGGSxLLPIsNznovdjo7ZexZ2aOeU/JjFV4uTr3U4ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 104.209.35.28) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=arrow.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=arrow.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arrow.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpVUczbyb5bI/bGU8w+5bqiYjmOIkt2SNZBeP415Qv4=;
 b=w6vl/OPz95HPbu2wXPlQ8QQe6/2MPKHJD1wqhpFoMQYWgf4ai+HSRQNHcUCmiDj/2/nFIQeRlP+ZfSme8YIbM0LwJNS8I1scKOHUrVDm/LxCX0RHCJvbZ2hW5ajEX2BRseeTeFysGbxsb2ftzCYUd24u8HADr3wUgB3/WCHTywk=
Received: from CH2PR14CA0046.namprd14.prod.outlook.com (2603:10b6:610:56::26)
 by MN2PR04MB6815.namprd04.prod.outlook.com (2603:10b6:208:1ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Fri, 3 Apr
 2026 14:08:08 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::36) by CH2PR14CA0046.outlook.office365.com
 (2603:10b6:610:56::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.29 via Frontend Transport; Fri,
 3 Apr 2026 14:08:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.209.35.28)
 smtp.mailfrom=arrow.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=arrow.com;
Received-SPF: Pass (protection.outlook.com: domain of arrow.com designates
 104.209.35.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.209.35.28; helo=us2.smtp.exclaimer.net; pr=C
Received: from us2.smtp.exclaimer.net (104.209.35.28) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 14:07:57 +0000
Received: from BN1PR07CU003.outbound.protection.outlook.com (40.93.12.6) by
	 us2.smtp.exclaimer.net (104.209.35.28) with Exclaimer Signature Manager
	 ESMTP Proxy us2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_DIFFIEHELLMAN_WITH_AES256_NONE); Fri, 3 Apr 2026 14:08:07
	 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 115454248
X-ExclaimerImprintLatency: 3552967
X-ExclaimerImprintAction: d4c1be71c7ac491ea352c4bffcbc4822
Received: from SA1PR04MB8467.namprd04.prod.outlook.com (2603:10b6:806:325::20)
 by LV3PR04MB9121.namprd04.prod.outlook.com (2603:10b6:408:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Fri, 3 Apr
 2026 14:07:53 +0000
Received: from SA1PR04MB8467.namprd04.prod.outlook.com
 ([fe80::c83d:94f6:3db4:b578]) by SA1PR04MB8467.namprd04.prod.outlook.com
 ([fe80::c83d:94f6:3db4:b578%5]) with mapi id 15.20.9769.015; Fri, 3 Apr 2026
 14:07:52 +0000
From: Tomasz Merta <Tomasz.Merta@arrow.com>
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC: "olivier.moysan@foss.st.com" <olivier.moysan@foss.st.com>,
	"arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com"
	<tiwai@suse.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] Subject: ASoC stm32_sai: fix incorrect BCLK polarity for
 DSP_A/B, LEFT_J
Thread-Topic: [PATCH] Subject: ASoC stm32_sai: fix incorrect BCLK polarity for
 DSP_A/B, LEFT_J
Thread-Index: AQHcw3Hp+y0C7ItapEush3tIy3Z9mQ==
Date: Fri, 3 Apr 2026 14:07:52 +0000
Message-ID: 
 <SA1PR04MB8467CE79DCA58DF65FD9A798935EA@SA1PR04MB8467.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Enabled=True;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SiteId=0beb0c35-9cbb-4feb-99e5-589e415c7944;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_SetDate=2026-04-03T14:07:52.473Z;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Name=Public;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_ContentBits=1;MSIP_Label_879e395e-e3b5-421f-8616-70a10f9451af_Method=Standard;
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arrow.com;
x-ms-traffictypediagnostic: 
	SA1PR04MB8467:EE_|LV3PR04MB9121:EE_|DS3PEPF000099E1:EE_|MN2PR04MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: c46dd343-4a4a-4b6a-dc6a-08de918a6e31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: 
 BCL:0;ARA:13230040|7416014|376014|39142699007|1800799024|366016|31052699007|38070700021|55112099003|8096899003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: 
 432v4yrnWeu2PbLPUrSmg3JosbH3PoTzTR/T4k2/qvl4VfQykM/FSQTSrIbzyk+DIEmFnOPDoCJxranYcFYlKoyuMVc9bkHbv3BBolp31APGbpAnUm3HhlQ6DRWx7Zs1Yd2650uG4PiMtlFAk3c4Vregbq8RHG8hljuavEu4Ba+XCvxWY5MbDbQ21uK7CjFlI7wEi8igllSp65LVKfTxeCA4GRoUlI4BEKtxkL8DHmO6nc8TlxS/asV/+3xfgY8GcBhR9IIa7RQnh5Jx5JEItsqiktVPS1HFkRSPpNcE0sv+LHxAdqIzEJ6N134WMdqUcxbdTqUmZmpJ/yPau8PxXrHLs7mMvgBB8JDsDz1aYOnlsIFxduEVmx5hmB5AVkWkvdgoVyNLwffFWKH9eMb9+2ZOLr03PVH7xb54LVoDn51SRuiSQRQRQwyjyqU4LDnd3iAREZoddJXR0VrrJrTpaUg9dzGg7x1OuA+zkSlQlybtgaEk0gw3b6DZrpQQGQn0c91J277YtDSobisarJxI3prYa9FVjHXa/ItQBbFjvKXZoXfMAS0pf1dcRPoVa7YjDWmnZzuE3dtkgwFRNN0CeyfWRsb9gyiXGxbZhhCep5/UR1Zf+YoXaNzeV5s3qgJjdHczWLcOmfCz2YZkncU2cX2nMTzg6dmv5iGifeS01g5K5O5gJSP+KXkQYNr4lr3JqAxGixgPAoilM79iAMCBXPsXfbcpDIrLKktLt6kgySRPjNSiblPzyMQ1WTV6GB8v4SS56/Wl+qJj3O9RWxhYdpQHGpEeB0W86hAZ91TQEFI=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB8467.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(39142699007)(1800799024)(366016)(31052699007)(38070700021)(55112099003)(8096899003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
 jM0Zjvha2QstPO6XghzAtqz7Wg25wKaSxFwKPw4m3/vB0TL1XgafB6SjKvmqKp0lPzKIUMcvwu2vZmC6W7OcUwhaMA7lpiKoN1N/kJNRfETCFxz2GSwGwBVsH+xi06skqWDS2bnt8Aj31LsOszKNJiqG7JQ0yAdjmJyZy8RzJGJGMwknwHt/baiPXPqxpdcBCQFOJ2ShYqJBA2CujS+xWBo3ppUGNfWFYiMf2Dgo6f2D+awDfrfESQSba9y9Nr32dlPa3uUkdgDg9QialaH7vxBAGdJuowLgUWtXefTgT3ta8bmk38bfzBJvF2bVYiwjhwNY0Fr1DiOjQski4IO5iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9121
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	1f008a77-0a1e-4f9a-8d65-08de918a659e
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|7416014|6049299003|36860700016|14060799003|7149299003|376014|31052699007|39142699007|82310400026|35042699022|4076899003|8096899003|55112099003|4053099003|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	/5mQEbHysJJw7VG2dShTQVcaHnSJ3nXZYEwh9FHoCDO8xttzMRAeSdDpIAKhFxV+MSX+sLM9hTDoe21hvqNbMbmzz3uO8uzbkncYQ4+n3tz1Ezgk2/TVJ9yEv82fjdm8oRL2iLcvnwt3tI1OoJ6TH78ul4ruAqSsTPGhuWZD7eC9Pa05R8BNntXnNh1k8F8UtTJXdNedgH9SlDSW8uTPtdz3vyuYs5lNUz1GITckIsCQ97HASx5+j/OBCGvGoSGMyWmS8v3HbJTeGtDlxyUPaOtHt9ZmaVNG4JRHyLDgQBEZCiNGq9mxCdaAa1tKWzRRa3+Dk+eZ1HDliaMKqgAA5m4UqKsD9svommM/HS+yiJiKJ57mT0XGZrL5+DaNc2LyMI2PBrbdNe2jlhfo2G8ezaTZ8kyjjHPavS+aj/SPwZeJ3nG5wyC+INUnBdQl2PNaBkyADW29Y7vGt4HrjlPjs3fGgMiZtO40kf9ZVcnfDisO2RvDc8R/NzmuTVv1KvwGTewCAiPd8rf2VPo1Bd521FfkkBNfQWuc13H9vGbB3uTY6bqf8r+GgETIuSLuazHBjoOPgLDfOGmrjjaE4TJjMBv6UbDOS8DPUbFzQ4O6pzbbvTB9L7cZ7hrQP9lWDxI7eSCP+M3O/uIjygDiB8lmHjJOQ0/eWuPTw/CTlKWOZbQOJKme0+PloGxH6F0k3QW3XfrmhAQxpFrRt+DbwdPx53DlCd/QLQxNpGZ8HYhTmJU=
X-Forefront-Antispam-Report: 
	CIP:104.209.35.28;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:us2.smtp.exclaimer.net;PTR:us2.smtp.exclaimer.net;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(6049299003)(36860700016)(14060799003)(7149299003)(376014)(31052699007)(39142699007)(82310400026)(35042699022)(4076899003)(8096899003)(55112099003)(4053099003)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	p3cm7WaAf5gK5e/e66IovWzX0IXcAMjL7eysXvThscgElj468U1sGvxxSyXij0R2HsPvLwgE3f6o7dg64gTpfEciKP54r8xEZIoGpaydctBV8ChycR1oGIxm31U87pHouCMkBR3QeiNv2Tp3fKJ2ZqJcimkv/z/NXPj22jnPFWuOk4FFsrh4b6DaagmlQ/rydefWg8IwRse7WKoeDwLRjew1QKfgUuSaNmyggMXslWvuByd1Fo7GvC9PFSS7gM3VDzY0aprresJjX2i9pRmDT8nG7BVW1XgoB/ompej1MYs93SowHibTNSzG/7ZOhm2wJUAEMHyARlJVu59tvvxUuLVNi1vcttYhzMIsuYc1i9kZ9ribRlZsWbZLIvdoCzMhjo/BQIfoOkOqZt/riCVhj6aRy3JRPPY3x7aDWCnw/0yTAkWxDY4QaQvNuIY7pptj
X-OriginatorOrg: arrow.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 14:07:57.5901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c46dd343-4a4a-4b6a-dc6a-08de918a6e31
X-MS-Exchange-CrossTenant-Id: 0beb0c35-9cbb-4feb-99e5-589e415c7944
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=0beb0c35-9cbb-4feb-99e5-589e415c7944;Ip=[104.209.35.28];Helo=[us2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6815
X-MailFrom: Tomasz.Merta@arrow.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: LWT53YSTYG3CWET7ZFLGTNUH4WIVXHCO
X-Message-ID-Hash: LWT53YSTYG3CWET7ZFLGTNUH4WIVXHCO
X-Mailman-Approved-At: Tue, 07 Apr 2026 09:09:31 +0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ST6OO3M26HIGO7MXVMBMUXKQPOPC65TD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

RnJvbSA1NTNjMDljZmE4NGZhODAxZmJkOGRjZDVjOWFlOTZlOTRhNTRlZTMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KDQpUb21hc3ogTWVydGENClNvZnR3YXJlIEVuZ2luZWVyDQpFOiBUb21h
c3ouTWVydGFAYXJyb3cuY29tDQpBcnJvdyBFbGVjdHJvbmljcyB8IGFycm93LmNvbQ0KRnJvbTog
VG9tYXN6IE1lcnRhIDx0b21hc3oubWVydGFAYXJyb3cuY29tPg0KRGF0ZTogRnJpLCAzIEFwciAy
MDI2IDEwOjMzOjExICswMjAwDQpTdWJqZWN0OiBbUEFUQ0hdIFN1YmplY3Q6IEFTb0Mgc3RtMzJf
c2FpOiBmaXggaW5jb3JyZWN0IEJDTEsgcG9sYXJpdHkgZm9yDQpEU1BfQS9CLCBMRUZUX0oNCg0K
VGhlIFNUTTMyIFNBSSBkcml2ZXIgZG8gbm90IHNldCB0aGUgY2xvY2sgc3Ryb2JpbmcgYml0IChD
S1NUUikgZm9yIERTUF9BLA0KRFNQX0IgYW5kIExFRlRfSiBmb3JtYXRzLCBjYXVzaW5nIGRhdGEg
dG8gYmUgc2FtcGxlZCBvbiB0aGUgd3JvbmcgQkNMSw0KZWRnZSB3aGVuIFNORF9TT0NfREFJRk1U
X05CX05GIGlzIHVzZWQuDQoNClBlciBBTFNBIGNvbnZlbnRpb24sIE5CX05GIHJlcXVpcmVzIHNh
bXBsaW5nIG9uIHRoZSByaXNpbmcgQkNMSyBlZGdlLg0KVGhlIFNUTTMyTVAyNSBTQUkgcmVmZXJl
bmNlIG1hbnVhbCBzdGF0ZXMgdGhhdCBDS1NUUj0xIGlzIHJlcXVpcmVkIGZvcg0Kc2lnbmFscyBy
ZWNlaXZlZCBieSB0aGUgU0FJIHRvIGJlIHNhbXBsZWQgb24gdGhlIFNDSyByaXNpbmcgZWRnZS4N
CldpdGhvdXQgc2V0dGluZyBDS1NUUj0xLCB0aGUgU0FJIHNhbXBsZXMgb24gdGhlIGZhbGxpbmcg
ZWRnZSwgdmlvbGF0aW5nDQp0aGUgTkJfTkYgY29udmVudGlvbi4gRm9yIGNvbXBhcmlzb24sIHRo
ZSBOWFAgRlNMIFNBSSBkcml2ZXIgY29ycmVjdGx5DQpzZXRzIEZTTF9TQUlfQ1IyX0JDUCBmb3Ig
RFNQX0EsIERTUF9CIGFuZCBMRUZUX0osIGNvbnNpc3RlbnQgd2l0aCBpdHMNCkkyUyBoYW5kbGlu
Zy4NCg0KVGhpcyBwYXRjaCBhZGRzIFNBSV9YQ1IxX0NLU1RSIGZvciBEU1BfQSwgRFNQX0IgYW5k
IExFRlRfSiBpbg0Kc3RtMzJfc2FpX3NldF9kYWlfZm10IHdoaWNoIHdhcyB2ZXJpZmllZCBlbXBp
cmljYWxseSB3aXRoIGEgY3M0N2wzNSBjb2RlYy4NClJJR0hUX0ogKExTQikgaXMgbm90IGludmVz
dGlnYXRlZCBhbmQgYWRkcmVzc2VkIGJ5IHRoaXMgcGF0Y2guDQoNCk5vdGU6IHRoZSBTVE0zMiBJ
MlMgZHJpdmVyIChzdG0zMl9pMnNfc2V0X2RhaV9mbXQpIG1heSBoYXZlIHRoZSBzYW1lIGlzc3Vl
DQpmb3IgRFNQX0EgbW9kZSwgYXMgSTJTX0NHRlJfQ0tQT0wgaXMgbm90IHNldC4gVGhpcyBoYXMg
bm90IGJlZW4gdmVyaWZpZWQNCmFuZCBpcyBsZWZ0IGZvciBhIHNlcGFyYXRlIGludmVzdGlnYXRp
b24uDQoNClNpZ25lZC1vZmYtYnk6IFRvbWFzeiBNZXJ0YSA8dG9tYXN6Lm1lcnRhQGFycm93LmNv
bT4NCi0tLQ0KIHNvdW5kL3NvYy9zdG0vc3RtMzJfc2FpX3N1Yi5jIHwgMyArKysNCiAxIGZpbGUg
Y2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9zb3VuZC9zb2Mvc3RtL3N0
bTMyX3NhaV9zdWIuYyBiL3NvdW5kL3NvYy9zdG0vc3RtMzJfc2FpX3N1Yi5jDQppbmRleCA0NTBl
MTU4NWVkZWUuLjNlODJmYTkwZTcxOSAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9zdG0vc3RtMzJf
c2FpX3N1Yi5jDQorKysgYi9zb3VuZC9zb2Mvc3RtL3N0bTMyX3NhaV9zdWIuYw0KQEAgLTgwMiw2
ICs4MDIsNyBAQCBzdGF0aWMgaW50IHN0bTMyX3NhaV9zZXRfZGFpX2ZtdChzdHJ1Y3Qgc25kX3Nv
Y19kYWkgKmNwdV9kYWksIHVuc2lnbmVkIGludCBmbXQpDQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCCYnJlYWs7DQog4oCC4oCC4oCC4oCC4oCCLyogTGVmdCBqdXN0aWZpZWQgKi8N
CiDigILigILigILigILigIJjYXNlIFNORF9TT0NfREFJRk1UX01TQjoNCivigILigILigILigILi
gILigILigILigILigILigILigIJjcjEgfD0gU0FJX1hDUjFfQ0tTVFI7DQog4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCCZnJjciB8PSBTQUlfWEZSQ1JfRlNQT0wgfCBTQUlfWEZSQ1Jf
RlNERUY7DQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCYnJlYWs7DQog4oCC4oCC
4oCC4oCC4oCCLyogUmlnaHQganVzdGlmaWVkICovDQpAQCAtODA5LDkgKzgxMCwxMSBAQCBzdGF0
aWMgaW50IHN0bTMyX3NhaV9zZXRfZGFpX2ZtdChzdHJ1Y3Qgc25kX3NvY19kYWkgKmNwdV9kYWks
IHVuc2lnbmVkIGludCBmbXQpDQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCZnJj
ciB8PSBTQUlfWEZSQ1JfRlNQT0wgfCBTQUlfWEZSQ1JfRlNERUY7DQog4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCCYnJlYWs7DQog4oCC4oCC4oCC4oCC4oCCY2FzZSBTTkRfU09DX0RB
SUZNVF9EU1BfQToNCivigILigILigILigILigILigILigILigILigILigILigIJjcjEgfD0gU0FJ
X1hDUjFfQ0tTVFI7DQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCZnJjciB8PSBT
QUlfWEZSQ1JfRlNQT0wgfCBTQUlfWEZSQ1JfRlNPRkY7DQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCCYnJlYWs7DQog4oCC4oCC4oCC4oCC4oCCY2FzZSBTTkRfU09DX0RBSUZNVF9E
U1BfQjoNCivigILigILigILigILigILigILigILigILigILigILigIJjcjEgfD0gU0FJX1hDUjFf
Q0tTVFI7DQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCZnJjciB8PSBTQUlfWEZS
Q1JfRlNQT0w7DQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCYnJlYWs7DQog4oCC
4oCC4oCC4oCC4oCCZGVmYXVsdDoNCi0tDQoyLjM0LjENCg==
