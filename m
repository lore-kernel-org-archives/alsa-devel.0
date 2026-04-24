Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D5FFAD3F0
	for <alsa-devel@archiver.kernel.org>; Fri, 24 Apr 2026 03:41:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0AA2B60205;
	Fri, 24 Apr 2026 05:41:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0AA2B60205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777002074;
	bh=ZDu+fCJh6Gl95sJRDRofeoO2o70PqHlFYg039NTmqUU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=SCHxEUz+SQkzMZmeK3N06pDC5v9z50tHFAIBxSLWKLU7CPazwX0RM5o1lD3Jiwmgu
	 fYkbl2jZvQtnKtXIBELNhrSenf7JfYhYEsBt+Fa7SGbv192FfzFaeCI75UAOPI63HT
	 wUDE+wChYtQNoHJMGqdLjkmI+3wu39rhfr3FoIW8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5DD6DF805EF; Fri, 24 Apr 2026 05:40:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F1F2F805ED;
	Fri, 24 Apr 2026 05:40:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF834F80510; Fri, 24 Apr 2026 05:40:26 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012036.outbound.protection.outlook.com [40.107.75.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC394F8011B
	for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2026 05:40:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC394F8011B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=S0ow7i+V
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBMbxuPmEvftvvQcmNsannKPc4K3s+ZOTOsGLkC8HeNLkVuEF/ZuJsdONX49tAK+QhQPLl2vEfH6E2dVNjZ4mjOBOkDbAEmWAZ25a6ITSQ00s+ThGDHjvao81nC/M25KFLd6CWkWXTNHbACm2FaMms2Lp9U51z71AMA4VHWVDjjb8/n/x2yLANtLopSXGdKyGEyfkHj0oc3nJCtVVcoJ7rwlVDSYGas29x2IyyX6gBYNTC+9SAYiFR7YL18Yq4+KxXp4WcIfNFxMMWhtIx+kyVlBD9h+i7N0PkFrZJIF38SNDMYgEeJbnqAspyK5W4Kn5+H+bkn+Q7TzYVTuHG77xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qj0+HQi2tbdpPVhvpTmAsj3ZtLxf6OyN/SSB21VPzIc=;
 b=w/sA0kIwrxl7hkrx9zfsAW4DsX8tCDxtGuzvTsrXDsSsbQpZu1qkFQ3RyBMKmae1EohpI5GMUZOx1///p4E1rWyQvT6KvzAcgu7b/4QoSHs6aU5MdfCDybjck9a3yYPi91/zHiGoguhC0+8K/Iz8ZOO1jpyCFGm5XDjabOBk131D0X5LG2XHNnfA1bWLy13HVGrDkASQRZU9R4GU5jZVtWbZPoKYCdJh64rOYMOww2KOgqp8CzhsBLAleMCJ2SRgnlNaS1F2prZlOfRKlgCnwIU2w/oFdlzEKmou/bNQBPwpQr/xQ++3368nqrAg7zdjEwhVQ1HMeD2irqe9xp3OOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qj0+HQi2tbdpPVhvpTmAsj3ZtLxf6OyN/SSB21VPzIc=;
 b=S0ow7i+VylsO/cx+PdCZlJR7LfQyMyI8w2M1g2/4Y1iSo5ZczfS7u3KWJ+S6/QXCOhxb4mUCu6Im8hxl8K2tFT+K6x4v9AuL+9n59XHHq2R+uKTndFdCvbg27L/Lx493E4SkDfMPp1CfYZ9oMFeWm5wiB5MF29o+b1dCDGF3OyvuPSiQjTANHVfQ/8Np9pMGkhqYTW6TwBYnnPNH6jN/ndMork6aFTAIonMCiuMqXxsE0ErHPM8etMMjuJ/eMZE5fBXYkf7IhZcTpGn91CGc9q1HSCpSnvF0K0DPZ63zeZbJitGV+rsUYqSIvs49/eH5msNXRx6Fi54ofRNSsxI6uA==
Received: from PS2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::15) by TYSPR03MB8365.apcprd03.prod.outlook.com
 (2603:1096:405:5f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 03:40:12 +0000
Received: from OSA0EPF000000C7.apcprd02.prod.outlook.com
 (2603:1096:300:58:cafe::4d) by PS2PR01CA0027.outlook.office365.com
 (2603:1096:300:58::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 03:40:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 OSA0EPF000000C7.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 03:40:11 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 24 Apr
 2026 11:40:09 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 24 Apr
 2026 11:40:09 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 24 Apr 2026 11:40:09 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH 0/2] ASoC: codecs: Add Nuvoton NAU83G60 audio codec driver
Date: Fri, 24 Apr 2026 11:39:51 +0800
Message-ID: <20260424033953.280520-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C7:EE_|TYSPR03MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: 432b6e1f-f34b-45e9-0b9d-08dea1b330ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	bc2pjKP/hgSD6Ecjc1XJnU6UoBtNRPQiDcU+DCDofh9vI6+BVcnvKffzFHnqSYrQg4XNZGM6rNj+Zzcmj8rh2GoHjCKJhFEV+irkC3SJVKj/lvtuiSAUuuA8E1+xlx9ZX1qQUIZm4cXueV+ggmycET/3dPFHfY/Bn3jFLHqBEuA/PTO02f58unNJUeEy7GZ5UHD/tnb5EKuUTpZ+dmvlLHagcgOGiOGgK9fSL+e4Z9GcAWcksCsywST41u8/2N5MbmEwtxWftRCYtli2U8rl8GTcGCHCNGAJV0+QH+HmsVXeHF3pNRtder1Ph0Sq2iD+XsDFLyvW0IDHJDp70V4QFIWKZjurBmDLUwwajGvh/BU8DEnNSH3OEQHHp57XHWJLmDt7vHmXhuYkvYLhfhFs95It+LI2OMI0igFYuMr+iTmMiaclxkzxFVrsBry5gY4YKcnwABTR9o9IhJtnBGjn5jEMPnLHWKhwBkjc200OR9tmesxgBtY5Zw5vkLbI2OrTnkxuBC8e601C4/Lm7LqPzaSlVUbv0xNXsTEt26Hb91gO9brGdQtdC6+oYnBpEDnKILqrbTzxGaA3Jrpzc/3RRCadTG+KUnAhj7PUoudactmR3pJvH+4IVNEkl8t6NG0pNCfRNXOp5rjQqD2u9H3cqPy4gB2MjHe51olhGcDE52RdYfnKskVOFeLiGMpG6S4z3Ogna4LcneBZwW46REjDwhPGVbkLxZiIVaW+FcXj9scjFnhe/RMjbfk5ALPBgpi4i6wXFhtfaeFhkP0/G0h2/Q==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	EzBEpnJtDme+FSnY6oHhEuU70nHFSD+AjPk2P8Ctm3v6QIewUfvxe5bLnXMh153sYPX4QOH3G5tnIiYjp2uGvfS9iZtdDZ6tW8XcQQTioCs/5fJXxQsCdC7IA4TkoQcEtwXChSbaqzGfZB/c/wFQIeuAcIWiDPxZ0lu/llUBIoKZF69FRvi/kPjtEKOR+fz5cSUGoksT0RYVYAetJLfUqc7JhQU8/rTomYlkqU1qYm424V+rDuMpLhNomYSDZZcZN2fYUPrvO6DJoqeI2wFzcKOTID6OPQ98PfYAMqEbvDXb0JM9ZiFfVoHGyViAjJMjclUHx2wjWv772XeGdvvK+dh9Y26pCSNNb+RevK+MwcEaM9cbCRM47sLaMHDvgUWnkxpZH2LW1bl81iiVhQLbej15HWKDMWgmBrFFU9RrD8gkypCopuzDE2QZvOkDrGN8
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 03:40:11.9821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 432b6e1f-f34b-45e9-0b9d-08dea1b330ab
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C7.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8365
Message-ID-Hash: FGQMBO7MB3CQMTS2PA4NUUCO4HMNK4SF
X-Message-ID-Hash: FGQMBO7MB3CQMTS2PA4NUUCO4HMNK4SF
X-MailFrom: YLCHANG2@nuvoton.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FGQMBO7MB3CQMTS2PA4NUUCO4HMNK4SF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series adds support for the Nuvoton NAU83G60 audio codec.

The NAU83G60 is a stereo Class-D amplifier with an integrated DSP and
I/V-sense capabilities. The driver supports I2C register access through
regmap, DAPM widgets and routes, TDM interface configuration, and DSP
firmware loading.

The series is structured as follows:
- Patch 1: Adds the YAML device tree bindings documentation.
- Patch 2: Adds the ASoC codec driver implementationy.

Neo Chang (2):
  ASoC: dt-bindings: nuvoton,nau8360: Add bindings for NAU83G60
  ASoC: codecs: nau8360: Add support for NAU83G60 amplifier

 .../bindings/sound/nuvoton,nau8360.yaml       |  115 +
 sound/soc/codecs/nau8360-dsp.c                |  704 +++++
 sound/soc/codecs/nau8360-dsp.h                |  117 +
 sound/soc/codecs/nau8360.c                    | 2334 +++++++++++++++++
 sound/soc/codecs/nau8360.h                    |  900 +++++++
 5 files changed, 4170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/nuvoton,nau8360.yaml
 create mode 100644 sound/soc/codecs/nau8360-dsp.c
 create mode 100644 sound/soc/codecs/nau8360-dsp.h
 create mode 100644 sound/soc/codecs/nau8360.c
 create mode 100644 sound/soc/codecs/nau8360.h

-- 
2.25.1

