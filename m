Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2D9FF4956
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:25:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00332601F7;
	Mon, 30 Mar 2026 09:25:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00332601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774855539;
	bh=syiJK0HEofgGNnN0C+4pIw0X0VHQOu9rY6Mo0nz4a8M=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=L1Lmy3tEpvdW/JG1O9lEiwQfz6elvv1q/dXDZPiSsggrW0FFDdgLfQCaqqqnaI0pr
	 6glt3fBbZ970JxCGNdHgmg/wF+8Zlq/eMbfzgFaxQV5YbKwuGsCIu/8MW5Gx74f6wl
	 PSMwxP3DNdfeOH4biFeAjOiX6EV6335pLN+no9NQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 11789F805F3; Mon, 30 Mar 2026 09:25:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 148F0F805E9;
	Mon, 30 Mar 2026 09:25:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E611EF8052D; Mon, 30 Mar 2026 09:24:53 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DD946F80087
	for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2026 09:24:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD946F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ZPYkJLwQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcJoNplbOZzTjGK/hKInDZYmGe3Xthcrf812GBdkuIVdQenEMKrtXLRITVufplpEuqJUykK760kmqVfv0Zxbe/MDh/Wb2rbFxYc/gpv+L7qhwJEwGWFrjiacjPInWpFqRoX4omrxSoROOU01+iNWF5s0gBjZEVX1KQrm8XGomW4MSQ+58NGin9OHEknxUJEtkz2HJBMq1hFlJ/W3kIUyuNNtYeJfzC23n4BGER9Wo4/Swfm/6q9yx28cjBCLjlcRADY1F50nmsF+yN/r8Kcb+vVNE/l/1CgVzM8LFYaWGsIhrosl9sbOKmXf4Vdun3ppTejCz5KLjZCVvhhGTvInJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0ZJglVz9cl4lBa+zBT1Ts7VhSl6XaJ8BTik2duMK+g=;
 b=aAD/vY0bsHEQW03xeC2HGzsmnUvvO5c4glbMK+jQjyfl1rFp/phfZgV8Ko5M9HMtTkORRkb+ZM7brHDDvU1TmRmZ4moWgAe44yaHVOL0gqBpCuvsobiQHagXk2g/rLpFDfIg6pkypH+jJOzAF72vuDiAUMkUmgd9dGEICdcXyL2QGlQD6zEFDopQqaGUrgY+J+oA/ofazlXQmitm3KgQUa6b5mW9KUfGLIbx+oD014yzkl+QR93XSJIYdEJ8T1y1w/ayZlLMw+M5UIWrvFsz5MCauIxPWun9f3uMkHDK8t2W8Czls+ZziM64qKtAk1HRm+yxPwOHzsBd9QGYyoENow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0ZJglVz9cl4lBa+zBT1Ts7VhSl6XaJ8BTik2duMK+g=;
 b=ZPYkJLwQtVOOnLrdOdgIjDrFkGn51sG83B+Z1bo31vNJ8VrOUSZnjqqDaDdUqqmc3QjGlO/LHVw96KanNOn50mSM5ioCdfoompqeGngAIIWkUiR90IIAJASQms8b9V5dU2kWlwB+jcbjZpKzVA2LlUmK5ZQX6yIkaJPaR9gE5AU=
Received: from BLAPR05CA0029.namprd05.prod.outlook.com (2603:10b6:208:335::10)
 by LVXPR12MB999197.namprd12.prod.outlook.com (2603:10b6:408:3dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 07:24:46 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::b5) by BLAPR05CA0029.outlook.office365.com
 (2603:10b6:208:335::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 07:24:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 07:24:45 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 02:24:42 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <tiwai@suse.com>,
	<superm1@kernel.org>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/2] ASoC: amd: acp: update dmic_num logic for acp pdm dmic
