Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81329CC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:12:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C16F6020E;
	Wed, 14 Oct 2026 12:12:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C16F6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791972752;
	bh=H+sXoGwoFjSxQ+R4FxHcJuMgQQj+2I5E9T1v8QRrlwk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kA70LvuIOdCYdpE8zTWNM979Y59BjtWQ2n2fh56HeXlly/b1ms8ifM2BVESyRrwQE
	 d54VSWZqrdRsBlk7+PmxuX74m1sj5hEk0ZSIwsXuuFxDVXiAfJP4W755P57vXdz6KX
	 SL4vIr1B1dXAQ9g/qqb6w5rVXcpHHGeI+FoUSNUk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2948F806C8; Wed, 14 Oct 2026 12:10:54 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3AC91F806C3;
	Wed, 14 Oct 2026 12:10:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 476A4F80636; Wed, 14 Oct 2026 12:10:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.56
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791972630;
	b=mg+2nN0x1KkGNNmHKZqAwFjPCY8IAnVGmsfloksSvazAOgtVjE/vONc+1K6uUVZV+0z/
	 GET4kdw7eOEWULn5Ir1gLEE9j88MQa42nSce7AxNnaYT2PrbfDdit0x3L4g04SpfNHhFY
	 sUJkBDJJzWbHwQ+UK9nH5U2e9ENjP46BEh/2DU6IbP3kGu4vGRXm+ORa/7IigkWxks5bA
	 qNpEnb5XSaC37Kvi+XB8Z8wL2yAjYzNQ/29AxYRc6TMmYjjPAWSRBoEbZuLQ8FfJVkv+l
	 Lefmn0bE5leGCh7D1K9yLvK6y0yUBdoN7Wq0K0zIBraH+X/4LC4GFbc2d9fZOY300mQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791972630;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H+sXoGwoFjSxQ+R4FxHcJuMgQQj+2I5E9T1v8QRrlwk=;
	b=WfrHoGfYmTA8hZtgWyX6+X1nP8rjV6CAjI5ZUDuKnAWF7xlnj6pu/4QURHBNsPUIuZJI
	 AVz7Ylr5D5SxOQygO9831yMxddv3splVtfTHBIiGgN7dCqE/HCpd1vlnvXgRNk6WaDud8
	 fqTFRLTdp2BrlUmcnn+mTjfLPN1EKKt+D98ip5donS0fy90nX31OqSHiDCy2IPRTuEDoL
	 eze9dX1m+3N9RDlEvjVG9PgrybDMge5ZeTRAE5ZbERIoDLR89FAC9Zc9qRrRfKiLKuvO1
	 yAXoCMD1SiQ6C6N2XkzkNQy2/49Kq54FAdp+Crg6TRkZqLVDtOl3BNUxo17PHyKNrsw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=kMHfO2GN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.56
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012056.outbound.protection.outlook.com
 [40.93.195.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8210AF805DA;
	Wed, 14 Oct 2026 12:10:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8210AF805DA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=kMHfO2GN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c3eb/GUtnhrC6Z6WZeawHNK7mgA25P7qf0ZB5uOxpLb1OMiVfnTKb9I2P007JYn0/i1BhEOMUwn6+WrXgpWUOIkpLsP1iBsCkTsqknY2WGr9+pRPmOHGMv3tHX/nNBxVEOTsoWU+sRXus/q0pmYgtYSv2uG7cN+uJ5YHEOmzYm8eWsLmoEfRbQP8ruY9zzTO4DYtRLoIYYXQ213v88Vos/CNXlg1re7mD3x+fqNPLZc9hxiDtqQOILAT4mZsSzfKlQkCO7rHP3I4/xVy0bCmLqyTPfrFHD87X1qMRa8UcGvyJA1fU8F5BUCrHFsJRe+TDaAPY+P7L4iIZDpNDK2kdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gyTZvAOxGSx1g4nD8yBy+8vQkFWY5R3dv9QmY742BQ=;
 b=wD0WyAYbkLbzF3vSewqv1SA1mq28P/8t7WHUmfhU+WW+xwzHgbleiZAOdQFwQ7TaIngf1PCCOhKsT7vJPkExPl0aou3HeF8sYNztuHQ16d4qslkMWrPsh3SddcG0ywoYBChaN4ONROZJTolbAdSXvznlV3kCsESg/FpYXGD0izCHRdu/CYG9pGsnhZs5FbXobc4rbKg1yf87Sk/FUlx6NO1KaZRkSFafZNurEQmZ6wqk+zFjpQWLd3N/QJ+9p6PMCu4TZkRjsqWGSfgqSU2y912jmKWBMYoEmDcziqHckmsFK5BMuDs2VFR87KFg5HbAqptcgOOdmoTlxwJmfLZnsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gyTZvAOxGSx1g4nD8yBy+8vQkFWY5R3dv9QmY742BQ=;
 b=kMHfO2GN++e+pv8469JM6qmg17q8u3Us4LzSuS32xShL2gPQLiu2/NVK9T2ZRHhlgP/E9E3SICqluJcveMsj4WjXKRO6pxcjnQGE8NIUIz0pGSb3UtKVmvQ0gMJ29CirFCwoCluhu4s0BWDQQCIzidmda0p+oDgvVYq4xSzU5XM=
Received: from CH0PR03CA0402.namprd03.prod.outlook.com (2603:10b6:610:11b::23)
 by MW4PR12MB7240.namprd12.prod.outlook.com (2603:10b6:303:226::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:10:16 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::7b) by CH0PR03CA0402.outlook.office365.com
 (2603:10b6:610:11b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 10:10:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:10:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:10:04 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:10:00 -0500
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
Subject: [PATCH v2 02/10] ASoC: SOF: amd: select descriptor per PCI revision
 in acp7x probe
Date: Wed, 14 Oct 2026 15:29:10 +0530
Message-ID: <20261014100902.1215212-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MW4PR12MB7240:EE_
X-MS-Office365-Filtering-Correlation-Id: fd328568-2e19-430c-5886-08df29db57f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	cwlkwbSVB5o/9B1KnE2mqKQsIM5SiWY6wXV/kwSHfypYhhTaTAQk1SL6cny/OGeS1+N+dkrciPfbJyvv6NIHvyFFsaaHRJCaiW+Gm/ZYO671N10a/IxUgPS6YdMOF1P20Ci193XDbyaLrY7QZjXHtfnLwCw/jMEil9YL/kzDVyOJpsT5LRVNo4vlAs6lcU8Wm5PbubBl1snrpoFrv2KSqE2hPJp9pWMxhoYzmj0vsuKC8QPelPZryBkMFYP2kX5j+OZFDeAKrYRBG25Dobg/tBFaVc9Tu/Jjk2L//8f57SUHzICW8t+c4pM7Z81YI+5uQrcGSxSnalxIc6DAKkOeRsjpWW0O+3787c0PhmwdIoD1nVPHaey6ymd88p29qQyv71nf+CVHhIo9O96V2ghztx0gMvxyTgTpdxtiN8SmcIFn+yMIiZzRCOTUJPSC/zpZ5Flz3QvSxImz2LhHq/ZAZV29brE4YlcPPM9lxQfc4AjC1jdu8Y3OxsMeNCYGmrqBd2BGg6pITCXTe4fES3Gc+VEIrBsq+ANLWrwG6KgmoF3DwOZv9oIniwyKV0+li4pDza8ofJX/yQ7Ha/FD9lrObQ+l8v70lqnDm79Eqbnv7cbkUb7/8z7+Yq4HeylwY1irylGBFjyD4tC3B6llknAlcXd3+3a/ldjSx78TGUwSj8SZohSiRND6IfwmAGuVM3A8
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	iP64Mvj3OWK8EJ15qnXNLyy6mE89RIems9C2VzEEhQltNNlXI3zbRHD8NHcChHFTQ3PoLFOQgI34n9jMJYmYbmzv7OJSqU8VVx13z429JrGFF+E1BffC2CNszif0MlgB5ioXQSRI/y4I7RJ+CpWH43CqSFp53RuLH6WcE/CfybcwECQDcElgT8bZ66WvxuA6aQYRlwoea2UCnUolItb/PVe0KFXz0W7/1vb9xldf4pDA38KvX7/cpY95KeIZ7132tTZGIp3ZBLPMvJuPyOKu/nI3BtjsAi0TpMhSloCPAT6MESJg9KjOT8haOBdnlTAi5EVTtxzN+dJUQb1neGy0gTOQcC/WS59kyjL3YLxdNAONV6/GILSIk2KmnMZo76Vnnyg7dAMVOshkCbEK+iRc+v3CFlrPg+Dy1IKYiMQJcU9cTFucpy5HGByb2xnsz6CZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:10:15.9368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fd328568-2e19-430c-5886-08df29db57f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7240
Message-ID-Hash: VH3SUS4FZHMGTMGEY3CHAXYFDEJCXWBH
X-Message-ID-Hash: VH3SUS4FZHMGTMGEY3CHAXYFDEJCXWBH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VH3SUS4FZHMGTMGEY3CHAXYFDEJCXWBH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add a static acp7f_pci_id entry carrying the acp7f_desc descriptor.
Update acp7x_pci_probe() to check the config flag before the revision
switch and return the per-revision pci_device_id to sof_pci_probe()
rather than passing the table entry.

Remove driver_data from acp7x_pci_ids[] since the descriptor is now
selected in the probe callback.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/pci-acp7x.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
index 5949aefe26bc3..7261377c615b7 100644
--- a/sound/soc/sof/amd/pci-acp7x.c
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -68,23 +68,25 @@ static const struct sof_dev_desc acp7f_desc = {
 	.ops_init		= sof_acp7x_ops_init,
 };
 
+static const struct pci_device_id acp7f_pci_id = {
+	PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
+	.driver_data = (unsigned long)&acp7f_desc,
+};
+
 static int acp7x_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 {
 	unsigned int flag;
 
+	flag = snd_amd_acp_find_config(pci);
+	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
+		return -ENODEV;
+
 	switch (pci->revision) {
-	case ACP7B_PCI_ID:
 	case ACP7F_PCI_ID:
-		break;
+		return sof_pci_probe(pci, &acp7f_pci_id);
 	default:
 		return -ENODEV;
 	}
-
-	flag = snd_amd_acp_find_config(pci);
-	if (flag != FLAG_AMD_SOF && flag != FLAG_AMD_SOF_ONLY_DMIC)
-		return -ENODEV;
-
-	return sof_pci_probe(pci, pci_id);
 }
 
 static void acp7x_pci_remove(struct pci_dev *pci)
@@ -94,8 +96,7 @@ static void acp7x_pci_remove(struct pci_dev *pci)
 
 /* PCI IDs */
 static const struct pci_device_id acp7x_pci_ids[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID),
-	.driver_data = (unsigned long)&acp7f_desc},
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, ACP_PCI_DEV_ID) },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, acp7x_pci_ids);
-- 
2.48.1

