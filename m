Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145FCC79F9F
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:25:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F3DCF60272;
	Thu, 10 Sep 2026 15:24:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F3DCF60272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046704;
	bh=MXpwBw+5JcS6S7fMhb4PfcSNnVIxU/pemuNpCrYx7rE=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=t4wwAnKUs6PSVsFu8xz6d7IgeI0s6NATWVNwG2WNz6yllmykklf+fxPWE8GpUWMyL
	 CIDOcSSCCMBagpJiLFTvcVejT6IxF7cajLRG2C+QBm18LuC5VR7f6Cug5DfNLlUCzG
	 DIq24QpWhhkqU3F8LYqO5NguA3IqL+Q/xeHe836A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 068F2F80605; Thu, 10 Sep 2026 15:24:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BA15DF805FF;
	Thu, 10 Sep 2026 15:24:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7951EF8058C; Thu, 10 Sep 2026 15:24:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.47
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046656;
	b=JYCzBKJb75rz7JGhkZd2U6+yIZTRMFbyAMABylk3drUHzKYevN1R2xiBOEtb14Fd+paF
	 DgW/kqT6yFAbQqgtZxkLd5Df1HrkNK1WDiENRvJ7uDub4N4STOyC06BKH9Mwha8stFT1W
	 dD/ggIFxVNcADbtYpQnM1nEudyUNVJRqoQncin6Z+swOf62o+6JP8G3t1JkPw8TdwEx1E
	 9aY8SpDppwrD4OpiALW6yxqtf/uAuWS3T03nfN7L1Gg5I78kdbSZ5tvsQs6JkTRCHg0Ms
	 hnopLO1kclNxhSOv99I8hzOvlDu7qfnSTqAEFivVLnc56cXOTkTr9OS/eEk4MARAWkw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046656;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MXpwBw+5JcS6S7fMhb4PfcSNnVIxU/pemuNpCrYx7rE=;
	b=TuILxbgn/r9VBYB/0OGB5pQAOx+p5dlB16MmK/Yb+BOLIy1kzy1cHvvQDXNF197Rh6xB
	 eJf/+F3NSKHpzy9oFUHkQHDy3U9sLRtKMD6gDZV7Q2CpTDD4rbdcZjUzt83m/hhMNioxc
	 9ApwkiqB9zJwYhqqziymcwRN5BEfmZ4vCIeOIP3lGbczDbwoi4V8Qp1HzZsLcckQoHq5c
	 S/d7IHqEM5EEwLzq15q5s/Z4d8ql/l8ZxmIxxIj0zaNMVd9ynUijMIcUL9wITTjqBBUUF
	 nL7ZO0EDrLiOzA1JECChmTm4SbsuPZ2DmDrOwgzIrMXCUfehtKlqjs1Ic1Pv1WtwJug==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=joQeXmad;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.47
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C1E4DF801F7;
	Thu, 10 Sep 2026 15:24:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1E4DF801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=joQeXmad
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKtNnqmVuKQ53hgVsMPS2MUBb31uAhYhHLIPa6fzZlD9s8k/8JV/DMtTVbQAwCh7B0brAG907r7UZ5ZbmtqPXzmRajSPVJPqgb+vkA7dWLYSLzcvkHYpIbudcpOv6X3NJSSKi6yJDCmbRILRjHrzmKJf80LmoNqbBx249noBv34621Kj7+1ij8bbKLfdePymlifoJwBnO1CEbdvx0uEFafJl6R5Qi3/9dP6nCzKc3WTnF8oYksk3LO5s1RIg2IbVGVxRS9oGRehd/TjNQkstSlUJj9krXGZ+/A3EQk1FfFmm+xx74zh5JebnSs7ieMNfAuj2SITKr08bJ5AGuylJag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p4l4YYc84S79phyNERWD1eyH+Wri8ah5WinZFuY810A=;
 b=dDI2P1P8zghDfSXY2qdtgvoSt4/+SWlk+MUEwuYjk4klId4SCzX5FquXn4vbX0R1IiGTivK0LKKs53qWMhnEhtHrrvygPnaSKWRKV0BsK0rpmkm+eapWlMWG0mQ9XTl8HhD1tVGDvVDYprE20e9oPDFRiX1jiNra/ORYHQol3CGg2ALIFt6J+MvFyWTucsA9VazeTxn8PrpP3l6iDKfbmu/lasiB8uPQcJ7K6MpFJTAh5ElGKxvsOeknXucsDHeUMZwZSITlvuCE8/celf4Uxe5xbJuu42TJK4Zd6BH33QlTh4dcRgwjxwCl7Yx8ez8eedUHWk/mN4v0RtWn4IXrpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4l4YYc84S79phyNERWD1eyH+Wri8ah5WinZFuY810A=;
 b=joQeXmadtBSWNvpowvGf+9VfBfDB4eRY24Ilq/ZVopdd4I0VYuvlzaHKrRPfUalhlNSNilw7f1yaKLo1dU6kg9lnNp7wysauEWIEDAz0cNamPy/0ycUOpFoWOlLarV8Kgn28Ce/WeZ56aACKTayeFCzKZd+Fx/7ku2BNidEDBl8=
