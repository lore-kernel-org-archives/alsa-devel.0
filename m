Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29507CC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:24:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 26A42602A7;
	Wed, 14 Oct 2026 12:24:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 26A42602A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973460;
	bh=MhGxkHqsb4rHcJjbCffuwwyPWqH3q7JYH6AWAEFSPec=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kwhBfGZEpebe10cr1c5g0EfqGsIGSb4ByX33D0JhPGaVF6thS+ko15eDkpmOlMfkS
	 13Cfy3wTluBO323Upg2vQXrNXLO3T0ZABsp81wQObeX/O69xdTuKO/ttffeOc4zWx5
	 PCBI7/TDpx0/7Nj7y3KnYichfJpfNCWJww4zXYk8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA1E9F808C9; Wed, 14 Oct 2026 12:20:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A5281F80878;
	Wed, 14 Oct 2026 12:20:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CE920F80764; Wed, 14 Oct 2026 12:20:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.52
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973230;
	b=d9g5PbsxaPAOfGDmq2p6g7iFk8jkEBJ87QrS7VGGKplLpIBEqR1ZihH6nYq6/W0s5Kv3
	 tcj9M/UGbigLG0fWKW8pm3zNAoeK7tcco1uyPcKoKE7qMdirATPL6OVOSbLBF+fj9bXcE
	 jJnWK0DTl/rT2vLZfaQm51I1/sHvoIb6OwrpJ/VzN3HPXax5jcwzNE2bkw7OJWrET/Rt/
	 feXe20aUzd8N+Qd3B2wrD9Kn3gYPrbz1grkYAsQvwLDqC87jDc30XfM5UPaCmXKkH0S4z
	 kVfcuSM4FNNT2kK6OeyGcClaG2KnvWJOg+VS1bU2SEM4H2ngvzAhFdKtAIA7s/w/yiA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973230;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MhGxkHqsb4rHcJjbCffuwwyPWqH3q7JYH6AWAEFSPec=;
	b=E1OajMCQTEG/Na1dSc7iKUs4Ci7pO9O9480h/mIMCEHOv+5VNTfyyFPQxAXKTTfUUOJi
	 dyt0QeveJWjJJOVoqLzOEdUhcwpHrQLhMzoo+DFzjGa5BQH7NhC217lcif/c5GrWR5K7i
	 t5p3uMBwlAcqPhuF8ob6N3Erd07mm4vEeAJE3aiMA/KJh1wDgeQsEEg1uZ8htPSoUyv+N
	 Y2ce0X/afzm/u9I8u5xG8UeNWusO8KEEcFa3g3EwwVVGhg9dRGb868ku1cyZeEdWxZmxk
	 vDauIzZSXTn0vrRU4ROucvIq+lvGxAVs9iAv4bqG3qrlX+fkj4Jv13KbG6ltSklm+gQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zaqJV+Et;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.52
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 869CAF8061C;
	Wed, 14 Oct 2026 12:20:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 869CAF8061C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zaqJV+Et
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJitr07CdBER45kftvkOwRv7tO/X4vrF9HF1a3YUzKwwToATDHa6CD0WEGTr3QR6OZ8Qf6ztgPznKVZMMrq1sNmZfT5RIQj+2qNWekMGKM/kshScPohycudC6/vFBqTrMswVtHiBYMdrpRKXct1DiEPixbQ5stn3ivwqhrC8jVq9ZcB7aVcndwvjfBot+rhFPkm5f/SmLAw0X137rpy5c9HMRpUsovhIARCbOROVDiRqPca6wgx+E7X4V5d7vBuyyxnFGcdhgYl+AL0A/fw7bkLZJWoOH6gGYcoCQrWu46B7VGT5lDgly5Kispu6p9VhYwlFFK5k8RDEAieNtIZqTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+Ge2gz/ZBN0D3k0WD7n+CAHlDgWiAT9XThasimNDG0=;
 b=tUL/rHw6vLuCOHbQna9BB+/Dd5WTnAt2uRJlJxtHjTkN+GiXK3IhTCezromnLsxL0svuY+BIbUgW/eBRfLD8E2uOYrrWji5iFfyBZi2LfXiPZrkf0gUB5FzpRclheDU+oz1W3flbp+U2K65t5zEl7XNOfIWpmwGWPQ8VKBwbRX85/m7wX+X+LF1zLE6USapB+Lkpsq845w6V6PVwI4Siv6y2d57MDjeKFbAYVdsFMpx8NVflS3rZdRPlx318xsQ9ZZD5r/oVUBoA2x5scn2iYfWEDj44g7tqYxPfyIAhvjxb9h+gqLSjoiLSLI6UB5hQh3xl+9yu/PNPN1GSeNYbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+Ge2gz/ZBN0D3k0WD7n+CAHlDgWiAT9XThasimNDG0=;
 b=zaqJV+EtvT0zldA4mPA3M3JA9VzThGyofGbn0jWJtX4M7acI27YJXOlmstCyj+WOcsbGGBjaj5FLqwPpulUM8KjsLytBiIukkKpHkHo9mMeIdXpyoc5SJL9PSM9EvInIZ5XMHpdVxM9egRliHzLNxBUVkyNLBjMay44iT+8SCVo=
