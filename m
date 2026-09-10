Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A73C79FBF
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:20:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 01A96602C0;
	Thu, 10 Sep 2026 18:19:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 01A96602C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789057207;
	bh=4cDhTGsyArA6UGmdwFEw1+ENEZh0SWmGNO+1DXaqZO4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a8JSL+AwVXkoa8rnqKgS3Yjd34nhIP+nAhtsBCKROG+ZtBV9xtwAdRnUU5/4o0izP
	 AoQEXbj28YbIlPOgo+9vGhwy4EhfZKF0dr52XdFxDlm1Xmh8KQyz8fi0OQ3DB0uZTM
	 zp9aTcdyFprI4Xj6x/v2cTgA0ts5Q+1fXYUAsi8A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D17ABF8065E; Thu, 10 Sep 2026 18:19:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 6DC51F8065B;
	Thu, 10 Sep 2026 18:19:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CC447F80610; Thu, 10 Sep 2026 18:18:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.43
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789057134;
	b=YmStq/eelEC2CqRYZ07kS/cWbT1P9CiM+J0Qpgels4vF6TIm3BWZ/s1276eK3zLVkYRx
	 BcSzy03yRqP9gqjJCFq1TBkIO7z2JCavkgYxAytHIHKaIBS5yv54JbHaBfHGx20eB94xW
	 5ny8Tah1IEagEvIX/1Zb/McHXcth9nCo+9uSo6zVmBTUMmYn6ZM1Yk2xd59RmAaetErev
	 aqNDREhUs1KseppPdjfhDh9FZcndgQDvkIrvOJyUZ+YhI8br5rN/hih1TSTRgGnwcBQH9
	 GGqu4CTaAlez3St87QJyRafl3w/ObkQRyxyzjMkG0IMtk25Lxqqoh8nY4zag9BTJs5w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789057134;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4cDhTGsyArA6UGmdwFEw1+ENEZh0SWmGNO+1DXaqZO4=;
	b=PMXmsJsbK3+xAMRqBB4FebqUZ7p/HHRMipKt3ZJ279HnQPX+CSKDBm7HrwtqvJQvmwdX
	 ebcLBU2gcfqI9e1xxOM4+yUVtUAjl2Km9pn3VSYAAt+vHhrqAk4e3obb4yPcEJvUcBs7Y
	 whLPHkmagA9ZQP+8K9NwxkyPwdCF6a3gGGKAOC3eI6wV9c3KFuJ1wXw0GEh2WjMO3r9D7
	 9AsHpqmIRqv5OUC6RE8+klNOpOPkllHzoQVsDr5nB+zEcx4PSAuqialoYDsx/+wADy7LG
	 FxnX7tFR2UPez2OTx9hkTauzaZYRUmlrs69gh/UXrS7Cdy7rMPe5hmUH9Jz5PZPlY/A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=B4T9PCU0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.43
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012043.outbound.protection.outlook.com
 [40.93.195.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3B0A1F805D3
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 18:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B0A1F805D3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=B4T9PCU0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lB9f5zxMkvRtOkEGbNrubyIl09wmxH6l6u9bJvfAEhNkRk2VrII0KhVevuZSh+dV8ZXoStrVRUdOpMo9TWJz6XaVT0uuAIbOSfthBFe2G5EV7drHdIyJlvhVhRYJgXG9Ccw4h+l8aMZsjYvKXQ503B4hNmpI0YhCa+FFlHfmnYTGD/bB5lnecLAdl32+qZotKMPnuCsI8FeN4YaA9hkPYwuPymKsHTshn6ttQgD+NUBEJ1joajHcI9K+IPHqp4+ICk8c7CLrGyZhsopgO7fWM+lF8S2wfrtuTdcBpQ8K02SkIsWsUZvV9O8tnDgEEwfG3ASwaRlPLsnJugBDwViNSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ii00OqlJeDRHIJZiOnnyAqSLyaWMCUvdJ/VQYw+oTdk=;
 b=vfhJB9gT4jI2/vFsdDas2mzl/ha02PQqr/9yxrytvPaci/qYiBzf1CUFtwNzO+irPOXHS48o/g6/hg4UkW0v/IhFuwOLVSQZMaxx9y9QKhTPmxEgHJqaLpk0/QWoqHh1x37L0Q0b4g1Cd6ervXI+5jvYima6pVPDhFXJT8IVsW0secnU/2X/fA0MdX1mJ2HjW6VbVQJdKcOoNVurj0KjrTjh5zVpYWdJan6BY8AnEwrzzJG8tlHifGGig/Tjx8VYjX6ALXOKunZJG5j8oGvo6Da37hNm/pQEBadVvBgGRljO/v2SLCYkbR6pqNdGnoOINRK30h8gFuJrLOsTZ2hZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ii00OqlJeDRHIJZiOnnyAqSLyaWMCUvdJ/VQYw+oTdk=;
 b=B4T9PCU0HiSd6GpQMvspnBlYSHDUbifD7h0Z2wa0mGXDDbX7aiqaD92KdAiwPTsVDK0GCeFJi0NGUup8IZ2dnmMklj8xKv+GkpJvkMg15XsMscVDIzN0BMcxymFm/g+sctPmxMnS4K+G9Z3R3nyj0Ks4NMHlrEUcIfvZXOonF4Y=
Received: from BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16)
 by LV8PR12MB9450.namprd12.prod.outlook.com (2603:10b6:408:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 16:18:41 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2c) by BY5PR04CA0006.outlook.office365.com
 (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 16:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 16:18:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 11:18:39 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 11:18:35 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<ckeepax@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/4] ASoC: amd: acp: refactor codec config count in SOF
 SoundWire machine driver
