Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55EBCCD5BD5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 13:33:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C91AF60246;
	Wed, 27 May 2026 15:33:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C91AF60246
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779888801;
	bh=z08kt4RA7pdP7S+UMm9g6qokFP50TLxr4KrJHAFqCZk=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=NTn3vkl7dJXFkxs6zTqZJR6Uv6GKs4KPJUA2K8AWZTqAb49fj/MNryuuVmMhobRnb
	 +pWbQ8NRuCWoGkv7Xw5ySL6nYAtqL6zDReV58HAEJ1aSQhMe8LvQIqw5vJohEsshBU
	 e+KwoNwSh8p+VfZcR8SlbrU37kkO7HWdSjpsYjrs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33FDFF80087; Wed, 27 May 2026 15:32:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F16B6F805ED;
	Wed, 27 May 2026 15:32:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E856F804FF; Wed, 27 May 2026 15:32:42 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E05CFF80087
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 15:32:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E05CFF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=xIvWLEMK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bG/aIRHw5Eoe+7PFFTpeoJc+zBlAC5Valg9Owmf9EEjllsVQ6zEb90MrMtSR/rQQpgaIyd50c5YtygItrNsoax9ejZ5QvJlzxXZXy0qqh39tR+9lKU/BLRd1/x1ShFvtzq+Qe0FWtaM/k7Gh5wwDsZyFHPUwBhOYT9WtzALEnwD5T6FjdS/hNOSo2+t/6iVNht7krGnoQj60mDYAI8LLuM+Gi0j9BOPD9fslvGVd6NeaQEchvcSnX5stGaxCkhAb+rcEJOsWdropeEDWwcNZsYbnQ/T8C/vvYSGPNoQ1GwlZGLrdurDbPZ5oL5e04ws8fViNXPcCeW6JfBLAYGhEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4ZGhU2xvDVDU2eMcIJIRfdm8tOUWXnL2PgoweKkjGs=;
 b=Yyh5o6yUrn4bHdxdRj2Sv84ohvOGErRGK+A+wDK7+p/92gEm1b7DY4P8o+CxfYMMqFIE5UV1MxoLS7iLFAHWgslNFa+jRtJsOTi9uNrIKp+d+upDwB+wqhNNxeBjOXuQO2GUz3JVz00qIv82yV2GLi8FmWZbfhilS699DvlClsteTQQ9bidk6SBKLSGqXq0FC2ckETaNyqxXzg8HWDaDZPxXnJXxUSzCT6rp4uPQBLdIryNvJn79eu0VT1etne002VRI9RmMvuHIUPATmssvzaJedpVoOYNc+J0+z3Lbw+EnvW9pCVMQWTfYFD0KJwB/NR9U3WKiutZiKOd5VXbesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4ZGhU2xvDVDU2eMcIJIRfdm8tOUWXnL2PgoweKkjGs=;
 b=xIvWLEMKOF/Vri4xgcvCyQ1I3+0V3r14b+UUKv1hsRsGiqPtBDv3zG8lo3cJkiX8CpYi9DYcPP44RfKckDlJX+lmHk0IrW71zKl4yy14eHg7KyIZ7AjuuTX/mTRJ0UMjnCjr510o0cSOn2jJWtxoNV6RMqM0Xmvli4uh5lJvHF4=
