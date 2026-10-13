Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 907C3CC6B16
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:49:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8862C601FD;
	Tue, 13 Oct 2026 17:49:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8862C601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791906591;
	bh=9Cd2Q0CMNXUR138WrDIAmjU0V5tLPPxpVh6y4l7TBVE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=viKEfZvQFHOaC18wpBkKjlKsfWJaLsrJfx6UbXTq6nZKXLWq5I2kbHMj7qfHqixz8
	 nadBnKO/CwUdSv8AUDfSN7yqdIh+mDPdxssoPNQKOQq/TJ4OYC6PYIBXFiBy/7uYCz
	 /RNzgSduwH/VMaq13FvJeeBbtmpmegLjMK8FqGLw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A051F806A7; Tue, 13 Oct 2026 17:48:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E930CF80448;
	Tue, 13 Oct 2026 17:48:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 54281F80654; Tue, 13 Oct 2026 17:48:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.62
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791906491;
	b=EdTmbyxZmNsoyNEd2bEggl6iOeDhikZbySPX4Fm6pEPYijAPnCNHRN7eSEEyuCnvd0gw
	 izFLeqwVseb6wxXIrrKJkS011BraX46L2qVQUwnmaP/JwrTYbTTrfiwUkbgz8YxGg7m5F
	 sTkePkwBz+sqQK0XQDnVGsroJJwBBKJhszx8poyg6RS0w7OBxPg2HZLiiecoKN0gO5A+E
	 CZpqSlSwiEoyOG874vwWycV9Fl3q29j6R0IXUQAFpTrIRutFjcyTI6pezRKjcKLEGpXoq
	 M/BeCmje1Hj7lKK10H6e9lXUbBd0QrGzKxPdjtiBqRpQAiB92RnIFGyAUzVCBlpGwFw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791906491;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9Cd2Q0CMNXUR138WrDIAmjU0V5tLPPxpVh6y4l7TBVE=;
	b=bOlD/7Hb9U0b4jWBGp3X8ifID4AovPImGjRCJGei9ymuw57RudS12GhbRquSPXjD+uxi
	 YjALCcoizAMWgrt9MwuozFuNmLVH9fm90+D5XHwuM2qKqrZjmrVtZoiCXQlZqaIjwhE2v
	 3HGt8jgkBYQOVax7gsIrWqLOf1epnpSZo+LkVylkIjnt6VOCvHy2C16dLRlmCG56EGneu
	 hLd1IlXhGuwCTasuP+aOF6ts8rgU9mjln21hB4sDX6yb5JmEHRbAPWRnBKDWk/AnzVOp1
	 IRIgLNyIcmd3JjJCar4IebDNvh9ms/+z+mNrawjZEX6ldQp7eq27i0B9jqSRR3EBReQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3RbCe2bR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.62
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1F036F80621;
	Tue, 13 Oct 2026 17:48:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1F036F80621
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3RbCe2bR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJY/G7VEEO93I7nnALcoQ5Zmlz9VoLuLbLk9vtCFBe8roR8mCCiG4Nue6wSXtGVnUZzt2do9dMpk5NVlvVDwMw/0wjZriJ6b+259ueSq3JoV8kNTX4XjUz+qfHCbfLVrz0CJtAzrXwysEVTQAqg5vfZuH24uIzvi7GvtCnFYSHRd89CKZL9c/jC+PoiFRkHEwL75EeweG28i0h8iWPtCGwjTdHSDM+44e/Xn0r14KjYUzDjN0tiLqAwxcAmvBoqYhst74X5BZyB8uABZUYyavS2jqXsM0+gz+VHduBBb0JbWtQlZcUg8KaMkLqQgaBa9eQ128CSthCOckyxB5QKa7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAjskAzmgrX6/g4k3OErCDUvUyOgHsTD1YlSJ41ueQE=;
 b=nA66mjlt55z1zzdaIAngy7KwympNlw1QILr3yAYT4O+iVxiH8wwkexSoYT6/YPjb0vXg3JjY3+LLixEqW7uc5ucturUx5ed0dlUcz3ufVTpQ8w5WCv4ShORYQyvpHGAwH62JqqKp4VnxtQK61LJoJH3EP1spfu/7PEysx84iWJKTGmzJJBOYATGuetfmLLABrWiPOo56PzMM99iKNDGuPuXEBxe+XSEX5WEa5XHqnM5v0rWs+b6Q1CwVAQO6f6f9wYu/EC27zqhnnOIUfBhtjSpfalCtjaNUbZqAu+Z/girG+yDHenqZYXcxapVD4iEXLRpFEKhFG9gecgHxiDXfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAjskAzmgrX6/g4k3OErCDUvUyOgHsTD1YlSJ41ueQE=;
 b=3RbCe2bRtCwOw0EL5pn8Oxaajo4+p1FauEolPrzlJq1MNF0TydZ8cuYToJkx+5JU9kEMq9wycZ+Ijt28+11E+R0dERac9lYS87f9L4XKgD+3tpcvYiCKfN1IWFQ43XhVEL3+rKWpqgVd07nwascKWg9nj5rMap/AVUkotj8WR1E=
