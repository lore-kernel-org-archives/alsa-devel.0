Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D843E9A03B
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Feb 2026 10:54:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D01786020D;
	Wed, 18 Feb 2026 11:54:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D01786020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1771412051;
	bh=VQWOAL43YSMZDqgAlgM1dX3aI2WsfgkbhEgMuyxcFGQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IiKYcwl2/6iyzA9f4DR7TX4H8DxW48qzZrEb7uMCrmoQP6ubXMoSMAWZ0LujzfNwV
	 +SvUGYk9Z185fKGeiHX5doeDiPs3heCPUns23NIq4MeNH50DaHjAijiBglYezLRYX4
	 0ykg3DNi8ih2TEVhZpIAFUxmSC2jRxFLH30+mPcA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37F6FF805E4; Wed, 18 Feb 2026 11:53:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59242F805F1;
	Wed, 18 Feb 2026 11:53:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F0E4F804F2; Wed, 18 Feb 2026 11:48:07 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010042.outbound.protection.outlook.com [52.101.56.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E256EF8045D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2026 11:48:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E256EF8045D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=OqlByvJ+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmfaIu79X8gJReZVtrly5CNUxK7B0vU14Y2GMS0UIj1AzZnX64KaCFo/ySYKzD9lpE3P0gvq7ZTF9BDuUOARbAFavgFzcmU1rg0kZ7amMvvsfTdtZQG4DhTPiKMIpK1Ns2EJd1CD8fArjt/N86X+Ttu2HkBy/WaNpdI/9OJKZ+gGRvyRQAVlfRI6OUUx8NL+oyhjS4sTp1pvlKWvbTzikeYM6rQz9wazeQ//TS5SxOY/34NdEInoVkc6g9yS4AYiecis44yVEqsoT6yChEQqn093S3ODA4QXz0nerOLYYWHJygrRpF4R2mNV1iAOxoNkfBZQpaGXt2Pm3tFzx3YZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0ZynwaqAWncdC0CEYknTB/cxtDdVDBqyLVHzbbmCSY=;
 b=xcbkytL8e4nJA1d/mvLdspBm9KHj+q9Dnevtzd66QV1sYJetE3vPigJztluLJjw3Fgjh7IRrwy1WxZYo8BZ+MFhPKAeB/at92UYq3HjdCras/Uv7NbpBAfXzGM9xwyTiQqXWLPqkihejJ+VmU5XxWJjLkMYjXJKhat2pLsLgQsLpvDyHpeUgTkuf+nVvjNrZSbB23uf7JYqo00pNwvG1qQeALZrFwQwTZDyJ5mWTY+PmoX+u6Tumo15sUE2gbBF4Bd7UgMjCw2ZNFMMB4crG6fxs0mEowEPI+k4EOPNPFg+XW5bTVyVqIkUEtUuFNhy7FZQc8u9BfeOLYhvydNTT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0ZynwaqAWncdC0CEYknTB/cxtDdVDBqyLVHzbbmCSY=;
 b=OqlByvJ+w0jJG6Mk03szoyIt7jookalW3k8Q/wfVzLoEifzV7s9v0dVTkt7hiLT0+zqeEW1PAs7iLVnGSeovYx+ihQ0XFRkJBBB18zMl8qUyNnxBl+JNTvmEwuOQMdazDv4rwc2mFWrtHe11SR6InSVrJx37YpqdEmYVtnLSAL4=
Received: from BN0PR04CA0157.namprd04.prod.outlook.com (2603:10b6:408:eb::12)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 10:47:58 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::ae) by BN0PR04CA0157.outlook.office365.com
 (2603:10b6:408:eb::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.14 via Frontend Transport; Wed,
 18 Feb 2026 10:47:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 18 Feb 2026 10:47:57 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Feb
 2026 04:47:54 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <mario.limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/2] ASoC: amd: amd_sdw: add machine driver quirk for Lenovo
 models