Received: from SA1P222CA0191.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::24)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 13:32:23 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c4:cafe::1c) by SA1P222CA0191.outlook.office365.com
 (2603:10b6:806:3c4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 13:32:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Wed, 27 May 2026 13:32:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 27 May
 2026 08:32:22 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 27 May 2026 08:32:09 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <vijendar.mukunda@amd.com>, <Sunil-kumar.Dommati@amd.com>, "Syed Saba
 Kareem" <Syed.SabaKareem@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Syed Saba
 Kareem" <syed.sabakareem@amd.com>, "open list:AMD ASoC DRIVERS"
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: Use IS_REACHABLE() for
 SND_SOC_ACPI_AMD_SDCA_QUIRKS guard
Date: Wed, 27 May 2026 19:02:00 +0530
Message-ID: <20260527133208.3074614-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: 524a7640-8b8e-43cf-4b8b-08debbf46271
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	URxEx9FBgZbxHocf49K/KiTgwad2VVLit/jjAP4Ul+aWK8VogMMMUMQoHn6NfAIjQdCjzFJX0KCZjgWdCt+AANSYeUqCWmEGX2EWHLLfzwZwgUMng6U7qlXtgX2+izIAXb0prsb1Hgy2MXZho1H3FbKLXTlCEKnkxTSEpsF4zd7wZxaIh/7C1oQdOil6i11hQ2ABhvLRh/pLlJbJIY7CSZ/KsyKMr1xRcc1BR70aQROy8BwwqJDh4QQH8fanSsWCN5fF9ucjbxR89bB6rIsk5Jnvc0/ge27gT0qgcGMqDWyUkK2iI+qtSMgAFaT/SZCZ/HRH0ykikYxEfyfO6LGes750NSVzCRNftSBR2IRq3aETYX0EHPzhM0ymx6PBcOKXmT1rFqfNRi1LCo9smPCs8S6jacHxVJWNTTqFike+isMIaI0JVIPhAA2Z3F4W99t0TRamDSKO2LjHvxpZuX7p+JtyJPtS73aYsrEkdY8WKAm7wbmbC7Pj8VSKO7jNHZPyisMtO8WamE/2LcjImX9LzSz6GDlJ+h4J3pcQ88UmKQNfWi6zb6Oxk7fqkk4zKk+H+vByl60VlWD9sUgfeQY0B8nake89NdQZl9jl7qupTcsqtY7RVvoIRefuoA8/gdMHGMFw/pGr7TWqZzs9mgSuky8AhE2SrXicwCtxGfOAoVGKmWGw322pDhPO5NM28LMm3zjsmgyUCFWD4znr1XMonzPvHoMZvjE0qwssUuta8Ro=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	F+UBg/utE3DkevhSRcBgyq8yIo2fLeP5kfyikpC3Pp5RWg8af7QB6lGauRdgtLAcP415VZ7aDozKtbSo9UiXX3ImRCqhH2eRDgFmmSWsCcyqGvme2xkleqZCBpDX+y9J9ZFH5dujHj9/Cai9Jh2/udV9U++Bd2zSjHzabj5gWwRb3wCFsrGe/CoMJW6+lOtJpqhttUFu/wV5IzVi3XvC00qwCoFRcANZiOoSNbWbf9olQEjeXFlyZHVvciZOjQX+224fm4AgV+tR0CBl/hBneaRJBt620E6cNDcnM/ESxEPU24yZ2vs7d3/yYg+vEZR6xC1QCO+7lkKVrWy54YKn0c4OUpCMTAa3/Zgy9ZumMHfT8zCJ8AbEMxictDhIpMjJW28/fs/sz1kr0ABSDJ6SHo8Vdhcjr2woUlqCg+HWJw8MMYDQADoe1/43eS3jFcxz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:32:23.0841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 524a7640-8b8e-43cf-4b8b-08debbf46271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620
Message-ID-Hash: TO2G6OJYBE34BFTGRM5OUBJRMLGLLHIB
X-Message-ID-Hash: TO2G6OJYBE34BFTGRM5OUBJRMLGLLHIB
X-MailFrom: Syed.SabaKareem@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TO2G6OJYBE34BFTGRM5OUBJRMLGLLHIB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Fix a build failure when CONFIG_SND_SOC_ACPI_AMD_MATCH=y (built-in) and
CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS=m (module):

  x86_64-linux-ld: sound/soc/amd/acp/amd-acp70-acpi-match.o:(.data+0xf00):
    undefined reference to `snd_soc_acpi_amd_sdca_is_device_rt712_vb'

The header guard uses IS_ENABLED() which evaluates to true for both =y
and =m configs. This causes the real function declaration to be used even
when the symbol is only available in a loadable module, resulting in an
undefined reference when the caller is built-in.

Replace IS_ENABLED() with IS_REACHABLE() which correctly evaluates to
false when the dependency is a module but the caller is built-in, causing
the static inline stub to be used instead.

Fixes: 10d366a846be ("ASoC: amd: acp: Fix Kconfig dependencies for SND_SOC_ACPI_AMD_SDCA_QUIRKS")
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h b/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h
index 0e644e71e76f..66df37d29d84 100644
--- a/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h
+++ b/sound/soc/amd/acp/soc-acpi-amd-sdca-quirks.h
@@ -9,7 +9,7 @@
 #ifndef _SND_SOC_ACPI_AMD_SDCA_QUIRKS
 #define _SND_SOC_ACPI_AMD_SDCA_QUIRKS
 
-#if IS_ENABLED(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS)
+#if IS_REACHABLE(CONFIG_SND_SOC_ACPI_AMD_SDCA_QUIRKS)
 
 bool snd_soc_acpi_amd_sdca_is_device_rt712_vb(void *arg);
 
-- 
2.43.0

