Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD34C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:05:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F14F602B6;
	Wed,  1 Jul 2026 12:04:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F14F602B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900296;
	bh=9b840sijRBnESRkNZbf7YHTRMd9XVWTeD6cMe7+IBnE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=arW/OUIw2shMjXNC6gVAAYo+I8ncMg3/uBzeXM9m9OQ7iL81Z1oG1otRdvoPLqMF/
	 t6XFDlnH9Med6PVr1de2WfuyooKxr+50jnEPSSfuocfd6KA2syAisf/52qa5kKklYk
	 CtzMRur+dhPYOOPxzQ6ovXsDR6K5KRfkvisDdJSo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 42DA3F89709; Wed,  1 Jul 2026 12:00:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CA184F896FC;
	Wed,  1 Jul 2026 12:00:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 999A5F8086C; Wed,  1 Jul 2026 11:59:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.31
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899974;
	b=D0CgRi+mncLI2UG+EXITRLsNAQDy4eicfx3bh1yP/M/RRwrjRi+ApS9q/kb2TwGq8/U8
	 kn/IMyJkshpM8g2XxxcNWsAFLT9g0tA3oMWBQyW/Ib9b+OPfAYxPHxzyZF4EWoS42dD6X
	 VH0XmxUF7XYvllOS8TJTNy3htXcepkOE5yECSH0yZgtNcZacZGk10VII+j1UdPzTr2DbG
	 v8+NgBxZrGnsOvCWpdRbwm69WFBLW+hdFLVmhERvP/8gfZj5ZFzpGdJyavw6vv7W2VvKK
	 pmS6DQpxVkZb9y2axfN7PE9IbKwwWfxNv/o0rZM+gOYLOQrb62LEUmNtuWJavindfjg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899974;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9b840sijRBnESRkNZbf7YHTRMd9XVWTeD6cMe7+IBnE=;
	b=ALqB6U3Tk4v7nEKQHrRE3hDNDMhWjb5aEw1ru8QPyJ6ElQHuJ4TUvqiXcegB8Z1wUhIj
	 zBE9DRXJlatW1XiQJ/uSOGHKNuwh6qRo8SbfuaGg63ifa34wgdViBk+Pnuuw9ouTr8Wn/
	 Us4//vhPWVLyX7GoMsXytZdje1PHILJgqnQf3NdmorbW8jfv/af54BOYLd0n3UD9s4Y5j
	 4xWwrr/KHBORBd/3xFaAtnWol0d0Bk84yf0LjBilISnl2iVHNVL3Og0XXXLOwNS0fx1u3
	 4DFvfMip4pE9EY2Pj4TQvV03RVokTesRaoUM3ed7yjTaSeghcJNBkNxKTH2OVa70BSw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=b9ZLMica;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.31
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010031.outbound.protection.outlook.com
 [40.93.198.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C968CF80796;
	Wed,  1 Jul 2026 11:59:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C968CF80796
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=b9ZLMica
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/R/tQd20Z+ti1YCPhX9EyZke2OeX5iU5uEtzzCxJNoE4dsvrIH0g+2txmw29NgmADMfK09h/qZKXQxT1rvi5FmdmMrnPO4xi9t/Vbn1XjEskdMg1erwAP8MNfuTHgknx1pEh17agNkXF+g5Zq+Lh4DrpXewVaxFzm8uAIJ9bcTnUpn+dwz0Tx6Ae2dJYuVlJC7h+5fQ2AokSpjjVkuXBcZnLkqjo9SeTKpk4DxzX5WV0ZIG6+OgUJLFmxyzzv/gKFHGZgl6kbZGi+BTL+23nUsJRnaJE7RBW9Q7h0mIjc5LLy3zFtGrcX6X8018snVd9jFsuBrqydphNU3n1vLIfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVopRO5NqXO64p6ycqayvQAPraLTuh1uTVyTHPvcDQQ=;
 b=rBago48FYXkgGgz2jqxxmUf1FPEtcwiisrt7ep+Ldkx/TW+NHoUKSh5M/DN56LZRI2ilevzqVJkY5/Z1ggZLjJv6+RTx/0iqTOKL7EHOl+xjGedSAmBrnqP8kCJpJ4HyEBHOov6AEcGCoud0Smjl8WeTwXZyaR1B2MVPvSlzE4ne/Gbt3bjK0r9NN4XUBMKsUQ34IRM9cHpWd7vGlGFX+xNgDSR3niAtLUPBphcyz0GXehb/3Yi/3C5c36mb9hZrVYvnp6kem+P+jGPiih4Kk5vMuoHerTpg7DoQC0CqV9TNYS/LMAuNsVzGISeYPyiEJIZnMDvlJkrEHY6NJYORtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVopRO5NqXO64p6ycqayvQAPraLTuh1uTVyTHPvcDQQ=;
 b=b9ZLMicauN5UZRPvd7VDU9YcSKuCiMJPc8NAOliAmLm53Ykho3tF/CQGXOA7UOxwBdqPhdPqMk4XBR1Hdu10Lr4xY4tJ6EZR/KKrm2iLdHU7OYpPG9qR66LaRw0/tHKD4U78zynCET5rx1zXresy6UHNhysMHNqQGl0nsntc1lA=
Received: from PH7P220CA0133.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::20)
 by SN7PR12MB6911.namprd12.prod.outlook.com (2603:10b6:806:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 09:59:24 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:510:327:cafe::7b) by PH7P220CA0133.outlook.office365.com
 (2603:10b6:510:327::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:59:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:59:23 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:59:19 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 14/16] ASoC: SOF: amd: add ACP I2S format field and topology
 token
