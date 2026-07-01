Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455B2C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:02:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C48DB60278;
	Wed,  1 Jul 2026 12:01:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C48DB60278
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900129;
	bh=vbuXsESm/gvmaDZxK2dzDFc86lsjQeZoCAAom7T2RXM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=mBXi4q0uuUam1AjmsbgdrbNWJIMm41v4mhxZzpcBNNs14CTTV0ELaGT5w7OKm33HV
	 MQesqOVovMOS6QM/Nq0aSOvwyEhLmB7lLsZJ5BtU9aRvju2biRFQkZ6o1Ds2y7YHlD
	 VUuQb4lpH9iJbPx2zsRLZyHqmgLIN4brwOVxJvbM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5B4A7F807A6; Wed,  1 Jul 2026 11:59:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F86EF8078F;
	Wed,  1 Jul 2026 11:59:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 93C51F8068C; Wed,  1 Jul 2026 11:59:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.33
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899943;
	b=ekF/J5zq8tHRtYHeeXipKJVc/PCJunbyHhXCKD72qTOpg/xzyQmYT3loEndJOFsFHphs
	 FpPzG/MkRyN1rp0YewnnPLaKqF45KwtIbw33TnI09UmIle+FtL4Xx74IbGU3AzH9PlT9l
	 Z+9MpI0HtOM88Hq9eqCaBMHjUhXJQs80aardM4N7EXrR/IQsIaDFxjIXgHRG9A0qdxBv4
	 SWfS86+3YJKHN6gh890q/pA9cunH2N9YccDjj23VgUM4tr5ld1sZpWu9BBUOay0swdNvx
	 c/5+36zgwZmaBXSVjlLdBWaxlinfzdWW6vqrlQllxGYZWEMxJd5oCWYn1pAZzyE/Xbw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899943;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vbuXsESm/gvmaDZxK2dzDFc86lsjQeZoCAAom7T2RXM=;
	b=AyxeAi5fh0Mex9UQdAIRP1ixm7ubtPQ/E4PBLEmF1tORR9QksCogVGmc0CL0Ftzhl12Y
	 RiJCga+gKs4n/nvHP9dm5NwPj3MedyC3aAhO64ognKj8eqQGviikovTizeICIUMvMdety
	 fr4yG1fCYfCMbeX5KfkGSdgoS6eJ7VsdhrHL/qS9N6wrTYwnprPcO123vSgx+gosbDunt
	 xuTUD2f1baluFjLHQP10XhdWBR+xVAZoKoz7OcK/QmSZiTN6wCKB35VZbWrizlpuqZfPe
	 Gi65YzI47S+VR1jpSbCk4lEURvWRxGPQTDD9MDQVkd/P+M9i+lAvT/k+ti4tBxtgd9g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Eer8PX9N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.33
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C40C0F8068C;
	Wed,  1 Jul 2026 11:59:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C40C0F8068C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Eer8PX9N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOTtOdbNSsniSEmfpCNNU/bEBKy2kInVRPjyi3DIAAp1jA+FcS9H+/TCahe5Gioe7GdWWsauMyYPClIPfhLynb57M2RKWk35Jr79Rsoym+5/A76hxHCbUMzVURGnCM7Bhn6q1JCIh6bJ6ik66TfAcxEQK5Q68xbt1KY2j2TxU98XJqSWiOlYDOhuDbK2C00s6o5Eh7i5vBn4sd1jELQ78Xbka8h3TiUI1M5pp86BnBPzUhRjUnZ1s6nVGQm6SPlb7nqUiH0do/qVFT6t3fmgEPP67dVdFRCe1VD89LcGZ9xJqxWUhesYumHShj9S157PNzvc4ungIeO7vuqL1S8+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpjPq0z76KpDLrpIfA3TTf4G5V+ieYCPKfcvfPE29Os=;
 b=BiM2aNw85SOtn55Q6isCDmlFsfWZFR/3qKfeYDs70Sxnx2TFOVSmn8FlGU56Ucga4cH7FLKR2bY57qIN5eljXktZh+Kc3OCUi+glV5CfzuK2zftYGWJ5/3CgGgboq0mnK/4ET3pQiCi7YY5uqeZdeaE2fZpO1ZtBlKfuSrArw6G1db456zLiQXFzjXwVR1J5ONUSTdPZueSgmC03YiSRaJUMuf7Mh2NsDFw9ZqxgKcQmOzQprEGe9UqzowjQx0aVP0i6x3+goTPZwzUbo/6lLG87x1WRkFiMC15kcuYSQ/tEXqc+oJHTIVSr20+YIjGi3oZgaoud6ZagvZroX19RnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpjPq0z76KpDLrpIfA3TTf4G5V+ieYCPKfcvfPE29Os=;
 b=Eer8PX9NDSnjRGqOAdAurBgpmv82JBhaL5C3AoX/gjfvg/nxUYTQVVKWgwoVnSYMkkQjGGBqpvFm1fO1265uYGPAn7oanpjomEvattvlWhU65p4K2n/CCQKR3HHXJpYsLrei3kAxWK5ns+00hnn4lqdtii2IQwV86kZZcEC5nNg=
