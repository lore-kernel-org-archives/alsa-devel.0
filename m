Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4935DCC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:20:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E629060373;
	Wed, 14 Oct 2026 12:20:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E629060373
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973214;
	bh=M3x0JTQFNPZzlx6rbaZXMCAaYDEAm+Mc22jUoo2tQUc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TgKsAdh/a/vn4p8UyoSTn6d4pNuQJU44SWFD4nvSgEHsr3Z8a+qoUB2uBVxFai/sk
	 n9fd1ultPlxjcj0u+ID8NO9YW5wr8rCq0/asoSxcGZxCGze4lpizhPyOwcLYdjvzsg
	 03ZMitwo0PLipT1oGHqsS1c2CFmMdSQDNNAwP53U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7C76F80603; Wed, 14 Oct 2026 12:19:39 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 73613F805ED;
	Wed, 14 Oct 2026 12:19:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5A465F80552; Wed, 14 Oct 2026 12:19:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.60
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973170;
	b=rV8ehnYAi8LXE9DhJBsDA5UhzEN2Rb0t6qgrkLdbT/YdR3CD3c8gMmiUQopzPsBhmNyZ
	 EcssaFT0+x0gXjuay2up20Zfu85uDShptSAEiK+lSl+pknij3jRqlhKxX3MtmBI2mHLOI
	 xtFyGFc4xE0z2+nxPIsYl2JOZAyAOSlYOzfP6UMKXgI8Zy9E+sWD9qIx1HBM5Q0bKFSYR
	 uaD1+1o8wLfF/Uy3vPGGRUUNz/DfmfDLBWiNyZX46rRVHq+QcJYtAEzmAS+AUtWFiszCk
	 HP0i/bF928cG72Ezjfl8zjQt44Cp/UTKOSuXO8WR926P6reYYWNueaBOolHGq9PDhjA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973170;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=M3x0JTQFNPZzlx6rbaZXMCAaYDEAm+Mc22jUoo2tQUc=;
	b=Ueq6BvA59srQzuJqCKtUqKxfMIGKInk3wMOIQIyhYhD1JfRTt2gYcUw5pvdw5FSNa0RF
	 1JFdNZ7BWJwq/ONKOuGIrRZPnbjXarOxhN6bUJzlJs38SGwrhGeaMKAtyRxA5D+CylB8k
	 Pouz25IFW6n83qiOncRjeg4lPlBJcUh3vMsSPnJ64g8L10OepxqiLKjsYUB2UovcWjukP
	 Nx0u+Qhdi04SJ/AXz6TRvk1WctY6AbaCCKctw+gExEZSZDgvsQ+8vXJRY6cvLBLupHuQA
	 tH/RiQsyV2e3aRJ9yqqJGT3fr21Kv4T5oFoa6rAeUbmZfAFVcv/v8yNmCESEik/MzcQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Awmwf5sM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.60
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013060.outbound.protection.outlook.com
 [40.93.201.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 06B1CF800E4;
	Wed, 14 Oct 2026 12:19:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 06B1CF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Awmwf5sM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=biNZIct0b+ukh1yKl1ZuJI1Z6kPR5ifPM8Bn71r7DAfl24/bp1/xk2nKfCOsKVlzzYPI8PFwc3HL0ESj4kk33MRZwAKabebjI2SQTd3A87y4iX/WL9VGChvAEi3rfz4JNkUbHr4T1m0z3JqbB9whqV1QWRoCypzvCgOPBj3asjblnNE5x/IQ9CW06XOHGjSqLDWhHmZk9i3pE73VUI5te0ZgiZpdvm/O0oT4+wVaAk/BGnmpDp623+nQlkXl5xvVa3eVi6zb5yF/VNgRa019WMXNkL0Rr31Zl6GspMwjZaazQug4GpXOt69pL5tbgst0FIhq2p/rHsKVFH3U3liZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LRNJpbQ+fV3P8N+iK+VOukEtIWc5Awe0abppaetwas=;
 b=tPpEV7/+P5pgGo578R4wUa2/THrjYVMPlvQN4jR2awDPM1qw/wbZX9W6MFvidIWggoM3kfgpAd2pT52gvHpuRh6sHGJFOGz4BNKMn6Z0f4e/i7ofLdNic7k7DGEkXXOT7GbI78qX5ca8fWHTko5PcgJK9KrMdq61OBgMIC08lGu56M82ifs6U9qYj/xmOLHMwPqHtsSXNPFC2YRtNQ8omDRehmqcEbk0Z+BDt/1iWUVFmr4Mn6pmgEbqXs6ULdsPL3Uyh6Y6F2MoCepP4kAncx69bxgJXEcS/z0XldVnIPinVDh+S8r1M7iaP3KYjFRl1M2+q2zsX9wa5xYRiZ5wvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LRNJpbQ+fV3P8N+iK+VOukEtIWc5Awe0abppaetwas=;
 b=Awmwf5sM9D1mCaxlYy/crcRH8UmGseKHibf2cVow76MRW4eycnNzM2RSO5qRCpsSCAzobIMr2UpoBhjGK2bpGDBoXUOGLrzRvE3GdK2Ug23WBBOYsvZzQeb0sUv9CbosEwzhutS1F6Wl0me1xq9WExbk7rMB5ui5gtuqbXW/c5g=
Received: from DS7PR06CA0005.namprd06.prod.outlook.com (2603:10b6:8:2a::20) by
 FT1PR12MB050200.namprd12.prod.outlook.com (2603:10b6:170:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:19:23 +0000
Received: from CY4PEPF000392D8.namprd03.prod.outlook.com
 (2603:10b6:8:2a:cafe::9a) by DS7PR06CA0005.outlook.office365.com
 (2603:10b6:8:2a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 10:19:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392D8.mail.protection.outlook.com (10.167.247.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:19:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:16 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:11 -0500
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
Subject: [PATCH 01/13] ASoC: amd: acp: add ACP7.B/7.F SoundWire link count for
 machine driver
Date: Wed, 14 Oct 2026 15:46:20 +0530
Message-ID: <20261014101817.1240200-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D8:EE_|FT1PR12MB050200:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb59ff0-6f46-4433-33be-08df29dc9e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	FbRqsQTu+KeKJ2ms0pTSfAlKLdvqdcoVdqe0RZDUJ6JZAkGrELr5tj1iaBeyw8CERj+NFR4o7p0pARQXoLJI+lpjhgJPchUfkZGxciKU0wOjLx9f5rgP5RJHzMY2Ci7QkpKt70fpF/qhLpztwM6jg1tB+pBa607axDTFnblVcQ1or56GKmZ5m9XvPIlFE4ztGDs+I/vJqpNYoFCLrZ5xEXFanDNxhiPNYjdQV/SD+wqtfNnkbD3rNCPj0SB+uerjMru2iQefHVJsLyERJJ2iToOdNRPMUTFQYsA1/BZ3jSVK1yIU1fKT58oXlkxbebPTAeLUd4UcaRnqrRC0FqPYnDC6tF/zeD1yP9DfEFmEVF+lJjLjH8xyD+S0CKwGYPyhNd83QltsKfbdYJpcmfcLTKhSkWuwwO9IORhM1y/xaFPoJN2UMXomo/G3lwDAYGZTvK99pT9coBDwujIcqqxU4qOMlcEWy6VD6AHf1BUvlKy7k0WS1xqeovNI+ajMcESl5dk/aV+o9dFk8h0SyoUYcp9nljGP0pxPgAYn7tYQRJJTmlKr+xLXJ3QaotpfLKgILIzpEYvO4qHh47O1YFU2urZdwCDlWyEaEAoVWKkTyeUlgAV2UahYJBzr16Y6BxMPRZQx2w+ABfYIuC3LhPAZ3hFQt7aVYtwyCvhG/o1AKrqxQ03TdAt4SA8Jimi1kxGc
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	lwn0BSYqHaDq59Za0Asqt5HuOrATOcWyzclOu0og5ttrDVdkhLPoXISAtMWgEw8oyPBmb99G4ZPzehfTV2bZBp9sfxUL6DIJhE8JyCIzAt2Xh92VCGM7CzeBEhGEG2ARH62EdTUfk9KQ2anx2xnMKj6oYSqZs7z6Ap1b5IQ3P1OcZ5KeHdR/7w6HEVYDBIpQWL8yUpyPc0Ph2B74HS+Ji0sgDSf3e2ZrGIF7FGbzf6JinyLcMDoOmAJzDjpQrfQXOvIvxypux3iH19aCDcjcoUo7pX6wte/NSNFlyl1MPHt0fH0eZuwk1scIaJ4Ar/frCPm/DdAGWCIeQAKLvdGOAjWZYjpviHisVapCAoY4CFdjPvUavyxZ3AOQAtQAdHQCPuirhnECcCeX01voUF8QDk7BV4eIK4H6FSoZ6th5qn6coy5sMY/M6wAensZndJYN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:19:22.9416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cbb59ff0-6f46-4433-33be-08df29dc9e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF000392D8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB050200
Message-ID-Hash: QJAGTKHH2APCVZHWS4TATK3VFJQMOUMR
X-Message-ID-Hash: QJAGTKHH2APCVZHWS4TATK3VFJQMOUMR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QJAGTKHH2APCVZHWS4TATK3VFJQMOUMR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ACP7.B/7.F platforms expose four SoundWire managers, whereas earlier
platforms use two. Add PCI revision constants and ACP7X_SDW_MAX_LINKS
to soc_amd_sdw_common.h, and set max_sdw_links in mc_probe() based on
PCI revision so the machine driver validates DAI links against the
correct manager count.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c   | 10 +++++++++-
 sound/soc/amd/acp/soc_amd_sdw_common.h |  3 +++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index ec3e1f5f1052c..ad8a024321dfa 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -382,7 +382,15 @@ static int mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	amd_ctx->acp_rev = mach->mach_params.subsystem_rev;
-	amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
+	switch (amd_ctx->acp_rev) {
+	case ACP7B_PCI_REV:
+	case ACP7F_PCI_REV:
+		amd_ctx->max_sdw_links = ACP7X_SDW_MAX_LINKS;
+		break;
+	default:
+		amd_ctx->max_sdw_links = ACP63_SDW_MAX_LINKS;
+		break;
+	}
 	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index 034c9ab6e4ea6..5b9410eff56eb 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -17,12 +17,15 @@
 
 #define ACP63_SDW_MAX_CPU_DAIS		8
 #define ACP63_SDW_MAX_LINKS		2
+#define ACP7X_SDW_MAX_LINKS		4
 
 #define AMD_SDW_MAX_GROUPS		9
 #define ACP63_PCI_REV			0x63
 #define ACP70_PCI_REV			0x70
 #define ACP71_PCI_REV			0x71
 #define ACP72_PCI_REV			0x72
+#define ACP7B_PCI_REV			0x7b
+#define ACP7F_PCI_REV			0x7f
 
 #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
 #define ASOC_SDW_FOUR_SPK		BIT(4)
-- 
2.48.1

