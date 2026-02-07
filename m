Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B894EE6B76
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Feb 2026 06:27:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 259FC601F9;
	Sat,  7 Feb 2026 07:27:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 259FC601F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1770445660;
	bh=tcmNBeUoe2TWmh9zA3yEFyJXCTODJgeyuybWoAkD//M=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=m9KzW49vligedoqpX7cvzXZ5PLQ0CKGADleRirdf1iMh6PbF3JQD6kysG6Fc4VS1y
	 fTPiGd20WwWlvtzwnHloGLDNfkBTxvV7UKe+Tw8yXnzMBNMAVWfdfL/A2WDQaEvwzw
	 s2g8V/tZ37Q7kGwT8kuyVJ3DlSGKPDxLPEM7CLzU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2BCAFF805EA; Sat,  7 Feb 2026 07:27:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 24D00F805ED;
	Sat,  7 Feb 2026 07:27:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A176F80571; Sat,  7 Feb 2026 07:25:33 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013035.outbound.protection.outlook.com
 [40.93.201.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8AC95F8047D
	for <alsa-devel@alsa-project.org>; Sat,  7 Feb 2026 07:24:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8AC95F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mbR16TCz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epZvwm/Z511m3fL98t98sUNEEi48i0d36hUyaaHRAooqaAgn8+ytPwryaHLysAfu41Y1r97QFDRXGrnmBXZwmAitg3ULbv1cXsttkBREd7udutxDM8masufUmuScvsmouKSO4zbJ+Immxzvty8afA0Vg41Ch6Gym9rfQC43dYAA2x+VroBm33IQ1URjC+K6UIkTXE7NxTyjo+vMSs+GXJvzxl0ZaVeNGJJYG0izVOMxLgVAXavRimchx48NBnGjxm7JE3+HhBczCavnUNTzMGeu9hpEmLZeOEg7c8Usx/RPkegPxncPKcqMFh5x+udUgRFckxFylD1ZD2onMLGhP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCQ+TKGB3ysNpAkV3B2nCYXmeXk9WlNW/fcwxgAJnZA=;
 b=sTelPLWlPLSwaUkStUnan9CQM1vxMgX2qeS4Z1NfUPW6NAOJy941V4tGxHzt1XDjPUWwBCLrxgcv/WAVAsve2rrdkQyNkD2bq1y0n2Ghd+pg6nPDXkLoEzGpD3AUvLffNcAO9Bqw8FqPOQF4BuU3WoNNKs4YKoheuewF69WnNT/fGqqjRBDi63Lh0HRmPCQYbQn+OuJni/an7V7Fv9d/oRuOfUFbh/lIzSMBQuQaLPjKUYPLKR6SVYjG4KpwLRWCbt3WdyUyXyuNeJsRpXK5czk5ph6ek1dGW5peJQ4CL9hSO9SiOEuX9ikzO6H0dzvRL+dISsKk8orjtRNKh1DKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCQ+TKGB3ysNpAkV3B2nCYXmeXk9WlNW/fcwxgAJnZA=;
 b=mbR16TCzE+CYA8p8WykxdFL/+mX2eus19ZzgMjET9mNuaB6sNdnE43o8KaeE6ftI9DcVCaVDSftYiYNbmV76g7676kiqQGw2kEtpT6g1Yp/Hk96ryCWYHYPk42ev+CNMd6hjyQchJTUagUenFliUIzGtNsV0LJdii4unKZnhpaA=
Received: from MN0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:208:52d::14)
 by DS7PR12MB9527.namprd12.prod.outlook.com (2603:10b6:8:251::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Sat, 7 Feb
 2026 06:24:48 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::4a) by MN0PR04CA0024.outlook.office365.com
 (2603:10b6:208:52d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.17 via Frontend Transport; Sat,
 7 Feb 2026 06:24:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sat, 7 Feb 2026 06:24:48 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 7 Feb
 2026 00:24:45 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: maintainer information
Date: Sat, 7 Feb 2026 11:53:51 +0530
Message-ID: <20260207062433.1465232-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|DS7PR12MB9527:EE_
X-MS-Office365-Filtering-Correlation-Id: 63aa8a3f-f1db-4e5a-c2ef-08de66119807
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mvGxVc1a3ZSv34SnZ1HtF3RZM/+A0EBtQPOXc5gBi1P77SAUDzalnP42Y64Z?=
 =?us-ascii?Q?hHIlcscsHjGgXJHi8qTuZSLe4CMYJV5dTHcLRfFbtdIld57IwxDMnDZhAbB7?=
 =?us-ascii?Q?0w1f0dy40aeWMLcHaohSTxwqRT4/ZmIaItfDJCVU9Rwp4ErkhmLsXTs+aPWs?=
 =?us-ascii?Q?+H74vLNyuwTNf7eFqDcZs3SwVAfQ5Pu/szEJ2wlzCHLFnleJogo26x9cm8gF?=
 =?us-ascii?Q?UWa1EfdIVW7doAVONldOa9TXNqpuR+ZrtQ+U3d2ivWiRTCIQUHDO62qxWcoT?=
 =?us-ascii?Q?lDvzsc4w3LnJf+qpZRuP7IvJ5jqMwtgMu8rbMAYmzbt5LnhZPnuU62a/0T3H?=
 =?us-ascii?Q?BWdsA43hdEmppfM9k2P7JyVuYc+8p4KpmY/TdQbOhslGTD8ebY2DCWzbJ6cl?=
 =?us-ascii?Q?ZoGihpgJ1TqhixOAkd+uFcIc2vCLex+2Ui6SY2d0QwKi0U4aK631APM6n4ri?=
 =?us-ascii?Q?PKH2vCToxxqzYtcK2gVsELYo8v5tMhyNTce/xrwPD6ulS4/zVJ0F4C7Eu9JX?=
 =?us-ascii?Q?n8RUQPnbEidOEaNKEkpVoI8BfcTY7EMREFIR5Ma5nBcoDVeEXmN8yns4yCHr?=
 =?us-ascii?Q?8tQg3XGaQO502aqMZSy4Vdul5yNKvI3b0fl9+Ti4fxUkRDdJUaHoyrJKNMza?=
 =?us-ascii?Q?jXrp++AoVMIbM5MVSm11BydKwMrpA9hILD8XHHiEWVFu74ZBAU9VmOKbwCdF?=
 =?us-ascii?Q?W4EJgAw0G47GLVR8pQX1k8Zt2ObeMtlSQwGpeS2X9WirXqi1VlpMiW5TuQ9R?=
 =?us-ascii?Q?0KWccVHUwxRCkj36Wb/Mo9fd3E7lK8chTvRQeuat3/XgxGC8YpJZR4jYkFrJ?=
 =?us-ascii?Q?dFtXCMPyPxXsSXspzsKmWfL8f+xuObw1+3XTCoKCDtUU4cqlAJZxqQ0DJ6g7?=
 =?us-ascii?Q?jBbHIVzochpJlcUJsfpRu6PrDoOtCl4aUKVxbtuTgYK9MGE1MZmC3oYzeR9N?=
 =?us-ascii?Q?AqySf7qLPVRAdbAqCXnEBflugT1/TSIivfjnA9pXAPyXYSbFdIWFxRB+H3ih?=
 =?us-ascii?Q?GAkoN912Bn9D3wj/NBEBNLNsyfavLX/exZePAHb3HfeKLjZ7V/OUW6SwJI+5?=
 =?us-ascii?Q?b3TQ5flcczJpsElx5TTkr4yNR/fnigLFgxIpMmBsofzJyonbRU6X2Z/CX83t?=
 =?us-ascii?Q?drbW9ck8A17Ahdsmo2iFKrD1fpdElqo6ScJoj5BfmiDP+mTxDOj162HxaJjV?=
 =?us-ascii?Q?XK06Nuwg5OGxu5AlaUdOFniBJicHwLwVCQ8lm4HxsG2NK+GViJ9lQ2rkp3OU?=
 =?us-ascii?Q?112SpHDYZLvK9ThgcKun2LN1QkckzC+9LUH040FB7HyRJix4Yz5rOc1p3YZa?=
 =?us-ascii?Q?4pLwhM1LcUdOnfUtys5c7tVKkhpAxkP/NUVqXNuni+zLpR3bo8yeHPqJEvfQ?=
 =?us-ascii?Q?YoILQayjsWDp0j37c/iSrretLJCyEhjgPcbN3q7wHDa8CgQ1dErsT4/kmCkz?=
 =?us-ascii?Q?DRWyd6YjuM00MIVapvc8sbrv/aBtzcpdvgGn2mQYGI2rLntyuWHsKcj4+dAF?=
 =?us-ascii?Q?4jShYm8Bg7TARGebdyIVpFsviNEdO/MMkKpUmEMCPEq8/sgW/jobO8ti3t/F?=
 =?us-ascii?Q?l0lafJtmOAD/Ld9NzsphDvLB5IWMc5s5eXg3ouMrF1fj6mM/5eNjK/4OcOiI?=
 =?us-ascii?Q?U8iAvBUW2Gam/yx7hWZfrqp2P7tMY6TxACV9a3gY/rXMrfaEoEFrAdxSZf4k?=
 =?us-ascii?Q?X5HiAw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	okM3f9P05hfxLBsFFlC3qYj3oOs5e4FNyUjxq4E99TUPNp55Z4GZ0U1BfvOMYEVtvpKrZWiGY+QSvdo18XFkRBlYo9UwIG/ym1Dn/C4u8tjnTpzmraBQbm3j4bxFcjDS68GuQEBrME+ryeiR9gnCmXPvtHHzh5nEGvMrCgF+Vespwhlq74pLAFrdVi63foo5ZYD5/rLAEUojtVX2p5bxIQ5I9tTlb/8wX2+Glqni+tBYxsuWL3DckIs477OdrqlaCOsj8Lc1kS70h8cHS1fYOQY5axlpNwthboPMRva/DPa9UMEaFBJ98dw0aKkY3VRCKh5U2wupIO0dZAZndgPbIA2F0X/a5iRjftjAoMY4KflYnfySJFiIP15C0FoQim4K2A0bPT1EUFyBN+EurpabnTjLfJmatDF5gowAETP3T1uz/YQtwc+IpsHiDw3vYUW0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 06:24:48.3869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 63aa8a3f-f1db-4e5a-c2ef-08de66119807
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9527
Message-ID-Hash: 54MAEOARL6XUR4MSF6FRONV7BNSWDWP3
X-Message-ID-Hash: 54MAEOARL6XUR4MSF6FRONV7BNSWDWP3
X-MailFrom: Vijendar.Mukunda@amd.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/54MAEOARL6XUR4MSF6FRONV7BNSWDWP3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Update MAINTAINERS file for AMD ASoC drivers.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a48a11072e4..f27485e54645 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1030,6 +1030,13 @@ L:	dmaengine@vger.kernel.org
 S:	Supported
 F:	drivers/dma/amd/ae4dma/
 
+AMD ASoC DRIVERS
+M:	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
+R:	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
+L:	linux-sound@vger.kernel.org
+S:	Supported
+F:	sound/soc/amd/
+
 AMD AXI W1 DRIVER
 M:	Kris Chaplin <kris.chaplin@amd.com>
 R:	Thomas Delev <thomas.delev@amd.com>
-- 
2.45.2

