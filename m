Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFC8C88E77
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:31:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8468160226;
	Wed, 16 Sep 2026 08:31:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8468160226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540311;
	bh=La1Ud/NlVlE74xpjFNI5YXZX5eIvV9aTU8q3eUmRAVU=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=U4Yi8CzBe/p2QsQ+dR0PIKkEmi2ojnPW70z1GmXWs1dpiZGhhBB0KHzOndJzZHB2g
	 lKDzc/Fssew1SITY+7TlJ1teV6/K/FRzRIezNBKKrSDbqiPKARSyeZSGW7NCPmEWHd
	 9p+t4vX+PAublrUdKmuZm8C12PcG9vfY/5BN2oJA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0AA0EF80722; Wed, 16 Sep 2026 08:29:34 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27876F8072A;
	Wed, 16 Sep 2026 08:29:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9EBAFF80588; Tue, 15 Sep 2026 05:52:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789444366;
	b=gu0+t1WpVFgNZGDQx1hcPa/LxmdQKUg6Kn5qVddtWK9xFzEdQDtPqlcnj6vI23ME3IBL
	 I92NBbDdZtYiL1f4ToH6DA9LWN9A6PLuKvwKLuBIOQkbzrmBXn9Ctsg82ah4CmMpkZPrp
	 jJfUuvmsFfMgfA0K0puLgfGb11/HoqoDQ2pUuDKMviCvSiuk9PuNFx8au8HccmYwPNUV6
	 Rz3qRN1CGzkbPsdAqCJ5ribTnsMsxv4WHRFUWYu/UdsiMHE+bPWHWQkdCZT3C5Xe+4J/0
	 yL59ysn4e4dBLIxNX9HS43vXvqcS20vZekKIrAuj0MROaWKiOjzQq6/pTgxENg368sg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789444366;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=La1Ud/NlVlE74xpjFNI5YXZX5eIvV9aTU8q3eUmRAVU=;
	b=K4xJ39VAI9O+7zcwyqrHgBbwfj0D4S62TMgntbc5eh331BQfBgYR6jgX2ns2Kh7eY7KP
	 HU1jIn/iIwZYDXhHaRBiYlkS/YQ6MjRfXKeIgmDc9S5dMvKV00kzTSyrzfB90V5YeRmez
	 3WPo5lRwpJNGwJRqq2n7EUSVYBFVaYCl8aBcd3lh30y4I4DYqSiV+NyLJ8InlKBm/0VB6
	 3h4/ADuCJRlUGdWiptW5WT9fqYLIT/B/DO1ro2AMDK1sLUvXG58xKU+zSP+Cd2CTAX7mw
	 5GkE4cDcOOv5yZ9Si6nXvatI9rpes+KKEf3UpW3cgfejG1A0f/JoR2KpR72TvM6oZMQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ZJJE5v6B;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=wcquUylg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5111BF80217
	for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2026 05:52:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5111BF80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ZJJE5v6B;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=wcquUylg
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68F2llSL3069168;
	Mon, 14 Sep 2026 22:52:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=GGtCG8jMtK1TE
	1LGtp/Vkew8AsuG+B0R54pjFAlxKUo=; b=ZJJE5v6B3/Li2XXfpyi3ofSe4lGDo
	AR4OdC4HGGAG+YpuVFHAIWD807z4dc8fN5aDInPQxREMLxdeCSKsw0FwzSovdLC6
	kcw+k2sVcqJEvuqOTsDcww8itdqA3dzoRsb4b/faUi1fdhXMTBcwiVDNbxG7IkJe
	+VVUkywhxiS6ZslvuS2cscAN5SjEkE9rT5622HJh2xCs9WFZKZugLuj37/svUrGh
	bIxMBiqsl2X7AqTlUfJplcPBE3lRjI9cNJBE0RX//ylGLaObYpigDxoQxd10zx3b
	sRWl+BzrNpDak6mHoUZWzRmNkj7eCXE1WBAUkUQnejOPyrwN2mR7CnR0g==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
	by m0380145.ppops.net (PPS) with ESMTPS id 4gppxsjcc3-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 14 Sep 2026 22:52:37 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ8OtAz0jo/3GI/IIYdmJSyMPwMaGobkzYRAEltIrCtMTbVNMUpOIIMteF4DaXO66l5DxV+p8mmFkcxR5fuUtR0W2N69FRARNkjCA6S7cor6IGoSFKGIx4EXEzKx3x1Ob5CXcsTcWWWmHZPdAKFyaGBlZEIabzHJ5sS4OiE5d+2xOkprTBnnHmUHpY+Pj9Nnp/INJL1zuFgMb+b446zW5sFR1T8r5Wvqt+nXBsxvlAX0tVimP3vUCSFbKnsPE1NQjnb+k6nYaz11NWd4j7tSQKivuEmXlb9adTQPFcnHPWAUz8DitylciOKtJDPkC0Q21HdhcEFreHTvdgO2Rql0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GGtCG8jMtK1TE1LGtp/Vkew8AsuG+B0R54pjFAlxKUo=;
 b=QeVirwedZZqcTMjw2kV4zSVEXzDAH6sCXOFZGnRBYFgod79VGV5xRPYUhiPOHCc368o8t6yYfy94koow3KC0sHrSy/W2UGOhdKa0BlpbOonko8XdlW02Y9VikfHt1QLmUaiY1IGbjbTTisL+FbmZD14EiWWtbqMI0OdUaSH02YKt8piK7qG4R0OxfCvw0Qbe9k89sxvjUAmJaX1iBeAkYUt7KBA345HTK95g+j1BjD0dF8zdhIzLF4jQwlnBKe/UBIc5pMcG9rkxazxp53jijrLo3WrJQ58lWpHB6mntcp0kyfS7JlG3mF4FmoFPqnujF7uDFx5W2DdeV/BGKXEoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GGtCG8jMtK1TE1LGtp/Vkew8AsuG+B0R54pjFAlxKUo=;
 b=wcquUylggotEslYlaCNUhYzg+EqV5GbAj75dzW9DcDtLo9aKmm6/9kCMww9Al1Am8rXp91egxNMd+z/pPQXeuC4gGx0l9Ol3ca/iz0tL8jpymx9T/nbu4tP1VgS3AAmoXnnuzQi8pHlkAZgPj2Z54l2T2YMcHnkR3Gjpe9NmUnM=
