Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D69CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 10:06:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1865B60239;
	Tue, 13 Oct 2026 12:05:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1865B60239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791885968;
	bh=j6Y9+mtmX3icjvMo09zj8Gu02F0tGq8+G1p8RiNp3iY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bYhd3OaFcMjRDGvrrSLuhxFx2tZUfRD+iOyZzKcrydJ0nUzSuhFSf9LQ2Vf0yTmQB
	 HWBGNlJNkG6BjBfg8li/xhZX/qJSoD9X2PScVC1hdiMNIzUSW8D5T+hsyOFe3e3ADj
	 bEhwbuvYWQ1l/70U1SOEuAX8WJP8RhpdDE2SJ6rQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9EF00F8069D; Tue, 13 Oct 2026 12:04:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A946F8069C;
	Tue, 13 Oct 2026 12:04:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2A1E3F80615; Tue, 13 Oct 2026 12:04:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.38
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791885875;
	b=VpKnxZwVGLwohBhaV+2EC8DkcrNHMmLDIwGthaTT2ZFqVaA+eAM2AiUGpXtxrseYwF/n
	 DT70I8V0oJIpVUreK1DsDNYmdz+j4TTKyjSraOV1zsH47XFSU044mSsIT2+ECw9YkWpe7
	 ak0aKV4mtpqI8C9JP/9Da0vRE3HgIKgqXY7banxjWoCjRZttnSIPC7lNI/8qx4ZyBZIYV
	 lLpM/9JpAiKkYV6cw92t7fx7+cNbU2Hf9T4s72X99F3tqK+KJe8YmjkGPF8UveXZVDZ5b
	 W2EFBGb8a8GazFgizqCtz0R1IT/tA7XxIp+nfLOiJSE+Tx3tXsbhEB7fR3M3RMCCo1w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791885875;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j6Y9+mtmX3icjvMo09zj8Gu02F0tGq8+G1p8RiNp3iY=;
	b=QggAuIkDVjPR4Ofmsw/t8XzIOR5+bjOSrc0iVM3TX0xnU3kM+ZNRUAwvRGq/xp4iK2Ja
	 nqXT7z/MBTkhWPk9+1V4GQir6fa9aH5VaXXl1m/GjZ4f97kB4SJqW9RQGiVpFCrIFRsjK
	 FQSxIcagNXCX47k3fxPOJqh2An7txut4L5BQbxHR6oeJsz4tA4Dyr4cjgf/oG9nJVtCNx
	 c9XZYOBxqKJE5megDM5LxJKJtkQcYBC0AiRYWFZrvxvI8hveeGLhjTpFQ0iHiQvQIY+wR
	 VfpCm3n+xu2avLsnldcxPdRg1VVY/zU+lcU6AR/4IsTeqs2499IW+Ii0W2XqfpZPxrA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=oWCQIye0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.38
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CD022F80495
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 12:04:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD022F80495
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=oWCQIye0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yijmt+4xQQPjp+3/n/O8ZPf0uG/CDDA0ZZ4N9wUJIJ1HQf4sDAJeaDqkFiThCuDrHtQBllcjVOXzFVoLu8LQYCa75K/Hei5mwCOXDbcGUx1aj5ijage79nJyq02EDOcdmjDY3kh2fMQyqPBDgjch725ickMXtilDuffzA6ngTdkenKOx1L6x4tSfcbh/b6Kmu2q9n9/EN+88XuphvAkQ0s5a0bvGh1MKwZ/+tfPzGNdfYDDWoAqK8M3rr+vfoqGIMaiXRE+HrPCWJJHY6jIFS1reMsWJC6mjjszx80CpU8364oGVLm/WGYnZPtMI83MUfkNGQm0smxdMaSMnHq4KRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svoUWV1ungNECDFHo3YnyMxx61KTd/LTRVrXc8SqP7E=;
 b=n+n+9K7hy67wwAjHub29n8bN5N1yzSHLDwdaubI/R7dYemquT9JZ3wUEAFPgoguGQ8oSh9B/eV5PgX3u3S9lR8Ii94n8/2RjqeaghuzMGtZEg2SjU/zU+VmCERuJ4LbjE3v53oj5NANcff6Pp8wnj9k/M9qZd1JhPRKrlMrHZHwX2IVtsXfTcMR+a2bPHJKSCItlbl2ismc02+gXktt/TrEZWwvYIHw9Czq998+XrQABngfiuBRJytifsxni3+gsZtI0XHdHJTaYwSKe5MHEWiVL8XPYO2jIbwbVDXrbxDDf7K1SYoOS8iLcNO4WscpK5s5xvHG12pWHfsViQyBiCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svoUWV1ungNECDFHo3YnyMxx61KTd/LTRVrXc8SqP7E=;
 b=oWCQIye0ZljNDnYtMzooOlAdWqs39uPJMUEtN8A01abmTUnff22a6h4D5Ckx++yrGXRUq9/SlODGTQuYAdGOZ3ieLbsSj6rFLfeq8B7DVZSsLUtw/LQA9rypKFHiGd3L/jCS/Gnp73B/rFHScnGRbreYi0B+ZWrj/XV69eS3zSU=
