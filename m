Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D527CC6B12
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:50:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0E4CB60210;
	Tue, 13 Oct 2026 17:50:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0E4CB60210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791906615;
	bh=79uEjUPSJbr29eevOVFUoZvkZgvKXxKyJh6RiSHKKcg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Qx3CptjZv3aVogyM867w6vjvRiKkvqJKd1wlIC1m3oyIMsOffvufWuLCA5vDSxiar
	 VMbk2boEMEXEePeZTTMfMOxvPrYqVb1rzxQc4zhZGWDViPKM0eQnkFVPdQA9S/ygr2
	 TcLiszXZ6J2j6149DCv9pojkFgbviAsSi2bXTEkU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EBBA3F806D8; Tue, 13 Oct 2026 17:48:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 764FBF806CA;
	Tue, 13 Oct 2026 17:48:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 57A39F8068A; Tue, 13 Oct 2026 17:48:15 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.40
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791906494;
	b=pioUq878tPGa6VtUhKmelVpuP5oz0LuBMKW3C5y95NWfX6LOpoVlbp53Qt4Id3q0tyE3
	 v9/K34MyIw41NWbZ6rkJ0udRWV/GSXhLzGFAFplTR7kHHOD9tMzwYXhZ6YxbSqFWRHZMM
	 myBOc336gpAE2yjT7uBa7Fu1nH/fgj4KVSz6XJGfu+TQTuc0EIxy9p/r7OuXbWmunSYKP
	 YqoxlsFOE1/06wFpn/VkHbnTWTwZm9p+2SWiqoDSjNzRBF6rm5SEJL9cG0PnavHwqTWL1
	 JBhSsVR1utJK4grJGuAHYZFJLgUqzhRAzyTVsK+A38JBLEQdXP8wo6eZbESPPSrUN8A==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791906494;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=79uEjUPSJbr29eevOVFUoZvkZgvKXxKyJh6RiSHKKcg=;
	b=Iu6ddFvuK44XXer00AMz7RveP03PU7Sf6/xNElmSbqkEofc1yb8QNxMJfRxMzaDLtKZX
	 Tdw+qTBnhfDLTqOL1xWjs6c8OP+GVbz075XkBLrtgvXuyeMzBTtoiUS3+FcxUnM7cRPpZ
	 FX59FjCuCQea93DfB7CV+AtdwnKvkiC4HcAxzF/IQ+C1bFNBd65DGiucUfsPBcr4tcSA7
	 E/uGfXOv5F90CIQW3QjoVC9ohWTEB6b7eler/HApUDl7wyJ/MuDDJ+cTKPXzSbaUa7CWW
	 Y+tK6r7SFnoc+/syvyjvbuYra9sdGMIt5vMA+Lf8MLeVCyy0gDWtMgIv+1TdkGUWmTg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FjJ0noBO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.40
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012040.outbound.protection.outlook.com [52.101.43.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C5D0EF80621;
	Tue, 13 Oct 2026 17:48:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C5D0EF80621
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FjJ0noBO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQX0FUyKHDg3MOQJnxFFFW7ixW+IsEYgiNe4dkGspgDeD6d1JWscloV0MXpZlpvV+maYkwCNxYXzSX4PSNpZjk8vComgDPVZEiC8jdgdKD9wmjPMMa5y0wH/y2UEjBdf79vn50pOun4h9Epyhk+GGwaEhCzqwLHLSEG8SMuD3osDnRcIIu1bB81ZFVVwD+AwT9MS+Ov1WdrUz1VNJS1WEbgU+KPHJupJJlJpqaBwPIUERQvQI/eEPpa41DUnx0HBru1sklZ5lwuuvhVKV4PaxK+92GVfaHnCFLh9lOlJlei0+0WzOf2MtYXVdHx2V1dDTO9ehrQhFdhdAHEFKRR3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k7itLMnaX3zwtcZlSNvclTkWq5VIODJIU6tOVxKWXU=;
 b=WxBP/UUxM6t1/HTn2dGKP+2rVZH+Gcj5hrsQzBpDlzQy0GniNLvkN4AYtiUQg1CGOSrBQk3ixT1hwguh3HC5BMAejeQ4/zA23ozda3mAkQR04k2sgiWt3LTKa4nj+hTnbEh0s3jaAooE8iSn9I/xeExVKGxK5emZTnM97+0m1hwzubHoZTznV3aEi7pQRZ3gfeiuRC6DHGLpwZihx3zvg/acX+tX5MegZjDMbNbt1uZzsP4mSdZuu5Fzw6uA7OblAh8uA36vR3C8ZQet96Dr9l3yLfKLgqR7cvbGm9hhnKmrUFkFEPJ8dPwjgSq4RaRIzXHlorc5loONjA2kIMq4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k7itLMnaX3zwtcZlSNvclTkWq5VIODJIU6tOVxKWXU=;
 b=FjJ0noBO3vvZp5iZh7hQ6bAhuDjcTVXYeOPwYAu09+SiPa3mWx3deVXQt1Zqx83cWhyld2wpTM+vZ6i0egSCVSu4O1zzLI8LCfZ1YDEvvmpvW363Zp/BRhKZWFIBBoa8cVL6d+3zVe49RduUwpKR91BrFbW89Pi9lpQoRBME83E=
Received: from CY5PR15CA0250.namprd15.prod.outlook.com (2603:10b6:930:66::24)
 by SN7PR12MB7910.namprd12.prod.outlook.com (2603:10b6:806:34b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:48:02 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:930:66:cafe::72) by CY5PR15CA0250.outlook.office365.com
 (2603:10b6:930:66::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 15:48:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:48:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:47:55 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 10:47:51 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 4/9] ASoC: SOF: amd: add ACP7.B chip descriptor and wire
 per-revision probe
Date: Tue, 13 Oct 2026 21:11:36 +0530
Message-ID: <20261013154644.3788064-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|SN7PR12MB7910:EE_
X-MS-Office365-Filtering-Correlation-Id: cbfc8856-f9e7-4343-5aed-08df29415cfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	PInZimR8DJLNgVd7aMl8pCKnYcK4CZQU9SD4wvOkm0YGU0AH1ws9rRtPcairadmZW+oT959N6ok8uJ2OK7qraJJfBfm67TRPZBuW/M63f+W0w3sx/BLqJwvciP7E+W8FQzULej9FfFa7m90/DeCtnqM70AYtaj/N5xv7TZm2aryCfSKOfAcAJLdLqHOcj2fWsk3PpF3sUI9/PjqymXVK+aqwCxSWywul2g/ItVV2MYGi2HJ6gM1ik6FzTNZv4iP369likX4b8LGSHdkLzWVIUqOoB5BZs9K1uXvqopYx8Z4D5a7LBGFeOjtz1T8An6xhkUHKv4jUsmIbI/QW+zrSQpbqAsF0Ny9Av6zhsBfdIJUM3u9D1Cpf+EfBABPG8XNAhag9K/kLKei6ufnLRvImZ0l/tQbBDjnvupmH2GOfH/UaOgSzWJhVThzHN4bQ+E8SlT+3m62695rupS0PvGRboh5Lzpo16P9X+Gksonh0LAX36+eSRSDluDPgtxSAZlYSp6I86L6IUsH3UdtaNGvcU6aK3+PY/p0pj7w68qa55FSndosB+6mZb4Qi1Q262KMsfRDvuCqyqrkcuGEQJEmNtoX3cWUdPLaBuotVp6SPOj1QpDA2sUOCz/INEN/h2hYPNGGuiOmf5yMjAhixU+ilBdRaMh/zKnnaGBVktSQ1IoHkLlrfgywQf76Y6+qZsNoGClxNG1Bs1vU3+OSWyp/gJQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7PckSKvHaDcKw5hkEv5uA/pRtwxWP2u1v2+aNi2kCuSfzLsg5h4arq306G5cn6vt/hJyYnL5+zfRdZdoK1hDQybC7+94HUjODq+2DQdoq8xLekH6o6rEV6g5WVTpxvdbG37IvAOWsqZXuj77I7D6Ms//xyrOWOv4NLi326ex3nROW1IUeVPt8YapzYDwJWIR9LgMYARpEKDy/w7+hrEPpGwHsoQkkwn2NUdpCgj5gvL3akGNfsB4BWsrhQiQRKPKPj942cq4C9DHKSFK3lRzhNArvTSoQnJaGL8VPIjTDywwabONX2zdTYqX85SRt5mTG3PmpBW4PRjLz9GiurIH2bEbi+2hznz08zSW3BH439QTXAohBl0q0FndioA+/sbE4YDG4LRd2B2/5cBhm3yy0qAvbVLCy7uHcwbiRWUpRjf48Jcqc8m4Us0m5klbOSGB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:48:01.9094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cbfc8856-f9e7-4343-5aed-08df29415cfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7910
Message-ID-Hash: 2X4LMLOTMXIVA4ORWP5DXTN2NHSWQKWT
X-Message-ID-Hash: 2X4LMLOTMXIVA4ORWP5DXTN2NHSWQKWT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2X4LMLOTMXIVA4ORWP5DXTN2NHSWQKWT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add acp7b_chip_info, acp7b_desc and acp7b_pci_id for ACP7.B platforms.
Extend acp7x_pci_probe() to select acp7b_desc for ACP7B_PCI_ID revisions
alongside the existing acp7f_desc path.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/pci-acp7x.c | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
index 7261377c615b7..5a21ab8ebb4b9 100644
--- a/sound/soc/sof/amd/pci-acp7x.c
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -26,6 +26,48 @@
 #define ACP7X_REG_START			0x1240000
 #define ACP7X_REG_END			0x125C000
 
+static const struct sof_amd_acp_desc acp7b_chip_info = {
+	.name		= "acp7b",
+	.pgfsm_base	= ACP7X_PGFSM_BASE,
+	.ext_intr_enb	= ACP6X_EXTERNAL_INTR_ENB,
+	.ext_intr_cntl	= ACP7X_EXTERNAL_INTR_CNTL,
+	.ext_intr_stat	= ACP7X_EXT_INTR_STAT,
+	.ext_intr_stat1	= ACP7X_EXT_INTR_STAT1,
+	.dsp_intr_base	= ACP7X_DSP_SW_INTR_BASE,
+	.acp_error_stat	= ACP7X_ERROR_STATUS,
+	.sram_pte_offset = ACP7X_SRAM_PTE_OFFSET,
+	.hw_semaphore_offset = ACP7X_AXI2DAGB_SEM_0,
+	.fusion_dsp_offset = ACP7X_DSP_FUSION_RUNSTALL,
+	.probe_reg_offset = ACP7X_FUTURE_REG_ACLK_0,
+	.reg_start_addr	= ACP7X_REG_START,
+	.sdw_max_link_count = ACP7X_SDW_MAX_MANAGER_COUNT,
+	.sdw_acpi_dev_addr = SDW_ACPI_ADDR_ACP7X,
+	.reg_end_addr	= ACP7X_REG_END,
+};
+
+static const struct sof_dev_desc acp7b_desc = {
+	.machines		= snd_soc_acpi_amd_acp7b_sof_machines,
+	.resindex_lpe_base	= 0,
+	.resindex_pcicfg_base	= -1,
+	.resindex_imr_base	= -1,
+	.irqindex_host_ipc	= -1,
+	.chip_info		= &acp7b_chip_info,
+	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_3),
+	.ipc_default		= SOF_IPC_TYPE_3,
+	.default_fw_path	= {
+		[SOF_IPC_TYPE_3] = "amd/sof",
+	},
+	.default_tplg_path	= {
+		[SOF_IPC_TYPE_3] = "amd/sof-tplg",
+	},
+	.default_fw_filename	= {
+		[SOF_IPC_TYPE_3] = "sof-acp7b.ri",
+	},
+	.nocodec_tplg_filename	= "sof-acp.tplg",
+	.ops			= &sof_acp7x_ops,
+	.ops_init		= sof_acp7x_ops_init,
+};
+
 static const struct sof_amd_acp_desc acp7f_chip_info = {
 	.name		= "acp7f",
 	.pgfsm_base	= ACP7X_PGFSM_BASE,
@@ -68,6 +110,11 @@ static const struct sof_dev_desc acp7f_desc = {
 	.ops_init		= sof_acp7x_ops_init,
 };
 
+static const struct pci_device_id acp7b_pci_id = {
+	PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
+	.driver_data = (unsigned long)&acp7b_desc,
+};
+
 static const struct pci_device_id acp7f_pci_id = {
 	PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
 	.driver_data = (unsigned long)&acp7f_desc,
@@ -82,6 +129,8 @@ static int acp7x_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_
 		return -ENODEV;
 
 	switch (pci->revision) {
+	case ACP7B_PCI_ID:
+		return sof_pci_probe(pci, &acp7b_pci_id);
 	case ACP7F_PCI_ID:
 		return sof_pci_probe(pci, &acp7f_pci_id);
 	default:
-- 
2.48.1

