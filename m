Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91104D730A9
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Apr 2026 06:36:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 97284601FD;
	Fri,  3 Apr 2026 08:35:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 97284601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775198163;
	bh=27aSojsNMDXfm37+dVmOnPD6jdmvYbz3flNtyuLYY60=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=LLZ66cXtbVCZQVXHH258C9xXHR7eLfTE+7Wmnay2BBVCedJt1Maj31P2gb3ye7XmI
	 Tqnv4aTXrSzgO5WGzYstwEWngOYibhVPhULiGay7KvahUN5s8bzmnYC6SduS3IOWWx
	 2pcDXXGrQZQ0LlprNs2Vf/Es3C6abE/zN53GUcx4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 734ACF805F5; Fri,  3 Apr 2026 08:35:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CB18DF805ED;
	Fri,  3 Apr 2026 08:35:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 51089F80589; Fri,  3 Apr 2026 08:35:18 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7FFBF800EE
	for <alsa-devel@alsa-project.org>; Fri,  3 Apr 2026 08:35:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7FFBF800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=A9i2F7Gi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ne1ntfNM9DU3YRCay6fJHHlHKsy5fstFf1hvfTqPC0uDerOEMQArjB85hhJLqJH0iJA3DHDGBb4fO1XUL/2Wx3VD1OO6vmjv8BCFe1TRe6NqpBJ5BSeVrEKifXyOn9mCUk4AwrKrfkynkAjZvNKM3gOr9Imaqg2l33PyJ08C0hjlW91iKxL1GHQ2Nm18BstkreLwYoYgdIMPRPGNtO1od4gruP+WgcuJLaWxcloalJ2AMXkpN8MQIHAy3tQ584K0FltlKgYTqkxBD+6g+AY7L2z7wM2YYVaixcS+GWDdL/fSH8Cshj9j7cwSbMGyMT6YTmPYN/Tzhl1WlJI6eVFybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT9C8e/08UzgwAleYntXVcmFMwUk879D17EfBBFACfA=;
 b=lGQ/6Vm7VWjTp2tkRpRhQSbnIHqFz8pJ5B2J4yaMmkI3qO4H86vES3PbVaZnHw+K0aq/MNqPCcCWVCKwEGCrwoLjcAngEaa48JFUdaO5CG1r/G4dbv9zTZHf1ac5wZ8n0Yh0b2DgtFAXEt6LRxNGvkTPkhFI3ZPZyY1EkmJZ9crEzr4/XksmbZTFGBlhc1BLSbujLh3B6B5MR86P22kdYx7EnB1u8ITSpweTQUl26rbic5HOZpbZp1lD9d+xyS4E2IuIstySR5bnKWo/OJT13KKcxPrF4QgebbdNfXxUNZnTIyBInr9kRgXgEZj8erKBWlLPfWIJ9hOu8JKMFKIzGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT9C8e/08UzgwAleYntXVcmFMwUk879D17EfBBFACfA=;
 b=A9i2F7GiiizrpNiP80Xlu67mNNraqaiW3t0ssYZ6MayoZ0/F/Yp5pbrwKr2DEynpG8YYNReRxCJ0uFivqVv/zsFP0eTsckoQojvAvbFC9lnsYoOjC42/XzSoRKLhNE622HXxf5jS1RbrEAw0sZd9D3yF/yNIZ1vbBQ6857r+kdU=
