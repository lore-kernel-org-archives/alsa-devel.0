Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18020CC6B1A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:47:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30A1160225;
	Wed, 14 Oct 2026 13:46:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30A1160225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791978428;
	bh=s1Gtd2wpR8w8vInN5/SW07XPTq+n6JU3QudU1Smn84w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=npDF0yG2B/wnGEb9Zu1dVn7dhcOeA7afGX8xFFx9ShQQygMxsidZh80oQI/cJpXbX
	 JuDPAEPifR96wXUqQ/AVDYmH5fBXNWCfi0/16iPVXRBM7vjhMpIyIfUcVvA3LT3HhH
	 5pRGwuhF1opWsBsI+I7649Q1jWocBFjkF4RwkQZU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9AADBF80622; Wed, 14 Oct 2026 13:46:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AB86F80622;
	Wed, 14 Oct 2026 13:46:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2463FF8060B; Wed, 14 Oct 2026 13:46:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.49
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791978372;
	b=aAZlYxzJQUZIs/+KLmXJckN99hx/PT/tc/Kn6BwA44+uzwuAMQbG+cQ6W0k16IWY1CxE
	 358QBowzAPpV3iCTxqJxroPoMPbnkVQlIW9hrIXslGvfkyQaeJJ3XRibmPLll/IXVzqjM
	 lGGAOo48Xoxbk+MCy49FQoPUr6uKwi9GvR9ha8gEozYh7ZGTtWkQPVj7DpcIePHWAOlwU
	 QWfCHcjYLbKcfLykeo5mI/BLYcn+y8JLjd0Fp9I6nGHOWCy5Pa1MBKCjBwTdnZT5iJuAp
	 8XtfK4U8jD0L3r6+Zjl4jjlrMjTfVer5yeq+/++XjgsWSga3gFHKaLRIDyz1pai4vXg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791978372;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=s1Gtd2wpR8w8vInN5/SW07XPTq+n6JU3QudU1Smn84w=;
	b=SXOc0N9apS7beOBx/F7+Pr8SbomqNB33HadBy6vAkydLNyZCjNtKjlZ0SXLNmxuE6Snb
	 1K/qYBt940VxrSb9nex/lCHQEfXMs94I20WkNxE5D4xo9tMmzMMSTG/Ri+o2st712MU4A
	 YzEoLsPh4Y8M//ONcJRGlJYatjiM8Ia10KKGTsMShBimpKTYojpPSUBqpR77WIQ2BfuoK
	 mk+vTaXIrMiHvA1XfH9Nhx4JO267HrOxtSGaDEOpvoGJiqk5Hr55hIXxfIm+b4v3wyYdV
	 lrjJQuE1xhqGtMvD34exouA70iAtAEc2FD4xLnGlhY3XJQFkhGaKhnohQaXTffa/38Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="Z/dBeoel";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.49
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BF5BEF8060C;
	Wed, 14 Oct 2026 13:46:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BF5BEF8060C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Z/dBeoel
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n29CLpLJJqTP5PYRzIqe1es3lrcDyxiGWPAcPueVjMVMam7uoqtluz41kTg3sElok6tP91S5qzqDtASXC7Uft9yAxNmhts07w7rTH7fgUqv5A+H0F3azhu0di93KqifaRPy409x4aHWER+cZA5TZXM1xyq5znI8UqqpGS1co8IzJY1nQYVeNYgYWmMxShD43FuebI7lz/myVX93djV2LxfDcNfV+R+iQkED7Sm/hfbIU0mRijqTCXQ0NL8dTZXTru+NUzRMJJcYMG1gg08UYsWXftTyC0fiTEvtGGk7Ap+kTBYjfRgEM+b7/sYd4iWnTXtpKyhMwl7bLYWQCRfrUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgoeDA/6RdL7P8I6vjwM9ZnMvQXWASKF2xLAjZ74Fd4=;
 b=VxUbln0xGa1IPQ6dBh+X31+zlu1AarsceGNiyZ/xHl0R5gZzlr+HE4N0y4LCnsbcbOoZoH8/L0/T0R2VmS9rIm1TDeUMEj9CExrDXSOQ0omckB0kY1hlazNSWxddrCj6fcpWi4K2XS3xeO0ZtlSKJJOLAjUqpUmuFu9obDcPptVAmjaeo/8o5kiTG5TN4eR3uHtOPTUHGaVLE7iYkfR97saVZdczsA87gYGIvfOH9RaXMrtMDGCET/y9hKxW7wefO5atqhLR3Z264FM1tx84W91y22A4XrMcS9QbeFfxm4WD/hsukJ5YiCrCo1LWZH1gGyfVhNPcn/oEYcuoVkDd2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgoeDA/6RdL7P8I6vjwM9ZnMvQXWASKF2xLAjZ74Fd4=;
 b=Z/dBeoelLfxVnsqNQFwIUCtZFIbYVqBw60MGR+0oP9V7dH9VsbjT7MIvZ15Sk0dSwKsoz5JV/r5E6SpovLVTUH9GmiOKl9rfFw47jA7pXdAG3HnKmIyNQUObRB+Iz4Ku3Oj+JVv+KgORJs3VRjpKEvZxKVJqJij8KkL8yFNS1jI=
