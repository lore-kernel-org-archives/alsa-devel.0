Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63503C61DD3
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:01:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD08560205;
	Fri,  4 Sep 2026 08:01:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD08560205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788501702;
	bh=Ab9Ybhfd6p5c3pkojHnEjb1vmJdwz8r5ke/5jPZXgGQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=a5lk8zC//e5wifDiLfWdfM5hePjQHWAtpP7Zl/9JUHDSpCXFk6JkTqk87eRFCrxEU
	 N5XTYXaLkREfPVCK+gkMPmQc8mNg5dKVo5KUR7uByNYydJ4Ztm1ue4yIipNCBhMGtI
	 HgWlhxiyg8dpWrbOPBx7Kdvc11JboB3vunKx9bFE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E7482F805FC; Fri,  4 Sep 2026 08:01:07 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E655CF80600;
	Fri,  4 Sep 2026 08:01:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B629F8049C; Fri,  4 Sep 2026 08:00:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.58
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788501655;
	b=VRQwZK09lUj9OjhjePGa40vnwtoR/1Dh27uVT8oeJBXTHEXbf3JTUt+EM1opf5RLA+p8
	 L09bxQ76SrORgLWvSZ49yDknKFPSz30NCnTa+0CJnF9Fo7Sbhj9MpSo7L7JWB6T5j/G+F
	 7NHLWCsUgO+Hj+W+BOI8PeKcuBpRhl8cbnTHLaowP2aHWWDlOqnpRrqVkOyCHmRpX6x5D
	 QmgJs5CIcA8K3L/rMegWQ1YynMfha1J+9XH/fEuQdUT/9AzkRnKd/QbhJm5M/3Rzn1m2x
	 QaI07BCknQxFgwAdyppwwDWWgnEaSGtXWRiLYXsmXPijgXnAHZwxxTO5ggopkawQXmQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788501655;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Ab9Ybhfd6p5c3pkojHnEjb1vmJdwz8r5ke/5jPZXgGQ=;
	b=Q0HjOYwCcK70E4HPihOIqIvJWjPTJqtODNU+3VBpTmPV4N8JWJQ9oE8NQ9jaPHOTmXTZ
	 iu31rY4NqpghHDJTz7WtEmr3Akhvv7R/5jdQ+8MQjKUfs0Tl/BOHvq7EWO6cXO28ogq3M
	 SCZC5vOnYoiKPaLqSM9op7Qs4tYMl2uJ9agkGKlL1oNwYkTpb+EDnoT44ZYbTKQuGwXLZ
	 a/4AIwesvb4got29pNxfjS8/loQKcMlaF0RsgV2d3/ctElIicLXcxdZqcw+ni9zGjnDrc
	 uBo4QF9a5W0/8MPf9eF73KmfSEYwg9Za0lYB38rzdm71VWVtWB5P/643oY82/wVcnoQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b="mc3Ec/DD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.127.58
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11013058.outbound.protection.outlook.com [52.101.127.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7496FF80185
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 08:00:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7496FF80185
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=mc3Ec/DD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErH6j3a/uv7Gq2gHag5PUCh9NCTvCeXzjoQd0NesamDsJWd6VkR38kIh0VuWNGFhvX4Amn40MVpTjBgdOmL8W11wzFeTK8xBAC3bQD5bTcEi//MyVR8rOOu+byYs02iVmQHu6H0z1MvaVvP1ML6XwSXv9H0xiZanvnhIfvWmF7KLyyIGdfEXvDi3tjOKxHapXmmABghRQM3IwMXk7VbMB29EtP1UtMZEg+mTAUiwoIzyQWHK9noqojoxxre3/fKSFjuWJ1XT2UiA64j0FykrCB7SJuZEd0JHEJV6B2eenos8LhGdv/IuRZtSk73oBn2Xv1pyf5p9lF8KPP/HXyOQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4zRgj3kYgLUbfnxg+78pE+x5w/ItG1oXXNnJrN/cdI=;
 b=l52v20bYXBPezKaMDxfsCQzDvtkkhU6Mwi8NDEe2MAxoKJQH6a98AtjE2yG7jvzousL20PGtBmEORqwJvMji+U6O95rDGd7CYtLOSSlvH9yycDrNXTrMz3UPMsmSEKFkzSmh5e35e+CSFVeL4MtaQFQB5hkWeDqXoN+WGx7mfQ8hR3BTy7af0BOWakjPLaghTmCxmSaDLT3KGQY7NG7dwcTVM071ckEecWPFpXB+lhxbi5UJdJIP1x0oS/WyWL/CWwRO9nG82Z0LBdqiK0tDev3mLBowPLKM3oid80mdobjMBsXeWkgMydXQhyA0mfix8XCGpTSwdy1/81P2DKYtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4zRgj3kYgLUbfnxg+78pE+x5w/ItG1oXXNnJrN/cdI=;
 b=mc3Ec/DD5wx9nXY1hd488W/3kZCYy6RnDs8FQNt5bUVjtr2LMiQMdFXKA76HktRIBIV00Usfa4UoZmiIRyIyaDZQqQ6PYM0+9a5M3MDMmnj88GXoKmUMtfur69LOeravLSLh0pZZn41L1qQRHdZcauSbXq8cxJSvzWkFWfkft3FtGIIMByl/RdYiL2ov48w6QXYN0DVJ4W+XhOxzgTv0kR/U/iZ8NXu4LyMR9DH1GQH99fTF04knVpQ2iZv17CAqu0puLbjflhWM46jfAzN1kje9GyE3fxFirCTnoPBMeuCQj30/LPrRNoD7wmZl+g/vYadGqy2iCPQhm9sTrv6aGA==
Received: from PN3PR01CA0052.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:98::17)
 by OS8PR03MB8817.apcprd03.prod.outlook.com (2603:1096:604:289::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 06:00:45 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:c01:98:cafe::9e) by PN3PR01CA0052.outlook.office365.com
 (2603:1096:c01:98::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 06:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 06:00:44 +0000
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 4 Sep
 2026 14:00:36 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 4 Sep 2026 14:00:36 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v2 1/2] ASoC: codecs: nau8360: Set DAC path to bypass mode
 when DSP firmware load fails