Received: from BY3PR04CA0015.namprd04.prod.outlook.com (2603:10b6:a03:217::20)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 10:04:27 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::88) by BY3PR04CA0015.outlook.office365.com
 (2603:10b6:a03:217::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 10:04:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 10:04:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 05:04:14 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 05:04:10 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 4/9] soundwire: amd: rename hardware backend symbols to
 amd_acp63_*() prefix
Date: Tue, 13 Oct 2026 15:28:50 +0530
Message-ID: <20261013100306.2921771-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
References: <20261013100306.2921771-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|DM4PR12MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cef063-46b3-4979-4891-08df29115d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|261009223027099003|261009223327099003|261009221227099003|261009220027099003|261009221727099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	boZnv8PcV2IHu3M+zBNTvjQirXVse6eSdYoHwfOeJ8PlR41rECs9r3edupLZBmRz7csaNzXkTzRRWrfQ/eovc3NOD83+7Ac6IzVG8swXL1/jqvuLr6aejVYCUNQ/flPpSd+MuteMphhGIXu9Lq3R9pLICeTEcikgZrVn7+BcTKIDDSH4FIZWpP7C5HgdQj1aJCZjpwon8km2j9wc/nvRr+Eg856n3eJfsUBwbo+M+c74awKlRNCho9Czt+3ltcq2wCBLj3w9td42DUB/uLyZX7lubiWuuTNmEwE3e9bavXM1Rc/E6f4ITjUswNBe9fiURHItaRGNlj5EkS1km1UtW/7ovg2RLJs5emLufhEXLLkVLFdVZ40sQv+EzPD6gWk59V9hSBwg6m+iFVb9UyWeU0qLRdIdXypCd1etJVY1nHE3ti4Qf39UZUG5UBSNjWG9c0okZ4GRDRGo/jsivqhARlUXaTuAtFAybhsyEelMc7YhblpnU/R1gx9bMstk1SFT83iRjevYoJ2TtI1pdsj86d1Uf7R+vvYSVcSDRTbHI4xzTP1yUls5gwUvQm4N1uwvDh4/pgDa1ASiaBuvb45YcCaupFMhrAqlHNGLzlgjbzFXEE6zqILlPGnFPcCXDxoA6rEQnHDAgbLEY4iCsxq2or1NMJ1x4X7qF9BfSGmRH0ifNw9S5V1tGh3vnOxUmaeBVn3QUxXfroYLZMSiuxpKIw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009221727099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	cn49/kunUIkMFr+EiB2Abo5gjprll6tl5t82VG6iaxh/SpOfXFhdjwMXWGEAlJUU1hJGaeIogm07HI+qMdWU8EfB+J2p5ZbyauC5S0+a/Q0r91eJVrbumqWhLd8jWbBqjxRhoUNhneZFNAD19nIS0S+nNyAHq2K/MjTH1Nl88KM3yK6fphtqMsnCjqL5WjawPoYYcdHP2HDdN035bQRd4aQYbP9VsAMdOdatrnqK3FTfXgH8oDGpxdlf+M2x5C24UirdaArHJdeGWsWG9mhPPoFt8to3wmuJV4Bnq4/VB2GaD5EERd38rLQBQYO/Z9nKBpJtAofLOchby19/jox0TgJwmrS4t89mDi9PQzQDuKIpdzYGWWRC/AA6YU6FqQSfYhF400SEhV2KNM0XAH49aXHbwSEoBR6EtxdA8y5sfSt0gAW8WMTDw8XX8oa+JyGI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:04:26.7437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 60cef063-46b3-4979-4891-08df29115d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866
Message-ID-Hash: LNVD7XHV3A67YHSXUTSZPZVWKKNGKOYG
X-Message-ID-Hash: LNVD7XHV3A67YHSXUTSZPZVWKKNGKOYG
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LNVD7XHV3A67YHSXUTSZPZVWKKNGKOYG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In preparation for the hw_ops dispatch framework, rename the
revision-specific hardware-access functions, op-table instances and
the register-offset constant in amd_manager.c / amd_manager.h to the
amd_acp63_*() / ACP63_* prefix. The amd_acp63_ prefix denotes ACP6.3
as the base revision of this shared IP block, not ACP6.3-only support.

