Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92761C43458
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:04:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 674A460286;
	Wed,  1 Jul 2026 12:04:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 674A460286
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782900251;
	bh=a3qWkPrtlpcxVxOhNeW87z8qjqKNHfhUfdi0Eriz/CE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=LaP/fNARiWD2pr875SyzNPxmSV2QA+w5m1MEbIGFG8B454vm+FsmwNVyNRr3n6lCC
	 DndDBtfE6NmIKPFft+0iFyoFQRTAr+OyPY/LcOs5JqQ16dgEtqxBqGqsBa/fJmixD1
	 ankMlZ25Bl6ea8VSIBfr7aAJ3ic4omQ/9Pt0lu6k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 83A0DF8963C; Wed,  1 Jul 2026 11:59:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 44044F89626;
	Wed,  1 Jul 2026 11:59:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1531FF80605; Wed,  1 Jul 2026 11:59:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.14
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782899967;
	b=W6bcwBI3IQBxgAU/otKC9VmYLDRiRGvQVRlqMVkzlqbFkEUY1OCbzchj5tJHtjLmsQRu
	 23saRqWOxTNrkctKaw60W0r1t5PXjRZGiiYeYnPmWnaJIOXIbnx1TQ79kq4HLiYjwn1J5
	 Xy8i3FghUjYzNyYgSAUGFh1uqeGuR8oS4/sM91gemb8NVPIuCVf2fbb87MlJ7IQiPP0oF
	 Fz3XuK5/p+T+355XdIKX+l5y/+2c/I02dUg9grKj0aw3EmXL8dXJoLUJMIupMO+QinjFw
	 Q6RJO5+n7TDd8RH9KAXejboQ9vu7CjEhAmjpWilf6QCUNuKZzPvzk1tYHLfSZYDk7sA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782899967;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=a3qWkPrtlpcxVxOhNeW87z8qjqKNHfhUfdi0Eriz/CE=;
	b=XbDEYFep7/B5RdQc8Xr9aYkAxZSrDVtxlrWQFmT3n46l0fV+dfUWNahNI5fltNhiOqgI
	 CFzLzntoHRnppS/gzdAv9mhoVfimlLjv2orD7Yy56mzgZxxd3zs/pvsDMfaSoufKa0eMo
	 7gwCGeveqZNA7a6Ao8k2EeLMqnP9VpxlhEFQ9ua4ha7WxM6meDs17izA0fEDw98oQV28f
	 gaSOBiU9tatFYbNO99FkAYSlqWPu6e9J4kMkE6fqrSJj2KJjFTqNAkWtGWrQVtWfB4Nb0
	 KH54EWQab+Az9RSBo13s8txJMfKrq/yu6z8PFVMkp2NgV7N96u9Ktq/GaQYRR/zi2zg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qB9hfm2N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.14
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 46250F8076C;
	Wed,  1 Jul 2026 11:59:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46250F8076C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=qB9hfm2N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMtpULqzamuMXb9w9/pWgIeCzNeTIadCGsgzwPFP9ZpYz5j7pCx1ZDuDvJoW/lNwe3bZIpRZsHTybClg4PcoLO54XPiZ3KmONBiDNIdSS0Gd2wQyAQtzJe8HDtk2mVBfGHNpHkfuvDNUneDEkfbjqzte2owUyetHu8jk6iHnNvTLv2Fzb44DFceKq2aU63RJNDaODUMvwpPbJ20nt3JyKzmS0KQJcVtAPK3Ko+2h3UqRGii9ex32zKNL+cQjA4S7oP9niiCc3VUs7rr5flduoqMIox/XSg046kKRiY8g2aXzmvHc4RsiLNc746eIvWPIaHnm6laXNQfI9TGHD9otbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lMx+s9o0bYz1p2Bl8ysMUHBe5ySYqEwPXj00XEJC2I=;
 b=b58uyheVlbhKJr5dU24fU5PWaKbYnDuIBEbbnlfoaSxlDqRlCozKQe9hyU5gmToC4m7dJ0POZ1K4ZOsln4Izr7BSwrHCAtO9c7AYXK++E4hzS6sb1A8C1G/dBYKmE6EkPhI65UbzYYCm1p78Qv8/Xm0WktGWtReB7Lhi6FsF3PFnTPUz/eX6cXESuTjqIcwYoj+Go8JidyQndKpwr/nPgqs53HH/XNLxueaDVltbyan4A7OUgU1frvUcFFtVj455tWoJrXRRUm7Kv6IvLKN99xypoiMYM7eRMEZPNcMGI1RsOcUi8CLRjy5fUi2S6a9H7aVcHDTDLRh5SpeJQ4YUDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lMx+s9o0bYz1p2Bl8ysMUHBe5ySYqEwPXj00XEJC2I=;
 b=qB9hfm2NXEz8QPHBzCBeiLo1OZmSCGh9T1FxqgX4BmcdKe7bXexKbnhiiAW8xEQvOtqVkL1f6Sr6vd2VoLFIydDMFGxi+rnzxMQOPV+saHEf3BizYVsHH+q92CiJXI1LtN1MMAMHdYdF2Dd0Xf0IIaJpXXcJCzps1y0u2P09CP4=