Date: Wed, 1 Jul 2026 15:25:15 +0530
Message-ID: <20260701095759.1012929-15-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|SN7PR12MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e91de3d-1a3e-464f-c718-08ded7576dc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|18002099003|6133799003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	E5sB+9wse2qOXV6SUzoX575A4je33giJKm/N0/bITDIzjl4RE7WnKZmssy/YNUDZRywyYUaTQX/vEStmULeXAO7MdnTj+mtOlh2i1zx5m8/XBLvCPidWoTzsbuawiIVRA7AAxlUG/6KTZo9h2IyB+33kA0+tre2ua+W7j/uY1SlAz/qYR1gUO7B0lVz/VtyO7i0DXHMGJH9sCw6zUuEzvZoC28HLqpU4jwzXNh+3txPUj/I6zaCQUhqO3NxAdigNsIyykB0Pl6K0Ix55PrC7Exmn8McFe6Vhc1VwSfaHPhKcvizlRRiXv0BKCUVFxRIk6AOAlbrlKDXe7O+QxE1ZSv1XWM3Q+EOoBCWBO4iamdrXcPS9us24WL9qSNV0PTR91iPdCAa2iXu8SjQOIrYdXc1wC11cIaP7FECj3aHXS/n/zp6LZfKaG+SIfzh5C4WDiLrLSkn/dFkPIMFaJUK3bILCTLvzEBpyf/2N1Uyx6LbXJ9EwcPFl+RlKEr+9Y7cWbrYBu64HQHEEP+1OVeoN8bUST/VTYqKdGK1PM+akFvudsTx4vHMNbi4uQ+OTguLDBrWo5ku5sKNdNfyIDSUg+QwM2BeJ1xquq2h8IdLfd0KjvEm8qC2xuEnLeOTj+cg55QPBub3Y1IeDPtc5cRsw1iFIks9uiuRJJCT0en0V6aVl33nOZxIIDt1fjX71mvHZHUeGEhp/FYzp+yOdIdFKng==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	DdRei3B3Rm5yqS1p/bpS1huuF9rsFBHkJN6H14UFqNNS0XNa9IHMNqJgbnvPsue2CMzEnhEtAhsEWK8BQSBDuIwL0JsEsT9zXI9XDX8iF+9cQsU6GTNHd7C88fca1B2r1mCX7MEjZhc2K/DLnr820aht6a7gTxM0W5BaqLbKXU+UgrGpIiF2/XgJIvrat80fAulegRXI8fqfkITTUoEj7HEyQgeDOzAtl2P7o7MLLGDO+nd5/ZbvgS6wzGkENp00cUDWvFdnRd/NSGSdFUR5ZR+mBAKwUZoIX63Dam90FrNA0i+9ixPOAOIpp5YbWGRrQdW3ahZXJkPvox6oX9VEf7NKab8oLCR302Bt7ok7Ur9TPK+3ACwNlx2qPmU2uYMh1nwM6+ktAwfYD+JdBWkN+bmSpJItH9T+yTaWbNtbrWvGdvL28i0D1k2qZMZ0oBHg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:59:23.6298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6e91de3d-1a3e-464f-c718-08ded7576dc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6911
Message-ID-Hash: YDJYWSEHRNRXUTXOIOHEWGJWKKSZS4VZ
X-Message-ID-Hash: YDJYWSEHRNRXUTXOIOHEWGJWKKSZS4VZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YDJYWSEHRNRXUTXOIOHEWGJWKKSZS4VZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add format field to sof_ipc_dai_acp_params for ACP I2S format selection.
Add SOF_TKN_AMD_ACPI2S_FORMAT (1703) to the existing SOF_ACPI2S_TOKENS
tuple and wire it into acpi2s_tokens[] so integrators continue using the
same ACPI2S token group as earlier ACP I2S topologies, not a separate
ACPTDM-specific token set.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/sound/sof/dai-amd.h     | 1 +
 include/uapi/sound/sof/tokens.h | 1 +
 sound/soc/sof/ipc3-topology.c   | 7 ++++++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof/dai-amd.h b/include/sound/sof/dai-amd.h