Generic SoundWire protocol helpers (amd_sdw_xfer_msg(), amd_prop_read(),
amd_sdw_clock_stop() and related bus helpers) and the top-level
work_struct handlers (amd_sdw_irq_thread(),
amd_sdw_update_slave_status_work()) intentionally keep the amd_sdw_*()
prefix; inline comments mark them as revision-independent. All other
amd_sdw_*() and amd_*() functions in the hardware path are renamed,
including amd_acp63_sdw_process_wake_event().

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 158 +++++++++++++++++---------------
 drivers/soundwire/amd_manager.h |   7 +-
 2 files changed, 92 insertions(+), 73 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index c4eb97e46807..c585f7d529c0 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -27,7 +27,7 @@
 
 #define to_amd_sdw(b)	container_of(b, struct amd_sdw_manager, bus)
 
-static int amd_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
 {
 	struct sdw_bus *bus = &amd_manager->bus;
 	struct sdw_master_prop *prop = &bus->prop;
@@ -57,7 +57,7 @@ static int amd_sdw_clk_init_ctrl(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
-static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_init_sdw_manager(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
 	int ret;
@@ -89,7 +89,7 @@ static int amd_init_sdw_manager(struct amd_sdw_manager *amd_manager)
 				  AMD_SDW_TIMEOUT);
 }
 
-static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
 
@@ -98,7 +98,7 @@ static int amd_enable_sdw_manager(struct amd_sdw_manager *amd_manager)
 				  AMD_SDW_TIMEOUT);
 }
 
-static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
 
@@ -115,7 +115,7 @@ static int amd_disable_sdw_manager(struct amd_sdw_manager *amd_manager)
 				  AMD_SDW_TIMEOUT);
 }
 
-static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
 
@@ -131,7 +131,7 @@ static void amd_enable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 	writel(AMD_SDW_IRQ_ERROR_MASK, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
 }
 
-static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 {
 	u32 irq_mask;
 
@@ -146,7 +146,7 @@ static void amd_disable_sdw_interrupts(struct amd_sdw_manager *amd_manager)
 	writel(0x00, amd_manager->mmio + ACP_SW_ERROR_INTR_MASK);
 }
 
-static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
 {
 	u32 frame_size;
 
@@ -154,7 +154,7 @@ static void amd_sdw_set_frameshape(struct amd_sdw_manager *amd_manager)
 	writel(frame_size, amd_manager->mmio + ACP_SW_FRAMESIZE);
 }
 