Received: from SA9PR13CA0040.namprd13.prod.outlook.com (2603:10b6:806:22::15)
 by PH7PR12MB7425.namprd12.prod.outlook.com (2603:10b6:510:200::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:58:51 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::3f) by SA9PR13CA0040.outlook.office365.com
 (2603:10b6:806:22::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 09:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:58:51 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:58:47 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 06/16] ASoC: SOF: amd: add ACP7x IRQ handler for DSP IPC
Date: Wed, 1 Jul 2026 15:25:07 +0530
Message-ID: <20260701095759.1012929-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|PH7PR12MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: cfa4bb80-2ec0-4dd4-dcb9-08ded7575ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|376014|1800799024|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Aq9MIqQaseDyk/aD9lZXgOQlEddkOTw8G/4OJsIPnGvXi5WGBgW1uVH+UbZ4CTHty26OicB5Gufexoy8YEVytlWT/ljNIV3nZUqGyn8gkO/5vuaZtiLxgRXd+T9xaMEWhNMZLnrM8oMSr7ftdNLkoYIk3H3I1s/qHlQTjyoG1Sap6kftQq3lysthxLsBRjpSKmGmdldSg5wUgGxoboj0XNPYEbHLL3YJxTGlULqdtkLdNNHzDW/PQtNz6q3qGewqWgZGi7vsC+71hcum/y4BY3/52TroNj4DyOUmeEaifiEb6bL8x86dQ/BJdsAoMDN6EhHmYXEYR3uB1omGiwYWRyl3rpZ0ZlQAgTraM4xAojEryweo6Oe40witEIZ4SeObA22a5gugRtllrnr8yRYEYql7q2ZyRFrSBZH2UesZcAdmtztCcpWzKnaQTio3f9+0A+RKWxvzwu/QZW8xZeCkBRc+903k8QABy+VL6+3Vtb3NLW57OtYXT0pI9xHx34tHxvyplRTnIXt8k0gxGV0YtcO3XEzxokz/9C26eCOh/M+6B0Cy0ztLOaOW3WMj2urpMdmGzipxKS385slqkgLssXo0nc4ttchpXXE3pf7VFdkykJwO4BKbrLWpifM08OPBlms7KFkWpKZC7Mc1zIVcCG/e5b6u6sURTNUvzpofDeNjTuCf0C0mROo9lb71BammDNDLs10sUP2IQmiK2R7LfQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Zo9lw2+oFxI2ClqdEPTBLvHgLAf2iNjgv8+Ubd/SQvlqUf+dCAclPmQAV8e6FrQ7FGDdrgC1I8bg/raZIjt2o3t0Mwltbs3sZO1/1z1IdeW0HelEe/jsMJb05uTlpF68Nf31Wv8iE7WPZcyqmbTjstsxvWH+89zuhGqEt5Q2EqhQu5iwgJoyxq7FIAWxdMVSiLmu8dTAWllTnfHSggGOOmJrZYtKbQWKze+SXLfVP9vBKStHet595xU+Q1Bz7oUwRNZxUxsLPm1gi/ErwHRgb1vS+esVrPYASc7+i358yGJBG5cUBCUcwnFJzGny1U72hxQCzUrKuedw8rP3IWw4FP/zr5GQJpy9MHbIUKf1oCKJOa6/V6252ekYCck4j3Tp1q1AM3m9XDfXkNHDwq4oTffNCcwcuNgPtD9qWXhMUmKvxXjPFZro05MB8oHo3M/U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:58:51.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cfa4bb80-2ec0-4dd4-dcb9-08ded7575ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7425
Message-ID-Hash: AQMJFFAMTPOKHUFASUYCJOMLCJCMCY5L
X-Message-ID-Hash: AQMJFFAMTPOKHUFASUYCJOMLCJCMCY5L
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AQMJFFAMTPOKHUFASUYCJOMLCJCMCY5L/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add acp7x_irq_handler() and register it from amd_sof_acp7x_probe() for
DSP doorbell IPC interrupts on ACP7.B/7.F.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp.c | 49 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index b2c319857ad8..5df984b93dec 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -580,6 +580,35 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 		return IRQ_NONE;
 }
 
