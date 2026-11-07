Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66B4606A326
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Nov 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=A5TfijOP;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lU6JSYbp
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B7AAF601E1;
	Sat,  7 Nov 2026 18:55:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B7AAF601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794074145;
	bh=b00yCIpNx0MYGHLzLSlblpl0blyKRMVPi8nb9AIN++8=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=A5TfijOP5y9iBr8GkdWKdrcbchnJRep+qkWW48LAVSLOm0nZZTzSbHi0KcoLec68v
	 NzgXn5ij4yEMz1rx8HE8RD8/hYOVkkysIhMhd7AXACuezHOhezKgcHbMuOroH9paxK
	 NPYY3eMBuORNnohGjNlUgfhLLYPsHRhpfpYJ0qEY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 165F0F80605; Sat,  7 Nov 2026 18:55:12 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1824AF805F8;
	Sat,  7 Nov 2026 18:55:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3579FF80538; Sat,  7 Nov 2026 18:55:05 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.23
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794074101;
	b=fEeoBQhXfhJtB1yHvbxjQdIDfuPHREGiBcaJbHbIATywRBp5A/gOCGxIQPXX1K5NtkWd
	 GHT3wJmTYe98V60Sm+EPrepfStL/GYdKkGuehyZAoRVCM7Nz99h7wp4lCYcatwm0zZrMp
	 q/+ckdbOIBGJfCb5f4MgVPEWqszwwhmtdZIDThU1UEBvA/sn3vPcdF7squK+wlCaKzcAH
	 3GuFH8FGYQ2+2bWl+5SGgdKLv2rOo+EsQlfk4LY6FcLNkDXUzd/8X4R1ZJSV7lM7WBMw1
	 PSNmIK+T7QXtHjZqJQw7RcjOH7sXKPIhRd6rEHVnLFffzAJV3NUkHqlrTadFI/Azh2A==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794074101;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=b00yCIpNx0MYGHLzLSlblpl0blyKRMVPi8nb9AIN++8=;
	b=ppA2ee/S2z9Ns5bBDJNHGSA8poOPahjOI0K+jMsYh+nbQGd7WCspCnWhW5akyPKaNwnm
	 oMxY+sgX0gMrgPMOydAms2ys0Xm8T2UNEaMnAE1ZtWA7FpBUrkp+NEbT4fcROYNATaOr7
	 OQHAsTkakX2NM3rtIe8fNKHTbLN09F2jx49Mc00mTf0Sxip7P6AsCLcYIdA0Gtn3qkWW7
	 684Mu4brKXIiNTBhQdf/YW+QCSP74WrhsGJ/NmWKYpXkNnc0KGOKezdjnxPm5yXGN5nCC
	 mIp/bZZ6SsFfVHNGlh2pIZKn55G408zZAyJF0iq1vDlMgv89AGPG7wcF4n+ulUkmrdA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lU6JSYbp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.23
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010023.outbound.protection.outlook.com [52.101.46.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D7767F80538;
	Sat,  7 Nov 2026 18:54:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D7767F80538
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=lU6JSYbp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofqmDWBKdDSMqvnCZBY+VIVnTkb+CWLweZJx2YGA8T8C4s4xidslT5NqCtJqOVLDYinjxvU1khWXFJUNLvnQE9Oagr8crZkIXfztu97hBLfHcwdpKvD1zGotTlCk7WHntv/SVs1pH57hABsvMgCVEC3FxLwTTID7rfMb9mCYb/bAjgz87t/PEfuCFrXOz4BOlb36oXXIOjfEu+U6+EzlcQjZM7F8aNOqwcImgGjip6Nl/3Na74ENm0NSaRu8On+JEfsBE1IRiTzZmFeB3Ji25UPZSUCI/TS87YxoDdLK3Cab+/vfARV0ZwuWZVOhPq4+IvTK+THo2hIrIx2/NSqkdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBa8GCKv/gbussZ7f/tAHyvHVXCFihcaEv8idEyi97k=;
 b=suIuaLXaHzRhiJShiVJiZFKSlJJTkhr0CLoz62x44oaaw1bw/7LYh2kIN8JwBdFOE+woFCus7w8RtK5jN+iBFxehul/wItK0DOP6fl73xl8YAQojAg13Rl9J3V7/J7Qh735QKV7zN6RnfSAEry4km7mYNnP0Zp3PDFT+LON9noJZCxQ+RHxgsQCIr4bQ1+eYryNJvn1f9wpdCXc0AoCNWhmcV3dXAOO/NAxjxrrlMNtOyfVRrrydY1lbMk7eK7KNXuD/5kvbcdnLmiSdkR7Xuys2fY7zbMNlpz8bk4DrNA8vSSxv8HCZO9uWdBrm9wDyeEfwBOlHX74zu3AfazBjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBa8GCKv/gbussZ7f/tAHyvHVXCFihcaEv8idEyi97k=;
 b=lU6JSYbpT2XtT9+/Yqg5BsdHPcyABCvDQ9p9mV9NyhpmfapDEiOuJToUQnaHT92NUShq6FqhV/NGAcPG4tNaMvcr+J6gWiWSi1RlxjLJRrAxm7B3lXctVnq1U7w+XVSh7VVPIZxKSkthuO3518vI9CLysix9AZPXEnyy3IzJ2+U=
Received: from CH0PR04CA0044.namprd04.prod.outlook.com (2603:10b6:610:77::19)
 by SJ0PR12MB6856.namprd12.prod.outlook.com (2603:10b6:a03:47f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 17:54:51 +0000
Received: from CH2PEPF000166C0.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::57) by CH0PR04CA0044.outlook.office365.com
 (2603:10b6:610:77::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Sat, 7
 Nov 2026 17:54:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF000166C0.mail.protection.outlook.com (10.167.252.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 7 Nov 2026 17:54:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 7 Nov
 2026 11:54:50 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Sat, 7 Nov 2026 11:54:45 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <vkoul@kernel.org>, <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<perex@perex.cz>, <tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>, <Poojitha.N@amd.com>,
	<lee@kernel.org>, <Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 0/4] ASoC: amd: fix IRQ handler races in AMD SoundWire drivers
Date: Sat, 7 Nov 2026 23:22:25 +0530
Message-ID: <20261107175339.3547918-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C0:EE_|SJ0PR12MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: 97679d8f-97c2-4ffe-3cd1-08df3cf838ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|7416014|1800799024|18002099003|10067099003|13003099007|11063799006|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261021123027099003|261009223027099003|261021121427099003|56012099006|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: 
	Q4FBxSVh9ESya6oZQ3sMI4e0tMEe9DIzkvnPduOZMLxH0jj5RFD7jedy9mdOJhSRzbr/9IyzmYbIPt6c+ohCU2MCbXxZF9tQcrfWeQRxo+q/VEJuSB3GZGtT8h0ewr3cpTvEPJVgFSeIFdmwqqlOL7l84k5sI27HWG3yw7kYlSVuwpfSiwM4j3D0InWThVjBmMEyzsChybEIPdmItbjHnzLTWqHh0mZ/MbaORbJZsv0kA8bn6sRB7Gi0gL5pjXYgCe3n0gjucHPmFw3wVmZxKZFrjlfBPx0EG/H3WG47s0cbvlxKyQhbd/K1P4GDe6Rpje34j0mB0gcPZkMQIWV68HpHt+o4Xs8m95MP8slkMD76I0zjlBKigk36d+s3wZi+AzVCnjCbrzuCMn58k2X4N16yVbjUNq2h6JI/2v/DqkR1QGwz6mFv7hAu+Tn7JXRTRBXR+00OslyrjEg4itjcew/3SDEppZhjOSulvFouDK9Nt0g9T1gHa1WS0jGxNQvLF5aPGkcDapgpR3Fny6YJqSTWzO3PgmWRMhpujLWFSLLav2tDYbTUV7PUj9L/XTQrKD0hXMk/fJL3cknbatBRu6xstrIL/vASOd0SsYaDZHSNAagLmNL1C+rawlhQEjsc6LJcqsQOj6zgT597YkNOh5oDNir/kK0mSJIsXq/kvSo=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(7416014)(1800799024)(18002099003)(10067099003)(13003099007)(11063799006)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261021123027099003)(261009223027099003)(261021121427099003)(56012099006)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	NTVkoXj4Ma3++6KcuCj+2LUFlH6l01SupzapNSl+mCM2ugwacsdZLnTIrl3cYSufHKtq5fM5ic1sraeyWKAEtMCkujErwbUa+jcavFCXGB+gsiBBuyypxmYresd1V2u4nj3jhm4nTdtGP0bs6jlgwrIWZQ8epguv4GsTquJIAmYLwM6oLNs4DdlY2GAuOesQccnyqUVgej/PF5UuQb+PDuSvAtyAoaoqoPwp2LlMvBdAxnRalrDDCJnx5WuYlKPf/UDmvvARWamazm5+OaKn8XpWgz+xZwWSaxfq+31npE9N1aCVkZ0YuJFO4ZJlirj6a/kmsKDTyzCqJ7OGSjNrcHaK1W9Ut1pUlrxt+XXHO23mXuS4HVF/vHwSj8yziZLheeLXhGeJxgMOSXUgEkz6HtD+I2rQUAlrnGvaqvZzPP0P7qOastQd1mCpWl3bLBDC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 17:54:51.3776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 97679d8f-97c2-4ffe-3cd1-08df3cf838ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH2PEPF000166C0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6856
Message-ID-Hash: Y2RGJSGNI3EZTGFI2MWWBQESY7NM4EMH
X-Message-ID-Hash: Y2RGJSGNI3EZTGFI2MWWBQESY7NM4EMH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Y2RGJSGNI3EZTGFI2MWWBQESY7NM4EMH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

These four patches fix two related race conditions in the AMD SoundWire
IRQ handlers for the PS (ACP63) and SOF platforms.

Patches 1 and 2 guard against a NULL dereference in the ACP external IRQ
handler.  The handler is registered before sdw_amd_probe() assigns
adata->sdw, so a stray interrupt in the probe window, or one that fires
after sdw_amd_exit() frees the context, can reach the adata->sdw->pdev[i]
dereference with adata->sdw still NULL.

Patches 3 and 4 guard schedule_work() calls with the interrupt_enabled
flag so that an in-flight IRQ arriving while the SoundWire manager is
being torn down does not queue new work after amd_disable_sdw_interrupts()
has cleared the flag.

NOTE: Patches 3 and 4 depend on the following patch which introduces the
interrupt_enabled field in the AMD SoundWire manager:

  https://lore.kernel.org/linux-sound/20261107154659.3358223-18-Vijendar.Mukunda@amd.com/

Until that patch is merged, patches 3 and 4 should not be picked up
independently.

Vijendar Mukunda (4):
  ASoC: amd: ps: guard adata->sdw dereferences with NULL check in IRQ
    handler
  ASoC: SOF: amd: guard adata->sdw dereferences with NULL check in IRQ
    handler
  ASoC: SOF: amd: guard SDW IRQ work scheduling with interrupt_enabled
    flag
  ASoC: amd: ps: guard SDW IRQ work scheduling with interrupt_enabled
    flag

 sound/soc/amd/ps/pci-ps.c | 32 ++++++++++++++++++++------------
 sound/soc/sof/amd/acp.c   | 32 ++++++++++++++++++++------------
 2 files changed, 40 insertions(+), 24 deletions(-)

--
2.53.0

