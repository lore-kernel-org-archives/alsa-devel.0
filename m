Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45159C79F9F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:26:19 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E4CF660287;
	Thu, 10 Sep 2026 15:26:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E4CF660287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046771;
	bh=obUGAg/E3caUCTwnroWse1ES4f7fICxIqfdY9MajGHc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jHIEhEEOFtM8UzuGaowbYmPiNixMsWHACxH3ltLNs5v3yt5TbU86HOqadBqxg/xAw
	 eGcxGeddXjL6BTdjHFs0ISs+efBOlzaADB/qEWLqfRus8kGnE1a4+RoAnbfok7yrNA
	 df/lynd9SiHMLdhw5q924eLPWVaX2SO8dalvJJVY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EABE0F80695; Thu, 10 Sep 2026 15:24:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F7D9F8069E;
	Thu, 10 Sep 2026 15:24:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E874F8060F; Thu, 10 Sep 2026 15:24:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.3
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046668;
	b=q671jWUy45LqQT7S3P3pfgJhgjzaeWzXoUwKeY9jEqhm+6QvoIVCEeBCCTGnHmTdSCO8
	 8HZbK5n+kZF7iBq3i/H8gzJr8S5B0TuGyr+RX2nG2I+AahBr8KC4UF0BhUFQlXVkfZQCa
	 ONu707IDlnxlRJLDA+/SFCB8B/9z4P6b09lEs0e37vpEVuj9XhsPl+3TFv4DDnWKMmndU
	 hFJUqOcNgrgkqR11C0SQ+UGwpwcKILjqU8I2aI6dNVm+eR7S0Mxyh3VQ1MaWO89o51xsI
	 20+Q6rnt9QF/NYFlc5UhWxOH1Ky8sEIbX9uZL7Yd5GKHcfAexBXqp3528Y5O8syTrkg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046668;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=obUGAg/E3caUCTwnroWse1ES4f7fICxIqfdY9MajGHc=;
	b=IeeNud/vxtyeq9XFWMXKfuWk0XmK5VsMNWyWTBETawlgSxqUOLCTcPWN55PCRjAGDzrD
	 8OQ4jqok4xqsAwu/e7NifQ6B2ug4pSvRGE0Zizcj8en2/fo3uYPldBkQ1AstA1pwRYGH4
	 WLanhiy93HN2avkAreN1bikpqUfD2Y9aknNWRPlDz5pwOKdyrUa5WzXdTzmfs7/IMkVr8
	 cceOFIiF3KPcerlGn7Kqr4BtI0A/iufEnVKy7vwjiWhV32WjVb7/WS0SOlfH4h6sE5elM
	 0szkftO+1zPnbAoNYG1f+f+z9xNKCLrnNu8p0gHzPUVJ1aZJYx2KAC7V2rJRQGEH4xw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=iedSLH68;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.3
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8C4E9F8060F;
	Thu, 10 Sep 2026 15:24:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C4E9F8060F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=iedSLH68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQrIMzINjKpfFRG74c/tVraoG4ZJR0LHe8791xRYwhyNua5HmSbYU7190rBzKA4zsFlVodS3CdjBuIkBJNNO3LoojXZk+xbler9maOOF1OsDJUhGqW6kZZ8hvaEUew4yLSi0AFZOtgUHgN4siTbf3PfpMyqh+FCTuHAwaiUKXKLYaPEascAOTjzrBB56luc+aWL7KrtIoIMfa+47dmWXRodXC4Jh3VagMZFNQrEoi/3uzepitMInOMDBqcXLhAuw2ONNYbxEls/JK6AP1mcbGjaTfT+i/jwEyEZX+tiq/sjaSG1/5Q5kXzb8WGPwQ/y0ELnfPpIIETiw3JXG5wFtkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FlIzzEsf99DtQcRAi4109SfCyY38QCP+F0X0o+ZL3Y=;
 b=W+U7rL1O1dLCWhIi0eeqRqJD6qOexhC8sXgh7nS5LnIgabpjoTDkGlSyzdbKewlOpD0e7SdGlzwtpOgHqf7NgYVMErN+yRo4iInYWRoajob1z8zG/O7jTdGFxHM6ROwKBa57BHOkO2bWr6o3F+5P1pTe+fVWc9ipO4IZFKO8kMXAxXaU1oi6wQVR5GtNuouiXXJ9o9L9fF7GiILMs700R0A1k06A+JlM1vXjKgDAGrztVTFC2z7wPymP6rKPP+rUTuTp5SwpfVbh+1i2HDbnKUlQ7R3pnblJJHieJ/SyhhkbkB+2i9gxeb0N8p6Y21LrEs6ZirTOTe9wrgZCgm8I1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FlIzzEsf99DtQcRAi4109SfCyY38QCP+F0X0o+ZL3Y=;
 b=iedSLH68yUSnP6md+Gxc7PvTDsacYVJhamXisVWn5B7oDeUpWLfPgkhkaoY1nsxsAs4aVESKLvGJ2JglG5PzSoODZM7aN51WC0i/xPJnrp9J8126++F58+Phnz2YGOhYuOgpNGCsUHFkRlmX7EUB5WNxL8nbCxA+hSF+WlP+NkQ=