+static irqreturn_t acp7x_irq_handler(int irq, void *dev_id)
+{
+	struct snd_sof_dev *sdev = dev_id;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	unsigned int base = desc->dsp_intr_base;
+	unsigned int val;
+	unsigned int ext_intr_stat;
+	int irq_flag = 0;
+
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
+	if (val & ACP_DSP_TO_HOST_IRQ) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET,
+				  ACP_DSP_TO_HOST_IRQ);
+		return IRQ_WAKE_THREAD;
+	}
+
+	ext_intr_stat = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
+	if (ext_intr_stat & ACP_ERROR_IRQ_MASK) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_ERROR_IRQ_MASK);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->acp_error_stat, 0);
+		irq_flag = 1;
+	}
+
+	if (irq_flag)
+		return IRQ_HANDLED;
+
+	return IRQ_NONE;
+}
+
 static int acp_power_on(struct snd_sof_dev *sdev)
 {
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
@@ -1039,6 +1068,7 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 	const union acpi_object *obj;
 	struct acpi_device *adev;
 	unsigned int addr;
+	unsigned int irqflags;
 	int ret;
 
 	chip = get_chip_info(sdev->pdata);
@@ -1079,6 +1109,16 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 
 	adev = ACPI_COMPANION(&pci->dev);
 
+	sdev->ipc_irq = pci->irq;
+	irqflags = IRQF_SHARED;
+
+	ret = request_threaded_irq(pci->irq, acp7x_irq_handler, acp_irq_thread,
+				   irqflags, "AudioDSP", sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "failed to register IRQ %d\n", sdev->ipc_irq);
+		goto unregister_dev;
+	}
+
 	if (adev) {
 		if (!acpi_dev_get_property(adev, "acp-sof-signed-firmware-image",
 					   ACPI_TYPE_INTEGER, &obj))
@@ -1099,13 +1139,13 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 						    "sof-%s-code.bin", chip->name);
 		if (!adata->fw_code_bin) {
 			ret = -ENOMEM;
-			goto unregister_dev;
+			goto free_ipc_irq;
 		}
 		adata->fw_data_bin = devm_kasprintf(sdev->dev, GFP_KERNEL,
 						    "sof-%s-data.bin", chip->name);
 		if (!adata->fw_data_bin) {
 			ret = -ENOMEM;
-			goto unregister_dev;
+			goto free_ipc_irq;
 		}
 	}
 
@@ -1115,6 +1155,8 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 
 	return 0;
 
+free_ipc_irq:
+	free_irq(sdev->ipc_irq, sdev);
 unregister_dev:
 	platform_device_unregister(adata->dmic_dev);
 	return ret;
@@ -1125,6 +1167,9 @@ void amd_sof_acp7x_remove(struct snd_sof_dev *sdev)
 {
 	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 
+	if (sdev->ipc_irq)
+		free_irq(sdev->ipc_irq, sdev);
+
 	if (adata->dmic_dev)
 		platform_device_unregister(adata->dmic_dev);
 
-- 
2.45.2

