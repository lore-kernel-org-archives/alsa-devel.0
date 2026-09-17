Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70DFC88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:54:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DA76601F7;
	Thu, 17 Sep 2026 18:54:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DA76601F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789664064;
	bh=DDWkZwswRqN9MgkHC5LASG8Em7Wjz6cIrAXS96m/pC0=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JqF/h3VfHFNhjfiNzzYarMsfgE5sdljII4U07lSyhsRPnezaK51+tOBjTNkgn+Eq8
	 SVnIY3StqCb2Fp6klzhvjg0LGWm0qF97PQ2N5MtQVVNzu0em3eUbAbFDed9GcgKczE
	 qknxCcZfCf/y+zsqHqfWSLXBihTz2CnNgqxiFNwQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 701A9F805FF; Thu, 17 Sep 2026 18:53:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F9E7F80601;
	Thu, 17 Sep 2026 18:53:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0C03CF80537; Thu, 17 Sep 2026 18:53:40 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.22
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789664013;
	b=KV7kERXqnq2VZ6hZpKtT/mXBHWr+GNM1NgTcY7UpYMXqp+UIJHoec9yaMmpLUMvmooEN
	 JLUQU0bSz4cdjx3nQNiC1vGnPIl9GgcYo29fVqAIgpfDiwKraEVqHBP0VLltujdyzeOaM
	 EonY9LYUZHhb1X/CYSPwHFAc7YhLc0pAYNrD+o/45EfNuW5lIt04uOCzgpapa2B9DBa8n
	 c+ZNrS+XDnINTEEZcBL2dZJyvVDLb6L+89Ns4lw5BahzqDfyCaI9H2o9lnf3xCvX5u/Dv
	 3Sr69jfTxQoghxaksVduWyDOb+gTCC2uNvo3mdFWf13DThBeuCM+FL4HUDQTaHR2v8g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789664013;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DDWkZwswRqN9MgkHC5LASG8Em7Wjz6cIrAXS96m/pC0=;
	b=n3AmpIzR8v08HUTqDkQDrNkdVVfMGr2tiDJ1TfxiZbZouPPeFZXy9wLfcjzoxCNziTb+
	 ozQn3QEeXk70JRGdlkf9AbtNJ4l0BrNnCcl9HAzrVnyIOpb+GDJCU4h52G4Z0b93cHbIW
	 0q6cv17Rc4eAMlUUknO4XZ/V3CLVWXy5ZblViO4P+fFicbfm/w5H6nNwp1i2u6zbTK0GN
	 UYjxjwWEjE1pa7JVbIJewADt7v4IDecL/SvHtccgVVehfs/Hf6qeg/dYTgQKJLK3/l3Ic
	 LiFi4T+BScayaAah8k5Sv5igayg2ho57RZKaRQ1qN6I/r1/mG1WucjMbjHUbhuvul4w==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4CCtd0KO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.22
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013022.outbound.protection.outlook.com
 [40.107.201.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 40822F8001E
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 18:53:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 40822F8001E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4CCtd0KO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egzv35LcLaiN+Q0Ei1jjy6yghRiZN9Moh7Av5N7fTJWRxcGN1d0JRF28EJQ8agD5IvaXGmp+d7/kkgQutCzTK71Uq4e8Tx0ey1OJ544Mwg4XwArOta6HAUaHPUpH4BsQD0T81hW9BL40PpQC/YCpFmm4qN/ijWHsl0C9gtxZJjlzviGeEQsVnqi+tkVdU69fI6AdVJo9UERTBkSFRYSTumwISk8tRgdfaYP6p0WJOcuWWOhNiGlelH50kIYRTqdj25BXgt8QkyglYFIrnl8Vhc8O0Dcc/WkwMUzCPdDYrMZSNVgGElPEaxKI7l0HD7cAXZCL7OIOxI+CiyicCcMlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GK55GCoQZOH2asDRdPBgrv1nC/pbCaH/bHqTcxf9tFQ=;
 b=sMBRUEKNaDNRYk5wzuia22yJk0T5/DwRN3guTDxhW3L7W0ETQoJg+qfL3QfbT6lUPIsAtYQV4UE358QO3WFdehJ0PYo4N2xRQR62IH0dVfFU63uP4MQt4uqb7hIblTN4J3HiK4UtzaKwGczSItq8ujv3tsC8jQOCiQ0bnT4KOhZu6jemNeth5H8Wo2PnwS4ud50sWKphSvaBqKEDGZOROhPHfvcCGzPeCmyA+d2S5YF+AT7muA/V+b08kqk0aNfxCAlkHQ0ivL8fJJ9XAk1kUiNsC12kct4Jphdc3jQOE6oiG/JvvciXsnEySxtkBbt6Z7SQhCEi45Sh3+VYqWCkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GK55GCoQZOH2asDRdPBgrv1nC/pbCaH/bHqTcxf9tFQ=;
 b=4CCtd0KOFR3Oqe0PYu+u8uswVCe4gh8RCwzQ6j4o/W4Btn9GbarpsdcRJA0cn5mZ73D4ATuEGhuTjXPuhm1tQb/wioCG15lsKB1SIowkvsILGgUi8NcNCO9NCcomBl1WcIeTk+GJ9fFdpBthbBFF7Ge4XReGzAJP1lAtpXzWTyg=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 16:53:23 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::1e) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Thu, 17
 Sep 2026 16:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 16:53:23 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 11:53:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 11:53:19 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 17 Sep 2026 11:53:15 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <anson.tsao@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Trimmer <simont@opensource.cirrus.com>, Baojun
 Xu <baojun.xu@ti.com>, Ville Saarinen <wiza@saarinenkoti.fi>, "Hasun Park"
	<hasunpark@gmail.com>, "open list:AMD ASoC DRIVERS"
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: acp: enable TAS2783 and add RT712-VB SoundWire
 machine
