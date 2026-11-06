Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78F7606A32F
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=jrdQLsEc;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dxnogW7I
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B38B8601E1;
	Fri,  6 Nov 2026 12:48:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B38B8601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793965705;
	bh=6bwZVmt3fDO44Umy3vTJZmXC/Jf67lpmMKGVhjjTd6M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=jrdQLsEchdRaqEeGyje3Kldbp3dGsnWA2MOFjOU+LdzByer26HvUkqBWM4TTU4RMx
	 kfE6fqGsI7n6ZIsQY1CAf1mXm6famqRf+trKM4Cj3vv6tho7hAgtLKLSJK5Mh2ZajN
	 gIoQIq8YT3NTk0wF8F+EzFIieT97kCt8VFy0+cJw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 469DDF805FD; Fri,  6 Nov 2026 12:47:51 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59B36F805F9;
	Fri,  6 Nov 2026 12:47:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1D06FF80510; Fri,  6 Nov 2026 12:47:44 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.14
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793965660;
	b=DHJoH3lL3x76BINO5rM86/GeBfbGz3bGDUj01afrFPdCVH/0DbN75co68UTkKxHdWkHb
	 bGuIN0iTV6fWF86CHMgIXUhQRStLkdj0C11yi2B3HO3VPkWQrHERh8OipA3hqQouoL9nJ
	 2nqVqd+IjUqEWOCT1OIEgVWL69zNqkwYsl8H9i/1Thu0GyQ+8N1ojQd4kph+1xXTcMVa6
	 NWnn8gOt+DmgTKVGQUWEtUEBfdEKZDPcFPPzP6CKBfFB/8Hi34E5OovS/NRqkEoEl7w6x
	 KWPKqB2lDCLqRI1HlLEBeParcinMZuzAcoMbNi6GNi/GtFtMyjblBu8LEjRwfo5lF1g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793965660;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6bwZVmt3fDO44Umy3vTJZmXC/Jf67lpmMKGVhjjTd6M=;
	b=X3X9J/hZruXcr+biidxsdvaZOz7g9NFVbIkryT8pY6sqKHvc37frAdTg3PEtE/iWICgP
	 Xq4cDB6E9cCpBTF6FA/HWuYeT6O5rPpBELJqcjh27Yp3LgBXQwlB6bS8ouk9Baj57E0qw
	 fuE4UfTkWuhVemmXkumo5NTERyCGyMwokjG3vv6/BnTo8yevjk6fmvf1YuWAdX+BK9Fq+
	 ligtoQGo/tHrz6Afowg9rX2+eTxNpOu7evn2MdvTCVT4i70jeldlHWVyn/MkfKhbAR5/t
	 IpK73mWDY9iqvVe2cDz53eiIB9hnSxqyoA58aayyaJ9h88ZopW8L528wtsZe0Rb6a7A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dxnogW7I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.14
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012014.outbound.protection.outlook.com [52.101.43.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D6E92F80124
	for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2026 12:47:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6E92F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dxnogW7I
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2hkrd7t65t+CwqLU+VO0H7RTCPRkhWYUI3B+vEI8MeJG5D8XfqTTmh1WhgCmEMnx9eybrO151BlFAzLV0mBwL7qM3UfAZzgf0Xe6ty3TdWwsjrNpWVh/L1J2XZk7/M7Ty98ZsdvtrzmFaLeOQR7CxK/o9KZWzWEIibtuyJnpwDv1zrSSi3Uf26u5ohUo4RAJSLb6vx31oHCMqbgBBEjhJ9gEg7Ndg1iAYmSOrSQXiQOv7B4U4ak7xpYhH+vyI5/vG12cbrnEDvdAiI6jz9DNKzR9rTDzM4mk/aQ+HPbtRweV5pNVKYFHLsDTSwrSHzI3XQKDYAeQcw4domf2xvhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7+dOZS5NbqctMwj+ML9mmIONS1DqNelMRfbgICKaTo=;
 b=TVKrxbjHCPKIWNkk9cuEeBGwJb929/TGLQ9iFSGQGwp5u5U3b4Nt+VAl+c30/2TXk9scCNQz2jRaB8VosEdevaDfZ9mtHVaDa1IamkPKfPybYkvF24mKO4pIflBu/eOZ0La72yxpetytbXQFy9Kk1geONLN8boVI1zMiuJXn3hidFkbGe7e7tGpIuJimnSYa2Z8cYDFlbWHsak+z9RaLGNU1IvIvjKkSf63PwXcXHWqLUVlZHluBqXsi0m6kQn7HbqD6U70u8jxk/2ClUKuh3m/skliqU2JG2v+/iZw2IcKq7qpyG13FaLQh8t9sGbd37kq0Uw1v/uba9gB4aERAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7+dOZS5NbqctMwj+ML9mmIONS1DqNelMRfbgICKaTo=;
 b=dxnogW7I+1Qx7aVfsYD2BCFyeKGXIyjIm+sVRIWoL5665XJuPsxAT0I5DecWHpOIAYzh6nBBNJnFEW4vtP4fGeEjBJD2U67GUGFfX6Cvb/KrJXxTC53OL1sMUDUUHTf/EaYw5qZEXhrrLraxjyakAM4y9iz3CXYBdRzXTkfEzbM=
Received: from CH0PR13CA0025.namprd13.prod.outlook.com (2603:10b6:610:b1::30)
 by LY0PR12MB991423.namprd12.prod.outlook.com (2603:10b6:404:21e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:47:32 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::1e) by CH0PR13CA0025.outlook.office365.com
 (2603:10b6:610:b1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Fri, 6
 Nov 2026 11:47:32 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:47:32 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 05:47:30 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 05:47:30 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 6 Nov 2026 05:47:21 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <pierre-louis.bossart@linux.dev>, <vijendar.mukunda@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<Syed.SabaKareem@amd.com>, <alsa-devel@alsa-project.org>,
	<lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 0/2] ASoC: amd: acp: supplement patches for ACP7.B/7.F
 SoundWire machine driver series
Date: Fri, 6 Nov 2026 17:16:20 +0530
Message-ID: <20261106114622.219126-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
References: <20261030094714.1123396-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|LY0PR12MB991423:EE_
X-MS-Office365-Filtering-Correlation-Id: 33007868-655c-4da1-94ba-08df3bfbbe24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	ucJaVV7VHEnW3JVZZbcr4blGz2nwCiSg41giOnSu9op+ABl7iOuZTn7pcsTn5ZOjdg8IutfFi22E6ogU2Y18FOw5j60jFqJUx1EfI51GZ0penUZeHEvWuYaQYJ4U4TxKELXqA0soqoH8MUCbmuTXsO4Mx+qkX1oG/1cBZTbBdbbZjan3oNqxUkTkMmBe51GNTGGBgFnCC7zKfH2d5lgyH0kvMXmDQQdd+p/ezadR0lvNIp/0sF+xWe2erlH5PKRLHfU9lZsFT0i/MWPCbCo3ZxCr9igX2fEvID6ChfExpaDQXLft+fNcqDPW42CU3Pu3rfKRIpQOHPF65ikWQaHnepf6i4VfpIP+bItvtqexu/Z8uhVLTIZsg/9d5Jizyus/WwLW5ga5uMmgSw2t7ail4H8G1Xzf+FrKQYT1K2rmYkVRwPTPfioEKUzmTJBtWtyWFWy2WwI7CWvu1P/eJ3SOh1Kt2RexcyKl2CM4vXYGTcEaL+WLaabafHugrvpek0FXv/Lpa1X720XlvU5TgZuVWMJVJQiQtcMBm0PZeodOiIjVkz9LIodmw+LOx07N2AE/1uPSxJ00P6bb/up45xwa6MBmBysvJAoDjah5lX7DJCYGtQKmnI0YmqnifbYPS6eQa8RtDgapBnXVhsXdFS57ZQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	as2mRYIPPW0pL2SGWPygTf5uLXaroGOnpStVZq8478Kn6nT8aws3I4Ta6F4Lvm2zwRjLSw4qo8RQbc3VP6DwezuFOGBQltzjkfl2r9HzTPvdw6MhrIvIRCzMgI61lex82GPqnx7j8AzsMdUwbnM0XD/heopichLlfHChMhCUZwpVOBzAonB0JgwZY6bOhBnDi+cjIVpo+fYfISOnRDSGPLHUY+9zk99rdsCT/3pZ7klxgL0qXMCE9TekvHByQyBMqJ3rJDT9Cp51u41z539FX5Fr2Gkhh2rt0StkEgwI57KZP4MVbGFMX2/khgH+TqqCf/AzzBiMEhCi8KtSjLdNYN5eDfh0ZfFRmmIbbAllbdU4WzrnzomMZcty8hu7fUykrh1ETYUrWtbrIix7notjfc0mVwHjB+5s9RmZtEzGvXSQDkNd0lOz9b+Slwo4XD9k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:47:32.2247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 33007868-655c-4da1-94ba-08df3bfbbe24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB991423
Message-ID-Hash: XCTGT56XHVDYFXE7IRFJR26JWEZEPKQC
X-Message-ID-Hash: XCTGT56XHVDYFXE7IRFJR26JWEZEPKQC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XCTGT56XHVDYFXE7IRFJR26JWEZEPKQC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

These two patches address nit-picks raised in review of the ACP7.B/7.F
SoundWire machine driver series posted at:

  https://lore.kernel.org/all/20261030094714.1123396-1-Vijendar.Mukunda@amd.com/

Patch 1 renames three static adr_device arrays in amd-acp7x-acpi-match.c
to reflect their endpoint set rather than their structural role, making the
distinction between jack+dmic (combo with RT1320) and jack+amp+dmic
(standalone) self-explanatory.

Patch 2 adds a block comment above the ASOC_SDW_ACP_DMIC and
ASOC_SDW_ACP_DMIC1 quirk bit definitions to document the dual-PDM-
controller hardware model of ACP7.B/7.F, and annotates each bit with its
role.  ASOC_SDW_ACP_DMIC is a generic DMIC-enable flag on all ACP
platforms; on ACP7.B/7.F it additionally identifies the PDM0 controller.
ASOC_SDW_ACP_DMIC1 is ACP7.B/7.F-specific for PDM1. BIOS wires exactly
one controller per platform.

Vijendar Mukunda (2):
  ASoC: amd: acp: fix adr_device naming in ACP7.x ACPI match table
  ASoC: amd: acp: document PDM controller topology for ACP7.B/7.F

 sound/soc/amd/acp/amd-acp7x-acpi-match.c | 22 +++++++++++-----------
 sound/soc/amd/acp/soc_amd_sdw_common.h   | 11 +++++++++--
 2 files changed, 20 insertions(+), 13 deletions(-)

-- 
2.53.0