Received: from CH0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:610:33::28)
 by MN6PR10MB7998.namprd10.prod.outlook.com (2603:10b6:208:4fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Tue, 15 Sep
 2026 03:52:34 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::83) by CH0PR08CA0023.outlook.office365.com
 (2603:10b6:610:33::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 03:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 03:52:33 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 14 Sep
 2026 22:52:33 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 14 Sep
 2026 22:52:32 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 14 Sep 2026 22:52:32 -0500
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F3qQAd2429245;
	Mon, 14 Sep 2026 22:52:27 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v4] ASoC: tas2783-sdw: add firmware download status check
Date: Tue, 15 Sep 2026 11:52:23 +0800
Message-ID: <20260915035223.1518-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|MN6PR10MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 370c9f71-2ea5-4d2a-152b-08df12dcc652
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|10067099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
 OiS467HSRB+znbHeWN4M7nfVk0hBSRfvgS/9yqRJedImyQnlsl/+9/jUltWrplwVr0kRQgLepkf0drKKyigPXmxjJrZNSDI4vs+9NIIrd1+ots/LBmAbSHhFHVCeHA5qiC3iHBfI5PVn42LGbp5V/Q2/TgumkjhqFNBnF1hf4eSv+pbb3+5BcVJt+sjTemo+ooRLmuT1zC3GtwaPPBPctLvp/ONLFYH5J6tIU5q7N93Ww3da8zHEUH0qIK4aCKzUbUYp9q5lQHauDQsdW3/GOHH09oTww4cf1rXffxuazMyuRxYJupmtBf3TZ25yusnkEdE72+NF6AdA92C34pndKs396Yy5OZx0GD5ElBsJXwH2U6e44d+K83tWUqNAGevbbtLVN/P6ErQSJeUj5+ea5XbUTdg0zRdT134zrmyTPb3gbOPUvQChqf2GlWRLZhNpUd9mWSCn7unFAIkD/Ne9NGw+STLV1VCIcuOyhz8swGNX8B7+zungDCqEwBCZu2t4wkRr7/fiWAxr9bjCnovNS5eABMq+z16y+CEmHhvtKpHygPTw7zSYhs1ASL+DSnQkj/BbOqiml5ZI04NQeBHJ043hEBpYCzTDjsyBJoWEk2wyi+QEeyFBaadCVMR8HpLYVHzr17BbSAwvMM2xJPmW56IPo2Ig3UAhE/pyQ/G64pTpy+Oe2XZAYCX+m8AMceEADViYOXo+Vx9yLojkzG/PYA==