Date: Thu, 17 Sep 2026 22:21:49 +0530
Message-ID: <20260917165314.1880855-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: fec736aa-9e09-4e99-ae2d-08df14dc2fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|36860700016|82310400026|376014|11063799006|6133799003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	z/mYlHDITryo79O7MFU5kZd4nYkU+Qxu9RB+xpG82VZwvQ0jI/PqIY7Btn6C36wDran6Zm+gib6+AMYI6H2OTlfTSoP9wuVhCcBd1BidJwkCF5cMIPFkcNSdlktAgCPNY6r4osGcDregFRQ1dyq3blIEhzuMItHfnF/E/bRH7s7jKLPmYxr7j52mrj0LJFGh9aUSgkkSP1T994TQZzxmxokYQHYXEIJes42tGiagCQhIU3fQpo+B8+/kzOoNq/dcGS0QoAq1S6wtQ36Rlcg1mydYNFBlp1yYhjQywqY1aYbCwMI+qw/wePOO/aFSGBB+k3qHThokJq6oOOj7sAsLhjWrnf/t5gSzfF3UnCaghHNkMvz60lEd34L1kccsiRQNqR1QuzQO2MYy4043gITeXzTF3+4/bSCSKU/GIzox/RkmvTJO42JMXJOzR/2tvvcFPPZVrN8puXG7i65KfWp3eCFxr8xXDDF72Gso2cw9+geW8UyEnFZYwywTsl0JRh7O5HbhCTCuBqkq1APMv6PqXIzVFlBdRUBsx74d73f5j0TQsWPhlPV3WFQ9gAIQlOakeNVSZwQhZ0hPA0WxTI+CNuu19BoO2rGzpw4Qn1c0seH4zUNhvfmjhyC7Y315qzvMoE/6kCE8gpdUNnZnWGOd7qR+PHgbQygF9JMaJonJu+Ei2fZLX/iem8+FFO8zfJWhwW7VGD9TR+xlBC8qg6Er5w==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(36860700016)(82310400026)(376014)(11063799006)(6133799003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	sJBIhGVGqKqdcoKEWuvdX3lAK3zvFA5o9Pkg1KJ90MPf+stuK0gmwCJdDUeWZqAdiRCxG/CvC7zJrAtK4Z6sqD2FqtKVS3/aWoaTY8vda2pCKuL+fNB37nNjwWdyiAFT2w1LXjn2kyu7Gi/ldpdxzHm/K92f0cOdQkpRncDHnq5lw0N3o/RAh3vR65E+l2n1xsdPNsSxvR57NbxDO1LwUHSdSAohXXWCNrSNqpFB/5Exj+RDImKCWCvWNS8V0Z0fx8zBlL56ngmFmEbusFQNpozvTKz9JSCOFyl1WMi6Uqn7s0JRuhB7sJTMIO63WZTe7+39pCWPdu/pmYeaL4HJdI7raTEartrn/0QDRg+xUlb8AFov+nL0bGgoNZFW/WSwiQkh1eCFtGe65XC1cuVwb0K3HJxRsDRDslRBgk8MgFK+XZtK0jSz/S8zB/1wldNr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:53:23.4825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fec736aa-9e09-4e99-ae2d-08df14dc2fbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
Message-ID-Hash: 6YX2HICTXVY7F3O2PE4WRSX23LBHGFLD
X-Message-ID-Hash: 6YX2HICTXVY7F3O2PE4WRSX23LBHGFLD
X-MailFrom: Syed.SabaKareem@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6YX2HICTXVY7F3O2PE4WRSX23LBHGFLD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

The ACP7.0 SoundWire machine table did not cover boards that combine TI
TAS2783 smart amplifiers on SoundWire link 0 with a Realtek RT712-VB
codec on link 1.  In addition, the TAS2783 SoundWire codec driver was
not selected by the AMD legacy SoundWire machine config, so it was not
built for these platforms.

Select SND_SOC_TAS2783_SDW from SND_SOC_AMD_LEGACY_SDW_MACH so the
TAS2783 SoundWire codec driver is built together with the AMD legacy
(no-DSP) SoundWire machine.

Add a new link/address map, acp70_tas2783a_l0_rt712_vb_l1, describing
the TAS2783 amplifiers on link 0 and the RT712-VB codec on link 1, and
register a corresponding entry in snd_soc_acpi_amd_acp70_sdw_machines[].
The entry uses snd_soc_acpi_amd_sdca_is_device_rt712_vb() as its
machine_check callback so it only matches platforms that actually
expose the RT712-VB device.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/Kconfig                |  1 +
 sound/soc/amd/acp/amd-acp70-acpi-match.c | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index a04c301df4d6..e880e44b9763 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -181,6 +181,7 @@ config SND_SOC_AMD_LEGACY_SDW_MACH
 	select SND_SOC_RT715_SDW
 	select SND_SOC_RT715_SDCA_SDW
 	select SND_SOC_RT722_SDCA_SDW
+	select SND_SOC_TAS2783_SDW
 	help
 	  This option enables Legacy(No DSP) sound card support for SoundWire
 	  enabled AMD platforms along with ACP PDM controller.
diff --git a/sound/soc/amd/acp/amd-acp70-acpi-match.c b/sound/soc/amd/acp/amd-acp70-acpi-match.c
index 815e088b437d..2a9da6de7bbc 100644
--- a/sound/soc/amd/acp/amd-acp70-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c
@@ -748,7 +748,27 @@ static const struct snd_soc_acpi_link_adr acp70_rt721_only[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr acp70_tas2783a_l0_rt712_vb_l1[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(tas2783_2_adr),
+		.adr_d = tas2783_2_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt712_vb_1_group1_adr),
+		.adr_d = rt712_vb_1_group1_adr,
+	},
+	{}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[] = {
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = acp70_tas2783a_l0_rt712_vb_l1,
+		.machine_check = snd_soc_acpi_amd_sdca_is_device_rt712_vb,
+		.drv_name = "amd_sdw",
+	},
 	{
 		.link_mask = BIT(0),
 		.links = acp70_tas2783_2,
-- 
2.43.0

