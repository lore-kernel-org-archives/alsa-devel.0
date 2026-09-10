Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA91C79FB9
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:28:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6B8A602AE;
	Thu, 10 Sep 2026 15:27:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6B8A602AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046879;
	bh=YTXN/WCk2ht4NK94ql/bPnHWyar3zUu28qBjuDokWPs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZvUyr6NuNIiVW03tLWkqUFcDH3HmEZ4puu0vJ3KBU+kYUfGNbKtfKJE5NW2AKRuuz
	 JQl8oVbfFbgYoF1/2CpNP//CTKkaEBwpa/lQXzBY3tw6+oo3cnhd/YzZkYcczMpUfS
	 mP8DyaCDD2GQ0d6JpQ0TIDJYoseRRnvo3rxji1JQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A5767F80817; Thu, 10 Sep 2026 15:24:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B119F8080C;
	Thu, 10 Sep 2026 15:24:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0BAD2F80722; Thu, 10 Sep 2026 15:24:45 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.29
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046681;
	b=I6d+gDZABbjVU4cFIn3znJ/LVlz52fyZj2+Z6wqTKQFDRZuMhWZxIO8HCsexooJHJIE6
	 mvp49VygkwC9JLLNMMOAPYBSLomhjW+B/nBOkb1UPLYNxopQCsk8tdMRzuXJtbrTXdCUp
	 JBE4coTGzoYdNwI9WfXdqtlP3UXqcQY0NmK+0wvO4siVk4aA+O0KdBVw9q5oinu1wfkhh
	 3TsKF3tdZt0Y3U4K2SLwGTsdURktEa23lPEDS+jutVqQRu4lYToYQd5xrrdpUUVPVNA3g
	 TWbxLNQ9CFTRn1MimLWFD/NnH8KzDBroSzpvYUv/4Q0dH5udFsPXLMeIT2BhIrb5/Mg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046681;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YTXN/WCk2ht4NK94ql/bPnHWyar3zUu28qBjuDokWPs=;
	b=XKjap9F3u+cZnZTrHHtdxykBvDc2BRQpJH+8KPGY4NGndi78xG7JwTvaaKZHgS6BrCbJ
	 FK4Mz/iFRJs0scNDc9ks2+9aw78MNPoDRl9o8yzaYzQkNdJk34Xdhm3fyFAqgGVu+V0PQ
	 WxH13yGZI+m+ZsXDLALNf7jchygQhSbXOjWL6rXPEZxPRt+Aj7G+1WeJrnoOyJrfMdTWp
	 gWnq/V5JX+1H3aM0Je3Fvp8UoMAMrHbXf1HghR76h50MPGg1EFqlg3QH4+YcDS3Rw7AVM
	 Ds08yHhwMRZFHKDtyR+Is5aiFFdKcS1YL50tSmd70ethsjyTNgwKIRV07acT5Yc1npA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wAI49dtI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.29
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013029.outbound.protection.outlook.com
 [40.93.196.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 80293F806CF;
	Thu, 10 Sep 2026 15:24:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80293F806CF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wAI49dtI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gv5wvTe/NtkqdxG/yWI6gRqk/7T/RAO7oI/ygDMPS8sJOHjQWzCBdiSJdo8OuTknCRykDn2makUonmAmylBAtUPcPPU2mQjQcxMuAdtW43Y58GIC96W3TsiYymKCFljCxQAZ8mtxSFGlWuU6OWl7gGgtT3IFF3F/BNLRA+6tSc9I/D7wGvlv9h/cRTyZtl91EqVbfJxACLlcoAMUHl7AUCu8jQZXW3/IE7RiNmjRz8QzObJfHY0MxYHQjkMFxE6e2bw26ZFNjEiMoyUpwTD2lGy99CzMoXHxcXLit4sXadidNhF64KeEQyvU684h7dHef4Hll4TOjm1nphtir0bR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4Y3cEKzgO1DgVL69Nl6RATSQqiXpuJucoyPzek7mJM=;
 b=hrGwfV2Or8wGb2TW29btSfwd0py/7Dhb3NX/Mzkg5i4UgUztxAJ2Bnthb7GeFZZBuFqMj7hQIlFHlpdmmgHiBJIokOYbaiuyuIKOLcfsOhflzTHa9OSWYK2QNBSrfLikkkSWJQ7VHz4WJNg8Re7yEoWgRRSXUaH5u3JJ0YBanS0fITjEBA5wUg0jPQ7Rkw8hkCpw5e87VPJV2BXY2RaBC8vRgYgTm2L0bD3GDXW8n7OKm27YejJ8auy3sibf+9rAi5OFyIDrTBxBAcC64IKrKnG301Kykc+9YJQ3XbsMRK99kHen6ZzzGXFJShTCmGT8I45iXsRPegvTXu5lqLPi7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4Y3cEKzgO1DgVL69Nl6RATSQqiXpuJucoyPzek7mJM=;
 b=wAI49dtIL72q3ToQjYSDs56kOOpYHGMi91ls6QK1Qpx1hFJIBjd9wK8Mh5mgc2Lu+kb+fAWcEsIfOFHV7SS8V2Gp7762kVUizYbYTJ+cJBOWNcLUOyFrLkXW6DqZSxb+NNV6sAuYagsf0V1rKEIYBjyYbSBcHKKY2MEX4cnGDrM=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by IA1PR12MB6484.namprd12.prod.outlook.com (2603:10b6:208:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:24:33 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::34) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 13:24:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:32 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:24:28 -0500
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
Subject: [PATCH 07/11] ASoC: SOF: amd: wire SoundWire probe and remove into
 ACP7.B/7.F paths
Date: Thu, 10 Sep 2026 18:50:07 +0530
Message-ID: <20260910132251.1171943-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|IA1PR12MB6484:EE_
X-MS-Office365-Filtering-Correlation-Id: 420661e6-cd29-4f99-5ea7-08df0f3eda56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	kb1d6Gw074I6mB3ecgkpignFAq7zsrcirCx0JK5q8/Hpcu6HPtdJ2IFHDICj/mwjJ2A6qsHyKFHJ+NOikmzKn+WjJT0qRg3CHnb955du3fciJTUQ+81YuLLpiIkFXNK9lBGuQ9nIPlC5Sjp7iwqYkowbQ27kSZWbUVnpQUXhNzO3C5DHDxXSVEsZlk0PAr0X95IYJ/00yItxETBtAXYm1hPpzAAbrPb+8AEY7zL+9hSRzheQ/e15LscpxaZ/AdeKNngXH7OqgD+iw7Uu3XInQTT3O8V0h99hva/Kcf4gN6+p+CT89VQ+IsgkEwuuuLiCqKFdOeXj7V3NzkofktWmxFLbR4QmfhfwSbJrj0JWa7h+yqxo9gblAmbI0pvVb+v8wTPGeMU0+80JMFlkK44UPUjsy9SFhAyC+Zjnf64MxaifhfP7Yssr6BRii6QcNGRco8/RZ9hjxtmJw6ecC+K7uoPm2bYmjyZqlnVRj2zO+IN8I9JPv45FdJvdgHgDzZ9WvFP5erYplBvOMPc7iMVC9H2EtHSUb84OpPBKTE8Wca4Yrezr53P591m++X+wqtU9XEeNRZXJaYypazid3JK3lhFWmZ19Hn1kqd9AaQ4DrwzQK49ILrOjVJJUPCtIRLlsR6TH3i31yHV4B8rKuB1YQ5i+HPasi8LovVE1ppShZ62jeoMSQo8ch+P4OlRmOIzwoJmpmNeNDs9phLgtMT8V2w==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	k88+aKtBixk6+RjE/mO/SougmrDRjUlT0iCOitILjZ7cVunazzed9P6eLPTxx1kW5UQDAD28B0E4+kY/oWRurskHhTpByP9GfUbX8/e5DofCLTOFizQsq4P3mPFIm11vGzB6uYL+fhjhEgZAKexViwvIvfRP6H3gofpda0V7xtbozZOD+Zee5xSMWlHfuXNyAOsQeT0h/uNeRmmic0DEUp2zzRo88TfYBVTG6xQftCt6nKOSxzag5fD6gOBXLKUZQFIYpliWF5CJu+A+IcCuAyRJCdVZkehuCThSuUh00EoLhN2t5NtHDTi28D4i2UIlgHDu4hmR+MzZbTJZpK8pBQWebngCEkoMU6KLMRQHUrAvENfC9vTeFJbdg0fObooVNuPMCL8vnhm+MaIMAvFmdZCOS6Guyxs+9bZvWZ4YCyEuKGfjeicZ3F85zq35Qw33
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:33.4930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 420661e6-cd29-4f99-5ea7-08df0f3eda56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6484
Message-ID-Hash: YXNBLIZCACFUNZ4MH4XTAUOKK4AYEZTV
X-Message-ID-Hash: YXNBLIZCACFUNZ4MH4XTAUOKK4AYEZTV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YXNBLIZCACFUNZ4MH4XTAUOKK4AYEZTV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In amd_sof_acp7x_probe(), scan DSDT for SoundWire peripherals via
acp_sof_scan_sdw_devices() and call amd_sof_sdw_probe() on success.
In the error unwind, call free_irq() before amd_sof_sdw_exit() so
the IRQ cannot fire after the SoundWire context is freed.

In amd_sof_acp7x_remove(), call amd_sof_sdw_exit() after free_irq()
to prevent a use-after-free: the IRQ handler dereferences pdev[] entries
freed by amd_sof_sdw_exit().

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 37909f2d86a4..a900dbc1de20 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -1148,6 +1148,18 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 		goto unregister_dev;
 	}
 
