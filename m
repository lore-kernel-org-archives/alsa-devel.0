Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77CC606A31A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=QFFor+0c;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=PVKf57Q8
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7D0360212;
	Fri, 23 Oct 2026 08:55:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7D0360212
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792738527;
	bh=RfNE6tjB2ouyMktYc5QbFrNcQ8/Nuwa6XdEZgG1YmEo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=QFFor+0cSyJxX2VKe4C7z0Zl0Q06xdeRbpU1I4qJpTNCEus5osbuBtJBrz6wGYXJg
	 9TvIw4AYbcPL5Ph5Fgklu1ybLBR0scBuJqq8sf/SiT69Vo4aHbkixSBBTfSRdszgjx
	 phfeDcQLjGiM9OzwFL0JCFIZnGN9sQpfa7SRv0fI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1413BF8067E; Fri, 23 Oct 2026 08:54:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F05FF80689;
	Fri, 23 Oct 2026 08:54:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 49AB4F8063A; Fri, 23 Oct 2026 08:54:23 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 60749F8061F;
	Fri, 23 Oct 2026 08:54:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60749F8061F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=PVKf57Q8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flgusF5/DC2d3fazK15q9q4N4Zy02GfTyVAzR03G/g2Q3r9VxHNwqQzpOs/eQe0Nua7bi+avv/TknoyRrQwz5eq/vGkAFsmH+LcRDgTo8mi2Oen9gVMADYe36mfdK5lcCJwJ79EJTZ/OWPTZQTvytCxbOML/s0wO/cS5S3lG+ICrrXO0S3cE3M7QR4m13BtPWQADnsuTl8YHy01+nEQWuYakT5DZXuBtdU3hjoKyjYYGzi1du1pG/+h8CfTEwlBYzHo5ou5enQuc+aZrANWPlxNbhosUWBSfKdIOHyvL9ZJ8EaT8EArbwtEJNRiKcw+jHZWjVJUMx8rcvjHb8T+UiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oT7bOxxZhHHwQnYc7SzVCT84ucx6fKIduB/9snF/N5c=;
 b=e/KLm4Y5CDT0YbI0q/CI9PjLvVtwGnbrmx59uzqsMp9UQLCvMa9QW88GUugjFxdkgVGpsOQR7Z2URob3rZ+2LWmksjEUsFfDsYinlQ28wzltH2Woc387Uzmzf4JnY7NKijorrT7tipSc9PAiU/VztdAwzVm04qlK1UD6WeqaxwHqP3iPRF1HafGvWjaiZUpeJ8RqbbuBTwVxd5v9NWrQrBFKlc2YnPL9lKaOqbhqfJI6dxC758zZYMxvAzl+bwDO8o5IdSyOEBb4Ktb1nyf9C5HK30a4WttMPFJIaN/eT83kIG32q4ym42xrBQiWNrCH7OKAwww0tkQiCNb6r/YbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oT7bOxxZhHHwQnYc7SzVCT84ucx6fKIduB/9snF/N5c=;
 b=PVKf57Q8qg7tdXrCHeqWAsYeS2aoMfOqyBMjjHVzyvKvDiruFXZ3ZH461Xtl0JfIVSkjP2T9fx8EieASw1zGyI4Y9GWwo8AUu1uougS1N5W8JPxiuDjgyVxEtQtH9ccIU3KBI9umtww0yVCno00oker9yP5y6QHvclZVcYewv5E=
