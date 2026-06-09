Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F803CD98C5
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 16:11:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 81F80601E6;
	Tue,  9 Jun 2026 18:11:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 81F80601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781021473;
	bh=z/CE5vNqfu++6kTiarePv3ecU6JXxFpmOhgRJN9G2Ks=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rdOghCE8x1DNhA7gwxcRRneG+2M3J3A6f99lWAN6O78QM5q81AIWUjGDTGYrEPkBk
	 L0oHSq+l20U4v0HGXgRY9JmcIfkK6l1nPn8pbSPHO6nsjmPF2nEVdfZ/HE2oEo26nQ
	 OB5HP7ZEp8Cfi/2md8GFtF/wmmPgM9UYUuEcCFH8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 328A6F80630; Tue,  9 Jun 2026 18:10:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24C48F80635;
	Tue,  9 Jun 2026 18:10:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 91AD4F8003C; Tue,  9 Jun 2026 18:10:13 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.56
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781021410;
	b=YYFzKDWsmiIGIzb6SafCoZfNMvcF3E92ER1SUxxo5f05QstO7L57mgPIE/9EXpBz8aI7
	 HY6ehP1A/2WGV2COeaPLBVHeooH/p6lyY4glK6pbiSWVrNr81BXh8cup0mjWaKn8hQM8A
	 CUn7ZfxiuEro9ZhaKXX3dQM5syXZ5P+aJYDrZc7zR5Mw0/MLjsiYE4B6vJc1Ru+Kr1hef
	 AfgyJZHh/4orY6mg6N+fXnQaOFb0DMbxqJ3MJ38gVjh0RQQTp2qrfDhkn2lPu4Q6lXwn4
	 4tCA3e8ezjjfxwPJwjJ8SNc4SBJ1339bH7Vcfl0KuQrfRDXpWv8rCoTmsEZbAmxTsKw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781021410;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=z/CE5vNqfu++6kTiarePv3ecU6JXxFpmOhgRJN9G2Ks=;
	b=VDp7/EweZcgo/+dhVLMNfELCuNNjEup+FzJFliiQldXxH+Q8CrxzQDiZ3mW7gVn+asl6
	 3RbNl3oKiUemHhJy6GJssGCLJxxwvme+7ZF3zfJZLFvmhh4I3H5lEPTTjIoQTnTY5T6dU
	 hqWR/HpAukZLbx3xeehtxomcJ8MmZhzixn6QOylwm+PpYXEI0+2I2bmYeesM/LtpuMjgv
	 qYJH295P37fbve7t6nHcIoDlCyjWoNk+6QfpHGaRsS8eKy8VR00R8HVQPPnPHButSdiE7
	 56u+XDHDO464EvwcqxzfKYRBSmqBhuDGSYpWh50rtjJtJF54hOnlu+9FFFSHlAbePFg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=c3Z2LUhx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.56
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9D6ADF8003C;
	Tue,  9 Jun 2026 18:10:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D6ADF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=c3Z2LUhx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0Zx8DR9WQIpCYMq895Q+ZaqLA7pqvZ+houSQd7dEd0NqzBk6dYUSGBtId1sOIJtwSc61ucSbDMsdMRLy3q5q5oj71sXW9kBKbnZJ1RKOelfRCfkMcfNhM3fKxrpTVLXTM09MTbbbU28OFAhftV/UXH5HoXrRei8s52P3R4cGGsHFEb2TOTFzqLrM11lCsHm4LdWohEahUDpKpF0ySXN8GcYlhz2aqqsqhFLf9vN6K3NkTG3u+gyHxw7Crh58fzPF9+ymNS9zvuzeLrNhqcU4vdgGLKPCMD7Gi1M9upDT51f7lLmpyhH2pBbpan1ganq7MqQXj/WbQ8Xj3vchOpekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBdHeb3AyFJoA3WEf9mV4VfQuhEC4c91QjIZCxACVO8=;
 b=vsHrdZO4l8ioP6QhteYjlIIyFGmJS+gky+3atgODEv1ZcymXp3k2q8wBuIL+nC9XXLsPwZwxb2WoFTnwHKI0DvH4YbLzR1RV79b7XVf5yv1E7vIQRQXbmuUVeLAbjCD4N3PWUrZ9SRVaVrXUaRSUQNIuu4vmB5N2iwyvKQxFqHA6Hj5UO/DiiNERqXj1+Oad386ZgxFvzb76rEejml7YDQH6CiucjU06e7IZ377bvxKUeK3cAiIJwzddMzIAqEAUGi1o5iHafpUlUq+3EBqFq1NgWIgfV4xiTN77cE8UuUUzAMdFaGROgfd+/tH9UyNp0OIsXrAY42y2zWAXEmDDHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBdHeb3AyFJoA3WEf9mV4VfQuhEC4c91QjIZCxACVO8=;
 b=c3Z2LUhxENB9VybmZ+JMb/KaRp4Ebj9Fh8qUdemG61ApikX56ZB+1mbnZ6j1DlIyMFzO53Q8eZAv2O9Kb7381nrVDlXdiP6PmDv3tF2PFXBJMKj/TZbVfEF8E+qOTPCDBNL6wgIfTsZ9ocQsU6ZRzL/3yOvAOX15kKVtx8FKIn4=
