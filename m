Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7307AC88E75
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2026 01:50:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6B28F601E9;
	Tue, 15 Sep 2026 03:50:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6B28F601E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789437046;
	bh=+RQIbKVsrqCIMOzKvAlrA8pe40NvtkjW/HFi2CXHuQY=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=OBcGtaMBXYhvRrCtIz5u5cAILzGg0sL6K1St6/G2cgBwF8+OURTXglzk1O7RSYgsn
	 rYejQ8Lxcbte/eeJUxsDglcHv5axxzlQ3TULX0lRghv+KhBXPKiPtPFzKVYTUS7ZsR
	 3U8/gCj0vpOXqVkiLI6cuqvRYaS7fFlRybhM/KBI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 141FDF805EE; Tue, 15 Sep 2026 03:50:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8A876F805FC;
	Tue, 15 Sep 2026 03:50:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 179E7F80588; Tue, 15 Sep 2026 03:50:01 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.64
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789436996;
	b=qw+j+3K/03bEdTWcQbB5ck9t81vORCscBUSHLuRKmMYmXlYh5HKvcjUztqU0hvh5Mpp2
	 IJtv2BUgu/H+F0KoIxlavcU98mBmSNeLahW5N8wlCDqfbZNmTocle6R7Ng5Nzey+s8o4r
	 5AR4DHmaiJ3t1j2Wg6oMWk8hv0+I1NBEL5QNZIA48sMEdkfNp0SPxozW7ZRmz7vnsqL0u
	 52QhEEI9wFJlhlkWX1llzRrkJ9qKSQhD1iVELVOOQFQbRYmOiYQCtN9+oyub+ApgA8ZtA
	 tB1hRYwUVTtYnjWvuFsmp5lWnN1kZ4Nn280uegipJ5NC1HAxGYuil1ZNZ4CBu5Q/2UA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789436996;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=+RQIbKVsrqCIMOzKvAlrA8pe40NvtkjW/HFi2CXHuQY=;
	b=ieI76J+L6G1LJfXJ5iT1lycfwtoDUu0E9KaYRxC29ledUy2x3YPqIPiIH3umJ2i60+QF
	 UuFgkfgVzQBY0ioP3piPm6p3Pq2cu3FKnqAMCqXOBvD3F5maWu0fvFmQ57MOEyiAgdN86
	 268ii9pUg+3/I5+yIBgr5hvI4hPzuyLlogsLy+cyE6sKIjHqSSKySrDzSpi93SuR8biwU
	 NEB2HhS7yJllul6JnmucGdDv9rzAtuCkJXV5xe79OEtFYgdm3q6hZ3a73OJcBuUNdAWXM
	 OmdFhqtE1+aiFGs03ydKyhXM3OKGfHB+UkPD5619FinIt6ptgyfgo55kk660RD+dzDw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=cFSQkLR+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.64
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D262AF80423
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 03:49:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D262AF80423
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=nuvoton.com header.i=@nuvoton.com header.a=rsa-sha256
 header.s=selector1 header.b=cFSQkLR+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfGaa3WDU2eJ6A952y+bqwW3ERTy7VOe0dYQuGY7hr6rxFyn97cHebxvHJOgxXkucF1bj66qygEUoyLnLZZMlpIj+thebJCmQW3Gda4mFuButtTE15UNQf7NiYK/tQ1d4+UeTsLGGNdPHsk8DN1i5q4sr6JD6sXtTXAUk6ILdQFoyCrGDU94U8Xt07qjRw+I1yr7bRtZ5cQO9fksVpqiV6mAoa/aLDQ/IXSxVSCTsV6pfUeOTczHRzySEZbAvhJ3P6Q4xu+DqSowqp5+sbfyMecFkie80ZNCwkhKbV/KzG00lrzM6vJDQx1v3UKmP/Sv10LiyFkk2Vjdk+K4dG9Tyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw6X/AXi717HwZnGg0/86xf1nXOmhQRT/GdgTfhGpe0=;
 b=I1x1J0WjNfZlMmfEPeJehHIReFVTJ4WJGjm7lnmVoMJ+0aQXlQuGnvIbwQQ1aoCnm+h3aCbVm39xMoH1XyHz42OcRQDGUaib+qHBrmr/qkHvyJCDOydWI8aZgov5aXSrgKhXezkc5RNLXlKtbWE7/MRcQmgmcC4flyHwhEGOipJvM/Vhp6TuNK569OUv9ybLoPC22mZrb2h0Ll0J5imttt3rQrxzs1GbuZs8wj5wmrta2XUPKezgf1th/9Sg/9606xieepSrs+NEMc0OvIWK66rws00Z6toc4SZapyWSLXNO9Ppep2rEB6afBKRovO3yyJ5xlRCyz6Cg8iCC3HxgQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 211.75.126.7) smtp.rcpttodomain=kernel.org smtp.mailfrom=nuvoton.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nuvoton.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nw6X/AXi717HwZnGg0/86xf1nXOmhQRT/GdgTfhGpe0=;
 b=cFSQkLR+ncWy9goRwQnkdl+30hRfPb+ZqgKxQEQxe0Skr2VILRD25nvRE2Y1hFqdZclroCwrzgfaWgAHjRjIPRy3Gr6ATHjyFI9SFWmEtBuv0hC8M5kNKng2pLWPJ0r8n5nFMyflOsmTgukob71Qkc05WSZVlTe/VcF0K3OSVKej6qDQIikNQuZrGqWTv6reRrpI7Cbh3FgljfPtFjdWCzNYrJFM1YMsKoJyR9gleOQ8vWzqUXhcKm4cYXZUkEo7q2Xu/f222KYlc8HXqza2gByRmczF/4ckgorK4RlgeFLimi+XTPcVglVw+DxgoI0v7onvo4Kmu2PwWfATW80b5A==
