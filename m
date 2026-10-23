Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1978606A31A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=AqMHoNpC;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wKVTq5El
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5BBAA6020F;
	Fri, 23 Oct 2026 08:56:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5BBAA6020F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792738590;
	bh=RJf270KOsZqGtRTGmzFA0PRteiVrVwEYACiVInu4qUg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AqMHoNpCBTHspURisOT6t+ZLlC7M1oIbALUgDWGS3XuJxKN+H5y1KAsPy5YhVV9ja
	 EuRaE/lAX0UviccDSnVKBG8nQ8RhCZDvnsBEUyMiLJ8h1e9YN6WH4Yk1J2qTdarlE+
	 vHY303/5h+PQcjbAJMa8KQus7pzOltvwg51lkbHM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 938E5F806D6; Fri, 23 Oct 2026 08:54:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11C09F806DF;
	Fri, 23 Oct 2026 08:54:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5DF7F80674; Fri, 23 Oct 2026 08:54:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 11EAFF804B4;
	Fri, 23 Oct 2026 08:54:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11EAFF804B4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wKVTq5El
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFGT5xQCk5FM48ePv7sPD3gmPzFKVMPVwClnRZt5G4N4REkn1KylzfA7AYYs6vyHQEhSWCtyHYo/3XMUUnVG+X+gnx020L4WsbeO9+tTDXaYHGgjBJfuI12Oi5xuWrNvfcBIQ7alsuf1i2swdTN2RDoX6FjKSTetRSXt4SdrtkCtJ89qqjjDbegw+aS+eAKG+FKIszZ3I4W3mX9JgaonnZCLDGX5gy8CrvUQNwNuHttd1bwX3aB0IgG5043h9Vw0he/e+imH+t5J3WZxjDUrWMZMtyMI0N/n6v4j/jxHKYa8d/551rk9+zurfMMPqJHXH6hJgEC5Wfo+aM267tTmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jk3uKBqqMdrXg51aR71N7qZGo68EbVXi8zWAHS1yb9w=;
 b=cvLa/kyYUdBC/PGHRx8QpS56MbZIfMSk/1lPjxDwVw0e4QFt82wLrgSmC3I9v1JAW0vREr3EqiLy7GvenE9yb291ZSllu3EGcaHLkcCvM68CwyWXJZlDEidtgP+L59c31HmVjFG3mk4BmTGtDfvORB1Dh9C/8TybHugWlXJ2ZeHstUYKvpE2+gsV6DvaDodaysDxvyOiXnCMGGFXG4BZ6EesQhYxTYIS5vxsEVD4mceQNcb0ZBt+8DAeBf7t+boyu0Vf02UF++GQP6D+W2wOcHpxN7kyYxL+n0Mc1mRAj8RJlYgovYC/bXONxtHh72t4JukkG9A/4M6bEH2usQ7Jvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jk3uKBqqMdrXg51aR71N7qZGo68EbVXi8zWAHS1yb9w=;
 b=wKVTq5EloNVjE8k/bwWkYzZZ96uyha4Ns+57uqglJr88HOwXlEBYtQ6etykIYj50F/m68R7erfzOqTzS57PXRqWs9EWd9DnaaM/dPee0JDwkTeyTFhBOxxZ4xzjd259pEuQFhqALrFsT/y/yKNd4C2WPKThtwyxtERQNnsRgggY=