Received: from PH7P220CA0157.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::23)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 9 Jun 2026
 16:09:59 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::20) by PH7P220CA0157.outlook.office365.com
 (2603:10b6:510:33b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 16:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 16:09:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 11:09:58 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 09:09:57 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 9 Jun 2026 11:09:53 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <ranjani.sridharan@linux.intel.com>,
	<pierre-louis.bossart@linux.dev>, <perex@perex.cz>, <tiwai@suse.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <mario.limonciello@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<uajain@igalia.com>, <sound-open-firmware@alsa-project.org>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/2] ASoC: SOF: amd: set ipc flags to zero
Date: Tue, 9 Jun 2026 21:38:45 +0530
Message-ID: <20260609160938.3717513-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260609160938.3717513-1-Vijendar.Mukunda@amd.com>
References: <20260609160938.3717513-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dfcf4ca-d573-4864-63ae-08dec6418d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|18002099003|22082099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	A7vVucknyb1n0DnLl7j8zgydrh9J31jlqAXSOBBnK7FTqTYT3LOgwmASFoKy6AV3YC/PErDB/U5zy7BNwJl/bNXQlKJitmmB8cE7/9gQsnCa/Dwwx5/Ztjv6UySmfj94XtB0RQwnX+ZIc7LfAc0jtsDHYTdbFS7xECIkzuiJdnaioaP0azJw5uuv20vvPBim/IW5jwQNd7jzAthz5OzdkL+YtOT2DlFdgMlrapxtzdO15uNklMFHOa/GyJUM0Vw6qkrFiovGcr4PfqioesDMfWCJNQ1hJtC+iezQDnzMw8ZCsr1lRSFItwz2jifWTW4aTFJw8EVoVZcQOeFLBqqU5is/dOdWKlVCwrenASOZjoeHZImH4xlhCX9bcIhmmWkJijruu6aaPN3NE670F3yqE8se+sSXLyQL8OyXc9VFhzh6xLhD/mgcnfDJJT2myizaS8kxsg4yNHuTOV8aMU0QYyPTDhhl+rzA7DuqPBBm/OV1MKGrZnarlnFNtrxPA9ocry/Pe9HVIR8qjhoWivrVglbT1mrpXqzhd0dVWVHs2HlY9v0APOdI7kMHqdGg+DkjmZs3iK3WF0qrOocNoRE/+2qIUXtZk2CQt7z3Ar+W6SLZWsV0fafWX8F0ouJFxkbUCU5ZidCXMLuFOSqWw8fl3elHIsO2BofMAOIq0rfXu3Ab6AEwin9b+PGbwRX39u/g0Cpy0H/jowregSNBhri6xMXE3dTYtWIewFrGPvFMuIk=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Yl0wWQvengM1ptbmgz1TzkKX4xctwv+UN97aHSpDEdzsUMbUmFRSb2JXwBhlejQnpC8zBiQDVm2dxJJubANwCWrmWEEorWfHJ3ZSjiqkS7EF+D06g/EG4+5wu3w0BmqQZfpPWhckKkBWt70n+j9X7qHnjrTFxYbaPdfuOG30D59OcMDVYrfzwQpbbLdrVmncnQSuhHdenRhA1B7R2ZkE1MwEtX9zTthMEW3Ozitk3ydmn7IelCJi+/cF2A+xK7A2jnlR34vC6hufoxrM+JSM7mEA4nZhGOFvP42sjZSwWZYy64g25a/E8EMAkrdudUGwR6YKY8wM0y20Y5+ZKKsbnuALPkjEpZIB9kFuq1Qbb+i0CY1oca8QWrLrtdNVISKm0iM1pOpH8bGKHJ3d/x6+vxbjGSjOdHvhwttqqnUUxOQxV+hceWz+dd2w++Ogtg4+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 16:09:58.2554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0dfcf4ca-d573-4864-63ae-08dec6418d8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
Message-ID-Hash: PSQRF64XCNBUMKTLKUUV56FVMDMCA6V3
X-Message-ID-Hash: PSQRF64XCNBUMKTLKUUV56FVMDMCA6V3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/PSQRF64XCNBUMKTLKUUV56FVMDMCA6V3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

