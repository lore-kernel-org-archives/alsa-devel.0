Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88EDCC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:22:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CCA5460233;
	Wed, 14 Oct 2026 12:22:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CCA5460233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973332;
	bh=mGYrXjN+WO3LBMuM+V28Ee7AMCgohSZmMmGapxwNb3w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=SwQTPEDaMgcsyiU09603uF5OJ8m2qVBwzjzZ2JYuHcQXH7uVhRvk77R1zF3XuE1gG
	 DRsNq2Ufy6mKCcZtTD+zznmP3l7llvBaKTwRky/HRooryv5y0Ae3qJL6dVWDw4mAHD
	 08qDHH1IXqBhf5w+hmZWwo1Gky/boAJrjf0yCsHY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0F160F80707; Wed, 14 Oct 2026 12:20:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B3304F80714;
	Wed, 14 Oct 2026 12:20:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 583B0F8068F; Wed, 14 Oct 2026 12:20:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.69
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973196;
	b=ZKblc0NHet2cp0e63tGRzR8P94jjhtPelFM7lsQmQ4st/37VcIede/uERcVkh4WuCVTm
	 IywJxPv7Vt4McP7ZbOA4oGnoxEcFSOn9bCIO5naHHni33vjWsIrwPPILax2Nq/i/X0SDB
	 +6154hTl5/jFO6nmMIfprlDJe6NNmRpQaMhgf7uZXG/MyOiqMLXjYEYiRcmDXpM1MDLa2
	 V9kzYTtpDJkUR72QG9eJKi+wsaDtZleyA2cOTPU5sYvuja6TbSHe+iHUdimq27bkX5+2q
	 QqW5j6GBu9D7Qa93lVAq6plbRI1CeZDQjgpfZ2aoW3rowlV0yfjAOYoRKtTgHhRYukA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973196;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mGYrXjN+WO3LBMuM+V28Ee7AMCgohSZmMmGapxwNb3w=;
	b=YjQMTTX/NJGGV7HBzYJt0yr8onV3L2JJ9PfE6p0S7TKW34sPG1O7d9FJtIz27fpXmqA8
	 yPSJ4vcmn7ANYjoBD5FvxeM25KBX0gjV789ViqrT5cULVQdinu42SkdOOryq5HjAMBOQB
	 KpINmdxgpiBM2Y1g29g6PG5+aPT0uq0h6HqWoiKW9rITHMr9Xh/KAJNcm12hyLy6FZvF3
	 773V7e+Lt3qNqenGtT6BrzvFjzvrZ5YKMLOuXP1Npw1PSZMvasfWur/4JfkjC7wgi8EAm
	 Q4JDJGBZYvICtfCZqI1vsrkR2oMlhmfOW3QbO5K4bIVwsNeby2eFMgu7M1PYLR5Xf8g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dkzivbb4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.69
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013069.outbound.protection.outlook.com
 [40.107.201.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0B169F8068F;
	Wed, 14 Oct 2026 12:19:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B169F8068F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dkzivbb4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkRYFIu9baS3vjabNoykuv4TcWM+V9jHjUMnzLg2F3nZLLq9DUYciMHRSi8VAT2SaBxWG8GURDsl/LhHz9qITq25nzUVZZPyqpYCgnf2/KOwPjQoF6JRO91VMdoaHBzvEKCQmA5MaSnDs/54ZymljxhinyK3qt964hpViXXjk+lq503AHgwd8xOWx3J6SrdH8G4dshj9Jl8XxX7AnFQfieOJ/GLxFn0kxpf4qkAP7LvpWAE0/A6wEUQudQMNsqV1XQBOQh5/zFpTYCTafxYbwEGDiIT+EdvwX+xdKjG++Csz7RwnOIGNFJFlJ6YmLKGeHbJZUt9jBN0doEbksqcq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aGC454MiAbMz1mO+Ox+4MMGJ5dNfq/ZqrP3PcnG9MQ=;
 b=tr+tN8sKDj0fuDCFVGrRpNvThAnXBKyfSrwsise+hCAoFQQcyW1yoR5N1/xWCDxAVZoAQsfFp3DoFT90YTDJRyxL+7uTL+qsq3M4GVGXsIZkfyFgR+QkwBQgrEpV4XJi2FPtvz4aj/iM8beX3HtWofw8NOMKDxG59mynF2SZTvupwzRtu4o73z5kO8BfTMqQWSHKzukZ9YBy25VS2W2m2IX5jUuFq46NchxUP219ShY7ltdsgMgfpm4Bkb1e+0spcr8WF249i+W5+Kw3s4qAofYeYVehGDq2DFubhSdZBkN6yit6H+du+p+1b9YIFVTLCT1LZ3F5o+WZ/oYTJnyD3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aGC454MiAbMz1mO+Ox+4MMGJ5dNfq/ZqrP3PcnG9MQ=;
 b=dkzivbb4QyCSrOtNFvAFNspgLwFWKPY47mfskXfmRqmZs5ajNk+1gUq9HXAG+JxwXXSEWpP2pWq13K0DWZN9rUQ49gh0jATlX0xUPDTsqPGtOTOtBeIr40KibkGJyjUnEdrw8W5b4Ot6bDHxyP9t2RcGteXrTVQIyL3X1m05xl4=
Received: from BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::33)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 10:19:47 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::aa) by BLAP220CA0028.outlook.office365.com
 (2603:10b6:208:32c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 14 Oct 2026 10:19:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:19:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:40 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:36 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH 06/13] ASoC: amd: acp: move ignore_internal_dmic gate to DMIC
 enable condition
