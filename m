Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FE7D1073CB0
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Apr 2026 13:31:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C348E60209;
	Wed,  8 Apr 2026 15:31:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C348E60209
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775655094;
	bh=B6/8+3+jD/NRZV2jxNtjSHdqyQb1+hyextPQLFfseK0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=jb93Seg96TY4Zj77sI0P9OqUfj/4ZizlQgk62MMT+RYbYt4WVLZ/iaYijUH5guRiU
	 Zlo+jQq383Ksrz2T/nPpQmqMGylFPou/8fqMHjxc+hjL8nrOjVcRdhS46sKOuCkvDk
	 bFP3DJmx/mxrAlYuGq5r0ZOVXQAwFvXZ5m5jXq/M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 374D6F805F1; Wed,  8 Apr 2026 15:31:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 84C19F805F2;
	Wed,  8 Apr 2026 15:31:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 13523F804CF; Wed,  8 Apr 2026 15:30:51 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7EB12F80154
	for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2026 15:30:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EB12F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=WSSyQmWz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8gHYURUA2fxFsz9urdJE2gXvZTztoYWBx3wHd4fawHDtueaMgS9EXu7Tal+zF8SZbfpeOjLwn8g3/6DW+toKzqsz+wuY4zCRtRJXpzcj+PpkXcGRkLKVAec5UlRYMgnGu831PMNziNelFSJaJd3udyc6+zHXEGEDaomxiwvUx6eZs+Ne/PLFABKMZA1Vb6zhC6bV+TQ813i7H35f7aNrTdhm8n94APC/gYliSB7c7k3Oe9IF3UNXEV5GSKQ5m0AoDFWISspvPlNRzj6po//CN7naWHIATscsZ+u7l0cK9Wwr/WtQIswLz+F2R90h8AZcdQSxFyGeFpB1rqSOpcZNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6JjelVpnkHVVKO/Juushs+0vnP5zCB711DWA3yFods=;
 b=tegbINWGSrrgmOtKTLuglcQFMf/2XJIsP8+UKK6wZXUwRGj05BLo22GyS5NszhFITW4tcWrBTy/COsBrhYOvREcaZ0rD2PwIQJTWCBeL5lQolghwNBZVw50gkxKsUKK1zEA/D25wc2qVfkyBOvkoD5kTxG5Z9Rnrp5rNaWWCqHmts5r2DHLqzplQwajlvURuEPagV21fQ73bFZlBfq2KikbTNapYpxh5fdm9NOiOO2wIxE+sP2OpqjaoJut4XbA46wAywvepVohngBuLmZqjm2uFandzNiOBtoAqWgZd/0I5pUk03w9BTvKBX43meaCvyhl+AAHovUjZ7mqQh7PONg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6JjelVpnkHVVKO/Juushs+0vnP5zCB711DWA3yFods=;
 b=WSSyQmWzQ0xGBOyIiXLR7ulHqjFTFvep7P+9CrPpMVymOBTi161VU0DNmyvKVbNyJnS766JrIyQVmHwkcLcRyigK9PVvMAlsyMJUbXpslncSOMSPpzE4LgMjB3d3+JYZuRRGVa0WRW8Iur5y5hlT8jFTt0RgOcSpfVBS+zXPHkc=