As per design, set IPC conf structure flags to zero during acp init
sequence.

Link: https://github.com/thesofproject/linux/pull/5642
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Tested-by: Umang Jain <uajain@igalia.com>
---
 sound/soc/sof/amd/acp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index f615b8d1c802..e6af8927baa0 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -377,6 +377,33 @@ void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src,
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, reg_offset + i, src[j]);
 }
 
+static int acp_init_scratch_mem_ipc_flags(struct snd_sof_dev *sdev)
+{
+	u32 dsp_msg_write, dsp_ack_write, host_msg_write, host_ack_write;
+
+	dsp_msg_write = sdev->debug_box.offset +
+			offsetof(struct scratch_ipc_conf, sof_dsp_msg_write);
+	dsp_ack_write = sdev->debug_box.offset +
+			offsetof(struct scratch_ipc_conf, sof_dsp_ack_write);
+	host_msg_write = sdev->debug_box.offset +
+			 offsetof(struct scratch_ipc_conf, sof_host_msg_write);
+	host_ack_write = sdev->debug_box.offset +
+			 offsetof(struct scratch_ipc_conf, sof_host_ack_write);
+	/* Initialize host message write flag */
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + host_msg_write, 0);
+
+	/* Initialize host ack write flag */
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + host_ack_write, 0);
+
+	/* Initialize DSP message write flag */
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_msg_write, 0);
+
+	/* Initialize DSP ack write flag */
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SCRATCH_REG_0 + dsp_ack_write, 0);
+
+	return 0;
+}
+
 static int acp_memory_init(struct snd_sof_dev *sdev)
 {
 	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
@@ -384,6 +411,7 @@ static int acp_memory_init(struct snd_sof_dev *sdev)
 
 	snd_sof_dsp_update_bits(sdev, ACP_DSP_BAR, desc->dsp_intr_base + DSP_SW_INTR_CNTL_OFFSET,
 				ACP_DSP_INTR_EN_MASK, ACP_DSP_INTR_EN_MASK);
+	acp_init_scratch_mem_ipc_flags(sdev);
 	init_dma_descriptor(adata);
 
 	return 0;
-- 
2.48.1