Date: Thu, 10 Sep 2026 21:46:47 +0530
Message-ID: <20260910161728.1452808-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
References: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|LV8PR12MB9450:EE_
X-MS-Office365-Filtering-Correlation-Id: 815e17bf-63f9-4bd9-884c-08df0f572d0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	wEdSF8oM3Af/01dvrkBuXzWPcknp6Xtnc1K3neFUQY8QFsSDhzN2SRE5P/Ai0IM5xgSRO1w3EWN0VFGoBPC8QGjI0ctyJxMY2ZxgYexgiiS/wveZfXZlm/UhGJrn5ah7WlbmwvqT9EmFU+yXbckvlaoZjOk46gNp28OUT7rbld+Z6hn5RwKF603ZENBNzYPXwXHBShcB2neCVIBYg2PzopbjpxDYTNy14PQjjA1yYb5J66fHvH2NIx4Jdp2q0szxBHOCKu7lTR4lpDnsMLSDiVd3L1bt+1TmM9XYTxuqVAxuMIVjIy54lTZoZWN6qvk8L3tm//ALLZ0Ayh5e5Tkh4uvg9N+v41j+F9thgw7CBv8h3hqj0Fb2OiQZiH7IspP44iKwitIn2qqQV3ITtly4DTtRmkpwWiGOWnYBZi1cL4smzU/c9MoksU53SW4EO/VLQzIlKq4vruv/FwWmN022/f9/4tBr6h+1BDEbXcV5h0M503lfJ+G6XcOVAAZnrP8EJRFp9tRVA2ZWyPjhA45Z9xpMb1G4DqNIM24BbOD0zSDq+HHYNPBNIeqtFK5vV0qRtmbhWvbAoETSj6Dhz7BYtCLQNtqMn7FJQPQLda9090HMz4r064gf/ePxHOZuRg2dc8fCkuqHHIxNvXdR3uCbRPP39O1lj5NHHT/U/UDilEAIhhqDJfgW8xb/TfEOkODMMBMZu04UHzrJC6drP2p2yQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	SQh4MdFEeVk7Dxe5isLg+z/nDvkmxG021QNLda3SBBo4b0+X/+UeRkV36coqqKLIE/xfXlgvkYsogxPVN7Fta2sUyrRBFVb2QBruBxgCNfsyWrFrC+KGRSFiuC6CWftmxYKUEE5MhviLTJjSo0pT+ripsdmsn//7jCcISqck24lbguXsvSl3pqSWvFQpDebeAwP0oe4fXftWe5HL5WDG9O8l0uR5IzBoY1eCad66iueoMir/SQchkhz0RBnRefjRSbEbBnm1tH3lEqjD1nSInVzLDswmr0uApYAeZBPpPuLSv07cM3CuDKc6ir9IQbBydu8IP/6w2sysNBuc/7vVJGyUdMyWPOEiDiEBtwHYg11CWWG8DDr85PWh/RiWfhGSvQZM5nuT5b8BkjwA7Fz+u2PLBLgILXA6bW3mVMa1JdFnq0KRNe2X1ueLtG2BNZZa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 16:18:40.0999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 815e17bf-63f9-4bd9-884c-08df0f572d0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9450
Message-ID-Hash: VLG5OJGCNZPSUYJFHXFTWYGRN4L4TEXD
X-Message-ID-Hash: VLG5OJGCNZPSUYJFHXFTWYGRN4L4TEXD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VLG5OJGCNZPSUYJFHXFTWYGRN4L4TEXD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

num_devs was used both as the endpoint count and as the output for
asoc_sdw_parse_sdw_endpoints(), which overwrites it with the codec
configuration count. Introduce a separate num_confs variable to hold
the codec conf count so the two values remain distinct across
codec_conf allocation and card->num_configs assignment.

Fixes: 6d8348ddc56e ("ASoC: amd: acp: refactor SoundWire machine driver code")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 6c74e67b134f..b7926967593f 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -286,6 +286,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	int num_devs = 0;
 	int num_ends = 0;
 	int num_aux = 0;
+	int num_confs;
 	int num_links;
 	int be_id = 0;
 	int ret;
@@ -296,6 +297,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 		return ret;
 	}
 
+	num_confs = num_ends;
 	/* One per DAI link, worst case is a DAI link for every endpoint */
 	struct asoc_sdw_dailink *sof_dais __free(kfree) =
 		kzalloc_objs(*sof_dais, num_ends);
@@ -312,7 +314,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 	if (!sof_aux)
 		return -ENOMEM;
 
-	ret = asoc_sdw_parse_sdw_endpoints(dev, ctx, sof_aux, sof_dais, sof_ends, &num_devs);
+	ret = asoc_sdw_parse_sdw_endpoints(dev, ctx, sof_aux, sof_dais, sof_ends, &num_confs);
 	if (ret < 0)
 		return ret;
 
@@ -324,7 +326,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 
 	dev_dbg(dev, "sdw %d, dmic %d", sdw_be_num, dmic_num);
 
-	codec_conf = devm_kcalloc(dev, num_devs, sizeof(*codec_conf), GFP_KERNEL);
+	codec_conf = devm_kcalloc(dev, num_confs, sizeof(*codec_conf), GFP_KERNEL);
 	if (!codec_conf)
 		return -ENOMEM;
 
@@ -335,7 +337,7 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 		return -ENOMEM;
 
 	card->codec_conf = codec_conf;
-	card->num_configs = num_devs;
+	card->num_configs = num_confs;
 	card->dai_link = dai_links;
 	card->num_links = num_links;
 	card->aux_dev = sof_aux;
-- 
2.48.1

