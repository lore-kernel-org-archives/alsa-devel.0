Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE72C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:01:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E8386021D;
	Wed,  1 Jul 2026 12:00:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E8386021D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900058;
	bh=RujFb/0l3NVtWFyRVvWDo9MnhjZgO4pTnpGmahCfin4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IBt9SVkIePGsrdTsPMbgqkM/yM2ZgNHjtUrJz2Hx50oqrgdhGuSWTq8deEVTDnsdh
	 Dcohu/E3dikFlaaSVvu/ACJS1vMut6xtADyWgy5g1l5gqdFcw0rxUZukhz/mnrm5yP
	 /YCCyX72gs2jMh69tTqOKmib/+jJPGYJTscDAiYs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 47F2DF806D8; Wed,  1 Jul 2026 11:59:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B6790F805EF;
	Wed,  1 Jul 2026 11:59:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3E0EF80652; Wed,  1 Jul 2026 11:58:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.62
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899933;
	b=RQFzk3RR+3DIM/h10aCDLF3toZpcwj9EUppAxK3NP0b9e5Uvpc3usrhNAiFIOCYSpks8
	 L5efmxz8KDCWf/OmcGvP+0HKhayaqFCMJKAKVNcCT6HVlqjhO/4nXtg/5jKINbNMy3Uxl
	 8Q0UkCU3/FE9EBdt61y2fvilbXTxwvqxEV/gwdrHkBhfv459o4p1ZlKW7PSzpR9wMANEc
	 BX+nFlTC0l29XmesbXLgdiFjRXRdYcRgsuQfsWsMECuyDXmuHAMV03WjbNSYfQeNVPfXh
	 olj4iL0TZODpgl1ytpzwUbWS02/Fa93cQ79lSgFCmSrdiU9pFdEmYG2chu4eaxlhwxQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899933;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RujFb/0l3NVtWFyRVvWDo9MnhjZgO4pTnpGmahCfin4=;
	b=cP2dwR3C8sp46C3uusmXWC11+8jQ0ojeNb/Fmn8mKFg9TV4CDr65DyZJ/toMLDOgT5A4
	 1PeUomTAK6uWKOChmJwZlJglPs8p9jiOtW2J27/e+frIsUmvAxt5j8h/fQmtaQYsGBzRg
	 fo42qBqe05ia0GTsRNVce7R/vTR5p7HqZpQBpKSYgkMxMp2jBeSZpt6Z4p1PaQK+6SEyr
	 a0uvj/+sgDUq8spLc/JseIdQ08ldOcrR9eqpRA3VO69w8+zaPz5k07okMpAjMHiXTHkFp
	 JM0fnh/jmuN4JAEYYWjI0Ci9XNA49A7Rob+45xAEyUXJWuD1fHQ1VxyCKHhYdat9kdQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=RQx6P1zG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.62
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1376BF80641;
	Wed,  1 Jul 2026 11:58:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1376BF80641
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=RQx6P1zG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL4LmudmFthja5vR8h6x2kjm5XE6NLNLYhNi+Kggg5AFIPDdcPJ3Mw9XgcIpk/AmiXTH1dSXudHcd7iR8EA2JwLFA5x7x5lz45mAFONQF7pYDoFYFT99OnSOcTyUoln9evAnUzO94cBoJDXdUWPXyC7RUjBURGS0QPSGJuRWiz1+ptiNZqW2nHKkWv3CqR/0Ltc7uKX4o3m2ea3AzIEe5cHmrUJG9mTtoN60yVTpi4CJyoXr0Jdeuz2AyfK1SnpHmezXexf8/GeDwvqDzXl9vsl0MePI8vf0cu8Ei78Tqxe0U7VXS2bJTATuHaxA6hSGYNblqrUswqIE5xA75OqOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5/T7AEWVsegpqhZsxLAcjv9+iAUYH002vjIe+bKNhU=;
 b=VxLfVdsjTGIW8qKhPgiTJhY31zTKK2MP/tdZkYywqcHnBPwDsE1GO9q2+GrDOWU6fjxYDszYIXb9YLUZceStwYE8GW4Aoxxf85SY+o4Xxh3rUsBfvCueCaqxu+axci+V0yFKPj1z7JnpsVwh73zTXeguU5AzyE1yAZyiGbnf1qQ4fyQ2ht9B4qeTUQ7r1qTy/FCs5WAybYt18VJcTeH2KH/oNxomx8rjmvFUR8ivvx34csKOjJfgyUhZIB21g7AL3sCz/hBpY/mvi5scnoHz0hKUHnFfzH65XHt4lZMzNO32HaFxb/nNajGQ7oMkbo7xx18mlwIsoKdGjgBgeajxNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5/T7AEWVsegpqhZsxLAcjv9+iAUYH002vjIe+bKNhU=;
 b=RQx6P1zG9d/mS0N0+8Jw21we5xXlGREpP3IFWj/YSxgrcez5wPTC4F1hGmth+C4peKYJKiSYqHinoVPFDuWwd+bNg9O0yysvnRV8n0b+TEDELGWPPjO5ti88xNRgJsgXbqdZy9BNOLTq6q/zjZhwtwDNfxBISNjakbGbl3BVoHI=
