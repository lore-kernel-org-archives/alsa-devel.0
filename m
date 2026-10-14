Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816D6CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:21:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 702BA6023F;
	Wed, 14 Oct 2026 12:20:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 702BA6023F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973265;
	bh=mwaNglps+dBbljkG17AxxS+Yzi4Sbnm88aSNzW5ZUrg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YN3fezFk8mU34NQwkNOGrQpFhf5MTpXwgagk9JuCaC30MuZ4FXFxT6644yqF7+fW/
	 pPJog+3w7IF1Gw28P85oiDutK8ppCdynkF7jAFSgUQcSbMElaiZeb9VxMlDL8s/DU0
	 CTCR8h3epnIforu2wuNbDZkEwSo8nud8vaBgvDZc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AF27F80674; Wed, 14 Oct 2026 12:19:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E5D2F80674;
	Wed, 14 Oct 2026 12:19:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C2C5F80620; Wed, 14 Oct 2026 12:19:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.15
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973181;
	b=jtNzc9g/2uAIE0BFwibv5hQBZYx+vA9tgim+KvjC77SE5t8aFrfOVTQD/CS+xG/owlBz
	 9Ji3rWvCtdfbLLzhKhkvHV+ForRa5F+aZDnC1ijaLHTEPbIyxbVaC2koNSjQF4UR6z/Is
	 XpJ+n7W346OXwiQMVqypEwV3Hdr442MWnVcEG+uvjysWiHI/kz4MrKUvhonjYd2ib1Xoh
	 0E1BbUU+cFhIZx3/6AL8DU3wPim/RJlEJFRz/MMUPXasQW8WilfIGEWS17bz58B07MiAm
	 lCu5C+v9XJ7+bq4njMaQCa2ju2cFPYG1e2xazCcdKsFdU1Y+bsvgdwtOgibNaSgzBbw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973181;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mwaNglps+dBbljkG17AxxS+Yzi4Sbnm88aSNzW5ZUrg=;
	b=OujQJRUj16UhJWhWGhb3sxjxM8S899qMMBq8pmLRKvkhskobuEWwkFlS30GHAHSYQNO3
	 KKaotfTN1iMn3q3wZTB1+IQp0ybtxZZoGhzPL+aaFI1OjQkMgVUgPuJ1WP7c8cn3LFWxv
	 w9xtUgFcZsf6GcUpccFFqTWSs21nny2+dXCNYiY3cP02L4+joLGdN9NBNZRHQ2g0GcTp+
	 +Ljv9Tdl7OkMMf1bBDj4S4zFCdTq7+Obvj6fuyJyuJ4k0vk5muQL6rS46sqvYnT2B4ZNw
	 gdfcN5F3hlH3VeOgRXVCkFLui1u/OmoK5YsZjPYMU/RQnoS4ZWJZNhCxeLAux57P+bg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BsPt84io;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.15
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011015.outbound.protection.outlook.com [52.101.57.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 134BBF8060A;
	Wed, 14 Oct 2026 12:19:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 134BBF8060A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=BsPt84io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n93j7DnGHbxF358ZQ5VJT2IDGOW1leswUTApdVlM8QfEX5aOL8X2J0dvef0zZ3t82lxodIJaeeQDpXtFSKLTW/KR45b0p6kBNjKf2YHnTnRy+ZAqvv3YcsYBjfpSLKmPXYBAT64vuIUPKKa34m7GeVM2lTroRsbk/R1PClqp18gcBovlJSJ/gFsUf55gdO5C+crNFrV+NLcFDlV5TpxLoN+O+2522Vy6WWio1PX/MBhaldTfkxojpwhdTTZpgr31TyGjw1ud/VGVwc4haLs+8UYndgMpPRQqfDyAj2wQ6uMurSAo9JRLb/xNC43F/gIjHuXZHAJsa6bFjeu1a2BHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4LYA9DVKQ//XspoeU1lrtARSIA9xi5s02DewEwPAww=;
 b=P8WQZoHUimmsUtboygCNC6G+5EHwLgFwxRlpyHGLROeqFlsgMVqAKb7UTIDIq/IRX46T0FeQHMQ1NrrYw8rChp+he09cra2l+MoN2u+PJYri6+l7cp/Du0ToYVr2BKhO9+FYUHbnBGrpaePt9ykz/NXgyHS4Xs7IOywahqXGFrU9vKhVC/j2YaJWVnKfdP/Wv9ZnOs5xyLJJ5iNzyB9So4N3z7ZfFtiP6assFJsuPCYA25WsyRlwzqfgJrAJc32SFGdMBlqumqAA8Hsj1Q4Uk88evCmcQUEfOx6Nv2OLCopVC+hZdbPt6lX6mZjZ46ZhT3tweAO9Qzij/TSnQ9fRgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4LYA9DVKQ//XspoeU1lrtARSIA9xi5s02DewEwPAww=;
 b=BsPt84ios428e5nt+6iZyZdXD5f6vwEJ0HQzcXvVosO67qfP9W46IBBuXHSf7FQYwHpQhBDnKhcevfvkSVKC72alrwWedbDeKHbwyQryo+XyAjo1aAM14dlsecIpucWJsl2S50GxYVmRfREKap70hvW9vrt3niNUUzIFyLg0pfQ=
Received: from DS1PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:458::18)
 by SA3PR12MB208015.namprd12.prod.outlook.com (2603:10b6:806:517::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:19:34 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:8:458:cafe::6b) by DS1PR06CA0005.outlook.office365.com
 (2603:10b6:8:458::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 10:19:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:19:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:26 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:25 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:21 -0500
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
Subject: [PATCH 03/13] ASoC: amd: acp: fix PDM1 quirk and PDM controller
 selection for ACP7.B/7.F
Date: Wed, 14 Oct 2026 15:46:22 +0530
Message-ID: <20261014101817.1240200-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|SA3PR12MB208015:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ef264e-0fa5-41d3-4311-08df29dca3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|56012099006|11063799006|261009223027099003|260925022911599003|10067099003|260925021311599003|260925021911599003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	StR1vAOETj+LrkgH9Ip06muS1k/lzUbX7Iux9ukExiajhJHTY577NbLnniCiSu1/KDoI3aITJoagUT1BvaM5H1O0+DTY28k/uVJrtW0uSfGlzRCGtUqzbusUtA8dokOCzSq6u7JW51rZ04x90vGRfGpg1ftgEDSEFPQhHvAXCqv9kdgPCgngqh3ckFiRX13Jr842kG4UJFhAn4UmJVRHoWz87yYjTSYIn8mqqz8ybwfXAr5c2DD5Dl8mJ8lgZGGqxzGxL6EioZA6AgLlDQBDEQoz8AdxfL8dul9FU+2RqztpppTX7/KDUcWoX7s/snfnLjF21rZXt7C8ZVNeBpao20jqQzRWQwtejfXIHZCi07LJgUfY+lwHSgVwoDWWaKI53mfN/N1qYSL2t0Fs8PpvULoQNbuW9zba1TfldHJXuJaWB0gl8hIvPQ6X+4kzXW7yj9EVthSZ99w2F733zdxWgVI/mxxeEDTMg9rH+d9VmaAfT53e0Mk1yihLAzj30lo0IMESb+rOdLnBpr/URf5caZEP5781/63T5bHeFsY4KcSxa5jSxAqkXiL3EygTPDCgguOy6Q063YRHd+wIGLSIq2fbU8UV1dBHvumwLnZ6PYHxMgisRelhW4nixnQiuDwX2P6uvr+GV5cmbRbY+hPIo2JL5Q+szvMZohn6C+9iPtlcFCy5Fi9FkBk0c+4TMWS5VoUEsGmRXmy/wfN50st09w==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(56012099006)(11063799006)(261009223027099003)(260925022911599003)(10067099003)(260925021311599003)(260925021911599003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5AnrI2QFAE/0CjCwQyza0SU4eAi2V+W9e3U+7VBoCBiPfpajS4kWmV6Tpl1ZRgsh8+flZ1KOcD3tdKbtu+w5UYH6DsE+fhcVXTQ99+46giIX+OWSzFhHEgkY4CiWDdRMjz5ekjyAfXHsZcj2JLkAeb9+5IkIG3nZ1KPLp+DIzeZqGgEaRdGa7tcypqjbxocc+Zz/LUn/cZT65n1o5rXUiUHLz03SvAtT3ykMWCynXwVDQsidIuY8i3bZlp44gZXnTO5OtknKGpL1ZxG7AR4OyfTWiI89bWJG0Y0jIFtyD2DaeG9JxqXRrruN1miU7GDNH7MFDBYwxcVLI42qtBc04GI8WWay0a1Lf/lqWl2OwuPTmds4a+p6NE7krYxRs61BiNHlJgSFEEXdkKy+rNnryD6wIHtiv7zrdwaZalq0Fr6Uy3AkylYYWEtOjbECk5tm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:19:32.5511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 90ef264e-0fa5-41d3-4311-08df29dca3bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB208015
Message-ID-Hash: FKIJS5ZVEV7VPN3FKS3VY2XVPJXOKLRS
X-Message-ID-Hash: FKIJS5ZVEV7VPN3FKS3VY2XVPJXOKLRS
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FKIJS5ZVEV7VPN3FKS3VY2XVPJXOKLRS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The ASOC_SDW_ACP_DMIC1 quirk was evaluated before dmi_check_system()
and quirk_override were applied, so the pdm_sel fallback always saw
the compile-time default and was effectively dead code. Move it to
after the quirk is fully resolved and restrict it to ACP7B/7F revisions
where PDM controller selection is meaningful.

Since ACP7.B/7.F exposes exactly one active PDM controller, use
else if for the DMIC0 fallback: check ASOC_SDW_ACP_DMIC1 first; only
fall back to ASOC_SDW_ACP_DMIC (DMIC0) when DMIC1 is not set.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c   | 44 +++++++++++++++++++++++++-
 sound/soc/amd/acp/soc_amd_sdw_common.h |  3 ++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 6855141293e34..2fb5c7ecafd8b 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -265,11 +265,31 @@ static int create_dmic_dailinks(struct snd_soc_card *card,
 				struct snd_soc_dai_link **dai_links, int *be_id, int no_pcm)
 {
 	struct device *dev = card->dev;
+	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
+	struct amd_mc_ctx *amd_ctx = (struct amd_mc_ctx *)ctx->private;
+	const char *cpu_dai_name;
 	int ret;
 
+	/*
+	 * For ACP7.B/7.F platforms the PDM controller is selected from ACPI
+	 * acp-audio-ep-port and stored in amd_ctx->pdm_sel.  Use the
+	 * matching SOF DAI name ("acp-sof-dmic0" or "acp-sof-dmic1").
+	 * All other platforms use the generic "acp-sof-dmic" DAI.
+	 */
+	switch (amd_ctx->acp_rev) {
+	case ACP7B_PCI_REV:
+	case ACP7F_PCI_REV:
+		cpu_dai_name = (amd_ctx->pdm_sel == ACP7X_PDM_DMIC1) ?
+				"acp-sof-dmic1" : "acp-sof-dmic0";
+		break;
+	default:
+		cpu_dai_name = "acp-sof-dmic";
+		break;
+	}
+
 	ret = asoc_sdw_init_simple_dai_link(dev, *dai_links, be_id, "acp-dmic-codec",
 					    0, 1, // DMIC only supports capture
-					    "acp-sof-dmic", platform_component->name,
+					    cpu_dai_name, platform_component->name,
 					    "dmic-codec", "dmic-hifi", no_pcm,
 					    asoc_sdw_dmic_init, NULL);
 	if (ret)
@@ -378,6 +398,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 static int mc_probe(struct platform_device *pdev)
 {
 	struct snd_soc_acpi_mach *mach = dev_get_platdata(&pdev->dev);
+	struct amd_pdm_pdata *pdm_pdata;
 	struct snd_soc_card *card;
 	struct amd_mc_ctx *amd_ctx;
 	struct asoc_sdw_mc_private *ctx;
@@ -398,6 +419,10 @@ static int mc_probe(struct platform_device *pdev)
 		amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
 		break;
 	}
+	if (mach->pdata) {
+		pdm_pdata = mach->pdata;
+		amd_ctx->pdm_sel = pdm_pdata->pdm_sel;
+	}
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
@@ -419,6 +444,23 @@ static int mc_probe(struct platform_device *pdev)
 		sof_sdw_quirk = quirk_override;
 	}
 
+	/*
+	 * If ACPI did not set pdm_sel (no acp-audio-ep-port in _DSD), derive
+	 * it from the quirk bits. ACPI takes priority: quirks are only
+	 * consulted when pdm_sel is still zero. PDM controller selection is
+	 * only meaningful on ACP7B/7F platforms.
+	 * ASOC_SDW_ACP_DMIC selects DMIC0 (default); ASOC_SDW_ACP_DMIC1
+	 * overrides to DMIC1.
+	 */
+	if (!amd_ctx->pdm_sel &&
+	    (amd_ctx->acp_rev == ACP7B_PCI_REV ||
+	     amd_ctx->acp_rev == ACP7F_PCI_REV)) {
+		if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC1)
+			amd_ctx->pdm_sel = ACP7X_PDM_DMIC1;
+		else if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC)
+			amd_ctx->pdm_sel = ACP7X_PDM_DMIC0;
+	}
+
 	log_quirks(&pdev->dev);
 
 	ctx->mc_quirk = sof_sdw_quirk;
diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index 9e4c86bed3003..86c8e38a19bb1 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -30,6 +30,7 @@
 #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
 #define ASOC_SDW_FOUR_SPK		BIT(4)
 #define ASOC_SDW_ACP_DMIC		BIT(5)
+#define ASOC_SDW_ACP_DMIC1		BIT(6)	/* select DMIC1 controller for ACP7.B/7.F */
 #define ASOC_SDW_CODEC_SPKR		BIT(15)
 
 #define AMD_SDW0	0
@@ -83,6 +84,8 @@
 struct amd_mc_ctx {
 	unsigned int acp_rev;
 	unsigned int max_sdw_links;
+	/* PDM controller selection, copied from amd_pdm_pdata at probe time */
+	unsigned int pdm_sel;
 };
 
 int get_acp63_cpu_pin_id(u32 sdw_link_id, int be_id, int *cpu_pin_id, struct device *dev);
-- 
2.48.1

