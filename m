Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA185C88E5C
	for <alsa-devel@archiver.kernel.org>; Mon, 14 Sep 2026 01:57:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C3FF1601AB;
	Mon, 14 Sep 2026 03:57:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C3FF1601AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789351070;
	bh=pAgw9ytfobk4rTvjmDs2uov5sYyMdItRsNO045sKALA=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vds0y+c2S5kTDhwGnCO2+0VMQJ0JEg0H5zknHeZS0Bq0PQDziDqQHjMdevsNOXuHD
	 QEAST3TfJjxwQyEuQhjojfWNf8JYWkH2OfqKT1Ui6fR4+aoklAVFhMC8CFcXqdLLpS
	 zKTLS09Ik9TYrTgJ/CFBjhy9mmBom3DY5wT7dK1c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8BD90F80605; Mon, 14 Sep 2026 03:57:16 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C14BF805F4;
	Mon, 14 Sep 2026 03:57:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 502C0F80553; Mon, 14 Sep 2026 03:57:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.8
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789351023;
	b=aFlMXDRDlhIfuZj7wU98dM7ihHjQNfg6XW5DfeEl3O7hGC6HpprP+n+tM8xlX81/PCt0
	 Mj8Y6102GAC+1UnBBRAQGsKiVQGmRFClHEVIHqipAvfBZRGcrcWt/PUjsiHXm1R4teFMG
	 LZsvCfkG8QDnBYRhqw8266M+HV4aoBthJ3wfSYOJn+xo9I1rhJgJxVX8QconZK5lIRKty
	 /cBMrv35MXxQUM2MambN76XB1XNqXRVFl3hOd1Yt84wX7Bvj/gstUG6AcNXj93E9rgJM0
	 PWg8P3P44wd2Vx2bhVBjwJq2ktiYYZkEThIh2ZPr/D8LxY/0/4Yd9XmhqGnIdxIID8g==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789351023;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=pAgw9ytfobk4rTvjmDs2uov5sYyMdItRsNO045sKALA=;
	b=APUelR7sQxX2Y8vk634xFNwSgkYTECtCy4wBvx41CAuNVRKDGxI0xVDjK0meiAn9M0ZM
	 iLlqVKIlvPAsekYQmSXyFDQa3u4azESXM5c4V9Sl/dxKBjTj6pCaQNGjoOa4FykDWolst
	 9kKf43FNg/k3ct4o5befQ9xqa0LxrqBDO5dC3sypNTQq3NPVzya/JPfzCaBgP4NUfrLjA
	 wsSLioJcguVXanI+vJq3kcyJuef2t0Ymz/5MdW4/x3MsLheLQi8ck7TbGe9ktkxXJ2cLi
	 /9adf1XBqV7LiHJUrv2XpEVkFusX5s8CQ2/4BDXeWGn18KqW3pCv84Ik8IzwIYr2ypw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=Xeq2mnkd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.8
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012008.outbound.protection.outlook.com [52.101.126.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5A870F8027B
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2026 03:57:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A870F8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=Xeq2mnkd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmPBw6DStrxxZ39VxizOV0whVojomlixB2s5Oywtn+UcNKvd8cgEnYIX2AztEBlnLuXwIyNkSEMM9SDW0Nnc7VLaLmDndlpfK44ZqXfiglVOuCvu0SOO3tWJ06HmjnFv+q3AOZPIxGvFG6f9i2ycEfZmIBtEBQKHTVkgxhqxVD2KXnoo7ADCrf1gfTRQEhdaf+CQ5fqLY8Vz42Gu1HSZ32sDrlpfONOI6QBwd48e2YHIG71PblYVQISUXetzXSNAIvF8Oh7QUP78tcaa+dMROkK4u3G8LF+8IGu7tkkzE2F/pURkzjgav5pkI4ZkEZdRYYM5my5Q0JzNxWcrDtgKQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2stzfbIdko+uwfthSjO9n4VFgCAuFMQJSEfF+6sQvk=;
 b=Utj1aQ+xzj4Jv1P59bRMwwQ/+muGLxnvjAeHUSbhhbDfyPiouQFTquzFGqVhAl1PlOcwCMexpTvvfOMdMvhCx2SMy/rmBR7MsLG1Jo0rTjTOmgMC8I7T9PjYRRXjsJY6dnZ7vPER6zdpz7xf0BzhJGCKo88aYuzpaS740JhNTl6PCOzfb7gWruW/hm+tACQeoUN61Y7XE2gUDBjPf8XJR6LDltTJ8rp1LnKwIuIsu2olkzsgQXfkKpRhF2R7b0ISo9XL8OqPPVqIDaB+mMU8ToRhQT8ids2b68ebptlbF2p3EUeoHdhiTS/zsbatYWmBcSwn0abWVd8kmoljo973kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2stzfbIdko+uwfthSjO9n4VFgCAuFMQJSEfF+6sQvk=;
 b=Xeq2mnkdQtdUIhJ1PhEoMjtGF9OZnTO1Iyg3QAq+UAv0g7s4kkskoONJSxusL8PM+ZnyaDcog/XyMFJRIFLbsdeq5q29aUtgRPXIIO0AQnduBm2ZnY06c8/HLZSVsQ61LAzXwD4SEeW61y9DeLwRK5zr0HGKvH8DzxRpQqvNxxdvIl7NObHuJ7eruMYQKJ9CksjYPKE4VPMOV8v9v6YYvNhJF5B8kgE6ukpWZ/FJJeresHNGuiMU0uOVEOogVaiUqiUNdTc5oRwUNT+SwVp9fW6BaLl46SbpUGnzKA5ZLZ8Ua2BxJ1vOdTOK+alUxVNNXlRjBX50IzsrGFQZlUoVUw==
Received: from OSTP286CA0102.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:219::7)
 by SEYPR03MB8364.apcprd03.prod.outlook.com (2603:1096:101:1af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 01:56:53 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:604:219:cafe::8) by OSTP286CA0102.outlook.office365.com
 (2603:1096:604:219::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 01:56:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 01:56:52 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 14 Sep
 2026 09:56:50 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Mon, 14 Sep
 2026 09:56:50 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Mon, 14 Sep 2026 09:56:50 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <error27@gmail.com>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v5 0/2] ASoC: codecs: nau8360: Fix DSP routing and deadlock
 issues