Received: from MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Thu, 10 Sep
 2026 13:23:59 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::aa) by MN2PR22CA0025.outlook.office365.com
 (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 13:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:23:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:23:58 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:23:53 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 00/11] ASoC: SOF: amd: SoundWire and PDM support and fixes for
 ACP7.B/7.F
Date: Thu, 10 Sep 2026 18:50:00 +0530
Message-ID: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 63af50ca-9e51-4fea-9715-08df0f3ec5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|10067099003|6133799003|3023799007|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	4WwllXR7ZOEaT0SAs2ahCkGNMmE6b4YUOjvdRIIsJ5rPGw2ZGOoMKRZM8ErMBuO05tPhHX5ZCkaNmG6ODv4uXrxQzMRu3WEXp4KOPvVoOpcQfPa8Y02o5fHjPhRBj7sfGMEpWp2Lu/ti36kaWawtB1pZDR0+n+mQr0HlWMRDo92Sbh5py2ltKiR4mGjTCD+GGpZcHXIFLPP6CW8i6NqPBumtADEJaKSloiWvSEJGzaStMXu/r5e9t0VUKja5eoKYKAmhNrXj4L6PVDizwHTDHUCABxuVQyTBNNKVFISeXhSSM5LO2niuZzE6AZ/sjrI5B218yqfmWwkJrX1Sx1XouXs+vC49alHFm2jkU6g5WH0ehXbxTEXvVuezNZP3gvvRvqzMFZKy98tqZtVnAK3Rs0uh4wQSTy2AosqyYRTwS+hRf1HxAreRhY1dopPQOowmgjHnNF+2MEZlNLWOcnIVReziT36pI5c5gZ/9bf3KTrwkXOC45ooRX97vg071KE/nCB1LdBn7HIzgpmt6CKSGlAzeiE7fTzNZIU5uwyoZYz6xj4K3ukYqw66Q6OOObiDfFnqIMdVs/FfZDBkGRe7WDFwPhHMt0ddRlLbFrfPxUYAOa20ChkHmPYLJE2gmJDHFxShwo53zT1iMbOdwAHGQVubRSJ9Rp8yNdLAYPewjm5Hqy32HTKar4nMn1q2FzoL/i6whZY8ot7bnW0Y5MWj90g==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	51XXwqZScXlJ+1izitUuvL132Wl4jNJrT/p2B5ETYGzyXSkaDD5QbUQBXslmxpLXYSp+Aj1KTpOMUoTFRaoT59dhAwqbhG1TwRzEsXXDKr0CmWqxsLddBGezjYbRV4ClPqGEXVvP02Zcb3jGJ9oWamSqfSfRNvJnSPg2Z+n50GChR30oe0V6m8IgLl4dUveIOoy0PDBqYTUAM8EWj0R09ZeUWnLxVTskL7Xrnj0h88m6zjO1xJpPJwHh7F0+vnNymdTcN+/tCzfyCwxx7CF710c3Nfy2jsj0n2EuAEG9BeKT/IkXpes1jLhO8cdUsZywotxWXpSOAnmtmG/IthxWN6+qk2cTmZHalkw6MG7ejNosw1zKfI7R5k89jM+9xsej+I6qgJb/ftL23D40IMW18+U1cf6VhglHRQgZWH4F3TROtoT0wnvUZhK49Ezngz/v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:23:58.8357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 63af50ca-9e51-4fea-9715-08df0f3ec5ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
Message-ID-Hash: N7LWMK3PYDEQEIYVWSELCNJGBZFLB45G
X-Message-ID-Hash: N7LWMK3PYDEQEIYVWSELCNJGBZFLB45G
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/N7LWMK3PYDEQEIYVWSELCNJGBZFLB45G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This series contains bug fixes for the existing AMD SOF SoundWire stack
that affect all ACP platforms, followed by new SoundWire support
specifically for ACP7.B and ACP7.F.