+	/* scan SoundWire capabilities exposed by DSDT */
+	ret = acp_sof_scan_sdw_devices(sdev, chip->sdw_acpi_dev_addr);
+	if (ret < 0) {
+		dev_dbg(sdev->dev, "skipping SoundWire, not detected with ACPI scan\n");
+		goto skip_soundwire;
+	}
+	ret = amd_sof_sdw_probe(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: SoundWire probe error\n");
+		goto free_ipc_irq;
+	}
+skip_soundwire:
 	if (adev) {
 		/* DMIC ACPI child address is 2 on ACP7x platforms */
 		pdm_dev = acpi_find_child_device(adev, ACP7X_DMIC_ADDR, 0);
@@ -1191,6 +1203,8 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 
 free_ipc_irq:
 	free_irq(sdev->ipc_irq, sdev);
+	if (adata->sdw)
+		amd_sof_sdw_exit(sdev);
 unregister_dev:
 	platform_device_unregister(adata->dmic_dev);
 	return ret;
@@ -1204,6 +1218,9 @@ void amd_sof_acp7x_remove(struct snd_sof_dev *sdev)
 	if (sdev->ipc_irq)
 		free_irq(sdev->ipc_irq, sdev);
 
+	if (adata->sdw)
+		amd_sof_sdw_exit(sdev);
+
 	if (adata->dmic_dev)
 		platform_device_unregister(adata->dmic_dev);
 
-- 
2.48.1

