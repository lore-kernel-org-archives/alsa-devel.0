Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DABF8A145
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:21:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2088A6020E;
	Thu, 16 Apr 2026 11:21:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2088A6020E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776331310;
	bh=sL/EABiL7zER4psHRtu/XypIsfVBZZLv89K5wrgu+0k=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=QEgMUTKV7/ve+KL+9IXhF0gg2VEoD1qixlvc8kVTDcgogZj9ezN6n2s/ooj6plepO
	 nZ4R+8jJ6y8kbX9Z/yC72ckY7faPJ9XjJfL6dKYyAU7hcZe3ExqFiPf8uO3BK+gMLO
	 oRLl4MnzRifmfAyz5EbzYXdc4BqfMepDUvbLe6Iw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 849BBF80624; Thu, 16 Apr 2026 11:21:06 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 22F89F8061A;
	Thu, 16 Apr 2026 11:21:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09214F8049C; Thu, 16 Apr 2026 11:07:40 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 72A32F80212
	for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2026 11:07:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 72A32F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256
 header.s=selector2 header.b=AybhCGMe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qseyvCwbGL95wJAyiwWiN2djguOZA8yGcNc/MGv44KDOnfqeu27Gp4BaNAIKfnz/pA1Y+HMBRkQFHyE6pmxkJBND8qeGsmRyv1uZKr9vJYeUtaCKmT4FIj9gOPT5C3reSREvKqtplSj8QIHnloAJHhKGMXKOVtvGxnw9In+ZNedff1vK/tZTQRkc06uaZQkc83dEe/RiPxG5VRmVtcuFbm8BFVJr5xCy7XCJ7oiyv7K+xd8Thg1GLm0+BAbAgsydyrwE0rVO+5clpD6Pw0I9bfEtrIX2v5vu1RUK1cPdqdReTfE+uKglIiTqsU1UOSu4u+ego+GGJT8Bs6UhN9GOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3QGFNO/TyCapwLc+Sva9ZPJYq2TuJgcmDQPS21Edqg=;
 b=AucHMmOUzhndgNEtQaLr/5PCz4SQcALMrss6tuRXyDYV0PLAWphb1lGWPQdWOuugQnwcTM266oU/xwCmgXF6XjKqw9/VuGDQ0RVU6/jxr/V0RrimZxfv1Ap+1Prj8vlAvPUsVR2CWOYr17oueGPPPAhg3u95u1zehlLPzMbP1uyX6nRZZVxe9tH3OlUIb8frLoxq6ez7s6hd560YNM6rY2vwCloOQEM4HLe3JCtSBMmpzQiTkC8+rKwx6XRFMzlEanQ/kgGYWgvKxucQKoocWmYA2zp/cIU68IfSLA+CNDChPjitbcC0xCHtGNhjOFEZmuUdOAyY9/aoVm8b0nr4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=alsa-project.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3QGFNO/TyCapwLc+Sva9ZPJYq2TuJgcmDQPS21Edqg=;
 b=AybhCGMeNgOlll55u7tso0FW7cw9imUnoxNaxrFq6x/qjvAMxRWUozJnA1zBce7u+Lv7hefvaBhHvcNzJFdr+XlQO/TLKnCr7GRiFrrNmm5PwzhVDLLpexjhgkwWwrAaik/9rDdAOB3L1Hu78X+3+PFC9OXYjv0+RblSuWpau85t0DwwBJkCphRbFfv8C2u3xfffQkMElz/TlwJ+rWOnhC7Gvf2F5fGq0P0pVcalSb5Ntxp753k9dTvH1t2sIX0FzJy94HmFy5R9UYKTonGGq3tkEOMNPuiN3dYoO22a476rTuxFwkK7oC1xOpvGr0owzAs5li9UGS0ZzJBkA2FtSA==
