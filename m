Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B52AC79F9F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:29:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6A294602A2;
	Thu, 10 Sep 2026 15:29:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6A294602A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046952;
	bh=i717O9FirZ9RiYOxN/qfxWBuw8UUpD2VCS6br3gOT/E=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=fe/64Gga7BUYQ36aQE3IIRGz7X3xL3BWvyPHYqty4+fmkp97+DeOkBUgRBUpc/OWn
	 sDzoEVw2WnYjBvF1lv3v5MY3Y1AmOnVqqenL797HTqVv/rjTVvfYd3WDkwXwmo4lKA
	 HY5gH8Xanbjz0iclzk520oBbCkU0IaIhMbrhJWjA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D232F80C96; Thu, 10 Sep 2026 15:25:09 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E4702F80CBA;
	Thu, 10 Sep 2026 15:25:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5BA91F805F1; Thu, 10 Sep 2026 15:25:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.13
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046703;
	b=LGyykqxOVBVuBkuaoIHjBNv+E+Vo5k7orvEYqTUKoy3bHDC8Wkqpv1AKh4AkHZW3DlQX
	 lNY1UYeJXlpmsjpVMNPc/5MGVgqgoq0UrpkmbkWW6XtYaIsX5qtBERQxMpEKEkxtrMLAw
	 2TS1O7LzG7nyZmftGTDJwy/1rzXV91KuXEMYj1f2S9VZBWiU5RE+j0x4Y82H3llrPUjgo
	 YcdqdD1XNTpKaiu6Z+pU03y8P1qWkWWtG+k9f1Jx3ZWFy3OprNU21OGiA8nDgcM2g5vUt
	 kjSZ4IzC0tYiEZ/N8apO9pdSnF6U+qL0lNUq3BfYEHr6PALzarkekSZCqOhD36+Z5EA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046703;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=i717O9FirZ9RiYOxN/qfxWBuw8UUpD2VCS6br3gOT/E=;
	b=LCVeuBqC89G5fWRnhOTY76ia9Ze7jyP9+edKhE2MwyKOWhVgdC4TeUvIBv02NIvJFcKL
	 GsWlTw+72oWMeMF36ZTPiDCOnXKRjekwZXCrqSuTXFNCP2+dVtf2bbQJp4y5z6cEwZZkw
	 QGB+ufF5y+Jzq5FgN2s9KimgBqZmmAURDVLk99kdbAb5KiE3kqNR+KCvNKYU62LBIGAzh
	 c/qAB8xaBsvbV5gvrtIkuGR4Macq9c8GTLhWEu3LOlIqU6kBxSDXQn5VuwwYcKeC8F9U+
	 F8Rou1F8ypefDP8l2tSnfSnSNnnlyolRyymeikqvHU/SKiGdrobYGDGtcPtQCznvIhA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qSImAMjE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.13
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012013.outbound.protection.outlook.com [52.101.43.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F101EF80C5A;
	Thu, 10 Sep 2026 15:25:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F101EF80C5A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qSImAMjE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcNDnusWefD+VRjNZGFC6KoH1uJ8bK5EWmIuAlifFUZMO6zp4iJ0ncv11ptDQXmQN0xtI56jMxNIkP+Ugnt8nDwj87AhwarwYdUjrcCvTFV2/4C9LYZ5+0WILkinRLK7cZ4Blk7QI2skO/p2cGQuW9WUHew4gY3hXAleS/hsm00FlzghXoZ/7hvQ1UkxWY00vthFcOhC5CVN9fG8cTGv6V0qyV5B5HJe4IsqVcXuiV8K+onPgnofTPurSx66+x9Uu4srpofIjHwxIpy9X77cjtSBR5glV1EwnEcKegJMs6ZRi0AISRvZiT7Stw4za608LXn3aS0Z/lxFg5yfdOlO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak/Ng+vhHBtCUreB6yM98H1PFL332b+ELD3jDlBXmTw=;
 b=jxenk6/Fh1HF+II4IZlAua6OxunL+OuEfqd/Mw3+a8ebYoKC1dHK06yybX5cgQajQCJPaeutd5Z+NjBQmUI+hF8y+7ao63WpUYvqa5BAdedh7Ys6nPx86Mva61e0qCGN4KUgmfuhqPKtv3vbOdXngKTQNlME6wu2ImnC5TC6NgpZJvKW58pYnThYbXzGZvGfIrBumg2gmVSQ1jIYtty7rBZl1EFNrlzdtWnPAvO7GYwDkwmcOqJkJcJEwUIL1ApL5VHawlWo2mtg6ijkMF9JMcG2usfGPxcFWIDbAV+uMfe8j44jdEl/b0+TTlHOh7Qk2IF4PHkN6sVeBQ38ruwD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ak/Ng+vhHBtCUreB6yM98H1PFL332b+ELD3jDlBXmTw=;
 b=qSImAMjEp7o4R+1t0NkPe1DrwUf9FD7Lpy/TVNeMi45WjZIzQXQl9Zd2O0oMW4IWdjnzsjocbygoAa7hx/TPSAm2yCDf3X0tbT1KfNX0kreYEOC/AtX4e7IE6sliX0Ns/egjP/VjK2MTyu8rSDCOaUD2wnIo8dmQR6Hwjef28SE=
Received: from PH8P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::17)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Thu, 10 Sep
 2026 13:24:51 +0000
