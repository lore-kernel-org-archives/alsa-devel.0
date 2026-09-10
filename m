Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C35BC79FB9
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:28:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6824A602D0;
	Thu, 10 Sep 2026 15:28:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6824A602D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046931;
	bh=YvpvnAN42we2MwigPf4Vr7EGTiPWFzITacIF3L4sGkA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=f/nzgy9LHID6OUFnqtBLTxztcZVtxgE97G2NJzZPXHZ9wLoMHROpVwSkddz2Uiwyj
	 muMooY6Tel6eIFGu5NB2uonDmJ6SANvPeDGMUPsr5bCQlmmsnVWDbATOHjDJUlHJxo
	 4CbUc9F8nzYzti+B6WtuN+MSAMQLy6BxXxtiqdPA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52325F80C7F; Thu, 10 Sep 2026 15:25:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CE960F80C81;
	Thu, 10 Sep 2026 15:25:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2350DF8080B; Thu, 10 Sep 2026 15:24:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.69
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046691;
	b=Ud+Cwx6mZm5iXnJlaghrqSoSdcmqEZGRnO0uwvTdqngR2nBhOOBvOReRJmD4lNS9KzOH
	 U6OqP+5XtHOUPYy4cqiTRkcCV4QDPc7/NAeLY2Tm+rzx0sMs/1vD1UeaPG16j4NRyIShS
	 59c3ciJn8RzsJbaVnTVhVRv0lPIZgLbC1PWQJXFU7Fut9PGWtAiSa9zu9UC7cGkdSGtMu
	 Cd7XDnrzmV/jslz2sfG7EzGlxO6F9BbvCsh6EfURK2iMFmer0Fr/ETTL3dlYh+tOm8VgX
	 1IMQTsvOiGkjShpfoG8jxig5cr9jMq1EJxLIwn2x92MMVeI1eAo/sAWbT/6MhEFthMg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046691;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YvpvnAN42we2MwigPf4Vr7EGTiPWFzITacIF3L4sGkA=;
	b=sJYYburYrv2z25gelqlv02nqnh7O2nFVJhvCGYdYIiBDN3Or5nWKMc8M8e2chAVsWOLu
	 LexxBeg++CarZZZ2oGofWXmgkJfYZru7ter4rl9hxzUqB3QZrWYCyNlWFQzg8To8r4ebx
	 HVPhTT8wBDDZhYoRVmqKH3dNCnlHPfD3oNhdzo6g51kLhG5fCCIHp4R6WWSVwBciIlY2m
	 XDi582NTZCHRSqSTnW/7yE8l1vezJwo15ck5etXp7d++REHUezX8zPoU0WxGsNZKMxBPi
	 HfaQw+X4lIEWB93qqz5yASQzbWKWQRsXqmhSF/iXxzVPsJwtUoSKwjezN1pj+zgpU2A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cXtZFpgg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.69
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0680BF80774;
	Thu, 10 Sep 2026 15:24:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0680BF80774
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=cXtZFpgg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hego7RNKFWNnz5ZL2LmpSi+DF20BOt402QFW15be12Vemz8dId5qTlkxUIu9KF75BChGvFnnELcFEXOTu/Jmatq0j5w3gXhTM3fPuDgLOFtQbKn7/p8CYH6qdF2MPdB1VgEChH65eWX51vxru7xATRuRmTPrt6DpFU72kqYMEuzqSlo4SkYvlLh3MLUQ3cs6M+sf2qD7EL2WfZZybx/gPsIvWBn7Q9n3IRQNphy6NULM27ZJB4vVpX7oU9GAQ3MWbKMiMGlmeU70USNKXcU+0aEceKVCzUi5odexO4FCxWfqu7cWH5DLBaIXfuQ8mJftdrtORliJLK/4TNbpm+V8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb6ADFN3wwJDka1oaUcMl4J/K0lONFSE13HBqJAqJUE=;
 b=o8NIywFZ0K7bDFumrJGAirprY89Qp8H6GtMQXYJlWKOjSK8px7MwZj3eQ4ATaMsIllildxiokR0ofN+uGY70if3LNXPpoQgK3WLNRARqoh5Mk6MXLauEtKZd+AxodvgRQjooeTK0HEpbWRYnXwxA2dpIicD3QbwtaqOpajUsU4eMyxjvE9GNJGCz4Drkp4N1yr/cNU7Du+19NgSLqvZMvqb+HdpXLDgqeolIBT8volIvUPYOvpub1fC1LpA907CsldKOejrIXY/Qwra2SUXcJ2QPUCMrS6jlJjOSIbU/ShpYqCaJRPgFLspVF6h0cL2UapYczZ+sZVZhgkwZmrppRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb6ADFN3wwJDka1oaUcMl4J/K0lONFSE13HBqJAqJUE=;
 b=cXtZFpgg6Qv2BAqytQoxESMO4a8fRxm8x/I0Up2NkDaMPv2MxD/0FP0BeHOWs19m4KAulyWYdMQaB50xUGMnum5FJMALbRHiWdUM4ocL6bSIGh468bz9jz/EsQW6f5ADAHStbVWvMmJp0ct1Bpe66HW2C8oNkZOXOBZfMqbSZoc=
