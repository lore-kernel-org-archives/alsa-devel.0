Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1CCC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:24:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ED67F602FC;
	Wed, 14 Oct 2026 12:24:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ED67F602FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973481;
	bh=RJf270KOsZqGtRTGmzFA0PRteiVrVwEYACiVInu4qUg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=eVijmf/n9ldEjP2uU9BeAqh8UrJBHSV56ewSygywUlYzzX2a052S8e+1dlnXMACOr
	 DKBi1aKxaLlrYPn0EvTg2qqjeCsbhWanaJWzejzZG0OAKNjLs7NHb7MaJJ0NWEZ7O1
	 vkNyZGD4mx7ezfAoo8oOkRf3ZMne8DMPUZnbs6m0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41DCAF80CC1; Wed, 14 Oct 2026 12:21:02 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A067F89610;
	Wed, 14 Oct 2026 12:21:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57DFDF80631; Wed, 14 Oct 2026 12:20:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.38
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973230;
	b=WiuQWa7Ks8u1Nfh6UykveOognH4/XMKOlm6N+qSLNENXIM5l1fmm2WAfGV4qBw6+f+Kx
	 ldnJkKIVWImd63QFYbrYyfz3iN7F7FLXxe28T02L9ger6m+IoE27fpSxx/hZBB8J/CaIW
	 YDkwIAPQ+l/ykDgT1brhyWuWe1BfJ5dgwZuMdaYno+eX4UPbXxvE44GT3xRK/z5AYKJjB
	 WMBmCaUg1A8A6jOUigyezvcC/3YWi/htk9fNbchJWgpBRB0LcZUNwZbikpmqDlUIjOj21
	 QLqfwg/CwHvP0bUzbtr47/wv6Uuh5egeTu26kl2zS0w07uAPl3L6EiA88j+GEWAjAPQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973230;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RJf270KOsZqGtRTGmzFA0PRteiVrVwEYACiVInu4qUg=;
	b=Beu8opMmKFGPQyVN2Ezwxe3a4v7InDBMrgTPPkE/qWCzCDAUorauQTFTEmfpIyxmsPqx
	 8EvC8GZ75noA9Nr6Id3iX2OuZd6C+2z1g7TIgx3TLfdmD4LlsMkhEaFbwqLMK/byygPsx
	 FM2m0ee9LgHoGYy9j3f6h3ldciWcMv2d+S9euY6h0vq4pO3r74EkM5hh4dOR9Ee5M+ULi
	 gRvCtrVLNetYuDxZH3GWKWVJ2gbJApOed3MpGs7ggo8Wniz10+V0TL18yCMDnXj6pjcyx
	 +03V4XS75QdxVLZJBs+zxMc0haRc+BFOgdO9Xz+WvLq1nRKeNClK/DrZReOC1fSY1cg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AYc3+mqo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.38
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012038.outbound.protection.outlook.com [52.101.48.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 68B7CF8074E;
	Wed, 14 Oct 2026 12:20:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68B7CF8074E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AYc3+mqo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UElvutDsEoU9X2xBYklGMRIILBsm6wVuayH1PlysI6C7J5nPnwUAirpLWlCgKdxIvrsRValmPP3MvsD5Yn52gVn5OoeY/lZqOH/49uLn5BBQULt/DQtPxGZ4UJygJNx0wYcIQAC2kAVQPa+5Ug8pVliErHLb+AlYD04Zw5+uQukCqdzTephuUIBAqhn38/Tc/bKYrGDsf4C+pSqqyR+f8Gh3pnuRMF39n91rXYNq/03KTeNctivIA3scO3PDrdkoJBgbc3Wyb8WfbT/AjrVzr7r6ehhngWWuvKBr9CPDNCPH5hb4rkYP9GliIwDnc37P+bQkDrlPmndUVztXnb1DXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk3uKBqqMdrXg51aR71N7qZGo68EbVXi8zWAHS1yb9w=;
 b=WOCM8+Ax9J1u4hr0SbQpa/LEN0zEXpDboNvwDmFV0Ndxi49fY5VZspbMKnnuzFo2icTJxs70vtUKEZp6jx94dYoM8yBDoD9cHwFHaoUBKcthiKfn55oiuUq1el7v9hRwwuNNPQ9ugxMeb5Zqwy8vkQxNZzKlKcIeDIqJ3ybykvSUl9QJSgYoDa8ZShdpKoT/vn21y+Kov6fk7Udf7MRo0quhYeMsQndpqecZriBkyAmbjmnBdOADozaXUVtZoDa4EA4dsB4v3H0qwF02JYDFxEPVwn1Ii82UXt0ZEtY6SS17fRcBU31PBXhX++35qeFZ1JApo7Py/+AG53hA9QATtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk3uKBqqMdrXg51aR71N7qZGo68EbVXi8zWAHS1yb9w=;
 b=AYc3+mqoe0Xie1wZnnxPaJCtqYa45DQsMjTzIZMS0eztcujEBmHo33K1QdR9kGI0JyI4UppQVElxIt00l4Kk6mM5wqGcUvN5N6faVVaVI+xFID104dfV1biZqx8z9KDmbu71MVydWPSsq00Z62BUB7R5rguAt9jN4q1T755B/80=
Received: from BN1PR10CA0009.namprd10.prod.outlook.com (2603:10b6:408:e0::14)
 by CH0PR12MB8508.namprd12.prod.outlook.com (2603:10b6:610:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:20:16 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:e0:cafe::aa) by BN1PR10CA0009.outlook.office365.com
 (2603:10b6:408:e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 10:20:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:20:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:20:03 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:59 -0500
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
Subject: [PATCH 11/13] ASoC: SOF: amd: add alt_machines for ACP7.F SOF
 SoundWire
Date: Wed, 14 Oct 2026 15:46:30 +0530
Message-ID: <20261014101817.1240200-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH0PR12MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 289594a0-a9d4-40e7-4ac5-08df29dcbd95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|261009223027099003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	YkQbGe4rthRBAFcqr6OyRiBW7QapYyufiarq66f0WN1stNf5dqgOQKCuSacJTnln539DR1qZVGrKio0LCG/p6rovvT83lG4gFec2gFoCT73FltqBk3x7YSMr2ELA1Qjdo6wS9aY5Tap3lSXEEAMOPr6TIWMAgfXSJDr800Peewojjsl3/BctUZGysYbeq/DzB3rZxauf96VJzrzGROIdtTQESjSABl3je0Fj14g3RAWQYBtJAng9MiA//dmbd5hndqi/o3cdT0nY1TgRrymadkFKcgYcvu7lJWqmGDZax34ZESUI9Z1gK8TqP6z8zI9fzAzaSHMFQv4keHz6AbsQayXwsIlDkbo2gW+UY3VNLnSMeYghIBEexGKGfz3X4Dn4l1MOimjKUyrirtsQhiSp0LBn+VbGBqjPrIIoeh6bgw4GxS9w4AkGiUhGbf5apKTqDwtqhBaAFUS+fsP//QEnw7o+YOcVztOlm7F0Oo2+Fmkks4GRuVwznzw6Uthw1hrijGh+aeftn7nN+BjMOrFobmnKNVF6YZkQlLaUaSPeLcZ5XgWpjLYrOyBK7qVQOwJrDFdRhNdUDqGXyl+DZjBZXaeRQhyAIybwtty7m2bccsAVpRa1BYQovLQ+FNkCdNe/8f5TOHX9K61Lk99jhcLiw8UiYfKqJQfrVTHrrknH6lLwahn3qnB4YxuvcB0PMgB+upSTMXrQEdCPSCC8xArS4A==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	zAzYRoOaubSzCwVkQN86XMUgEgz1YDKta8fMoLuKdKaB0pNKeamk33tQ2P9ilMqsi0L/kgHuktFmCCaryqnftqSdwFuuLi7WzkoJmAmM9akgbykZcyujAdpgu+hT7H7KoB35tCjvhBDNJ5+2loJrUv7/RCZwiR0T5wy3W4OaOPdGhJrDSpP3X9UdQ3GlHwPcVPQBrzEsxOIM9mbZ6ngTW2PiPvWpvUA6N+u0d4+XsoBPhWbg13K/rU0ilFIWNjMgnQxTJGg/Pgwt39rWkLFsJ1Su+XYss46YX2tdhnRGGhCg0tymvFLvKFSFoxOyAVUKC8WrZounrh0O6CX26l6aCMlvXz1cb4wer8K4+U+//b2oRYBW6V+232rFRdfx8kyVyJppZylcqwpftVKSH8xIe5kAESwc1wKOc0mqdi0+AcqLUQ9HHOkTIYzYJ9BjC4Dd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:20:15.9687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 289594a0-a9d4-40e7-4ac5-08df29dcbd95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8508
Message-ID-Hash: 443HNKXGPDCI77BAWELQJ4XV5UD5DV6D
X-Message-ID-Hash: 443HNKXGPDCI77BAWELQJ4XV5UD5DV6D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/443HNKXGPDCI77BAWELQJ4XV5UD5DV6D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Register snd_soc_acpi_amd_acp7f_sof_sdw_machines as alt_machines in
the ACP7.F SOF device descriptor so that the SOF core selects the
SoundWire machine driver when ADR devices are detected on ACP7.F
platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/pci-acp7x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
index 5a21ab8ebb4b9..2999dc6d72a63 100644
--- a/sound/soc/sof/amd/pci-acp7x.c
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -89,6 +89,7 @@ static const struct sof_amd_acp_desc acp7f_chip_info = {
 
 static const struct sof_dev_desc acp7f_desc = {
 	.machines		= snd_soc_acpi_amd_acp7f_sof_machines,
+	.alt_machines		= snd_soc_acpi_amd_acp7f_sof_sdw_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
-- 
2.48.1

