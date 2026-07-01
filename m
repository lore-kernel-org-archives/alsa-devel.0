Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02412C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:04:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52CD6602A5;
	Wed,  1 Jul 2026 12:04:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52CD6602A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900271;
	bh=7D1vV3CwaC4rMfy9wG8tlU5bV/g/kB4qN2CZy4aQYmo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YPFtjufuKa+94/Go0lXqg2vHedDNDpVAvRbfWCiKuSxZfrC7PKxZiZPpbcy0Ul6cF
	 HhdHanEOZ8sjXD9ZvEiblhI+yQIcfzFErVuDfEp0JCEADmpL3aNyGWCtOeH5cochpw
	 MorKKkYadDFhuMkauelbJUgg1D3pldm70jX7EIc0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43142F8065B; Wed,  1 Jul 2026 12:00:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 31382F896E2;
	Wed,  1 Jul 2026 12:00:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F519F80803; Wed,  1 Jul 2026 11:59:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899967;
	b=MJoJ051AP6+zZnvjciSO05pAYQi/OSIMtXqjTTQ9NjydbaLNznyHa48OeXU/sBwTFWMj
	 qoECYGSp/oc6LLTt7Z7gYTsCr01sd6CSqPTatFxPSp7CUtp9IsqtkVSoGZjlxNkoDv2ax
	 MTQ3hBu96cthhm/VdIf7pC+yY/yqbjqrgnEKtY8vpahvUnc5sdk75fMvYUGlY4FOfJZ8X
	 dtmh6y2GM8L3VZtYiy21q62vg5gdCsrr2vDcnskNc7bDRjyg7arz1IdSUDmJi9g72XuLD
	 1w9OGH+g78jcFYyNbD6pfkijCjFl4cr66AB/+sqiKgvHBta0HlTffwm180jRX/kA/Wg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899967;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7D1vV3CwaC4rMfy9wG8tlU5bV/g/kB4qN2CZy4aQYmo=;
	b=jfhbraNJK1ylahiVy5LYuo8vxdijUoCUoVh60Sg5EKkIg4Ljn0AEVIPCLtqd9NyEQVlk
	 6M6svFjVbetMnzblCc+BSe8vT0nJ3G/6gUKNngQZW4usFS5+R4Kdp60wEIfUkW4g5cL4Y
	 z8weN2n13ajdHNUU9OcFtakG22jYlqvOLjs/1wFf0rpHnZNXHy04QYK8VSz8dUsi6Q+8I
	 okenic68IbTNyA8gh7r4foB/SY+nfIvVHFhvutZrlDRdEFtmc3Fyf4xAeE7Oc17Vv/3eL
	 8GY1QKhOFSIMIOxl3SeymOAEBK07g/Ceeq7/rE/8xaVNfNS4APZ4+Lbb/zW8gwJehTQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dlnd0lkS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 75DA8F8076D;
	Wed,  1 Jul 2026 11:59:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 75DA8F8076D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dlnd0lkS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoW8N0UEtegeJrAEB6swoyco85I4SD9c/1S+L/0RSKi+TER/8Q4soOs2sdN24FWyjSgW89J6fmGWakRcWb/vcWMDohhUc4RZ0BVxJfMiaEFbuoQlyFuwEl6SlQ9LWqdCWmiVdF62WOxUgMohDmjdeHsuK8vhicB0oUbiEPA/WJoexp6GZNX3IVORnoQ9oKl6zunctoZLrwsbs95AUh5GYRZMeFKhCW2CkN4fHXDmbnooRjrEb39anr6a6PU/0J8cswkV2EORwVW8HTJkAYhfYdsLD3s1grj+z+eNrn7DtHpSuX++4XCSxxecGoWj9fEn44Wg6q5DQnm8/wYCfCQcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJqGQKUdP+pc60OfxrD7PmsBi0uxUii5uqY6kOTNN/0=;
 b=YfdoNW0cNrdytcnPtxJFo3asDeUtsbcrq8tB4B/IiDECt2h/HhnHT9nI6BUNpZa4gzEsRlRXth/+clpBUDwcxKFNVEFfzRbU9g2Yol4h1okNRNqhT8LdP/3uw3/wgnez6tI40NpDbQ5QIy5sJNDjUmFqUDRzV9LGgkkV/xuF1UsbXNGF1hlkpvHmp95wMVTZohankzanZeC1hc4nDTEh57XYk3xFnEqcYwTbYN7n5XU0F9T/1JtBNzYSsElttQOGTWpFVjOofQJX5/jEvFav0oIZMwF8KReKN5n6e7EgODRQPMopY9z/i3gbvLpuNY7n1iL+6oPRMflCAl+rQYhJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJqGQKUdP+pc60OfxrD7PmsBi0uxUii5uqY6kOTNN/0=;
 b=dlnd0lkSSeS9JakisxBz9Ucn5fK3SE84m2VMVQxuFoHQY7hz2FhUXoi2RWSeiLXprOa/VXj1pKmaznsHbXaznrC07qwCU1wY5uZ5nJLTCJBUD+UO4uJMQ0RW0uJ6Up6P1AIlKrpxRaWYM/tIX8c9oUCX4t5FBWRoXkR64F5Mlu8=
