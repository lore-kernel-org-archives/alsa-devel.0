Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21F0CC6B19
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:49:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 704CD60146;
	Tue, 13 Oct 2026 17:48:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 704CD60146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791906541;
	bh=grHL63Vu4IFddOGUgJNl6TsV4fZnj/KRmwqFoTgfGV4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=AayxClVvmYHPk4cQHwuf/29D2AwkY3FjLVG2CvSe4e+HAXNi30BSLvpJ4dhFJ49+/
	 t/LCTXyMXzhWnCM1T8vlv75o/qbYHTwZ0HWvSjNf+eEQZa90IxLUvb0L55LT4o/rTl
	 RGr4eoToQw+/jtYwzk+NOzHv3ln5GyrGN1DmM+5I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46182F8061C; Tue, 13 Oct 2026 17:48:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D7F58F80622;
	Tue, 13 Oct 2026 17:48:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9C77CF80548; Tue, 13 Oct 2026 17:47:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.48
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791906478;
	b=DS4j6q/Yn7XYuV5TNvzuflZlKvwoFlRtFz0IszD31oPGtK+Z1IYVjjh8IgXarwx/17xb
	 g9MUhlQlZb20/5qG2DAjk937K/L/dW6hz8YhM1FcgWqI1oAavkXW2c1Sy/wSSnz5DpumV
	 skTZ/jUqdg4Iwji9j3R7v4Qnbzakt3PHAMWl45++4ur/A9gxYjERYe8La0VNYVK84S10Q
	 uJdyXFuEmLQXai1dJs1y0jjyRq28/1lE4u6pI4unmZibOgdc/KSlKyfjf+NQb6Jlzwktp
	 8X/4+BKhsDQ74wP2C8wykzTBWG6WuEfPL1sn18Vh/nAFA5m8GFmxT7pHdL8qBjaR0Og==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791906478;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=grHL63Vu4IFddOGUgJNl6TsV4fZnj/KRmwqFoTgfGV4=;
	b=rgWoz6qWcTMj3n3zoWPm8xIRI7bDQprftr6PEsj1KafeZw3Pg29VFZPI4Nv5uYO2lgyw
	 bqa9g8JBN9ZxMHtBZD5kogtpw9WAxexJM5Gf+8JkpOGQYJFdbcTAOOWx3cgqGZmlYiASh
	 MXMQzKwsaE/w7ATbFMGKZ/HdfZ913b7s7uBvuUr0P0WSGYZujQrraYvoNF8o3QXksSrKx
	 jpPLBgDq6Xrhbers8U8WwAB0XuQTe2RwvXFuoX93F5UG0MZ1MMrXFCWxnNbP4+5bORJwJ
	 j19mltZuUfn55G/+l/ZAGAXFynOuq/uwZVTMdtqnx3Rwn5mDx4s/6waEMKjQLEyA31Q==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Xipq6SHa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.48
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 44CCAF8045D;
	Tue, 13 Oct 2026 17:47:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44CCAF8045D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Xipq6SHa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8b6VRFmXqK5P4NWq/Q3zthb+54Kh4eMPxczKsoOfNGRYehAh83lOndnw7wAGAehGgCzE3RFKncg2KgGO9pEvZ0GYZtJ9q1QvLy1Fa74iNs7WuO/KoPbfU9N+yqSgwcaWoABdHZPk82Cqkj9CG2HeVx6OcC32P7VGvGmcgft5csaaJaKSQ2LkissBIlXTSjMnNdQVrPciGtFJ7Ui1BGo5lfLDgFqZNJzuMAgbu/VOvsUWnLTdFEybV7pGYO3CA8EGmtKu5physpmWkNuofaoroAK0e59TDEYfdPdWQIEPfNe4n5cyi3gH+Lp/DDGWuJXf9AqytTYfAnTpqzBIAaRHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2cRonvBjTtyqV+nuH7m2ZcvTXvCGu9XezJ3DS6V0gVU=;
 b=e44//HFGVXnEtgeN1r5t06JKCai9I2vuDrZJJF9mYCvK/wDdmmrZ5vk/EkQLBCOFsE8TfTbv623t2cIkALk+4wpJVEQv3hVU2HKnXHqj0PNj2V62KErXAQ2U/OSKzsRklsTBmHBru41Qrv/j03kSG2S1DAwiuEa7ZeTjEz3rHitk/883gXy1SqTsarxryHE7bTQo+rM36PV6zGZU1nfRBPorg8jkmk6N1FLnktLuIUQz0smvoDFXriC2kbFNqV3XBjQin8cioI5tz30uqpLCUxXCM8X8/Yot27Z00sP5qMsV93mGpzF7MBkBFeAnbRnuJVqmnp8gItF76BblYuyPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2cRonvBjTtyqV+nuH7m2ZcvTXvCGu9XezJ3DS6V0gVU=;
 b=Xipq6SHahXkWV6K8nT0m9Hv9J/NoY3GUdtjGxosTE+dgxJVFVLZ9kE6VU+JHoHa8FHpk7833B6kfibt7Mj5Om+epIvvN+5O6LxheJnZ2X2WwL/BXD+bZH/A6HuC5kJxErmtPnkY6k2YhrpfNS+feVvAxWPt9sZZ/wVNh+RFuHOU=