X-Forefront-Antispam-Report: 
 CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(10067099003)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 9bvni4g94p7H6jbnhVAJGPeg16VfvkBOzM8WlW1nYqVnG3DRXfZzDS6/DTJkuEPQJNxQxihkDc5OgyLa2An51NEgNpMPFrBShMLURVgcEBqCQKzvIdxlIqwmVUfXtOxvS4bCWQvXzz6fa4rnqsMp+ORruzohF8ui4PHmCoBycH6ftS6ntpcvfFUBph+EUJ7KceMfMN9/MrDDtNYTwfO9v7Zv2TVIODrfQYBhQAChoonEtJsWqOpCAAGo1U7XlmC77rUez+VFKZEbyZ3FPUBSGyAhkqQG0KKHYFGHKS+WwCe7myodPxWrNveItZTSo9u8CWkyoRru7yAnbGZOAS+1ja2eHvH19s505X6Irg8WinxrFeq/mQdXgb61XzpzdS88u0bs+rh7xOU2/YhvYt3C7iu6Ns4Fag6qhSbZg01ih0IAKU/OQFr+20vry3ahY4kp
X-Exchange-RoutingPolicyChecked: 
	Zi+3yIlQA82vVkV+VVcYYwb8txgW/CI25kJLWvVWIghyFNMJLAJKXx49c7hrZ1+D62/62FqnTaD1c0LQe+kYM0wdEjIM3UySlPQ+EL+K+LstrABYpi0uzsqBOTURDZFhsOZsV346J3BYYhlc2QpOy8o1Fl9r2dLebu39d4UegLPOwixlHnfuezFHEoCJGG3hjdg3T5JUOlVjN7eIu9Us3u5MLim9ccS+YGUH9ezY09UYXW1x3c51xj+iYuPgXrtoc2hN67sAjHcHLpdUUhBTy1xEzeH6daKxIgAApHS1kj4rPRj1YhuhEcZYvh0E9vhw0m64KyET9IvwLLiRcGvzXg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 03:52:33.8298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 370c9f71-2ea5-4d2a-152b-08df12dcc652
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7998
X-Proofpoint-GUID: j8LDv4HMsUxNmJQ-UeCvKnVQtHrEpnvI
X-Proofpoint-ORIG-GUID: j8LDv4HMsUxNmJQ-UeCvKnVQtHrEpnvI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA1MSBTYWx0ZWRfX7irdUw3CBJpb
 LTVG/peL0wEyW2W3kIxEG7yn3ibumLTSumJo0D569iNRId6uWW8ikXQUC6U4YU9lwdun6btpxgE
 9fYGLv8yy0xDDQbVYbptg6qom2k96yVVIlX7QjuhiBWG8oi8iFWV6X77v/tg6UfpcOmHV5NVoSl
 B5B6yz3TGQHYDApKJinkA+vZxBUkWwHicAqXKHUJAwXueQPYu4FYTyVn7u5aUV301dAak8SumKZ
 F/1J8G5YCsd/1b9H7wnnsbBaR+0E4sHh6ev8wJSzxkKdnpCwgI0km5igN44i0aNi+MxYthxBWW+
 OJUXGoAzYTA1yM3qjm/nI0tZxy/teisMdRcpKj4EtWdM0lMzsqZ/ndDU+UFjftxpJpAiWhiqsYc
 lfcfSMdyQjIlbuILJCWeESYLhhP25HlMWlRZRs6N7Mw1BC1ck0ovJh+xBKdqHwPoO79BUM9aHQ3
 5OQwSmwTfOKqFANjctA==