Received: from SA9PR13CA0002.namprd13.prod.outlook.com (2603:10b6:806:21::7)
 by SN7PR12MB7323.namprd12.prod.outlook.com (2603:10b6:806:29a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:58:44 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::10) by SA9PR13CA0002.outlook.office365.com
 (2603:10b6:806:21::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 09:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:58:43 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:58:39 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 04/16] ASoC: SOF: amd: refactor SW1 I2S error reason clear in
 acp_irq_handler
Date: Wed, 1 Jul 2026 15:25:05 +0530
Message-ID: <20260701095759.1012929-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|SN7PR12MB7323:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c8fd10-c0f9-4479-9eee-08ded7575620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	CBNnonIbl8jD4vqERnzFJixrNpYt9Qb/CXN1haZ1E2wREAnQNMKQW0niyZCWgYlDjgSY+mZLXxh71KKcDeM4lmAFviho1aiTfLpSrhzGYJ9c4353rfudBS8CQTCQzwEEVUuX+oG9MFD4R1HmWOETQZYkdT5nuBhKEUF91uLHG6hVHJS2NtZtsif//ospW1bAMjCrZz2ZMg7xZ6PSRXC6zLnNru/zZ1eK8BZruYKWG2Hd5bTYTMMZc0pdjs5EHFjs85bmmCb22aBC8gb/AQdpK7L6aOYt0BaplUIJomNCdFfHaXgqLw/eq3b9lFjnpJVtkW/gfd/yKqplOXWn9cpTDGesZzaJRY4NaC8Y10d+m61SwdW+lRZUoHmqkzNjKeP5sUEB7evHjFp7jtZl5ZsVUrH0irHfTTHPYrwgWrSgWFWFWMHEGeF6LPJDujDThaBW56i7Vz8oh8VN+qdSBO7foGN/OMznKVYawBVVDSSHSYN1PQhz2gy+YtnXmVWdOtFklrrMJVjqKw2X2rO2iImfKNCzmdUIpJLBcG0E/IRSq6WGexsJtabU3WMvci4ofyHsit4Hds2ahIdnmlSqTgntDPZ1KhW+l52ooUOzqml9036WyLV70DQnZ2SIShfP0afYwMUZcJiWk01p6Ct9LkNEInWhGYDpfMSicDrRCdgBBKioQ7+wS3Ka0Pb0T5sJj2WDT4KfrDPey8AASjAdCOcZfQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	QEoI1EsMmZxnBygkhAQCOgLFDgx9X1Gn7fwx31sMLQfy1kbA6EbrxT1U2Ity7iyifJW+Q2NY/7+urxhdXIgKKba6KHXXdMMWMrz+o86M7HAXFs6fFvQL6rgmwjTyanlRQf5wthMfbza1TKIoRjsLQiAwjCXDNw5G3KQ0QOaolvJIcMLM8+64c9jKMOvIjYFubl20p8CZbFFvCur38zdrbMrkmFYskMVzjZyYTlfj9wbY/qeTAqPfQ/AWvfA3kZlB8uZgLyGbzzfE7IPpEaW8NmsbkwU4ceBGgS04DmiwM/bGzQ83CHrohNuZrdCOiIbE7iKqZXJihhm0QrtSWTLHPQb1dqoY5jfJuwxP1gOzkPd3Rn7OCuX+aIwRE9Tp1RuO0KNimhpjkmEW/fiXQTJ7M/wcAtWZR1HqqC2N26kD6v3ji0tyNxFTrDrDPUSe4nkQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:58:43.9670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 58c8fd10-c0f9-4479-9eee-08ded7575620
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7323
Message-ID-Hash: MDLVUFOQWBKAV5SUPPMMRV5SVANNGRWR
X-Message-ID-Hash: MDLVUFOQWBKAV5SUPPMMRV5SVANNGRWR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MDLVUFOQWBKAV5SUPPMMRV5SVANNGRWR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Replace the open-coded pci_rev comparison with a switch statement for
clearing ACP_SW1_I2S_ERROR_REASON. This makes the per-platform control
explicit and easier to extend.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index f7b22f9979f6..1f0fc052ea1a 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -540,8 +540,17 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_ERROR_IRQ_MASK);
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_sw0_i2s_err_reason, 0);
 		/* ACP_SW1_I2S_ERROR_REASON is newly added register from rmb platform onwards */
-		if (adata->pci_rev >= ACP_RMB_PCI_ID)
+		switch (adata->pci_rev) {
+		case ACP_RMB_PCI_ID:
+		case ACP63_PCI_ID:
+		case ACP70_PCI_ID:
+		case ACP71_PCI_ID:
+		case ACP72_PCI_ID:
 			snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SW1_I2S_ERROR_REASON, 0);
+			break;
+		default:
+			break;
+		}
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_error_stat, 0);
 		irq_flag = 1;
 	}
-- 
2.45.2