Date: Mon, 14 Sep 2026 09:56:46 +0800
Message-ID: <20260914015648.311986-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|SEYPR03MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9d3521-3f8e-4e19-970e-08df120372ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|6133799003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	r8BAkwxW+/2QWOolaNosqBi6cClCzUJkraKYzHR2MTP0fDneThb/GJAwXJULRgzFl/0lvdHlELp3fJJVSeUW4grGEfIRs3t4XA/o5PAu8SOj4a0W5nomnAvqBcCmNlYGsVK+JjV6SN9fkTuR9JHslr7BkQfrVj+eV2trZDDiXrMF80qjD/wwoHG/ekJ1bduDysdZ9khNcxqCrJcOqsa5ARZerYqWSu+pHZi8vc806ju0X9UoY1Q4qXE4jPZedJ+OthpT0RmHWJcv0LjbLGFOS3YWvXFwRpJxf9SXEDfYwYFY3GKryYp5eJ2Gq40CgZns4V20XaKMYjGSFQkOzlad4JP0WsCI6hbr824pgXiA58XKkxiT8VtDSRGR/YMR6mMYZJibbiFhFzC25XI6ELWzVzEru50kwb0x7G4rQoJkNtZnlgS8lTYagaZMdrHB0B/Ez/An5INx9rGKS1TjI6l6e9/C3HnJY6eFVm1KifyMpENe3TQ6Ri74vrg6nk+5tvmiK1Oue4ymMUB4pgvaGKpGGmx7b5DnngolmDzgmqEfea62vcyJuPTqiaveMCp2Q1d9oHpTZHskZ3+qszdZCmElhwonC3/80a+S65yCB52KQe7SeVY4oYOygiVlIdwcPpdn/ev0ybRuUleH1jjsYlp0o0fgSJwNoOeiTuwgnP9eulPEFwHLtyyXrlLMPEdlMNaW
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(6133799003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	rHNZPhAhfNqG537Au51asDyJv6OF0vE3bpewr5oinh1LZrZZtHSTpL27uBSy5QZpRCYKDZsTH91Mxt6vJKP4U1fyWvRR7R4x+n0oP9MgQ8RoQjSu7fZw12bNEh3HAn1/nj90kOxTVYm0x9Pnuxn0AAcAxCp/UhalH7pM3T0VUoRY6Zkn/woMGdOGT5KoHkmRgmuv+H586xCUF212D4R6+a5VHGYJut3Nt+9rdOUrxOgjFHCew2gjw64CZzWZxVBr0YzBBiVb2DAvNuCIEf7k6dPK3muWvtOVSeON1DvgUHjlbYURSJ1wjQVwq/fo0OQVq4u2AAnq/fKuJE7wrlsghDyZfo5ZU2GIS5RNfxGYBosFReRYI22Bxjnfb0Rw/twIFvi1/bcXyggK3v2Z4JNV6WbqfB0QWy786ILUa95lPor6eQnqxVeKpfwI7nhH1AeS
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 01:56:52.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4a9d3521-3f8e-4e19-970e-08df120372ba
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8364
Message-ID-Hash: MMC7OGZG7AOXR7GRMJ6R32OP7LHOKVPO
X-Message-ID-Hash: MMC7OGZG7AOXR7GRMJ6R32OP7LHOKVPO
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MMC7OGZG7AOXR7GRMJ6R32OP7LHOKVPO/>
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
Changes in v5:
- Patch 1/2: Changed the return value to -EBUSY in the playback check 
  condition (bias_level > STANDBY). (Reported by Dan Carpenter)
- Rebased onto the latest for-next branch and resolved a merge conflict
  in nau8360_dac_mux_put_enum().

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

 sound/soc/codecs/nau8360.c | 21 ++++++++++++++-------
 sound/soc/codecs/nau8360.h |  6 ++++++
 2 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.25.1

