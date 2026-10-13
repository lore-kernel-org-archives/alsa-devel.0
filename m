Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FDFCC6B12
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:49:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DBAD5601E0;
	Tue, 13 Oct 2026 17:49:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DBAD5601E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791906565;
	bh=H+sXoGwoFjSxQ+R4FxHcJuMgQQj+2I5E9T1v8QRrlwk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ApnAZIMG8z0c1VUfszH1FJJ2Ed+FD3sLPVW6oTtE6NEYkfHrcq1tJ9M1m1MYWnOXf
	 FvE8k1rf8eenWDdUjkmqZQAhSkA4iJuUQRFy/pXWnksXeEigOafUTsFIm1opj6uHEd
	 TVzLHx7IIKRDZN5ejhJwLm+ayU+1Edj5Y8ALfstE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D255F8067A; Tue, 13 Oct 2026 17:48:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11A52F80684;
	Tue, 13 Oct 2026 17:48:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E66FEF80495; Tue, 13 Oct 2026 17:48:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.46
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791906480;
	b=KeJRUCKV1iP4ClMkp5kbTY4K8Q3cMb7FuXQo5mvmy9eAfRfJNDPXy17RQUHL2nBvGSwz
	 ntkSnIDop+34FomFtFK3xVFLmBKdjlTXvZTlvhRjyNe7NgI7z/5J1ENHNZ/hxEYqRcAyM
	 w6A/6vO7GcHm6GPIN3g1uCKXaVUGGwUImeUQjC6zFdznqTKR52gQYkiG4pG9jdqDtdFEj
	 v9Iw9z8DmhZuqtJr1/szqS2EHWuLSLGIAIPn5JH7B59e9kRjaKSCRT1ME9mIafsvCGFhX
	 e2s5Nkdc8jaFc3jp36sQGuH88fX5Dzk904mip6ru3/ZvDzqefkR8akGp4UQnK2BN2DQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791906480;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=H+sXoGwoFjSxQ+R4FxHcJuMgQQj+2I5E9T1v8QRrlwk=;
	b=FF+VbGtfj7vPcCT2JOrO5MJK1H8ECBZ/Enpw4D8VSOPs5c5riEsIZNbRChlUSaKYZiqr
	 qEpSgDVlTj3KTBvrGMZFl42yymxT8jr4F6SiDHDg6PRev0tuRvfz4TO6EvWqB9d2UpKpv
	 a5j8XBKKMDAgtCK1jZW7iHpXzjnYTuYCQ0fcQlZFyh7lIYgttZLV/NUhhH1o9/DbOTd+d
	 2MSdS5HC0X4nnr+s7kA6dFnCtnEJFQH05/NiKHu5uxpK6i/v6ucVc4n7ycBuizH9Zzd0z
	 aKD6iyJbrvBsV/DyEqi/jKZRpAQuwat0WvrN9AsWyxMA8i6xpqp0AdPSheCJJ8e77AQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2NjPj8hD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.46
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013046.outbound.protection.outlook.com
 [40.107.201.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D1884F800EE;
	Tue, 13 Oct 2026 17:47:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1884F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=2NjPj8hD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h7tfVNl3HLHeRNC6yBjIUvV+rvvpl4nLr8oA54fu40pzgjiLZrI6148mR76H+Zr20CIbhe8SlATDECzmrRVIhBZU6gIak4kA5Lhrunk8xDJxzhGlV5K6NbEvv/E4zjevV798MPG+n9jSvsQQT+tBMCrj3jCqjM9KgeRNBy/XioA1iSw8kS/SPo13aV5VxzjRKlyL1BcckmxneXard1mCbSEXBAZaFYtIIpAAs3lWB1Ya1B0btMqEhU4fWS3ZbYDzuSEXKYxNd4LSWX3OMDmsCA9d3aoRLdhOtLcK23KEOhg5IsQDhEW21l1FUPDlCu3s+8KDtZX6dlcNUC8KjuYK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gyTZvAOxGSx1g4nD8yBy+8vQkFWY5R3dv9QmY742BQ=;
 b=O5xm9dcjFlNWGvdWIfl4Kf4600bUa1r+J0t2kmWlTLfXxuWgtj4/ts9EZyYeaSWnOhLAq86NP71lOVQWnkqiZTHaSRrw1edJrFBDl6leYUCD75+RSE0ZLRfe0SMh/G0t35QcU/jtmdotq/zIQ+MdUCvdlOvCsPSPrmsbzwBgSLhjJMnz1kkblhMSRpAHPkwYbn/o0qQp2BSBBItyqymGZir3RkgrvLno/hpP6pKF47zDCGVc+2pqp9KByUbASZPaqJ0X5WG7XTrNQVIKXVVGTWCpwNe1g2gVBZ0lCoruBexukfpJOyri+yhynTYeRNMSCY8Eb8S9PNi0KXaotc57BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gyTZvAOxGSx1g4nD8yBy+8vQkFWY5R3dv9QmY742BQ=;
 b=2NjPj8hDFDdTZXOzDbLZW3v5Dpfb2snT2lQvJdFHW1IQ3yMr6CPXXtspI2owWacUm+fxvpBiVs5w5x+WqzJ4kjXyYVx9f7P3x/9mmBPyspXi/A3aukgpvviduEp+ORt151W+5vHmo7B1tbp6q7TtHQYRcneAjXDqiHzBD0u8GNw=
Received: from DS7PR03CA0170.namprd03.prod.outlook.com (2603:10b6:5:3b2::25)
 by SA3PR12MB177419.namprd12.prod.outlook.com (2603:10b6:806:53f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 15:47:53 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::54) by DS7PR03CA0170.outlook.office365.com
 (2603:10b6:5:3b2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 15:47:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:47:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:47:46 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 10:47:42 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 2/9] ASoC: SOF: amd: select descriptor per PCI revision in
 acp7x probe
Date: Tue, 13 Oct 2026 21:11:34 +0530
Message-ID: <20261013154644.3788064-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|SA3PR12MB177419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f1ff22a-47f8-4443-59c7-08df29415786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	PTRQdH935W01l1h8IEjyiOMMEBAWpLVZvIghvuSltmLNa1bSKxLmRIgi3f4dvUGP/13dJc6pF5G/wS81XjqDpOkugNAUpnQc7tkzMQF4KBKnr2suc9tYFjNH/iU51LyJw/ozKFJsOu6sh1i/nX2MzeYynvMlSfd/7ohSPEOnfhSOhtMuD/uclq4ftj+UYa9odakoO5Si5ehN16PL+imf37JTpx+XpVZK2pMf2W2s3vFV87+y542HxQbN9sVUBNZR32ZizZTd396t9oYAidRblW9gyLPHVn7iGHpduyYrJkhSb1X8Pg+1u2pUyVQNo5pR7F0W/APKxng0APcUA8b7YSyfZXLW4QBqERf8t8sc8s2WnwBPAv0aF4oIxeXCM0hUyBShNiNP2gveWRaTweUQo9/zllnZX01m0XeBXJ6XJRRIx+XeuNABsQpLWJjekhYXKxHsKW5dr8fuAgzDJVc2jZn6MBCpH2IxXHK6WJsOnrINC7PyyqH28Xp9U8DSOzB9TEzbc4FNfq//UEJBnDrdhSorK9RVJrgeIDHA3C10Mj/Wal6fjvKvldMyPKMzBbvdI2PSlDe5emTVosnHHuy8cxSxEZ88w1EfUikASnTKZG60519XhkPXerAGRzq+72J/2UVawB+zZ8HsLR5QBBzUy+plcpBQZIzcOTRvixu4wUpBf4jW2ix/JAZEqX4XOBr9
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	BQrDs0gX6gCELGyYQz+UGaVrheaXW27nYevKmJwosds1XSYQa1udQnOlp3yJfhCg7sTKaPYOQ1Z0v3lom51OdbBUOdg/qZFsYvJW+UyFDYDLyMZN3tUeSnSMn6n2Qq7NF2wWfQ5AMCAxFqZJKMFW0cELP+HSAmgDaX20YtHiIp7YQDxlHX4N6dzcmPHwJuFYYmUx2Tk9KR8/GlWFgP0DbJwXTHNy70TelH/36Ma4abMbHVRysY+xUTQzs9/rZA+AtIXYQGLCXaEG7gD7r1mbwJEJjV8le6hetLzcPOEXI5FInZlZD9dg6JAroYml1DYyK3nopoknGSkx5kLJQc/vekq3gULnaASCXZi7UHnZYHp+ObhQiUgpw/oBA6+3/ZGNxCrgFey7x5QitHOoTnijg7dxSB9CD1APN5/4Hbu+0s9EtFKXwzIrQov8ldBVghzV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:47:52.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5f1ff22a-47f8-4443-59c7-08df29415786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB177419
Message-ID-Hash: 7TOWEHZJQJO6UHGCDLCOPEYCOY4QCDZH
X-Message-ID-Hash: 7TOWEHZJQJO6UHGCDLCOPEYCOY4QCDZH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7TOWEHZJQJO6UHGCDLCOPEYCOY4QCDZH/>
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

