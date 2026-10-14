Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11475CC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:11:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6D51060220;
	Wed, 14 Oct 2026 12:11:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6D51060220
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791972712;
	bh=79uEjUPSJbr29eevOVFUoZvkZgvKXxKyJh6RiSHKKcg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=u7h2voni9wa+KVdwhiV9YtrCGvX6a6XO0OzkYTvETKB+AXFW4BuOFsId7rnU4oqSX
	 ajDN+YVg+7683fjmu+B7AoJqun5Iip/ZZbtbiCm2jR7Hh/e2cGR5356v9kqCJLvpi+
	 oCHBG0W1yqIG1AJYYnmn28lAECrRxJM0vwdZ6eZ0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D9140F80659; Wed, 14 Oct 2026 12:10:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CFF6EF80676;
	Wed, 14 Oct 2026 12:10:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B4D8F80620; Wed, 14 Oct 2026 12:10:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.25
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791972628;
	b=VscjsW9WFH+0FZhz9pjP8He6DqXBvmQ+DZHC9oKaZLGG/wJ42I10gkFovRzYT6Lq1Yye
	 vmv5Wdxk5qju64fUCrC8dN2OkAKHkxzpn9ibrwmiQy1jzKWMWHtwXafF1Z8UHCudCDrGb
	 +7KFm0Vh3LZYAeEp2j+C9lX36B740WzSMRX2vooTFRLeRBjcqmTEHDspyTWL5UqtdR6RB
	 TLriYvEtzmZ2SkQyr00ntGVguXw7AqLNf3YcmwYPmI0tF0gxF/VuPusQYZw1x8tlRfdVn
	 1cesAdi3qke+uZ+iXImeRmyBh7pOU7T+Q4nISfg7BVxL+XHQRm4bWLQZ9/mx6YNttGA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791972628;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=79uEjUPSJbr29eevOVFUoZvkZgvKXxKyJh6RiSHKKcg=;
	b=mdeDpsJXqdRaJWtJbKoLhPbWD+0WuIMuPKfuTnvyXSK/+r0BRwWnUxvFDsHLEjGvOP+9
	 8JrQ5UVVe9dDsF0i2i+U4OBNjLJ4mBvn5ZFOm6FtamvKYGcg/Z6Tp8fDNQWmMRuUVPfGd
	 japRQS4LbgsbNAgkgrS8mSsvO1OYY3W3BkjLYd4ckTG1NDsBK8lCY1gCpd1uJ2j1Na/E4
	 0bR7SUbk7b8CzT+MgiKhgnbifi1vQhH2l/0fdozpKvYdPHb4QBp0axgZC5mJFEXSRPCeX
	 pd1WLJPa/kNcYBfE0tMwpbxliuKa+7wZat5aWYdJ1RC/tg0rhoixzjH378rG1TOe05A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=pYlNquFT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.25
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6C7FEF80607;
	Wed, 14 Oct 2026 12:10:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C7FEF80607
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=pYlNquFT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDpWGYo1y/vQ0kS97wvn3+dIWWpJQDFAUlcj7vyfwDHwm8X2tpVgnUnXkGUBOVC9RDsyD21XHi44sPxCrC84qpaERaoIv7HXjKEFsD90/VvyiWJZWhteXX90WX4GSC6bvm6GM7SrjE6SCmiS8FCD1eSjeTZTiagzS23Ols3kX3g93nISUIISHmaNxkFURCpVCbdxxCYpcmjKP4QrQiX57942UwGVA0TxQtAz+I5XKR9A2zPTx+47rHzvFfD8CAKZrMeHCqcr7tl8WoRQE+GDswpL4q55dIP2VT4t8bQAmOenxMXV7hygeCx8vupc5LOKNTDZ3jN+j7VSuXk9ofpkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k7itLMnaX3zwtcZlSNvclTkWq5VIODJIU6tOVxKWXU=;
 b=Tyv9Nt/WQi4XzkowWChjTlVAkL1O8xba1Ui1+H0xV6sV2s3ydFTf1TGApZkXEFPW4fgrHylexwX0WIco+wAT/W/O2+1vdxybAUckFO044n5iE3kqVq20rHrSfR7UJtxC09jU24OeemX6HxJQKb0/DgAeysV74DqTldyaal7bw+49BBkySmr7KzG8DqwWMMAoFu/6C+R1IV49XrH7dNDgclCC3WGKWgbSCUILlkpYhAnHwh3NKVu965cRwrXj/5q4HgGiisC2xxGDStn9hyXbhCuUtPQPNKTw/wrPLbBWNGN9hL6Lfb7sY6NrF24mzYnLwM09Jxuhfg7OlS1L/z7LEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k7itLMnaX3zwtcZlSNvclTkWq5VIODJIU6tOVxKWXU=;
 b=pYlNquFTRpLglOlgbJPBNosJU3+hWgNzxLnO5+zMTao9VHlxZbh1DtcSamb88w2DANZii1/jpastdUFpHdJOvkmPXuoabx1Zy6dObR1Y6wv4q2Ug8MVCRMvwOwS6O6Lm8uL5xcAr6vS7LQiJpgwz5J3CkXqwSJnZHLw87uos7hE=