Received: from BY3PR03CA0017.namprd03.prod.outlook.com (2603:10b6:a03:39a::22)
 by MN0PR12MB5956.namprd12.prod.outlook.com (2603:10b6:208:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 09:07:31 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::ec) by BY3PR03CA0017.outlook.office365.com
 (2603:10b6:a03:39a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.51 via Frontend Transport; Thu,
 16 Apr 2026 09:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 09:07:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 16 Apr
 2026 02:07:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Apr 2026 02:07:13 -0700
Received: from build-sheetal-bionic-20251202.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Apr 2026 02:07:13 -0700
From: Sheetal <sheetal@nvidia.com>
To: <alsa-devel@alsa-project.org>, <perex@perex.cz>
CC: <jonathanh@nvidia.com>, <thierry.reding@kernel.org>, <mkumard@nvidia.com>,
	<spujar@nvidia.com>, Sheetal <sheetal@nvidia.com>
Subject: [PATCH] tegra-hda: Add HDMI/DP outputs 2-4 for Tegra186+
Date: Thu, 16 Apr 2026 09:06:00 +0000
Message-ID: <20260416090600.2237882-1-sheetal@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MN0PR12MB5956:EE_
X-MS-Office365-Filtering-Correlation-Id: 73bf8616-3879-4b89-c0a6-08de9b97962c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	Ii5cdNbJFEutiZaSjjZb4hOiZhtjR7DQHP0F63sda2W+lSLemETEiwuOUMggiX96tySO1YemrYtAG9W52YTq5KjTaQoHdetVDjs0EH6sUk7uV/t3w90HQFrF7lt6T/1uMjt+1jkpfwQkitHhjSn1jKRkWuuhJux/pMUlWTq2U0vnd12x3Kwg8GTOkD9l5UP9QhNs0vld3lKXOPDc++/b04tOuR6qU9Ql9du/iHjliEwtH6Ylsp7SpT+6GSdTvi4fGaoI+iwKyyiAF4+Ax5vhrtA9B5cx5lrnyuVSXsKDV/djgpLeKkWdBRXJbK8wXWaZZebD5NYsE95Prk2UHSWxEbkD07lLCPcL4Zhia+Fp0V8PcZ6GYGX3RV6O1+7YF5wSDKtwhFuIz4fF4IedlFRxTmpp3/NBRcB5Rc81ofor0Yu9hRbqPiX+qM+eVZdYYXD7gVi4SyODjaCichNcNxLWq0FuIzmDd1/dVp8P8XcShzl0ajePCjmw5wD274hf0QVYoKi0cVJrU4eJ2nKmLKRRk91RIIjUHFQPU7Y2pL7vyEWlAEgHb1dLhgjbkno5Lr7EN3vVxmbrDfmdFpU+P4cQzJD5CdLHe5pGhGvVuKwnca1V6jvPtmrH/dVS1LHezucGkZX0D52HSJ4MG0GaE0HcYC90LuJwb/6YOEiGxHBhMNYT2TEoDV6FpTHdeTJ3PHcO7g5gg0ydKz38uRglcj+wSC8zhivLJwieMf599m2mS4B3W3S8DZcOTN78c65CzLOrGfOmMhzQFfMBS+KRp+FRfw==
X-Forefront-Antispam-Report: 
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	r6A4tkpF7qlVSYcdG0KgSU5l+KCWfvJauyzWJ9igZQPvjBiOib/omlScj990pb0AHopPF+rtIp36qp+jjentpUehQ3gvgAPjguyfqe8GXs6dylQRAHmf60LlFO3uYJXplYrn7+UkFnswUbnPuMjLPc+4k5LLNtqsF+d5hkcLY48ikZ7i1bt1A95JexOM2I8hZ+wHF3Mwghff4C9lIznOW51B81KtDSktNnQSxDsH+OdP+Moj1CInzrACbnXftjp3hmH5lYUrrlX5sS+M5XICztUrfiBlQAtokyCr+uh0IEplc0hYg+tSfObIEb3+mYTLsofWwv5kbZ4rSgbilckQXwuKMPdhqTIGJlACzvCtomSeQwM7L6Iu+z8rh1gbonm4gsVjJrh4XMTV4/ntnkEy6jKikhBkJYun+YBJpOQTbKeeXAQjfILfnqBEGM5ntqzh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 09:07:29.4870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 73bf8616-3879-4b89-c0a6-08de9b97962c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
X-MailFrom: sheetal@nvidia.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 3NB4PE4JOUZV2JF62HXQAK76GRZ3CA5G
X-Message-ID-Hash: 3NB4PE4JOUZV2JF62HXQAK76GRZ3CA5G
X-Mailman-Approved-At: Thu, 16 Apr 2026 09:20:58 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3NB4PE4JOUZV2JF62HXQAK76GRZ3CA5G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Declare the maximum four HDMI/DisplayPort outputs (PCM devices 3, 7,
8 and 9) so PipeWire can see every available port. The HDMI macro's
built-in ControlExists check ensures devices are only created when the
corresponding jack control exists, so SoCs with fewer outputs are
unaffected.

Signed-off-by: Sheetal <sheetal@nvidia.com>
---
 ucm2/Tegra/tegra-hda/tegra-hda-HiFi.conf | 28 ++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/ucm2/Tegra/tegra-hda/tegra-hda-HiFi.conf b/ucm2/Tegra/tegra-hda/tegra-hda-HiFi.conf
index 3277f6d..f26941b 100644
--- a/ucm2/Tegra/tegra-hda/tegra-hda-HiFi.conf
+++ b/ucm2/Tegra/tegra-hda/tegra-hda-HiFi.conf
@@ -1,10 +1,34 @@
 Include.hdmi.File "/codecs/hda/hdmi.conf"
 
-If.hdmi {
+If.hdmi1 {
 	Condition { Type AlwaysTrue }
-	True.Macro.hdmi.HDMI {
+	True.Macro.hdmi1.HDMI {
 		Number 1
 		Device 3
 		Priority 1100
 	}
 }
+If.hdmi2 {
+	Condition { Type AlwaysTrue }
+	True.Macro.hdmi2.HDMI {
+		Number 2
+		Device 7
+		Priority 1200
+	}
+}
+If.hdmi3 {
+	Condition { Type AlwaysTrue }
+	True.Macro.hdmi3.HDMI {
+		Number 3
+		Device 8
+		Priority 1300
+	}
+}
+If.hdmi4 {
+	Condition { Type AlwaysTrue }
+	True.Macro.hdmi4.HDMI {
+		Number 4
+		Device 9
+		Priority 1400
+	}
+}
-- 
2.17.1

