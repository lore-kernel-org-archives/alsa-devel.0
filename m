Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F0BC79F9F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:25:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2CA89602A8;
	Thu, 10 Sep 2026 15:25:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2CA89602A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046752;
	bh=DVhNOyqF8GYVtL7r2qjzz8lPWBT7Zpyix4XpG+aq/8A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vJbew/RjprrVbnluD+YGZx6dYlzXORAqr0azFX2rihxC7Q0VUWoHPpGDR6+CEx6BR
	 ltYIajv7jHkPzD1XdE10TNjqOL3Ra9Wdo1Jt5Sokg1N2YleGybPFRiF2ebQlYQQixl
	 DaMN8T4kzaRmc/OzpxTSYQT4y1/Ld6nc2EIqmMFg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C980FF80683; Thu, 10 Sep 2026 15:24:33 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 57236F8065E;
	Thu, 10 Sep 2026 15:24:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9D709F80638; Thu, 10 Sep 2026 15:24:27 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.51
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046666;
	b=kOrsKG3ORKZJ8rCp7oUXTlAsr68ZnrutqduFB3j8NtFskqYfi1hfC0C5QVC0GeD1sA7W
	 JyydRWAZ6H1PXNLP+YL8x1YTn1opthpBsLUkB8YowoLflatlob+we4BSEljhWYCOsOCmA
	 YqJpMDDXP4K43n5euuKY0A8OAtNlXK2pe7Tg6QtSZPTdeSI2d4cFmwPvTr/G2BpySYm3Y
	 1kGaj1Rhj3wpygbAdR23npFbOnH/+QvRv3ntVxbP9BNd5/9E771ie4LbeBvlwpxuh7J2g
	 aDNBcQZpipoY3CMk54hAqp1YKEhgrU4+yaZneQStFj0Fhl27D+WO3Ldd4NvR5GxBO0w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046666;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DVhNOyqF8GYVtL7r2qjzz8lPWBT7Zpyix4XpG+aq/8A=;
	b=YUn1+mNcBGIksOcAFTUlqfBCgmxdMBD8Qe+h+EOCRpI+B0yLDwV7NbKYKz+Lz31q65ZF
	 GSdOn6NHkuj2qp43HKGnqSsd31lw7kE51FGObEsg6eJiOBRpeDB7N0nMisJz5wiZOoePO
	 cVGodrD8ayoHOsblVE3taQvzpfQORGkcR0Hz/i6HUAas3ScQh9gzJr6vaaKej7/r/GXIu
	 v6/YbjJzIkVC7CEPB+xx4Ih5F/H4EFih9Js8M/kssycwmMIR5zI3UhCjNGG0n7n6iNBbI
	 avphiO7AHvKjhB20PIFKjXoIoS+mAsyy3bCZGUUXYkfh2uGYlsFccqTw/fl/3CF+7pQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CUb0OTWA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.51
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CAB4AF805FD;
	Thu, 10 Sep 2026 15:24:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CAB4AF805FD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=CUb0OTWA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayYvOOnzVVU13dT4GMunyXmEAXVOO6+NPRBBWMnOKvRZfbLbnOa4AGXNxQ4JKghndj1LxCyOAAgh5H1xw1SsUZdiNG6QnJo8J0JD6WYTAQQw60YP34/BeX1MQkWhRZHXtB7hQnm0sm7Q4/4e+NA2mU9X7G0VsbjuWeoxLgzZdcjUudlaOZSbS1ThGj5eiAcf9aTRp8HaxiRnNG2qTbdzCpYtnabnJTj1lia/iTyTU4pjD7JUL8d+lCyJPhaWfk1wERiseJQLXj/4ugD/8Rn26XERxTmjMSupy2EAnFZc6B2qps2yseu3Vr8kkkf3uwyGABL0ax+KJIztrOHT2TUFaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfbDZK2szKvHjRr165JO7tXy1zLeS4h638g+bF96hB0=;
 b=UlotnZzKYlibQdYzVhO/0UE6h2JHPAZzOktoNzHv/ItNSCogwuMgOacnGpTQjAWWvJUNPjetfHptmCzQUTvvTnv7/rCBY7PXbWA1lbBJLcplJ8GOFFlkZUhXd4vIayvJ7zz9RfukFbL1Wy7wSLEpjJh08rzb3lS5+ELQz5DowWb9hlk8H5XPZER0YylMicag6GNjl/766K5NxtVwbCo/i/mpejF5FzRJ1jpMlpCub3Nk/dGDmNOcTp6kwPmSaqRb9KYzgv9O2qhOMphdLAOTTGaeeSVHt1uwF8cf9EYxh+z0+jsvVjAnbBrO6zsfJMJaKUDHpJt84ETEa+kzLF5B+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfbDZK2szKvHjRr165JO7tXy1zLeS4h638g+bF96hB0=;
 b=CUb0OTWAA/GHqrjoXnRoXP3r3/wLJeyvFUfDhnnGC7UzJQIcew6DX+duJaOf4OddrtgpjKkdXjuD3kh5zlI+N3ohF+xsC3ntuTGjwJ9opqO6T+6vtdCmAGwWuJ4SB7WAQ82Z3kEcZJgHjgJxKdESqt5Q0tqc0v3Zrd6aPvirG30=