index 59cd014392c1..e2107da6558f 100644
--- a/include/sound/sof/dai-amd.h
+++ b/include/sound/sof/dai-amd.h
@@ -18,6 +18,7 @@ struct sof_ipc_dai_acp_params {
 	uint32_t fsync_rate;    /* FSYNC frequency in Hz */
 	uint32_t tdm_slots;
 	uint32_t tdm_mode;
+	uint32_t format;
 } __packed;
 
 /* ACPDMIC Configuration Request - SOF_IPC_DAI_AMD_CONFIG */
diff --git a/include/uapi/sound/sof/tokens.h b/include/uapi/sound/sof/tokens.h
index f4a7baadb44d..cc694a397987 100644
--- a/include/uapi/sound/sof/tokens.h
+++ b/include/uapi/sound/sof/tokens.h
@@ -223,6 +223,7 @@
 #define SOF_TKN_AMD_ACPI2S_RATE			1700
 #define SOF_TKN_AMD_ACPI2S_CH			1701
 #define SOF_TKN_AMD_ACPI2S_TDM_MODE		1702
+#define SOF_TKN_AMD_ACPI2S_FORMAT		1703
 
 /* MICFIL PDM */
 #define SOF_TKN_IMX_MICFIL_RATE			2000
diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index 4e066bbded91..9eb8335a3c07 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -281,7 +281,10 @@ static const struct sof_topology_token acpdmic_tokens[] = {
 		offsetof(struct sof_ipc_dai_acpdmic_params, pdm_ch)},
 };
 
-/* ACPI2S */
+/*
+ * ACPI2S tokens fill struct sof_ipc_dai_acp_params; SOF_DAI_AMD_I2S (ACPTDM
+ * on ACP7.B/7.F) reuses this tuple group rather than defining a parallel set.
+ */
 static const struct sof_topology_token acpi2s_tokens[] = {
 	{SOF_TKN_AMD_ACPI2S_RATE, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
 		offsetof(struct sof_ipc_dai_acp_params, fsync_rate)},
@@ -289,6 +292,8 @@ static const struct sof_topology_token acpi2s_tokens[] = {
 		offsetof(struct sof_ipc_dai_acp_params, tdm_slots)},
 	{SOF_TKN_AMD_ACPI2S_TDM_MODE, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
 		offsetof(struct sof_ipc_dai_acp_params, tdm_mode)},
+	{SOF_TKN_AMD_ACPI2S_FORMAT, SND_SOC_TPLG_TUPLE_TYPE_WORD, get_token_u32,
+		offsetof(struct sof_ipc_dai_acp_params, format)},
 };
 
 /* MICFIL PDM */
-- 
2.45.2