Date: Wed, 18 Feb 2026 16:15:34 +0530
Message-ID: <20260218104734.3641481-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260218104734.3641481-1-Vijendar.Mukunda@amd.com>
References: <20260218104734.3641481-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 3004646d-d1b6-4e56-aef4-08de6edb2d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0iLMl7b5cZS9DPOigJR8HUEkdllajCpUvMS92JaxOHqz0+jQNfRneExfO18q?=
 =?us-ascii?Q?1JhdMEFmd5kG+OtNEKBNlbd7uslTcCdCnmCOJBiTY/lDJGdVL4gp8UWhe7fH?=
 =?us-ascii?Q?nfdP4ywfVcQr9tBKr9y0pYsBo3FBFEinGVyOqsaMOFSHyLTGrtU5q/W6Zkkf?=
 =?us-ascii?Q?buaDT3oTHMa7nfyEwqAKojHa8/6LBRvKE07IdAN+Oy+BovpVRjHdOU0K0eG8?=
 =?us-ascii?Q?azzrT9URGhtfPLs97m2TreBDtRNdth6oZC7Y3q6OapgldhARkpUrUahKqQMM?=
 =?us-ascii?Q?jArGaW4kNP2NKbv+jef7W/fuw/8O3spP3QdJ6tJgnNF4dHxxzq8JelX8+W4a?=
 =?us-ascii?Q?e69Bms4DG/hxYuqkI6uYotKEEodIsmYV5wCOAD5mLWx6Zawcf3YitKGKhYHm?=
 =?us-ascii?Q?f3Ss6tLhGyHMuYr51SDTOGu6/m/lROn2f91xaqzpnhMl336y8skDUkpP2t1S?=
 =?us-ascii?Q?3KqF+gJVg0ELKXCIzbVr/TvJM6S0x1Vwv5bfsyZVKB4vkcByzG4q5EO8GE7z?=
 =?us-ascii?Q?vvO+s+VRSlg4oqnvvpx6ca8YtUkC8AJR6n4M8Vm6ti89KsxDWjbBqoUs6F6K?=
 =?us-ascii?Q?jg0s+DaL8CuL8X/Xp9raIluGaa/vfxa/x0OsErJtWRnoTwM31/9SvDG7OfjW?=
 =?us-ascii?Q?s+Xtq0sWMgE/eh2CTeCD0dZf3rsjmhGJsR2YnRjtUAqns2CX9FXzpRfZ0ULL?=
 =?us-ascii?Q?H+B0zBVpF6WvWhmYuuDg3gldDX2koHXl1OJdNDDRQ+0kH8Wdic8k9AuIMnMC?=
 =?us-ascii?Q?mLfNWmU4KiRobKeNPNpkiqtdeYnX/TwbHwbyFCk5Cqgt1hhJs6uJXKCxmc9H?=
 =?us-ascii?Q?BGyjLJuY1//wfwsoK/Ku5BveHrQVsL1v1/5Dm4gdXqiu7rIQnofeilN2/nNv?=
 =?us-ascii?Q?2KIWtRZfVXt82fLJPu76ChuBmIsVn+RtsYeqN4y3cYbeST8U7T/19nPrbtMy?=
 =?us-ascii?Q?RaYhL55RxjNjj3LlhaLvQyFJFyMHAd+aCWvjDmCaHiUt1V6aPhznf75p1Yjo?=
 =?us-ascii?Q?1RLLaft2EGCARYYSrpNEkg3wx/BAhlPmLHJ6CjOiPIA3gx6SVzONbHpXUxHG?=
 =?us-ascii?Q?jHvwdJrhBCi0mjLWJL//KtmygQS3TB2NVtSuQDIpHeXvL0hFFDYf54CuCr0m?=
 =?us-ascii?Q?QwIHBKk5SIkRJ+EYaJHbGayBJ23WsTVrbkbTmJ06SnM6PpWtb7rCev7fkTqG?=
 =?us-ascii?Q?l380KS3DYV2DQ1OH66dHz2HnKgOofS33JtB5eZmiUkWSS8y/dsdC28Po4HIz?=
 =?us-ascii?Q?QWaLZWX2JX4aMKnjuMOjq6pMLdTksN+4qbH8wODCRObH7+GgFauU3C6GHmq5?=
 =?us-ascii?Q?kFPzaoYIS+CbkjZbveoAVhn2MiwCTeOeyskFJkyzS902W9IP0uuAQln8q7/F?=
 =?us-ascii?Q?Mq4JkOZwcERZ/+PQHcq7k4EwEqaclYg3WTKduNzL2vSKp+2NC6R2b6V39zi2?=
 =?us-ascii?Q?PIGGd5wRCGNpKsfLJ9jOkeNTbfl1Dv0j/094f61ozFzp6YxzRGlXrei3qGFH?=
 =?us-ascii?Q?yXGJCTOAjhyU83jTIMARklJg4Utnev/NHsWwsuQxlz4jhCDL05790GrL2zYv?=
 =?us-ascii?Q?327TZMEw49Q5+868PMjHK/qWi9s48BrocZsVl3DL65D/Z0kJELb2JibAnEHY?=
 =?us-ascii?Q?dveFIXpoMPotAUukN+Bh9jWxiXMLUcjh6IaqHNn8RGbRvggfGUg9nA8ottuK?=
 =?us-ascii?Q?3f8zRQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	AI+j9qHAlkjm0fCAFJy37f1+6sz6zWzvRSlMyjamYAtYj32dr+RqgvoQdJnJag7RDuXZ8QB9+qWYhs0i1LvGAaT9Jf56rItUkNJXJTERH/l60Lcm45n0Nq70X3jrQ3ZW+aY8Q70//b7EncKNMBVQQfcSjAcHrh9DdzVQuzYvQUYiIjvHNelO1WuX2whAogubrayJ+PBP0KhLmBu5td0aFaXpYbfWN0FmJvoDLX3ynNoPJlNemcdPNvyGi7nvm9HZ009Pk8cZDVbLGcdo0eEwOjvmMZHWJwSxBEvjy8bu7oBpuHiOikfY0LdFbqCxSzeU6bl0sT9Ljd1Uj0BTWsJLOzRcUhievrW1NVrVPF6iyqKNLKydngNsjEUXgdt8lwIE03Pnp2Zhz/xObwpgKXAk7IA92IodVRZcB221EClBWKzv9wEBlvnDgt42J1eE1nMO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 10:47:57.4362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3004646d-d1b6-4e56-aef4-08de6edb2d94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169
Message-ID-Hash: OSCG7BFBYDVZOQUWTUL6AALWTHB3U7I5
X-Message-ID-Hash: OSCG7BFBYDVZOQUWTUL6AALWTHB3U7I5
X-MailFrom: Vijendar.Mukunda@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OSCG7BFBYDVZOQUWTUL6AALWTHB3U7I5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch adds a quirk to include the codec amplifier function for Lenovo
models listed in the quirk table.

Note: In these models, the RT722 codec amplifier is excluded, and an
external amplifier is used instead.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index 9cb55d592c3c..c93fc0920a3e 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -95,6 +95,22 @@ static const struct dmi_system_id soc_sdw_quirk_table[] = {
 		},
 		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
 	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YW"),
+		},
+		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+	},
+	{
+		.callback = soc_sdw_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "21YX"),
+		},
+		.driver_data = (void *)(ASOC_SDW_CODEC_SPKR),
+	},
 	{}
 };
 
-- 
2.45.2

