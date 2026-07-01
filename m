Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FACC43327
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:01:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0147E60273;
	Wed,  1 Jul 2026 12:01:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0147E60273
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900105;
	bh=pLmevQXBvtPnAAfwPH4Q8Yreou4Fu4MPkcxZCPsqBCA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HCFJHu4IgV4t+xgwO0Vt6uCkSGlE4lU3mLxIBCp1Wx5a9gUYjy3tzCnlJF0i8jE+K
	 Js/bGkxXD39hXiQQHx/ABkJD3Z6EwO/Tmyv4o1ShPj2Z5wsS/j6I3sTuHqpWQfPy4e
	 9Uks7/FPNAFfeiY7eCi7TxU5d7QS0wKSMdbQAgsk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 26639F80733; Wed,  1 Jul 2026 11:59:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A7BCF8074D;
	Wed,  1 Jul 2026 11:59:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D579F806B8; Wed,  1 Jul 2026 11:59:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.10
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899945;
	b=oKHxymeitP7WExz1JPYnWKVDtaNZliFXbf1ExK88CCKwPhnsa20ZNCg14pfy3fA3MB83
	 uEZLWUieo9OmR4OIyYxm6gCr6qUEOm/i8t38GwM72Dl3FVIcR5G1Uh7kj4UYZR7HqtGtU
	 N2iRKws5UixMFJjCkWf9lvaejQBpqr416ikDG6Z00eSgnd82RDh/x222zcCCqDvryyBMF
	 R787GKPcqrsJ3gLtJdBt5i37CKRXtWN9+itAszTAVtqexpSsmIFSMIocejHPKIkEV8jdj
	 2yy/87AMDXi16fUczkkoIWOrJENBqcSh+kdolGr+RqHCqC8OHvnfPyFqSPGXcDJa2aA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899945;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pLmevQXBvtPnAAfwPH4Q8Yreou4Fu4MPkcxZCPsqBCA=;
	b=sOjmCcsstr1+mFsvmvMP8rFmE7P5crKHq+NlNG/eoc0Jf5S1NLNB4Kkef+DuSFmosZr4
	 PokTMYB+TcyrNXm9t3e6wpQbCTg6jYm55g0dXCFNuV6NuQoKNkm/RhFSAy0h2wEqjvKwV
	 SbjHLKYgB3Iyzeq8aX/aWR510kSkWVrNgCY+hSDpl+Lk+RVeV0plACX8CUJC0Vv8TiMDH
	 M/WQezyVWnbK3CWdhOAOFbKoeaL5LhzW10iPHz5F7BKbP6baebke1AXEDcMqvQx2w3fd5
	 /oAMXSo5EfBxiSI8jomlCWgKYdH84Ymr/6XoC1MhD3zGH4hzE4iyOdrWjJ7ETS9gPiA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Xq6bJXCr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.10
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A7F7EF806A5;
	Wed,  1 Jul 2026 11:59:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A7F7EF806A5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Xq6bJXCr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQipyj5r/sgSCNzN5ZGMNpYkyAxGs8wlwSF5tE22UYlym/d3m/PuK6tEdov+zy/NmOSzvi2Nj8E3xvGuaf7zaAs+NV8Fzqr5YVFQ0No93w4sMxLfkrFnjh/SdtdwdmPrIpICfuz280v0GkCxF9t43hq7NDeO5dD/r7qZJFmoLPT88YyXiAtMB5OZ8A3AcwXkFaAmGtASK0LQobeLCIaT0mmDrq8ItIbgisj+TNYpc8fmBjkaSjSDTkZFH3o9I/tp99FChHqwD4GkmppoMBQh8vD4uTE70/IdCdvKC/c6Dpoe57VDz+SppJ0q922IWOAQTwxUjYsr1OZuR9UkSVN0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTaZwC4o/U+2xTW8tfgTqgpSCmEzHiM9+pjG67t7gj4=;
 b=fVBBOj33ft0pN8lahAu6wnjyWKAzj/dME0+sCgyWNwUAv8qxuF0daSyTBEjxoG+EmOrkQjlcCyICicR0PbaSok8I/PCCvSrRmFUtKkS5hz1uXWH5VxwmgcKaXIxT8rCUGrtDfiq9/2+X8MATzIAVwDZzWtniC2G7/DOo3221UmfaWtuSz8wzK16o+6452UIyL/h2fabTQdSDxF+nMJzbs02+ayaJMBFEPmXSDqh5tVtwvaQMw9Ie72XDlIkD6VXCpMUnv3pvZ1kc4sPAfrjkWL65E1YTyQwsb/4Mi7VOuYgDrBvlin4l1ssrlcxIGwJ/XU0+QvKtPjyzGPjm+DyInQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTaZwC4o/U+2xTW8tfgTqgpSCmEzHiM9+pjG67t7gj4=;
 b=Xq6bJXCrlDdqFoECVL7Mg0Hf1lFR4q4DG6vY84cvKvoE4QfJwLizahdH1HO+z4Ukaov7G5ndMUlSlrcyZv+DRglIPPbyCPnqLvZK2KjILHhdA3MsUBrsBmw+eQDowNlNQ+igH66swez7fmXF/17JWK4CLJZSDq6Hr9wRdhB1Zqk=
Received: from SA1PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:2d3::7)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 09:58:56 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::33) by SA1PR03CA0008.outlook.office365.com
 (2603:10b6:806:2d3::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:58:55 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:58:51 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 07/16] ASoC: SOF: amd: extend signed firmware pre-run for
 ACP7x
