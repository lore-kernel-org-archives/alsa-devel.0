Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9082C79F9F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 16:20:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB9F6602BB;
	Thu, 10 Sep 2026 18:20:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB9F6602BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789057223;
	bh=Q4D3UGIR61PLhxtCy9m6tVpZ+botHtv61D9LUxo3TDk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Fh0hiDoREJUGXkI7QBTcZNE5B749oZrAGPmbN3ZVBmP2Q99lqU3l40VNgXiaqnpIg
	 RVi6N4epiZZNf2HPWrC7Ds8qLxmS8Dsjh48AeqrGrl9xW5MGDupvEfrGMXTtHCqufl
	 iqEWNduvjsR9333M9cMY7LaOTi83ZghrnUQF8/Xg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0FDBBF80681; Thu, 10 Sep 2026 18:19:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EBE9F8068E;
	Thu, 10 Sep 2026 18:19:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E6F3DF80636; Thu, 10 Sep 2026 18:18:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.16
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789057136;
	b=T8laEKeWZcKFLpLJNzkKyKj0rRGIzdLIb7h/TzKTedpfpehe+AahkKI2O6I0xdlYfp2o
	 ChyFCtv64DwS3uaS8FTbTHiUAVjicNvTb9O19GQBDWaMh+WU0MDL+LibuTxbcX4SACVr3
	 HitFynlH0pVkCyCimdVj0GAQr0OvFUlIrEZuskUuuoctxUwinRIFPGDjoqn2kR0VcyTiF
	 XjwIZ2R8QJRQIJSp3+IHsOqaMOZDYi8F6Kz3GZDI/h6R44Wtcb+vpKgaBnHn8uV6KGVOc
	 UfGV94Ly1abbw7jTkEgk/dmvVnmjbM+d14zdPEIyI97eIv5mXI69K4+aERmTVlKr5Cg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789057136;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q4D3UGIR61PLhxtCy9m6tVpZ+botHtv61D9LUxo3TDk=;
	b=otNELWhzyoIFOy7sSzk35gcFA0TUjt2qD2LDP3IJYjuyC2ZrAs/iWcNl7qXjWbl827Mp
	 OWWrV/1eAxGJakuHxeQuLmS7/8BS1wcou1x7t4JszL4888vqn11Ch1P7QC++qvrpy66UT
	 npNnZIUg3TajYrsP+Rp1TL6uLst4+kr5PiQF230TOf0OhYNz1AEy/Xxw9xPh2/f+JiSHa
	 Pm6MlMS2N5tI6EUSk+fL6IVReqLI87p2EUff9Kl3sJj3V9Pp6f/tz4t2fJNr/q3Imey5D
	 qvQl4J13dGiGyuvCT0Yja0w/F0TQkOk021eOy5OJDWes7QIkJmqIp7xKYj670EtgaMQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jDF9MhKo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.16
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D0756F80603
	for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2026 18:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D0756F80603
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=jDF9MhKo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4xllRoLv4y1L8EO/Da0xQY9Bgeqg+E6rLpJ3JvZALjCsuhvmPkt9ExW3JSJWuNuoTTyr8UCI+l7s9zo9+qLly6WTgjuSOu9RtBo9qQDhvT8WsrzYOdPFnBQ5eC14WC+l3dRDpWD0whxXAHQaNLA51U/dLEQ0Lxj9Vzcq29bhVBPrdF908XVdYnJvRrI9pyasL534G3Qm+v20mAqgkcxLvtrJHho80cIFmoerhRIehUK6bH/jOzdKGwMX45cq1cGyg6cwf9/dB+MN3XMxNPqZx92DUbXO83kq5cBoh/PEeUA8to+GdTT6a3Uae8pHy1ZZkGdWwDQfei2MDbIv5pj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcl2UPvwOwwNG0c/raBTqZFPn4DGYP20yAIWQ7TzzD8=;
 b=M0/VyqzafOOkbZY9Xmkj2yV7Dmbi3mujwaD8sh2w4TVNXAaTx8LSZ7T+jmjW5S15X6G0EPIVA55XG0DDqLRkvjbcMjvcZ3uoYzOJcKsJI3fmhWN6HyFE5DVJM7lyq0XM0jo6hjCYvJX394AR6KvOtkUrVY7Xml2kfshuq6vjRWGLrLbr9X1zg9nX/2JJNzE3k/6Wu3h44ilwGn4XGcWDbt/hDOCNSW+MspkPTNSFBAUbFOkiF2Xx9LuClxYNBix4wDyaMmz8Qpjg9AvpAwwoLiGHMSgtjSXE10EWMJAaZmExxIq4LqTrhfVWj+iJaw4yB6thqE9U6UsZ/Ydy5ii+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcl2UPvwOwwNG0c/raBTqZFPn4DGYP20yAIWQ7TzzD8=;
 b=jDF9MhKoN4M5QS7RnAXzt2RdhngxDlS5d8OKOr1fbyk/g1+y7yo0eOHxsd/QyFUQ0VO0NAdCMjOtXlHHvDQNNi9hv9cp1+MjfzJgRnLPXFiLt4B5ygK0efr/JsGJZtxuyPwB0OCEEJL4zoAVp2L2/pi6leVmzHKwlzFp0zyHCtM=