-static void amd_sdw_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
+static void amd_acp63_sdw_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
 {
 	u32 wake_ctrl;
 
@@ -167,7 +167,8 @@ static void amd_sdw_wake_enable(struct amd_sdw_manager *amd_manager, bool enable
 	writel(wake_ctrl, amd_manager->mmio + ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
 }
 
-static int amd_sdw_set_device_state(struct amd_sdw_manager *amd_manager, u32 target_device_state)
+static int amd_acp63_sdw_set_device_state(struct amd_sdw_manager *amd_manager,
+					  u32 target_device_state)
 {
 	u32 sdw_dev_state;
 
@@ -190,7 +191,7 @@ static int amd_sdw_set_device_state(struct amd_sdw_manager *amd_manager, u32 tar
 	return 0;
 }
 
-static int amd_sdw_host_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
+static int amd_acp63_sdw_host_wake_enable(struct amd_sdw_manager *amd_manager, bool enable)
 {
 	u32 intr_cntl1;
 	u32 sdw_host_wake_irq_mask;
@@ -244,8 +245,8 @@ static void amd_sdw_ctl_word_prep(u32 *lower_word, u32 *upper_word, struct sdw_m
 	*lower_word = lower_data;
 }
 
-static int amd_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_data,
-				     u32 upper_data, u64 *response)
+static int amd_acp63_sdw_send_cmd_get_resp(struct amd_sdw_manager *amd_manager, u32 lower_data,
+					   u32 upper_data, u64 *response)
 {
 	u32 lower_resp, upper_resp;
 	u32 sts;
@@ -301,7 +302,8 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.buf = &msg->addr_page1;
 	scp_msg.flags = SDW_MSG_FLAG_WRITE;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[0])) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data,
+					    &response_buf[0])) {
 		dev_err_ratelimited(amd_manager->dev,
 				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -309,7 +311,8 @@ amd_program_scp_addr(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg)
 	scp_msg.addr = SDW_SCP_ADDRPAGE2;
 	scp_msg.buf = &msg->addr_page2;
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, &scp_msg, 0);
-	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response_buf[1])) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data,
+					    &response_buf[1])) {
 		dev_err_ratelimited(amd_manager->dev,
 				    "SCP_addrpage command timeout for Slave %d\n", msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -374,6 +377,7 @@ static enum sdw_command_response amd_sdw_fill_msg_resp(struct amd_sdw_manager *a
 	return SDW_CMD_OK;
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struct sdw_msg *msg,
 				      int cmd_offset)
 {
@@ -381,7 +385,7 @@ static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struc
 	u32 upper_data = 0, lower_data = 0;
 
 	amd_sdw_ctl_word_prep(&lower_data, &upper_data, msg, cmd_offset);
-	if (amd_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, lower_data, upper_data, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "command timeout for Slave %d\n",
 				    msg->dev_num);
 		return SDW_CMD_TIMEOUT;
@@ -389,6 +393,7 @@ static unsigned int _amd_sdw_xfer_msg(struct amd_sdw_manager *amd_manager, struc
 	return amd_sdw_fill_msg_resp(amd_manager, msg, response, cmd_offset);
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sdw_msg *msg)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
@@ -405,6 +410,7 @@ static enum sdw_command_response amd_sdw_xfer_msg(struct sdw_bus *bus, struct sd
 	return SDW_CMD_OK;
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 index, u32 status)
 {
 	switch (status) {
@@ -419,6 +425,7 @@ static void amd_sdw_fill_slave_status(struct amd_sdw_manager *amd_manager, u16 i
 	}
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *amd_manager)
 {
 	u64 slave_stat;
@@ -436,12 +443,12 @@ static void amd_sdw_process_ping_status(u64 response, struct amd_sdw_manager *am
 	}
 }
 
-static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_manager)
 {
 	u64 response;
 
 	mutex_lock(&amd_manager->bus.msg_lock);
-	if (amd_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		mutex_unlock(&amd_manager->bus.msg_lock);
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
@@ -454,7 +461,7 @@ static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_man
 	mutex_unlock(&amd_manager->bus.msg_lock);
 }
 
-static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
+static u32 amd_acp63_sdw_read_ping_status(struct sdw_bus *bus)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u64 response;
@@ -463,7 +470,7 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	/* Called by sdw_show_ping_status() which holds msg_lock. */
 	lockdep_assert_held(&bus->msg_lock);
 
-	if (amd_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
+	if (amd_acp63_sdw_send_cmd_get_resp(amd_manager, 0, 0, &response)) {
 		dev_err_ratelimited(amd_manager->dev, "SDW%x ping status timeout\n",
 				    amd_manager->instance);
 		return amd_manager->ping_slave_stat == U32_MAX ? 0 : amd_manager->ping_slave_stat;
@@ -476,7 +483,7 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	return slave_stat;
 }
 
-static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
+static int amd_acp63_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime *stream)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	struct sdw_transport_data t_data = {0};
@@ -562,8 +569,8 @@ static int amd_sdw_compute_params(struct sdw_bus *bus, struct sdw_stream_runtime
 	return 0;
 }
 
-static int amd_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
-			       unsigned int bank)
+static int amd_acp63_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_params,
+				     unsigned int bank)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u32 frame_fmt_reg, dpn_frame_fmt;
@@ -599,9 +606,9 @@ static int amd_sdw_port_params(struct sdw_bus *bus, struct sdw_port_params *p_pa
 	return 0;
 }
 
-static int amd_sdw_transport_params(struct sdw_bus *bus,
-				    struct sdw_transport_params *params,
-				    enum sdw_reg_bank bank)
+static int amd_acp63_sdw_transport_params(struct sdw_bus *bus,
+					  struct sdw_transport_params *params,
+					  enum sdw_reg_bank bank)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u32 dpn_frame_fmt;
@@ -676,9 +683,9 @@ static int amd_sdw_transport_params(struct sdw_bus *bus,
 	return 0;
 }
 
-static int amd_sdw_port_enable(struct sdw_bus *bus,
-			       struct sdw_enable_ch *enable_ch,
-			       unsigned int bank)
+static int amd_acp63_sdw_port_enable(struct sdw_bus *bus,
+				     struct sdw_enable_ch *enable_ch,
+				     unsigned int bank)
 {
 	struct amd_sdw_manager *amd_manager = to_amd_sdw(bus);
 	u32 dpn_ch_enable;
@@ -755,6 +762,7 @@ static int sdw_master_read_amd_prop(struct sdw_bus *bus)
 	return 0;
 }
 
+/* AMD SoundWire bus helper shared across all ACP revisions. */
 static int amd_prop_read(struct sdw_bus *bus)
 {
 	sdw_master_read_prop(bus);
@@ -762,16 +770,16 @@ static int amd_prop_read(struct sdw_bus *bus)
 	return 0;
 }
 
-static const struct sdw_master_port_ops amd_sdw_port_ops = {
-	.dpn_set_port_params = amd_sdw_port_params,
-	.dpn_set_port_transport_params = amd_sdw_transport_params,
-	.dpn_port_enable_ch = amd_sdw_port_enable,
+static const struct sdw_master_port_ops amd_acp63_sdw_port_ops = {
+	.dpn_set_port_params = amd_acp63_sdw_port_params,
+	.dpn_set_port_transport_params = amd_acp63_sdw_transport_params,
+	.dpn_port_enable_ch = amd_acp63_sdw_port_enable,
 };
 
-static const struct sdw_master_ops amd_sdw_ops = {
+static const struct sdw_master_ops amd_acp63_sdw_ops = {
 	.read_prop = amd_prop_read,
 	.xfer_msg = amd_sdw_xfer_msg,
-	.read_ping_status = amd_sdw_read_ping_status,
+	.read_ping_status = amd_acp63_sdw_read_ping_status,
 };
 
 static int amd_sdw_hw_params(struct snd_pcm_substream *substream,
@@ -967,7 +975,7 @@ static void amd_sdw_update_slave_status_work(struct work_struct *work)
 			       ACP_SW_STATE_CHANGE_STATUS_MASK_0TO7);
 			writel(AMD_SDW_IRQ_MASK_8TO11, amd_manager->mmio +
 			       ACP_SW_STATE_CHANGE_STATUS_MASK_8TO11);
-			amd_sdw_read_and_process_ping_status(amd_manager);
+			amd_acp63_sdw_read_and_process_ping_status(amd_manager);
 			goto update_status;
 		} else {
 			dev_err_ratelimited(amd_manager->dev,
@@ -1001,7 +1009,7 @@ static void amd_sdw_update_slave_status(u32 status_change_0to7, u32 status_chang
 	}
 }
 
-static void amd_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
+static void amd_acp63_sdw_process_wake_event(struct amd_sdw_manager *amd_manager)
 {
 	dev_dbg(amd_manager->dev, "SoundWire Wake event reported\n");
 	pm_request_resume(amd_manager->dev);
@@ -1024,12 +1032,12 @@ static void amd_sdw_irq_thread(struct work_struct *work)
 		amd_manager->instance, status_change_0to7, status_change_8to11);
 
 	if (status_change_8to11 & AMD_SDW_WAKE_STAT_MASK) {
-		amd_sdw_process_wake_event(amd_manager);
+		amd_acp63_sdw_process_wake_event(amd_manager);
 		status_change_8to11 &= ~AMD_SDW_WAKE_STAT_MASK;
 	}
 
 	if (status_change_8to11 & AMD_SDW_PREQ_INTR_STAT) {
-		amd_sdw_read_and_process_ping_status(amd_manager);
+		amd_acp63_sdw_read_and_process_ping_status(amd_manager);
 	} else {
 		/* Check for the updated status on peripheral device */
 		amd_sdw_update_slave_status(status_change_0to7, status_change_8to11, amd_manager);
@@ -1047,17 +1055,17 @@ int amd_sdw_manager_start(struct amd_sdw_manager *amd_manager)
 
 	prop = &amd_manager->bus.prop;
 	if (!prop->hw_disabled) {
-		ret = amd_sdw_clk_init_ctrl(amd_manager);
+		ret = amd_acp63_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_init_sdw_manager(amd_manager);
+		ret = amd_acp63_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_enable_sdw_interrupts(amd_manager);
-		ret = amd_enable_sdw_manager(amd_manager);
+		amd_acp63_enable_sdw_interrupts(amd_manager);
+		ret = amd_acp63_enable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_sdw_set_frameshape(amd_manager);
+		amd_acp63_sdw_set_frameshape(amd_manager);
 	}
 	/* Enable runtime PM */
 	pm_runtime_set_autosuspend_delay(amd_manager->dev, AMD_SDW_MASTER_SUSPEND_DELAY_MS);
@@ -1093,15 +1101,15 @@ static int amd_sdw_manager_probe(struct platform_device *pdev)
 	amd_manager->ping_slave_stat = U32_MAX;
 	amd_manager->instance = pdata->instance;
 	amd_manager->mmio = amd_manager->acp_mmio +
-			    (amd_manager->instance * SDW_MANAGER_REG_OFFSET);
+			    (amd_manager->instance * ACP63_SDW_MANAGER_REG_OFFSET);
 	amd_manager->acp_sdw_lock = pdata->acp_sdw_lock;
 	amd_manager->acp_rev = pdata->acp_rev;
 	amd_manager->cols_index = sdw_find_col_index(AMD_SDW_DEFAULT_COLUMNS);
 	amd_manager->rows_index = sdw_find_row_index(AMD_SDW_DEFAULT_ROWS);
 	amd_manager->dev = dev;
-	amd_manager->bus.ops = &amd_sdw_ops;
-	amd_manager->bus.port_ops = &amd_sdw_port_ops;
-	amd_manager->bus.compute_params = &amd_sdw_compute_params;
+	amd_manager->bus.ops = &amd_acp63_sdw_ops;
+	amd_manager->bus.port_ops = &amd_acp63_sdw_port_ops;
+	amd_manager->bus.compute_params = &amd_acp63_sdw_compute_params;
 	amd_manager->bus.clk_stop_timeout = 200;
 	amd_manager->bus.link_id = amd_manager->instance;
 
@@ -1170,15 +1178,21 @@ static void amd_sdw_manager_remove(struct platform_device *pdev)
 
 	if (pm_runtime_enabled(&pdev->dev))
 		pm_runtime_disable(&pdev->dev);
-	amd_disable_sdw_interrupts(amd_manager);
+	amd_acp63_disable_sdw_interrupts(amd_manager);
 	cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 	cancel_work_sync(&amd_manager->amd_sdw_work);
 	sdw_bus_master_delete(&amd_manager->bus);
-	ret = amd_disable_sdw_manager(amd_manager);
+	ret = amd_acp63_disable_sdw_manager(amd_manager);
 	if (ret)
 		dev_err(&pdev->dev, "Failed to disable device (%pe)\n", ERR_PTR(ret));
 }
 
+/*
+ * AMD SoundWire clock-stop sequence shared across all ACP revisions.
+ * Differences between revisions in this path are minimal; a switch/case
+ * on acp_rev is sufficient to accommodate any variant-specific additions
+ * needed for future platforms.
+ */
 static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
 {
 	u32 val;
@@ -1210,7 +1224,7 @@ static int amd_sdw_clock_stop(struct amd_sdw_manager *amd_manager)
 	return 0;
 }
 
-static int amd_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
+static int amd_acp63_sdw_clock_stop_exit(struct amd_sdw_manager *amd_manager)
 {
 	int ret;
 	u32 val;
@@ -1302,7 +1316,7 @@ static int amd_sdw_host_wake_enable_by_rev(struct amd_sdw_manager *amd_manager,
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		return amd_sdw_host_wake_enable(amd_manager, enable);
+		return amd_acp63_sdw_host_wake_enable(amd_manager, enable);
 	default:
 		dev_err(amd_manager->dev, "unexpected acp_rev 0x%x\n", amd_manager->acp_rev);
 		return -EINVAL;
@@ -1323,22 +1337,22 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_disable_sdw_interrupts(amd_manager);
+		amd_acp63_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, false);
+		amd_acp63_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_enable_sdw_interrupts(amd_manager);
+		amd_acp63_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_disable_sdw_interrupts(amd_manager);
+		amd_acp63_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, false);
+		amd_acp63_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
 		if (ret)
 			return ret;
@@ -1349,7 +1363,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_disable_sdw_manager(amd_manager);
+		ret = amd_acp63_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1359,7 +1373,7 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
+		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
 		break;
@@ -1383,29 +1397,29 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		return 0;
 	}
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		amd_disable_sdw_interrupts(amd_manager);
+		amd_acp63_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, true);
+		amd_acp63_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_enable_sdw_interrupts(amd_manager);
+		amd_acp63_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
-		amd_disable_sdw_interrupts(amd_manager);
+		amd_acp63_disable_sdw_interrupts(amd_manager);
 		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
-		amd_sdw_wake_enable(amd_manager, true);
+		amd_acp63_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
 			return ret;
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_disable_sdw_manager(amd_manager);
+		ret = amd_acp63_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
 	}
@@ -1415,7 +1429,7 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
+		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D3);
 		if (ret)
 			return ret;
 		if (amd_manager->wake_en_mask) {
@@ -1448,7 +1462,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
-		ret = amd_sdw_clock_stop_exit(amd_manager);
+		ret = amd_acp63_sdw_clock_stop_exit(amd_manager);
 		if (ret)
 			return ret;
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
@@ -1483,17 +1497,17 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 			}
 		}
 		sdw_clear_slave_status(bus, SDW_UNATTACH_REQUEST_MASTER_RESET);
