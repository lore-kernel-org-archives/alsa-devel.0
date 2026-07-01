Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC42C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:03:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D27B060284;
	Wed,  1 Jul 2026 12:02:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D27B060284
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900178;
	bh=1caopJiassJU7DG9mU5AFny71Qvov/FSHeqxpzRqnLI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=IZ/8iHQB/ZYZy4/E6+A/Qke48k1lLWS8eiho3bz79mckok9fh+oXHL6/v7m8TNVdF
	 V6kzCz/JCfWjPgdWzzGLb3L07FYs5d9j5Ejui6xGlyyhHHtxhgUeGlLkVXjhxaYWzG
	 dXV26Hc8QHfLeaFLeXhXT5IbVGH7zt5hozEGUBBQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BA14F80807; Wed,  1 Jul 2026 11:59:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E0360F80C15;
	Wed,  1 Jul 2026 11:59:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 369AAF806E5; Wed,  1 Jul 2026 11:59:17 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.69
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899953;
	b=KC+7SJ0ZA8SmAdYLdVBxQzQ/DOja9+Ub8TUwFi9YwcZsWTy64BOQWP1HuXjeTxObpf4G
	 uQ6rlXBEPysJFVs5FAjSdgU55FdjO5cr+rMQNWajuJXQWP0U9K6drLG3awxr739g/W55r
	 VFXUCz3hsb3/8ipS0zB0v6J8X+gI7bB8vfEPnUd8Et8t7/i2PqmHMSym0vqoOo7FjX/jw
	 QQGnzxmO+/5HAiksJ2e+/G22CKg1ShhVgJ4BQ7MUPpXPBvANXW8Oj2VcmFjSuBjUPU0+F
	 SusnyYOVPEMt0w+xU+6O6zfzh3Lyt395QvnN+lCoN8s2Xiq50eAxXhe9EpJ2ukaTwUQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899953;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1caopJiassJU7DG9mU5AFny71Qvov/FSHeqxpzRqnLI=;
	b=MONdpJuxeNCcju0O+cJjKjATOwRj2Tr++qH9Up+cdzWBaKDzWxqQ/DaJYQufmMO6Wedi
	 wpSWsThY9n7+PtMY96ZngmbrgL3HQ9DhGvzLTf67nnIlbyfW35vpS5V2doSnPHKJgLCOQ
	 Cm80hjVemSIoFq1E8r+ltmRN3ozbOONFO+I+5ZqVVt0QBgZj0z6lcdC2JYZphaJxL/HGH
	 mGQ81EPXmuySyh4jM+MRfYe1fKRU5FN7W0++AB99BfEAQTTHFYdXzg3Kd81myRKTVf9XV
	 0QZYLgalIwtXpaR+FvYvD5zCetRibodqu8kFiYE7oGivvcLifNDm/+kr5L595R9fLAg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=om125IAI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.69
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D9649F806DB;
	Wed,  1 Jul 2026 11:59:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9649F806DB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=om125IAI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G3iQOOHsBzTN8B5SU3p0HmzuP8Mx10Zw27iELFsABW4rLiv3LUm8jMvnQmjD0qfqnrtR3TDFQWhWiErNSizMhvHXoKffeu3w993gDh4NqLiHbxsuLP4kKe6h/ylrJeSJ7aoLRCQfPmm2ENg76Jy/E/fLbjdJ52MAHc4KVUBveaNs1mTiDRyZES14uzMnf0gPU8OIUMzlaBgmYkvelRRV0wnNl5Tn4YW4uMWVZSKDPgYV1yKLOByhCh5nPxFrgjTIyVlHYS7WIniEZ/ByHsaFlyIXKJ9Uo+W1QSCTfTzGddtmekatGE+aTf7CaTI+99n7ITyVpEFSOOoWplfcNWXU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3OleLJvd7Op0g1OS6ulq04zyLfNXmPXyMrE86T3PXE=;
 b=YcyeZcAyHR+sY03F0KweYclAtFBvbxzJAfqjcTRKzRkPBxew5DQHIaRxUWKHRHLvzvJujct7HVhBeeqyU9wgIozkuMUl40ILEKvReS8YxIhYlyHa4ji6e0SK7nr0Hfm2ycUKkWMzAvBi5qSg3n2nw1EEYBWGpQlXjR/2LO3Zl4bLPssVormXSMay9y01WX3MgOBHV5jcGlNy3nGPIKlRuHmAOMeWR3Ai7wrZHMIX1d7R4mLgBRacmRdaCijBtSz2kkxql85VyTM7NTJ1oZMnY0Q8rvTPgvlBt9u0BsDYefPPHlIoUy3Bq4OQfEHNIZZVGYzl7EkFUmxDZTtY2iu0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r3OleLJvd7Op0g1OS6ulq04zyLfNXmPXyMrE86T3PXE=;
 b=om125IAI3+mIwHOYsqMAGBgkPkT6M2Fj739uJ2RkkPI3KNqM8CLwsDJygMDcj8wRw/CNG2XQlR9EpS2qm9sTBxL65/jtN0lcyQd2iU23447QU9/V+EOGQAJg8i/+cNvYz5CQPDlqamKpqLMFTMGyjHzUVJF1jL3quX9uQB8rz4U=