Received: from JH0PR06CA0023.apcprd06.prod.outlook.com (2603:1096:990:77::12)
 by KU4PR03MB9832.apcprd03.prod.outlook.com (2603:1096:d10:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 01:49:45 +0000
Received: from OSA0EPF000000C9.apcprd02.prod.outlook.com
 (2603:1096:990:77:cafe::41) by JH0PR06CA0023.outlook.office365.com
 (2603:1096:990:77::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 01:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 211.75.126.7)
 smtp.mailfrom=nuvoton.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nuvoton.com;
Received-SPF: Pass (protection.outlook.com: domain of nuvoton.com designates
 211.75.126.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.75.126.7; helo=NTHCCAS01.nuvoton.com; pr=C
Received: from NTHCCAS01.nuvoton.com (211.75.126.7) by
 OSA0EPF000000C9.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 01:49:45 +0000
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 15 Sep
 2026 09:49:43 +0800
Received: from NTHCCAS01.nuvoton.com (10.1.8.28) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 15 Sep
 2026 09:49:43 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server id 15.1.2507.61 via Frontend
 Transport; Tue, 15 Sep 2026 09:49:43 +0800
From: Neo Chang <YLCHANG2@nuvoton.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <linux-sound@vger.kernel.org>
CC: <error27@gmail.com>, <lkp@intel.com>, <perex@perex.cz>,
	<krzysztof.kozlowski@oss.qualcomm.com>, <linux-kernel@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <neo.chang70@gmail.com>, <kchsu0@nuvoton.com>,
	Neo Chang <YLCHANG2@nuvoton.com>
Subject: [PATCH] ASoC: codecs: nau8360: Fix misleading return in
 nau8360_message_to_dsp()
Date: Tue, 15 Sep 2026 09:49:40 +0800
Message-ID: <20260915014940.317403-1-YLCHANG2@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NotSetDelaration: True
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C9:EE_|KU4PR03MB9832:EE_
X-MS-Office365-Filtering-Correlation-Id: 950b1472-1d10-4644-b8ab-08df12cb9e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|7416014|376014|23010399003|18002099003|13003099007|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	D0SQx7GJKFgaYcVsx/9BWDL9tkBQ7eOuPqyCFwDSX1hab4enD9PgRffJowhWbAbUAccSuOhxF8kVi2sM12kaF1GixdSypWYjqp1KOW5pBVDgKBWXkf0hW/nGvKqnJgwH/x3Y48O52MF0sktgL+h1hRdPl7ASAdcvIQkXobpENIhgkrwOvWzWn8CIXVgRgDRM0pX/5G+aAZJDXEaPMGydEKuLgNDEO3Sun+te3jgj5snxjjWqh1ms/VyWStpQcp7WCH4T8dST9VJP3GXF/5R6Q6mgQAI4cU37v8vIlfylU3rjiB/eYDQDEeg4HKdh1tZWpL1IjRBu7BjsnTOqbKCvMEi6880ZZ6Y7ZHnRx6gnTcl7ygnYW6O0qp6oR6K00KzuaKh3lg5+LHCmK2l8lvABt1d7+8dXPT5kdJJOgVsaw34FdV1LQXDyNGIG5efgs9eJ6mvx0kPz7GLHD6fRu+0UCUhO7XMrf2ndxiwizfkpTTPacgKqh2x01QhZe88TIoArURKhFMHNjRvr2zy38ANYbYLRj24CSXrqOlBkXjza+uYnCpXdZjDTxs5d28nBsesFY9eXhcgA1ALZ+1oaWWkkTHecTxcK5Pb9n3JP1AXJO5pMX9yzC0i5G6YaWjkwwKMmzjItZt80UFGxzKTIyDy27IplV6URVVh5GdY4SNf97co=
X-Forefront-Antispam-Report: 
	CIP:211.75.126.7;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:NTHCCAS01.nuvoton.com;PTR:211-75-126-7.hinet-ip.hinet.net;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(7416014)(376014)(23010399003)(18002099003)(13003099007)(3023799007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	HbgyU7b5UX+tlN5Wh0EzcCYvI9v9nxFEqORpABgJmHBjKLt+YgjCGSl+TkI7zyCentAklz2I0zwoR3qHlpRsw7bYrNvB/0H62XuhdptPV7BCvzxMrSDu4mQAng6y423uasTPHYVPDg+AnRhvwLN8zSF+YMOMB9wK8w5P7/1LQ4thWa4Az2cILxynxQ6umAvpeqkiqKMBTCn+v1GU10EQUEoFA1Qpe8uTgvWBmHpsjyY04sYom9zwAoZMZzvH2Tor1VUYBnUmkc4S5lFNZJVhuxuC2DderfJcW4EeoyWsv08MtHsapVcRZW+GHtPhlcuULilBtRa+DRbuj9KlCyLW/yQ2GfjBiNoXzOKNACrQlj8JL+HaugJqV6fY+UuOgCDutshI34sLZx49jqbMzqu9z5inaf71Afd5GB7pSZuZv/jaVdmW3kLbU3vWNdq30SFe
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:49:45.0461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 950b1472-1d10-4644-b8ab-08df12cb9e2f
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=a3f24931-d403-4b4a-94f1-7d83ac638e07;Ip=[211.75.126.7];Helo=[NTHCCAS01.nuvoton.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	OSA0EPF000000C9.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR03MB9832
Message-ID-Hash: QANQCBPP3MZSTSZ6ASNJXZ7GQVRYBPMN
X-Message-ID-Hash: QANQCBPP3MZSTSZ6ASNJXZ7GQVRYBPMN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QANQCBPP3MZSTSZ6ASNJXZ7GQVRYBPMN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Fix a smatch static analysis warning: "missing error code? 'ret'".

When there are no message parameters (!cmd_info->msg_param), 'ret' is
guaranteed to be 0. Return 0 directly.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202609081933.K4tVJnyh-lkp@intel.com/
Signed-off-by: Neo Chang <YLCHANG2@nuvoton.com>
---
 sound/soc/codecs/nau8360-dsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8360-dsp.c b/sound/soc/codecs/nau8360-dsp.c
index 2e5b61bfc303..65ffec8b3a39 100644
--- a/sound/soc/codecs/nau8360-dsp.c
+++ b/sound/soc/codecs/nau8360-dsp.c
@@ -211,7 +211,7 @@ static int nau8360_message_to_dsp(struct snd_soc_component *cp,
 	snd_soc_component_write(cp, dsp_addr, payload);
 
 	if (!cmd_info->msg_param)
-		return ret;
+		return 0;
 
 	/* sending payload + padding */
 	payload = nau8360_pack_param(param_offset, param_size);
-- 
2.25.1