Received: from BY3PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:217::6)
 by CH3PR12MB9249.namprd12.prod.outlook.com (2603:10b6:610:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 13:30:37 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::1e) by BY3PR04CA0001.outlook.office365.com
 (2603:10b6:a03:217::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 13:30:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 13:30:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Apr
 2026 08:30:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Apr
 2026 08:30:33 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 08:30:29 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <Sunil-kumar.Dommati@amd.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Mark Pearson <mpearson-lenovo@squebb.ca>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Charles Keepax <ckeepax@opensource.cirrus.com>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Hasun Park <hasunpark@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Kees Cook
	<kees@kernel.org>, "open list:AMD ASoC DRIVERS"
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: amd: acp: update DMI quirk and add ACP DMIC for
 Lenovo platforms
Date: Wed, 8 Apr 2026 19:00:06 +0530
Message-ID: <20260408133029.1368317-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: syed.sabakareem@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|CH3PR12MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d35759f-c257-434a-fe36-08de957303ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	/e7FgOWc4NrnHjtVSGQVmwBh/epE7OisXqJexjUVhydlBxnOD+YS2g5D5eJ5HLuKdfRz+3JweCwspOm2uE2oTmIAG5nX+RZXbTGuw1R3zRa+mXFFPpGRfQlrHbjmTenxkyCls1MS5Wdq1Nrc3hiJx1x/1/tqZbs2kvPO/z+eECdyZns/R3ZfrupW6hkzdR3nljz6FUkRe72IUmu4lPrrhEcCN4wsGkNqHBi2gp14hhtrLLsot/dfDA9Y2OzQQJhsTOwfPI4q+3aoLJibs4qJ2IusN431B9zovRiw2S+6z4M72Y6CWXdr1lrg/EQ6AwioMq5D6xHJrt+nY7sVGZo1AQ62TM+S7PnN1wU/4gl8mFhT3GTmWsmrDqnbCjz6quJYEakWEhzyzfvb/bzk+uEXpW1Sjv67V5SNlhiACk6ATHSpS65qJ8DdLilm4nLEjF1Li2RbQcVWUJhR3RHkZ24pxNTOy4q8pA1628vtMa9pRkpVLAcEthqelnd+McJCkx1mNo4OvWXrWZKs7IsM+AbHDCmR9vBJ9Z7Z16f63CKuMt1V8BIgf/qHEqQ4Rnql9+l7v8dMQWpJcw6CesSY4u5k0DYV+zOHkPxH4ndStQbdxHTtv23D2CjKTp2IhnFHQP6Cl7j7S3iiWPJ77UU8hmR84wiIzQpHSzEQSbp81l9BreFum1Xa7oHYIJ8K8RlJvWyoiAZM2p9e8xi189RQ+EYLZOD7UxtwsYcpV2Ob3PAcg27lXOrP6WgKw5NNG20baEiL13kzZyR1wWk/JqImgxaikQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	oV+Vdzj+/XaNR3VOdVIwHd//Kg4PQQaYdxMDGOC/QVyQU5eC+1SwQ6rsH9Ozglz6shLtKahjIBAU8uJCjBHzPIchBq6eGgM+qbaL/BIh0OIRDZVx1gC5j1kDwQHqnW+rytm4z2/Ur0GWRjDiMiN08i4bLun5RBWgX6zFYY9zHOBkmnXtK7cohsyN/rx7e/qOL0mqgeyUqzhpK6YCJyAf4rILlvQz1xG1vHhd7K+JJvjjACe0uijnsQW1B7XEv77RyX5AwCOAIPAQkOB0l+NuQnDNhaBTfLVo8SHVLlR3Kc4n7vCUSKyFW/Gia3JQEwYWvfYSV8QPsQxNBrfp9TTfHNXuovAvXxPGw03u9S173APfk/gHkMFAIcGd+QFUtt96HUcwRHlKO5Tt5UNN8NYhcNQ1DsekFjDGKqVxmcHJJNrkCnZVjJasJTvee0uCvXqQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:30:34.9258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7d35759f-c257-434a-fe36-08de957303ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9249
Message-ID-Hash: HFG4IZ7IUSBB56Z3QRNTHUGUE5IEWGHF
X-Message-ID-Hash: HFG4IZ7IUSBB56Z3QRNTHUGUE5IEWGHF
X-MailFrom: Syed.SabaKareem@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HFG4IZ7IUSBB56Z3QRNTHUGUE5IEWGHF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Replace DMI_EXACT_MATCH with DMI_MATCH for Lenovo SKU entries (21YW,
21YX) so the quirk applies to all variants of these models, not just
exact SKU matches.

Add ASOC_SDW_ACP_DMIC flag alongside ASOC_SDW_CODEC_SPKR in driver_data
for these Lenovo platform entries, as these platforms use ACP PDM DMIC
instead of SoundWire DMIC for digital microphone support.

Fixes: 3acf517e1ae0 ("ASoC: amd: amd_sdw: add machine driver quirk for Lenovo models")
Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---

Changes since v1:
	- Updated DMI_MATCH to replace DMI_EXACT_MATCH for Lenovo SKU entries
	  (21YW, 21YX) to ensure the quirk applies to all variants of these
	  models.

 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index f86d14adc721..0f21e5f64531 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -99,17 +99,17 @@ static const struct dmi_system_id soc_sdw_quirk_table[] = {
 		.callback = soc_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YW"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "21YW"),
 		},
-		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+		.driver_data = (void *)((ASOC_SDW_CODEC_SPKR) | (ASOC_SDW_ACP_DMIC)),
 	},
 	{
 		.callback = soc_sdw_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YX"),
+			DMI_MATCH(DMI_PRODUCT_SKU, "21YX"),
 		},
-		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+		.driver_data = (void *)((ASOC_SDW_CODEC_SPKR) | (ASOC_SDW_ACP_DMIC)),
 	},
 	{
 		.callback = soc_sdw_quirk_cb,
-- 
2.43.0