Received: from SJ0PR03CA0176.namprd03.prod.outlook.com (2603:10b6:a03:338::31)
 by SJ5PPF4D350AC80.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::993) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:24:17 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::74) by SJ0PR03CA0176.outlook.office365.com
 (2603:10b6:a03:338::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Thu, 10
 Sep 2026 13:24:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:13 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:24:08 -0500
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
Subject: [PATCH 03/11] ASoC: SOF: amd: fix amd_sof_acp_probe() error unwind
 ordering
Date: Thu, 10 Sep 2026 18:50:03 +0530
Message-ID: <20260910132251.1171943-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|SJ5PPF4D350AC80:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c478ce6-7cc3-4ba1-baa4-08df0f3ed0f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	q44WQWH2e8wi0Kzv22WV3tp9gKDfLo9zyiJ8atfhagDuYNHEK/9e4wLYUnVHaFewjVroaJGy16fz/JP/tSa+U7UqkadRp7XDAPeOM7Z4nTyOWbyCn9H/mnCfdXm6Yt/Lkh1sLQ17fEGF7gbxnVL1KMuapwtG8cVP/xyzCm25aQcWibrjsvSjg25jbgC1ei2U0F77/45u3vy3fTDCyYp/28VOMq1cmKun3lot3J7U0+KaIZWPrC/Izwoo07wgfRPEXAP/wg8v6Fm5mKOorbDhKkBI5wqqGD5FlqbErQ8HDimxE7sUKiVG+nJ79q1qSWUEgvFMjzM0Tfu+EnfUTH+qPXqLXF2gTYewt28EV+nBdtaWeifodnkfGKGy2arHQAIYBBmWNNiIXsPEX4JIVEVli31HlCyV5FcIfrTU7/L5iCnbGvzfNUdBWVNd7/2+rg0C8MZiCleo2g0ZZrJs/HkvYaMsKBTrWNNfr6hKjN3sy7Q/6qkDCLKG0xD1wmg4r31l2Ov0xZfDPY/xobFaFOEM5PIIwcl6JjZOK5J9fRa2257Jx78u9VL+uA0X975kcd18CulxNevqO9563OVKyJdB9ErCGdrQjf2ss7y9nqWIcKwqcUmiD0UrkDjFst/+WeFCsE0PSNdShruwZGbnyRJ0982fnqTCGGfltI/15gJvAA8dSp0ld26vytW8AfttnCBlQoa0pI1Z1i7IcaG2aBX7kg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	phoMddZoMQ6dMWBUFx/2tWrZBEUy7QDT3g+wBhL0SNGL2KHeVJHmh0OPwRDm2UWvs1jlsQP32hzXtN3LN9VKdO84MJpQhcDB5F9dgQLeUrWKoKvIl8sLHvwNsD+2t7jThYCO5kvc0+nDG2+6TJEexjiqFJkbnbVgoPi5CoBCN/pvXIQt3adv1ku6Golnnwvc8NhDtT+hvajzWyFJlLPMKNXPCcfywxK8Y77MW0r/e2PjquMEH2+2e21nVU3XcuIQc4aHi9EjbgFaQHCr7D58SNZp+H3Iqe/9puAiVaLRbdI5MMcefftokLdZgBFbp1Rt8tuGNA/E2qKJnIGGkQeK/FNpyeXwa5P9Zp22Mbs0tqPNKtABTSDwwdCpWlVJJzN7JIyRr4zudyLD5PEx4lS4msPmwdLaSEBxuqupL52NhlcWRAvQGNaZzyvXi/SRGVBl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:17.6924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6c478ce6-7cc3-4ba1-baa4-08df0f3ed0f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4D350AC80
Message-ID-Hash: PGWJYARJDZJ2R6NB3Q6DFZGC3T42HWJP
X-Message-ID-Hash: PGWJYARJDZJ2R6NB3Q6DFZGC3T42HWJP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PGWJYARJDZJ2R6NB3Q6DFZGC3T42HWJP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Call amd_sof_sdw_exit() after free_irq() in the free_ipc_irq error
label of amd_sof_acp_probe(). Without this, an IRQ that fires between
sdw context teardown and free_irq() can dereference freed SoundWire
resources.

Fixes: d948218424bf ("ASoC: SOF: amd: add code for invoking soundwire manager helper functions")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index e4cdb74c075d..5570f3d1348d 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -1038,6 +1038,8 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 
 free_ipc_irq:
 	free_irq(sdev->ipc_irq, sdev);
+	if (adata->sdw)
+		amd_sof_sdw_exit(sdev);
 unregister_dev:
 	platform_device_unregister(adata->dmic_dev);
 	return ret;
-- 
2.48.1

