Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50969CC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:11:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9D208601F8;
	Wed, 14 Oct 2026 12:10:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9D208601F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791972661;
	bh=N8/qLIT9pUcIeidsDH1vXjG1txF+hsH3Yim4Z/qsrng=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mmoxHLVgq4abN53jOxM+j5nQOBm0vlvOXeajPa8AmF2j3nRR90Kncn32bkB15WSFZ
	 6mEJRytxOkkIsefUmvrUPCqDwrLNu+8QwyXd/zo54qbSKYmvJkmg+Ooh97zFKvYz8O
	 cn506WxG9dlwFyqmvXZ5XYwYvIIyC6OYJ100oG+s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29CC7F80605; Wed, 14 Oct 2026 12:10:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A3356F805F5;
	Wed, 14 Oct 2026 12:10:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55F8EF80495; Wed, 14 Oct 2026 12:10:16 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.29
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791972614;
	b=f5raYmVLg3nj0sXQDp195yOnps7Ez+9HnTNXEH5JW3erJwuK+BWyY68+PQwKmDmQb6lv
	 13AINbOz8lOn6FdytRZ6s3GKjIaJL1r80ZYvuu4wEgbxqq5JmpCTli14wK337FAoFtPu+
	 GC7zEqbMHsYvHnigedMVarlBorrrinRp4CkTeF5sjt5xBTHdH3AUYDq8KMaCTHiFegzDi
	 MUeIINHcfU/bUszkrHE0fGWxpYQFgMa47pi9oZLwdrfR7PvWvkqb3OJmspuhCVAw/TB9x
	 v8oSMnd5iMaQfmpz+BsDm3wPtKH04tEuHFh0460lXKoDzNFazeUYNoyrn91HFLkcXng==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791972614;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=N8/qLIT9pUcIeidsDH1vXjG1txF+hsH3Yim4Z/qsrng=;
	b=mjXBA80EIBpWsESItFj9hDpmIRIfwKCNgTw8VhpiLVmc3+fzOloYN0q39Noh0PZU06Tg
	 ybUin6tn3FdfP5q86jZGlRQb5oncpNBPDfa1z8PDP19yKq3RPTZOyWTA20MNqlTVcKuF8
	 +fGlHFUxANQbMSOuN/yHxvIs1R6Dhc/6z0qAWd1e0dFBKCg4VNMK7hSOEVA02YCIVie9/
	 ujnQ3Bh7FmMQdv2jBx5YnS2o+WVaWV4g38pQhbVzM5NhtPRU5+p7ga7HRWUHJKCCQX+da
	 HpCBGZ5BCCvGTUXau/+J5vUubvSiMbkk+ZfoG02ob43/ciQJiAKZqizk35279OgdE0A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dj0Ut2Ng;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.29
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010029.outbound.protection.outlook.com
 [40.93.198.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EEF00F80038;
	Wed, 14 Oct 2026 12:10:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EEF00F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=dj0Ut2Ng
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez7r/GS7NnTvA9Ri4jsHIwqHx9hfMH7KsTYdR2U8vJu7U7Jy5iylOujMZLjgF6LBwRBmBtLDujGNuPsGnEOfFK9MyEnozSXUEvUDF1Itgw3PjYHXCfZJFKLS3pxF95aZxflGnmRL9vPqJFUNFsNZA0LsF2zbvBvC+6VjPwioUHjPt7u4W85DWdY/qoDFOTeBrlpELla4UmU4awQ5Hs/ge4QYt7ZMu6xhu7F2kFJInVklg1FRXbBwyMu/Mmhq2bqaVjGVjgGneKyLie55ElXmve7Jm6W3UoOpzBpEIZF+uEVsqd6z4MT5Cg72bqTnxvNyqWC/0OlR4xuaMG/AaaznkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rxR6TT3XuoJcJSL0T1aZxIv/O3lGjOIDnUdhadeSWvk=;
 b=UovAYwcWTq7Si/c0XmXAsMJ2pEzlYyXJZmDbLbHE2tyNtLEOp56hOqwDbU+9Jp+gCrkext/O0IoKMeBdp7SQXNzGtAMxZOw9jOFj49wIC31cl5BMhU6CxzIGuR0CtW9d/7o4c0lZZ5+F6Zjvk/YY+IA4efOwPuKFo3ME5ci35e34iX2HW40lriwKIGKsxe+1ZLg7T/MNxjjUTPtu4BUav/UQcIqfK4QeRkjBau8QIerQ6QJPoqlQr3OQwgFJlmXZ1mrw1kXAaGk/c0PfinD5OlFBaDn8/qos02NZBBvshIHEh+HIkBtK2tDcmdOzwo2TP91v4tQByUy2Tmy1sm659Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rxR6TT3XuoJcJSL0T1aZxIv/O3lGjOIDnUdhadeSWvk=;
 b=dj0Ut2NgM04TT7zbvR/pvTgCu0mUkigl+LzcPvyI3gLNAMrhlkdYHddj5xhK+bmRzR5F9jYEuYhLeW/dfLlULVUcsY9uRmubTJznzcPC265bkQdg8OZ6cmsDtIsnbHhnW6JbbFDxGxlinAoY0HVLXRIsMHCUZKxzWq/cR9fOP+I=
Received: from BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27)
 by PH8PR12MB6985.namprd12.prod.outlook.com (2603:10b6:510:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Wed, 14 Oct
 2026 10:10:02 +0000
Received: from BN3PEPF00022BBE.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::7d) by BL1PR13CA0382.outlook.office365.com
 (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed,
 14 Oct 2026 10:10:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BBE.mail.protection.outlook.com (10.167.248.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:10:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:09:55 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:09:51 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH v2 00/10] ASoC: SOF/amd: ACP7.B support and ASP carveout
 firmware loading
Date: Wed, 14 Oct 2026 15:29:08 +0530
Message-ID: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BBE:EE_|PH8PR12MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 42780639-b306-47ad-6e54-08df29db4f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|56012099006|10067099003|261009223027099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	eofDJWQi4crOTiSw0qTRNS13E3J/glp4TWdNLWHWToHZKQbRaxy5IPtKa/mbAjFf/7n0u55qExL+pswKg3MdjfIxrUL6vUYg0gLwtqtYbkGLjv6qN9T7URq+nrh6ilhZQfdUxSdduAKtxELuVxvnCdZRMnll7n8/x62n644k7lPcCVlVlXL6uQErSzXWXoTfiaHX7Lozt1/DIOdR4PvL3iP9LYupJMUc/jDF+zbNfhsF8N8vjYaA+ZtnBGJ+Bgy40gO7hIZW5kxl5z4htHJx6EbCHpoYhq1pWBpWfjXEJbQTes4wDbpOX6hYnU430wZt/QF//jnxafgnPu+qEMwQtvplQkpi8yvR2E6ORJXu+3DT1SKawUKHxmcnTQkJBOomq1FKRP7PK/O/heO1oL6V1fLu2wn7AoB/Ha48AVzCqdvZolQgUpIZtqNxmDSl0wC7Q+S3GYGUG8uvMEuhi9k+K3JuhQxiiJM0knLW7FEIwMQQQCSGsNLpae1DxyNrq8TK9aaEr2BA6NLqOibln6e5H7/aO6qqrgfQQfj9ecna3vOTIpzYdYiDuUg4loWgx192lvX5w0ofMuHvZ8GR8mm7fDk5vcKrGWnX8rkFI5XD3PNk2nlAZHETkxEBco3Jnj9YpI/8K6NZgI9WQW319myIbRcGwy+rFkgqXh//r1Uo/LscPAwnTNHXF/rM/ox5hzTQm1w6xkCwhxhEOAnAHODl0w==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(56012099006)(10067099003)(261009223027099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	7xUMgd0C6mPWqxkj694HfK5cGRuPy4MIRhv7jHt36Vy+Tvmp8/syLmSozztGi/vjiYBfvrcsf1v0C9xyJ123pJNnu7rqTVc310gmfT0horUzrZIbhgw8Hs81K0JUEpJZonK0ar4XWQ9HlD+GmIltxFAcLnkr3u0KwV4FuiBXor8AEta/iP/ME3W3j34BppQMoi+/rMs8/GFzd/KnLF/I1QJyPJx3AuVVQRte/OkbWWoP+iAUydIVQRBTKGRPFR4Ik50sHWUAwZJidQk2gtsPp9NfpZB47C9mepWk8CUigqO/AUF2eWm/j+anK4HieQ8vXkNHS6RYN8aOkxlvuUCIPsrNNpXm12RO4W/MleygnCqZ1aArH6Fnn+0g/RDnutwKK/K00hySs+Mo+uVJ59MZtdqc/jJM1PQNuB+9WVlvebES/eUWMInOPEnqcsxoMnSk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:10:01.9282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 42780639-b306-47ad-6e54-08df29db4f95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN3PEPF00022BBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6985
Message-ID-Hash: HO5N34CIXNFFHR4J25ROQA5SV5WP22EP
X-Message-ID-Hash: HO5N34CIXNFFHR4J25ROQA5SV5WP22EP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HO5N34CIXNFFHR4J25ROQA5SV5WP22EP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series adds ACP7.B platform support to the AMD SOF driver stack
and implements the ASP-authenticated firmware load path required by
both ACP7.B and ACP7.F.

Patches 1-2 are preparatory renames and restructuring. The existing
acp7x machine table and chip descriptor are renamed to acp7f to
accurately reflect the hardware they target (ACP7.F). The probe
callback is restructured to select the per-revision descriptor via a
dedicated static pci_device_id entry rather than encoding it in
driver_data of the shared ID table.

Patches 3-4 add ACP7.B hardware support. Patch 3 adds the ACP7.B I2S
machine table with its driver name, firmware image, and topology file.
Patch 4 adds the acp7b chip descriptor and extends acp7x_pci_probe()
to select it for ACP7B_PCI_ID revisions alongside the existing
acp7f_desc path.

Patch 5 propagates the PCI subsystem Vendor and Device IDs from the
AMD SOF machine driver into mach_params, enabling downstream SDW
machine drivers to use them as an SSID.

Patch 6 is a cleanup: register variable declarations in the ACP7.x
SDW wake and PME handlers are consolidated to u32.

Patches 7-9 address PDM controller selection for ACP7.B/7.F. Patch 7
introduces acp-mach-common.h as a minimal shared header for types used
across all AMD ACP machine driver variants (I2S, SoundWire, and SOF),
and moves struct amd_pdm_pdata there from the SoundWire-specific
soc_amd_sdw_common.h. Patch 8 moves the ACP7X_PDM_DMIC0/1 constants
to acp-mach-common.h so there is a single shared location for all PDM
types and values, removing the duplicate definition from
sound/soc/sof/amd/acp.h. Patch 9 fixes a gap in the SDW machine select
path where pdm_sel was not propagated to the machine driver, preventing
acp-sdw-sof-mach.c from configuring the correct DMIC DAI link on
ACP7.B/7.F platforms.

Patch 10 implements the two-stage ASP carveout firmware load path for
ACP7.B and ACP7.F. At probe time the driver queries ASP for the
physical base address and ATU group of a pre-allocated 32 MB MALL
carveout region; probe fails immediately if ASP does not support
carveout. At load time the signed firmware image is sent to ASP via
the MPASP mailbox VALIDATE_IMAGE command. ASP authenticates the image
and deposits the raw binary into the carveout; the driver then
SHA-DMAs from the carveout into DSP IRAM. On D3->D0 resume the
carveout content is preserved, so the ASP authentication step is
skipped and the driver restores directly from the saved carveout
address.

Changes in v2:
  - Add patch 8: move ACP7X_PDM_DMIC0/1 to acp-mach-common.h as the
    canonical single definition, removing the duplicate from
    sound/soc/sof/amd/acp.h
  - Fix patch 10 (v1 patch 9): remove trailing blank line at EOF in
    sound/soc/sof/amd/acp_asp_mailbox.c

Vijendar Mukunda (10):
  ASoC: SOF: amd: rename acp7x machine table and descriptor to acp7f
  ASoC: SOF: amd: select descriptor per PCI revision in acp7x probe
  ASoC: amd: add I2S machine table for ACP7.B
  ASoC: SOF: amd: add ACP7.B chip descriptor and wire per-revision probe
  ASoC: SOF: amd: Propagate PCI subsystem Vendor and Device IDs
  ASoC: SOF: amd: consolidate local variable declarations
  ASoC: amd: acp: add acp-mach-common.h for shared machine driver types
  ASoC: amd: acp: move ACP7X_PDM_DMIC0/1 to acp-mach-common.h
  ASoC: SOF: amd: propagate pdm_sel to SDW machine driver via
    mach->pdata
  ASoC: SOF: amd: add ASP carveout firmware loading for ACP7.B/7.F

 sound/soc/amd/acp-config.c             |  22 +-
 sound/soc/amd/acp/acp-mach-common.h    |  29 ++
 sound/soc/amd/acp/soc_amd_sdw_common.h |  14 +-
 sound/soc/amd/mach-config.h            |   3 +-
 sound/soc/sof/amd/Makefile             |   2 +-
 sound/soc/sof/amd/acp-common.c         |  17 +
 sound/soc/sof/amd/acp-dsp-offset.h     |  58 +++
 sound/soc/sof/amd/acp-loader.c         |  64 +++
 sound/soc/sof/amd/acp-stream.c         |   9 -
 sound/soc/sof/amd/acp.c                |  91 +++-
 sound/soc/sof/amd/acp.h                | 110 ++++-
 sound/soc/sof/amd/acp7x.c              |  11 +-
 sound/soc/sof/amd/acp_asp_mailbox.c    | 558 +++++++++++++++++++++++++
 sound/soc/sof/amd/pci-acp7x.c          |  80 +++-
 14 files changed, 1008 insertions(+), 60 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp-mach-common.h
 create mode 100644 sound/soc/sof/amd/acp_asp_mailbox.c

-- 
2.48.1
