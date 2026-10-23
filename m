Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11823606A31A
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Nuu1vBN4;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UkmAsb7W
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1267F601EA;
	Fri, 23 Oct 2026 08:54:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1267F601EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792738508;
	bh=wg9/rp50DCJe3iVfV+57HKzOjy121x2uI6GRQhN9wXw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Nuu1vBN4l3yFgbgCI+HCpVQiGB+qvyLxO+Acc8LcZ5u7h/K7zmFazRsZbQlcI/fwV
	 HJVB3l74jssO4OCIY+IH1nikXGGG2h8LhhwckGDnlu20ceY9PatrjBItHYlJ2NHQ9d
	 g5Ah/aEZ6Cm0jQ8DkQVlHpK5ODC25N2F2m1w2DT0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7D870F80642; Fri, 23 Oct 2026 08:54:20 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D511F80651;
	Fri, 23 Oct 2026 08:54:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7B7D1F80100; Fri, 23 Oct 2026 08:54:08 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C0D04F80100;
	Fri, 23 Oct 2026 08:54:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C0D04F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=UkmAsb7W
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyLSzvfR8k+tR12VJdPPLz3CtVV4XNlvLuoCHaerStpXTAeRe/rlqOUaiAZ7zjc9gKrnO/yysLwf58AnkW2p7slkNlUF4agwEyov1N+tr8nBE5xuCLQoNA+ws5ABB0oStayfhT4sv04/KSOwjri4qJhwmMjtVF9GV4SpGSi100bsl4vWoCVPGBFn7qByyhQqg2YdhoARVtbVciJ1wnSay+cyiANqPDYzyU4xz1sbYfOxlSGMToG9IZcNBXGCgoIeksrQw5V78fTtj4CpVvAbv+iTmiWEWH00SDAjkKs5/96TCSwtadrdHffsjp1T60/7SC/5XDpL6Nd4I3io+0jMhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rm2oHs3R37U9m1HKAKqrWSD2hAO1v+w7FNAXcaZwOWc=;
 b=Ud/wF/NqR9EliCP307qmCfUeCbKd63b8oQMj2vrBwUVY/Ggiz7d9GqzfsVAvjfpsDppPwx5qLPujRnH9cjAAy1XQP1I7IObIFD5d7WOpHoFd5539c1ey6+kQVcF/x6C51cG/orNdGjNd9SMOsobcwev+PuECMx6wzwnxKQiZejZv222Qnnpx15CuKHoNQbXeZccx3zuyYhIcpr/gXer+AqC3V042D5fgXFTEdVXyx2XqA/2b+1RBQdi99JClpMIc5TjEM7ty2rTZ7vs53YcHLXKFqE0Q9DI83BMbDZmB0v6gH0fhAWVxwn0dqfMeiv2HGdVpR/K2tYYPMfUmmQwwRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rm2oHs3R37U9m1HKAKqrWSD2hAO1v+w7FNAXcaZwOWc=;
 b=UkmAsb7WKSU0lUpbgYF6qcJQk2CRZVX0twnZJq/juaO4A5Z3x4U/NfgB1feXWp28INoF1JZbIFD2tHnSLfkoyNrq+FIt4WvIA34c+kTPRpkgaFPQ29YR2M0e/b2S/XXakisVVnrf61yecmuThOQigixw9sjZyBztn1KD2PVGNjo=
Received: from BN9PR03CA0219.namprd03.prod.outlook.com (2603:10b6:408:f8::14)
 by CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 23 Oct
 2026 06:53:53 +0000