Received: from BL1PR13CA0422.namprd13.prod.outlook.com (2603:10b6:208:2c3::7)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:24:43 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::7d) by BL1PR13CA0422.outlook.office365.com
 (2603:10b6:208:2c3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.5 via Frontend Transport; Thu, 10
 Sep 2026 13:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:43 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:42 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:24:38 -0500
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
Subject: [PATCH 09/11] ASoC: SOF: amd: add ACP7.B/7.F SoundWire IO IRQ
 handling
Date: Thu, 10 Sep 2026 18:50:09 +0530
Message-ID: <20260910132251.1171943-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: e071de95-8fe5-4186-2b57-08df0f3ee034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|36860700016|1800799024|82310400026|23010399003|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	61eCRnyMrSxyhnf5Q4ktSVi2c61srLJu/FauefHuGfFSuVTpKq2mHQ5l9GO6ghgrsYKTtY5iqL7JbMz6J/qDAfL12p4dwhtH1f2PnZdLH5cEhPAP3LZ4gVkmkr7/vzmlUXU2SQBPx6X8gLIwCUTWGg+3Wob/mUjZfda4UGPDjGftzFfQ23fcuJgIS1NbAjwbcSXHt8bs7KnVZFGAxNwOFlwZsiUM1ogde9KQyIRZ+rOLtpJJob0hebRq+0V/sh9E4U8kpSgn7723REO8T3xyrnrYZOUhs7g9pippROxWMeHK5CJCvTiIMhxT7EJqCBsZ/3cBc8f8tbB3FjLF+SsyOaR2xOl8pyMN9xPlQzS/lxFuI8Wd8A/NqFUarY4gavl6AY1C3hNsVWZrJrQ9zecT28rhZNo0tLX9wxZi7rfVnV9Pp6QHaTszyu+t9y1L6r4+iEpmAOyGMfZqNKQk9qkfu/KKAP8zaMRNRRzpmtE9jCBMO0OrWmbgdx5gM66mHHl71ppjq0zCXsQWSNRKTOhmU0D+uj54OtSDUxgoOJyuhbu89jUO+JyKV/bDbVNNUsb5HgDKk5JnjNA/x3x15mTkUeWj/hImqO29jPs1EHLI/P2HwUKYUhkp32WAD8ukwQNdm9SGDH4eXRuYpJ2i1k9tIoI6CYnIoRtS9vfv3Qe7xx7m2ugE4l16GD3lr/clsHnfYImx+a8UHj7VUr65fe7gCg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(1800799024)(82310400026)(23010399003)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9h+456B+CboC4GwIdhBBV2N4c4AfOesCtf84waj044bAky8+nFKTfNr2hHEbVDOK8cMDmbVKBWITddotj7uX4u2gKh2LiywH1sUjqL5Sm+nGNpXqetTu02zMFeukbKRWCThsAizkWOCh+JCCeoZH+PKTlTYkDq3lHBMKVTxHQFEGkBA+TD5TB3KNpvOeZ0WTU+947a+LoqIuEN4Dk2O5paBQMnq+NNWwR8V7FO3uliZlxmFUgBSurN4a7cB9EG2bZKU0AqLyAQRGeNvVXlb/fusfGpITm7VHOju0LZrY0YkwBKYIN2uOPS2hu+kngVTsCz1fYx2YyHAhfTdDE7R2xtLoDlB8uynqPgOFnpU9ND3OGTsXdT6G8B9Ac75HsLQ3D4mnTb5ULDE/fR3G31BjwQxAk27ictd282g+hLlAkIx0kEcmimwWSb5xAXuOVFow
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:43.3370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e071de95-8fe5-4186-2b57-08df0f3ee034
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
Message-ID-Hash: VFHTQLBR5BUICF3L5HVCHQWGWO5PFJP4
X-Message-ID-Hash: VFHTQLBR5BUICF3L5HVCHQWGWO5PFJP4
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VFHTQLBR5BUICF3L5HVCHQWGWO5PFJP4/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ACP7.B/7.F exposes four SoundWire managers (SDW0-SDW3), each with
dedicated interrupt, wake-enable, PME status and error registers.

Add acp7x_irq_handler() to dispatch:
- Per-manager data IRQs via sof_acp7x_handle_sdw_manager_irq()
- Host-wake and PME events via
  sof_amd_check_and_handle_acp7x_sdw_wake_irq() which checks both
  sources independently per manager so simultaneous host-wake and
  PME events are not missed
- Error conditions via sof_amd_acp7x_clear_sdw_err_regs() which
  writes back the updated error status to clear only the affected
  manager bit

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h |  15 +++
 sound/soc/sof/amd/acp.c            | 187 ++++++++++++++++++++++++++++-
 sound/soc/sof/amd/acp.h            |   2 +
 sound/soc/sof/amd/acp7x.h          |  37 ++++++
 4 files changed, 235 insertions(+), 6 deletions(-)
 create mode 100644 sound/soc/sof/amd/acp7x.h

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index 74abbc834d71..3984cd627db6 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -159,4 +159,19 @@
 /* SW enable base for SDW0; manager N uses ACP7X_SW_EN + (N * 0x2000) */
 #define ACP7X_SW_EN				0x5200
 
+/* ACP7X SoundWire IO registers (non-gsync, up to 4 managers SW0-SW3) */
+#define ACP7X_EXTERNAL_SW_INTR_STAT		0x001A24
+#define ACP7X_SW_WAKE_EN			0x001458
+#define ACP7X_SW_PME_STS			0x001474
+#define ACP7X_SDW_STAT				BIT(23)
+#define ACP7X_ERROR_IRQ				BIT(29)
+#define ACP7X_SW_WAKE_EN_MASK			BIT(0)
+#define ACP7X_SW_HOST_WAKE_MASK			BIT(22)
+#define ACP7X_SDW_HOST_WAKE_STAT		BIT(24)
+#define ACP7X_SW_FIFO_ERROR_REASON		0x50C4
+#define ACP7X_SW_ERROR_REASON1			0x50CC
+#define ACP7X_SW_ERROR_REASON2			0x50D4
+#define ACP7X_EXTERNAL_SDW_STAT			BIT(16)
+#define ACP7X_SW_ERR_STAT_MASK			BIT(11)
+
 #endif
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index a4ca4f78e106..eff86b1cee3c 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -22,11 +22,20 @@
 #include "../ops.h"
 #include "acp.h"
 #include "acp-dsp-offset.h"
+#include "../../amd/acp/soc_amd_sdw_common.h"
+#include "acp7x.h"
 
 static bool enable_fw_debug;
 module_param(enable_fw_debug, bool, 0444);
 MODULE_PARM_DESC(enable_fw_debug, "Enable Firmware debug");
 
+static const u32 acp7x_sof_sdw_ext_stat[ACP7X_SDW_MAX_MANAGER_COUNT] = {
+	ACP7X_SDW_STAT << 0,
+	ACP7X_SDW_STAT << 1,
+	ACP7X_SDW_STAT << 2,
+	ACP7X_SDW_STAT << 3,
+};
+
 static struct acp_quirk_entry quirk_valve_galileo = {
 	.signed_fw_image = true,
 	.skip_iram_dram_size_mod = true,
@@ -581,30 +590,196 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 }
 
+/* ACP7X SoundWire IO data tables */
+
+const struct sof_amd_acp7x_sdw_err_regs acp7x_sdw_err_regs[ACP7X_SDW_MAX_MANAGER_COUNT] = {
+	{ ACP7X_SW_ERR_STAT_MASK << 0,
+	  ACP7X_SW_FIFO_ERROR_REASON + (0 * 0x2000),
+	  ACP7X_SW_ERROR_REASON1 + (0 * 0x2000),
+	  ACP7X_SW_ERROR_REASON2 + (0 * 0x2000) },
+	{ ACP7X_SW_ERR_STAT_MASK << 1,
+	  ACP7X_SW_FIFO_ERROR_REASON + (1 * 0x2000),
+	  ACP7X_SW_ERROR_REASON1 + (1 * 0x2000),
+	  ACP7X_SW_ERROR_REASON2 + (1 * 0x2000) },
+	{ ACP7X_SW_ERR_STAT_MASK << 2,
+	  ACP7X_SW_FIFO_ERROR_REASON + (2 * 0x2000),
+	  ACP7X_SW_ERROR_REASON1 + (2 * 0x2000),
+	  ACP7X_SW_ERROR_REASON2 + (2 * 0x2000) },
+	{ ACP7X_SW_ERR_STAT_MASK << 3,
+	  ACP7X_SW_FIFO_ERROR_REASON + (3 * 0x2000),
+	  ACP7X_SW_ERROR_REASON1 + (3 * 0x2000),
+	  ACP7X_SW_ERROR_REASON2 + (3 * 0x2000) },
+};
+
+const struct acp7x_sdw_wake_src acp7x_sdw_wake_sources[] = {
+	{ ACP7X_SDW_HOST_WAKE_STAT << 0, ACP7X_SW_PME_STS + (0 * 4),
+	  ACP7X_SW_WAKE_EN_MASK << 0, 0 },
+	{ ACP7X_SDW_HOST_WAKE_STAT << 1, ACP7X_SW_PME_STS + (1 * 4),
+	  ACP7X_SW_WAKE_EN_MASK << 1, 1 },
+	{ ACP7X_SDW_HOST_WAKE_STAT << 2, ACP7X_SW_PME_STS + (2 * 4),
+	  ACP7X_SW_WAKE_EN_MASK << 2, 2 },
+	{ ACP7X_SDW_HOST_WAKE_STAT << 3, ACP7X_SW_PME_STS + (3 * 4),
+	  ACP7X_SW_WAKE_EN_MASK << 3, 3 },
+};
+
+/* ACP7X SoundWire IO interrupt and wake helpers */
+
+static void sof_amd_acp7x_handle_one_sdw_err(struct snd_sof_dev *sdev, u32 *err_stat,
+					     u32 acp_error_stat_reg,
+					     const struct sof_amd_acp7x_sdw_err_regs *regs)
+{
+	if (!(*err_stat & regs->err_stat_mask))
+		return;
+
+	*err_stat &= ~regs->err_stat_mask;
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, acp_error_stat_reg, *err_stat);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, regs->fifo_err_reason, 0);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, regs->err_reason1, 0);
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, regs->err_reason2, 0);
+}
+
+/* Clears SoundWire error registers for all managers; runs in hard IRQ context. */
+static void sof_amd_acp7x_clear_sdw_err_regs(struct snd_sof_dev *sdev)
+{
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	u32 err_stat;
+	unsigned int instance;
+
+	err_stat = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->acp_error_stat);
+
+	for (instance = 0; instance < ACP7X_SDW_MAX_MANAGER_COUNT; instance++)
+		sof_amd_acp7x_handle_one_sdw_err(sdev, &err_stat, desc->acp_error_stat,
+						 &acp7x_sdw_err_regs[instance]);
+}
+
+static void sof_amd_handle_acp7x_sdw_wake_event(struct acp_dev_data *adata)
+{
+	struct amd_sdw_manager *amd_manager;
+	unsigned int instance;
+
+	for (instance = 0; instance < ACP7X_SDW_MAX_MANAGER_COUNT; instance++) {
+		if (!adata->acp7x_sdw_wake_event[instance])
+			continue;
+		if (!adata->sdw->pdev[instance])
+			continue;
+
+		amd_manager = dev_get_drvdata(&adata->sdw->pdev[instance]->dev);
+		if (amd_manager)
+			pm_request_resume(amd_manager->dev);
+		adata->acp7x_sdw_wake_event[instance] = false;
+	}
+}
+
+static int sof_amd_check_and_handle_acp7x_sdw_wake_irq(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	unsigned int ext_intr_stat1;
+	unsigned int sdw_pme_stat, sdw_wake_en;
+	unsigned int i;
+	bool sdw_wake_irq = false;
+
+	ext_intr_stat1 = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat1);
+
+	for (i = 0; i < ARRAY_SIZE(acp7x_sdw_wake_sources); i++) {
+		const struct acp7x_sdw_wake_src *src = &acp7x_sdw_wake_sources[i];
+
+		bool woke = false;
+
+		if (ext_intr_stat1 & src->host_stat_mask) {
+			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat1,
+					  src->host_stat_mask);
+			woke = true;
+		}
+
+		sdw_pme_stat = snd_sof_dsp_read(sdev, ACP_DSP_BAR, src->pme_sts_reg);
+		if (sdw_pme_stat) {
+			sdw_wake_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP7X_SW_WAKE_EN);
+			sdw_wake_en &= ~src->wake_en_mask;
+			snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_SW_WAKE_EN, sdw_wake_en);
+			snd_sof_dsp_write(sdev, ACP_DSP_BAR, src->pme_sts_reg, sdw_pme_stat);
+			woke = true;
+		}
+
+		if (woke) {
+			adata->acp7x_sdw_wake_event[src->instance] = true;
+			sdw_wake_irq = true;
+		}
+	}
+
+	if (sdw_wake_irq) {
+		sof_amd_handle_acp7x_sdw_wake_event(adata);
+		return WAKE_IRQ_HANDLED;
+	}
+	return WAKE_IRQ_NONE;
+}
+
+static void sof_acp7x_handle_sdw_manager_irq(struct snd_sof_dev *sdev,
+					     struct acp_dev_data *adata,
+					     const struct sof_amd_acp_desc *desc,
+					     unsigned int instance,
+					     u32 ext_stat_mask)
+{
+	struct amd_sdw_manager *amd_manager;
+	unsigned int sdw_intr_stat;
+	u32 sw_intr_reg = ACP7X_EXTERNAL_SW_INTR_STAT + (instance * 4);
+
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ext_stat_mask);
+	sdw_intr_stat = snd_sof_dsp_read(sdev, ACP_DSP_BAR, sw_intr_reg);
+	if (sdw_intr_stat & ACP7X_EXTERNAL_SDW_STAT) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, sw_intr_reg, ACP7X_EXTERNAL_SDW_STAT);
+		if (!adata->sdw->pdev[instance])
+			return;
+		amd_manager = dev_get_drvdata(&adata->sdw->pdev[instance]->dev);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+	}
+}
+
 static irqreturn_t acp7x_irq_handler(int irq, void *dev_id)
 {
 	struct snd_sof_dev *sdev = dev_id;
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	unsigned int base = desc->dsp_intr_base;
 	unsigned int val;
 	unsigned int ext_intr_stat;
-	int irq_flag = 0;
+	unsigned int instance;
+	int irq_flag = 0, wake_irq_flag = 0;
+	bool dsp_irq = false;
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
 	if (val & ACP_DSP_TO_HOST_IRQ) {
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET,
 				  ACP_DSP_TO_HOST_IRQ);
-		return IRQ_WAKE_THREAD;
+		dsp_irq = true;
 	}
 
 	ext_intr_stat = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