Received: from BL1PR13CA0264.namprd13.prod.outlook.com (2603:10b6:208:2ba::29)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:24:19 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::6b) by BL1PR13CA0264.outlook.office365.com
 (2603:10b6:208:2ba::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.5 via Frontend Transport; Thu, 10
 Sep 2026 13:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:18 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:24:13 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 04/11] ASoC: SOF: amd: add ACP7.B/7.F PDM controller scan and
 pdata propagation
Date: Thu, 10 Sep 2026 18:50:04 +0530
Message-ID: <20260910132251.1171943-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|MW4PR12MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: f462508f-fe90-496b-24d1-08df0f3ed19a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|7416014|376014|82310400026|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ZDR++ki4O7uBwvPfH1klpdAI46ZHHxCptCw/GWzHPTNI33RH1mA2bCXQGnsx6K7OOud+C7fsIXbrZKwpLvPuhv6CUXtatfzH3SdLaSiESbTR/zwLwbnILm46ZU2sXjMgexHuZ4CpbRou2yA1Exv2OUQpFIOUP9EqUaQydFhIyBgWYtde9RZC9QCi9h5wbyOp3WomTX2PkpK2WgNAceBuCIcW5e+/5I6sYKzYySlBPGXML5q3KJ1DO06HmQPdQyyxSzYLbujDpX+O7eltudYop5yB/+sjKxmw+JszGKNr/DpKWExNxHYeifvGh5LK2M+g5CfG3SwQymtk+hpv3auQyzJcELrYujZhGYuo9AWhXt/sVYT6FsZCaFP+UKvoCHQYG/rZcp3M+Gm8/T+k7TUCvEMlwasSCKzRnd5lhlS9lKvLB0vLXOKOjAY45iBFppZKWb/bU0XrHiE4qtQmFa3jHdyisn/sV3C6QIFRi7yXue4dCR5k5jtFEI4NSa2Uzz4t6pl+94+YjHpGXxAsFxYJUT8avhjXnZGIh+fFmGsuUneJDArjodYFlXYwPBbg//jWkTvf6KKhYG1QJnZxh2K5EEimoO7GXkUNVUyBgjpMhdSAdIiF4iP2UgXQN6eVFU0kIRXLbY3VaoTKZvPASC6QstCwqrEIemOv3SBwrKzn1NLW7PXykAtNYQGWBFVsTBbPSMCxtbqfN805SXYn3IRc3w==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(7416014)(376014)(82310400026)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	IZQjfgosE78cf7nnXHunWIGIlP863oJRPYm5hdxIgKgf+1UOjFit3PlRC7nyiZXh8fWcYvX25hMThhX1cgCAfdcw7eX1WMUxM9FX0b5D3qDhjkyweP9szFGnsSlWG3aEYv5Gnrotddec8xlgxQJ+1XB5+vjSiOwCCo6Q1y8NaYHprYwd8Kw9VAbhHbNpWK2p6SJodqz1lnyMtwAh55tUPu1WSSs5N5YZ6DuSRu9VjC+5yGuXUhC/ESbkIJV4XxnlfKUyvoSPmYcSZr0G4jHprljSiaiXWre7BqoYkMN+C+3Noyp7HNrJz8RTkeJU+00+vNavrnM350HjC6ghsUrQgoysJih2vBK+Rt3h+UVQ64XuDm14BXO05jRA+twXqE193TKYIN7pDxbChd9KDOd7zfhXt8RAMOTEdOjwjkwtofhBjWnm/AUwBC+EYwE2rixA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:18.8387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f462508f-fe90-496b-24d1-08df0f3ed19a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
Message-ID-Hash: S7QM2WPFMGQUN2ONWIFVEA6KK6N2ZPS5
X-Message-ID-Hash: S7QM2WPFMGQUN2ONWIFVEA6KK6N2ZPS5
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S7QM2WPFMGQUN2ONWIFVEA6KK6N2ZPS5/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add acp_sof_scan_pdm_devices() to read the acp-audio-ep-port ACPI _DSD
property from the PDM child device on ACP7.B/7.F platforms. Value 4
selects PDM0 (ACP7X_PDM_DMIC0), value 5 selects PDM1 (ACP7X_PDM_DMIC1).
Unrecognized values are reported via dev_warn(). The selected controller
is stored in acp_dev_data.pdm_sel and propagated to the machine driver
via mach->pdata in amd_sof_machine_select() so the machine driver probe
can register the correct SOF DMIC DAI link.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/soc_amd_sdw_common.h | 13 +++++++++++
 sound/soc/sof/amd/acp-common.c         | 17 ++++++++++++++
 sound/soc/sof/amd/acp.c                | 31 ++++++++++++++++++++++++++
 sound/soc/sof/amd/acp.h                | 10 +++++++++
 4 files changed, 71 insertions(+)