Received: from MN0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:52d::10)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 06:54:19 +0000
Received: from MN7PEPF0000014C.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::90) by MN0PR04CA0017.outlook.office365.com
 (2603:10b6:208:52d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 06:54:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014C.mail.protection.outlook.com (10.167.254.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 06:54:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:54:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:54:16 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 01:54:12 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <pierre-louis.bossart@linux.dev>,
	<yung-chuan.liao@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH v3 11/13] ASoC: SOF: amd: add alt_machines for ACP7.F SOF
 SoundWire
Date: Fri, 23 Oct 2026 12:20:47 +0530
Message-ID: <20261023065216.3473883-12-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
References: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014C:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: 1222945f-039b-42f6-066e-08df30d275aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|18002099003|22082099003|10067099003|11063799006|56012099006|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 
	y12AmsVBGYRoUylEONmOZrzFdmYAoboc/ISahv3nRJApQ9sFMJL+28qYp3a1IsouC4B9voSJKBshIxUfi0fCVhR8IEj8xUwyFe8Wc5pmHoiSMYwC/4s3jSnjPPk9U/PIHS0S2HdXuVQr6NZVW+OxVAnZfEYmXNyzjzwbYtyk9KgWJWMj0jz9p6ttdVdyRNsKZveJpFvf37LXGL53PD3dsC1PlTU/xblT7Rp+gwEw5UKWgOzPBQUJ7Dell/d76C602NqMASrdpsOCjbZeSUF3Llzlug3xWtocJM++G0E6XizpOJ5ENQGgH5d5VSnPZRYSRqUWsb+Cv+VSEcAKRmRh9C8DNs0W8eh0BKoFnWF1NKK+24cmo/yLLi6jDSaRM4UW3eRTTg9eO8nFmBLO8qYVnsDL8bIFvB26g28FvyCZxnQNYWzeDqagg5WmHHdolmhKFk4zVgzKr64Zieh1T0Py6OmdW8qb/4L+Cl8suQmK1TRP05XGm1OIhijXwovIiUhSzOOjAMs3zSBhHqqiVpY9im5X5GYa6x9DeZ9tx+9oPAjywwNmztfyoGcGx7yVu/aL6wnuNjotTQ+Vewktjo06gMpe+QO1ZfBwbhzJeZlA0vOnd1I8QN9dFibgaCe6Yq0aH7YL0+VsYw9D8W1q0eDuH14C0owVdz101t2plHxIqSpk3sWCsguzRTfmG25mVQI2RaHwfUCXuJGiS9rv7VdYqw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	wJcuZ+obKGliz0C4uVGELYWi0e8QshJQnIaiVbIJBxpJ2Dk7DgwcAdaisX/3fS21MRGpGwc9wwfY3GZbxcwEulNzRF0M9QtrUKehJq9ZXM4Vm62mRUP24HP67DBm3/ji2gvDotc+ZUAPoqq5dKucDEJQmXBML4Zq/XQy1148yFcKc4v6zgKgST/6Etn7cS60DLrtxpfNHYSXHXurGnl0++6sbYuj0FHkDabiOns2l5tQ+RTpx4XhK9j8rhGQpbZfsKnugI6Ldbq0m8BA6aRz1LeqnY/SvvuicX9nQFxaHTrzHmCGXsWRL/SS7NdS+dkBJNsGhuBtJz5IBG29388mu25l1B3HWpAi9dSb8GClgUdspn+UmfBbtDvYBRyJk3rGosXr1nBq4MZKHm58zCO1IhBDEfT2I01bORfNjUBo9Aj/lEaYZSwpOLtFkUPWlt+4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:54:18.4787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1222945f-039b-42f6-066e-08df30d275aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN7PEPF0000014C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867
Message-ID-Hash: QDFCLVIP3XDTAJJ4GLHTEWWONKBBZDBP
X-Message-ID-Hash: QDFCLVIP3XDTAJJ4GLHTEWWONKBBZDBP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QDFCLVIP3XDTAJJ4GLHTEWWONKBBZDBP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Register snd_soc_acpi_amd_acp7f_sof_sdw_machines as alt_machines in
the ACP7.F SOF device descriptor so that the SOF core selects the
SoundWire machine driver when ADR devices are detected on ACP7.F
platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/pci-acp7x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
index 5a21ab8ebb4b9..2999dc6d72a63 100644
--- a/sound/soc/sof/amd/pci-acp7x.c
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -89,6 +89,7 @@ static const struct sof_amd_acp_desc acp7f_chip_info = {
 
 static const struct sof_dev_desc acp7f_desc = {
 	.machines		= snd_soc_acpi_amd_acp7f_sof_machines,
+	.alt_machines		= snd_soc_acpi_amd_acp7f_sof_sdw_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
-- 
2.48.1