Received: from DS7PR03CA0151.namprd03.prod.outlook.com (2603:10b6:5:3b2::6) by
 IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.18; Tue, 13 Oct 2026 15:47:44 +0000
Received: from DM2PEPF00003FC9.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::4) by DS7PR03CA0151.outlook.office365.com
 (2603:10b6:5:3b2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 15:47:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC9.mail.protection.outlook.com (10.167.23.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:47:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:47:37 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:47:37 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 10:47:33 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 0/9] ASoC: SOF/amd: ACP7.B support and ASP carveout firmware
 loading
Date: Tue, 13 Oct 2026 21:11:32 +0530
Message-ID: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC9:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7492ee74-a645-4e68-8332-08df29415226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	4rnYn1ziMS/tENRV63uXb3ks3UE2Qy5uDtOhiLXe4yAK1hLvtYu2yOJWwGRkJO2WEl85Y9FDiL1hrajM+f26wKk3rD3a8QucXkP59PbQfFYTyz9UhFyD0rxtkUB+YesTijON7DKwG0a6vX00g6La20j9GfT5BcP+7cwjj0B7i8us9llnSc9K+wOtOGsvH4Svb4usFmUfp3tQZIW0K4VdE8d5Zg3UhbfkU33MXQOp0SWHqTieb5S40DUPUAEEo3R5tsj4br4GbimLWd07yiRi7FHGPENUOcCngJibdeqJnCZipHJoDYLzTqYLmjyplDuMJFAnO51fc+Yxaonbx611oG6wStGW4GuEJALyZLO991pvo1hYrZXoVqtRpmkrUWgDwYCYMFDVjBgiP3k6jHqA67+IPfWN8qcwyU9zLaadBjBEfZ71XAZwtY3qnSbG6UGrTaN2TvUjJAetjDXZOQfImy7gHvAqmVVrm1JE3oEf26NlK3bx5tBiI99dgGUAVOYCfsHboFQNKSRRQNaLyUg+uKUUlId153N72F8W12HW+9AiM9RAmI4mGVdlf+CpZpoKbGN5qkzF6hERIEpMwD3PjV0ieVCTZe6PRpZXDh4h2/6auY0o8Z45LnMg2FSVvpYwb0W69TxCidzB9WDfai/O0lxohoBHgjv/bzexIZGPMVKFKC3NhNujOckRmhqlBXrjLBlTZArvXGtoJceFreH0rQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	vMdD8pWWqrWSLxDB2cxzpYM0Y8//BK70XtfPfysG3NaD87q2JOfAxiKe/laVgH66EsONxEDE48xKHQC16LUZUxHhgdzk3dS6+a6jIBmN9llMFABusdHw8/omOnEfRfhPVju3pvQGgQOq5QeGYBBKMamqoPhioiEwkiZQmiM1fIHl+4ax2EQjhq5YRZ8e2fT/Ct3osOi6+QQ/nq2ed47v8Rl46lycMaQrKj0IZPioj7dEQnKXsKTXzotqmTTzNjT2NmtAzO5mnt6V4EFV6pmG1pHvPeiKRCIawxDqH81eBr3GqMbc13hIelB79SE5XLxzzyv9M4cgucaSpEcdx+ebKzVbhf3kPza0tX9EbAYf+MUT7XipJycbUbL21ZtYlzt4+QelQOq5KWjswKbqhQ/+HodGD5hrU3AvazunQ0ib6LzBJJyGBSCGY9t/ZzB2Xogp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:47:43.6995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7492ee74-a645-4e68-8332-08df29415226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
Message-ID-Hash: A55NK6UBYALTLDQIOQU3JKTXYTYVBIWD
X-Message-ID-Hash: A55NK6UBYALTLDQIOQU3JKTXYTYVBIWD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A55NK6UBYALTLDQIOQU3JKTXYTYVBIWD/>
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

Patches 7-8 address PDM controller selection for ACP7.B/7.F. Patch 7
introduces acp-mach-common.h as a minimal shared header for types used
across all AMD ACP machine driver variants (I2S, SoundWire, and SOF),
and moves struct amd_pdm_pdata there from the SoundWire-specific
soc_amd_sdw_common.h. Patch 8 fixes a gap in the SDW machine select
path where pdm_sel was not propagated to the machine driver, preventing
acp-sdw-sof-mach.c from configuring the correct DMIC DAI link on
ACP7.B/7.F platforms.

Patch 9 implements the two-stage ASP carveout firmware load path for
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

Vijendar Mukunda (9):
  ASoC: SOF: amd: rename acp7x machine table and descriptor to acp7f
  ASoC: SOF: amd: select descriptor per PCI revision in acp7x probe
  ASoC: amd: add I2S machine table for ACP7.B
  ASoC: SOF: amd: add ACP7.B chip descriptor and wire per-revision probe
  ASoC: SOF: amd: Propagate PCI subsystem Vendor and Device IDs
  ASoC: SOF: amd: consolidate local variable declarations
  ASoC: amd: acp: add acp-mach-common.h for shared machine driver types
  ASoC: SOF: amd: propagate pdm_sel to SDW machine driver via
    mach->pdata
  ASoC: SOF: amd: add ASP carveout firmware loading for ACP7.B/7.F

 sound/soc/amd/acp-config.c             |  22 +-
 sound/soc/amd/acp/acp-mach-common.h    |  25 ++
 sound/soc/amd/acp/soc_amd_sdw_common.h |  14 +-
 sound/soc/amd/mach-config.h            |   3 +-
 sound/soc/sof/amd/Makefile             |   2 +-
 sound/soc/sof/amd/acp-common.c         |  17 +
 sound/soc/sof/amd/acp-dsp-offset.h     |  58 +++
 sound/soc/sof/amd/acp-loader.c         |  64 +++
 sound/soc/sof/amd/acp-stream.c         |   9 -
 sound/soc/sof/amd/acp.c                |  91 +++-
 sound/soc/sof/amd/acp.h                | 107 +++++
 sound/soc/sof/amd/acp7x.c              |  11 +-
 sound/soc/sof/amd/acp_asp_mailbox.c    | 559 +++++++++++++++++++++++++
 sound/soc/sof/amd/pci-acp7x.c          |  80 +++-
 14 files changed, 1005 insertions(+), 57 deletions(-)
 create mode 100644 sound/soc/amd/acp/acp-mach-common.h
 create mode 100644 sound/soc/sof/amd/acp_asp_mailbox.c

-- 
2.48.1