Received: from CH0PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:76::29)
 by CH2PR12MB9543.namprd12.prod.outlook.com (2603:10b6:610:27f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 3 Apr
 2026 06:35:07 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::28) by CH0PR04CA0024.outlook.office365.com
 (2603:10b6:610:76::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Fri,
 3 Apr 2026 06:35:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Fri, 3 Apr 2026 06:35:07 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 3 Apr
 2026 01:35:03 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <superm1@kernel.org>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: acp-sdw-legacy: remove unnecessary condition check
Date: Fri, 3 Apr 2026 12:04:25 +0530
Message-ID: <20260403063452.159800-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CH2PR12MB9543:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ef8845f-720a-4b8b-3d42-08de914b25a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	nLHf5WR7Yj5oAUWf4weMasHlLZ9z6Xv/Rk1QbuT/R+P2BicmB5OhPXx1PHhwAk3rSxwb4g/G8BwHgIYKRbyaNZUevK/eiG9Rof4jPXb8a62Gom79pRLJVOyVigFhjVsBFN+sk+GV6YPYe+kN2Pb4ZiMFUQF3NF0CuueNiLGkarNZXtwxi04OoYa3AFQFbRUlNlpwFO4AHdNuNmWuMgL9IiQME6PMYwJw7U5jFKYIwJUuvK/DFiVf8J/glVRc1RHvT8DuzCS89LEfbrir574HyK60RF5YdXtyYJf+xYtSXRF/FdJKkrk6OpOyutWcxOTlfmwbfmMdriwr0DiEuHmCiO5nl8Lx4z57xe39lg+A+eLGx4Eta4cF0wYMemkFkJzIhoeUDaidxB4rkC3CYflWN6QhcXMWvNtZCz2BQQamJdJxzWfOgrmr7H/6+/WnjCHpJ2B2O8j+YmlnePjJ94w/C0Cxij2YqtUlkYsNmTYXvcRhedfmYXRPnPsR0s4GWtIJPL9yZe3cZys/sdPAQ/a4cFuQ9+zcKZ4yS8DxT4oioq1NUbAXxRCntgFP2BHbOnrhgnWpubwNd6oL5m+bI35XbIp1zDJk10Z+eCN03USfYw77W2LalmwpxQhtr/VbT7Hv+4gy4JLmQlLOK/Rp3gPe381nhqrhE/nW/OUcf+vmv0AFvWdvwWzOjMqAp0mRk090GIXteV2CtdkL61c/plApWrTIOJq7WaqOvgZCzwVQT48PZjudKUd+uroBP8P0c/g/39kn76n5yLu3raF95ywDrQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	CKDQRv/1ONpHb1hBsdLdEuJViN9nJFxLxa6sQfEaYQ+YsBIHwd5eJzA7J/zmX+jJgl2+Bitkz4+4f8HF/P+LTDqc+rLpRzqBpkQzRjGs3Xl69kn7jT5q023dcC4Mp1Gq0nLXPqUrNxumqFH4rztDKgRsYyD55/dklyAYezm/VTqrXfb5PAe6z+X+tLAQrM0gNENuDs+RZwRSYKh8zCtRMwuisbQhksadgDykD4yCGcntflQ4raqnLY6hbb5RKFMXzAaKdid89QNYZN/mck9IbxCdsB1Z+U+8M0ctmsiZAWOH6KNhyLCqXMr2xPmr/03VBVL+cyXvTrEFnjpuzHL4kO/iIbHrKoKMgEYUrlv5QmNTtJZ8nxeD5QTUlbRJqFXLE8Dvkl1DEltJGVMv7bCtpP0KXr/CwIQZgrZsXV0b7AMjmipV/aZmElZlzlv953aX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 06:35:07.3177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8ef8845f-720a-4b8b-3d42-08de914b25a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9543
Message-ID-Hash: KEQ45AJUAGQ5A62FVSK5I3OKF43EH3IA
X-Message-ID-Hash: KEQ45AJUAGQ5A62FVSK5I3OKF43EH3IA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KEQ45AJUAGQ5A62FVSK5I3OKF43EH3IA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Currently there is no mechanism to read dmic_num in mach_params
structure. In this scenario mach_params->dmic_num check always
returns 0.
Remove unnecessary condition check for mach_params->dmic_num.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-legacy-mach.c b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
index 05484c72f9a8..24e99d8d36ab 100644
--- a/sound/soc/amd/acp/acp-sdw-legacy-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-legacy-mach.c
@@ -378,10 +378,8 @@ static int create_dmic_dailinks(struct snd_soc_card *card,
 static int soc_card_dai_links_create(struct snd_soc_card *card)
 {
 	struct device *dev = card->dev;
-	struct snd_soc_acpi_mach *mach = dev_get_platdata(card->dev);
 	int sdw_be_num = 0, dmic_num = 0;
 	struct asoc_sdw_mc_private *ctx = snd_soc_card_get_drvdata(card);
-	struct snd_soc_acpi_mach_params *mach_params = &mach->mach_params;
 	struct snd_soc_aux_dev *soc_aux;
 	struct snd_soc_codec_conf *codec_conf;
 	struct snd_soc_dai_link *dai_links;
@@ -424,7 +422,7 @@ static int soc_card_dai_links_create(struct snd_soc_card *card)
 	sdw_be_num = ret;
 
 	/* enable dmic */
-	if (soc_sdw_quirk & ASOC_SDW_ACP_DMIC || mach_params->dmic_num)
+	if (soc_sdw_quirk & ASOC_SDW_ACP_DMIC)
 		dmic_num = 1;
 
 	dev_dbg(dev, "sdw %d, dmic %d", sdw_be_num, dmic_num);
-- 
2.45.2