Received: from BY1PEPF000264B2.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::5c) by PH8P220CA0011.outlook.office365.com
 (2603:10b6:510:345::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 13:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF000264B2.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:47 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:24:43 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 10/11] ASoC: SOF: amd: enable SoundWire host wake interrupt in
 acp_init
Date: Thu, 10 Sep 2026 18:50:10 +0530
Message-ID: <20260910132251.1171943-11-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B2:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 87f3b3b1-eabf-4767-07b5-08df0f3ee4f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|7416014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ogvkemy+htxieMvrTentS2aNlMy5raakEnrTM/JUKWEl2RiGVmyhYTXypZpLU9X5+O/msZS3wFPFw14VIBtvhXBjlguw/ldmburVW+TfEbYxWmz4ze0DH82lVXbTvkFNQFezE4S/MM4MAt7GrrkynpWI4zmxZ3adWSac/bwjSungbdYlu1HUXPrEf2voyuacUfhcb3/R1j5Aene8PJsGVOLSvkhLfmjByhFZv/AdLuOjjisz8qidgUHq8P1qNfln4KKYnwcQ7EQl/tTKzuAsUew0ikMaVuPqJGM4kDDpFTAw5dOLPCZn999QNr+TxOko0ld8KQV27pr1kA1LiktE2ihFOdNPaT5LbsDE47K1ypAwMMkcp6G+B+OTEE9xfXxvv8h3J3Td0KQOGFuyq6w20LJdLhQnQzkF+e1mZMHd90lQsRyuWrO8IHVw99UyZ1c4ofS9ER8cOufyh8QU17Qxg5+LplOVgyPsUGTMWSsy/QQ4cCCJxg1A6MJ5RjH9psA+IOGx2PR78oZ5FJxdIv/NtZHGNu/wABQe+cOWanLEv5fiR3qXHOJO6eFnRXpELCsQgtzQYfi+X1MwoJuWwMjWB/2rgqljX558qWMfmKOVr4mo12LkOrAYNjO7KGJ7SQMVGJIW8rsXE8Fg5MpZ3UUqC7LOHjOkn2qovUB/pBE5yYC6Dh3renxXLrXDUYX/GKgckjlGOC12j7TBX008zWi+Sg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(7416014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	XXq9sszNRIhCSDpGLs2P/2Xpo+GxKwOAY+6QPbpYE+DLoe1WSUr4HY2jHcYmGbND5TvvJhSJc/J9pXfFZqO54DDv7jnLuAwXw/DhW/w282Z597lt5ftTs8qYB9JZNBtiKEUnHvbxoTQrScXJp2t348oLnU/u+K6V/EBbkn/aYkF4R3jNS0ORs2ZdNixPHDDZNedPVqEkae5ETNjmx0E6MepZrxv3Cgkk98VtZhjNhSXLcm/3toYifxwgNj0Ha8YbvQHfw99AGO90Zw5WReMIt0m7KYhMy0TiRvjcvXJBmBFGFQkniPm3l+AYvxohUYFyhRrdiBwmRoPkta34qU6hcGR0KVwL59xUityI9HRUmPV5QuLbgqsO+k6KZL/+qKCiZz2yCJ+FeOFmrppVNI9rJch/GYR4eAKJygIrGvZhdi5aZKwMG57PE1snDxVXAqfM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:51.1246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 87f3b3b1-eabf-4767-07b5-08df0f3ee4f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF000264B2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
Message-ID-Hash: NDR3UCBI7HMPEMYM3R4TVDAFWRRX5SPQ
X-Message-ID-Hash: NDR3UCBI7HMPEMYM3R4TVDAFWRRX5SPQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NDR3UCBI7HMPEMYM3R4TVDAFWRRX5SPQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

During acp_init() for ACP7.B/7.F, read ACP7X_SW_WAKE_EN and enable the
corresponding host-wake interrupt mask in ACP7X_EXTERNAL_INTR_CNTL1 only
for managers that have wake-enable set (SW_WAKE_EN bit i enables
ACP7X_SW_HOST_WAKE_MASK << i in INTR_CNTL1). This ensures only the active
managers arm their host-wake interrupt when ACP enters D0.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index eff86b1cee3c..da987a51491c 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -903,6 +903,8 @@ static int acp_init(struct snd_sof_dev *sdev)
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	struct acp_dev_data *acp_data;
 	unsigned int sdw0_wake_en, sdw1_wake_en;
+	u32 sdw_wake_en, intr_mask;
+	unsigned int i;
 	int ret;
 
 	/* power on */
@@ -946,6 +948,20 @@ static int acp_init(struct snd_sof_dev *sdev)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_PME_EN, 1);
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_DSP0_IDMA_ERROR_MASK,
 				  ACP7X_IDMA_ERROR_MASK);
+		/*
+		 * Enable host-wake interrupt per manager based on SW_WAKE_EN:
+		 * SW_WAKE_EN bit i enables ACP7X_SW_HOST_WAKE_MASK << i in INTR_CNTL1.
+		 */
+		sdw_wake_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP7X_SW_WAKE_EN);
+		intr_mask = 0;
+		for (i = 0; i < ACP7X_SDW_MAX_MANAGER_COUNT; i++) {
+			if (sdw_wake_en & BIT(i))
+				intr_mask |= ACP7X_SW_HOST_WAKE_MASK << i;
+		}
+		if (intr_mask)
+			snd_sof_dsp_update_bits(sdev, ACP_DSP_BAR,
+						ACP7X_EXTERNAL_INTR_CNTL1,
+						intr_mask, intr_mask);
 		break;
 	}
 	return 0;
-- 
2.48.1