Received: from SJ0PR05CA0210.namprd05.prod.outlook.com (2603:10b6:a03:330::35)
 by PH7PR12MB6935.namprd12.prod.outlook.com (2603:10b6:510:1b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 16:18:45 +0000
Received: from SJ1PEPF000026C4.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::6b) by SJ0PR05CA0210.outlook.office365.com
 (2603:10b6:a03:330::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 16:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C4.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 16:18:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 11:18:44 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 11:18:43 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 11:18:39 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<ckeepax@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 3/4] ASoC: amd: acp: fix ffs() operator precedence for
 SoundWire link ID
Date: Thu, 10 Sep 2026 21:46:48 +0530
Message-ID: <20260910161728.1452808-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
References: <20260910161728.1452808-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C4:EE_|PH7PR12MB6935:EE_
X-MS-Office365-Filtering-Correlation-Id: fafe15fd-e9be-4fe0-fcec-08df0f57305d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	vmFfkMHEVtURC4ocR4Iw4ckwkpyichp870g2/H8FNXdnOT60ht+1GP4YAKFnxnQS1k2psHL8Pyg3P0acQRo+HhaS8FNuyZq+mIwBscuuFx3q5d/1D5XzBw/t/OuhhgZPwVTYO8MlPkHH7nL5aciaPgski/6MF5bydcoSnB3zwn9fyCHmHPlL6USerR1qn4PvcPieZeG0eyEHJW5dfpH3F1SuL9y0kRbeNapeMt5XVCCBzHzMssBRqBk4142wQWs3JD1wYDFW/aCj+hCeU6xb7wg51MJeZl9jr9c2rwqNCpXXk+1hmpJmmqwKElSbznWrpJ4e4WgPVQLlBreTz4V/b1TWslkem84M8S1wL6ggaW/d540vQQOUayiH5RJYA/MLCngQtwOCAm7r4gf6IMFL3y/+Y2jKUFgaFynRKSFznVNIP14fe0ebcWHTmrtciqzZofefoVt+WfDKOTxJR+5rSMgk/qIN6ibWghsI4EF3qmHqPpZpZERKm/jHju0a1/laoyo4PeCrx6VpaIkddAFXOHyvkMNvTx3Yj/iaHH527hKzTIRxMcMIsUvCdugCVWTyBINLH4sGNVFO91UwFYCnKd45gY94fOvkUvd9Vb5X0C/nDtBBN3DYJRwBmhDpT/G1fWUWA0ofVSO4JctQZFv50JQz6H8rpBvtLoOmflXlzwYmnUmT7zxPjFZTob3K6f2a8uCQ5lo0Q1e2K17nWFIVbg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	BnfsyvRqIkt3wZRldYu6dfzT6EmfsoRoY3uQGvP8BXLyBKCgMqdAbZ3/Oe99x6YLON0xNVWuyjsPs3UmQUG/IBqyHmb5KRANixOjnmtghunlDDrI9Jc1/G2hflbdv3k08N9UNbbmueltd4Ut2Qlda8OTHIx+Pz/GVvlm6fih7qV9NWTP3AygftdyUZH7jxl6spswhVyVrHz0wrjQ4IUq8OpebWM33UpWGnSOmjTey5TlrNY8TdQKjhhyViJsQVPCjubMQvJMjWFEA2cmsPbheU0nJdZctRcpt9ZlydOADVWWUCns1iWEYNEANr1c/pAC2YUVAodxiOeGviIy/MMh4cpTfGor6+QY1Bkuv1TPKS87DGkqbijGGT/iBXlkzinhZV7XJ4dzCM7/91gfBeXoq0vdw8aB2WOYUXCbLC4F2v4WVn6I+CT5mUUCF7ikt1N4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 16:18:45.6649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fafe15fd-e9be-4fe0-fcec-08df0f57305d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF000026C4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6935
Message-ID-Hash: IUU44X5TBH7IE7PPXXSX7W7RFNV46IBP
X-Message-ID-Hash: IUU44X5TBH7IE7PPXXSX7W7RFNV46IBP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IUU44X5TBH7IE7PPXXSX7W7RFNV46IBP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ffs(link_mask - 1) computes ffs on (link_mask - 1) instead of
subtracting 1 from the result of ffs(link_mask). For a typical
power-of-2 link_mask this returns the wrong link ID, causing cpu_pin_id
lookup to select the incorrect SoundWire manager.

