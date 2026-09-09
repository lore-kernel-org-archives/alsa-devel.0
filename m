Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBBCC79FA1
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:00:58 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A3BC602A2;
	Wed,  9 Sep 2026 05:00:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A3BC602A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788922855;
	bh=Bx1BFA0turJpdxtlZI/yk9DjHt5dkK9DEIwa97MzHa4=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=S+Zl2jBQ4ayNp07sv2cAreDs3MX75Vp0CEa+T7SrI/Sj3CQ2QTwKG7WhCfU5YqDL2
	 /ZGc0dfXvhIXg21BhuafOYc7kjzoLbfozwUKASvSXiqwmlnytjT1QwDo8DPNiRUtqm
	 2McUquNtjqVn7TvpucmWVjBUEmGtPf6RHDZYzyBA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 117FEF805F7; Wed,  9 Sep 2026 05:00:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 262E3F805FB;
	Wed,  9 Sep 2026 05:00:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8E13EF8055C; Wed,  9 Sep 2026 05:00:10 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.52
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788922807;
	b=UqgXk3DDqPV5JP2uhlg4Brf4CgpJtrMwE1e2Km44gAkUspfj4AHE9Ss2hDAj9efkBeNy
	 3dfVVcE0ApR6X4KeSprXJWzssJBXyrlmeWicLCdR1p8vQETboqd+UWI6X2+Kbbpg6Qv3x
	 pti0OvAxzfEIOARGX3NuFkAGTd42/utHNNzLLqk6a3YWR8adHiboRf/hjNdBd5l+bR1iF
	 A9so5dpw2YiO4867PMLG40yNh/YpN+Dnfj5W5DnT6P8kdZCEHKV/GSYL9yujsUt8VA9fv
	 SCvF+hS22qE3ftHDv6FVkHbJwtJaRqEYpTneW5cxjdNvvt4z3IzlW8+I1tBnJ82VB1w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788922807;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Bx1BFA0turJpdxtlZI/yk9DjHt5dkK9DEIwa97MzHa4=;
	b=DVdLCqlow1yWP7oHDDEhryQ0kYCUIzucs2t9bEdrz/Jg+bIyoWXvBTZjn+uB6Ua2Zg8z
	 a7mgi7DRZrh0Oc6tvmsKJNFbZPSP0SisIQYvmc26gQ2GqvkTHXLAIlccBA4AmvyQ40QCN
	 AgvSyDKv+wvq/rCrhz0WnenB+FWMitl4OyeBep5S2Yx1wBnvyWGSraC+YZLq+6vAdTCYg
	 v6VA9AkZRUT0ZApIHlbLMiaQyu3iYr8zBzDHN2FwPUcorBjTEanxv1Nus+lE6oBAWCs14
	 GNl9VdzYCcWA1Q17fTtYSO/KGRMbgOe2KGuW5wBEET/GsrxkCGaeOXhSEr9EsuTd0Cw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=FxaAcFqA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.52
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012052.outbound.protection.outlook.com [52.101.126.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 10AEFF80549
	for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2026 05:00:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 10AEFF80549
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=FxaAcFqA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d69cus3F6107wAgeYj+5QymexZfrPk9B9lMZywZma5T01AH3sE1NXTnXA8xbNb9uKboldcjJfItKVDJ0QGINKRRg24PwsM5OYlkaUcXSi6/vKmi5ZxbmwDvfUfahpHc6PZXhjqoQzM7o//EK/ZH0mFjNKtdPgGmEW59UEK147Vu1CeDC/oypGZ/kGhIcse4RAAFEwZ45W2dzNuRUKnFSbBQdsGytwK45uxK3fgp7XSTmoRopSyRLFu11Fxzgkx5VZ+YC5owrqIKpGZDSMk1e/ZnNJG9f5btsYXYfFsM2w/6B779zHNImSdkHHRMtSpwtWonVPqxZMml8H6MjLGYfeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqW8AU3ourd4IT952RKB1nMGt0rv7iNIQCnTUgVIzEw=;
 b=ANLqiGUFayG0d2Ry9uF83Irh6v6jU4P0LSCnWMRaCOKGlQwuhtYuDDSA9auAb1zoSgH9qboiRsxFEQDV39fW0xEMd/Xs9sKvloZeyYiHbzZqRjouwuln8aswnuGXXvJlrvdgqpZ/jgpZ1i4XShKbb/ZKe0paTdAZVFXjATvzJQ8XnBN3MdxPkBI2mZN8zuc7wgCZpa693SfScV3e1XSwf85rS3n+7n49Y6TG86xrjPRG0nDfKe6qrXvzWHuOjLEw45L9Y5bCDh00tvAo1oBGoG8hRk47VydWJNhhAuVi/b1T9RHmXlSlPdU3+EPQvNF5N3S0krTKSPQ/grlOW47bAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqW8AU3ourd4IT952RKB1nMGt0rv7iNIQCnTUgVIzEw=;
 b=FxaAcFqA2DzmfU1f6M59WmEsvT1GaFZComXCVuuSsnEBH7qAusJAjisiKq6jOK3oNx/MZxXUNnLeQaXdgn50CfblNiWaG5s3hqifGQutAtIvgVMu7C7QVGSxPwmox04nA/evzeZukWfbOhGPH35qLFOdmRf+5YrMSD0oDldhB6dLZyYalhwqh7WicbDhm6s2VC5eCWx85ZprLYoVeUselBS5BYQG57TCsArAdUH8Ba+mE4RIgekQII5/Z0KeHDs0x3QfBNwMsJj+I02hzVPbBZIq4hmqiTNjAC7tHKOi6ipMm2kuo+4KGJpIjVtrDRX/Py8iYBdn4yxWu8X1w33FNQ==
Received: from SG2P153CA0054.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::23) by
 SEZPR03MB7297.apcprd03.prod.outlook.com (2603:1096:101:12e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 02:59:53 +0000
Received: from SG2PEPF000B66CB.apcprd03.prod.outlook.com
 (2603:1096:4:c6:cafe::c7) by SG2P153CA0054.outlook.office365.com
 (2603:1096:4:c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.4 via Frontend Transport; Wed, 9
 Sep 2026 02:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 SG2PEPF000B66CB.mail.protection.outlook.com (10.167.240.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Wed, 9 Sep 2026 02:59:50 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Wed, 9 Sep
 2026 10:59:48 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Wed, 9 Sep 2026 10:59:48 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v4 0/2] ASoC: codecs: nau8360: Fix DSP routing and deadlock
 issues
Date: Wed, 9 Sep 2026 10:59:45 +0800
Message-ID: <20260909025947.287120-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CB:EE_|SEZPR03MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 68c4cae8-bf86-4d29-15a6-08df0e1e6a94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|18002099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	AZaXla5wOO3VwKQ8DzThvYRAWgOgsS9Eo33J+lPCFgKM0EI/J9KRw95QxZe1y3XSz17oZYQYpGKNdwshdT+YKQ8BbTGVUdeyOxDi5WtwMla8RkgXCcgJTVhJxbqIm82R5yu91RKoZwc7Yd0c5tAxzLqrvR9wlVKdYTS4zi1Q56eOG3o1HDA54HgvbLhb6Ig9QbKiw84MAa3hb/tZhe8ciN0zqTFX93/gVnKn1Q7DPlQ1nI+mj4biNvh28Tz/cxrRfZINSQaO2SQfWGwHYTpHj6wpj6oF0+z9m5ctOG0n/foZzVsSK3BbBo41ZlWLZz7PCacOi/Md4+lmrRQgv4D4pIlt2hfeA1hCWLY3ZiRlKH9xMyKjbfZmnSxApIm6zVGzp5W/zDMDZ9r0W8NDJth5omWqxpifyYiKcm6jxPFUaEHGmp+m5xbfnylSMioHHP0zAX6j+juspxSQfQXjYZgZi0s+4em0h8Km/lHuFyGXv30voT7MuTB8mizRZdHwp1LHMMURnyQ0HlZmq0nCfdfVW6hbMNG02sDofJol0WgH60ZDXLm4OSS+JBMUFoLP8mwaExIDmdlJUysZ5SH0cUHiHRkRtoep0/3VfYSi/cBJ1B8afA0KFqirZ9z1SbkcQUxOok41IlrHt1h/0IeG8mpS/6AEY++ev4KbD6NJK0lB3MvVSin8bilOXlEudXIhWqMpa9qYVDQGpSpQMIyQb+yJ3A==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(18002099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	iGkKZmmszgLxAuswOcEFjW8Su+VG3obGVTM4U2zXtA4hPv1p3RJfor4EdtJtaiXs4pg8v4n109YTUur4P7+UfX3LtTo9hDg5tjI5U6Kr1YG4UtfhUAr/cHugGlCL7Hhs+BolV4grf5+1qZP2Rw3yvFNW0kjulCbFyPdfm4aS+dSD3D8uU8fIBCAhYrDKqEwW6R5rGK0qBXYWSCSrCKIYVeyXeuNHm1dFoTsBAaMHRhWi12rNnlIH+px1qbAsPwgb9yj2TNV/oca0YzL14dUREqso1bQeDYN16N0pcqIaVUtwVWfSVxIxMG+IwzvYlwlN0OUbNhon2hwPgxt6AWTJpgibGpmtLAaBAcrwWRPCDuLVIL5qjbKNnrI+HNtqOduFjaspWkc4BZSDd8VByA1L/qprWMe9dSNQB0KvZB4qoC5dqwBVloaZ6Tn73Y9QCPSW
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 02:59:50.8486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 68c4cae8-bf86-4d29-15a6-08df0e1e6a94
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SG2PEPF000B66CB.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7297
Message-ID-Hash: 74P4WDW6BKP4FKO4UETUXGHRQOIXSPEA
X-Message-ID-Hash: 74P4WDW6BKP4FKO4UETUXGHRQOIXSPEA
X-MailFrom: YLCHANG2@nuvoton.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/74P4WDW6BKP4FKO4UETUXGHRQOIXSPEA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

This patch series addresses two issues in the nau8360 codec driver
regarding the DAC mux control:

1. An invalid hardware routing state that occurs when the DSP firmware
   fails to load but the userspace attempts to switch to the DSP path.

2. A pre-existing AB-BA deadlock triggered during concurrent stream
   startups or ALSA mixer updates.

---
Changes in v4:
- Patch 1/2: Changed the return value to -EBUSY instead of 0 to properly
  reject the invalid request and prevent ALSA state desync.
- Patch 1/2: Used dev_warn_ratelimited() instead of dev_warn().
- Patch 2/2: Added a fix for the AB-BA deadlock in nau8360_dac_mux_put_enum().
  (Reported by Sashiko AI)

Changes in v3:
- Block the DSP path selection if the firmware fails to load to prevent
  invalid routing states.

Changes in v2:
- Use snd_soc_component_update_bits() to prevent register overwriting.
  (Reported by Sashiko AI)
- Fix missing bit shift for default PEQ band. (Reported by Sashiko AI)

Neo Chang (2):
  ASoC: codecs: nau8360: Block DSP path selection when firmware load
    fails
  ASoC: codecs: nau8360: Fix AB-BA deadlock in mux update

 sound/soc/codecs/nau8360.c | 19 +++++++++++++------
 sound/soc/codecs/nau8360.h |  6 ++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.25.1