diff --git a/sound/soc/amd/acp/soc_amd_sdw_common.h b/sound/soc/amd/acp/soc_amd_sdw_common.h
index 3930cc46fa58..17e4e97fb3d1 100644
--- a/sound/soc/amd/acp/soc_amd_sdw_common.h
+++ b/sound/soc/amd/acp/soc_amd_sdw_common.h
@@ -23,6 +23,19 @@
 #define ACP71_PCI_REV			0x71
 #define ACP72_PCI_REV			0x72
 
+/**
+ * struct amd_pdm_pdata - platform data passed via mach->pdata to machine driver
+ * @pdm_sel: active PDM controller (ACP7X_PDM_DMIC0 or ACP7X_PDM_DMIC1),
+ *           non-zero when a PDM controller was identified via ACPI _DSD
+ *
+ * Carries the PDM controller selection for ACP7.B/7.F platforms, derived
+ * from the acp-audio-ep-port ACPI _DSD property and passed via mach->pdata
+ * to the machine driver.
+ */
+struct amd_pdm_pdata {
+	unsigned int pdm_sel;
+};
+
 #define SOC_JACK_JDSRC(quirk)		((quirk) & GENMASK(3, 0))
 #define ASOC_SDW_FOUR_SPK		BIT(4)
 #define ASOC_SDW_ACP_DMIC		BIT(5)
diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index df656cdc1527..33540f7c421b 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -16,6 +16,7 @@
 #include "acp.h"
 #include "acp-dsp-offset.h"
 #include <sound/sof/xtensa.h>