Received: from PH7PR17CA0052.namprd17.prod.outlook.com (2603:10b6:510:325::19)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Wed, 1 Jul 2026
 09:59:04 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:510:325:cafe::5b) by PH7PR17CA0052.outlook.office365.com
 (2603:10b6:510:325::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:59:03 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:58:59 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 09/16] ASoC: SOF: amd: validate SizeFWSigned before signed FW
 length on ACP7x
Date: Wed, 1 Jul 2026 15:25:10 +0530
Message-ID: <20260701095759.1012929-10-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: e5b81aaf-e198-41e2-10b1-08ded75761f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|7416014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	Rco0M9IXelFDTBGrR/ZJxA0g41KyA2QAk1LyS8i5Kg4Bt3p4lGsDoJQk1Is3IoG0jGOioMD+Ej7dgA6e/Mteo22vvD1YDCeIylp5FP+okAT4EbLsGezl8GbZU5EEb4gWHVEU4ifodM2tuX4jWDHLjpJ0Mj/Mh7xh8eJC86ZMeqgNwrBwnCs3lQABJSxgriKAW0RFYjhWZuiaaeebWYWKZ8s5Oy2ftsTWNexhNK4VZF0dby7lT1K4hE3eB6b5H+JCmm3N7X1y/fhzWEJOYSeTLytqsJGYTl/5mErY8qMifP7O5NKGeEt+ebLrCgy80bRRkA3jcLM1UREpO1f4ImWrTBQ4V229/iE/m9zHaQUkZZbrzwQOZQj12ySob1JdIAkdiaU4Xzv1kvpBuzZlznbo8Uz6cSwvlBTAaHHcgUGWexQsaGV5m4WTwxz4U7f5zHmeMfQu3Ts2NSLHplFVDdJhpB52xKXcBgFM81iYWfywUawhfIr8DFbpZi6lMFdR9D9UrBhpLnfrvmDG7TNgR0kU23/EeGolwtucTXahH6qBvEZ2I91nQpFxskGnXHMrsray8W7YFbBfmlm5fupJca4oa/ldWn+DzDQdR2pPedxCnOSQObXRbTUR8YZEsPvSYk+XlRSoJl1HB8XyNygpM/ggZzu60S/bMdHmD3dBoH6nvY3J7LcS51NdIQjRy7K8+U7VndlmxEYXP7OCd7x/MLIyhA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ye3DqgdY1Yt9K2Nm+0cW5RzwZQydILLJdjZTBa/ZC5li5tbSXbgOwPo7+4Lur6JSlSa22dEZ/2Pd+XbXrpsO8NIRVF3Zja3KO78ejF1x7JJAuQiotcTFHsglNT6MYpb4JmWsPHon0a5VfEntl6oVPzkxTia/msAazg+CCIDdANUL2B7UsLFo6fKc/r1B3z0kKuUG2SeWwA1NrrFy34Kg5miS+YZ6U+cQ8Cl23ypetWqyE74WALqcpoSWpKlCg/P4WItk2ciYKlUvkuWBTNFtx+Qtfa0L8WcsH47k2fe3sfawKh6Pnl1NVSiPbpS9GPaH/O86Ktj4V7P+6aUEy9bSx4f4D9/ykZ06Kn7kdFNu5acGxL/L/4VShXXxlK0Lo2RP4Nx91lhIreADl6Qd9BJHsbuRnfmTDMO1iBVamk+YQ86HKjWiNcQt9ok9p6E4ycHm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:59:03.8145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e5b81aaf-e198-41e2-10b1-08ded75761f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
Message-ID-Hash: ODVKZLMTH7MP2ZYY2YJ5WWFTMILYSUZU
X-Message-ID-Hash: ODVKZLMTH7MP2ZYY2YJ5WWFTMILYSUZU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ODVKZLMTH7MP2ZYY2YJ5WWFTMILYSUZU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The ACP7.B/7.F ACPI signed path already reads SizeFWSigned from the image
header into size_fw. Before adding ACP_IMAGE_HEADER_SIZE for SHA DMA,
reject payload size zero or any size_fw with size_fw > fw_bin_size -
ACP_IMAGE_HEADER_SIZE, so size_fw + ACP_IMAGE_HEADER_SIZE cannot exceed the
supplied firmware buffer.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp-loader.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index e4a17e6656c0..76335c78255f 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -183,6 +183,13 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 			}
 			size_fw = get_unaligned_le32(adata->bin_buf +
 						     ACP_IMAGE_HDR_SIZE_FW_SIGNED_OFF);
+			if (!size_fw ||
+			    size_fw > adata->fw_bin_size - ACP_IMAGE_HEADER_SIZE) {
+				dev_err(sdev->dev,
+					"Invalid signed firmware payload size %u (max %u)\n",
+					size_fw, adata->fw_bin_size - ACP_IMAGE_HEADER_SIZE);
+				return -EINVAL;
+			}
 			size_fw += ACP_IMAGE_HEADER_SIZE;
 		} else {
 			size_fw = adata->fw_bin_size;
-- 
2.45.2