Received: from CY5PR15CA0254.namprd15.prod.outlook.com (2603:10b6:930:66::28)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:47:58 +0000
Received: from DM2PEPF00003FC6.namprd04.prod.outlook.com
 (2603:10b6:930:66:cafe::37) by CY5PR15CA0254.outlook.office365.com
 (2603:10b6:930:66::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue,
 13 Oct 2026 15:47:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC6.mail.protection.outlook.com (10.167.23.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:47:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:47:51 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 10:47:46 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 3/9] ASoC: amd: add I2S machine table for ACP7.B
Date: Tue, 13 Oct 2026 21:11:35 +0530
Message-ID: <20261013154644.3788064-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC6:EE_|PH0PR12MB8152:EE_
X-MS-Office365-Filtering-Correlation-Id: f5b65741-f806-4378-513f-08df29415a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|6133799003|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	7lCeQfQL6wVHwndOiw0evYkusMxz4PPDXZacx66gmgDe5YhhtYaSG7uFCz/lr0f5FChoFotJA1KQljHFE3mVly+T+2yN2Ra3NcLVYD+nc0qECntN9i/kBe0nWdfz9Tgd3Q4Q8IWfj0pWvmmJBAMQDarRfkUrdC9wwD8TwYkhCbJ1OG7Dx4JoeOkRZlS7DoomVTHoJmw7/67eYfLvoq6X/N1s3az7XSnqiBLx2z/A6krsocut8FZ+2FwbbsptmzNHSnTK/l2esdA9zgzqolNKedftONBm4kuSxGMefXiUTiXdetSZDwmP6uiSSxSTg2UCaVSJj3678BNMEA+VYpAotCPECN0sY9Bh9AiD2EuT/qsqckeMV0hoDhetbsiqbrLush3BriFBUHrgPdvTtecAq3nWLCAy9OUqk8EzY0lJ3tHqXWJkALR6wvzLCboH61jgRzlzZKP+IV2Y4IS8+rBk/pmyQtLodDEwWbb1e5u4Vyf0N0vtoN54p3NGlOoLYQn1H6a5CNAl6fztshHoz6FAR3xpVWpz8ISR3KofrNRK7lisJNuKHodn5E+gUp134BZxfSTZ82Sn0Xa7QaAl7stIqNcUIV0u2B5WdmDzqXPlArywITD6NSfP7e8dhWVpBvdK1OmbMlXSo50K81vgrfyV5V7DGKTyOuhgm7pQQ1LfNRG/hxmBRIiVUNlyFfVM4tZbl+5MD/Q7a4Bw9K2Z+bT2UA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	a1vdvPgLUiL5/qohnKMqfelE6vvG1Vu0uQcR4FR+m+57J8kQAEjIB2bWFOl+ESJRXcFVxnst4E5aNNDjO1R51lYKU95Ivd6Cmzd4Il42iZgWHxaeJm8g5oQrTzjemXbIAWHAZ2avp/i/nUAtya7mDaNx5ReAaW59AB4napXh0tH7Kd3wRFQZ4K4grNHRWlaamx/vkpTQHOT9eSvsXDuGqUSMmvi3NVmKHOnxZkSTo6x4N8GB02+jB7s7rNIfEzAqhwdCNJ9HTCLDpF4C0KOKfJruxnFQj6x83e2aPjL4oNIeboAJrmjr2qNy3O60h6p980nEg2eiNSrfdbS7AfqBQnn3nB80yjZzw37rH+T2IE4EIRo6N2LlGk+D2qro+47X2ZquFYbGb7APBQk4ZOaYEX22E8gDx46Xxm+W/iqIXRVJNHGaZUrkQeqaEdy8ARb1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:47:57.4375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f5b65741-f806-4378-513f-08df29415a57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
Message-ID-Hash: XTFM7257UECAM2UCLHSVEFDGEI25KE2U
X-Message-ID-Hash: XTFM7257UECAM2UCLHSVEFDGEI25KE2U
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XTFM7257UECAM2UCLHSVEFDGEI25KE2U/>
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