+#include "../../amd/acp/soc_amd_sdw_common.h"
 
 /**
  * amd_sof_ipc_dump() - This function is called when IPC tx times out.
@@ -177,6 +178,7 @@ struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev)
 	struct acp_dev_data *acp_data = sdev->pdata->hw_pdata;
 	const struct sof_dev_desc *desc = sof_pdata->desc;
 	struct snd_soc_acpi_mach *mach = NULL;
+	struct amd_pdm_pdata *pdm_pdata;
 
 	if (desc->machines)
 		mach = snd_soc_acpi_find_machine(desc->machines);
@@ -188,7 +190,22 @@ struct snd_soc_acpi_mach *amd_sof_machine_select(struct snd_sof_dev *sdev)
 		}
 	}
 
+	mach = devm_kmemdup(sdev->dev, mach, sizeof(*mach), GFP_KERNEL);
+	if (!mach) {
+		dev_err(sdev->dev, "failed to allocate machine entry copy\n");
+		return NULL;
+	}
+
 	mach->mach_params.subsystem_rev = acp_data->pci_rev;
+
+	if (acp_data->pdm_sel) {
+		pdm_pdata = devm_kzalloc(sdev->dev, sizeof(*pdm_pdata), GFP_KERNEL);
+		if (!pdm_pdata)
+			return NULL;
+		pdm_pdata->pdm_sel = acp_data->pdm_sel;
+		mach->pdata = pdm_pdata;
+	}
+
 	sof_pdata->tplg_filename = mach->sof_tplg_filename;
 	sof_pdata->fw_filename = mach->fw_filename;
 
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 5570f3d1348d..37909f2d86a4 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -853,6 +853,31 @@ int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_resume, "SND_SOC_SOF_AMD_COMMON");
 
+static void acp_sof_scan_pdm_devices(struct snd_sof_dev *sdev,
+				     struct acpi_device *pdm_dev)
+{
+	struct acp_dev_data *acp_data = sdev->pdata->hw_pdata;
+	struct fwnode_handle *fwnode, *child;
+	u32 ep_port_val;
+
+	fwnode = acpi_fwnode_handle(pdm_dev);
+	child = fwnode_get_next_child_node(fwnode, NULL);
+	if (!child)
+		return;
+
+	if (!fwnode_property_read_u32(child, "acp-audio-ep-port", &ep_port_val)) {
+		if (ep_port_val == ACP_DEV_PORT_PDM)
+			acp_data->pdm_sel = ACP7X_PDM_DMIC0;
+		else if (ep_port_val == ACP_DEV_PORT_PDM2)
+			acp_data->pdm_sel = ACP7X_PDM_DMIC1;
+		else
+			dev_warn(sdev->dev,
+				 "acp-audio-ep-port: unrecognized value %u\n",
+				 ep_port_val);
+	}
+	fwnode_handle_put(child);
+}
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_AMD_SOUNDWIRE)
 static int acp_sof_scan_sdw_devices(struct snd_sof_dev *sdev, u64 addr)
 {
@@ -1070,6 +1095,7 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 	const struct sof_amd_acp_desc *chip;
 	const union acpi_object *obj;
 	struct acpi_device *adev;
+	struct acpi_device *pdm_dev;
 	unsigned int addr;
 	unsigned int irqflags;
 	int ret;
@@ -1123,6 +1149,11 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 	}
 
 	if (adev) {
+		/* DMIC ACPI child address is 2 on ACP7x platforms */
+		pdm_dev = acpi_find_child_device(adev, ACP7X_DMIC_ADDR, 0);
+		if (pdm_dev)
+			acp_sof_scan_pdm_devices(sdev, pdm_dev);
+
 		if (!acpi_dev_get_property(adev, "acp-sof-signed-firmware-image",
 					   ACPI_TYPE_INTEGER, &obj))
 			adata->acp_sof_signed_firmware_image = obj->integer.value;
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 16d66b2eaa70..2326b9d2e4c6 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -125,6 +125,14 @@
 #define ACP_SRAM_PAGE_COUNT			128
 #define ACP6X_SDW_MAX_MANAGER_COUNT		2
 #define ACP70_SDW_MAX_MANAGER_COUNT		ACP6X_SDW_MAX_MANAGER_COUNT
+/* ACPI _DSD acp-audio-ep-port values for PDM controller selection */
+#define ACP_DEV_PORT_PDM			4
+#define ACP_DEV_PORT_PDM2			5
+/* ACPI child device address for the ACP7x PDM/DMIC device */
+#define ACP7X_DMIC_ADDR				2
+/* ACP7X PDM controller selection values for acp_dev_data.pdm_sel; 0 = not set */
+#define ACP7X_PDM_DMIC0				1
+#define ACP7X_PDM_DMIC1				2
 #define ACP_DSP_MSG_SET				1
 #define ACP_DSP_ACK_SET				1
 
@@ -279,6 +287,8 @@ struct acp_dev_data {
 	bool acp70_sdw0_wake_event;
 	/* acp70_sdw1_wake_event flag set to true when wake irq asserted for SW1 instance */
 	bool acp70_sdw1_wake_event;
+	/* PDM controller index selected from ACPI acp-audio-ep-port; passed to machine driver */
+	unsigned int pdm_sel;
 	unsigned int pci_rev;
 	int acp_sof_signed_firmware_image;
 };
-- 
2.48.1