Received: from SA1PR03CA0010.namprd03.prod.outlook.com (2603:10b6:806:2d3::26)
 by IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:59:19 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2d3:cafe::9f) by SA1PR03CA0010.outlook.office365.com
 (2603:10b6:806:2d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:59:19 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:59:15 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 13/16] ASoC: SOF: amd: load ACP7.B/7.F signed data firmware to
 SRAM
Date: Wed, 1 Jul 2026 15:25:14 +0530
Message-ID: <20260701095759.1012929-14-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: d9237e26-cd5e-4e6d-1f4b-08ded7576b65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|7416014|376014|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	MO6tsUa2ChPlyJtwFIkRmzC0R6Ykl1KfUzLEO2JHpT4GPanClpKKl3iy0Yqdn18zrBy4MCtanMBY53cn/EUqzz3Tg5DvApKnul4Z+bm7mSnD5UrgJEl/9ZywM4pMNPy3VReFALbQK5vXPtoK8PHexa5hyiZRX6Q0vtTCWXvs/TQV1tFdTNDBMnIqxagkMGMAUp4hM+lUT24XUEr6JI3ECzw9ueiFFKh6tflfo6Z+vxFCOKM6INEU2wKI+e1mWGBHe0KjndbXvyFI27YO3PTFrCfj98NaI/ZXN8TSlm7+78GE4xDR9MMmruLKARTmpSmSqPNSRXhDuxwt6YOlZciuaaudymGi+mSCFICHk+E5H85M+JP9PgBYnlUlZMwdqDlvi6x5n8bnfJAFPNlOxVysDHJ2T2dF9kCaOn8L1rj81DLxrGb/TBy/BzcLoZM1IFYuShMyScKxMZqzGx01czpRIU8fpwk83NBBClSQl4P2HxSeB7Dl6YyOpUQ5LbMB6ZUQ7/hjN9pDkuzdSEVOYMot6/ueHD3dCP+1oyTiMAtZkHF6Oh/6NCyLbATtmrWjhnuV8rfOqW7GrtwCDwBQd3r6k0x8z6vbCnnl09hcgQ3EOmQ2kM6h8o5nzEfKOmw5M/qV+4pT7uJod6rboKcLrtqUC7VJY0XLBvmHri5V1u1f21RDSKMXJOoGMYmHVEviNsHtf7kfdzpnjavwiU3seEuh/A==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(7416014)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	qDLg6wTUSAM3fUZN7p/lTYUcaJ4cOOpXlnfk3Wxz0tsB87HxLw4EBarIdsMTkJcTVYGns4kIurEFEuS4HoaWFxJmZP1nrZrak3SEmkcu77UN6g1gGttMO4J/ruyC4YQFExnPDe3eZLqDfmNBdqYtEPXAiSVVcK2xXuOpl/Kwan6YyP08HQs0wz2mT5DkRvRpmpMAbPbCM4FbBrgpScWpriWBL6HyXju6u3cKS51LqJRYEf2Tss8t93qSp0ezvItM7qUXgqMqTG9eRA5vnTsrYxyeW719+leNu6IbWhNeHZ7o7L8vQQF5hwPvBpQXzORbBbqU1AliZZFBOLIBYSywg7qAoJnsOhos6mBp8DXEGubjMExwuoLSs6vJggb4Y5edWiBUbDXH7x37Fj1j4KcBTqCxkUDcBiCYPcEk+eTO42RqRXaj20knS0GGI7tZrOQK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:59:19.6500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d9237e26-cd5e-4e6d-1f4b-08ded7576b65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785
Message-ID-Hash: VVEGQDHWSVWD4ADTBH44Y3RB3NU4RXOT
X-Message-ID-Hash: VVEGQDHWSVWD4ADTBH44Y3RB3NU4RXOT
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VVEGQDHWSVWD4ADTBH44Y3RB3NU4RXOT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ACP7.B and ACP7.F signed firmware data blocks must be written to SRAM
instead of DRAM. Select SOF_FW_BLK_TYPE_SRAM for PCI revision 0x7B and
above in acp_sof_load_signed_firmware().

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp-loader.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index 76335c78255f..f1ec85694323 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -334,9 +334,14 @@ int acp_sof_load_signed_firmware(struct snd_sof_dev *sdev)
 	}
 	kfree(fw_filename);
 
-	ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_DRAM, 0,
-				      (void *)adata->fw_dbin->data,
-				      adata->fw_dbin->size);
+	if (adata->pci_rev >= ACP7B_PCI_ID)
+		ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_SRAM, 0,
+					      (void *)adata->fw_dbin->data,
+					      adata->fw_dbin->size);
+	else
+		ret = snd_sof_dsp_block_write(sdev, SOF_FW_BLK_TYPE_DRAM, 0,
+					      (void *)adata->fw_dbin->data,
+					      adata->fw_dbin->size);
 	return ret;
 }
 EXPORT_SYMBOL_NS(acp_sof_load_signed_firmware, "SND_SOC_SOF_AMD_COMMON");
-- 
2.45.2

