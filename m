Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966F5CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:12:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C19160214;
	Wed, 14 Oct 2026 12:11:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C19160214
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791972726;
	bh=9Cd2Q0CMNXUR138WrDIAmjU0V5tLPPxpVh6y4l7TBVE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AjHACLuwxFFCApBGeFkL1XjKrWOVBJqhaYzkPHzOf+iKbhR6NImArD3dir4Ykslxm
	 axIRsTTEU2AHIiYsfUWoaOxOx3kbZsT0h0oTyUiiwedmVe4ar9/7yXSuRfUgVBWebb
	 EDM/VCN69cXUWXr3fGxga4yDe2Z/wRJmCqttF6EQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37DBCF8069E; Wed, 14 Oct 2026 12:10:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A446F80697;
	Wed, 14 Oct 2026 12:10:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D5C4DF8061F; Wed, 14 Oct 2026 12:10:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.14
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791972629;
	b=iR5uHfvsH30MFvMRKqNFd060HukYrPyQtbXAVyB/3d3J1QTY6gh3BlZNBdpKEUirovCm
	 5tr2A+ipgJ9AuFI0ezqV4qbKXkW4msiQzEqQGWWhQjpXAXU8MPaC/XXPVFs7bFbm/4EG7
	 dVyFDRwH93Nf59QJmxtFx1Npj2uiqCRusvA3gwlRBCwRa0ffQgoZks9PMe8tX2Mc/rGVt
	 uIwGmCswrWy1OLvg41xsYOt4nqmSaU9oVWDQ2PFjogFGpqH+qnIWMOXxjGQVFtnZfNl6x
	 /EFHV8OVrhsb0Yxh4HfhHHtTutRbu5wC28pJpxAe3lcDgDOh+YKhgLEm9WJn/0rgQIg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791972629;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9Cd2Q0CMNXUR138WrDIAmjU0V5tLPPxpVh6y4l7TBVE=;
	b=ZHtDa8E4aBcZshPmdPH60kdZ76xEqs4bE8ZACYb+Fexuow1lB2lZlJf9e/zpAsosIBCJ
	 zQW3Z9qUDGMU4qHXnaEdYsg/wLuWIayranXLt298WNjTGFcqv6PRiXUElVpe67fPbcgR0
	 70QE/1e88DhaeapjWVATH4Zd6e5IDyf8wlD7wz4UmPo1U1taZ0JfWXEup/XvX4Tb03fw+
	 5szxFGVtK7qyDzCjTpMcqXNwFXMGEJzcthi7eK223MwdDmGgjAQnINDbZY1eXiLJDAfkB
	 o3BHztSxHWgnL9sXA6v0iGxg8kfMNnn5BCfr5c/q/U9+q3I6QxQvo85EHb4CpupsGsg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NLUWwjOS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.14
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012014.outbound.protection.outlook.com
 [40.107.200.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CABA0F80606;
	Wed, 14 Oct 2026 12:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CABA0F80606
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NLUWwjOS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4jcPD4o+3lwXLDr2WBqgmXXwsXl4ckkesd2cMgiYaFaxYFPpQpbd+pW8SBIUvVXJdc/JjwRXxbb1DQHPmXiR9XRxM/S5u/HwZrCLTg1FnW53/enA222DdkUQnsfx20FScP+QX3PlXCFpKsMRRdBVho2QW01W51v6dWOOmqETGRFzYJ2hEATYlBcjFzD6yVbG6a2hC3uUWPG6uBs3qOD/3r76BXc8pF8Pnrs3G0DwE/WjizKx8Nvmzl1MMay3sNYDzNzCgxfMA3SanmRAzOedLbLt9zOXUC+gP/VodZ12Zr7TT4FXWsUXykvm5smbHt4AVkUC47txq82eo5ixFo4Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAjskAzmgrX6/g4k3OErCDUvUyOgHsTD1YlSJ41ueQE=;
 b=tVAAMfga4IQrYpI4yzHVoiILVNgSFBajfdZvNZ0+45Yd5tIreaICPPiV1DnNXgI/3pcXbWTS50kVJleYOT6E7yAiZ2txQXYPchtkExhhtTX1/SriVOE6A50bA5Tj8j7VZm7KrT7BFdL8mBbBHbolU+BeLeVJjOqdB4VO9o4oMI+aC23yxvYEHHcShreEheuMkTygZrJLqudbC5yU9liDIwQFqS3RvsyyW/1TCsDQtEt59iQZ+U4mni4EpTSeNnUnclJx6ZG5aH8nystOK+QEmO7pKDF8rWTv/lzqNuaqw9p1n97ymRQL5Ov02OHq9JMkgRBNLJmDqeK6Y3QQQf11lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAjskAzmgrX6/g4k3OErCDUvUyOgHsTD1YlSJ41ueQE=;
 b=NLUWwjOSiPXVpfeheaJV+xiEWGogSH7MGK+7LUf5ghdbbOm0XuEKXqHWDRR0airZpQGGr5YV6uClBArfvt+GrHNwj2HoqzeTBGcuVyGRSrXbTgOoVAk3VdQfxhlZ+UCTwrQXzlQlJbVNO4LH93SfS3ax5oo6FFVxkCHsjzO978g=
Received: from CH0PR03CA0391.namprd03.prod.outlook.com (2603:10b6:610:11b::10)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:10:20 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::a4) by CH0PR03CA0391.outlook.office365.com
 (2603:10b6:610:11b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 10:10:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:10:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:10:09 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:10:05 -0500
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
Subject: [PATCH v2 03/10] ASoC: amd: add I2S machine table for ACP7.B
Date: Wed, 14 Oct 2026 15:29:11 +0530
Message-ID: <20261014100902.1215212-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2f1474-bba6-457e-031b-08df29db5a66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	BIIAiCJgYit8xKm/cdQY6ilCATIdEpCmER6LJH9JGLzzyE0IWwHTBTUE22pHhQFlOYZSGIqKA+urClg0rbKYgC5nu7YjF6rxGIWotE2lQtU2xtyKFexIZSgFaNWsFw7v0gmT4EtpKzXPi9FWMUw8o9JAS1236H+cRK9AlfkCQAJDlUU7woIXcN9GRmVdI5KEj1N9Bss65Th/wfFstEIvgwyIL50VNU0BEmWynUeG3OqS/B4UmnR4QFBdbGvPN6XJh/FakfdZaYS4HGrxz4V+A61FiH4t2HSnS7CMUWV8QbrHT/2K01q4LT2qWnLbZ2qML+Yj5yC7heK6a/UUYN3Yrbxs63lkbqpMwjnJumcLmccmSMOQhwXqUMeJfW+6Wammu4Zbx+kCczTgNOJLpDe60qUHf2qQUZEMxxmsXUWh3tWzDbVaVd7HoTN6qu5qEiY5qa3CPUjp51LUdEWeK78qhl9k3nkcc7eB27rRzJyMGUr2AbHwPMBaThOq4t5/CxxNYyug+y8zWByZfkxAlq5XnhQgoXMzzdDUSP+3TznHkfcwjWC/eLIA4FF8/tvrWXuo+cPMwx+9ZhyS4fVF1IUqS+DGhxRnKmClhrQKT5U5JLOCczpcjAPPLrPXBgcxoVzNr4LANpYe5PRu39SN5VEVi4oHbluWsWkolfGcmxavD8UD43FWczT2l4me81TyJCphg1p/o6y7+z/h0RHCVsEMyA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	duf+GObjkXTYHu4nj6j6iRCglLVYfaYCtlcZ6jh2uhn6Pe4XW8HALKeFJbF0VuxWM1q/YH6uANxgLGK0lIOzinTCbVm8luBpJjsJwljDcQDTCZ5SZ5Sq2qRVOm48nW80fUyEs9hWegrfwWkQ+ldZPwkLT2y3XdZnohwn/Ncn5FxM/cVZEEjmHDrnSaAJE/UhvQFyeGLdUFCI8V9NKNERjkBfpLD7f1Cg2gPB1qnDjgM73QF64+8vBZm6wMix/HaokV7k7ozB6JyXuBDYU7xOdzhuxgDZdpFJnBEhKd+IaxAJwhdme1H6zLBgMvI6T0HFr+gtcu5ZxYsCWX1yjQPckrFmO9HpeOSGoDnLNE3osp4MbpkC8nx4IpdvmIoIY2MaepzLExDXDfaXuvhOfvM5rypucDIip2MJWxP/cCQ5WJfx6dgSxZrPsPKtiwBM5mO7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:10:20.0831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0a2f1474-bba6-457e-031b-08df29db5a66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
Message-ID-Hash: U6SDLO7ADGN3RVZFPYDUPQ6PD6J4IANR
X-Message-ID-Hash: U6SDLO7ADGN3RVZFPYDUPQ6PD6J4IANR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U6SDLO7ADGN3RVZFPYDUPQ6PD6J4IANR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add snd_soc_acpi_amd_acp7b_sof_machines with the ACP7.B-specific
driver name, firmware image, and topology file. Declare it in
mach-config.h alongside the existing acp7f entry.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp-config.c  | 12 ++++++++++++
 sound/soc/amd/mach-config.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index d40600e12d4f0..30e01bc47ee0c 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -440,5 +440,17 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_machines[] = {
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_acp7f_sof_machines);
 
+struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_machines[] = {
+	{
+		.id = "AMDI1010",
+		.drv_name = "acp7b-dsp",
+		.pdata = &acp_quirk_data,
+		.fw_filename = "sof-acp7b.ri",
+		.sof_tplg_filename = "sof-acp7b.tplg",
+	},
+	{},
+};
+EXPORT_SYMBOL(snd_soc_acpi_amd_acp7b_sof_machines);
+
 MODULE_DESCRIPTION("AMD ACP Machine Configuration Module");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index 2dafd742dc01c..02ce044bcbf72 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -28,6 +28,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp63_sof_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_sdw_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_machines[];
 
 struct config_entry {
-- 
2.48.1