The existing stack has three bugs that are fixed here. First,
amd_sof_acp7x_suspend() silently falls through on an unrecognised PCI
revision instead of returning an error, leaving ACP_CONTROL with a stale
value; it now returns -EINVAL. Second, amd_sof_acp_remove() calls
amd_sof_sdw_exit() before free_irq(), so an IRQ that fires in that window
can dereference the freed SoundWire context; the teardown order is
corrected. Third, the same use-after-free hazard exists in the error
unwind of amd_sof_acp_probe() and is fixed in the same way.

On top of those fixes, the series brings SoundWire support to ACP7.B/7.F.
These platforms expose four SoundWire manager instances (SDW0-SDW3) rather
than the two found on ACP63/ACP70/ACP71/ACP72. The work covers ACPI DSDT
scanning for SoundWire endpoints, chip descriptor population so the SOF
core can enumerate all four managers, per-manager IRQ dispatch for data,
host-wake, PME and error events, selective host-wake interrupt arming based
on SW_WAKE_EN, and SoundWire-aware PM callbacks that take a clock-stop fast
path through suspend/resume to preserve SoundWire bus state across power
transitions.

ACP7.B/7.F also supports two PDM controllers (PDM0 and PDM1), but only
one is active at a time. The active controller is determined at probe time
by scanning the acp-audio-ep-port ACPI _DSD property of the PDM child
device in the DSDT. The selected controller is then propagated to the
machine driver via mach->pdata so that the correct SOF DMIC DAI link is
registered.

Vijendar Mukunda (11):
  ASoC: SOF: amd: return -EINVAL for unknown PCI revision in acp7x
    suspend
  ASoC: SOF: amd: fix amd_sof_acp_remove() teardown ordering
  ASoC: SOF: amd: fix amd_sof_acp_probe() error unwind ordering
  ASoC: SOF: amd: add ACP7.B/7.F PDM controller scan and pdata
    propagation
  ASoC: SOF: amd: update SoundWire specific acp descriptor fields for
    ACP7.B/7.F
  ASoC: SOF: amd: enable SoundWire build for ACP7.B/7.F
  ASoC: SOF: amd: wire SoundWire probe and remove into ACP7.B/7.F paths
  ASoC: SOF: amd: add ACP7.B/7.F clock-stop detection in
    check_acp_sdw_enable_status
  ASoC: SOF: amd: add ACP7.B/7.F SoundWire IO IRQ handling
  ASoC: SOF: amd: enable SoundWire host wake interrupt in acp_init
  ASoC: SOF: amd: add SoundWire PM ops for ACP7.B/7.F

 sound/soc/amd/acp/soc_amd_sdw_common.h |  13 +
 sound/soc/sof/amd/Kconfig              |   1 +
 sound/soc/sof/amd/acp-common.c         |  17 ++
 sound/soc/sof/amd/acp-dsp-offset.h     |  17 ++
 sound/soc/sof/amd/acp.c                | 389 +++++++++++++++++++++++--
 sound/soc/sof/amd/acp.h                |  16 +
 sound/soc/sof/amd/acp7x.h              |  37 +++
 sound/soc/sof/amd/pci-acp7x.c          |   2 +
 8 files changed, 460 insertions(+), 32 deletions(-)
 create mode 100644 sound/soc/sof/amd/acp7x.h

-- 
2.48.1