Received: from BL1PR13CA0383.namprd13.prod.outlook.com (2603:10b6:208:2c0::28)
 by DS0PR12MB999106.namprd12.prod.outlook.com (2603:10b6:8:301::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 10:10:20 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::3f) by BL1PR13CA0383.outlook.office365.com
 (2603:10b6:208:2c0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 14
 Oct 2026 10:10:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:10:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:10:14 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:10:09 -0500
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
Subject: [PATCH v2 04/10] ASoC: SOF: amd: add ACP7.B chip descriptor and wire
 per-revision probe
Date: Wed, 14 Oct 2026 15:29:12 +0530
Message-ID: <20261014100902.1215212-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|DS0PR12MB999106:EE_
X-MS-Office365-Filtering-Correlation-Id: c4395d6e-e097-4dd0-76c6-08df29db5a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|22082099003|10067099003|18002099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	0LYo35406cA0z+klZ2bt+3meR2cQUK6X0S1NN4tcoyzudCc8XJ2kfjIXIatL0UTZRUbDhvNV5E89larXzF956vHPME9WUN9IBiGCMLjh+BATES/t2EC3YyepIdRfSiq7zsYwdTn3wmRDWxixe31PZrfd3lu4YQ1v2Zmt/6xbZ1YX4yXC/jNVdYKtcUhN8aAKJf1uuzpEubmsdmMzYw7d9Wbc2l2QG/vHXVHGNWs1CAh24y6Kfns36F/+vmKtDgMJ8hKzX3MYOniWqk9JxaMv/xeU+g5gYY4YIVL9HnBJXwZ1/XatjD3y6BSGbPg/dHKcEHlARhncWDMM/mHPCj0KmMOFakbhXT/6Gq/X0uFtFFa80hZDMhokaE7LXHZWJ9JgqqksEYpYyGartKKJZOJfem2KmDYWqsBQ8FQkeAJnZFCUNqRFjb803BqZtHAAuipUbeGrytS55vtQ+svu7DnQJlbGcRSCMJQQDl9oqzjcuKTsv2hCsEI+Pyr2rw66eE7O/WQJUjBZb/EahxQMAqQCXoxmeClqY9925g+9cK66/Ge8m9r0y6KkZX+JRIjrTHx8Np9ZphTCfLWQ0G735gDbdJ6ep1KaR4Jt4/0/n4TntzQS5eVFVK8ILJqDQq4WXsRU7WV5mgEzkF8yTx4M3uAwj+x2EGmhJpg2clEOOTpVPtWkLei9a5lapG5fNAPQYe5UK4NZi2Oe2iRdGfB4QDBPaA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(22082099003)(10067099003)(18002099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	hVvPbHqOeHILbu5LNQGKYh8Ig3Qz/kIBxBY99kkg/kf2JpCkivw5LCNvUZJwmA7GQXnyLAEzRFiNpHZkv6xjFeC5qSbkvUKl02hqFo1wtWp3rRvAWlmvqCu/jc+fxKMqxn2aV0alxE+G1czjAQaUDnr4am5tzi9pzaPtDV35T//RJG4BeiQq4rg3ty27ng4UOrUOqGv/vt/TSqyaATcQF2aSuWzAs0YKNLmV2wIiw0nlrlM44g+j8QBhOJGhQbgCC57uSkhH4YathOv8GJwPPV8fMoko3qss7+Nf+0ldHNQQsX7wQV7p3vN72sGozXTWkfuqOdtMrI+lKR8uVssKB7BRXcj6ehs//zVQmz6T8kUALtK5TRdMIoINol+FHiCmysymv86kvTpLrZOLV9wwnkjITePDOcuu5V+KdKAPLLxOH5wC7otRnT+3GLI/Fo5N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:10:20.3837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c4395d6e-e097-4dd0-76c6-08df29db5a96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999106
Message-ID-Hash: OGZ53G4K3LWPP6LEQ36ORAMVXGTQ6PHJ
X-Message-ID-Hash: OGZ53G4K3LWPP6LEQ36ORAMVXGTQ6PHJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OGZ53G4K3LWPP6LEQ36ORAMVXGTQ6PHJ/>
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

