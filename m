Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D06C79F80
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Sep 2026 06:02:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E57326021E;
	Fri,  4 Sep 2026 08:01:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E57326021E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788501721;
	bh=AfViu9stumwa2XyyLEMmtEN8szwvZIkInKJ4zuW9DVI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ZIiPgAgVX32lKmpMvQSwJGx/aGQ9QAv7oQo7bszcPBfbGMYGKCsyyr2Z6/+GBjnUK
	 6EW0won4zp9++1SJGe6UmscDsa0YTJDuH3F2nBsLWB+kk4KvCOZL15bsqrpI329nUZ
	 6bRu/ZfSvDnifgYpZ0i4s++c1NqPeV4D4d/K4B8c=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3EF3CF8061F; Fri,  4 Sep 2026 08:01:15 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B78EF80618;
	Fri,  4 Sep 2026 08:01:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4FC4F805EF; Fri,  4 Sep 2026 08:01:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.30
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788501665;
	b=p9ufsyZiO4OdYQElHOFpnDdhuENaxxXDdzZglZTNPlhnaeNyZRorJS5JjBNg1AHBoUI3
	 z7Wq6TLK3JRuUTP3C8oIQunyDxLcdIuES71PWObraQswwT9JFKZUK5hI0Syqzyd751BMP
	 W+CNIn9+6N9AUIO4iIUhDcLLXY4JLm8tm5LIP7VCJfhuVt6MW+brKyRgVHvnnFPhSuiDc
	 xB4D9DsIFa2X5aEzi0rQqhR3/RSIQvSBcB/1QH57GE1YVcrO+xUh32tXTGi9D10nZe5Y5
	 /ZtvS/2L5AFgSolcqA4IT6eSHncs9duipTVmjz4bTDhF/MpHh27w7gUQsqKzsZ1C/uA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788501665;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AfViu9stumwa2XyyLEMmtEN8szwvZIkInKJ4zuW9DVI=;
	b=nNFh5l5Au/gq86uvAb2Rpk3Yx9JRRmrb0ISuUI9c4E2uZ1hJEU7eT9jKhBRJoryR284G
	 84nUevA2G7nw4iO8ddnHfiN3/uhwUZDClF4gYSEVp5Wtb/jcfk9ymgcaZCHcrDtR9dZNE
	 QsbuLVXUohzncn9OZNHKoEIGfHrZ1v4WZIQGU6pO6oRRB+WtK2QoE8yD0s7SXzzi6wXZH
	 3qDf4kCj/ONImHfG+SYgOullOse2pJzNHdafNat/7kF4HWmktm02+XsUSNYqUGF057zcM
	 57fdGfKwC+Y7X/MpEoL81T8o53B0dawmBGfAPkFIfB6pHoLbiQXf+j9S8zb6VQHZEuw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=AfmnZoGn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.126.30
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11012030.outbound.protection.outlook.com [52.101.126.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E430DF80185
	for <alsa-devel@alsa-project.org>; Fri,  4 Sep 2026 08:01:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E430DF80185
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=AfmnZoGn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoe9JuttzQ6aA4IU+4glKX5/MYi6WbDxQ+VPNwy1RhzYZNtS4maac4BzyDuNbjEzcyw/1JlOiabaR4VLJsHnOvGfkOWV5V5CDs7aO743qK8TQSuXyQ9oHGowlUjUel9evYwTwZIShdSZRKSDyes+NQx62FqL+RmWHCosJctdrAhnSkZOcjNIuDh+m9aNQ2chFK0OSPpeOfamE07n8cwFsJDgy5aVoYfPXqWSXUhOxzRb0aY3JR7TQaTfp2dhPQUrciyoV777lZxZGCYjNn/KqXW55NN6YKAmQPbuhNyjK6GhED/5b6HbAe7JzadHd7u3GApl88x2RTnlZZPrBVfg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF1gY2bQhq8L3n7lN2KgO7duQxGzKqIvb2OUyhCri1k=;
 b=oTHPIJvvR2RSro83jb8WwopAnEfHU2Zc9fCw+3GQ2fIgeMNH5Lsyu7C+IVeRmj9NrS4/HwFCk+DTgTHg2nBawuxpxo3UsKP6HmSyqquDaETxmLhtGfaVyzqGsX+tMVvxH3z43nP+g64ERX+t+0mwKkBJRNyi0zVzXwDm6iddNf3NLKYd9iAFCw+Nt8NsFSw/l3b1EFfJVmB8gnJ6dVWZT/tVVSyTUKZkaFKt/zlzovFXCoUOUJCItbry9r82SlZUXNU1HllCd+gKcZV+3AowqWpEmLpdBetIjPZ51iVTw/I91LgAW24IHxTO7T5RruUH9hEaX0L5eOtGMfMOCl3rYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 175.98.123.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF1gY2bQhq8L3n7lN2KgO7duQxGzKqIvb2OUyhCri1k=;
 b=AfmnZoGnK2tzyh6h2mgjvsEwIa4GOSeIL0f6eldKeikvlj/MaCk5tY9InEtRZCRZgQSVjHkV1RQFGyj+o5Xh+mX0pPjjE5rYaWQMS93jr/srS9S2uvrNlX8BIT97M/egFfUHnOPvyVAqwJwiHfjo2Io8uKokHNz9TmxVSJLiOhkMVO9pamN7X//G9UO4JCdGmZqei+kqXQbZIhEPXVuJcRiWCp1smDWDaKmV7wvBlEZ+X5xMOEsRNpeYz6zt3DoOI8slwN8NHuIZ1NiJ2emKMjGIQFN/bgXos0lmKPIf85U1bstepgRHPDz/tqIHzvsg1ybRas9Vf7qNaKNzawRKeQ==
Received: from PN3PR01CA0045.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:98::8)
 by KUZPR03MB9663.apcprd03.prod.outlook.com (2603:1096:d10:64::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 06:00:53 +0000
Received: from OSA0EPF000000CA.apcprd02.prod.outlook.com
 (2603:1096:c01:98:cafe::29) by PN3PR01CA0045.outlook.office365.com
 (2603:1096:c01:98::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 06:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 175.98.123.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 175.98.123.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=175.98.123.7; helo=NTHCCAS02.nuvoton.com; pr=C
Received: from NTHCCAS02.nuvoton.com (175.98.123.7) by
 OSA0EPF000000CA.mail.protection.outlook.com (10.167.240.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 4 Sep 2026 06:00:52 +0000
Received: from NTHCML01A.nuvoton.com (10.1.8.177) by NTHCCAS02.nuvoton.com
 (10.1.9.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 4 Sep
 2026 14:00:38 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01A.nuvoton.com
 (10.1.8.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 4 Sep
 2026 14:00:37 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Fri, 4 Sep 2026 14:00:37 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <perex@perex.cz>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<neo.chang70@gmail.com>, <kchsu0@nuvoton.com>, <sjlin0@nuvoton.com>, "Neo
 Chang" <YLCHANG2@nuvoton.com>
Subject: [PATCH v2 2/2] ASoC: codecs: nau8360: Add default PEQ band number for
 DSP init
Date: Fri, 4 Sep 2026 14:00:35 +0800
Message-ID: <20260904060035.196399-3-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
References: <20260904060035.196399-1-YLCHANG2@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000CA:EE_|KUZPR03MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: ddeaeceb-650e-4ee2-1c9f-08df0a49e05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|10067099003|6133799003|11063799006|18002099003|22082099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 
	TwnQ3I9NUkPsxyTZTWc2yKZjMkn2IV46Ja8ZA+KVUvqvCZOaSGeY3q/DXQIFGM3JLGWuTBQp+w6mXFlvvM+syeywYCAbB5NM77A5tmC+0QKQtowcKmHgYBfTT/yG5voPBODd1SnLVhMATfdsKb1w9cvtY93wG2C+du+RJltZInAZFvav+hlAGJ0mh58cGCKr1J8R3x3iVPP7K0MXccPSEuvVf+Kg7KeqYulQO3At/AY4yJPSsf1bjPDTHZ3G30buu4bf+hW1LVFgXhT56MmBJvYqVha1p1PuOW7MjwnKt0NQEaVgjXxUA8xU1rT9jBhoCUEfGm/MnE0e8jY0LTz+SWpyKS10Ugo6oTQPU9OMJwpfxlPmaJxVYQenAI+0N8lJpYFQ0TfmYTvtkLE9wdl8gUGgBw/hk3QldgxRBdxqrs2qgzxttGHuU+FHWSsniHhg2kv+xVo9WDoVQZ7BAKnQNzvv58EhXT3zgd43XNPBO2jFBKZ+IMul3FuZpq7yJqPbGlXVyDY28aCmnexztF29cj1B92L/9O+6Ta2WC0UhCi9jfEn8pYsqTcQ1/t5D40RSWqEt+6VqyxLoVrz0MlmVUmscJ0uZg9/qoKuhmmiTFxYz4CKLEBak3XHWhiJTrPtpqw7xo/9HFCXnBt7h1U/VFlpbap3Q0vhm13fh2WUhvClFkm5ihJI0LCgb5wZoqD5gjwtfugTs1j7JbrY8E4yO+A==
X-Forefront-Antispam-Report: 
	CIP:175.98.123.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS02.nuvoton.com;PTR:175-98-123-7.static.tfn.net.tw;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(10067099003)(6133799003)(11063799006)(18002099003)(22082099003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	0oNUSNI3x5EmewK8wfaiQJl1Z40j7n7x7SVBi7aSothdcNOCQLtYzQSpQe3vAcZzEeLYv/9yAAY1Hv95IqkstGXz6Bnzbuhw02Cvu8FzQK6sqHEVFA8MbgusEd/OEqyYyzoP4wrNA4xfKpjpYujBJ38e/XirLkwGknUyNQiKDva8jsMwDePNNrBbtpy9ZCWmW5LKLU0svSuLVdY6hOqZfkmLirnwpNVTqeFFgk5Gd+tBJWU25Cj+8QSKnol9ustubK/HXbZmbSoiN6pnnsG455ycZkiCw5jKd+qCs/v4z2yKoGaXM75nq5D840pwooJqO6w+RpSaMsS0ke/MbevgfBYQWZLv6ZRxXWhEg6dUEt5qsRhfC0Tvk+/Ukw4DDCwrONdtIauaFT2PZqY9RKgNmCNWKM4LgPqtG4/QaMR6UQjcHtnUOwz6A/7FewKJzRKy
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 06:00:52.1873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ddeaeceb-650e-4ee2-1c9f-08df0a49e05a
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[175.98.123.7];Helo=[NTHCCAS02.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000CA.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9663
Message-ID-Hash: SWNK6MAFHUNFMRVQ6IC3HU5B3OYZOJ6W
X-Message-ID-Hash: SWNK6MAFHUNFMRVQ6IC3HU5B3OYZOJ6W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SWNK6MAFHUNFMRVQ6IC3HU5B3OYZOJ6W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Set a default PEQ band number during DSP initialization to prevent
invalid state or uninitialized parameters before user configuration
is applied.

Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8360.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/nau8360.c b/sound/soc/codecs/nau8360.c
index 8b75d3b9ebd6..2c4375e81415 100644
--- a/sound/soc/codecs/nau8360.c
+++ b/sound/soc/codecs/nau8360.c
@@ -1602,6 +1602,8 @@ static void nau8360_coeff_set_def(struct nau8360 *nau8360)
 			i * NAU8360_TOT_BAND_COE_RANGE, 0x20);
 	}
 	nau8360_peq_mem_enable(regmap, false);
+	regmap_update_bits(regmap, NAU8360_R9D_PEQ_CTL, NAU8360_PEQ_BAND_MASK,
+		NAU8360_PEQ_BAND_8 << NAU8360_PEQ_BAND_SFT);
 	mutex_unlock(&nau8360->lock);
 }
 
-- 
2.25.1