Date: Wed, 1 Jul 2026 15:25:08 +0530
Message-ID: <20260701095759.1012929-8-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e95f40a-d1bd-422e-5e9a-08ded7575d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	3U96bbYnVHfME7nfXQ8bqH9bDf9C41wjSYH5Lywfnf2n2+9MSXvYDvgS2ayck0BQ7II71Fl8YiEJ69UAEG+80ovbS2cq0HLnYbBObH4ZFr3pUu07kEZahDn7KthkXdHmbz/7/3YfidHm2qE605EC0Z2xTMjyp51Keg4HOIqrhzXJ7e2POxugl4UCOj+kCLf+fw4YPzF6J1iPxJDgkRK6BO1INv9JjcBiwKNJp5AdqBHuSVD3fCpimx22FCMojemijhr+robrOVFlxXJhOmdnnbM8P8qTGGJTQLvcBJenVZrM22RIHEd4XRX1CTwgqxcdROfvUnn6yakHK90oxxEfwRfwdkQncx7xnMHnsVIXoZ79LTnpeyn8Dq9RMlswGStKi4hVAwj7wMJJbQrAlUM5cc2UoDlLKGjWng8ojwjCT+uPka2q856KhUVo/Ex8jM55/hQJX1x+VQlBJu3ZJCpIPKYe3kBjQcPW+wvZpupdlPX5RCnJ4vi38vTkSm8H+tDCvG1cicgmQ58Mz+7DrThtezGtDSP/3nk9ub9OklYldV7/3gq+pONQf21Jicf6O2hJXmFg27oVysrlEpKGl7LjjP59iW2Xojdt4Vzlz7MxecAYo4FokoKgo0Gmt/j2fCsad1d8PsGbb6Rm/Bc/rJxi2xEHZDPaJwJqZoqkUJmAYsLabwCz788WYHryl1Oa0BqbmHULLwkywEFXHwCtSnY0Rw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	12aOODwbuXx9wbZkPVMWb7uutABiZfiIHdznrY4lhlc7B7l7ysGT0mAPIMFNwJMbqvweftaR+RAhvDctU2NB+rDyprlgMCHpOJ1qOOiG2BovYEKYd1X+M912B/AcbTXhw12vWot9DENnfuUTrZGHKrGGj/KLixck2lzec1IxKHUzOd+YCQmEnI/9ZxNV08pj2tDFN3jW1cWnGCnIMq/hfeqN/8QraTk2kl8ferz+hB9pbj82ndM5/xZSptzFdSRgT4MCm7SVE3nwAAkcnc2mAHyNblZ4/9BFj/X2XYhEg48otCEmDGWee/hiukuc2gLK2BlcD+mq5qQrxx4cm3oA6Q6IKc14nCGOi1TjFFSQa8c1PAHQTtaJhjUN63v8p8CEX8oVhEbwTG87ucBaMx+qfZR88R3v3RK2yqvHHt5htsvjH8X4pKcng7lJ0AiQLun9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:58:55.7173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4e95f40a-d1bd-422e-5e9a-08ded7575d1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817
Message-ID-Hash: EP7CFTAQUAXWCZADEAO6PG2CBR525R63
X-Message-ID-Hash: EP7CFTAQUAXWCZADEAO6PG2CBR525R63
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EP7CFTAQUAXWCZADEAO6PG2CBR525R63/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Parse SizeFWSigned from the ACP image header when loading signed
firmware on ACP7.B/7.F platforms. Keep the legacy
ACP_FIRMWARE_SIGNATURE subtraction for pre-7B platforms using quirks.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp-loader.c | 14 ++++++++++++--
 sound/soc/sof/amd/acp.h        |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index 98324bbade15..af04f053fd65 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -14,6 +14,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/unaligned.h>
 
 #include "../ops.h"
 #include "acp-dsp-offset.h"
@@ -173,10 +174,19 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 
 	adata = sdev->pdata->hw_pdata;
 
-	if (adata->quirks && adata->quirks->signed_fw_image)
+	if (adata->pci_rev >= ACP7B_PCI_ID) {
+		if (adata->acp_sof_signed_firmware_image) {
+			size_fw = get_unaligned_le32(adata->bin_buf +
+						     ACP_IMAGE_HDR_SIZE_FW_SIGNED_OFF);
+			size_fw += ACP_IMAGE_HEADER_SIZE;
+		} else {
+			size_fw = adata->fw_bin_size;
+		}
+	} else if (adata->quirks && adata->quirks->signed_fw_image) {
 		size_fw = adata->fw_bin_size - ACP_FIRMWARE_SIGNATURE;
-	else
+	} else {
 		size_fw = adata->fw_bin_size;
+	}
 
 	page_count = PAGE_ALIGN(size_fw) >> PAGE_SHIFT;
 	adata->fw_bin_page_count = page_count;
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 46b946132de8..c2f3add05d0c 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -113,6 +113,9 @@
 #define PROBE_STATUS_BIT			BIT(31)
 
 #define ACP_FIRMWARE_SIGNATURE			0x100
+#define ACP_IMAGE_HEADER_SIZE			ACP_FIRMWARE_SIGNATURE
+#define ACP_IMAGE_HDR_SIZE_FW_SIGNED_OFF	0x14
+
 #define ACP_ERROR_IRQ_MASK			BIT(29)
 #define ACP_SDW0_IRQ_MASK			BIT(21)
 #define ACP_SDW1_IRQ_MASK			BIT(2)
-- 
2.45.2