Date: Wed, 14 Oct 2026 15:46:25 +0530
Message-ID: <20261014101817.1240200-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 105e7164-7486-4423-b588-08df29dcac23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|10067099003|261009223027099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	YOUJ8F/QPDDszZj3XHc4wMLA49ZD0i4VAm6pgALle0kEmQRejs/X81zZdbgum2s0kty+Bmwmn6jG1B+NyXaqqMNAsQFLbuAPjnoV8CLBO1HanezT5VOuO3OVNu4joULamG+gjdzvUsO6pcEZKnQrdJkVRlib+y/sSFtwMqud5YTBBKzwgQcau+MjwLMO/XFjfjn0wzBhN9NrziXSPJS5YcyJJz2UrCOMeStBlSpIa16NzV18QjhkJxD+1SN6W81mrRTdJ4wFQxbR/5cpSpyTt6uWDZqTDr4v/Eu9yNSDGEMFPcIpr1sV1aSnAoJxxZpYmiSaqiMGhV8N+j6t3OPGTcN7zxxWH+Ja8Kg0xx/cKTIeULG4VnREDWM+HBuUvGRVfLOM2ZsQekpnUEZWxh7iMwaJKeu1ysShXgJ9vbQAUgdha6W8saV21PWmhhqcOgaFmaDQKdQLnWuwBX2itZKS4tbhs2f5C/KbCaAw/n1pWlymDxzZGLFodxrOZIfEyuFf6oad2YbZSFlMX77xyxLjqYBebhlS6eH29YNYB3QCngqzl0xEA4PeoJ1EZhjbh9d+ewazDL8ow5TOP0fo7fOtsKYhG9EvckHfoOs/SXfvHoJ+jAPOQDYD467FyBTuz/QV6/Zj62vq3pHwGmdtXp3XmAXxFkBoZj75v0nVv4M+FrlXihgjWYJWnFnJTuN88TvNy4/cy1gD57CXsnSjbp5qdQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(10067099003)(261009223027099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	VxT9b2D2xbw1OSUND0nnPQTw9/MNTdOyIX9xjUD8nuTqvso96BnMEydMilJnUQuq8NIvZo0yTLP530R5Sy0yxQiHu63nrEsYh2+lOmia3QbfV9bFccR/qIXoQsl27smbkoJRqt++OEfaSrPL1zMuGsWUltTnSQqKF7Xf+F/Sa8r5TefTKnYgzs2UqzrSW1A+To/NpbEPZnmtkRIf765j1fuMmMJoat7l255Hqeto5AVDp+udIGAnvcQceFkWbaltOQ9pVUgK+l0d92W9FMe5ohMv7lAjhJytE7uIFd7QGNVjT/cSR/TaYwlA2woGYhw4ef6T53wwmtBIE7d+cQhjq6T71Rx8fuuYQd652fLSBx6yUxerjE4LoY4dv00ZJNfImC1+SDc8lsUIROnOo10YEjGeZy76HHn+Iytv0lqNfQTRvO7sQI5jY8H1RKN7SQrZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:19:46.7035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 105e7164-7486-4423-b588-08df29dcac23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
Message-ID-Hash: FSYYBPVAB6QJD7U5XJMTZ4QRB3GFDCSA
X-Message-ID-Hash: FSYYBPVAB6QJD7U5XJMTZ4QRB3GFDCSA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FSYYBPVAB6QJD7U5XJMTZ4QRB3GFDCSA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Move the ignore_internal_dmic check from inside the dmic_num > 0 block
to the DMIC enable condition itself. This eliminates the dead if/else
inside the dmic_num > 0 block - when dmic_num is set,
create_dmic_dailinks() is always called. Demote the suppression message
from dev_warn to dev_dbg since ignoring the ACP DMIC in favour of a
SoundWire DMIC codec is expected behaviour, not a warning condition.

No functional change for platforms without a SoundWire DMIC codec.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index ac4c9e852f671..1207e35ffb581 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -351,9 +351,13 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	sdw_be_num = ret;
 
 	/* enable dmic */
-	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC || mach_params->dmic_num ||
-	    amd_ctx->pdm_sel)
+	if ((sof_sdw_quirk & ASOC_SDW_ACP_DMIC || mach_params->dmic_num ||
+	     amd_ctx->pdm_sel) && !ctx->ignore_internal_dmic)
 		dmic_num = 1;
+	else if (ctx->ignore_internal_dmic &&
+		 (sof_sdw_quirk & ASOC_SDW_ACP_DMIC ||
+		  mach_params->dmic_num || amd_ctx->pdm_sel))
+		dev_dbg(dev, "ACP DMIC suppressed by SoundWire DMIC\n");
 
 	dev_dbg(dev, "sdw %d, dmic %d", sdw_be_num, dmic_num);
 
@@ -384,13 +388,9 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 
 	/* dmic */
 	if (dmic_num > 0) {
-		if (ctx->ignore_internal_dmic) {
-			dev_warn(dev, "Ignoring ACP DMIC\n");
-		} else {
-			ret = create_dmic_dailinks(card, &dai_links, &be_id, 1);
-			if (ret)
-				return ret;
-		}
+		ret = create_dmic_dailinks(card, &dai_links, &be_id, 1);
+		if (ret)
+			return ret;
 	}
 
 	WARN_ON(codec_conf != card->codec_conf + card->num_configs);
-- 
2.48.1