Date: Mon, 30 Mar 2026 12:50:26 +0530
Message-ID: <20260330072431.3512358-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LVXPR12MB999197:EE_
X-MS-Office365-Filtering-Correlation-Id: 2245176d-d4b1-4b69-edea-08de8e2d6b62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 
	uAXcXU7lV5PtQnQh18EiChkbcEjrBm71insUVDXpU86+aMhUYMrQ0H2O+Bqcq7T/tsVnvrduJZz2lntJ7q6DRqPeoIYp+M5A8yuroQ5j5PGQuu/r37HPicPD/WrdgDPwJ4TwYpLT2vAj7aRlaY3JiuzWh6EO2VBaYtnUwD0SBmBe0RSI5QBhRSI5Sq9jSJeB/oz6DrPlGu7Cjt+ry0i1706nKv3sQPQipa5UIFZmrgLq9/d9LAKl1Y18YZ9QI9sAehOwj/yH65maDHrW8J+XbN4+1pEL1t8gyCj2JeJX6FFlJRu0Q60d6WqfdS2Mx1uqbiwQFwV6YTjTlpBcooo+toOzCt+ZRl0jPnSTrql48ennCuqBN+w5NwXQAfkLl6hncPsXqzaX+jX4a+jrGa9nAXWmJTeidnn8wHtkHQI6c/P4ioLmGbmRmc4hqL9rRM3Izei6JnkKTvwlHTEHUuQo3LoekV5xayhcZMSFLGDgythmcB8e9aKMotKvEYQuV4uIoYD8MTwZLh8DSo6A1GoEXalT2E+9gjrWMAAoJ5mX0SyibWrRb4SPCf9DuLASpaYdLmqkd+EUGM7a+hJRwlxRm6H2doDMiye/uSZqrSby7yYwvTJoxgi2SGSyXyKetQlOBDYbBthjTsyOuht2fr1VvMjztgRqu+aw5bzIGqDO/i4Fnmy82nD3/B0QHnB+/k2pyS+sGwibUftJw2GhblAPyNGJCqGznXoT9feUAx/cXtRgn+gk1cE8ujp8t8dZwl783H5FowWXdS/Yad6RuF0dBA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	YRyqiMZawgmUrtmWlDVF4Ym/iaWX0qbq4V7p9XED/QimA8vKg7/lUFwm5fqu8ZmZ346lXGtlCoXEiDbUg8oWvObQxeEI68ZJ/mdOmN73YYodQx5WLwozriP+z86WNwVFtiWqfMQytzUL7qRgzutmcWe2LF4qDEtgDWn+jwyDGS9FVwnlIBrSL5z1liaxVi39WFVPFYMypS2opMWVhcdU/Hp0nfl71j81h88DRcEiQeO9soItolL1PWpHc1bMKsIyMyeuiKM3WqADRxuheZvKGKVwbQhWljU/tQwwofwS8t/0oSASNFYDoEpb+EvLUVEYMr+n8QqvHnUvyFSQqY9oTjZz6MwNlypNV9gm35MRvcVLusrkPbKK99CTNzCH1GCXlEBqec/tEKLlfwtcMJvvk2jj8CpIzM75SkkJm7ybxZ3pcIt9e6mgjT34wyhOXNvA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 07:24:45.9063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2245176d-d4b1-4b69-edea-08de8e2d6b62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999197
Message-ID-Hash: I5N2L5YQSUAMNSQ6C3ZOSJI2JEVK74TR
X-Message-ID-Hash: I5N2L5YQSUAMNSQ6C3ZOSJI2JEVK74TR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I5N2L5YQSUAMNSQ6C3ZOSJI2JEVK74TR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series updates the dmic_num logic for acp pdm dmic and
renames the dmic component name in acp soundwire legacy machine driver.

Vijendar Mukunda (2):
  ASoC: amd: acp: update dmic_num logic for acp pdm dmic
  ASoC: amd: acp-sdw-legacy: rename the dmic component name

 sound/soc/amd/acp/acp-sdw-legacy-mach.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.48.1

