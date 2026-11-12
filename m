Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E02606A327
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=VrzK9JPc;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3p06ZhvP
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 60F05601FE;
	Thu, 12 Nov 2026 13:37:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 60F05601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794487049;
	bh=FSgO6C+UlrTOBKJ57jwvc5G1m/wz72lfwqusAAOK21A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=VrzK9JPcoCWkkrYvSK1BF2Zmldyus7HYGWdnWpiJUES7NTn/CcZaetJMwmqnCJxlE
	 6U5v9sZ8qouxJHcRRyzVrUBZniOalrveQFcu7lxWTYEt0O5JirZTx8Mm9/Uocq1TMH
	 vZsGbJ62txf0Wn9N5Ji2gRvQd0D3EAMnnpnvWNfE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C7C64F80631; Thu, 12 Nov 2026 13:36:44 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DB53F80630;
	Thu, 12 Nov 2026 13:36:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4DA93F80602; Thu, 12 Nov 2026 13:36:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.22
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794486991;
	b=Oyoq7hmUty9uigTcpXsnUc/MBzwoULhkeAhIU9nv6vTrnnMjlqIaWrljbbsXS6n5tdUx
	 PeyH/LsoJ8J/hIqfl0xW1BPGvhW1QUzOIvKg7RbzO/ncP0+bKBj8GW8Hl7pdXQEJ0vSvh
	 SEZsaWMAYTOdj5gVCnTTeVB67F3Yj+uNoy/0GkHuqnb7s2wgtqQ09YlaUYcWSVyHdMSQD
	 QgMgmPbgR1GLd+yewaKqauFYWG50Ix5HylR/T0lEH8COA3mWZ64dHEnzqzn+/pkC6TWPO
	 W0SwPa+Mp74cH/9ybOdSCj0eXWqS78oFq7Lnl9ZLnCovYk9CGXrPc/0HV9fzIO0IFVQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794486991;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FSgO6C+UlrTOBKJ57jwvc5G1m/wz72lfwqusAAOK21A=;
	b=G8l3nakUhIOwgncOnxFCoEybvLXFfCv7ikh8GM+UgR904vzc1cvrWe+ZRgyC1VH8jDF6
	 IE1Gjk5Sz5kb+2SFoFhvnynecMuugrwW7URb5Exonz7cXkx1KmgI2o+JM4a4F685RMjs6
	 HsVrrxRVY4MWYlLh/QBVhpkt3n6sJM7ldFsRVlQQcLZdgZ1Ysw3lxVmnYtfyZEANcNeVL
	 1oKrMzFkJTDIo0mNuF+Hic46+eyQwllGC1HE9EIDBPRHNEp8dOROPxtZTyWYwPu5LmFV6
	 41Q1mz+mrEMjnmOwL+8W/JwVUt8kJwmZ+HNWbD3KAvMDopsz7idu8OiT8CAmN913UrQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3p06ZhvP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.22
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4B56FF800DF
	for <alsa-devel@alsa-project.org>; Thu, 12 Nov 2026 13:36:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4B56FF800DF
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=3p06ZhvP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sw4lXyexqNajtRCCK3dNTVaWr/VHgyt3d4lmuw6wK7noljAIr4LsHbJCCVP+pkXoW0MaX9VQH4kBy2W8NBj+CWiuqrxGBWO/dH15AU6S3Y+tY4XHXX5MlbWeXmG59QC0et6diKAwRDFaDBDs+8hkiMcNZaM+V92PGmVjT/54x76t1j5KqvLp4ri+L2TVT8eg49zU850IlbSNH462hslBzojBwF7KuE46PimTkppcrlmrweKs+WCXbvqCwfs5hg/9VLAEFzvUmAVPkYyv/hvnBxVEw6f6s3/wAKX2DmrYYovL/K4xUaGiuwkKSYdoz7doEdUPScSWTuri+D3WHZkZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6KK2hS0CmygBq9Dx9E8ZiNeZQDLXrujVQ8jX4kOrtM=;
 b=UaXlyMdZdJ/hKRs6rjrK5igrTJglA+3be47YEumJvyyGwVEtiKkwJbBUEPNtTYbquiwoHmxZue4fJP6gE/9TxB3OwabEeRtpxYofZ3sxQV+si8JB4NYh033C1rHZjqYbyo4dCuH6RRHsiJ8iIGiqu3YUoRpjSeanknqtjb8v7tl4V+csxK4iePmYZFSNyKx9hSO2b3JnxP0CGmN09Sc5MU2+4jbdiMhOIyaWVlzTZaolCrLFuU921NapHXOV9Qqee+IoGkv5ymwvce8RdfEIs0rLg+BuY43hfkteCiIa3fHAZ2+4xQp+am4QCgcO1SdOLfE4BYdUMiGbmERBpUdiUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6KK2hS0CmygBq9Dx9E8ZiNeZQDLXrujVQ8jX4kOrtM=;
 b=3p06ZhvPQ15U/0txRza8XGNyR2z5GY9FhntkiUkW0Tqw8TAfmJkNg1RaL7xeSppkjVehmH7ZF/Ktp4CA+G6n0MRgNHs94KLbyeuEEAs3GqKMn5KNTzfraQwOjDzjlNSXBOhzj0tPU5Rs76roNF1aL0iKImXRhu76gJZqUt/Y8OU=