Received: from CY5PR18CA0015.namprd18.prod.outlook.com (2603:10b6:930:5::18)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 14 Oct
 2026 11:46:02 +0000
Received: from CY8PEPF00000053.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::8b) by CY5PR18CA0015.outlook.office365.com
 (2603:10b6:930:5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 11:46:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY8PEPF00000053.mail.protection.outlook.com (10.167.247.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 11:46:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 06:45:55 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 06:45:45 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <vijendar.mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <Syed.SabaKareem@amd.com>,
	<alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
	<perex@perex.cz>, <sound-open-firmware@alsa-project.org>, <tiwai@suse.com>,
	<venkataprasad.potturu@amd.com>, <yung-chuan.liao@linux.intel.com>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH 2/2] ASoC: amd: acp: move ACP7X_PDM_DMIC0/1 to
 acp-mach-common.h
Date: Wed, 14 Oct 2026 17:14:46 +0530
Message-ID: <20261014114446.1476489-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014114446.1476489-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-10-Vijendar.Mukunda@amd.com>
 <20261014114446.1476489-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000053:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: fa8affcf-77b8-4d8d-20ed-08df29e8b8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|10067099003|22082099003|261009223027099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	7/OE4mz4XS6SiUjRhu7IqVF0D2fmuuYdzzWHb2P43yNboUIdkCbTtyk8oV+u9ho5rqNcIjzkmXo2YkkyPWm+E/yr20Y+SL+m/idU0KyAegpM5x13L7Z4y5lVJjWYpIWuAAiSrKqfN+6A6NAJ8HDWwBo/0GKtYcTgDPZGmglsU4t4oAR5X+lvsbvc2kUvfd1HbPx1Ps6zSFvnqsVuKBOXsKtFcCQdPfLkcZs05JaGBdi37TvoJSPRZl/wRR3aFpwdw9yBrs04WegrD22YTRDwaIB+LOpW0q2D8yNHTn1LvCWTQHgsuwS92OuPtmT/hFY0PUwx4aTHqexqri2aX42E4pHcK0DDaXUoS1oo7gEjjphMXg9H8B73rPiBloBe4te/0PP2Q2pQM0eze02bF/8Yqua1JC5C3+i7LjF2iFANj32ah+buu3/DtUj+SsnFvxkHT077v0LbLGPmjuBijalodOCCZ7SqrLyKFssaXlWuFGLqUgmBeZA38sNVfvSVVoFLxHWiiLP+mHx3afV8hds2+3pOhCmn5KEsfIQ2ajnOBG5M5QQlBW7sta/s0QYIvsETeDcYgyd0hORpt0LH05B8vRKV7XBU/5+hwitOIcg6VukXeKE+noP64N+ciWfzq9corWlieLbeTjH+lumn9W3uf6OHAQjYS3OkoKB2ZV+md+JnCwXEoL5KCo7ALOosNfJdilw/tpfKtWQ9Bkf1MiCsNg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(10067099003)(22082099003)(261009223027099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	mCLDmQ9L0Pl2CLNc3RzLlGwKkaSN+XNDaeEPI7HBz3fCrtqBCde4J+eKprcsy59SEzPL/JmrwEBpRz41FlshaLyyYNxQDeft+iaQrVujFWun1CpH2VatfhLErRr0Zyj8/r8H5VS131PGkg8VPkAkA5gJSTHqR6RzfQDOj/kltbm0X1eU7T5j0P+rzKD219q6tG+Mh4zriHTDKCx6+JE9Gv90kAiGZB+ThkGxk3dRpGRFV3LGxt7miX9Yu5fA7PWw0XeETNPET+IFpKwvjeaPvtMxTiJbo49NX9JvzkPZHJpwM8YwsWNryhzSOBbVmxxPzNxBKcDkCR020aN4Z+44X8CbXZvAuGz/QfsZMeF0OFbxMGGyDSqhH7F8kiH6H2F5tE8TZpzSl5WprumByz00KB5nsZ8dTjb5AcMVb2aNCFyU8jS5EI4iTC6gHixEJUGI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 11:46:01.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fa8affcf-77b8-4d8d-20ed-08df29e8b8ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY8PEPF00000053.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894
Message-ID-Hash: CJUHB5WBLKRFYROWTGL4DYQURIZ52KD3
X-Message-ID-Hash: CJUHB5WBLKRFYROWTGL4DYQURIZ52KD3
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CJUHB5WBLKRFYROWTGL4DYQURIZ52KD3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

ACP7X_PDM_DMIC0 and ACP7X_PDM_DMIC1 identify the active PDM controller
on ACP7.B/7.F platforms. They are carried in amd_pdm_pdata.pdm_sel,
which is defined in acp-mach-common.h, and in amd_mc_ctx.pdm_sel, which
is defined in soc_amd_sdw_common.h.

Move the constants to acp-mach-common.h so there is a single shared
location for all PDM types and values, accessible to every AMD ACP
machine driver (I2S, SoundWire, and SOF paths) without driver-specific
header duplication. Remove the duplicate definition from
sound/soc/sof/amd/acp.h.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-mach-common.h | 4 ++++
 sound/soc/sof/amd/acp.h             | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.h b/sound/soc/amd/acp/acp-mach-common.h
index a2cb25be6bf8..c5f1bb41c826 100644
--- a/sound/soc/amd/acp/acp-mach-common.h
+++ b/sound/soc/amd/acp/acp-mach-common.h
@@ -9,6 +9,10 @@
 #ifndef __ACP_MACH_COMMON_H
 #define __ACP_MACH_COMMON_H
 
+/* ACP7X PDM controller selection values for pdm_sel; 0 = not set */
+#define ACP7X_PDM_DMIC0			1
+#define ACP7X_PDM_DMIC1			2
+
 /**
  * struct amd_pdm_pdata - PDM controller platform data passed via mach->pdata
  * @pdm_sel: active PDM controller (ACP7X_PDM_DMIC0 or ACP7X_PDM_DMIC1),
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 4eefc9cdba1b..b17a36b31ee0 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -159,9 +159,6 @@
 
 /* ACPI child device address for the ACP7x PDM/DMIC device */
 #define ACP7X_DMIC_ADDR				2
-/* ACP7X PDM controller selection values for acp_dev_data.pdm_sel; 0 = not set */
-#define ACP7X_PDM_DMIC0				1
-#define ACP7X_PDM_DMIC1				2
 #define ACP_DSP_MSG_SET				1
 #define ACP_DSP_ACK_SET				1
 
-- 
2.48.1

