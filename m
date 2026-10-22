Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17E606A319
	for <alsa-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=vQalgZbu;
	dkim=pass (2048-bit key, unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256 header.s=selector1 header.b=uw0N/U9K
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D2DF60200;
	Thu, 22 Oct 2026 10:42:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D2DF60200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792658533;
	bh=uEkFZ0AOMfh3KwpEoDX45G9TKy4r/dH3wSKEWQ3TUFo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vQalgZbu7t8NmOhh8aDNIVqPKafz/DoMuhXAqA41zka3v8Ka8ThM2ZhQnx6+YSALT
	 aDQx7YTWjm+z4mX5WFOyw/ij0zvVWpeyrZjVyChSxLMEEZAOj2AWIdj/Ksf2fyUdV3
	 ymqb64W8qg/4APZe7aa2D/ldlq7jplZLlkkYej4U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EADBAF80640; Thu, 22 Oct 2026 10:41:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A8E41F8064C;
	Thu, 22 Oct 2026 10:41:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A40AF80635; Thu, 22 Oct 2026 10:41:12 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012012.outbound.protection.outlook.com [52.101.126.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D6F7CF8003A
	for <alsa-devel@alsa-project.org>; Thu, 22 Oct 2026 10:40:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6F7CF8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=uw0N/U9K
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocAQ+/Uq6uGAqgEBOe4h5ZZ/OCqc11c8TwrEkop0IntwZ0DjFT5C7OvyhhufojDYfAn3DdZa64TEB2niwGdrUCYbv84NTYuajNFIf1PZwtlAOb+0wn+BRahLAZx+fNrISN346Fc1HPt0mh/halXKj6MJxN12rTve3V6QkEIX5OIJadIohczR9g1xhGzGkDxoVaJt4L8YX1ihcGeRQLyL8+3Uo/ZN3i/ZI7ObsUczcuYfNO+xbglI8npwi8CBeDg+/jbh5d5BPijfa+Xj/cs7MypWjVTqQudSX/hOYsMjluL97fLxhoPFPEIT/m9obZ8uiih5589ZCmOkqUxm+g++fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vdm1jQQyorQbRtSOeLR6rUaDNGlzI/sAVWkzxtuPgo=;
 b=JPF3Bx0ZNwXxmWaVCrwXmY83FnalFzgZrA8Su8Cn36LKfC7oYv/449ylud/w+ExtXgXgOCvSoks1jdV8SPq4PHc9Z7RnRFm4k6AlFewBrkO8c6icPUq9caOgxM71PTLF/Xg+KWUeH/i1B5QZxDY6zla5wRi4Nf5BbseMCtJv30i3LE7HYQcsW3VUQsMwkYt0l/qUdAeSyK/GRkMQVXUDGAMy6UlYUHipwANv66qnUfPchuv1Ooki/Y5+Un4ovo37EzeQK5swMRBbFWY8beWOP6fGaCnqRleEL6uAuIi3PQbaPVgOaKzJ7CuvkW/r250Sbk6t33dpQfOeeY420Og/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vdm1jQQyorQbRtSOeLR6rUaDNGlzI/sAVWkzxtuPgo=;
 b=uw0N/U9KB1yP/nijiuJ5VlXbkZpmDD2Rf8YYa5aYp4sRLb30VVeCZ7wEX8GFrSiQ2zRfKc4bVHeSaYg3bVx5KgZYPim5inL8zgi9bVqm9LR2F3guaMBnCPgk1JjDAEBAwkm1gwo8Zm5QS7CiQXwf06iDGzlJiyUGu6xP0Oj8O1KhwIpuysttfL2h8GPDpfIZhlNLVXjKPb9YuIc2+pDGHL/Epz/CuwFM20l5yvH/RV5kQJ1gvLULwYrVbOhVDbNQtgolMWIQdPjN6VCkN/AEnpZPF4mZueBnlseQlLPpBx+uZhzsrNwisa47xMlIfmqgOcwYWXx2yW//nuYnluF+IA==
Received: from PN4P287CA0117.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:2b0::11)
 by PUZPR03MB7014.apcprd03.prod.outlook.com (2603:1096:301:f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:40:45 +0000
Received: from OSA0EPF000000CC.apcprd02.prod.outlook.com
 (2603:1096:c01:2b0:cafe::11) by PN4P287CA0117.outlook.office365.com
 (2603:1096:c01:2b0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:40:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 211.75.126.7) smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 OSA0EPF000000CC.mail.protection.outlook.com (10.167.240.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 08:40:44 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Thu, 22 Oct
 2026 16:40:40 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Thu, 22 Oct 2026 16:40:40 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v1 2/2] ASoC: codecs: nau8310: Add support for NAU83G10
 amplifier
Date: Thu, 22 Oct 2026 16:40:37 +0800
Message-ID: <20261022084037.259983-3-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261022084037.259983-1-YLCHANG2@nuvoton.com>
References: <20261022084037.259983-1-YLCHANG2@nuvoton.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CC:EE_|PUZPR03MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 36dee10b-0a7d-4ba1-dc0f-08df30182977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|261021121427099003|261021130227099003|56012099006|261021135927099003|11063799006|261009221227099003|261009223027099003|10067099003|18002099003|261021123027099003|6133799003|261021133027099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	rV3V97OCPYHBWMfHXz5mzwkjlM5vkpM6j+N37n7PYn9HSsYxS6K+7kE6EqZEBoU9NQOJlPHYxSGPZHykXzrcOeqKZscuHToWOeBPmBXjCKMClvfzmP6coQYfW6rZ0nLVuVeIOj1e0rI6VDYkjDQlnW7KXVKEXXcVSy4y//L4KiyJbpOcIu8qJ+qoD9eOQfUi/L8WQVi8ohAvA3WIzIQBIBd375FlnwuhwfHWDbxyM+fyNQlS041xk+qu4TMcPMs7d9GBWDPEy8b2cMyoktkWWBWznkBactcY23vT/lge/TYKnaL1Bd+fbxRcUMSRN2fJN9KPmUcP0rzMrp1SjSxaKcmSXHywZc34fNzf4jfBv+xf0xs6+bjpATg5GfMuOqOdxPnUNwaLALayBvpBTCoAp1eJ5uOz1E8AGmm8BGS0Rv/Mm/AdE9Tjh7z4jGFEmMG06vABnBlAW50ko8HRXDvrMzbITjxkBE7Nq2llG9iskkZn5cC7/SuWXMIrSARr0Y/tTorva4SYli0b7z1b/Cygd4OfGUM5GWTLe9YDQIpY2Oo8himNYvcLWU4sF8x41P5Rehj/mdAQtebXZ0I33aIV9S/ycW2yTncUlubq8Lar7SjMz5xZkokuef3yVL77wp710Rru9Jr8e5+cLk5FvfzOWRo9LyvYcT3LSflbcuJlyljqoQKNCkePDkIbCkXST4tPwLpdx6PLK1x8ZBUXx76NIQ==
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(261021121427099003)(261021130227099003)(56012099006)(261021135927099003)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(261021123027099003)(6133799003)(261021133027099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	QrSjsY0wyA1xxXj8Htm6AMaKxZEmobkPBGWAgEDEguwt0bwWp27Gx8k/BWPyqEMJkReFbmC6Zj/19AJ6g33ic1n8c8paEEOmxgwSpPtyp4h9U1SSb6I6tk85ZZUK2ku2Ozygazi5XOw3i/ja4RxC+BLx3YNNTqV3RzKMa17kXTbaZdh+06wEFcLiZyJmZl+gg5j/8eh+Ryo4gFrIWufwWI5Tbwv3H27y9HBZFgTJ7ODA6qKjy7zmBHNzoZV8snl6AB6qGHQyui+NFnhWVU7tW6FyQBHWnjsN6GJH89s7ECqHIcrbjZM/aOREZL1JUmkLVL/F+GqVTe7ccvabTx9M90CRMUJRmCxAfG9kc0dkFS1Zqp0eZUM6q91gyK+y02FZcOHPb+ZFhVZC3Rutb5DbItNWBDDjj5rmrdxaoZG9zsFtgjtZlNvIWoxYwaklGqxA
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:40:44.1898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 36dee10b-0a7d-4ba1-dc0f-08df30182977
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000CC.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7014
Message-ID-Hash: HI37OWNVQ2YEOVLBDJI2UKFNJFTCG57D
X-Message-ID-Hash: HI37OWNVQ2YEOVLBDJI2UKFNJFTCG57D
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HI37OWNVQ2YEOVLBDJI2UKFNJFTCG57D/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add support for the Nuvoton NAU83G10 audio amplifier.
The NAU83G10 is a mono boost Class-D audio amplifier with
integrated DSP and I/V-sense support.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/Kconfig       |   13 +
 sound/soc/codecs/Makefile      |    2 +
 sound/soc/codecs/nau8310-dsp.c |  690 ++++++++++++
 sound/soc/codecs/nau8310-dsp.h |  111 ++
 sound/soc/codecs/nau8310.c     | 1845 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/nau8310.h     |  629 +++++++++++
 6 files changed, 3290 insertions(+)
 create mode 100644 sound/soc/codecs/nau8310-dsp.c
 create mode 100644 sound/soc/codecs/nau8310-dsp.h
 create mode 100644 sound/soc/codecs/nau8310.c
 create mode 100644 sound/soc/codecs/nau8310.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ba59dabeeccd..d5a639c4d581 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -174,6 +174,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_MT6660
 	imply SND_SOC_NAU8315
 	imply SND_SOC_NAU8325
+	imply SND_SOC_NAU8310
 	imply SND_SOC_NAU8360
 	imply SND_SOC_NAU8540
 	imply SND_SOC_NAU8810
@@ -2940,6 +2941,18 @@ config SND_SOC_NAU8825
 	tristate
 	depends on I2C
 
+config SND_SOC_NAU8310
+	tristate "Nuvoton Technology Corporation NAU83G10 Mono Boosted Amplifier"
+	depends on I2C
+	select FW_LOADER
+	help
+	  The NAU83G10 is a mono boosted Class-D amplifier with an integrated
+	  DSP and I/V sense. The DSP is programmed with a speaker excursion
+	  control algorithm that uses real-time voltage and current feedback
+	  to prevent the speaker membrane from exceeding its rated limit.
+	  It has a high-efficiency Class-H boost converter to provide
+	  ample headroom for overall loudness and sound quality.
+
 config SND_SOC_NAU8360
 	tristate "Nuvoton Technology Corporation NAU83G60 Stereo Smart Amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 3826f9e4fce8..81efb10e7db5 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -199,6 +199,7 @@ snd-soc-mt6359-accdet-y := mt6359-accdet.o
 snd-soc-mt6660-y := mt6660.o
 snd-soc-nau8315-y := nau8315.o
 snd-soc-nau8325-y := nau8325.o
+snd-soc-nau8310-y := nau8310.o nau8310-dsp.o
 snd-soc-nau8360-y := nau8360.o nau8360-dsp.o
 snd-soc-nau8540-y := nau8540.o
 snd-soc-nau8810-y := nau8810.o
@@ -642,6 +643,7 @@ obj-$(CONFIG_SND_SOC_MT6359_ACCDET) += mt6359-accdet.o
 obj-$(CONFIG_SND_SOC_MT6660)	+= snd-soc-mt6660.o
 obj-$(CONFIG_SND_SOC_NAU8315)   += snd-soc-nau8315.o
 obj-$(CONFIG_SND_SOC_NAU8325)   += snd-soc-nau8325.o
+obj-$(CONFIG_SND_SOC_NAU8310)   += snd-soc-nau8310.o
 obj-$(CONFIG_SND_SOC_NAU8360)   += snd-soc-nau8360.o
 obj-$(CONFIG_SND_SOC_NAU8540)   += snd-soc-nau8540.o
 obj-$(CONFIG_SND_SOC_NAU8810)   += snd-soc-nau8810.o
diff --git a/sound/soc/codecs/nau8310-dsp.c b/sound/soc/codecs/nau8310-dsp.c
new file mode 100644
index 000000000000..7e8606beb208
--- /dev/null
+++ b/sound/soc/codecs/nau8310-dsp.c
@@ -0,0 +1,690 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// The NAU83G10/20 Boosted Mono Class-D Amplifier with DSP and I/V-sense driver.
+//
+// Copyright 2026 Nuvoton Technology Crop.
+// Author: John Hsu <KCHSU0@nuvoton.com>
+//         David Lin <ctlin0@nuvoton.com>
+//         Neo Chang <ylchang2@nuvoton.com>
+
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <sound/soc.h>
+
+#include "nau8310-dsp.h"
+#include "nau8310.h"
+
+#define NAU8310_DSP_IDLE_RETRY 10
+
+static int nau8310_dsp_set_kcs_setup(struct snd_soc_component *component);
+
+#define NAU_DSP_CMD(_id, _msg, _setup, _reply) \
+	[_id] = { \
+		.cmd_id = _id, \
+		.msg_param = _msg, \
+		.setup_data = _setup, \
+		.reply_data = _reply, \
+	}
+
+#define NAU_DSP_CMD_ID(_id) \
+	[_id] = { \
+		.cmd_id = _id, \
+	}
+
+/*
+ * Preamble Fragment Masks:
+ * FIELD           | BITS   | SHIFT | MASK | DETAILS
+ * ----------------|--------|-------|------|---------------------------------
+ * length high     | [31:24]| 24    | 0xff | Upper 8 bits of total length (LEN[9:2])
+ * cmd_id          | [23:18]| 18    | 0x3f | Command identifier (6 bits)
+ * length low      | [17:16]| 16    | 0x03 | Lower 2 bits of total length (LEN[1:0])
+ * preamble magic  | [15:0] | 0     |0xffff| Preamble signature (0xB2A1)
+ */
+#define NAU8310_HOST_LEN_HIGH_MASK	GENMASK(31, 24)
+#define NAU8310_HOST_CMD_ID_MASK	GENMASK(23, 18)
+#define NAU8310_HOST_LEN_LOW_MASK	GENMASK(17, 16)
+#define NAU8310_HOST_PREAMBLE_MASK	GENMASK(15, 0)
+
+/*
+ * Payload Fragment Masks:
+ * FIELD           | BITS   | SHIFT | MASK | DETAILS
+ * ----------------|--------|-------|------|---------------------------------
+ * param_size      | [31:16]| 16    |0xffff| Size of parameter data (16 bits)
+ * param_offset    | [15:0] | 0     |0xffff| Starting offset (16 bits)
+ */
+#define NAU8310_HOST_PARAM_SIZE_MASK	GENMASK(31, 16)
+#define NAU8310_HOST_PARAM_OFFSET_MASK	GENMASK(15, 0)
+
+/*
+ * Trailing Fragment Masks:
+ * FIELD           | BITS   | SHIFT | MASK | DETAILS
+ * ----------------|--------|-------|------|---------------------------------
+ * length high     | [15:14]| 14    | 0x03 | Upper 2 bits of total length
+ * padding         | [13:12]| 12    | 0x03 | Padding bytes count
+ * length low      | [7:0]  | 0     | 0xff | Lower 8 bits of total length
+ * Note: Reassembled length = (length_high << 8) | length_low (Total 10 bits)
+ */
+#define NAU8310_TRAIL_LEN_LOW_MASK	GENMASK(7, 0)
+#define NAU8310_TRAIL_PAD_MASK		GENMASK(13, 12)
+#define NAU8310_TRAIL_LEN_HIGH_MASK	GENMASK(15, 14)
+
+/*
+ * Reply Preamble Masks:
+ * FIELD           | BITS   | SHIFT | MASK | DETAILS
+ * ----------------|--------|-------|------|---------------------------------
+ * length high     | [31:24]| 24    | 0xff | Upper 8 bits of total length
+ * reply_id        | [23:18]| 18    | 0x3f | Reply identifier (6 bits)
+ * length low      | [17:16]| 16    | 0x03 | Lower 2 bits of total length
+ * Note: Reassembled length = (length_high << 2) | length_low (Total 10 bits)
+ */
+#define NAU8310_REPLY_LEN_HIGH_MASK	GENMASK(31, 24)
+#define NAU8310_REPLY_ID_MASK		GENMASK(23, 18)
+#define NAU8310_REPLY_LEN_LOW_MASK	GENMASK(17, 16)
+
+static const struct nau8310_cmd_info nau8310_dsp_cmd_table[] = {
+	/* { cmd_id, msg_param, setup_data, reply_data} */
+	NAU_DSP_CMD(NAU8310_DSP_CMD_GET_COUNTER,      0, 0, 1),
+	NAU_DSP_CMD(NAU8310_DSP_CMD_GET_FRAME_STATUS, 0, 0, 1),
+	NAU_DSP_CMD(NAU8310_DSP_CMD_GET_REVISION,     0, 0, 1),
+	NAU_DSP_CMD(NAU8310_DSP_CMD_GET_KCS_RSLTS,    1, 0, 1),
+	NAU_DSP_CMD(NAU8310_DSP_CMD_GET_KCS_SETUP,    1, 0, 1),
+	NAU_DSP_CMD(NAU8310_DSP_CMD_SET_KCS_SETUP,    1, 1, 0),
+	NAU_DSP_CMD_ID(NAU8310_DSP_CMD_CLK_STOP),
+	NAU_DSP_CMD_ID(NAU8310_DSP_CMD_CLK_RESTART),
+};
+
+static const char *const dsp_cmd_table[] = {
+	[NAU8310_DSP_CMD_GET_COUNTER] = "GET_COUNTER",
+	[NAU8310_DSP_CMD_GET_FRAME_STATUS] = "GET_FRAME_STATUS",
+	[NAU8310_DSP_CMD_GET_REVISION] = "GET_REVISION",
+	[NAU8310_DSP_CMD_GET_KCS_RSLTS] = "GET_KCS_RSLTS",
+	[NAU8310_DSP_CMD_GET_KCS_SETUP] = "GET_KCS_SETUP",
+	[NAU8310_DSP_CMD_SET_KCS_SETUP] = "SET_KCS_SETUP",
+	[NAU8310_DSP_CMD_CLK_STOP] = "CLK_STOP",
+	[NAU8310_DSP_CMD_CLK_RESTART] = "CLK_RESTART",
+};
+
+static void nau8310_sw_reset_chip(struct regmap *regmap)
+{
+	regmap_write(regmap, NAU8310_R01_SOFTWARE_RST, 0x00);
+	regmap_write(regmap, NAU8310_R01_SOFTWARE_RST, 0x00);
+}
+
+static int nau8310_dsp_idle(struct snd_soc_component *cp)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	struct regmap *regmap = nau8310->regmap;
+	unsigned int idle_pattern, timeout = NAU8310_DSP_IDLE_RETRY * USEC_PER_MSEC;
+	int ret = 0;
+
+	ret = regmap_read_poll_timeout(regmap,
+		NAU8310_RF000_DSP_COMM, idle_pattern,
+		idle_pattern == NAU8310_DSP_COMM_IDLE_WORD, USEC_PER_MSEC, timeout);
+	if (ret) {
+		dev_err(nau8310->dev, "Timeout waiting for DSP idle state: %d", ret);
+		nau8310_sw_reset_chip(regmap);
+	}
+
+	return ret;
+}
+
+/*
+ * nau8310_pack_preamble - Pack DSP preamble fragment
+ * @cmd_id: Command ID for the DSP message
+ * @frag_len: Total length of the message fragments
+ *
+ * Return: 32-bit packed payload in Little Endian format.
+ */
+static inline u32 nau8310_pack_preamble(u8 cmd_id, u16 frag_len)
+{
+	return FIELD_PREP(NAU8310_HOST_PREAMBLE_MASK, NAU8310_DSP_COMM_PREAMBLE) |
+		FIELD_PREP(NAU8310_HOST_CMD_ID_MASK, cmd_id) |
+		FIELD_PREP(NAU8310_HOST_LEN_LOW_MASK, frag_len) |
+		FIELD_PREP(NAU8310_HOST_LEN_HIGH_MASK, frag_len >> 2);
+}
+
+/*
+ * nau8310_pack_param - Pack DSP parameter fragment
+ * @param_offset: Starting offset of the parameter data
+ * @param_size: Size of the parameter data in bytes
+ *
+ * Return: 32-bit packed payload in Little Endian format.
+ */
+static inline u32 nau8310_pack_param(u16 param_offset, u16 param_size)
+{
+	return FIELD_PREP(NAU8310_HOST_PARAM_OFFSET_MASK, param_offset) |
+		FIELD_PREP(NAU8310_HOST_PARAM_SIZE_MASK, param_size);
+}
+
+/*
+ * nau8310_pack_trailing - Pack DSP trailing fragment
+ * @frag_cnt: Current fragment count
+ * @padding: Number of padding bytes added to the final data fragment
+ *
+ * Return: 32-bit packed payload in Little Endian format.
+ */
+static inline u32 nau8310_pack_trailing(u16 frag_cnt, u8 padding)
+{
+	return FIELD_PREP(NAU8310_TRAIL_LEN_LOW_MASK, frag_cnt) |
+		FIELD_PREP(NAU8310_TRAIL_PAD_MASK, padding) |
+		FIELD_PREP(NAU8310_TRAIL_LEN_HIGH_MASK, frag_cnt >> 8);
+}
+
+static void nau8310_send_data_payload(struct snd_soc_component *cp,
+	unsigned short dsp_addr, const void *param_data, int param_size,
+	int *frag_cnt, int *padding)
+{
+	const u8 *data = (const u8 *)param_data;
+	u32 payload = 0;
+	int i, data_size = 0;
+
+	for (i = 0; i < param_size; i++) {
+		payload |= data[i] << (data_size * 8);
+		data_size++;
+
+		if (data_size == NAU8310_DSP_DATA_BYTE) {
+			snd_soc_component_write(cp, dsp_addr, payload);
+
+			data_size = 0;
+			payload = 0;
+			(*frag_cnt)++;
+		}
+	}
+
+	if (data_size > 0) {
+		*padding = NAU8310_DSP_DATA_BYTE - data_size;
+		snd_soc_component_write(cp, dsp_addr, payload);
+		(*frag_cnt)++;
+	}
+}
+
+static int nau8310_message_to_dsp(struct snd_soc_component *cp,
+	const struct nau8310_cmd_info *cmd_info, int frag_len,
+	int param_offset, int param_size, void *param_data)
+{
+	unsigned int payload;
+	int ret, padding = 0, frag_cnt = 0;
+
+	ret = nau8310_dsp_idle(cp);
+	if (ret)
+		return ret;
+
+	/* sending preamble fragment */
+	payload = nau8310_pack_preamble(cmd_info->cmd_id, frag_len);
+	snd_soc_component_write(cp, NAU8310_RF000_DSP_COMM, payload);
+
+	if (!cmd_info->msg_param)
+		return 0;
+
+	/* sending payload + padding */
+	payload = nau8310_pack_param(param_offset, param_size);
+	snd_soc_component_write(cp, NAU8310_RF000_DSP_COMM, payload);
+	frag_cnt++;
+
+	if (cmd_info->setup_data)
+		nau8310_send_data_payload(cp, NAU8310_RF000_DSP_COMM, param_data,
+			param_size, &frag_cnt, &padding);
+
+	/* sending trailing fragment */
+	frag_cnt++;
+	payload = nau8310_pack_trailing(frag_cnt, padding);
+	snd_soc_component_write(cp, NAU8310_RF000_DSP_COMM, payload);
+
+	if (frag_cnt != frag_len) {
+		dev_err(cp->dev, "message error (CMD_ID 0x%x, LEN 0x%x) !!!",
+			cmd_info->cmd_id, frag_cnt);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int nau8310_dsp_replied(struct nau8310 *nau8310, int *length)
+{
+	unsigned int reply_preamble;
+	int ret, reply_id;
+
+	ret = regmap_read_poll_timeout(nau8310->regmap,
+		NAU8310_RF000_DSP_COMM, reply_preamble,
+		(reply_preamble & 0xffff) == NAU8310_DSP_COMM_PREAMBLE,
+		USEC_PER_MSEC, NAU8310_DSP_IDLE_RETRY * USEC_PER_MSEC);
+	if (ret) {
+		dev_err(nau8310->dev, "timeout for reply preamble: %d", ret);
+		return ret;
+	}
+
+	*length = FIELD_GET(NAU8310_REPLY_LEN_LOW_MASK, reply_preamble);
+	*length |= FIELD_GET(NAU8310_REPLY_LEN_HIGH_MASK, reply_preamble) << 2;
+	reply_id = FIELD_GET(NAU8310_REPLY_ID_MASK, reply_preamble);
+
+	return (reply_id != NAU8310_DSP_REPLY_OK) ? -reply_id : 0;
+}
+
+static int nau8310_validate_trailing(struct snd_soc_component *cp,
+	int frag_len, int pad_len_exp)
+{
+	int ret, len_pos, pad_len;
+	unsigned int payload;
+	struct device *dev = cp->dev;
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+
+	/* reading trailing fragment */
+	ret = regmap_read(nau8310->regmap, NAU8310_RF000_DSP_COMM, &payload);
+	if (ret) {
+		dev_err(dev, "failed to read trailing fragment");
+		return ret;
+	}
+
+	len_pos = FIELD_GET(NAU8310_TRAIL_LEN_LOW_MASK, payload);
+	len_pos |= FIELD_GET(NAU8310_TRAIL_LEN_HIGH_MASK, payload) << 8;
+
+	if (len_pos != frag_len) {
+		dev_err(dev, "LEN_POST %02X, expect %02X", len_pos, frag_len);
+		return -EPROTO;
+	}
+
+	pad_len = FIELD_GET(NAU8310_TRAIL_PAD_MASK, payload);
+	if (pad_len != pad_len_exp) {
+		dev_err(dev, "PAD_LEN %02X, expect %02X", pad_len, pad_len_exp);
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
+static int nau8310_read_data_payload(struct snd_soc_component *cp,
+	int frag_len, bool msg_param,
+	void *data, int data_size, int *data_count)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	struct device *dev = cp->dev;
+	unsigned int payload;
+	u32 *data_buf = data;
+	int i, j, ret;
+
+	*data_count = (msg_param) ? data_size : 0;
+	for (i = 0; i < frag_len - 1; i++) {
+		ret = regmap_read(nau8310->regmap, NAU8310_RF000_DSP_COMM, &payload);
+		if (ret) {
+			dev_err(dev, "failed to read payload of dsp");
+			return ret;
+		}
+
+		if (!msg_param) {
+			*data_buf++ = payload;
+			break;
+		}
+
+		if (*data_count >= NAU8310_DSP_DATA_BYTE) {
+			*data_buf++ = payload;
+			*data_count -= NAU8310_DSP_DATA_BYTE;
+		} else if (*data_count > 0) {
+			for (j = 0; j < *data_count; j++)
+				((u8 *)data_buf)[j] = (payload >> (j * 8)) & 0xff;
+
+			*data_count = 0;
+		}
+
+		if (*data_count == 0)
+			break;
+	}
+
+	return 0;
+}
+
+static int nau8310_reply_from_dsp(struct snd_soc_component *cp,
+	const struct nau8310_cmd_info *cmd_info, int data_size,
+	void *data)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	struct device *dev = cp->dev;
+	int ret, frag_len, pad_len_exp, data_count = 0;
+
+	ret = nau8310_dsp_replied(nau8310, &frag_len);
+	if (ret)
+		return ret;
+	if (!frag_len || !cmd_info->reply_data)
+		return 0;
+	if (!data || frag_len == 1)
+		return -EINVAL;
+
+	ret = nau8310_read_data_payload(cp, frag_len,
+		cmd_info->msg_param, data, data_size, &data_count);
+	if (ret)
+		return ret;
+
+	/* check the reply length same as request */
+	if (data_count && (cmd_info->cmd_id == NAU8310_DSP_CMD_GET_KCS_RSLTS ||
+		cmd_info->cmd_id == NAU8310_DSP_CMD_GET_KCS_SETUP))
+		dev_warn(dev, "payload_len %d, expected %d",
+			data_size - data_count, data_size);
+
+	pad_len_exp = cmd_info->msg_param ?
+		(frag_len - 1) * NAU8310_DSP_DATA_BYTE - (data_size - data_count) : 0;
+	return nau8310_validate_trailing(cp, frag_len, pad_len_exp);
+}
+
+/*
+ * nau8310_send_dsp_command - Send command to DSP
+ *
+ * @cp:  component to register
+ * @cmd_id:  DSP supported command ID
+ * @kcs_setup: KCS setup structure
+ *
+ * The communication protocol is a Master-Slave type protocol
+ * where the host processor is the master and DSP is the slave.
+ * The Master initiates the communication and can either write or
+ * read back from the slave.
+ * Transactions from the Master are called "Messages",
+ * and read-back data from the Slave is called a "Reply".
+ *
+ * The function sends command to DSP according to the command ID.
+ * These commands include getting the information of DSP,
+ * getting or setting KCS configuration, or making DSP control.
+ */
+static int nau8310_send_dsp_command(struct snd_soc_component *cp, int cmd_id,
+	struct nau8310_kcs_setup *kcs_setup)
+{
+	const struct nau8310_cmd_info *cmd_info;
+	int ret = 0, frag_len = 0;
+
+	cmd_info = &nau8310_dsp_cmd_table[cmd_id];
+	if ((cmd_info->msg_param && !kcs_setup->set_len) ||
+		(cmd_info->setup_data && !kcs_setup->set_kcs_data) ||
+		(cmd_info->reply_data && !kcs_setup->get_data))
+		return -EFAULT;
+
+	/* Read up to 1kB data because the LEN field to request data is 10-bits
+	 * long; and not beyond 3kB offset.
+	 */
+	if (cmd_id == NAU8310_DSP_CMD_GET_KCS_SETUP &&
+		(kcs_setup->set_len > NAU8310_DSP_KCS_DAT_LEN_MAX ||
+		kcs_setup->set_kcs_offset > NAU8310_DSP_KCS_OFFSET_MAX))
+		return -ERANGE;
+
+	/* one fragment for offset and size parameters
+	 * one fragment for a postamble fragment
+	 */
+	if (cmd_info->msg_param)
+		frag_len += 2;
+
+	/* fragments for KCS setup writen */
+	if (cmd_info->setup_data)
+		frag_len += DIV_ROUND_UP(kcs_setup->set_len, NAU8310_DSP_DATA_BYTE);
+
+	ret = nau8310_message_to_dsp(cp, cmd_info, frag_len,
+		kcs_setup->set_kcs_offset, kcs_setup->set_len,
+		kcs_setup->set_kcs_data);
+	if (ret)
+		return ret;
+
+	return nau8310_reply_from_dsp(cp, cmd_info, kcs_setup->get_len,
+		kcs_setup->get_data);
+}
+
+static inline int nau8310_dsp_exec_command(struct snd_soc_component *cp, int cmd_id,
+	int offset, int set_len, void *set_data, int get_len, void *get_data)
+{
+	struct nau8310_kcs_setup kcs_setup = {
+		.set_kcs_offset = offset,
+		.set_len = set_len,
+		.set_kcs_data = set_data,
+		.get_len = get_len,
+		.get_data = get_data,
+	};
+
+	return nau8310_send_dsp_command(cp, cmd_id, &kcs_setup);
+}
+
+/*
+ * nau8310_dsp_kcs_setup - Send KCS setup command to DSP
+ *
+ * @cp:  component to register
+ * @offset: address offset relative to KCS start
+ * @size: size of data writen to KCS
+ * @data: data writen to KCS setup
+ *
+ * The function sends KCS setup command to DSP for
+ * setting KCS configuration. The maximum size that you can transfer into
+ * the DSP is 96 bytes. Therefore, the driver has to split the data into
+ * 96 bytes chucks, if the setup configuration over the threshold.
+ */
+static int nau8310_dsp_kcs_setup(struct snd_soc_component *cp, int offset, int size,
+	const void *data)
+{
+	u8 *data_buf = (u8 *)data;
+	unsigned int kcs_rst;
+	int retries = 0, ret, data_len, data_rem, addr_offset;
+
+	/* Limit full load of KCS_SETUP data and not beyond 3kB offset. */
+	if (!data || size > NAU8310_DSP_KCS_DAT_LEN_MAX ||
+		offset > NAU8310_DSP_KCS_OFFSET_MAX)
+		return -EINVAL;
+
+	/* sending fragments for KCS setup */
+	addr_offset = offset;
+	data_rem = size;
+
+	while (data_rem) {
+		data_len = min(data_rem, NAU8310_DSP_KCS_TX_MAX);
+
+		ret = nau8310_dsp_exec_command(cp, NAU8310_DSP_CMD_SET_KCS_SETUP,
+			addr_offset, data_len, (void *)data_buf, 0, &kcs_rst);
+		if (ret) {
+			if (retries++ < NAU8310_DSP_RETRY_MAX)
+				continue;
+			return ret;
+		}
+
+		data_buf += (u8)data_len;
+		addr_offset += data_len;
+		data_rem -= data_len;
+
+		/* checking KCS result */
+		ret = nau8310_dsp_exec_command(cp, NAU8310_DSP_CMD_GET_KCS_RSLTS,
+			0, NAU8310_DSP_DATA_BYTE, NULL, NAU8310_DSP_DATA_BYTE, &kcs_rst);
+		if (ret)
+			return ret;
+		if (kcs_rst != NAU8310_DSP_KCS_RSLTS_SUCCESS)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8310_dsp_snd_soc_dapm_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	unsigned int mask = (1 << fls(mc->max)) - 1;
+	unsigned int val;
+	int ret;
+
+	if (snd_soc_dapm_get_bias_level(dapm) > SND_SOC_BIAS_STANDBY) {
+		dev_warn_ratelimited(nau8310->dev, "changing path is not allowed during playback");
+		return -EBUSY;
+	}
+
+	val = (ucontrol->value.integer.value[0] & mask);
+
+	mutex_lock(&nau8310->lock);
+	if (val == NAU8310_DAC_SRC_DSP && !nau8310->load_fw_done) {
+		dev_warn_ratelimited(nau8310->dev, "Cannot enable DSP: Firmware not ready or disabled");
+		mutex_unlock(&nau8310->lock);
+		return -EBUSY;
+	}
+
+	ret = snd_soc_dapm_put_volsw(kcontrol, ucontrol);
+
+	if (val == NAU8310_DAC_SRC_BYPASS) {
+		/* Switch the clock source of DSP to MCLK. */
+		regmap_update_bits(nau8310->regmap, NAU8310_R04_ENA_CTRL,
+			NAU8310_DSP_SEL_OSC, 0);
+	}
+	mutex_unlock(&nau8310->lock);
+
+	return ret;
+}
+
+#define NAU8310_DSP_SOC_DAPM_SINGLE(xname, reg, shift, mask, invert) \
+	SOC_SINGLE_EXT(xname, reg, shift, mask, invert, \
+		snd_soc_dapm_get_volsw, nau8310_dsp_snd_soc_dapm_put)
+
+static const struct snd_kcontrol_new nau8310_dacdat_select_dsp =
+	NAU8310_DSP_SOC_DAPM_SINGLE("Switch", NAU8310_R1A_DSP_CORE_CTRL2,
+		NAU8310_DAC_SEL_DSP_SFT, 1, 0);
+
+static int nau8310_dsp_clock_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(w->dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	int ret = 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		ret = nau8310_dsp_exec_command(cp, NAU8310_DSP_CMD_CLK_RESTART,
+			0, 0, NULL, 0, NULL);
+		if (ret)
+			dev_err(cp->dev, "Send DSP command %s fail (%d)",
+				dsp_cmd_table[NAU8310_DSP_CMD_CLK_RESTART], ret);
+
+		/* Switch the clock source of DSP to MCLK. */
+		regmap_update_bits(nau8310->regmap, NAU8310_R04_ENA_CTRL,
+			NAU8310_DSP_SEL_OSC, 0);
+	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
+		ret = nau8310_dsp_exec_command(cp, NAU8310_DSP_CMD_CLK_STOP,
+			0, 0, NULL, 0, NULL);
+		if (ret)
+			dev_err(cp->dev, "Send DSP command %s fail (%d)",
+				dsp_cmd_table[NAU8310_DSP_CMD_CLK_STOP], ret);
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_dapm_widget nau8310_dsp_dapm_widgets[] = {
+	SND_SOC_DAPM_PGA("DSP", SND_SOC_NOPM, 0, 0, NULL, 0),
+	SND_SOC_DAPM_SWITCH("DAC data from DSP", SND_SOC_NOPM,
+		0, 0, &nau8310_dacdat_select_dsp),
+	SND_SOC_DAPM_SUPPLY("DSP Clock", SND_SOC_NOPM, 0, 0,
+		nau8310_dsp_clock_event, SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+};
+
+static const struct snd_soc_dapm_route nau8310_dsp_dapm_routes[] = {
+	{ "DSP", NULL, "Capture Sense" },
+	{ "DAC data from DSP", "Switch", "DSP" },
+	{ "DAC", NULL, "DAC data from DSP" },
+	{ "DSP", NULL, "DSP Clock" },
+};
+
+static int nau8310_dsp_set_kcs_setup(struct snd_soc_component *cp)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	struct regmap *regmap = nau8310->regmap;
+	struct nau8310_kcs_setup kcs_setup_comp, *kcs_setup = &kcs_setup_comp;
+	struct device *dev = cp->dev;
+	const struct firmware *fw;
+	int ret, status = 0, buf_off, buf_len;
+
+	dev_dbg(dev, "Send DSP command %s",
+		dsp_cmd_table[NAU8310_DSP_CMD_GET_FRAME_STATUS]);
+
+	kcs_setup->get_len = kcs_setup->set_len = sizeof(status);
+	kcs_setup->get_data = (void *)&status;
+
+	ret = nau8310_send_dsp_command(cp, NAU8310_DSP_CMD_GET_FRAME_STATUS, kcs_setup);
+	if (ret) {
+		dev_err(dev, "Send DSP command %s fail (%d)",
+			dsp_cmd_table[NAU8310_DSP_CMD_GET_FRAME_STATUS], ret);
+		goto err;
+	}
+
+	if (!(status & NAU8310_DSP_ALGO_OK)) {
+		dev_err(dev, "Algorithm of DSP is not ready, status %x", status);
+		ret = -EIO;
+		goto err;
+	}
+
+	dev_info(dev, "Algorithm of DSP is ready, status %x", status);
+
+	dev_dbg(dev, "Request firmware and wait until finish.");
+	ret = request_firmware(&fw, NAU8310_DSP_FIRMWARE, dev);
+	if (ret) {
+		dev_err(dev, "Failed to load firmware (%d)", ret);
+		goto err;
+	}
+
+	buf_off = 0;
+	buf_len = nau8310->kcs_setup_size = fw->size;
+	dev_dbg(dev, "Send DSP command %s (OFF %d, LEN %d)",
+		dsp_cmd_table[NAU8310_DSP_CMD_SET_KCS_SETUP], buf_off, buf_len);
+	ret = nau8310_dsp_kcs_setup(cp, buf_off, buf_len, fw->data);
+	if (ret) {
+		dev_err(dev, "Send DSP command %s fail (%d)",
+			dsp_cmd_table[NAU8310_DSP_CMD_SET_KCS_SETUP], ret);
+		goto err_loaded;
+	}
+
+	release_firmware(fw);
+	nau8310->load_fw_done = true;
+
+	return 0;
+
+err_loaded:
+	regmap_update_bits(regmap, NAU8310_R13_MUTE_CTRL, NAU8310_SOFT_MUTE, 0);
+	if (fw)
+		release_firmware(fw);
+err:
+	nau8310->load_fw_done = false;
+	return ret;
+}
+
+int nau8310_dsp_init(struct snd_soc_component *cp)
+{
+	struct regmap *regmap = cp->regmap;
+
+	nau8310_sw_reset_chip(regmap);
+
+	/* wait for the power ready */
+	msleep(120);
+
+	regmap_update_bits(regmap, NAU8310_R1A_DSP_CORE_CTRL2,
+		NAU8310_DSP_RUNSTALL | NAU8310_DAC_SEL_DSP_OUT, NAU8310_DAC_SEL_DSP_OUT);
+
+	return nau8310_dsp_set_kcs_setup(cp);
+}
+
+int nau8310_dsp_setup_controls(struct snd_soc_component *cp)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	struct snd_soc_dapm_context *dapm = nau8310->dapm;
+	int ret;
+
+	ret = snd_soc_dapm_new_controls(dapm, nau8310_dsp_dapm_widgets,
+		ARRAY_SIZE(nau8310_dsp_dapm_widgets));
+	if (ret) {
+		dev_err(cp->dev, "Add DSP widget fail (%d)", ret);
+		goto err;
+	}
+
+	ret = snd_soc_dapm_add_routes(dapm, nau8310_dsp_dapm_routes,
+		ARRAY_SIZE(nau8310_dsp_dapm_routes));
+	if (ret) {
+		dev_err(cp->dev, "Add DSP route fail (%d)", ret);
+		goto err;
+	}
+
+	return 0;
+err:
+	snd_soc_dapm_del_routes(dapm, nau8310_dsp_dapm_routes,
+		ARRAY_SIZE(nau8310_dsp_dapm_routes));
+	return ret;
+}
diff --git a/sound/soc/codecs/nau8310-dsp.h b/sound/soc/codecs/nau8310-dsp.h
new file mode 100644
index 000000000000..a8301b9df8cb
--- /dev/null
+++ b/sound/soc/codecs/nau8310-dsp.h
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// The NAU83G10/20 Boosted Mono Class-D Amplifier with DSP and I/V-sense driver.
+//
+// Copyright 2026 Nuvoton Technology Crop.
+// Author: John Hsu <KCHSU0@nuvoton.com>
+//         David Lin <ctlin0@nuvoton.com>
+//         Neo Chang <ylchang2@nuvoton.com>
+
+#ifndef __NAU8310_DSP_H__
+#define __NAU8310_DSP_H__
+
+#define NAU8310_DSP_COMM_IDLE_WORD		0xf4f3f2f1
+#define NAU8310_DSP_COMM_PREAMBLE		0xb2a1
+#define NAU8310_DSP_DATA_BYTE			4
+#define NAU8310_DSP_DATA_LEN			(NAU8310_DSP_DATA_BYTE << 3)
+/* max bytes of data to transfer into DSP each time during the KCS setup */
+#define NAU8310_DSP_KCS_TX_MAX			96
+#define NAU8310_DSP_RETRY_MAX			3
+#define NAU8310_DSP_KCS_DAT_LEN_BITS		10
+#define NAU8310_DSP_KCS_DAT_LEN_MAX		((1 << NAU8310_DSP_KCS_DAT_LEN_BITS) - 1)
+#define NAU8310_DSP_KCS_OFFSET_MAX		3072
+#define NAU8310_DSP_KCS_RSLTS_SUCCESS		0x10
+
+/* FRAME_STATUS (0x9) */
+#define NAU8310_DSP_SNS_OVF_SFT			31
+#define NAU8310_DSP_SNS_OVF			(0x1 << NAU8310_DSP_SNS_OVF_SFT)
+#define NAU8310_DSP_AUD_UVF_SFT			30
+#define NAU8310_DSP_AUD_UVF			(0x1 << NAU8310_DSP_AUD_UVF_SFT)
+#define NAU8310_DSP_AUD_OVF_SFT			29
+#define NAU8310_DSP_AUD_OVF			(0x1 << NAU8310_DSP_AUD_OVF_SFT)
+#define NAU8310_DSP_ALC_STS_SFT			28
+#define NAU8310_DSP_ALC_STS			(0x1 << NAU8310_DSP_ALC_STS_SFT)
+#define NAU8310_DSP_CLK_STOP_SFT		25
+#define NAU8310_DSP_CLK_STOP			(0x1 << NAU8310_DSP_CLK_STOP_SFT)
+#define NAU8310_DSP_OCP_OTP_SFT			24
+#define NAU8310_DSP_OCP_OTP			(0x1 << NAU8310_DSP_OCP_OTP_SFT)
+#define NAU8310_DSP_UVLO_SFT			22
+#define NAU8310_DSP_UVLO			(0x1 << NAU8310_DSP_UVLO_SFT)
+#define NAU8310_DSP_OVP_SFT			21
+#define NAU8310_DSP_OVP				(0x1 << NAU8310_DSP_OVP_SFT)
+#define NAU8310_DSP_APWR_DWN_SFT		20
+#define NAU8310_DSP_APWR_DWN			(0x1 << NAU8310_DSP_APWR_DWN_SFT)
+#define NAU8310_DSP_SNSR_RATE_SFT		12
+#define NAU8310_DSP_SNSR_RATE_MASK		(0xff << NAU8310_DSP_SNSR_RATE_SFT)
+#define NAU8310_DSP_AUD_RATE_SFT		4
+#define NAU8310_DSP_AUD_RATE_MASK		(0xff << NAU8310_DSP_AUD_RATE_SFT)
+#define NAU8310_DSP_FEED_TRU_SFT		1
+#define NAU8310_DSP_FEED_TRU			(0x1 << NAU8310_DSP_FEED_TRU_SFT)
+#define NAU8310_DSP_ALGO_OK			0x1
+
+#define NAU8310_DSP_FIRMDIR				"Nuvoton/"
+#define NAU8310_DSP_FIRMWARE			NAU8310_DSP_FIRMDIR"NAU83G10.kcs.bin"
+#define NAU8310_DSP_FWHDR_SIZE			8
+#define NAU8310_DSP_FWHDR_SIREV			4
+#define NAU8310_DSP_FW_KCS_DATA			NAU8310_DSP_FWHDR_SIZE
+
+enum {
+	NAU8310_DSP_REPLY_OK,
+	NAU8310_DSP_REPLY_MSG_INTEGRETY_ERR,
+	NAU8310_DSP_REPLY_EXECUTION_ERR,
+	NAU8310_DSP_REPLY_COMMAND_DOESNT_EXISTS_ERR,
+	NAU8310_DSP_REPLY_UNKNOWN_ERR,
+	NAU8310_DSP_REPLY_MSG_TOO_LONG,
+};
+
+enum {
+	NAU8310_DSP_CMD_GET_COUNTER		= 0x1,
+	NAU8310_DSP_CMD_GET_FRAME_STATUS	= 0x9,
+	NAU8310_DSP_CMD_GET_REVISION		= 0xa,
+	NAU8310_DSP_CMD_GET_KCS_RSLTS		= 0x4,
+	NAU8310_DSP_CMD_GET_KCS_SETUP		= 0x6,
+	NAU8310_DSP_CMD_SET_KCS_SETUP		= 0x7,
+	NAU8310_DSP_CMD_CLK_STOP		= 0xb,
+	NAU8310_DSP_CMD_CLK_RESTART		= 0xc,
+};
+
+/**
+ * struct nau8310_cmd_info - DSP command information structure
+ * @cmd_id:     The command identification number
+ * @msg_param:  Message parameters including offset, size, and data
+ * @setup_data: Setup data for write-only operations
+ * @reply_data: Reply data received from the DSP
+ */
+struct nau8310_cmd_info {
+	int cmd_id;
+	bool msg_param;
+	bool setup_data;
+	bool reply_data;
+};
+
+/**
+ * struct nau8310_kcs_setup - KCS setup configuration structure
+ * @set_len:        Length of data written in bytes
+ * @set_kcs_offset: Address offset relative to the start of KCS
+ * @set_kcs_data:   Pointer to the data written to KCS
+ * @get_len:        Length of data from the reply in bytes
+ * @get_data:       Pointer to the buffer for reply data
+ */
+struct nau8310_kcs_setup {
+	int set_len;
+	int set_kcs_offset;
+	void *set_kcs_data;
+	int get_len;
+	void *get_data;
+};
+
+int nau8310_dsp_init(struct snd_soc_component *component);
+int nau8310_dsp_setup_controls(struct snd_soc_component *component);
+
+#endif /* __NAU8310_DSP_H__ */
diff --git a/sound/soc/codecs/nau8310.c b/sound/soc/codecs/nau8310.c
new file mode 100644
index 000000000000..b4de2de33768
--- /dev/null
+++ b/sound/soc/codecs/nau8310.c
@@ -0,0 +1,1845 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// The NAU83G10/20 Boosted Mono Class-D Amplifier with DSP and I/V-sense driver.
+//
+// Copyright 2026 Nuvoton Technology Crop.
+// Author: John Hsu <KCHSU0@nuvoton.com>
+//         David Lin <ctlin0@nuvoton.com>
+//         Neo Chang <ylchang2@nuvoton.com>
+
+#include <linux/unaligned.h>
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "nau8310-dsp.h"
+#include "nau8310.h"
+
+/* Range of Master Clock MCLK (Hz) */
+#define MASTER_CLK_MIN 2048000
+#define MASTER_CLK_MAX 49152000
+/* DSP Clock (Hz) */
+#define DSP_CLK_MIN_MULTI_VALUE 2000
+#define DSP_CLK_MAX 102400000
+#define DSP_MCLK_HI_SPEED 12288000
+
+#define NAU8310_DEFAULT_SAMPLE_RATE 48000
+#define NAU8310_SYSCLK_MULT 256
+
+static const unsigned int nau8310_tx_slot_map[NAU8310_TDM_MAX_SLOTS] = {
+	NAU8310_ADC_V_SEL_SLOT0,
+	NAU8310_ADC_I_SEL_SLOT1,
+	NAU8310_ADC_V_SEL_SLOT2,
+	NAU8310_ADC_I_SEL_SLOT3,
+	NAU8310_ADC_V_SEL_SLOT4,
+	NAU8310_ADC_I_SEL_SLOT5,
+	NAU8310_ADC_V_SEL_SLOT6,
+	NAU8310_ADC_I_SEL_SLOT7
+};
+
+static const unsigned int nau8310_rx_slot_map[NAU8310_TDM_MAX_SLOTS] = {
+	NAU8310_DAC_SEL_SLOT0,
+	NAU8310_DAC_SEL_SLOT1,
+	NAU8310_DAC_SEL_SLOT2,
+	NAU8310_DAC_SEL_SLOT3,
+	NAU8310_DAC_SEL_SLOT4,
+	NAU8310_DAC_SEL_SLOT5,
+	NAU8310_DAC_SEL_SLOT6,
+	NAU8310_DAC_SEL_SLOT7,
+};
+
+static const struct nau8310_src_attr dsp_src_mult[] = {
+	/* param : power of 2 */
+	{ 0, 0x3 },
+	{ 1, 0x2 },
+	{ 2, 0x1 },
+	{ 3, 0x0 },
+	{ 4, 0x4 },
+};
+
+/* scaling for MCLK source */
+#define CLK_PROC_BYPASS (-1)
+
+static const struct nau8310_src_attr mclk_n1_div[] = {
+	{ 3, 0x2 },
+	{ 1, 0x0 },
+	{ 2, 0x1 },
+};
+
+static const struct nau8310_src_attr mclk_n2_div[] = {
+	/* param : power of 2 */
+	{ 0, 0x0 },
+	{ 1, 0x1 },
+	{ 2, 0x2 },
+	{ 3, 0x3 },
+};
+
+static const struct nau8310_src_attr mclk_src_mult[] = {
+	/* param : power of 2 */
+	{ 0, 0x1 },
+	{ 1, 0x2 },
+	{ 2, 0x3 },
+	{ 3, 0x4 },
+	{ 4, 0x5 },
+};
+
+/* Sample Rate and MCLK_SRC selections */
+static const struct nau8310_srate_attr target_srate_table[] = {
+	/* { FS, range, max, { MCLK source }, adc_div} */
+	{ 48000, 2, true, { 12288000, 19200000, 24000000 }, 0x1 },
+	{ 16000, 1, false, { 4096000, 6400000, 8000000 }, 0x0 },
+	{ 8000, 0, false, { 2048000, 3200000, 4000000 }, 0x0 },
+	{ 44100, 2, true, { 11289600, 17640000, 22050000 }, 0x1 },
+	{ 64000, 3, false, { 16384000, 25600000, 32000000 }, 0x1 },
+	{ 96000, 3, true, { 24576000, 38400000, 48000000 }, (-1) },
+	{ 12000, 0, true, { 3072000, 4800000, 6000000 }, 0x0 },
+	{ 24000, 1, true, { 6144000, 9600000, 12000000 }, 0x2 },
+	{ 32000, 2, false, { 8192000, 12800000, 16000000 }, 0x2 },
+};
+
+/* the maximum frequency of CLK_ADC and CLK_DAC */
+#define CLK_DA_AD_MAX 6144000
+
+/* over sampling rate */
+static const struct nau8310_osr_attr osr_dac_sel[] = {
+	{ 64, 2 },		/* OSR 64, SRC 1/4 */
+	{ 256, 0 },		/* OSR 256, SRC 1 */
+	{ 128, 1 },		/* OSR 128, SRC 1/2 */
+	{ 0, 0 },
+	{ 32, 3 },		/* OSR 32, SRC 1/8 */
+};
+
+static const struct nau8310_osr_attr osr_adc_sel[] = {
+	{ 32, 2 },		/* OSR 32, SRC 1/8 */
+	{ 64, 1 },		/* OSR 64, SRC 1/4 */
+	{ 128, 0 },		/* OSR 128, SRC 1/2 */
+};
+
+/* For a typical 48kHz frame sync I2S signal on DSP case, the ADC sampling rate
+ * must be 12kHz. So the specfied OSR to SRC divider is need to divide by 4.
+ */
+static const struct nau8310_osr_attr osr_adc_dsp_sel[] = {
+	{ 0, 0 },		/* no such case */
+	{ 64, 3 },		/* OSR 64, SRC 1/16 */
+	{ 128, 2 },		/* OSR 128, SRC 1/8 */
+};
+
+static const struct reg_default nau8310_reg_defaults[] = {
+	{ NAU8310_R02_I2C_ADDR, 0x0000 },
+	{ NAU8310_R03_CLK_CTRL, 0x0000 },
+	{ NAU8310_R04_ENA_CTRL, 0x0000 },
+	{ NAU8310_R05_INTERRUPT_CTRL, 0x007f },
+	{ NAU8310_R06_INT_CLR_STATUS, 0x0000 },
+	{ NAU8310_R07_SAR_CTRL1, 0x00b4 },
+	{ NAU8310_R08_GPIO124_CTRL, 0x0102 },
+	{ NAU8310_R09_GPIOOUT, 0x0000 },
+	{ NAU8310_R0A_IO_CTRL, 0x0000 },
+	{ NAU8310_R0B_I2S_PCM_CTRL0, 0x0000 },
+	{ NAU8310_R0C_TDM_CTRL, 0x0c00 },
+	{ NAU8310_R0D_I2S_PCM_CTRL1, 0x000a },
+	{ NAU8310_R0E_I2S_PCM_CTRL2, 0x8010 },
+	{ NAU8310_R0F_LEFT_TIME_SLOT, 0x0000 },
+	{ NAU8310_R10_RIGHT_TIME_SLOT, 0x0000 },
+	{ NAU8310_R12_HPF_CTRL, 0x0010 },
+	{ NAU8310_R13_MUTE_CTRL, 0x00cf },
+	{ NAU8310_R14_ADC_VOL_CTRL, 0x0000 },
+	{ NAU8310_R15_INT_COE, 0xa41f },
+	{ NAU8310_R16_DEC_COE, 0xb7cd },
+	{ NAU8310_R17_BOOST_CTRL1, 0x3f00 },
+	{ NAU8310_R18_BOOST_CTRL2, 0x0000 },
+	{ NAU8310_R19_DSP_CORE_CTRL1, 0x0000 },
+	{ NAU8310_R1A_DSP_CORE_CTRL2, 0x0000 },
+	{ NAU8310_R28_ADC_RATE, 0x0002 },
+	{ NAU8310_R29_DAC_CTRL1, 0x0081 },
+	{ NAU8310_R2A_DAC_CTRL2, 0x0000 },
+	{ NAU8310_R2C_ALC_CTRL1, 0x2000 },
+	{ NAU8310_R2D_ALC_CTRL2, 0x8400 },
+	{ NAU8310_R2E_ALC_CTRL3, 0x0000 },
+	{ NAU8310_R2F_ALC_CTRL4, 0x00bf },
+	{ NAU8310_R30_TEMP_COMP_CTRL, 0x7df4 },
+	{ NAU8310_R31_UVLO_CTRL0, 0x0000 },
+	{ NAU8310_R32_UVLO_CTRL1, 0x0000 },
+	{ NAU8310_R33_LPF_CTRL, 0x7380 },
+	{ NAU8310_R40_CLK_DET_CTRL, 0xa801 },
+	{ NAU8310_R55_MISC_CTRL, 0x0000 },
+	{ NAU8310_R60_BIAS_ADJ, 0x0000 },
+	{ NAU8310_R61_ANALOG_CONTROL_1, 0x0000 },
+	{ NAU8310_R62_ANALOG_CONTROL_2, 0x0000 },
+	{ NAU8310_R63_ANALOG_CONTROL_3, 0x0000 },
+	{ NAU8310_R64_ANALOG_CONTROL_4, 0x0000 },
+	{ NAU8310_R65_ANALOG_CONTROL_5, 0x0000 },
+	{ NAU8310_R66_ANALOG_CONTROL_6, 0x0000 },
+	{ NAU8310_R68_ANALOG_CONTROL_7, 0x0000 },
+	{ NAU8310_R69_CLIP_CTRL, 0x0000 },
+	{ NAU8310_R6B_ANALOG_CONTROL_8, 0x0000 },
+	{ NAU8310_R6C_ANALOG_CONTROL_9, 0x0000 },
+	{ NAU8310_R71_ANALOG_ADC_1, 0x0011 },
+	{ NAU8310_R72_ANALOG_ADC_2, 0x0020 },
+	{ NAU8310_R73_RDAC, 0x0008 },
+	{ NAU8310_R76_BOOST, 0x0000 },
+	{ NAU8310_R77_FEPGA, 0x0000 },
+	{ NAU8310_R7F_POWER_UP_CONTROL, 0x0000 },
+	{ NAU8310_R80_BIQ0_COE_1, 0x0800 },
+	{ NAU8310_R81_BIQ0_COE_2, 0x0000 },
+	{ NAU8310_R82_BIQ0_COE_3, 0x0000 },
+	{ NAU8310_R83_BIQ0_COE_4, 0x0000 },
+	{ NAU8310_R84_BIQ0_COE_5, 0x0000 },
+	{ NAU8310_R85_BIQ0_COE_6, 0x0000 },
+	{ NAU8310_R86_BIQ0_COE_7, 0x0000 },
+	{ NAU8310_R87_BIQ0_COE_8, 0x0000 },
+	{ NAU8310_R88_BIQ0_COE_9, 0x0000 },
+	{ NAU8310_R89_BIQ0_COE_10, 0x0000 },
+	{ NAU8310_R8A_BIQ1_COE_1, 0x0000 },
+	{ NAU8310_R8B_BIQ1_COE_2, 0x0000 },
+	{ NAU8310_R8C_BIQ1_COE_3, 0x0000 },
+	{ NAU8310_R8D_BIQ1_COE_4, 0x0000 },
+	{ NAU8310_R8E_BIQ1_COE_5, 0x0000 },
+	{ NAU8310_R8F_BIQ1_COE_6, 0x0000 },
+	{ NAU8310_R90_BIQ1_COE_7, 0x0000 },
+	{ NAU8310_R91_BIQ1_COE_8, 0x0000 },
+	{ NAU8310_R92_BIQ1_COE_9, 0x0000 },
+	{ NAU8310_R93_BIQ1_COE_10, 0x0000 },
+	{ NAU8310_R94_BIQ2_COE_1, 0x0000 },
+	{ NAU8310_R95_BIQ2_COE_2, 0x0000 },
+	{ NAU8310_R96_BIQ2_COE_3, 0x0000 },
+	{ NAU8310_R97_BIQ2_COE_4, 0x0000 },
+	{ NAU8310_R98_BIQ2_COE_5, 0x0000 },
+	{ NAU8310_R99_BIQ2_COE_6, 0x0000 },
+	{ NAU8310_R9A_BIQ2_COE_7, 0x0000 },
+	{ NAU8310_R9B_BIQ2_COE_8, 0x0000 },
+	{ NAU8310_R9C_BIQ2_COE_9, 0x0000 },
+	{ NAU8310_R9D_BIQ2_COE_10, 0x0000 },
+	{ NAU8310_RF000_DSP_COMM, 0x0000 },
+};
+
+static bool nau8310_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8310_R03_CLK_CTRL ... NAU8310_R10_RIGHT_TIME_SLOT:
+	case NAU8310_R12_HPF_CTRL ... NAU8310_R2A_DAC_CTRL2:
+	case NAU8310_R2C_ALC_CTRL1 ... NAU8310_R33_LPF_CTRL:
+	case NAU8310_R40_CLK_DET_CTRL:
+	case NAU8310_R46_I2C_DEVICE_ID:
+	case NAU8310_R4A_ANALOG_READ:
+	case NAU8310_R55_MISC_CTRL:
+	case NAU8310_R60_BIAS_ADJ ... NAU8310_R66_ANALOG_CONTROL_6:
+	case NAU8310_R68_ANALOG_CONTROL_7 ... NAU8310_R69_CLIP_CTRL:
+	case NAU8310_R6B_ANALOG_CONTROL_8 ... NAU8310_R6C_ANALOG_CONTROL_9:
+	case NAU8310_R71_ANALOG_ADC_1 ... NAU8310_R73_RDAC:
+	case NAU8310_R76_BOOST ... NAU8310_R77_FEPGA:
+	case NAU8310_R7F_POWER_UP_CONTROL ... NAU8310_R9D_BIQ2_COE_10:
+	case NAU8310_RF000_DSP_COMM:
+		return true;
+	default:
+		return false;
+	}
+
+}
+
+static bool nau8310_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8310_R00_HARDWARE_RST ... NAU8310_R10_RIGHT_TIME_SLOT:
+	case NAU8310_R12_HPF_CTRL ... NAU8310_R1A_DSP_CORE_CTRL2:
+	case NAU8310_R28_ADC_RATE ... NAU8310_R2A_DAC_CTRL2:
+	case NAU8310_R2C_ALC_CTRL1 ... NAU8310_R33_LPF_CTRL:
+	case NAU8310_R40_CLK_DET_CTRL:
+	case NAU8310_R55_MISC_CTRL:
+	case NAU8310_R60_BIAS_ADJ ... NAU8310_R66_ANALOG_CONTROL_6:
+	case NAU8310_R68_ANALOG_CONTROL_7 ... NAU8310_R69_CLIP_CTRL:
+	case NAU8310_R6B_ANALOG_CONTROL_8 ... NAU8310_R6C_ANALOG_CONTROL_9:
+	case NAU8310_R71_ANALOG_ADC_1 ... NAU8310_R73_RDAC:
+	case NAU8310_R76_BOOST ... NAU8310_R77_FEPGA:
+	case NAU8310_R7F_POWER_UP_CONTROL ... NAU8310_R9D_BIQ2_COE_10:
+	case NAU8310_RF000_DSP_COMM:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool nau8310_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case NAU8310_R00_HARDWARE_RST ... NAU8310_R01_SOFTWARE_RST:
+	case NAU8310_R06_INT_CLR_STATUS:
+	case NAU8310_R1B_CLK_DOUBLER_O ... NAU8310_R27_DSP_STATUS_2:
+	case NAU8310_R46_I2C_DEVICE_ID:
+	case NAU8310_R4A_ANALOG_READ:
+	case NAU8310_RF000_DSP_COMM:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int nau8310_clkdet_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_mixer_control *mc =
+		(struct soc_mixer_control *)kcontrol->private_value;
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8310->regmap;
+	unsigned int max = mc->max, min = mc->min, val;
+	unsigned int mask = (1 << fls(max)) - 1;
+
+	val = ((ucontrol->value.integer.value[0] + min) & mask);
+
+	if (nau8310->clock_detection == val)
+		return 0;
+
+	nau8310->clock_detection = val;
+
+	if (nau8310->clock_detection)
+		regmap_update_bits(regmap, NAU8310_R40_CLK_DET_CTRL,
+			NAU8310_CLKPWRUP_DIS, 0);
+	else
+		regmap_update_bits(regmap, NAU8310_R40_CLK_DET_CTRL,
+			NAU8310_CLKPWRUP_DIS, NAU8310_CLKPWRUP_DIS);
+
+	return 1;
+}
+
+static int nau8310_clkdet_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+
+	ucontrol->value.integer.value[0] = nau8310->clock_detection;
+
+	return 0;
+}
+
+static int nau8310_biq_coeff_get(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+	int i, reg, reg_val;
+	u16 *val;
+
+	val = (u16 *)ucontrol->value.bytes.data;
+	reg = NAU8310_R80_BIQ0_COE_1;
+	for (i = 0; i < params->max / sizeof(u16); i++) {
+		regmap_read(nau8310->regmap, reg + i, &reg_val);
+		/* conversion of 16-bit integers between native CPU format
+		 * and big endian format
+		 */
+		reg_val = cpu_to_be16(reg_val);
+		*(val + i) = reg_val;
+	}
+
+	return 0;
+}
+
+static int nau8310_biq_coeff_put(struct snd_kcontrol *kcontrol,
+	struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_to_dapm(kcontrol);
+	struct snd_soc_component *component = snd_soc_dapm_to_component(dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct soc_bytes_ext *params = (void *)kcontrol->private_value;
+	void *data;
+	u16 *val, value;
+	int i, reg, ret;
+
+	data = kmemdup(ucontrol->value.bytes.data, params->max, GFP_KERNEL | GFP_DMA);
+	if (!data)
+		return -ENOMEM;
+
+	val = (u16 *)data;
+	reg = NAU8310_R80_BIQ0_COE_1;
+	for (i = 0; i < params->max / sizeof(u16); i++) {
+		/* conversion of 16-bit integers between native CPU format
+		 * and big endian format
+		 */
+		value = be16_to_cpu(*(val + i));
+		ret = regmap_write(nau8310->regmap, reg + i, value);
+		if (ret) {
+			dev_err(nau8310->dev, "BIQ configuration fail, register: %x ret: %d",
+				reg + i, ret);
+			kfree(data);
+			return ret;
+		}
+	}
+	kfree(data);
+
+	return 0;
+}
+
+static const char * const nau8310_adc_decimation[] = { "32", "64", "128" };
+
+static const struct soc_enum nau8310_adc_decimation_enum =
+	SOC_ENUM_SINGLE(NAU8310_R28_ADC_RATE, NAU8310_ADC_SYNC_DOWN_SFT,
+		ARRAY_SIZE(nau8310_adc_decimation), nau8310_adc_decimation);
+
+static const char * const nau8310_dac_oversampl[] = {
+	"64", "256", "128", "", "32" };
+
+static const struct soc_enum nau8310_dac_oversampl_enum =
+	SOC_ENUM_SINGLE(NAU8310_R29_DAC_CTRL1, NAU8310_DAC_OVERSAMPLE_SFT,
+		ARRAY_SIZE(nau8310_dac_oversampl), nau8310_dac_oversampl);
+
+static const char * const nau8310_i2s_channel[] = { "Right", "Left"};
+
+static const struct soc_enum nau8310_aec_channel_sel_enum =
+	SOC_ENUM_SINGLE(NAU8310_R0B_I2S_PCM_CTRL0, NAU8310_AEC_CH_SEL_SFT,
+		ARRAY_SIZE(nau8310_i2s_channel), nau8310_i2s_channel);
+
+static const char * const nau8310_source[] = { "DSP", "Raw Data"};
+
+static const struct soc_enum nau8310_aec_source_sel_enum =
+	SOC_ENUM_SINGLE(NAU8310_R0B_I2S_PCM_CTRL0, NAU8310_AEC_SRC_SEL_SFT,
+		ARRAY_SIZE(nau8310_source), nau8310_source);
+
+static const char * const nau8310_adc_alcgain_slot[] = { "Disable", "Slot 0",
+	"Slot 1", "Slot 2", "Slot 3", "Slot 4", "Slot 5", "Slot 6", "Slot 7" };
+
+static const unsigned int nau8310_adc_alcgain_val[] = {
+	0x0, 0x8, 0x9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf };
+
+static const struct soc_enum nau8310_adc_alcgain_sel_enum =
+	SOC_VALUE_ENUM_SINGLE(NAU8310_R0C_TDM_CTRL, NAU8310_ADC_ALC_SEL_SFT,
+		0xf, ARRAY_SIZE(nau8310_adc_alcgain_slot),
+		nau8310_adc_alcgain_slot, nau8310_adc_alcgain_val);
+
+static const char * const nau8310_ivsense_format[] = { "signed", "unsigned" };
+
+static const struct soc_enum nau8310_ivsense_format_enum =
+	SOC_ENUM_SINGLE(NAU8310_R28_ADC_RATE, NAU8310_UNSIGN_IV_SFT,
+		ARRAY_SIZE(nau8310_ivsense_format), nau8310_ivsense_format);
+
+/* LB/LM is referred to low battery/limiter mode. */
+static const char * const nau8310_limiter_mode[] = {
+	"LM with Clip Detection",
+	"LBLM with Clip Detection",
+	"LM with Pre-Programmed Limit Level",
+	"LBLM with Pre-Programmed Limit Level",
+	"LBLM with Pre-Programmed VBAT Ratio Limit Level" };
+
+static const struct soc_enum nau8310_limiter_mode_enum =
+	SOC_ENUM_SINGLE(NAU8310_R2E_ALC_CTRL3, NAU8310_LIM_MDE_SFT,
+		ARRAY_SIZE(nau8310_limiter_mode), nau8310_limiter_mode);
+
+static const DECLARE_TLV_DB_MINMAX(adc_vol_tlv, 0, 24125);
+static const DECLARE_TLV_DB_MINMAX(pga_gain_tlv, 0, 1600);
+
+static const struct snd_kcontrol_new nau8310_snd_controls[] = {
+	SOC_ENUM("ADC Decimation Rate", nau8310_adc_decimation_enum),
+	SOC_ENUM("DAC Oversampling Rate", nau8310_dac_oversampl_enum),
+	SND_SOC_BYTES_EXT("BIQ Coefficients", 60,
+		nau8310_biq_coeff_get, nau8310_biq_coeff_put),
+
+	SOC_SINGLE_TLV("ADC Left Channel Volume",
+		NAU8310_R14_ADC_VOL_CTRL, NAU8310_ADC_GAIN_L_SFT,
+		NAU8310_ADC_GAIN_L_MAX, 0, adc_vol_tlv),
+	SOC_SINGLE_TLV("ADC Right Channel Volume",
+		NAU8310_R14_ADC_VOL_CTRL, NAU8310_ADC_GAIN_R_SFT,
+		NAU8310_ADC_GAIN_R_MAX, 0, adc_vol_tlv),
+	SOC_SINGLE_TLV("PGA Volume", NAU8310_R7F_POWER_UP_CONTROL,
+		NAU8310_PGA_GAIN_SFT, NAU8310_PGA_GAIN_MAX, 0, pga_gain_tlv),
+
+	/* Boost Control Target Value Limit. 0.16 V per step. */
+	SOC_SINGLE("Boost Target Limit", NAU8310_R17_BOOST_CTRL1,
+		NAU8310_BSTLIMIT_SFT, NAU8310_BSTLIMIT_MAX, 0),
+	/* Boost Margin Value between Boost Target Voltage and
+	 * Peak Output Level. 0.16 V per step.
+	 */
+	SOC_SINGLE("Boost Margin", NAU8310_R17_BOOST_CTRL1,
+		NAU8310_BSTMARGIN_SFT, NAU8310_BSTMARGIN_MAX, 0),
+
+	SOC_ENUM("AEC Channel", nau8310_aec_channel_sel_enum),
+	SOC_ENUM("AEC Source", nau8310_aec_source_sel_enum),
+	SOC_ENUM("ADC ALC Gain Channel Source", nau8310_adc_alcgain_sel_enum),
+	SOC_SINGLE("PingPong Mode Switch", NAU8310_R0C_TDM_CTRL,
+		NAU8310_PINGPONG_SFT, 1, 0),
+	SOC_ENUM("IV Sense Format", nau8310_ivsense_format_enum),
+
+	SOC_SINGLE_EXT("Clock Detection Switch", SND_SOC_NOPM, 0, 1, 0,
+		nau8310_clkdet_get, nau8310_clkdet_put),
+
+	SOC_SINGLE("AEC Enable Switch", NAU8310_R0B_I2S_PCM_CTRL0,
+		NAU8310_AEC_MODE_SFT, 1, 0),
+	SOC_SINGLE("ALC Max Gain", NAU8310_R2C_ALC_CTRL1,
+		NAU8310_ALC_MAXGAIN_SFT, NAU8310_ALC_MAXGAIN_MAX, 0),
+	SOC_SINGLE("ALC Min Gain", NAU8310_R2C_ALC_CTRL1,
+		NAU8310_ALC_MINGAIN_SFT, NAU8310_ALC_MINGAIN_MAX, 0),
+	SOC_SINGLE("ALC Decay Timer", NAU8310_R2D_ALC_CTRL2,
+		NAU8310_ALC_DCY_SFT, NAU8310_ALC_DCY_MAX, 0),
+	SOC_SINGLE("ALC Attack Timer", NAU8310_R2D_ALC_CTRL2,
+		NAU8310_ALC_ATK_SFT, NAU8310_ALC_ATK_MAX, 0),
+	SOC_SINGLE("ALC Hold Time", NAU8310_R2D_ALC_CTRL2,
+		NAU8310_ALC_HLD_SFT, NAU8310_ALC_HLD_MAX, 0),
+	SOC_SINGLE("ALC Target Level", NAU8310_R2D_ALC_CTRL2,
+		NAU8310_ALC_LVL_SFT, NAU8310_ALC_LVL_MAX, 0),
+	SOC_SINGLE("ALC Enable Switch", NAU8310_R2E_ALC_CTRL3,
+		NAU8310_ALC_EN_SFT, 1, 0),
+	SOC_ENUM("Limiter Mode Selection", nau8310_limiter_mode_enum),
+	SOC_SINGLE("Low Battery Limiter Threshold", NAU8310_R2E_ALC_CTRL3,
+		NAU8310_VBAT_THLD_SFT, NAU8310_VBAT_THLD_MAX, 0),
+	SOC_SINGLE("Auto Attenuation Enable Switch", NAU8310_R2E_ALC_CTRL3,
+		NAU8310_AUTOATT_EN_SFT, 1, 0),
+	SOC_SINGLE("BCLK IO Driver Stronger Switch", NAU8310_R0A_IO_CTRL,
+		NAU8310_BCLK_DS_SFT, 1, 0),
+	SOC_SINGLE("LRC IO Driver Stronger Switch", NAU8310_R0A_IO_CTRL,
+		NAU8310_LRC_DS_SFT, 1, 0),
+	SOC_SINGLE("ADCDAT IO Driver Stronger Switch", NAU8310_R0A_IO_CTRL,
+		NAU8310_ADCDAT_DS_SFT, 1, 0),
+
+	SOC_SINGLE("Low Output Noise in Receiver Mode Switch",
+		NAU8310_R64_ANALOG_CONTROL_4, NAU8310_RECV_MODE_SFT, 1, 0),
+
+	SOC_SINGLE("VBAT Peak Current Limit",
+		NAU8310_R6B_ANALOG_CONTROL_8,
+		NAU8310_VBAT_PCL_SFT, NAU8310_VBAT_PCL_MAX, 0),
+	SOC_SINGLE("VBAT Comparator Threshold",
+		NAU8310_R6B_ANALOG_CONTROL_8,
+		NAU8310_VBAT_THD_SFT, NAU8310_VBAT_THD_MAX, 0),
+
+	SOC_SINGLE("ISense PGA Supply Current Trim",
+		NAU8310_R77_FEPGA, NAU8310_CURR_TRIM_SFT, NAU8310_CURR_TRIM_MAX, 0),
+};
+
+static const struct snd_kcontrol_new nau8310_alc_gain_select =
+	SOC_DAPM_SINGLE("Switch", NAU8310_R2C_ALC_CTRL1,
+		NAU8310_ALC_GAIN_SEL_SFT, 1, 0);
+
+static int nau8310_clock_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/* Switch the clock source of DSP to MCLK. */
+		regmap_update_bits(nau8310->regmap, NAU8310_R04_ENA_CTRL,
+			NAU8310_DSP_SEL_OSC, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8310_powerup_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8310->regmap;
+
+	if (nau8310->clock_detection)
+		return 0;
+
+	if (SND_SOC_DAPM_EVENT_ON(event))
+		regmap_update_bits(regmap, NAU8310_R40_CLK_DET_CTRL,
+			NAU8310_PWRUP_DFT, NAU8310_PWRUP_DFT);
+	else if (SND_SOC_DAPM_EVENT_OFF(event))
+		regmap_update_bits(regmap, NAU8310_R40_CLK_DET_CTRL,
+			NAU8310_PWRUP_DFT, 0);
+
+	return 0;
+}
+
+static int nau8310_adc_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8310->regmap;
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(regmap, NAU8310_R0E_I2S_PCM_CTRL2,
+			NAU8310_I2S_ADCDAT_OE_MASK, NAU8310_I2S_ADCDAT_OE_EN);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		regmap_update_bits(regmap, NAU8310_R0E_I2S_PCM_CTRL2,
+			NAU8310_I2S_ADCDAT_OE_MASK, NAU8310_I2S_ADCDAT_OE_DIS);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8310_dac_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8310->regmap;
+
+	/* Soft mute to prevent the pop noise */
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		regmap_update_bits(regmap, NAU8310_R13_MUTE_CTRL,
+			NAU8310_SOFT_MUTE, 0);
+		msleep(30);
+		regmap_update_bits(regmap, NAU8310_R0E_I2S_PCM_CTRL2,
+			NAU8310_I2S_TRISTATE, 0);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		regmap_update_bits(regmap, NAU8310_R0E_I2S_PCM_CTRL2,
+			NAU8310_I2S_TRISTATE, NAU8310_I2S_TRISTATE);
+		regmap_update_bits(regmap, NAU8310_R13_MUTE_CTRL,
+			NAU8310_SOFT_MUTE, NAU8310_SOFT_MUTE);
+		msleep(30);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline bool nau8310_dsp_active(struct snd_soc_component *cp)
+{
+	return (snd_soc_component_read(cp, NAU8310_R1A_DSP_CORE_CTRL2) &
+		NAU8310_DAC_SEL_DSP_OUT);
+}
+
+static int check_dsp_enabled(struct snd_soc_dapm_widget *source,
+	struct snd_soc_dapm_widget *sink)
+{
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(source->dapm);
+
+	return nau8310_dsp_active(cp);
+}
+
+static const struct snd_soc_dapm_widget nau8310_dapm_widgets[] = {
+	SND_SOC_DAPM_SUPPLY("Clock", SND_SOC_NOPM, 0, 0,
+		nau8310_clock_event, SND_SOC_DAPM_PRE_PMU),
+	SND_SOC_DAPM_SUPPLY("PowerUp", SND_SOC_NOPM, 0, 0,
+		nau8310_powerup_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SWITCH_E("ALC gain selection mode", SND_SOC_NOPM,
+		0, 0, &nau8310_alc_gain_select, nau8310_adc_event,
+		SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_SIGGEN("Sense"),
+
+	SND_SOC_DAPM_PGA("SAR", NAU8310_R07_SAR_CTRL1, NAU8310_SAR_ENA_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC_I", NAU8310_R04_ENA_CTRL, NAU8310_ADCEN_I_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC_V", NAU8310_R04_ENA_CTRL, NAU8310_ADCEN_V_SFT, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("Capture Sense", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_ADC_E("ADC_OUT", "Capture", SND_SOC_NOPM, 0, 0,
+		nau8310_adc_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_AIF_IN("AIFRX", "Playback", 0, SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_DAC_E("DAC", NULL, NAU8310_R04_ENA_CTRL, NAU8310_DAC_CH_EN_SFT, 0,
+		nau8310_dac_event, SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
+	SND_SOC_DAPM_OUTPUT("Speaker"),
+};
+
+static const struct snd_soc_dapm_route nau8310_dapm_routes[] = {
+	{ "SAR", NULL, "Sense" },
+	{ "ADC_I", NULL, "Sense" },
+	{ "ADC_V", NULL, "Sense" },
+	{ "Capture Sense", NULL, "SAR" },
+	{ "Capture Sense", NULL, "ADC_I" },
+	{ "Capture Sense", NULL, "ADC_V" },
+
+	{ "ALC gain selection mode", "Switch", "Capture Sense" },
+	{ "ADC_OUT", NULL, "Capture Sense" },
+
+	{ "AIFRX", NULL, "Clock", check_dsp_enabled },
+	{ "DAC", NULL, "PowerUp" },
+	{ "DAC", NULL, "ALC gain selection mode" },
+	{ "DAC", NULL, "AIFRX" },
+	{ "Speaker", NULL, "DAC"},
+};
+
+static int nau8310_srate_clk_apply(struct nau8310 *nau8310,
+	const struct nau8310_srate_attr *srate_table,
+	int n1_sel, int mclk_mult_sel, int n2_sel, int dsp_mult_sel)
+{
+	struct regmap *regmap = nau8310->regmap;
+	int dsp_clk, mult_sel;
+	unsigned int ctrl_val = 0;
+
+	static const unsigned int mclkx_val[] = {
+		/* multiplier 4x, i.e. 2^2 */
+		[2] = NAU8310_MCLK4XEN,
+		/* multiplier 8x, i.e. 2^3 */
+		[3] = NAU8310_MCLK8XEN | NAU8310_MCLK4XEN,
+		/* multiplier 16x, i.e. 2^4 */
+		[4] = NAU8310_MCLK16XEN | NAU8310_MCLK8XEN | NAU8310_MCLK4XEN,
+	};
+
+	if (!srate_table || srate_table->adc_div < 0 ||
+		dsp_mult_sel < 0 || dsp_mult_sel >= ARRAY_SIZE(dsp_src_mult) ||
+		n2_sel < 0 || n2_sel >= ARRAY_SIZE(mclk_n2_div) ||
+		n1_sel < 0 || n1_sel >= ARRAY_SIZE(mclk_n1_div)) {
+		dev_err(nau8310->dev, "The fs %d isn't support in DSP.",
+			nau8310->fs);
+		return -EINVAL;
+	}
+	regmap_update_bits(regmap, NAU8310_R03_CLK_CTRL,
+		NAU8310_CLK_ADC_DIV2 | NAU8310_CLK_ADC_DIV4,
+		srate_table->adc_div << NAU8310_CLK_ADC_DIV4_SFT);
+	regmap_update_bits(regmap, NAU8310_R40_CLK_DET_CTRL,
+		NAU8310_SRATE_MASK | NAU8310_DIV_MAX | NAU8310_ALT_SRATE_EN,
+		(srate_table->range << NAU8310_SRATE_SFT) |
+		(srate_table->max ? NAU8310_DIV_MAX : 0) |
+		(srate_table->fs == 44100 ? NAU8310_ALT_SRATE_EN : 0));
+
+	dsp_clk = nau8310->mclk << dsp_src_mult[dsp_mult_sel].param;
+	dsp_clk = dsp_clk / mclk_n1_div[n1_sel].param;
+
+	dev_dbg(nau8310->dev, "FS %dHz, DSP_CLK %uHz, n1_sel (%d), mclk_mult_sel (%d), n2_sel (%d), dsp_mult_sel (%d).",
+		nau8310->fs, dsp_clk, n1_sel, mclk_mult_sel, n2_sel, dsp_mult_sel);
+
+	regmap_update_bits(regmap, NAU8310_R03_CLK_CTRL,
+		NAU8310_MCLK_SRC_MASK, mclk_n2_div[n2_sel].val);
+	ctrl_val = (dsp_src_mult[dsp_mult_sel].val << NAU8310_CLK_DSP_SRC_SFT) |
+		(mclk_n1_div[n1_sel].val << NAU8310_CLK_MUL_SRC_SFT);
+
+	if (mclk_mult_sel != CLK_PROC_BYPASS) {
+		ctrl_val |= mclk_src_mult[mclk_mult_sel].val << NAU8310_MCLK_SEL_SFT;
+		mult_sel = (mclk_mult_sel > dsp_mult_sel ? mclk_mult_sel : dsp_mult_sel);
+	} else
+		mult_sel = dsp_mult_sel;
+
+	regmap_update_bits(regmap, NAU8310_R04_ENA_CTRL,
+		NAU8310_CLK_DSP_SRC_MASK | NAU8310_CLK_MUL_SRC_MASK |
+		NAU8310_MCLK_SEL_MASK, ctrl_val);
+
+	if (mult_sel < 2 || mult_sel > 4)
+		return -EINVAL;
+
+	regmap_update_bits(regmap, NAU8310_R68_ANALOG_CONTROL_7,
+		NAU8310_MCLKX_MASK, mclkx_val[mult_sel]);
+
+	return 0;
+}
+
+static int nau8310_calc_dsp_clk(int mclk, int fs, int mult_param, int n1_param)
+{
+	int dsp_clk = (mclk << mult_param) / n1_param;
+
+	if (dsp_clk >= (fs * DSP_CLK_MIN_MULTI_VALUE) && dsp_clk <= DSP_CLK_MAX)
+		return dsp_clk;
+
+	return 0;
+}
+
+static int nau8310_clkdsp_choose(struct nau8310 *nau8310, int *n1_sel, bool n1_try,
+	int *dsp_n1_sel, int *dsp_mult_sel)
+{
+	int i, j, dsp_n1, mult_sel, dsp_clk, dsp_clk_max = 0;
+
+	if (!nau8310->fs || !nau8310->mclk)
+		goto proc_err;
+
+	if (n1_sel) {
+		dsp_n1 = *n1_sel;
+		for (j = 0; j < ARRAY_SIZE(dsp_src_mult); j++) {
+			dsp_clk = nau8310_calc_dsp_clk(nau8310->mclk, nau8310->fs,
+				dsp_src_mult[j].param, mclk_n1_div[dsp_n1].param);
+			if (!dsp_clk)
+				continue;
+			if (dsp_clk_max < dsp_clk) {
+				dsp_clk_max = dsp_clk;
+				mult_sel = j;
+			}
+		}
+		if (!dsp_clk_max)
+			goto proc_err;
+		if (!n1_try) {
+			*dsp_n1_sel = dsp_n1;
+			*dsp_mult_sel = mult_sel;
+		}
+	} else {
+		dsp_n1 = -1;
+		if (nau8310->mclk >= DSP_MCLK_HI_SPEED) {
+			/* get max N1 when MCLK over 12.288MHz */
+			for (i = 0; i < ARRAY_SIZE(mclk_n1_div); i++)
+				for (j = 0; j < ARRAY_SIZE(dsp_src_mult); j++) {
+					dsp_clk = nau8310_calc_dsp_clk(nau8310->mclk, nau8310->fs,
+						dsp_src_mult[j].param, mclk_n1_div[i].param);
+					if (!dsp_clk)
+						continue;
+					if ((dsp_clk_max < dsp_clk || i > dsp_n1)) {
+						dsp_clk_max = dsp_clk;
+						dsp_n1 = i;
+						mult_sel = j;
+					}
+				}
+			if (!dsp_clk_max)
+				goto proc_err;
+		} else {
+			for (i = 0; i < ARRAY_SIZE(mclk_n1_div); i++) {
+				for (j = 0; j < ARRAY_SIZE(dsp_src_mult); j++) {
+					dsp_clk = nau8310_calc_dsp_clk(nau8310->mclk, nau8310->fs,
+						dsp_src_mult[j].param, mclk_n1_div[i].param);
+					if (dsp_clk) {
+						dsp_n1 = i;
+						mult_sel = j;
+						break;
+					}
+				}
+				if (dsp_n1 >= 0)
+					break;
+			}
+			if (dsp_n1 < 0)
+				goto proc_err;
+		}
+		*dsp_n1_sel = dsp_n1;
+		*dsp_mult_sel = mult_sel;
+	}
+
+	return 0;
+
+proc_err:
+	return -EINVAL;
+}
+
+static inline int get_osrate_val(const struct nau8310_osr_attr *arr, size_t arr_size, int osr)
+{
+	if (osr >= arr_size)
+		return -EINVAL;
+
+	return arr[osr].osr;
+}
+
+static int nau8310_clock_check(struct nau8310 *nau8310, int stream, int rate, int osr)
+{
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(nau8310->dapm);
+	int osrate = 0;
+
+	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
+		osrate = get_osrate_val(osr_dac_sel, ARRAY_SIZE(osr_dac_sel), osr);
+	else {
+		if (nau8310_dsp_active(cp))
+			osrate = get_osrate_val(osr_adc_dsp_sel,
+				ARRAY_SIZE(osr_adc_dsp_sel), osr);
+		else
+			osrate = get_osrate_val(osr_adc_sel,
+				ARRAY_SIZE(osr_adc_sel), osr);
+	}
+
+	if (osrate <= 0)
+		return -EINVAL;
+
+	if (rate * osrate > CLK_DA_AD_MAX) {
+		dev_err(nau8310->dev, "exceed the maximum frequency of CLK_ADC or CLK_DAC");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nau8310_osr_apply(struct nau8310 *nau8310)
+{
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(nau8310->dapm);
+	struct regmap *regmap = nau8310->regmap;
+	unsigned int dac_osr, adc_osr;
+	unsigned int dac_src, adc_src;
+
+	/* CLK_DAC or CLK_ADC = OSR * FS
+	 * DAC or ADC clock frequency is defined as Over Sampling Rate (OSR)
+	 * multiplied by the audio sample rate (Fs). Note that the OSR and Fs
+	 * values must be selected such that the maximum frequency is less
+	 * than 6.144 MHz.
+	 */
+	regmap_read(regmap, NAU8310_R29_DAC_CTRL1, &dac_osr);
+	dac_osr &= NAU8310_DAC_OVERSAMPLE_MASK;
+	if (nau8310_clock_check(nau8310, SNDRV_PCM_STREAM_PLAYBACK, nau8310->fs, dac_osr))
+		return -EINVAL;
+
+	regmap_read(regmap, NAU8310_R28_ADC_RATE, &adc_osr);
+	adc_osr &= NAU8310_ADC_SYNC_DOWN_MASK;
+	if (nau8310_clock_check(nau8310, SNDRV_PCM_STREAM_CAPTURE, nau8310->fs, adc_osr))
+		return -EINVAL;
+
+	dac_src = osr_dac_sel[dac_osr].clk_src << NAU8310_CLK_DAC_SRC_SFT;
+	adc_src = (nau8310_dsp_active(cp)) ?
+		(osr_adc_dsp_sel[adc_osr].clk_src << NAU8310_CLK_ADC_SRC_SFT) :
+		(osr_adc_sel[adc_osr].clk_src << NAU8310_CLK_ADC_SRC_SFT);
+	regmap_update_bits(regmap, NAU8310_R03_CLK_CTRL,
+		NAU8310_CLK_DAC_SRC_MASK | NAU8310_CLK_ADC_SRC_MASK, dac_src | adc_src);
+
+	return 0;
+}
+
+static int nau8310_match_mclk_ratio(const struct nau8310_srate_attr *srate_table,
+	int mclk_src)
+{
+	if (srate_table->mclk_src[NAU8310_MCLK_FS_RATIO_256] == mclk_src)
+		return NAU8310_MCLK_FS_RATIO_256;
+
+	if (srate_table->mclk_src[NAU8310_MCLK_FS_RATIO_400] == mclk_src)
+		return NAU8310_MCLK_FS_RATIO_400;
+
+	if (srate_table->mclk_src[NAU8310_MCLK_FS_RATIO_500] == mclk_src)
+		return NAU8310_MCLK_FS_RATIO_500;
+
+	return NAU8310_MCLK_FS_RATIO_NUM;
+}
+
+static int nau8310_clksrc_n2(struct nau8310 *nau8310,
+	const struct nau8310_srate_attr *srate_table, int mclk, int *n2_sel)
+{
+	int i, mclk_src, ratio = NAU8310_MCLK_FS_RATIO_NUM;
+
+	for (i = 0; i < ARRAY_SIZE(mclk_n2_div); i++) {
+		mclk_src = mclk >> mclk_n2_div[i].param;
+		ratio = nau8310_match_mclk_ratio(srate_table, mclk_src);
+		if (ratio != NAU8310_MCLK_FS_RATIO_NUM) {
+			*n2_sel = i;
+			break;
+		}
+	}
+
+	return ratio;
+}
+
+static const struct nau8310_srate_attr *target_srate_attribute(int srate)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(target_srate_table); i++)
+		if (target_srate_table[i].fs == srate)
+			break;
+
+	if (i == ARRAY_SIZE(target_srate_table))
+		return NULL;
+
+	return &target_srate_table[i];
+}
+
+static int nau8310_clksrc_choose(struct nau8310 *nau8310,
+	const struct nau8310_srate_attr **srate_table,
+	int *n1_sel, int *mult_sel, int *n2_sel, int *dsp_mult_sel)
+{
+	int i, j, mclk, mclk_max, ratio, ratio_sel, n2_max, ret;
+
+	if (!nau8310->mclk || !nau8310->fs)
+		goto proc_err;
+
+	/* select sampling rate and MCLK_SRC */
+	*srate_table = target_srate_attribute(nau8310->fs);
+	if (*srate_table == NULL)
+		goto proc_err;
+
+	/* First check clock from MCLK directly, decide N2 for MCLK_SRC.
+	 * If not good, consider 1/N1 and Multiplier.
+	 */
+	ratio = nau8310_clksrc_n2(nau8310, *srate_table, nau8310->mclk, n2_sel);
+	if (ratio != NAU8310_MCLK_FS_RATIO_NUM) {
+		*n1_sel = CLK_PROC_BYPASS;
+		*mult_sel = CLK_PROC_BYPASS;
+		ret = nau8310_clkdsp_choose(nau8310, NULL, false,
+			n1_sel, dsp_mult_sel);
+		if (ret)
+			goto proc_err;
+		goto proc_done;
+	}
+	/* Get MCLK_SRC through 1/N, Multiplier, and then 1/N2. */
+	mclk_max = 0;
+	for (i = 0; i < ARRAY_SIZE(mclk_n1_div); i++) {
+		for (j = 0; j < ARRAY_SIZE(mclk_src_mult); j++) {
+			mclk = nau8310->mclk << mclk_src_mult[j].param;
+			mclk = mclk / mclk_n1_div[i].param;
+			ratio = nau8310_clksrc_n2(nau8310, *srate_table, mclk, n2_sel);
+			if (ratio != NAU8310_MCLK_FS_RATIO_NUM &&
+				(mclk_max < mclk || i > *n1_sel)) {
+				ret = nau8310_clkdsp_choose(nau8310, &i, true,
+					n1_sel, dsp_mult_sel);
+				if (ret)
+					break;
+				mclk_max = mclk;
+				n2_max = *n2_sel;
+				*n1_sel = i;
+				*mult_sel = j;
+				ratio_sel = ratio;
+			}
+		}
+	}
+	if (mclk_max) {
+		*n2_sel = n2_max;
+		ratio = ratio_sel;
+		nau8310_clkdsp_choose(nau8310, n1_sel, false, n1_sel, dsp_mult_sel);
+		goto proc_done;
+	}
+
+proc_err:
+	dev_err(nau8310->dev, "The MCLK %d is invalid. It can't get MCLK_SRC of 256/400/500 FS (%d).",
+		nau8310->mclk, nau8310->fs);
+	return -EINVAL;
+proc_done:
+	dev_dbg(nau8310->dev, "FS %dHz, range 0x%x, %s, (n1,mu,n2,dmu):(%d,%d,%d,%d), MCLK_SRC %uHz (%d)",
+		nau8310->fs, (*srate_table)->range,
+		(*srate_table)->max ? "MAX" : "MIN",
+		*n1_sel == CLK_PROC_BYPASS ?
+		CLK_PROC_BYPASS : mclk_n1_div[*n1_sel].param,
+		*mult_sel == CLK_PROC_BYPASS ?
+		CLK_PROC_BYPASS : 1 << mclk_src_mult[*mult_sel].param,
+		1 << mclk_n2_div[*n2_sel].param,
+		1 << dsp_src_mult[*dsp_mult_sel].param,
+		(*srate_table)->mclk_src[ratio],
+		(*srate_table)->mclk_src[ratio] / nau8310->fs);
+	return 0;
+}
+
+static int nau8310_clock_config(struct nau8310 *nau8310)
+{
+	const struct nau8310_srate_attr *srate_table;
+	int ret, n1_sel, mult_sel, n2_sel, dsp_mult_sel;
+
+	ret = nau8310_clksrc_choose(nau8310, &srate_table, &n1_sel, &mult_sel,
+		&n2_sel, &dsp_mult_sel);
+	if (ret)
+		return ret;
+
+	ret = nau8310_srate_clk_apply(nau8310, srate_table, n1_sel, mult_sel,
+		n2_sel, dsp_mult_sel);
+	if (ret)
+		return ret;
+
+	ret = nau8310_osr_apply(nau8310);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int nau8310_set_sysclk(struct snd_soc_component *component,
+	int clk_id, int source, unsigned int freq, int dir)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+
+	if (freq < MASTER_CLK_MIN || freq > MASTER_CLK_MAX) {
+		dev_err(nau8310->dev,
+			"Exceed the range of input clocks, MCLK %dHz", freq);
+		return -EINVAL;
+	}
+	nau8310->mclk = freq;
+	dev_dbg(nau8310->dev, "%s, MCLK %dHz", __func__, nau8310->mclk);
+
+	return 0;
+}
+
+static int nau8310_hw_params(struct snd_pcm_substream *substream,
+	struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *cp = dai->component;
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	unsigned int val_len = 0;
+	int ret;
+
+	nau8310->fs = params_rate(params);
+	if (nau8310_dsp_active(cp) && nau8310->fs != NAU8310_DEFAULT_SAMPLE_RATE) {
+		dev_err(nau8310->dev,
+			"For ROM Code revision 00, DSP only run at 48kHz.");
+		return -EINVAL;
+	}
+	ret = nau8310_clock_config(nau8310);
+	if (ret)
+		return -EINVAL;
+
+	switch (params_width(params)) {
+	case 16:
+		val_len |= NAU8310_I2S_DL_16;
+		break;
+	case 20:
+		val_len |= NAU8310_I2S_DL_20;
+		break;
+	case 24:
+		val_len |= NAU8310_I2S_DL_24;
+		break;
+	case 32:
+		val_len |= NAU8310_I2S_DL_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(nau8310->regmap, NAU8310_R0D_I2S_PCM_CTRL1,
+		NAU8310_I2S_DL_MASK, val_len);
+
+	return 0;
+}
+
+static int nau8310_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8310->regmap;
+	unsigned int ctrl1_val = 0, ctrl2_val = 0;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
+		ctrl2_val |= NAU8310_I2S_MS_MASTER;
+		break;
+	case SND_SOC_DAIFMT_CBC_CFC:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		ctrl1_val |= NAU8310_I2S_BP_INV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ctrl1_val |= NAU8310_I2S_DF_I2S;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ctrl1_val |= NAU8310_I2S_DF_LEFT;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		ctrl1_val |= NAU8310_I2S_DF_RIGHT;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		ctrl1_val |= NAU8310_I2S_DF_PCM_AB;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		ctrl1_val |= NAU8310_I2S_DF_PCM_AB;
+		ctrl1_val |= NAU8310_I2S_PCMB_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(regmap, NAU8310_R0D_I2S_PCM_CTRL1,
+		NAU8310_I2S_DF_MASK | NAU8310_I2S_BP_MASK |
+		NAU8310_I2S_PCMB_EN, ctrl1_val);
+	regmap_update_bits(regmap, NAU8310_R0E_I2S_PCM_CTRL2,
+		NAU8310_I2S_MS_MASK, ctrl2_val);
+	return 0;
+}
+
+static int nau8310_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
+	unsigned int rx_mask, int slots, int slot_width)
+{
+	struct snd_soc_component *cp = dai->component;
+	struct device *dev = cp->dev;
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	struct regmap *regmap = nau8310->regmap;
+	unsigned int ctrl0_val = 0, ctrl_val = 0;
+	int i;
+
+	if (!slots || !slot_width) {
+		regmap_update_bits(regmap, NAU8310_R0C_TDM_CTRL,
+		NAU8310_TDM_EN, 0);
+		return 0;
+	}
+
+	if (slots > NAU8310_TDM_MAX_SLOTS)
+		return -EINVAL;
+
+	if (slot_width != 16 && slot_width != 24 && slot_width != 32) {
+		dev_err(dev, "Invalid TDM channel length: %d", slot_width);
+		return -EINVAL;
+	}
+
+	if (tx_mask || rx_mask)
+		ctrl_val |= NAU8310_TDM_EN;
+
+	for (i = 0; i < NAU8310_TDM_MAX_SLOTS; i++)
+		if (tx_mask & BIT(i)) {
+			ctrl_val |= nau8310_tx_slot_map[i];
+			dev_dbg(dev, "NAU8310_ADC_%c_SEL_SLOT%d",
+				(i % 2 == 0) ? 'V' : 'I', i);
+		}
+
+	for (i = 0; i < NAU8310_TDM_MAX_SLOTS; i++)
+		if (rx_mask & BIT(i)) {
+			ctrl0_val |= nau8310_rx_slot_map[i];
+			dev_dbg(dev, "NAU8310_DAC_SEL_SLOT%d", i);
+			break;
+		}
+
+	dev_dbg(dev, "%s: tx_mask: 0x%08X, rx_mask: 0x%08X, ADC slots: 0x%08X, DAC slots: 0x%08X",
+		__func__, tx_mask, rx_mask, ctrl_val, ctrl0_val);
+
+	regmap_update_bits(regmap, NAU8310_R0C_TDM_CTRL,
+		NAU8310_TDM_EN | NAU8310_TDM_OFFSET_EN |
+		NAU8310_ADC_I_SEL_MASK | NAU8310_ADC_V_SEL_MASK, ctrl_val);
+	regmap_update_bits(regmap, NAU8310_R0B_I2S_PCM_CTRL0,
+		NAU8310_DAC_SEL_MASK, ctrl0_val);
+
+	return 0;
+}
+
+static int nau8310_switch_internal_osc(struct snd_soc_component *cp)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(cp);
+	int ret;
+
+	/* For internal Ring OSC, the default fs apply to 48kHz */
+	nau8310->fs = NAU8310_DEFAULT_SAMPLE_RATE;
+	ret = nau8310_set_sysclk(cp, 0, 0,
+		nau8310->fs * NAU8310_SYSCLK_MULT, SND_SOC_CLOCK_IN);
+	if (ret)
+		return ret;
+
+	ret = nau8310_clock_config(nau8310);
+	if (ret)
+		return ret;
+
+	/* Switch clock source to OSC before MCLK off if DSP is enabled. */
+	regmap_update_bits(nau8310->regmap, NAU8310_R04_ENA_CTRL,
+		NAU8310_DSP_OSC_EN | NAU8310_DSP_SEL_OSC,
+		NAU8310_DSP_OSC_EN | NAU8310_DSP_SEL_OSC);
+
+	return 0;
+}
+
+static int nau8310_startup(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+
+	flush_work(&nau8310->load_fw_work);
+
+	if (nau8310_dsp_active(component) && !nau8310->load_fw_done) {
+		dev_warn(nau8310->dev, "DSP firmware is not ready yet!");
+		return -EBUSY;
+	}
+
+	if (nau8310_dsp_active(component))
+		snd_soc_dapm_enable_pin(nau8310->dapm, "Sense");
+
+	return 0;
+}
+
+static void nau8310_shutdown(struct snd_pcm_substream *substream,
+	struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *cp = dai->component;
+	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(cp);
+	int ret;
+
+	if (!nau8310_dsp_active(cp))
+		return;
+
+	snd_soc_dapm_disable_pin(dapm, "Sense");
+
+	ret = nau8310_switch_internal_osc(cp);
+	if (ret)
+		return;
+}
+
+static void nau8310_reset_chip(struct regmap *regmap)
+{
+	regmap_write(regmap, NAU8310_R00_HARDWARE_RST, 0x0001);
+	regmap_write(regmap, NAU8310_R00_HARDWARE_RST, 0x0000);
+}
+
+static void nau8310_software_reset(struct regmap *regmap)
+{
+	regmap_write(regmap, NAU8310_R01_SOFTWARE_RST, 0x0000);
+	regmap_write(regmap, NAU8310_R01_SOFTWARE_RST, 0x0000);
+}
+
+static int nau8310_dsp_fw_load(struct nau8310 *nau8310)
+{
+	int ret = 0;
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(nau8310->dapm);
+
+	ret = nau8310_switch_internal_osc(cp);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(nau8310->regmap, NAU8310_R68_ANALOG_CONTROL_7,
+		NAU8310_MU_HALF_RANGE_EN, NAU8310_MU_HALF_RANGE_EN);
+
+	nau8310->load_fw_done = false;
+	schedule_work(&nau8310->load_fw_work);
+
+	return ret;
+}
+
+static void nau8310_load_fw_work(struct work_struct *work)
+{
+	struct nau8310 *nau8310 = container_of(work, struct nau8310, load_fw_work);
+	struct regmap *regmap = nau8310->regmap;
+	struct snd_soc_component *cp = snd_soc_dapm_to_component(nau8310->dapm);
+	int ret;
+
+	mutex_lock(&nau8310->lock);
+	ret = nau8310_dsp_init(cp);
+	mutex_unlock(&nau8310->lock);
+	if (ret) {
+		dev_err(nau8310->dev, "Failed to initialize DSP: %d", ret);
+		goto err;
+	}
+
+	return;
+
+err:
+
+	regmap_update_bits(regmap,
+		NAU8310_R1A_DSP_CORE_CTRL2,
+		NAU8310_DSP_RUNSTALL | NAU8310_DAC_SEL_DSP_OUT, NAU8310_DSP_RUNSTALL);
+
+	/* Switch the clock source of DSP to MCLK. */
+	regmap_update_bits(regmap, NAU8310_R04_ENA_CTRL, NAU8310_DSP_SEL_OSC, 0);
+}
+
+static int nau8310_codec_probe(struct snd_soc_component *component)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
+	int ret = 0;
+
+	nau8310->dapm = dapm;
+
+	/* Loading DSP firmware */
+	ret = nau8310_dsp_fw_load(nau8310);
+	if (ret) {
+		dev_err(nau8310->dev, "Loading DSP firmware failed(%d)", ret);
+		goto err;
+	}
+
+	ret = nau8310_dsp_setup_controls(component);
+	if (ret) {
+		dev_err(nau8310->dev, "DSP setup controls failed(%d)", ret);
+		goto err;
+	}
+
+err:
+	return ret;
+}
+
+static int __maybe_unused nau8310_suspend(struct snd_soc_component *component)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8310->regmap;
+
+	cancel_work_sync(&nau8310->load_fw_work);
+
+	if (nau8310_dsp_active(component))
+		regmap_update_bits(regmap, NAU8310_R04_ENA_CTRL,
+			NAU8310_DSP_SEL_OSC, NAU8310_DSP_SEL_OSC);
+
+	regcache_cache_only(regmap, true);
+	regcache_mark_dirty(regmap);
+
+	return 0;
+}
+
+static int __maybe_unused nau8310_resume(struct snd_soc_component *component)
+{
+	struct nau8310 *nau8310 = snd_soc_component_get_drvdata(component);
+	struct regmap *regmap = nau8310->regmap;
+	int ret = 0;
+
+	regcache_cache_only(regmap, false);
+	ret = regcache_sync(regmap);
+	if (ret)
+		return ret;
+
+	if (nau8310_dsp_active(component)) {
+		ret = nau8310_dsp_fw_load(nau8310);
+		if (ret)
+			dev_err(nau8310->dev, "Loading DSP firmware failed(%d)", ret);
+	}
+
+	return ret;
+}
+
+static const struct snd_soc_component_driver soc_comp_dev_nau8310 = {
+	.probe			= nau8310_codec_probe,
+	.set_sysclk		= nau8310_set_sysclk,
+	.suspend		= nau8310_suspend,
+	.resume			= nau8310_resume,
+	.controls		= nau8310_snd_controls,
+	.num_controls		= ARRAY_SIZE(nau8310_snd_controls),
+	.dapm_widgets		= nau8310_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(nau8310_dapm_widgets),
+	.dapm_routes		= nau8310_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(nau8310_dapm_routes),
+	.suspend_bias_off	= 1,
+	.idle_bias_on		= 1,
+	.use_pmdown_time	= 1,
+	.endianness		= 1,
+};
+
+static const struct snd_soc_dai_ops nau8310_dai_ops = {
+	.startup	= nau8310_startup,
+	.hw_params	= nau8310_hw_params,
+	.shutdown	= nau8310_shutdown,
+	.set_fmt	= nau8310_set_fmt,
+	.set_tdm_slot	= nau8310_set_tdm_slot,
+};
+
+#define NAU8310_RATES SNDRV_PCM_RATE_8000_192000
+#define NAU8310_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE \
+	 | SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver nau8310_dai = {
+	.name = NAU8310_CODEC_DAI,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = NAU8310_RATES,
+		.formats = NAU8310_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 8,
+		.rates = NAU8310_RATES,
+		.formats = NAU8310_FORMATS,
+	},
+	.ops = &nau8310_dai_ops,
+	.symmetric_rate = 1,
+};
+
+static int nau8310_reg_write(void *context, unsigned int reg, unsigned int value)
+{
+	struct i2c_client *client = context;
+	struct nau8310 *nau8310 = i2c_get_clientdata(client);
+	int ret, count = 0;
+
+	put_unaligned_be16(reg, &nau8310->i2c_write_buf[count]);
+	count += 2;
+	if (reg == NAU8310_RF000_DSP_COMM) {
+		/* format for DSP, 4 bytes value and native */
+		put_unaligned_le32(value, &nau8310->i2c_write_buf[count]);
+		count += 4;
+	} else {
+		/* format for Codec, 2 bytes value and endian big */
+		put_unaligned_be16(value, &nau8310->i2c_write_buf[count]);
+		count += 2;
+	}
+
+	ret = i2c_master_send(client, nau8310->i2c_write_buf, count);
+
+	if (ret == count)
+		return 0;
+	if (ret < 0)
+		return ret;
+
+	return -EIO;
+}
+
+static int nau8310_reg_read(void *context, unsigned int reg, unsigned int *value)
+{
+	struct i2c_client *client = context;
+	struct nau8310 *nau8310 = i2c_get_clientdata(client);
+	struct i2c_msg xfer[2];
+	int ret;
+
+	put_unaligned_be16(reg, &nau8310->i2c_read_reg);
+	xfer[0].addr = client->addr;
+	xfer[0].len = 2;
+	xfer[0].buf = nau8310->i2c_read_reg;
+	xfer[0].flags = 0;
+
+	xfer[1].addr = client->addr;
+	xfer[1].len = (reg == NAU8310_RF000_DSP_COMM ? 4 : 2);
+	xfer[1].buf = nau8310->i2c_read_buf;
+	xfer[1].flags = I2C_M_RD;
+
+	ret = i2c_transfer(client->adapter, xfer, ARRAY_SIZE(xfer));
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(xfer))
+		return -EIO;
+
+	if (reg == NAU8310_RF000_DSP_COMM)
+		*value = get_unaligned_le32(nau8310->i2c_read_buf);
+	else
+		*value = get_unaligned_be16(nau8310->i2c_read_buf);
+
+	return 0;
+}
+
+static const struct regmap_config nau8310_regmap_config = {
+	.reg_bits = NAU8310_REG_ADDR_LEN,
+	.val_bits = NAU8310_REG_DATA_LEN,
+
+	.max_register = NAU8310_REG_MAX,
+	.readable_reg = nau8310_readable_reg,
+	.writeable_reg = nau8310_writeable_reg,
+	.volatile_reg = nau8310_volatile_reg,
+	.reg_read = nau8310_reg_read,
+	.reg_write = nau8310_reg_write,
+
+	.cache_type = REGCACHE_MAPLE,
+	.reg_defaults = nau8310_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(nau8310_reg_defaults),
+};
+
+static void nau8310_init_regs(struct nau8310 *nau8310)
+{
+	struct regmap *regmap = nau8310->regmap;
+	unsigned int clk_det = 0, ana_ctrl = 0;
+
+	/* Latch IIC LSB value */
+	regmap_write(regmap, NAU8310_R02_I2C_ADDR, 0x0001);
+	/* Block MCLK */
+	regmap_update_bits(regmap, NAU8310_R04_ENA_CTRL,
+		NAU8310_MCLK_SEL_MASK, 0x7 << NAU8310_MCLK_SEL_SFT);
+	/* stall DSP */
+	regmap_update_bits(regmap, NAU8310_R1A_DSP_CORE_CTRL2,
+		NAU8310_DSP_RUNSTALL, NAU8310_DSP_RUNSTALL);
+	/* Default ADCI from slot1, ADCV from slot 0. */
+	regmap_update_bits(regmap, NAU8310_R0C_TDM_CTRL,
+		NAU8310_ADC_I_SEL_MASK | NAU8310_ADC_V_SEL_MASK,
+		(0x4 << NAU8310_ADC_I_SEL_SFT) | 0x4);
+	/* Set I-sense digital gain to +10.25dB */
+	regmap_update_bits(regmap, NAU8310_R14_ADC_VOL_CTRL,
+		NAU8310_ADC_GAIN_L_MASK | NAU8310_ADC_GAIN_R_MASK,
+		(0x1 << NAU8310_ADC_GAIN_L_SFT) | 0x62);
+	/* PGA in Class A Mode */
+	regmap_update_bits(regmap, NAU8310_R76_BOOST,
+		NAU8310_STG2_SEL_CLASSA, NAU8310_STG2_SEL_CLASSA);
+	/* Set I-sense PGA Bias Current to minimum,
+	 * Disable PGA Common Mode Lock.
+	 */
+	regmap_update_bits(regmap, NAU8310_R77_FEPGA,
+		NAU8310_CURR_TRIM_MASK | NAU8310_CMLCK_ENB,
+		(0x7 << NAU8310_CURR_TRIM_SFT) | NAU8310_CMLCK_ENB);
+	/* Set I-sense PGA to +12dB gain */
+	regmap_update_bits(regmap, NAU8310_R7F_POWER_UP_CONTROL,
+		NAU8310_PGA_GAIN_MASK, 0x3 << NAU8310_PGA_GAIN_SFT);
+	/* Normal I2S Audio data w/o SAR ADC data.
+	 * Default oversampling/decimations settings are unusable
+	 * (audible hiss). Set it to something better.
+	 */
+	regmap_update_bits(regmap, NAU8310_R28_ADC_RATE,
+		NAU8310_I2S_MODE | NAU8310_ADC_SYNC_DOWN_MASK,
+		(nau8310->normal_iis_data << NAU8310_I2S_MODE_SFT) |
+		NAU8310_ADC_SYNC_DOWN_64);
+	regmap_update_bits(regmap, NAU8310_R29_DAC_CTRL1,
+		NAU8310_DAC_OVERSAMPLE_MASK, NAU8310_DAC_OVERSAMPLE_64);
+	/* Enable auto attenuation for better output signal */
+	regmap_update_bits(regmap, NAU8310_R2E_ALC_CTRL3,
+		NAU8310_AUTOATT_EN, NAU8310_AUTOATT_EN);
+	/* Set ALC parameters */
+	regmap_update_bits(regmap, NAU8310_R2C_ALC_CTRL1,
+		NAU8310_ALC_MAXGAIN_MASK, 0x7 << NAU8310_ALC_MAXGAIN_SFT);
+	regmap_update_bits(regmap, NAU8310_R2D_ALC_CTRL2,
+		NAU8310_ALC_DCY_MASK | NAU8310_ALC_ATK_MASK |
+		NAU8310_ALC_HLD_MASK, (0x5 << NAU8310_ALC_DCY_SFT) |
+		(0x3 << NAU8310_ALC_ATK_SFT) | (0x5 << NAU8310_ALC_HLD_SFT));
+	regmap_update_bits(regmap, NAU8310_R2E_ALC_CTRL3,
+		NAU8310_LIM_MDE_MASK | NAU8310_VBAT_THLD_MASK,
+		(0x3 << NAU8310_LIM_MDE_SFT) | (0x18 << NAU8310_VBAT_THLD_SFT));
+
+	if (!nau8310->clock_detection)
+		clk_det |= NAU8310_CLKPWRUP_DIS;
+	if (nau8310->clock_det_data)
+		clk_det |= NAU8310_APWRUP_EN;
+	regmap_update_bits(regmap, NAU8310_R40_CLK_DET_CTRL,
+		NAU8310_CLKPWRUP_DIS | NAU8310_PWRUP_DFT | NAU8310_APWRUP_EN, clk_det);
+
+	/* Boost Target Limit and Margin */
+	regmap_update_bits(regmap, NAU8310_R17_BOOST_CTRL1,
+		NAU8310_BSTLIMIT_MASK | NAU8310_BSTMARGIN_MASK,
+		(nau8310->boost_target_limit << NAU8310_BSTLIMIT_SFT) |
+		nau8310->boost_target_margin);
+	/* Temperature compensation */
+	regmap_update_bits(regmap, NAU8310_R30_TEMP_COMP_CTRL,
+		NAU8310_TEMP_COMP_ACT2_MASK, 0);
+	/* Low pass filter control */
+	regmap_update_bits(regmap, NAU8310_R33_LPF_CTRL,
+		NAU8310_LPF_IN1_EN | NAU8310_LPF_IN1_TC_MASK |
+		NAU8310_LPF_IN2_EN | NAU8310_LPF_IN2_TC_MASK,
+		NAU8310_LPF_IN1_EN | (0x7 << NAU8310_LPF_IN1_TC_SFT) |
+		NAU8310_LPF_IN2_EN | (0x7 << NAU8310_LPF_IN2_TC_SFT));
+	/* Set Boost Attack/Decay, Hold Time and TC EN */
+	regmap_update_bits(regmap, NAU8310_R18_BOOST_CTRL2, NAU8310_TC_EN |
+		NAU8310_BSTHOLD_MASK | NAU8310_BSTSTEPTIME_MASK |
+		NAU8310_BSTDELAY_MASK, (nau8310->temp_compensation << NAU8310_TC_SFT) |
+		(0xf << NAU8310_BSTHOLD_SFT) |
+		(0x7 << NAU8310_BSTSTEPTIME_SFT) | nau8310->boost_delay);
+	/* DAC Reference Voltage Setting */
+	regmap_update_bits(regmap, NAU8310_R73_RDAC,
+		NAU8310_DACVREFSEL_MASK, nau8310->dac_vref << NAU8310_DACVREFSEL_SFT);
+	/* DAC Reference Voltage Decoupling Capacitors. */
+	regmap_update_bits(regmap, NAU8310_R63_ANALOG_CONTROL_3,
+		NAU8310_DACREFCAP_MASK, 0x3 << NAU8310_DACREFCAP_SFT);
+	/* Auto-Att Min Gain 12dB, Class-D P&N Driver Slew Rate +75%. */
+	regmap_update_bits(regmap, NAU8310_R64_ANALOG_CONTROL_4,
+		NAU8310_AUTOATTMIN_MASK | NAU8310_CLASSD_SLEWN_MASK |
+		NAU8310_CLASSD_SLEWP_MASK | NAU8310_CLASSD_SHORTP_MASK |
+		NAU8310_CLASSD_SHORTN_MASK,
+		NAU8310_CLASSD_SHORTP_100UP | NAU8310_AUTOATTMIN_12DB |
+		NAU8310_CLASSD_SLEWP_75UP | NAU8310_CLASSD_SLEWN_75UP);
+	/* Bias Current, Monitor Vboost drops below VBAT,
+	 * Non-Overlapping-Time Control.
+	 */
+	regmap_update_bits(regmap, NAU8310_R65_ANALOG_CONTROL_5,
+		NAU8310_BSTINDR_MASK | NAU8310_BSTCURGEN_MASK |
+		NAU8310_BSTMONEN | NAU8310_BSTCLKPULSE_MASK,
+		(0x4 << NAU8310_BSTINDR_SFT) | NAU8310_BSTMONEN |
+		(0xd << NAU8310_BSTCURGEN_SFT) | 0x2);
+	/* Slew Rate Adjust, Bias Current. */
+	regmap_update_bits(regmap, NAU8310_R66_ANALOG_CONTROL_6,
+		NAU8310_BSTSLEWPOFF_MASK | NAU8310_BSTSLEWPON_MASK |
+		NAU8310_BSTSLEWNON_MASK | NAU8310_BSTSLEWNOFF_MASK |
+		NAU8310_BSTIPDR_MASK, (0x3 << NAU8310_BSTSLEWPOFF_SFT) |
+		(0x2 << NAU8310_BSTSLEWPON_SFT) | (0x2 << NAU8310_BSTSLEWNON_SFT) |
+		(0x1 << NAU8310_BSTSLEWNOFF_SFT) | 0x4);
+
+	if (nau8310->silicon_id == NAU8310_REG_SI_REV_G10)
+		/* Peak Current 4A, Low Voltage 2.8V */
+		ana_ctrl = (0x11 << NAU8310_VBAT_PCL_SFT) | (0xf << NAU8310_VBAT_THD_SFT);
+	else if (nau8310->silicon_id == NAU8310_REG_SI_REV_G20)
+		/* Peak Current 1A, Low Voltage 3.6V */
+		ana_ctrl = (0x7 << NAU8310_VBAT_THD_SFT);
+
+	regmap_update_bits(regmap, NAU8310_R6B_ANALOG_CONTROL_8,
+		NAU8310_VBAT_PCL_MASK | NAU8310_VBAT_THD_MASK, ana_ctrl);
+
+	/* current limiting for low VBAT level */
+	regmap_update_bits(regmap, NAU8310_R6C_ANALOG_CONTROL_9,
+		NAU8310_VBAT_CURLMT_MASK, 0xf);
+	/* VMID Tieoff (VMID Resistor Selection) */
+	regmap_update_bits(regmap, NAU8310_R60_BIAS_ADJ,
+		NAU8310_BIAS_VMID_SEL_MASK,
+		nau8310->vref_impedance << NAU8310_BIAS_VMID_SEL_SFT);
+	/* VREF Bandgap buffer ON, I/V Sense Ref Buffer Setting -1.5dB. */
+	regmap_update_bits(regmap, NAU8310_R68_ANALOG_CONTROL_7,
+		NAU8310_ADCGAIN_MASK | NAU8310_VREFBG_EN,
+		(0x3 << NAU8310_ADCGAIN_SFT) | NAU8310_VREFBG_EN);
+	nau8310_software_reset(regmap);
+	/* Enable VMID, BIAS, DAC, DCA CLOCK, ADC, Voltage/Current Amps,
+	 * ADC Resetb gated by 'PowerUp' Signal.
+	 */
+	regmap_update_bits(regmap, NAU8310_R61_ANALOG_CONTROL_1,
+		NAU8310_ISEN_MASK | NAU8310_ADCRSTEN_MASK |
+		NAU8310_VSEN_MASK | NAU8310_ADCEN_MASK |
+		NAU8310_DACCLKEN_MASK | NAU8310_DACEN_MASK |
+		NAU8310_BIASEN_MASK | NAU8310_VMIDEN_MASK,
+		(0x1 << NAU8310_ISEN_SFT) | (0x1 << NAU8310_ADCRSTEN_SFT) |
+		(0x1 << NAU8310_VSEN_SFT) | (0x1 << NAU8310_ADCEN_SFT) |
+		(0x1 << NAU8310_DACCLKEN_SFT) | (0x1 << NAU8310_DACEN_SFT) |
+		(0x1 << NAU8310_BIASEN_SFT) | 0x1);
+	/* Enable Boost Converter, VMID Fast, Class-D gated by
+	 * 'PowerUp' Signal
+	 */
+	regmap_update_bits(regmap, NAU8310_R62_ANALOG_CONTROL_2,
+		NAU8310_CLASSDEN_MASK | NAU8310_PDVMDFST_MASK |
+		NAU8310_BSTEN_MASK, (0x1 << NAU8310_CLASSDEN_SFT) |
+		(0x1 << NAU8310_PDVMDFST_SFT) | nau8310->boost_convert_enable);
+	regmap_update_bits(regmap, NAU8310_R07_SAR_CTRL1,
+		NAU8310_SAR_TRACKING_GAIN_MASK | NAU8310_SAR_COMPARE_TIME_MASK |
+		NAU8310_SAR_SAMPLING_TIME_MASK,
+		nau8310->sar_voltage << NAU8310_SAR_TRACKING_GAIN_SFT |
+		nau8310->sar_compare_time << NAU8310_SAR_COMPARE_TIME_SFT |
+		nau8310->sar_sampling_time << NAU8310_SAR_SAMPLING_TIME_SFT);
+}
+
+static void nau8310_print_device_properties(struct nau8310 *nau8310)
+{
+	struct device *dev = nau8310->dev;
+
+	dev_dbg(dev, "vref-impedance:          %d", nau8310->vref_impedance);
+	dev_dbg(dev, "dac-vref:                %d", nau8310->dac_vref);
+	dev_dbg(dev, "sar-voltage:             %d", nau8310->sar_voltage);
+	dev_dbg(dev, "sar-compare-time:        %d", nau8310->sar_compare_time);
+	dev_dbg(dev, "sar-sampling-time:       %d", nau8310->sar_sampling_time);
+	dev_dbg(dev, "clock-det-disable:       %d", nau8310->clock_detection);
+	dev_dbg(dev, "clock-det-data:          %d", nau8310->clock_det_data);
+	dev_dbg(dev, "temp-compensation:       %d", nau8310->temp_compensation);
+	dev_dbg(dev, "boost-delay:             %d", nau8310->boost_delay);
+	dev_dbg(dev, "boost-convert-enable:    %d", nau8310->boost_convert_enable);
+	dev_dbg(dev, "boost-target-limit:      %x", nau8310->boost_target_limit);
+	dev_dbg(dev, "boost-target-margin:     %x", nau8310->boost_target_margin);
+	dev_dbg(dev, "normal-iis-data:         %d", nau8310->normal_iis_data);
+	dev_dbg(dev, "dsp-firmware:            %s", nau8310->dsp_firmware);
+}
+
+static int nau8310_read_device_properties(struct nau8310 *nau8310)
+{
+	const char *def_fws = NAU8310_DSP_FIRMWARE;
+	struct device *dev = nau8310->dev;
+	const char *firmware_names = NULL;
+	int ret;
+
+	ret = device_property_read_u32(dev, "nuvoton,vref-impedance",
+		&nau8310->vref_impedance);
+	if (ret)
+		nau8310->vref_impedance = 2;
+
+	ret = device_property_read_u32(dev, "nuvoton,dac-vref",
+		&nau8310->dac_vref);
+	if (ret)
+		nau8310->dac_vref = 1;
+
+	ret = device_property_read_u32(dev, "nuvoton,sar-voltage",
+		&nau8310->sar_voltage);
+	if (ret)
+		nau8310->sar_voltage = 0;
+
+	ret = device_property_read_u32(dev, "nuvoton,sar-compare-time",
+		&nau8310->sar_compare_time);
+	if (ret)
+		nau8310->sar_compare_time = 1;
+
+	ret = device_property_read_u32(dev, "nuvoton,sar-sampling-time",
+		&nau8310->sar_sampling_time);
+	if (ret)
+		nau8310->sar_sampling_time = 1;
+
+	nau8310->clock_detection =
+		!device_property_read_bool(dev,	"nuvoton,clock-det-disable");
+	nau8310->clock_det_data =
+		device_property_read_bool(dev, "nuvoton,clock-det-data");
+	nau8310->temp_compensation =
+		device_property_read_bool(dev, "nuvoton,temp-compensation");
+	if (nau8310->silicon_id == NAU8310_REG_SI_REV_G10) {
+		ret = device_property_read_u32(dev, "nuvoton,boost-delay",
+			&nau8310->boost_delay);
+		if (ret)
+			nau8310->boost_delay = 0x8;
+
+		ret = device_property_read_u32(dev, "nuvoton,boost-convert-enable",
+			&nau8310->boost_convert_enable);
+		if (ret)
+			nau8310->boost_convert_enable = 0x0;
+
+		ret = device_property_read_u32(dev, "nuvoton,boost-target-limit",
+			&nau8310->boost_target_limit);
+		if (ret)
+			nau8310->boost_target_limit = 0x32;
+
+		ret = device_property_read_u32(dev, "nuvoton,boost-target-margin",
+			&nau8310->boost_target_margin);
+		if (ret)
+			nau8310->boost_target_margin = 0x2;
+	}
+	nau8310->normal_iis_data =
+		device_property_read_bool(dev, "nuvoton,normal-iis-data");
+
+	ret = device_property_read_string(dev, "firmware-name",
+		&firmware_names);
+
+	if (ret) {
+		nau8310->dsp_firmware = devm_kstrdup(dev, def_fws, GFP_KERNEL);
+
+		if (!nau8310->dsp_firmware)
+			return -ENOMEM;
+	} else {
+		nau8310->dsp_firmware = devm_kasprintf(dev, GFP_KERNEL,
+			NAU8310_DSP_FIRMDIR "%s", firmware_names);
+
+		if (!nau8310->dsp_firmware)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int nau8310_i2c_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct nau8310 *nau8310;
+	int ret, value;
+
+	nau8310 = devm_kzalloc(dev, sizeof(*nau8310), GFP_KERNEL);
+	if (!nau8310)
+		return -ENOMEM;
+
+	i2c_set_clientdata(i2c, nau8310);
+	mutex_init(&nau8310->lock);
+	INIT_WORK(&nau8310->load_fw_work, nau8310_load_fw_work);
+
+	nau8310->regmap = devm_regmap_init(dev, NULL, i2c, &nau8310_regmap_config);
+	if (IS_ERR(nau8310->regmap))
+		return PTR_ERR(nau8310->regmap);
+
+	nau8310->dev = dev;
+
+	nau8310_reset_chip(nau8310->regmap);
+	ret = regmap_read(nau8310->regmap, NAU8310_R46_I2C_DEVICE_ID, &value);
+	if (ret) {
+		dev_err(dev, "Failed to read NAU8310/20 device id: %d", ret);
+		return ret;
+	}
+
+	nau8310->silicon_id = value & NAU8310_REG_SI_REV_MASK;
+	ret = nau8310_read_device_properties(nau8310);
+	if (ret)
+		return ret;
+
+	nau8310_print_device_properties(nau8310);
+	nau8310_init_regs(nau8310);
+
+	return devm_snd_soc_register_component(dev, &soc_comp_dev_nau8310,
+		&nau8310_dai, 1);
+}
+
+static void nau8310_i2c_remove(struct i2c_client *client)
+{
+	struct nau8310 *nau8310 = i2c_get_clientdata(client);
+
+	cancel_work_sync(&nau8310->load_fw_work);
+}
+
+static const struct i2c_device_id nau8310_i2c_ids[] = {
+	{ .name = "nau8310" },
+	{ .name = "nau8320" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, nau8310_i2c_ids);
+
+static const struct of_device_id nau8310_of_ids[] = {
+	{ .compatible = "nuvoton,nau8310" },
+	{ .compatible = "nuvoton,nau8320" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, nau8310_of_ids);
+
+static const struct acpi_device_id nau8310_acpi_match[] = {
+	{ .id = "NVTN2000" },
+	{ .id = "NVTN2001" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, nau8310_acpi_match);
+
+static struct i2c_driver nau8310_i2c_driver = {
+	.driver = {
+		.name = "nau8310",
+		.of_match_table = of_match_ptr(nau8310_of_ids),
+		.acpi_match_table = ACPI_PTR(nau8310_acpi_match),
+	},
+	.probe = nau8310_i2c_probe,
+	.remove = nau8310_i2c_remove,
+	.id_table = nau8310_i2c_ids,
+};
+module_i2c_driver(nau8310_i2c_driver);
+
+MODULE_DESCRIPTION("ASoC NAU83G10/20 Boosted Mono Class-D Amplifier with DSP and I/V-sense driver");
+MODULE_AUTHOR("John Hsu <kchsu0@nuvoton.com>");
+MODULE_AUTHOR("David Lin <ctlin0@nuvoton.com>");
+MODULE_AUTHOR("Neo Chang <ylchang2@nuvoton.com>");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/nau8310.h b/sound/soc/codecs/nau8310.h
new file mode 100644
index 000000000000..f0c32b3d09b9
--- /dev/null
+++ b/sound/soc/codecs/nau8310.h
@@ -0,0 +1,629 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// The NAU83G10/20 Boosted Mono Class-D Amplifier with DSP and I/V-sense driver.
+//
+// Copyright 2026 Nuvoton Technology Crop.
+// Author: John Hsu <KCHSU0@nuvoton.com>
+//         David Lin <ctlin0@nuvoton.com>
+//         Neo Chang <ylchang2@nuvoton.com>
+
+#ifndef __NAU8310_H__
+#define __NAU8310_H__
+
+#define NAU8310_R00_HARDWARE_RST		0x00
+#define NAU8310_R01_SOFTWARE_RST		0x01
+#define NAU8310_R02_I2C_ADDR			0x02
+#define NAU8310_R03_CLK_CTRL			0x03
+#define NAU8310_R04_ENA_CTRL			0x04
+#define NAU8310_R05_INTERRUPT_CTRL		0x05
+#define NAU8310_R06_INT_CLR_STATUS		0x06
+#define NAU8310_R07_SAR_CTRL1			0x07
+#define NAU8310_R08_GPIO124_CTRL		0x08
+#define NAU8310_R09_GPIOOUT			0x09
+#define NAU8310_R0A_IO_CTRL			0x0a
+#define NAU8310_R0B_I2S_PCM_CTRL0		0x0b
+#define NAU8310_R0C_TDM_CTRL			0x0c
+#define NAU8310_R0D_I2S_PCM_CTRL1		0x0d
+#define NAU8310_R0E_I2S_PCM_CTRL2		0x0e
+#define NAU8310_R0F_LEFT_TIME_SLOT		0x0f
+#define NAU8310_R10_RIGHT_TIME_SLOT		0x10
+#define NAU8310_R12_HPF_CTRL			0x12
+#define NAU8310_R13_MUTE_CTRL			0x13
+#define NAU8310_R14_ADC_VOL_CTRL		0x14
+#define NAU8310_R15_INT_COE			0x15
+#define NAU8310_R16_DEC_COE			0x16
+#define NAU8310_R17_BOOST_CTRL1			0x17
+#define NAU8310_R18_BOOST_CTRL2			0x18
+#define NAU8310_R19_DSP_CORE_CTRL1		0x19
+#define NAU8310_R1A_DSP_CORE_CTRL2		0x1a
+#define NAU8310_R1B_CLK_DOUBLER_O		0x1b
+#define NAU8310_R1C_BOOST_CTRL_O		0x1c
+#define NAU8310_R1D_GENERAL_STATUS0		0x1d
+#define NAU8310_R1E_GENERAL_STATUS1		0x1e
+#define NAU8310_R1F_GENERAL_STATUS2		0x1f
+#define NAU8310_R20_SAR_ADC_OUT_01		0x20
+#define NAU8310_R21_SAR_ADC_OUT_23		0x21
+#define NAU8310_R22_ALC_READOUT1		0x22
+#define NAU8310_R23_ALC_READOUT2		0x23
+#define NAU8310_R24_ALC_READOUT3		0x24
+#define NAU8310_R25_DSP_STATUS_0		0x25
+#define NAU8310_R26_DSP_STATUS_1		0x26
+#define NAU8310_R27_DSP_STATUS_2		0x27
+#define NAU8310_R28_ADC_RATE			0x28
+#define NAU8310_R29_DAC_CTRL1			0x29
+#define NAU8310_R2A_DAC_CTRL2			0x2a
+#define NAU8310_R2C_ALC_CTRL1			0x2c
+#define NAU8310_R2D_ALC_CTRL2			0x2d
+#define NAU8310_R2E_ALC_CTRL3			0x2e
+#define NAU8310_R2F_ALC_CTRL4			0x2f
+#define NAU8310_R30_TEMP_COMP_CTRL		0x30
+#define NAU8310_R31_UVLO_CTRL0			0x31
+#define NAU8310_R32_UVLO_CTRL1			0x32
+#define NAU8310_R33_LPF_CTRL			0x33
+#define NAU8310_R40_CLK_DET_CTRL		0x40
+#define NAU8310_R46_I2C_DEVICE_ID		0x46
+#define NAU8310_R4A_ANALOG_READ			0x4a
+#define NAU8310_R55_MISC_CTRL			0x55
+#define NAU8310_R60_BIAS_ADJ			0x60
+#define NAU8310_R61_ANALOG_CONTROL_1		0x61
+#define NAU8310_R62_ANALOG_CONTROL_2		0x62
+#define NAU8310_R63_ANALOG_CONTROL_3		0x63
+#define NAU8310_R64_ANALOG_CONTROL_4		0x64
+#define NAU8310_R65_ANALOG_CONTROL_5		0x65
+#define NAU8310_R66_ANALOG_CONTROL_6		0x66
+#define NAU8310_R68_ANALOG_CONTROL_7		0x68
+#define NAU8310_R69_CLIP_CTRL			0x69
+#define NAU8310_R6B_ANALOG_CONTROL_8		0x6b
+#define NAU8310_R6C_ANALOG_CONTROL_9		0x6c
+#define NAU8310_R71_ANALOG_ADC_1		0x71
+#define NAU8310_R72_ANALOG_ADC_2		0x72
+#define NAU8310_R73_RDAC			0x73
+#define NAU8310_R76_BOOST			0x76
+#define NAU8310_R77_FEPGA			0x77
+#define NAU8310_R7F_POWER_UP_CONTROL		0x7f
+#define NAU8310_R80_BIQ0_COE_1			0x80
+#define NAU8310_R81_BIQ0_COE_2			0x81
+#define NAU8310_R82_BIQ0_COE_3			0x82
+#define NAU8310_R83_BIQ0_COE_4			0x83
+#define NAU8310_R84_BIQ0_COE_5			0x84
+#define NAU8310_R85_BIQ0_COE_6			0x85
+#define NAU8310_R86_BIQ0_COE_7			0x86
+#define NAU8310_R87_BIQ0_COE_8			0x87
+#define NAU8310_R88_BIQ0_COE_9			0x88
+#define NAU8310_R89_BIQ0_COE_10			0x89
+#define NAU8310_R8A_BIQ1_COE_1			0x8a
+#define NAU8310_R8B_BIQ1_COE_2			0x8b
+#define NAU8310_R8C_BIQ1_COE_3			0x8c
+#define NAU8310_R8D_BIQ1_COE_4			0x8d
+#define NAU8310_R8E_BIQ1_COE_5			0x8e
+#define NAU8310_R8F_BIQ1_COE_6			0x8f
+#define NAU8310_R90_BIQ1_COE_7			0x90
+#define NAU8310_R91_BIQ1_COE_8			0x91
+#define NAU8310_R92_BIQ1_COE_9			0x92
+#define NAU8310_R93_BIQ1_COE_10			0x93
+#define NAU8310_R94_BIQ2_COE_1			0x94
+#define NAU8310_R95_BIQ2_COE_2			0x95
+#define NAU8310_R96_BIQ2_COE_3			0x96
+#define NAU8310_R97_BIQ2_COE_4			0x97
+#define NAU8310_R98_BIQ2_COE_5			0x98
+#define NAU8310_R99_BIQ2_COE_6			0x99
+#define NAU8310_R9A_BIQ2_COE_7			0x9a
+#define NAU8310_R9B_BIQ2_COE_8			0x9b
+#define NAU8310_R9C_BIQ2_COE_9			0x9c
+#define NAU8310_R9D_BIQ2_COE_10			0x9d
+#define NAU8310_RF000_DSP_COMM			0xf000
+#define NAU8310_REG_MAX				NAU8310_RF000_DSP_COMM
+/* 16-bit control register address, and 16-bits control register data */
+#define NAU8310_REG_ADDR_LEN			16
+#define NAU8310_REG_DATA_LEN			16
+
+
+/* CLK_CTRL (0x03) */
+#define NAU8310_CLK_ADC_DIV2_SFT		12
+#define NAU8310_CLK_ADC_DIV2			(0x1 << NAU8310_CLK_ADC_DIV2_SFT)
+#define NAU8310_CLK_ADC_DIV4_SFT		11
+#define NAU8310_CLK_ADC_DIV4			(0x1 << NAU8310_CLK_ADC_DIV4_SFT)
+#define NAU8310_CLK_ADC_SRC_SFT			6
+#define NAU8310_CLK_ADC_SRC_MASK		(0x3 << NAU8310_CLK_ADC_SRC_SFT)
+#define NAU8310_CLK_DAC_SRC_SFT			4
+#define NAU8310_CLK_DAC_SRC_MASK		(0x3 << NAU8310_CLK_DAC_SRC_SFT)
+#define NAU8310_MCLK_SRC_MASK			0x7
+
+/* ENA_CTRL (0x04) */
+#define NAU8310_DSP_OSC_SFT			14
+#define NAU8310_DSP_OSC_EN			(0x1 << NAU8310_DSP_OSC_SFT)
+#define NAU8310_DSP_SEL_OSC_SFT			13
+#define NAU8310_DSP_SEL_OSC			(0x1 << NAU8310_DSP_SEL_OSC_SFT)
+#define NAU8310_MCLK_SEL_SFT			8
+#define NAU8310_MCLK_SEL_MASK			(0x7 << NAU8310_MCLK_SEL_SFT)
+#define NAU8310_CLK_MUL_SRC_SFT			6
+#define NAU8310_CLK_MUL_SRC_MASK		(0x3 << NAU8310_CLK_MUL_SRC_SFT)
+#define NAU8310_CLK_DSP_SRC_SFT			3
+#define NAU8310_CLK_DSP_SRC_MASK		(0x7 << NAU8310_CLK_DSP_SRC_SFT)
+#define NAU8310_DAC_CH_EN_SFT			2
+#define NAU8310_DAC_CH_EN			(0x1 << NAU8310_DAC_CH_EN_SFT)
+#define NAU8310_ADCEN_I_SFT			1
+#define NAU8310_ADCEN_I				(0x1 << NAU8310_ADCEN_I_SFT)
+#define NAU8310_ADCEN_V_SFT			0
+#define NAU8310_ADCEN_V				(0x1 << NAU8310_ADCEN_V_SFT)
+
+/* INTERRUPT_CTRL (0x05) */
+#define NAU8310_WD_INT_MASK_SFT			14
+#define NAU8310_WD_INT_MASK			(0x1 << NAU8310_WD_INT_MASK_SFT)
+#define NAU8310_DSP2I2C_INT_MASK_SFT		13
+#define NAU8310_DSP2I2C_INT_MASK		(0x1 << NAU8310_DSP2I2C_INT_MASK_SFT)
+#define NAU8310_ARP_DWN_INT_MASK_SFT		12
+#define NAU8310_ARP_DWN_INT_MASK		(0x1 << NAU8310_ARP_DWN_INT_MASK_SFT)
+#define NAU8310_CLIP_INT_MASK_SFT		11
+#define NAU8310_CLIP_INT_MASK			(0x1 << NAU8310_CLIP_INT_MASK_SFT)
+#define NAU8310_LVD_INT_MASK_SFT		10
+#define NAU8310_LVD_INT_MASK			(0x1 << NAU8310_LVD_INT_MASK_SFT)
+#define NAU8310_OVP_INT_MASK_SFT		9
+#define NAU8310_OVP_INT_MASK			(0x1 << NAU8310_OVP_INT_MASK_SFT)
+#define NAU8310_PWR_INT_DIS_SFT			8
+#define NAU8310_PWR_INT_DIS			(0x1 << NAU8310_PWR_INT_DIS_SFT)
+#define NAU8310_WD_INT_DIS_SFT			6
+#define NAU8310_WD_INT_DIS			(0x1 << NAU8310_WD_INT_DIS_SFT)
+#define NAU8310_DSP2I2C_INT_DIS_SFT		5
+#define NAU8310_DSP2I2C_INT_DIS			(0x1 << NAU8310_DSP2I2C_INT_DIS_SFT)
+#define NAU8310_ARP_DWN_INT_DIS_SFT		4
+#define NAU8310_ARP_DWN_INT_DIS			(0x1 << NAU8310_ARP_DWN_INT_DIS_SFT)
+#define NAU8310_CLIP_INT_DIS_SFT		3
+#define NAU8310_CLIP_INT_DIS			(0x1 << NAU8310_CLIP_INT_DIS_SFT)
+#define NAU8310_LVD_INT_DIS_SFT			2
+#define NAU8310_LVD_INT_DIS			(0x1 << NAU8310_LVD_INT_DIS_SFT)
+#define NAU8310_OVP_INT_DIS_SFT			1
+#define NAU8310_OVP_INT_DIS			(0x1 << NAU8310_OVP_INT_DIS_SFT)
+#define NAU8310_PWR_INT_MASK			0x1
+
+/* INT_CLR_STATUS (0x06) */
+#define NAU8310_INT_STATUS_MASK			0x7ff
+#define NAU8310_INT_STATUS_WD			(0x1 << 6)
+#define NAU8310_INT_STATUS_DSP2I2C		(0x1 << 5)
+#define NAU8310_INT_STATUS_ARP_DWN		(0x1 << 4)
+#define NAU8310_INT_STATUS_CLIP			(0x1 << 3)
+#define NAU8310_INT_STATUS_LVD			(0x1 << 2)
+#define NAU8310_INT_STATUS_OVP			(0x1 << 1)
+#define NAU8310_INT_STATUS_PWR			0x1
+
+/* SAR_CTRL1 (0x07) */
+#define NAU8310_SAR_TRACKING_GAIN_SFT		11
+#define NAU8310_SAR_TRACKING_GAIN_MASK		(0x7 << NAU8310_SAR_TRACKING_GAIN_SFT)
+#define NAU8310_SAR_COMPARE_TIME_SFT		5
+#define NAU8310_SAR_COMPARE_TIME_MASK		(0x3 << NAU8310_SAR_COMPARE_TIME_SFT)
+#define NAU8310_SAR_SAMPLING_TIME_SFT		2
+#define NAU8310_SAR_SAMPLING_TIME_MASK		(0x3 << NAU8310_SAR_SAMPLING_TIME_SFT)
+#define NAU8310_SAR_ENA_SFT			0
+#define NAU8310_SAR_ENA_EN			(0x1 << NAU8310_SAR_ENA_SFT)
+
+/* IO_CTRL (0x0a) */
+#define NAU8310_IRQ_PL_SFT			15
+#define NAU8310_IRQ_PL_ACT_HIGH			(0x1 << NAU8310_IRQ_PL_SFT)
+#define NAU8310_IRQ_DS_SFT			12
+#define NAU8310_IRQ_DS_HIGH			(0x1 << NAU8310_IRQ_DS_SFT)
+#define NAU8310_IRQ_OUTPUT_SFT			11
+#define NAU8310_IRQ_OUTPUT_EN			(0x1 << NAU8310_IRQ_OUTPUT_SFT)
+#define NAU8310_BCLK_DS_SFT			2
+#define NAU8310_BCLK_DS_EN			(0x1 << NAU8310_BCLK_DS_SFT)
+#define NAU8310_LRC_DS_SFT			1
+#define NAU8310_LRC_DS_EN			(0x1 << NAU8310_LRC_DS_SFT)
+#define NAU8310_ADCDAT_DS_SFT			0
+#define NAU8310_ADCDAT_DS_EN			0x1
+
+/* I2S_PCM_CTRL0 (0x0b) */
+#define NAU8310_ALC_MODE_SFT			15
+#define NAU8310_ALC_MODE			(0x1 << NAU8310_ALC_MODE_SFT)
+#define NAU8310_ALC_SEND_ON_LOC_SFT		14
+#define NAU8310_ALC_SEND_ON_LOC			(0x1 << NAU8310_ALC_SEND_ON_LOC_SFT)
+#define NAU8310_DAC_SEL_SFT			10
+#define NAU8310_DAC_SEL_MASK			(0x7 << NAU8310_DAC_SEL_SFT)
+#define NAU8310_DAC_SEL_SLOT0			0
+#define NAU8310_DAC_SEL_SLOT1			(0x1 << NAU8310_DAC_SEL_SFT)
+#define NAU8310_DAC_SEL_SLOT2			(0x2 << NAU8310_DAC_SEL_SFT)
+#define NAU8310_DAC_SEL_SLOT3			(0x3 << NAU8310_DAC_SEL_SFT)
+#define NAU8310_DAC_SEL_SLOT4			(0x4 << NAU8310_DAC_SEL_SFT)
+#define NAU8310_DAC_SEL_SLOT5			(0x5 << NAU8310_DAC_SEL_SFT)
+#define NAU8310_DAC_SEL_SLOT6			(0x6 << NAU8310_DAC_SEL_SFT)
+#define NAU8310_DAC_SEL_SLOT7			(0x7 << NAU8310_DAC_SEL_SFT)
+#define NAU8310_AEC_CH_SEL_SFT			2
+#define NAU8310_AEC_CH_SEL_RIGHT		(0x0 << NAU8310_AEC_CH_SEL_SFT)
+#define NAU8310_AEC_CH_SEL_LEFT			(0x1 << NAU8310_AEC_CH_SEL_SFT)
+#define NAU8310_AEC_SRC_SEL_SFT			1
+#define NAU8310_AEC_SRC_SEL_DSP			(0x0 << NAU8310_AEC_SRC_SEL_SFT)
+#define NAU8310_AEC_SRC_SEL_DAC			(0x1 << NAU8310_AEC_SRC_SEL_SFT)
+#define NAU8310_AEC_MODE_SFT			0
+#define NAU8310_AEC_MODE_IV			(0x0 << NAU8310_AEC_MODE_SFT)
+#define NAU8310_AEC_MODE_AEC			(0x1 << NAU8310_AEC_MODE_SFT)
+
+/* TDM_CTRL (0x0c) */
+#define NAU8310_TDM_SFT				15
+#define NAU8310_TDM_EN				(0x1 << NAU8310_TDM_SFT)
+#define NAU8310_TDM_OFFSET_SFT			14
+#define NAU8310_TDM_OFFSET_EN			(0x1 << NAU8310_TDM_OFFSET_SFT)
+#define NAU8310_PINGPONG_SFT			13
+#define NAU8310_PINGPONG_EN			(0x1 << NAU8310_PINGPONG_SFT)
+#define NAU8310_ADC_ALC_SEL_SFT			6
+#define NAU8310_ADC_ALC_SEL_MASK		(0xf << NAU8310_ADC_ALC_SEL_SFT)
+#define NAU8310_ADC_I_SEL_SFT			3
+#define NAU8310_ADC_I_SEL_MASK			(0x7 << NAU8310_ADC_I_SEL_SFT)
+#define NAU8310_ADC_I_SEL_DIS			0
+#define NAU8310_ADC_I_SEL_SLOT1			(0x4 << NAU8310_ADC_I_SEL_SFT)
+#define NAU8310_ADC_I_SEL_SLOT3			(0x5 << NAU8310_ADC_I_SEL_SFT)
+#define NAU8310_ADC_I_SEL_SLOT5			(0x6 << NAU8310_ADC_I_SEL_SFT)
+#define NAU8310_ADC_I_SEL_SLOT7			(0x7 << NAU8310_ADC_I_SEL_SFT)
+#define NAU8310_ADC_V_SEL_SFT			0
+#define NAU8310_ADC_V_SEL_MASK			0x7
+#define NAU8310_ADC_V_SEL_DIS			0
+#define NAU8310_ADC_V_SEL_SLOT0			0x4
+#define NAU8310_ADC_V_SEL_SLOT2			0x5
+#define NAU8310_ADC_V_SEL_SLOT4			0x6
+#define NAU8310_ADC_V_SEL_SLOT6			0x7
+
+/* I2S_PCM_CTRL1 (0x0d) */
+#define NAU8310_I2S_BP_SFT			7
+#define NAU8310_I2S_BP_MASK			(0x1 << NAU8310_I2S_BP_SFT)
+#define NAU8310_I2S_BP_INV			(0x1 << NAU8310_I2S_BP_SFT)
+#define NAU8310_I2S_PCMB_SFT			6
+#define NAU8310_I2S_PCMB_EN			(0x1 << NAU8310_I2S_PCMB_SFT)
+#define NAU8310_I2S_DL_SFT			2
+#define NAU8310_I2S_DL_MASK			(0x3 << NAU8310_I2S_DL_SFT)
+#define NAU8310_I2S_DL_16			(0x0 << NAU8310_I2S_DL_SFT)
+#define NAU8310_I2S_DL_20			(0x1 << NAU8310_I2S_DL_SFT)
+#define NAU8310_I2S_DL_24			(0x2 << NAU8310_I2S_DL_SFT)
+#define NAU8310_I2S_DL_32			(0x3 << NAU8310_I2S_DL_SFT)
+#define NAU8310_I2S_DF_MASK			0x3
+#define NAU8310_I2S_DF_RIGHT			0x0
+#define NAU8310_I2S_DF_LEFT			0x1
+#define NAU8310_I2S_DF_I2S			0x2
+#define NAU8310_I2S_DF_PCM_AB			0x3
+
+/* I2S_PCM_CTRL2 (0x0e) */
+#define NAU8310_I2S_TRISTATE_SFT		15
+#define NAU8310_I2S_TRISTATE			(1 << NAU8310_I2S_TRISTATE_SFT)
+#define NAU8310_I2S_LRC_DIV_SFT			12
+#define NAU8310_I2S_LRC_DIV_MASK		(0x3 << NAU8310_I2S_LRC_DIV_SFT)
+#define NAU8310_I2S_ADCDAT_OE_SFT		4
+#define NAU8310_I2S_ADCDAT_OE_MASK		(1 << NAU8310_I2S_ADCDAT_OE_SFT)
+#define NAU8310_I2S_ADCDAT_OE_EN		(0 << NAU8310_I2S_ADCDAT_OE_SFT)
+#define NAU8310_I2S_ADCDAT_OE_DIS		(1 << NAU8310_I2S_ADCDAT_OE_SFT)
+#define NAU8310_I2S_MS_SFT			3
+#define NAU8310_I2S_MS_MASK			(0x1 << NAU8310_I2S_MS_SFT)
+#define NAU8310_I2S_MS_MASTER			(0x1 << NAU8310_I2S_MS_SFT)
+#define NAU8310_I2S_BLK_DIV_MASK		0x7
+
+/* MUTE_CTRL (0x13) */
+#define NAU8310_SOFT_MUTE_SFT			15
+#define NAU8310_SOFT_MUTE			(0x1 << NAU8310_SOFT_MUTE_SFT)
+#define NAU8310_DAC_ZE_SFT			8
+#define NAU8310_DAC_ZE_EN			(0x1 << NAU8310_DAC_ZE_SFT)
+#define NAU8310_DAC_VOL_SFT			0
+#define NAU8310_DAC_VOL_MAX			0xff
+
+/* ADC_VOL_CTRL (0x14) */
+#define NAU8310_ADC_GAIN_L_SFT			8
+#define NAU8310_ADC_GAIN_L_MAX			0xc1
+#define NAU8310_ADC_GAIN_L_MASK			(0xff << NAU8310_ADC_GAIN_L_SFT)
+#define NAU8310_ADC_GAIN_R_SFT			0
+#define NAU8310_ADC_GAIN_R_MAX			0xc1
+#define NAU8310_ADC_GAIN_R_MASK			0xff
+
+/* BOOST_CTRL1 (0x17) */
+#define NAU8310_BSTLIMIT_SFT			8
+#define NAU8310_BSTLIMIT_MAX			0x3f
+#define NAU8310_BSTLIMIT_MASK			(0x3f << NAU8310_BSTLIMIT_SFT)
+#define NAU8310_BSTMARGIN_SFT			0
+#define NAU8310_BSTMARGIN_MAX			0x3f
+#define NAU8310_BSTMARGIN_MASK			0x3f
+
+/* BOOST_CTRL2 (0x18) */
+#define NAU8310_TC_SFT				15
+#define NAU8310_TC_EN				(0x1 << NAU8310_TC_SFT)
+#define NAU8310_BSTHOLD_SFT			7
+#define NAU8310_BSTHOLD_MASK			(0xf << NAU8310_BSTHOLD_SFT)
+#define NAU8310_BSTSTEPTIME_SFT			4
+#define NAU8310_BSTSTEPTIME_MASK		(0x7 << NAU8310_BSTSTEPTIME_SFT)
+#define NAU8310_BSTDELAY_MASK			0xf
+
+/* DSP_CORE_CTRL2 (0x1a) */
+#define NAU8310_DAC_SEL_DSP_SFT			5
+#define NAU8310_DAC_SEL_DSP_OUT			(0x1 << NAU8310_DAC_SEL_DSP_SFT)
+#define NAU8310_DSP_RUNSTALL_SFT		4
+#define NAU8310_DSP_RUNSTALL			(0x1 << NAU8310_DSP_RUNSTALL_SFT)
+
+/* ADC_RATE (0x28) */
+#define NAU8310_I2S_MODE_SFT			15
+#define NAU8310_I2S_MODE			(0x1 << NAU8310_I2S_MODE_SFT)
+#define NAU8310_UNSIGN_IV_SFT			8
+#define NAU8310_UNSIGN_IV			(0x1 << NAU8310_UNSIGN_IV_SFT)
+#define NAU8310_ADC_SYNC_DOWN_SFT		0
+#define NAU8310_ADC_SYNC_DOWN_MASK		0x3
+#define NAU8310_ADC_SYNC_DOWN_32		0
+#define NAU8310_ADC_SYNC_DOWN_64		1
+#define NAU8310_ADC_SYNC_DOWN_128		2
+
+/* DAC_CTRL1 (0x29) */
+#define NAU8310_DAC_OVERSAMPLE_SFT		0
+#define NAU8310_DAC_OVERSAMPLE_MASK		0x7
+#define NAU8310_DAC_OVERSAMPLE_64		0
+#define NAU8310_DAC_OVERSAMPLE_256		1
+#define NAU8310_DAC_OVERSAMPLE_128		2
+#define NAU8310_DAC_OVERSAMPLE_32		4
+
+/* ALC_CTRL1 (0x2c) */
+#define NAU8310_ALC_MAXGAIN_SFT			5
+#define NAU8310_ALC_MAXGAIN_MAX			0x7
+#define NAU8310_ALC_MAXGAIN_MASK		(0x7 << NAU8310_ALC_MAXGAIN_SFT)
+#define NAU8310_ALC_MINGAIN_SFT			1
+#define NAU8310_ALC_MINGAIN_MAX			4
+#define NAU8310_ALC_MINGAIN_MASK		(0x7 << NAU8310_ALC_MINGAIN_SFT)
+#define NAU8310_ALC_GAIN_SEL_SFT		0
+#define NAU8310_ALC_GAIN_SEL_MODE		1
+
+/* ALC_CTRL2 (0x2d) */
+#define NAU8310_ALC_DCY_SFT			12
+#define NAU8310_ALC_DCY_MAX			0xb
+#define NAU8310_ALC_DCY_MASK			(0xf << NAU8310_ALC_DCY_SFT)
+#define NAU8310_ALC_ATK_SFT			8
+#define NAU8310_ALC_ATK_MAX			0xb
+#define NAU8310_ALC_ATK_MASK			(0xf << NAU8310_ALC_ATK_SFT)
+#define NAU8310_ALC_HLD_SFT			4
+#define NAU8310_ALC_HLD_MAX			0xa
+#define NAU8310_ALC_HLD_MASK			(0xf << NAU8310_ALC_HLD_SFT)
+#define NAU8310_ALC_LVL_SFT			0
+#define NAU8310_ALC_LVL_MAX			0xf
+#define NAU8310_ALC_LVL_MASK			0xf
+
+/* ALC_CTRL3 (0x2e) */
+#define NAU8310_ALC_EN_SFT			15
+#define NAU8310_ALC_EN				(0x1 << NAU8310_ALC_EN_SFT)
+#define NAU8310_LIM_MDE_SFT			12
+#define NAU8310_LIM_MDE_MASK			(0x7 << NAU8310_LIM_MDE_SFT)
+#define NAU8310_VBAT_THLD_SFT			5
+#define NAU8310_VBAT_THLD_MAX			0x1f
+#define NAU8310_VBAT_THLD_MASK			(0x1f << NAU8310_VBAT_THLD_SFT)
+#define NAU8310_AUTOATT_EN_SFT			4
+#define NAU8310_AUTOATT_EN			(0x1 << NAU8310_AUTOATT_EN_SFT)
+
+/* TEMP_COMP_CTRL (0x30) */
+#define NAU8310_TEMP_COMP_ACT2_MASK		0xff
+
+/* LPF_CTRL (0x33) */
+#define NAU8310_LPF_IN1_EN_SFT			15
+#define NAU8310_LPF_IN1_EN			(0x1 << NAU8310_LPF_IN1_EN_SFT)
+#define NAU8310_LPF_IN1_TC_SFT			11
+#define NAU8310_LPF_IN1_TC_MASK			(0xf << NAU8310_LPF_IN1_TC_SFT)
+#define NAU8310_LPF_IN2_EN_SFT			10
+#define NAU8310_LPF_IN2_EN			(0x1 << NAU8310_LPF_IN2_EN_SFT)
+#define NAU8310_LPF_IN2_TC_SFT			6
+#define NAU8310_LPF_IN2_TC_MASK			(0xf << NAU8310_LPF_IN2_TC_SFT)
+
+/* CLK_DET_CTRL (0x40) */
+#define NAU8310_APWRUP_SFT			15
+#define NAU8310_APWRUP_EN			(0x1 << NAU8310_APWRUP_SFT)
+#define NAU8310_CLKPWRUP_SFT			14
+#define NAU8310_CLKPWRUP_DIS			(0x1 << NAU8310_CLKPWRUP_SFT)
+#define NAU8310_PWRUP_DFT_SFT			13
+#define NAU8310_PWRUP_DFT			(0x1 << NAU8310_PWRUP_DFT_SFT)
+#define NAU8310_SRATE_SFT			10
+#define NAU8310_SRATE_MASK			(0x7 << NAU8310_SRATE_SFT)
+#define NAU8310_ALT_SRATE_SFT			9
+#define NAU8310_ALT_SRATE_EN			(0x1 << NAU8310_ALT_SRATE_SFT)
+#define NAU8310_DIV_MAX				0x1
+
+/* I2C_DEVICE_ID (0x46) */
+#define NAU8310_I2C_DEVICE_ID_SFT		8
+#define NAU8310_I2C_DEVICE_ID_MASK		(0x7f << NAU8310_I2C_DEVICE_ID_SFT)
+#define NAU8310_REG_SI_REV_MASK			0xff
+#define NAU8310_REG_SI_REV_G10			0xe1
+#define NAU8310_REG_SI_REV_G20			0x61
+
+/* BIAS_ADJ (0x60) */
+#define NAU8310_BIAS_VMID_SEL_SFT		4
+#define NAU8310_BIAS_VMID_SEL_MASK		(0x3 << NAU8310_BIAS_VMID_SEL_SFT)
+
+/* ANALOG_CONTROL_1 (0x61) */
+#define NAU8310_ISEN_SFT			14
+#define NAU8310_ISEN_MASK			(0x3 << NAU8310_ISEN_SFT)
+#define NAU8310_ADCRSTEN_SFT			12
+#define NAU8310_ADCRSTEN_MASK			(0x3 << NAU8310_ADCRSTEN_SFT)
+#define NAU8310_VSEN_SFT			10
+#define NAU8310_VSEN_MASK			(0x3 << NAU8310_VSEN_SFT)
+#define NAU8310_ADCEN_SFT			8
+#define NAU8310_ADCEN_MASK			(0x3 << NAU8310_ADCEN_SFT)
+#define NAU8310_DACCLKEN_SFT			6
+#define NAU8310_DACCLKEN_MASK			(0x3 << NAU8310_DACCLKEN_SFT)
+#define NAU8310_DACEN_SFT			4
+#define NAU8310_DACEN_MASK			(0x3 << NAU8310_DACEN_SFT)
+#define NAU8310_BIASEN_SFT			2
+#define NAU8310_BIASEN_MASK			(0x3 << NAU8310_BIASEN_SFT)
+#define NAU8310_VMIDEN_MASK			0x3
+
+/* ANALOG_CONTROL_2 (0x62) */
+#define NAU8310_CLASSDEN_SFT			4
+#define NAU8310_CLASSDEN_MASK			(0x3 << NAU8310_CLASSDEN_SFT)
+#define NAU8310_PDVMDFST_SFT			2
+#define NAU8310_PDVMDFST_MASK			(0x3 << NAU8310_PDVMDFST_SFT)
+#define NAU8310_BSTEN_MASK			0x3
+
+/* ANALOG_CONTROL_3 (0x63) */
+#define NAU8310_DACREFCAP_SFT			4
+#define NAU8310_DACREFCAP_MASK			(0x3 << NAU8310_DACREFCAP_SFT)
+
+/* ANALOG_CONTROL_4 (0x64) */
+#define NAU8310_RECV_MODE_SFT			15
+#define NAU8310_RECV_MODE			(0x1 << NAU8310_RECV_MODE_SFT)
+#define NAU8310_AUTOATTMIN_SFT			14
+#define NAU8310_AUTOATTMIN_MASK			(0x1 << NAU8310_AUTOATTMIN_SFT)
+#define NAU8310_AUTOATTMIN_12DB			(0x0 << NAU8310_AUTOATTMIN_SFT)
+#define NAU8310_AUTOATTMIN_0DB			(0x1 << NAU8310_AUTOATTMIN_SFT)
+#define NAU8310_CLASSD_SHORTP_SFT		10
+#define NAU8310_CLASSD_SHORTP_MASK		(0xf << NAU8310_CLASSD_SHORTP_SFT)
+#define NAU8310_CLASSD_SHORTP_NOMINAL		(0x0 << NAU8310_CLASSD_SHORTP_SFT)
+#define NAU8310_CLASSD_SHORTP_33UP		(0x1 << NAU8310_CLASSD_SHORTP_SFT)
+#define NAU8310_CLASSD_SHORTP_100UP		(0x3 << NAU8310_CLASSD_SHORTP_SFT)
+#define NAU8310_CLASSD_SHORTP_22DOWN		(0x8 << NAU8310_CLASSD_SHORTP_SFT)
+#define NAU8310_CLASSD_SHORTP_33DOWN		(0xc << NAU8310_CLASSD_SHORTP_SFT)
+#define NAU8310_CLASSD_SHORTN_SFT		6
+#define NAU8310_CLASSD_SHORTN_MASK		(0xf << NAU8310_CLASSD_SHORTN_SFT)
+#define NAU8310_CLASSD_SHORTN_NOMINAL		(0x0 << NAU8310_CLASSD_SHORTN_SFT)
+#define NAU8310_CLASSD_SHORTN_33UP		(0x1 << NAU8310_CLASSD_SHORTN_SFT)
+#define NAU8310_CLASSD_SHORTN_100UP		(0x3 << NAU8310_CLASSD_SHORTN_SFT)
+#define NAU8310_CLASSD_SHORTN_22DOWN		(0x8 << NAU8310_CLASSD_SHORTN_SFT)
+#define NAU8310_CLASSD_SHORTN_33DOWN		(0xc << NAU8310_CLASSD_SHORTN_SFT)
+#define NAU8310_CLASSD_SLEWP_SFT		3
+#define NAU8310_CLASSD_SLEWP_MASK		(0x7 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWP_NOMINAL		(0x0 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWP_25UP		(0x1 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWP_50UP		(0x2 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWP_75UP		(0x3 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWP_OFF		(0x4 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWP_75DOWN		(0x5 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWP_50DOWN		(0x6 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWP_25DOWN		(0x7 << NAU8310_CLASSD_SLEWP_SFT)
+#define NAU8310_CLASSD_SLEWN_SFT		0
+#define NAU8310_CLASSD_SLEWN_MASK		0x7
+#define NAU8310_CLASSD_SLEWN_NOMINAL		0x0
+#define NAU8310_CLASSD_SLEWN_25UP		0x1
+#define NAU8310_CLASSD_SLEWN_50UP		0x2
+#define NAU8310_CLASSD_SLEWN_75UP		0x3
+#define NAU8310_CLASSD_SLEWN_OFF		0x4
+#define NAU8310_CLASSD_SLEWN_75DOWN		0x5
+#define NAU8310_CLASSD_SLEWN_50DOWN		0x6
+#define NAU8310_CLASSD_SLEWN_25DOWN		0x7
+
+/* ANALOG_CONTROL_5 (0x65) */
+#define NAU8310_BSTINDR_SFT			12
+#define NAU8310_BSTINDR_MASK			(0x7 << NAU8310_BSTINDR_SFT)
+#define NAU8310_BSTCURGEN_SFT			8
+#define NAU8310_BSTCURGEN_MASK			(0xf << NAU8310_BSTCURGEN_SFT)
+#define NAU8310_BSTMONEN_SFT			7
+#define NAU8310_BSTMONEN			(0x1 << NAU8310_BSTMONEN_SFT)
+#define NAU8310_BSTNOVPN_SFT			3
+#define NAU8310_BSTNOVPN_MASK			(0x3 << NAU8310_BSTNOVPN_SFT)
+#define NAU8310_BSTCLKPULSE_MASK		0x3
+
+/* ANALOG_CONTROL_6 (0x66) */
+#define NAU8310_BSTRADJ_SFT			12
+#define NAU8310_BSTRADJ_MASK			(0x7 << NAU8310_BSTRADJ_SFT)
+#define NAU8310_BSTSLEWPOFF_SFT			10
+#define NAU8310_BSTSLEWPOFF_MASK		(0x3 << NAU8310_BSTSLEWPOFF_SFT)
+#define NAU8310_BSTSLEWPON_SFT			8
+#define NAU8310_BSTSLEWPON_MASK			(0x3 << NAU8310_BSTSLEWPON_SFT)
+#define NAU8310_BSTSLEWNON_SFT			6
+#define NAU8310_BSTSLEWNON_MASK			(0x3 << NAU8310_BSTSLEWNON_SFT)
+#define NAU8310_BSTSLEWNOFF_SFT			4
+#define NAU8310_BSTSLEWNOFF_MASK		(0x3 << NAU8310_BSTSLEWNOFF_SFT)
+#define NAU8310_BSTIPDR_MASK			0x7
+
+/* ANALOG_CONTROL_7 (0x68) */
+#define NAU8310_ADCGAIN_SFT			9
+#define NAU8310_ADCGAIN_MASK			(0x3 << NAU8310_ADCGAIN_SFT)
+#define NAU8310_VREFBG_SFT			6
+#define NAU8310_VREFBG_EN			(0x1 << NAU8310_VREFBG_SFT)
+#define NAU8310_MU_HALF_RANGE_SFT		3
+#define NAU8310_MU_HALF_RANGE_EN		(0x1 << NAU8310_MU_HALF_RANGE_SFT)
+#define NAU8310_MCLKX_MASK			0x7
+#define NAU8310_MCLK16XEN			0x4
+#define NAU8310_MCLK8XEN			0x2
+#define NAU8310_MCLK4XEN			0x1
+
+/* ANALOG_CONTROL_8 (0x6b) */
+#define NAU8310_VBAT_PCL_SFT			11
+#define NAU8310_VBAT_PCL_MAX			0x1f
+#define NAU8310_VBAT_PCL_MASK			(0x1f << NAU8310_VBAT_PCL_SFT)
+#define NAU8310_VBAT_THD_SFT			4
+#define NAU8310_VBAT_THD_MAX			0xf
+#define NAU8310_VBAT_THD_MASK			(0xf << NAU8310_VBAT_THD_SFT)
+
+/* ANALOG_CONTROL_9 (0x6c) */
+#define NAU8310_VBAT_CURLMT_MASK		0x1f
+
+/* RDAC (0x73) */
+#define NAU8310_DACVREFSEL_SFT			2
+#define NAU8310_DACVREFSEL_MASK			(0x3 << NAU8310_DACVREFSEL_SFT)
+
+/* BOOST (0x76) */
+#define NAU8310_STG2_SEL_SFT			14
+#define NAU8310_STG2_SEL_CLASSA			(0x1 << NAU8310_STG2_SEL_SFT)
+
+/* FEPGA (0x77) */
+#define NAU8310_CURR_TRIM_SFT			8
+#define NAU8310_CURR_TRIM_MAX			0x7
+#define NAU8310_CURR_TRIM_MASK			(0x7 << NAU8310_CURR_TRIM_SFT)
+#define NAU8310_CMLCK_ENB_SFT			7
+#define NAU8310_CMLCK_ENB			(0x1 << NAU8310_CMLCK_ENB_SFT)
+
+/* POWER_UP_CONTROL (0x7f) */
+#define NAU8310_PGA_GAIN_SFT			4
+#define NAU8310_PGA_GAIN_MAX			0x4
+#define NAU8310_PGA_GAIN_MASK			(0x7 << NAU8310_PGA_GAIN_SFT)
+
+#define NAU8310_TDM_MAX_SLOTS 8
+
+#define NAU8310_I2C_REG_LEN 2
+#define NAU8310_I2C_RXBUF_LEN 4
+#define NAU8310_I2C_TXBUF_LEN 6
+#define NAU8310_CODEC_DAI "nau8310-hifi"
+
+/* DAC Source Path*/
+enum {
+	NAU8310_DAC_SRC_BYPASS = 0,
+	NAU8310_DAC_SRC_DSP,
+};
+
+struct nau8310 {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mutex lock;
+	struct snd_soc_dapm_context *dapm;
+	char silicon_id;
+	int mclk;
+	int fs;
+	int vref_impedance;
+	int dac_vref;
+	int sar_voltage;
+	int sar_compare_time;
+	int sar_sampling_time;
+	int clock_detection;
+	int clock_det_data;
+	int temp_compensation;
+	int boost_delay;
+	int boost_convert_enable;
+	int boost_target_limit;
+	int boost_target_margin;
+	int normal_iis_data;
+	int kcs_setup_size;
+	bool load_fw_done;
+	u8 i2c_read_reg[NAU8310_I2C_REG_LEN] ____cacheline_aligned;
+	u8 i2c_read_buf[NAU8310_I2C_RXBUF_LEN] ____cacheline_aligned;
+	u8 i2c_write_buf[NAU8310_I2C_TXBUF_LEN] ____cacheline_aligned;
+	struct work_struct load_fw_work;
+	const char *dsp_firmware;
+};
+
+struct nau8310_src_attr {
+	int param;
+	unsigned int val;
+};
+
+enum {
+	NAU8310_MCLK_FS_RATIO_256,
+	NAU8310_MCLK_FS_RATIO_400,
+	NAU8310_MCLK_FS_RATIO_500,
+	NAU8310_MCLK_FS_RATIO_NUM,
+};
+
+struct nau8310_srate_attr {
+	int fs;
+	int range;
+	bool max;
+	unsigned int mclk_src[NAU8310_MCLK_FS_RATIO_NUM];
+	int adc_div;
+};
+
+struct nau8310_osr_attr {
+	unsigned int osr;
+	unsigned int clk_src;
+};
+
+#endif /* __NAU8310_H__ */
-- 
2.25.1