Received: from MW4PR03CA0055.namprd03.prod.outlook.com (2603:10b6:303:8e::30)
 by CY8PR12MB8410.namprd12.prod.outlook.com (2603:10b6:930:6d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 06:54:09 +0000
Received: from CO1PEPF00012E66.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::18) by MW4PR03CA0055.outlook.office365.com
 (2603:10b6:303:8e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Fri,
 23 Oct 2026 06:54:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E66.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 06:54:09 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:54:07 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 01:54:02 -0500
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
Subject: [PATCH v3 09/13] ASoC: amd: acp: fix MODULE_AUTHOR missing closing
 angle bracket
Date: Fri, 23 Oct 2026 12:20:45 +0530
Message-ID: <20261023065216.3473883-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
References: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E66:EE_|CY8PR12MB8410:EE_
X-MS-Office365-Filtering-Correlation-Id: a792910b-0215-4e8e-8f9b-08df30d2702c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|11063799006|56012099006|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	WNKrggIqitspyapCzePFlKYFmSq1IrcjNQsaKOJK0ns2uyRXuE313mSxa9000MML0leoI8ZsuoYSxkVz/qt/HmodYU0uYGUrSELEV6Zyv1jwMwCNZI5bv8etrriqC8SmWIbwXDt5AIDf3vKz69vmyQGIOkak2jRAbgoYU7iDU5lYIHMJywiXMaugNfEwgZ9K7wU0BYSEZLsa0L7HoiH95zfHc7LOdkulUIYbO8uTNKNTql3uyAoH9KkkElTecgqckkqYuReI3okvz0KgD4u9P+D85KCtnpMzTRJglC/yxG2DtcCKvrrrRQn+iQMItYPP+wQauAW8ZyfYgy1mB76PwyjsmzPw/nZKR8Vba+vR2qu3QP6gx31HFsGoPvHYlP8LFuWwXd0e44lJsEUbtDhlYX49lLJq6tTx7ytZKWg2U81lfiya+1NbmfkpWcEVPfuunGBDOn66ZXdJhz5yN/N5oLdhrMmwORiDNPYljP4cs7N5E4ZCFMJ44lZAM8EXDW7f5ZXIf3mVVqsY283LVMF1q54KMSd+Zm2gnfUj2x0bl4zOIM9xmPe+nN5Swz4tEWit1dF9hK9zrx9kDgDj6LpEVM877YkD3BjkPS5X+zE+uHReK0ewWItVM70DIeCtkE83zB/xHNvo6ouQJEBSCzeFBm4+w87IsUYAtKbp01ym1pe47Bmuj/v4DsXOb9dXuOqAMTCm/4gJX2kJdGhbk0QC+Q==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	uaiLWj0+qD5Olv7dH+gGXF3+azMmY2JbaY2A+KiGjcI6SIm7xEWswxDhfu8Uey3C70Yx6MeEaTFetKAKAbAR8bbH06v68u7fL6yXb7Mk5G4YClahXsydmLAAy73EIuyqNarkAfCalcczjX5poJ3t9BSdzI4+W9uDllbefUGWL/lx7Nf8W6gyBraJDKxlOj5X4KATDXBAgt2CwjOzHShJiQIHyEg4jMo7LDUa1cA87FdsKE3BRHGqwNDLFCH+ZHYgWKMjSrnZKE1l4TGWfyUxDJSoYJsKLFcjtB7nq28dGyy/FToiqt/BncuhlP2H/foTR82pledviwhgkG/fhKRsKHU6renaRUK7ofnH9otUUqpZFBp3M9kf6iKSaGy0Af3WlxKMYsRnFav+z6MXbaa9NQQLPn2RAj7A2L/U6JMjTNER1JpZBvX45QVGLZw3Om8k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:54:09.1778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a792910b-0215-4e8e-8f9b-08df30d2702c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF00012E66.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8410
Message-ID-Hash: YVRIZOEIUROH752S5AAL45Z6CDQ5PVCZ
X-Message-ID-Hash: YVRIZOEIUROH752S5AAL45Z6CDQ5PVCZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YVRIZOEIUROH752S5AAL45Z6CDQ5PVCZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

The MODULE_AUTHOR macro call was missing the closing '>' for the
email address angle bracket notation.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 1013f60b2818a..01e640f0ada72 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -544,7 +544,7 @@ static struct platform_driver sof_sdw_driver = {
 module_platform_driver(sof_sdw_driver);
 
 MODULE_DESCRIPTION("ASoC AMD SoundWire Generic Machine driver");
-MODULE_AUTHOR("Vijendar Mukunda <Vijendar.Mukunda@amd.com");
+MODULE_AUTHOR("Vijendar Mukunda <Vijendar.Mukunda@amd.com>");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("SND_SOC_SDW_UTILS");
 MODULE_IMPORT_NS("SND_SOC_AMD_SDW_MACH");
-- 
2.48.1