Received: from BN9PR03CA0393.namprd03.prod.outlook.com (2603:10b6:408:111::8)
 by CHXPR12MB999244.namprd12.prod.outlook.com (2603:10b6:610:2fc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:20:20 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:111:cafe::6f) by BN9PR03CA0393.outlook.office365.com
 (2603:10b6:408:111::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 10:20:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:20:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:20:08 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:20:04 -0500
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
Subject: [PATCH 12/13] ASoC: amd: acp: add SoundWire machine table for ACP7.B
 platform
Date: Wed, 14 Oct 2026 15:46:31 +0530
Message-ID: <20261014101817.1240200-13-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|CHXPR12MB999244:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e50dcc-c018-4998-8811-08df29dcbfdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|56012099006|11063799006|261009223027099003|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	1CBqEacCwBeNqq1tJLn7ZkaPJ5m6WHvO1Q0DQWPfA0HkDn22HMCAE5YWla5AHVstObqPI99TAreq0cKxgDWZkVCO4MQlOcDrpdXiXg1N7+rYs+edaCKXzUS82w8XZncxKD/IQ2TsWg4TZ2YWrWvR5O3/RN3nX4wV6zRPNEtfqnBzV91p55xTsmprdrRIalSmY1UUPyRA9xq6EpnlNiUHZosX0QNh/0TaUU1nQ2e1MevU0dFZEFSUQXCenUYjAujuDcAf1hRL0qHwQWKGkutCt+AQ2qX/6v/C3HeD8pAJphTUirqkS6a+LEuMxxcFgc62a7ZiLFYhvdg0D7i3qX9oe0t7exKMFa9vLMSfm4P1UMMErmzWDRkR/bFTTTw9Jy91fNpwkjLKKVkclaPm2HS6izH2eVCchrXwFutiYtgBHuJnFXHMwU+tBzHwqbNgV0epH6sW/M49+boNroRRf1o46BL+zE/yNFdfaazaKNA1+VmYbUxN+JFWt7YidO2mtpiMVTmPtBNDMN73X2S+PUFt+8MmbZFp4jr1/Ff4lCL7O+zEj2fMwyHx4IIo58zF/1KjqMUGW9CKoFfjrRjtWmwXUQQV2lfh3dIwCcxi/paJrYazTSTEy14o1YhPciiiEYkdEhoyDJ6FSOOAV3yFCDnWcZ0oFpgbNKKmHgdpTGBDUJbKOU1MZ8q2g8c9B5HZJWGFl2jG4S8ecEzAFxrPfqrXcg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	br2A67eQ8h1tBdtuualzuDCRsuu8U8TV2IMk7ZvDdJwhEXDieavRYHn0Q62QzWoPZoCwdq2bgG8r12AEqItG7lBJMJ3DclDOQJEzCuCa1ZDGSm+4br2Ug9zQi1Oleu/y7fAkRKPht6U27LTHgYyr63baDvP2df1wZnVKvbv4JL3ct4fkDhs7u/sTOpB8wbWv1JRhKBsNlV2BLQm9i3EPrYq3acfuq2CKQZYhqASqBkaL9C+85EDRSsYKk+m0btYUY3vLDRIzyuAu+NSTsKx0dnXE+ZXzbkK++2PGdjbkWfgqH3um70cNWyWSmCtb1Pvj/BGfByEDE1KjQHWq2dFV6ZwOfE52+hOqKdyrbbfrnjIpE8k6K9i73pFMTi+fhRLd9Qzu4tWe0z+L/MjNokG4QeWTJGvYLIU8rjKzKQ+c0hogY7kmagpI38zKGdY+J2Fl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:20:19.8151
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c6e50dcc-c018-4998-8811-08df29dcbfdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999244
Message-ID-Hash: JIEHDM4C3Y7CPEBZJMACN3XOAVVGNROO
X-Message-ID-Hash: JIEHDM4C3Y7CPEBZJMACN3XOAVVGNROO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JIEHDM4C3Y7CPEBZJMACN3XOAVVGNROO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add snd_soc_acpi_amd_acp7b_sof_sdw_machines with one entry for the
RT721 (L0: jack + DMIC) + RT1320 (L3: speaker) SoundWire configuration
on ACP7.B. Export the table for use by the SOF descriptor.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/amd-acp7x-acpi-match.c | 12 ++++++++++++
 sound/soc/amd/mach-config.h              |  1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/amd/acp/amd-acp7x-acpi-match.c b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
index 2f5e060ec79b4..830c59966a356 100644
--- a/sound/soc/amd/acp/amd-acp7x-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
@@ -148,6 +148,18 @@ static const struct snd_soc_acpi_link_adr acp7x_rt721_l0_rt1320_l3[] = {
 	{}
 };
 
+struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_sdw_machines[] = {
+	{
+		.link_mask = BIT(0) | BIT(3),
+		.links = acp7x_rt721_l0_rt1320_l3,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7b-rt721-l0-rt1320-l3.tplg",
+		.fw_filename = "sof-acp7b.ri",
+	},
+	{},
+};
+EXPORT_SYMBOL(snd_soc_acpi_amd_acp7b_sof_sdw_machines);
+
 struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 	{
 		.link_mask = BIT(0) | BIT(3),
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index 321af4682fd30..09ea9f5259557 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -29,6 +29,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[];
 
-- 
2.48.1