Fix the operator precedence to ffs(link_mask) - 1 in both
acp-sdw-sof-mach.c and acp-sdw-legacy-mach.c.

Fixes: 6d8348ddc56e ("ASoC: amd: acp: refactor SoundWire machine driver code")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 4 ++--
 sound/soc/amd/acp/acp-sdw-sof-mach.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index 2ea226a195c3..1a05d4288a46 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -217,7 +217,7 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 
 		switch (amd_ctx->acp_rev) {
 		case ACP63_PCI_REV:
-			ret = get_acp63_cpu_pin_id(ffs(soc_end->link_mask - 1),
+			ret = get_acp63_cpu_pin_id(ffs(soc_end->link_mask) - 1,
 						   *be_id, &cpu_pin_id, dev);
 			if (ret)
 				return ret;
@@ -225,7 +225,7 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 		case ACP70_PCI_REV:
 		case ACP71_PCI_REV:
 		case ACP72_PCI_REV:
-			ret = get_acp70_cpu_pin_id(ffs(soc_end->link_mask - 1),
+			ret = get_acp70_cpu_pin_id(ffs(soc_end->link_mask) - 1,
 						   *be_id, &cpu_pin_id, dev);
 			if (ret)
 				return ret;
diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index b7926967593f..e6d545fd665e 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -132,7 +132,7 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 		}
 		switch (amd_ctx->acp_rev) {
 		case ACP63_PCI_REV:
-			ret = get_acp63_cpu_pin_id(ffs(sof_end->link_mask - 1),
+			ret = get_acp63_cpu_pin_id(ffs(sof_end->link_mask) - 1,
 						   *be_id, &cpu_pin_id, dev);
 			if (ret)
 				return ret;
@@ -140,7 +140,7 @@ static int create_sdw_dailink(struct snd_soc_card *card,
 		case ACP70_PCI_REV:
 		case ACP71_PCI_REV:
 		case ACP72_PCI_REV:
-			ret = get_acp70_cpu_pin_id(ffs(sof_end->link_mask - 1),
+			ret = get_acp70_cpu_pin_id(ffs(sof_end->link_mask) - 1,
 						   *be_id, &cpu_pin_id, dev);
 			if (ret)
 				return ret;
-- 
2.48.1