Received: from MN7PEPF0000014E.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::20) by BN9PR03CA0219.outlook.office365.com
 (2603:10b6:408:f8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Fri,
 23 Oct 2026 06:53:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014E.mail.protection.outlook.com (10.167.254.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 06:53:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:53:53 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:53:52 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 01:53:48 -0500
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
Subject: [PATCH v3 06/13] ASoC: amd: acp: move ignore_internal_dmic gate to
 DMIC enable condition
Date: Fri, 23 Oct 2026 12:20:42 +0530
Message-ID: <20261023065216.3473883-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
References: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014E:EE_|CH2PR12MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 086828aa-11cf-4907-e85e-08df30d266c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|22082099003|18002099003|261022105027099003|56012099006|11063799006|261009223027099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	iiopq+AbUObXel6UWGs/AJonxbqVB54M5c19zqevtvOjHlVm2TP7gMYWTLy3M3NOnA1cL4Tp+IWDms9qjy5WzB0zIgqoaQEuQAaXZi0v8XhXshN9Yp9szM5yVBb6+O+FjJNxCa68qQGO4fV8Ov20i2BCn0rsl6fizvEDsPiNMHQFsKPq0V+7SKfGr325xJj3cIbBWeUTf4GPCJuGKvim3/BC+A6KB5d+Q1k2H0zbmGojSQN7t9D4RlRIqtEfS8iiXkfOr6B3gvIdxyT62IQI4J+z7Qo9pz3z0Gnxe3wp9PIP84yQf5Yn4Kq002ZVf5oEfX+i2dXYYkJDxWgrlW6zgdpuBlsKu0AitcWJgyaBzaM+eXG/FFUUOExV+HAT+DjzdXv6tk3RO2eAEWT3I2voq9Y2n2bx5ZA2aMyZkIQSWkdiOpxF0/Bu2Wdmp5sJnQZlKrECVm7vR1DsQBiPmJK2ed+3fii/NDcuCujMjvk3kzfseRzC5sjopzWQ3hrolr/rPNn9Wb3CSI97tp9V37RIRhGNUm1grJpfXuw4CUMkvMETapUAYATUnv9l95iz+TP5CSEj5zNCDfGYV71mLHmmn3BVzzJpgvtg6P50W9nk5o+nMW2FJBcnDWXorvc06+bgBXC2ZAR/UxQQDBpyFgJdl/gAtzlwFYhbt0F9JmWXCdFdPefXeDerXuIM0dsumpUp8q9CdaE+ZeGdK1aWBYd7sA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(22082099003)(18002099003)(261022105027099003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	PPz1m6kdkDbXbLe1616roXoRAG7v2zzFmP1dq/GLgatdyIbuwhjHvRrGSko48LoxUumq6KDM4nYPc1C0cPCCqpBZCuVn5TIEUi5AMRhV+xCHhN+GevSVoIc6/2hEbvjhDGgW5v3QfiqgwOimVbhSMiC8gXpTbFNh40i/mILXWt4Y5a1FITkAJd4cWRiI9Fz1SgKIudha0X4yOWQru0X1hzkMr4m6zUhs0fuSi8EgLIbBXVJ+594rHaCcMLpQ/11K0V4cwWUplUPZhaEYGBsMRNa0Z8Xqiw+0Y58tDiIyb2Kvy1wiCAJ12M9difmhPZ8utaxGDmaCnrntQldz8PA0Az6ESusBFvVfgf5V1XMeDqK3ARlU+aOt9/Jgba8fP0aRASOS0cMnfEYNsUQhWBq6lhtQaps8JY240Z17TffSnD3iPUpO9hC8VD4QLC/emJen
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:53:53.4708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 086828aa-11cf-4907-e85e-08df30d266c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN7PEPF0000014E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9517
Message-ID-Hash: M3GYF3ZKNF33R3PINLMF6N456ZV6FJCU
X-Message-ID-Hash: M3GYF3ZKNF33R3PINLMF6N456ZV6FJCU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/M3GYF3ZKNF33R3PINLMF6N456ZV6FJCU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Move the ignore_internal_dmic check from inside the dmic_num > 0 block
to the DMIC enable condition itself. This eliminates the dead if/else
inside the dmic_num > 0 block - when dmic_num is set,
create_dmic_dailinks() is always called. Demote the suppression message
from dev_warn to dev_dbg since ignoring the ACP DMIC in favour of a
SoundWire DMIC codec is expected behaviour, not a warning condition.

No functional change for platforms without a SoundWire DMIC codec.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 6848b966c6eb4..5c201d0b3bef9 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -352,8 +352,12 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 
 	/* enable dmic */
 	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC || mach_params->dmic_num ||
-	    amd_ctx->pdm_sel)
-		dmic_num = 1;
+	    amd_ctx->pdm_sel) {
+		if (ctx->ignore_internal_dmic)
+			dev_dbg(dev, "ACP DMIC suppressed by SoundWire DMIC\n");
+		else
+			dmic_num = 1;
+	}
 
 	dev_dbg(dev, "sdw %d, dmic %d", sdw_be_num, dmic_num);
 
@@ -384,13 +388,9 @@ static int sof_card_dai_links_create(struct snd_soc_card *card)
 
 	/* dmic */
 	if (dmic_num > 0) {
-		if (ctx->ignore_internal_dmic) {
-			dev_warn(dev, "Ignoring ACP DMIC\n");
-		} else {
-			ret = create_dmic_dailinks(card, &dai_links, &be_id, 1);
-			if (ret)
-				return ret;
-		}
+		ret = create_dmic_dailinks(card, &dai_links, &be_id, 1);
+		if (ret)
+			return ret;
 	}
 
 	WARN_ON(codec_conf != card->codec_conf + card->num_configs);
-- 
2.48.1