Received: from PH5P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:34b::13)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:59:16 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:510:34b:cafe::9d) by PH5P222CA0007.outlook.office365.com
 (2603:10b6:510:34b::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:59:15 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:59:11 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<mario.limonciello@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 12/16] ASoC: SOF: amd: wire signed firmware load callback for
 ACP7x via ACPI
Date: Wed, 1 Jul 2026 15:25:13 +0530
Message-ID: <20260701095759.1012929-13-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
References: <20260701095759.1012929-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e30020d-c178-4a6e-2a15-08ded757690e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	wOMk0RP3vS25AMqfS03PWW4ySU2BJE9D2xdJs7qzCzT69AXOFeiU25Z8Z3o6A5MXU8AuirhPYBvJgtM7V6f0YiLNXTyXiu9bRCJqlaRWB1Ypful1MH+3zpnncshLqMhbBySepvg4ndDopW3257aYYwBG2+TpoCATZgNJrvH+bQxbB0qBVamslnqizSP8UwDaXW/C3eTIujaGrJuEXEnuXinkF3ufAIrAi9L3Azf1MnFKwgmbMIny/tR1LavSb2d5kEYL4jAzgzJVfq1ED7n2lxRuHl8rS0YZQo7pF8LR2APfmYvkcT348eQA0Igyo8Dma51e48WLlTjOeoSjFO9Bj/JH8Vwk+NiyJFsqORiAoR1dPnKLGZRdK0u45WPV2fmJD/rrRRggBF0JCoWdu6gATs+npYPlk8Xmobtpev/dI79SUABSwbM+o97qzM32YgB18AktAjiywT18totjBYXYbS2+6hmaFXCoKXvt2fsxIK4pisA3ima8U5+3cyt+wEgVFBh2hcI5qGa4EPIPyu/vUm3icfdwuTcAOUaeiCypes0Jnt6vXjdZsE8xghsuH3scwZFLgsslfjUoWjZKhS8W9NOHKHdkdJ73om3qiJXq7fJfG/wt/EJoKcv198RQEC6TbMD7qC0Wi1lQpRkuQQR8e32Xmpz6PweqePHNBoO3HabxVOXLB7fONqpgfNdYaZeL3wCZa4KcuVWahE346rB5qg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	c4JRopXTJJ5jJ+DvlB5sbKXL/Nv+tqsxaH4hLykct3cBRM62k9m0RkTxMkysKUdNxk99il7GdPFa7iTgGv0L6DA5n3PMQ4Ok89oZM7hZPpMgfIdmiPOAfaDbR9TYMYxDop3d9XI2UBCGJfQD6HNx4LMnP4kllyS25gHaj+omAgJB1KQHBm9RobGWx9oxSu47aojiw2VfLA+AvN4IGnJeNJYG/NTO4jsSeXtz2GZaSxjnjJ9jI8yWvA0TuHRrfXPcFYivAYUm5fARaNjc53hOQAS9xEdOKMU532Z7pn1pOxo9zi0t7PQj4cG2RXDfPPMQZ/rbn+vovpQ5R5N2g9Iea7rL26RluBrLlOweDdJiOnsg0BJXLs0jbR1x6Hxhg0eNIhbtf/jAX9LKKJeD4zMY5uPlXKZpdgbXs8dQwA4o/hKDi2tL1oSS8NeBsAVSNPBP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:59:15.7199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3e30020d-c178-4a6e-2a15-08ded757690e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762
Message-ID-Hash: EK2F4HHN2MLD7KPXAFE3II6MQ45LPGDO
X-Message-ID-Hash: EK2F4HHN2MLD7KPXAFE3II6MQ45LPGDO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EK2F4HHN2MLD7KPXAFE3II6MQ45LPGDO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Read ACPI property acp-sof-signed-firmware-image in sof_acp7x_ops_init()
and register acp_sof_load_signed_firmware as the load_firmware callback
only when the property is set.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/amd/acp7x.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/sof/amd/acp7x.c b/sound/soc/sof/amd/acp7x.c
index c1b9c623bc39..94b7ea08b309 100644
--- a/sound/soc/sof/amd/acp7x.c
+++ b/sound/soc/sof/amd/acp7x.c
@@ -149,6 +149,7 @@ int sof_acp7x_ops_init(struct snd_sof_dev *sdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&to_pci_dev(sdev->dev)->dev);
 	const union acpi_object *obj;
+	int acp_sof_signed_firmware_image = 0;
 	int acp_sof_post_fw_run_delay = 0;
 
 	/* common defaults */
@@ -160,11 +161,18 @@ int sof_acp7x_ops_init(struct snd_sof_dev *sdev)
 	sof_acp7x_ops.remove = amd_sof_acp7x_remove;
 
 	if (adev) {
+		if (!acpi_dev_get_property(adev, "acp-sof-signed-firmware-image",
+					   ACPI_TYPE_INTEGER, &obj))
+			acp_sof_signed_firmware_image = obj->integer.value;
+
 		if (!acpi_dev_get_property(adev, "acp-sof-post_fw_run_delay",
 					   ACPI_TYPE_INTEGER, &obj))
 			acp_sof_post_fw_run_delay = obj->integer.value;
 	}
 
+	if (acp_sof_signed_firmware_image)
+		sof_acp7x_ops.load_firmware = acp_sof_load_signed_firmware;
+
 	if (acp_sof_post_fw_run_delay)
 		sof_acp7x_ops.post_fw_run = sof_acp7x_post_fw_run_delay;
 
-- 
2.45.2