Received: from PH7P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::34)
 by SA0PR12MB4351.namprd12.prod.outlook.com (2603:10b6:806:71::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 12:36:21 +0000
Received: from PH3PEPF0005961A.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::7f) by PH7P220CA0052.outlook.office365.com
 (2603:10b6:510:32b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 12:36:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH3PEPF0005961A.mail.protection.outlook.com (10.167.243.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 12:36:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:36:19 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 06:36:19 -0600
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 06:36:15 -0600
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: <Vijendar.Mukunda@amd.com>, <anson.tsao@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>, Syed Saba Kareem
	<Syed.SabaKareem@amd.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Pierre-Louis
 Bossart <pierre-louis.bossart@linux.dev>, "Siva Subramanian Ravi Saravanan"
	<sravisar@amd.com>, "open list:AMD ASoC DRIVERS"
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/6] ASoC: amd: acp: add Cirrus SoundWire configs for
 ACP7.F
Date: Thu, 12 Nov 2026 18:05:36 +0530
Message-ID: <20261112123603.2891858-2-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112123603.2891858-1-syed.sabakareem@amd.com>
References: <20261112123603.2891858-1-syed.sabakareem@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PEPF0005961A:EE_|SA0PR12MB4351:EE_
X-MS-Office365-Filtering-Correlation-Id: afe491c4-ab03-4442-0d3f-08df40b98e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|10067099003|11063799006|56012099006|261022075727099003|261022113327099003|261021121427099003|261009223027099003|261102130727099003|261102123227099003|261026121527099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	J3tcorvzUxHC0yxRpBOWRW4NbUXJXsdPpfuxnYn/V3I05vBy6zCQRa43VnX9bC00oRVX2hoZQzYwTAUr6KnIzwx4kChrDB/dLQ8Cd0WVGZr+RiV4V7JppT7VVRt97pD0L0rr2qj8Nc4zPUKsLqbR/IHEKuZtZbWCZCrmlrX3+XDWcIvt1qrE2F0cAX0U2AlJsngIk+OlpzCL3EbUNiqh5ORrSdhpzycPlNCMZ0GP+AVVa3GsTgbwjH7W2K6BIV7D7E92X8gfsxVbBMSccU96q9QvlbU6TTH+fEiojlheIiYIasgAgHQHw1TIpqlG15cjROC5UawVw20i81KFIudcAz352GJPz2IiEyS8DvhgkE/3ybi5oGm0iPdpfimSpurCOqsDYQR4h5RKYbL4C1MDVsQhJZFkaqwLF1Fdx6Bzj/53HZmq4Jg3I+1gkCPqb818xBbQCw5gsSAfVF5WvBXqP8SfTBaBKaRT7B0/zCNChBYA34YyIl4ROqwIm2Y/3YltZ4IzKvPGs4CxdVi+H6US2EruRyTEMuunIvssR3dEi9P8SI6oTK67WkIZbImIa5HP2b7d/MD6X14i3zLFLS5kgymioDYUJKHoHRFMm0kYVMEhKLc5J4PEy9abWQTYvbCfTUQBgyqzKhiozBoXA/F8bPbXnQn5S57E/Sy/VNaXGjjLTT5+bBhDuRIQ4KLlE4G14mmQl47JdPfVs3nti0aV0g==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(261022075727099003)(261022113327099003)(261021121427099003)(261009223027099003)(261102130727099003)(261102123227099003)(261026121527099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	pV1UrDGKmYT160ZA0RlKDgLtHMvJ1qpRp9/CuytgcUGq85a9ABadw40jYUK8ewxOVNZHV0ZL8+1KJSC/x9icByOWcrEAs6k3120Xhyl8NxRuUw0FKUTkdQq1G10pAFFgiEL7uT8ozUcYP3oTJAlcB4AEbywn6WWjBB9z/ZTN2Yl9FuyqkqOLzogyDr5Rv7E5zr1JNb7pUPmgYH5YvxZmFtVE61Vx4QqqkH3ESJf0ThdEuEpG/CImjsVNiGcoMBL86SfpM1XwCLLUbt/9ZhOXwmeoWvDfMRH6sDyoSvTK3KdMeW0t40HOJUYRcvTsySpneYPSMLzN2aHV+549MHmM+UuyfMgt4nCCwhNV8ggGlT10EcOZxmjuiuzd4IFQqSrV7ga8HY4HwaTmDNS2ZFPXvvfv0GYBKoYjgzZ5KfQymMbUcRLmtQjXH0aMFtG8y9Pa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 12:36:20.8209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 afe491c4-ab03-4442-0d3f-08df40b98e3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	PH3PEPF0005961A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4351
Message-ID-Hash: 3KOCJGROS2KYGCUG57FA7YGWNFBT4B5I
X-Message-ID-Hash: 3KOCJGROS2KYGCUG57FA7YGWNFBT4B5I
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3KOCJGROS2KYGCUG57FA7YGWNFBT4B5I/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

Extend the ACP7.F SoundWire machine table with additional Cirrus Logic
codec configurations:
- CS42L43 jack + CS35L56 quad amp (L0+L1, L1)
- CS42L45 jack + CS35L63 stereo/quad amp (L0+L1 combinations)
- CS35L56 quad amp standalone (L1)
- Standalone CS42L43 / CS42L43B jack (L0, unique_id 1) and CS42L45 jack
  (L0, L1)

Add the corresponding endpoint, adr_device and link_adr descriptors for
the CS42L43/CS42L45 jack codecs and the CS35L56/CS35L63 amplifiers, with
speaker endpoints grouped for aggregated multi-amp playback. The CS42L45
entries reuse the CS42L43 endpoint array minus the speaker endpoint since
CS42L45 has no internal speaker path.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/amd-acp7x-acpi-match.c | 435 +++++++++++++++++++++++
 1 file changed, 435 insertions(+)

diff --git a/sound/soc/amd/acp/amd-acp7x-acpi-match.c b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
index bf11ceb7478b..786ee5796ee6 100644
--- a/sound/soc/amd/acp/amd-acp7x-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
@@ -16,6 +16,34 @@ static const struct snd_soc_acpi_endpoint single_endpoint = {
 	.group_id = 0
 };
 
+static const struct snd_soc_acpi_endpoint spk_l_endpoint = {
+	.num = 0,
+	.aggregated = 1,
+	.group_position = 0,
+	.group_id = 1
+};
+
+static const struct snd_soc_acpi_endpoint spk_r_endpoint = {
+	.num = 0,
+	.aggregated = 1,
+	.group_position = 1,
+	.group_id = 1
+};
+
+static const struct snd_soc_acpi_endpoint spk_2_endpoint = {
+	.num = 0,
+	.aggregated = 1,
+	.group_position = 2,
+	.group_id = 1
+};
+
+static const struct snd_soc_acpi_endpoint spk_3_endpoint = {
+	.num = 0,
+	.aggregated = 1,
+	.group_position = 3,
+	.group_id = 1
+};
+
 static const struct snd_soc_acpi_endpoint jack_dmic_endpoints[] = {
 	/* Jack Endpoint */
 	{
@@ -148,6 +176,336 @@ static const struct snd_soc_acpi_link_adr acp7x_rt721_l0_rt1320_l3[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_endpoint cs42l43_endpoints[] = {
+	{ /* Jack Playback Endpoint */
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{ /* DMIC Capture Endpoint */
+		.num = 1,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{ /* Jack Capture Endpoint */
+		.num = 2,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{ /* Speaker Playback Endpoint */
+		.num = 3,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs35l56x4_l1u3210_adr[] = {
+	{
+		.adr = 0x00013301FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00013201FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+	{
+		.adr = 0x00013101FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_2_endpoint,
+		.name_prefix = "AMP3"
+	},
+	{
+		.adr = 0x00013001FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_3_endpoint,
+		.name_prefix = "AMP4"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs35l63x2_l0u01_adr[] = {
+	{
+		.adr = 0x00003001FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00003101FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs35l63x2_l1u01_adr[] = {
+	{
+		.adr = 0x00013001FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00013101FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs35l63x2_l1u13_adr[] = {
+	{
+		.adr = 0x00013101FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00013301FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs35l63x4_l0u0246_adr[] = {
+	{
+		.adr = 0x00003001FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00003201FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+	{
+		.adr = 0x00003401FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_2_endpoint,
+		.name_prefix = "AMP3"
+	},
+	{
+		.adr = 0x00003601FA356301ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_3_endpoint,
+		.name_prefix = "AMP4"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs42l43_l0u0_adr[] = {
+	{
+		.adr = 0x00003001FA424301ull,
+		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints),
+		.endpoints = cs42l43_endpoints,
+		.name_prefix = "cs42l43"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device cs42l43_l0u1_adr[] = {
+	{
+		.adr = 0x00003101FA424301ull,
+		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints),
+		.endpoints = cs42l43_endpoints,
+		.name_prefix = "cs42l43"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device cs42l43b_l0u1_adr[] = {
+	{
+		.adr = 0x00003101FA2A3B01ull,
+		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints),
+		.endpoints = cs42l43_endpoints,
+		.name_prefix = "cs42l43"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device cs42l43_l1u0_cs35l56x4_l1u0123_adr[] = {
+	{
+		.adr = 0x00013001FA424301ull,
+		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints),
+		.endpoints = cs42l43_endpoints,
+		.name_prefix = "cs42l43"
+	},
+	{
+		.adr = 0x00013001FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "AMP1"
+	},
+	{
+		.adr = 0x00013101FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "AMP2"
+	},
+	{
+		.adr = 0x00013201FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_2_endpoint,
+		.name_prefix = "AMP3"
+	},
+	{
+		.adr = 0x00013301FA355601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_3_endpoint,
+		.name_prefix = "AMP4"
+	},
+};
+
+static const struct snd_soc_acpi_adr_device cs42l45_l0u0_adr[] = {
+	{
+		.adr = 0x00003001FA424501ull,
+		/* Re-use endpoints, but cs42l45 has no speaker */
+		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints) - 1,
+		.endpoints = cs42l43_endpoints,
+		.name_prefix = "cs42l45"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device cs42l45_l1u0_adr[] = {
+	{
+		.adr = 0x00013001FA424501ull,
+		/* Re-use endpoints, but cs42l45 has no speaker */
+		.num_endpoints = ARRAY_SIZE(cs42l43_endpoints) - 1,
+		.endpoints = cs42l43_endpoints,
+		.name_prefix = "cs42l45"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs35l56x4_l1u3210[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs35l56x4_l1u3210_adr),
+		.adr_d = cs35l56x4_l1u3210_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l43_l0u1[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l43_l0u1_adr),
+		.adr_d = cs42l43_l0u1_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l43b_l0u1[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l43b_l0u1_adr),
+		.adr_d = cs42l43b_l0u1_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l43_l0u0_cs35l56x4_l1u3210[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l43_l0u0_adr),
+		.adr_d = cs42l43_l0u0_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs35l56x4_l1u3210_adr),
+		.adr_d = cs35l56x4_l1u3210_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l43_l1u0_cs35l56x4_l1u0123[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs42l43_l1u0_cs35l56x4_l1u0123_adr),
+		.adr_d = cs42l43_l1u0_cs35l56x4_l1u0123_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l45_l0u0[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l45_l0u0_adr),
+		.adr_d = cs42l45_l0u0_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l45_l0u0_cs35l63x2_l1u01[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l45_l0u0_adr),
+		.adr_d = cs42l45_l0u0_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs35l63x2_l1u01_adr),
+		.adr_d = cs35l63x2_l1u01_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l45_l0u0_cs35l63x2_l1u13[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs42l45_l0u0_adr),
+		.adr_d = cs42l45_l0u0_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs35l63x2_l1u13_adr),
+		.adr_d = cs35l63x2_l1u13_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l45_l1u0[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs42l45_l1u0_adr),
+		.adr_d = cs42l45_l1u0_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l45_l1u0_cs35l63x2_l0u01[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs42l45_l1u0_adr),
+		.adr_d = cs42l45_l1u0_adr,
+	},
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs35l63x2_l0u01_adr),
+		.adr_d = cs35l63x2_l0u01_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp7x_cs42l45_l1u0_cs35l63x4_l0u0246[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(cs42l45_l1u0_adr),
+		.adr_d = cs42l45_l1u0_adr,
+	},
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(cs35l63x4_l0u0246_adr),
+		.adr_d = cs35l63x4_l0u0246_adr,
+	},
+	{}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_sdw_machines[] = {
 	{
 		.link_mask = BIT(0) | BIT(3),
@@ -189,6 +547,83 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 		.sof_tplg_filename = "sof-acp7f-rt722-l0.tplg",
 		.fw_filename = "sof-acp7f.ri",
 	},
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = acp7x_cs42l43_l0u0_cs35l56x4_l1u3210,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l43-l0u0-cs35l56x4-l1u3210.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = acp7x_cs42l45_l1u0_cs35l63x4_l0u0246,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l45-l1u0-cs35l63x4-l0u0246.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = acp7x_cs42l45_l0u0_cs35l63x2_l1u01,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l45-l0u0-cs35l63x2-l1u01.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = acp7x_cs42l45_l0u0_cs35l63x2_l1u13,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l45-l0u0-cs35l63x2-l1u13.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0) | BIT(1),
+		.links = acp7x_cs42l45_l1u0_cs35l63x2_l0u01,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l45-l1u0-cs35l63x2-l0u01.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(1),
+		.links = acp7x_cs42l43_l1u0_cs35l56x4_l1u0123,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l43-l1u0-cs35l56x4-l1u0123.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(1),
+		.links = acp7x_cs35l56x4_l1u3210,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs35l56x4-l1u3210.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0),
+		.links = acp7x_cs42l43_l0u1,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l43-l0u1.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0),
+		.links = acp7x_cs42l43b_l0u1,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l43b-l0u1.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(0),
+		.links = acp7x_cs42l45_l0u0,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l45-l0u0.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
+	{
+		.link_mask = BIT(1),
+		.links = acp7x_cs42l45_l1u0,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7f-cs42l45-l1u0.tplg",
+		.fw_filename = "sof-acp7f.ri",
+	},
 	{},
 };
 EXPORT_SYMBOL(snd_soc_acpi_amd_acp7f_sof_sdw_machines);
-- 
2.43.0