X-Authority-Analysis: v=2.4 cv=bYP+w+PB c=1 sm=1 tr=0 ts=6aa8c105 cx=c_pps
 a=ReLZl+GdXdFt35wSL8r9Ug==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8
 a=MsNS4y5GQQOSDfnsN3AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA1MSBTYWx0ZWRfX8Pgg5N6zFqhq
 oRBqI2nAKpiXaQ/EkIQCdfjlWlOBCVD1G9N0H/N1BhNlQvYcHZWg+eDd5phEwNZCECEDvPEGlR+
 EOViZ8u0u6VD03S371Pci+Iv8C7Tc4w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150051
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: NBBJ7ZE6YSRGN6RUGESFNB2QVA2ZB5T6
X-Message-ID-Hash: NBBJ7ZE6YSRGN6RUGESFNB2QVA2ZB5T6
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:29:17 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NBBJ7ZE6YSRGN6RUGESFNB2QVA2ZB5T6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Currently, the firmware download is unnecessarily triggered on every
system resume from suspend, causing significant wake-up latency. However,
this step is redundant if the AMP remains powered on.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
v4:
 - Since first_hw_init is only required for download reduction, remove it
   when this feature is not enabled.
v3:
 - Updated description about memory page download reduce.
 - Removed the logic that skips memory page downloads.
v2:
 - Update register address from 0x07 to 7 and keep the line within the
   80-character limit.‌
 - ‌Remove stray/unnecessary changes.‌
 - ‌Change variable type to unsigned int to comply with API requirements.‌
 - ‌Replace usleep_range() with fsleep().‌
 - ‌Set idle_bias_on to 0 to enable low-power mode.
 - Reactivate the AMP after resume.
---
 sound/soc/codecs/tas2783-sdw.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index 04e10473c705..9519dbfc7299 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -857,6 +857,7 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		ret = -EINVAL;
 	} else {
 		tas2783_update_calibdata(tas_dev);
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), 0x22);
 	}
 
 out:
@@ -996,7 +997,7 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substream *substream,
 							TAS2783_SDCA_POW_STATE_ON);
 			if (!ret)
 				break;
-			usleep_range(2000, 2200);
+			fsleep(2200);
 		} while (retry--);
 	}
 
@@ -1119,7 +1120,7 @@ static const struct snd_soc_component_driver soc_codec_driver_tasdevice = {
 	.num_dapm_widgets = ARRAY_SIZE(tas_dapm_widgets),
 	.dapm_routes = tas_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(tas_audio_map),
-	.idle_bias_on = 1,
+	.idle_bias_on = 0,
 	.endianness = 1,
 };
 
@@ -1252,25 +1253,29 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
 static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
+	unsigned int val;
 	s32 ret;
 
 	if (tas_dev->hw_init)
 		return 0;
 
-	tas_dev->fw_dl_success = false;
+	regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), &val);
+	/* Check if the AMP is in reset status. */
+	if (val == 0x20) {
+		tas_dev->fw_dl_success = false;
 
-	ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
-	if (ret) {
-		dev_err(dev, "sw reset failed, err=%d", ret);
-		return ret;
-	}
-	usleep_range(2000, 2200);
+		ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
+		if (ret) {
+			dev_err(dev, "sw reset failed, err=%d", ret);
+			return ret;
+		}
+		fsleep(2200);
 
-	tas_dev->fw_use_fallback = false;
-	ret = tas_fw_load(tas_dev, slave);
-	if (!ret && tas_dev->fw_use_fallback)
+		tas_dev->fw_use_fallback = false;
 		ret = tas_fw_load(tas_dev, slave);
-
+		if (!ret && tas_dev->fw_use_fallback)
+			ret = tas_fw_load(tas_dev, slave);
+	}
 	if (!ret) {
 		if (tas_dev->sa_func_data)
 			ret = sdca_regmap_write_init(dev, tas_dev->regmap,
@@ -1279,6 +1284,8 @@ static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 			ret = regmap_multi_reg_write(tas_dev->regmap, tas2783_init_seq,
 						     ARRAY_SIZE(tas2783_init_seq));
 
+		/* Re-active AMP after resume. */
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 2), 0);
 		if (ret)
 			dev_err(tas_dev->dev,
 				"init writes failed, err=%d", ret);
-- 
2.25.1