Date: Fri, 4 Sep 2026 14:00:34 +0800
Message-ID: <20260904060035.196399-2-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
References: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|OS8PR03MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 77056172-edc9-4532-95ef-08df0a49db82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: 
	Ob//G9bDGnQwWVmWetQgKezuTwKJv/lC7wAWuvJmd84ux5BfcPHQevC3+fW4E2HzQ0isMSYXyb4HnfMnFoTYlxWYKmrD7QuovSZDWO2oCkSjZo5tuedQLhNE9NJyhLjn3r5GPeAyLd7Bi5Ehzi1OteK5lvo2mJwjd2DW4/u792+3+mFW5xlMyUMV258sNQInHwnHlQRiXyZ0cPqKYCsl0JkRy/RINkz4uA5e2vz1MHBbR6NlOTi1GZu5gruBLN/pkH+1CZAP/nDgHzl9pd3kKyofhvt71aUBdg2Kz3USSZA3uGNpkveIgEZLd3WzLXbrnssEU68l/F7YD8tD2G3kMNrTapfflEFyDBztntdvwA/IPfFuKl4I9E279RnF8hP00WIXO+91sR8fubhUqbmgaq/Fs3Y0pC/pbyfH5mzFkBG8AenyOF9CW5An6J05pypeWQNAoRIzFQlZmlwxsWX31qeyr7pllQ8XcfJhYfJatl/w2d4/U4TSCrqrmpkfGy5VImeZAIbc1S+aF7GASfN185eM3hDrS2CZUh324XxetnfDQ6iBTv/Lf/G27qzDTyhrLJt9XU9BMidQERfzonehxPkWUoyOtLTcx8RArnBDUku6SN0RXXx1URwvJJ36BSbcPARhX5FhX9FIBQ8x2PQqYEzomIJXZB8g8syfhBaVDRrQ6Ca3tIPfWZQuz1ZVwQYs3Ht0y56f3fKSg8KvIYGFmg==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	LidwTmQ4S6+GtKxHPlf/8WQcsGtr/T4E2Bq8MXik5NW8wKYQS0FIpKEpgkAwlc0mLgsRy7MnCX5DFR2uPbIwe6pMoLEY3WlfVcGkE9g8JSLQ3jEiJX0ivuAFU2FfWUAG+buPUfxKiBro3rVEfJvW8Z0DzTqAhWu9hkLtyW9OVmsUM+kIkG6KRyB4jJ/r+Bo2PxKhTxOQMnrCDpZEucj2mmN5euhy12BreyJwNdlGTUCO4G1q7QF5zKuylC7jAOhBlog0wT4wy5o1fLQlbV305rGZO8OXY6UwVeH/E/fSTcGOdm0clcbwRzTmq/o3U4C2cPut+iiwn2h5GqyVbJMKvx/vnVlm1hWQF1qkp369rI1R+t/eYp7LBgUsk2pkPwdds/SFrlWxEtqDw8iYLEtwE/iU+X96rYn2CNPjuwh8tTi8NuPX/4MNqkKKAzh+9nOg
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 06:00:44.0360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 77056172-edc9-4532-95ef-08df0a49db82
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS8PR03MB8817
Message-ID-Hash: HG73OC7LXAUE2QKEG3UVJTZJPTEKH3JC
X-Message-ID-Hash: HG73OC7LXAUE2QKEG3UVJTZJPTEKH3JC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HG73OC7LXAUE2QKEG3UVJTZJPTEKH3JC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Automatically route the DAC path to bypass mode if DSP firmware fails
to load, ensuring basic audio playback remains functional.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8360.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
index d7af2dffb749..8b75d3b9ebd6 100644
--- a/sound/soc/codecs/nau8360.c
+++ b/sound/soc/codecs/nau8360.c
@@ -1702,6 +1702,8 @@ static void nau8360_load_fw_work(struct work_struct *work)
 	if (ret) {
 		dev_err(nau8360->dev, "Failed to initialize DSP: %d\n", ret);
 		nau8360_dsp_enable(nau8360->regmap, false);
+		snd_soc_component_update_bits(cp, NAU8360_R12_PATH_CTRL,
+			NAU8360_DAC_SEL_MASK, NAU8360_DAC_SEL_BYP);
 		return;
 	}
 	nau8360->load_fw_done = true;
-- 
2.25.1