-	if (ext_intr_stat & ACP_ERROR_IRQ_MASK) {
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_ERROR_IRQ_MASK);
-		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_error_stat, 0);
+
+	if (adata->sdw) {
+		for (instance = 0; instance < ACP7X_SDW_MAX_MANAGER_COUNT; instance++) {
+			if (ext_intr_stat & acp7x_sof_sdw_ext_stat[instance]) {
+				sof_acp7x_handle_sdw_manager_irq(sdev, adata, desc, instance,
+								 acp7x_sof_sdw_ext_stat[instance]);
+				irq_flag = 1;
+			}
+		}
+	}
+
+	if (adata->sdw)
+		wake_irq_flag = sof_amd_check_and_handle_acp7x_sdw_wake_irq(sdev);
+
+	if (ext_intr_stat & ACP7X_ERROR_IRQ) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP7X_ERROR_IRQ);
+		sof_amd_acp7x_clear_sdw_err_regs(sdev);
 		irq_flag = 1;
 	}
 
-	if (irq_flag)
+	if (dsp_irq)
+		return IRQ_WAKE_THREAD;
+
+	if (irq_flag || wake_irq_flag)
 		return IRQ_HANDLED;
 
 	return IRQ_NONE;
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 47e475de8b4d..e3c85b5cb20c 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -290,6 +290,8 @@ struct acp_dev_data {
 	bool acp70_sdw0_wake_event;
 	/* acp70_sdw1_wake_event flag set to true when wake irq asserted for SW1 instance */
 	bool acp70_sdw1_wake_event;
+	/* per-manager wake event flags; indexed by SoundWire manager instance (0-3) */
+	bool acp7x_sdw_wake_event[ACP7X_SDW_MAX_MANAGER_COUNT];
 	/* PDM controller index selected from ACPI acp-audio-ep-port; passed to machine driver */
 	unsigned int pdm_sel;
 	unsigned int pci_rev;
diff --git a/sound/soc/sof/amd/acp7x.h b/sound/soc/sof/amd/acp7x.h
new file mode 100644
index 000000000000..5151d8757c12
--- /dev/null
+++ b/sound/soc/sof/amd/acp7x.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
+/*
+ * This file is provided under a dual BSD/GPLv2 license. When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * Copyright(c) 2026 Advanced Micro Devices, Inc. All rights reserved.
+ *
+ * Author: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+ */
+
+#ifndef __SOF_AMD_ACP7X_H
+#define __SOF_AMD_ACP7X_H
+
+/* Return values for sof_amd_check_and_handle_acp7x_sdw_wake_irq() */
+#define WAKE_IRQ_HANDLED			1
+#define WAKE_IRQ_NONE				0
+
+/* ACP7X SoundWire IO structures */
+
+struct sof_amd_acp7x_sdw_err_regs {
+	u32 err_stat_mask;
+	u32 fifo_err_reason;
+	u32 err_reason1;
+	u32 err_reason2;
+};
+
+struct acp7x_sdw_wake_src {
+	u32 host_stat_mask;
+	u32 pme_sts_reg;
+	u32 wake_en_mask;
+	u8  instance;
+};
+
+extern const struct sof_amd_acp7x_sdw_err_regs acp7x_sdw_err_regs[ACP7X_SDW_MAX_MANAGER_COUNT];
+extern const struct acp7x_sdw_wake_src acp7x_sdw_wake_sources[];
+
+#endif /* __SOF_AMD_ACP7X_H */
-- 
2.48.1