-		ret = amd_sdw_clk_init_ctrl(amd_manager);
+		ret = amd_acp63_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		ret = amd_init_sdw_manager(amd_manager);
+		ret = amd_acp63_init_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_enable_sdw_interrupts(amd_manager);
-		ret = amd_enable_sdw_manager(amd_manager);
+		amd_acp63_enable_sdw_interrupts(amd_manager);
+		ret = amd_acp63_enable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-		amd_sdw_set_frameshape(amd_manager);
+		amd_acp63_sdw_set_frameshape(amd_manager);
 	}
 	switch (amd_manager->acp_rev) {
 	case ACP63_PCI_REV_ID:
@@ -1501,7 +1515,7 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 	case ACP70_PCI_REV_ID:
 	case ACP71_PCI_REV_ID:
 	case ACP72_PCI_REV_ID:
-		ret = amd_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
+		ret = amd_acp63_sdw_set_device_state(amd_manager, AMD_SDW_DEVICE_STATE_D0);
 		if (ret)
 			return ret;
 		break;
diff --git a/drivers/soundwire/amd_manager.h b/drivers/soundwire/amd_manager.h
index 76ecaceb3ee5..adde192f61fe 100644
--- a/drivers/soundwire/amd_manager.h
+++ b/drivers/soundwire/amd_manager.h
@@ -8,7 +8,12 @@
 
 #include <linux/soundwire/sdw_amd.h>
 
-#define SDW_MANAGER_REG_OFFSET				0xc00
+/*
+ * Register offset between successive SoundWire manager instances.
+ * This value applies to ACP6.3, ACP7.0, ACP7.1, and ACP7.2. A new
+ * revision with a different offset must define its own constant.
+ */
+#define ACP63_SDW_MANAGER_REG_OFFSET				0xc00
 #define AMD_SDW_DEFAULT_ROWS				50
 #define AMD_SDW_DEFAULT_COLUMNS				10
 #define ACP_PAD_PULLDOWN_CTRL				0x0001448
-- 
2.48.1

