Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02E8606EE97
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=R8N9Hdv4;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=ImwKOppS;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=FPHNlegT
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D67F9601FF;
	Mon,  9 Nov 2026 15:59:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D67F9601FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236404;
	bh=RAmU7wVgiVjmD/zcud3VeW0jp5XOfis5LtiWpBF5AQw=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=R8N9Hdv4aKp7YMw0ZM+gSc0hAW2j7+FABX+wWK5hf2JnjMQaTBPgAHfUSYtxd9eof
	 vaYr9i9aQWe65Yoy1T1zDmSg3whsWyIN7SeBoJ+EndXzttEo4Sx4UnoqpTaov9yNjH
	 q+pvFEaagTI27fhIutPj/OrLcnqxqYjA0na3sAfk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D4F2F805FF; Mon,  9 Nov 2026 15:59:31 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28CEFF80600;
	Mon,  9 Nov 2026 15:59:31 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A4C33F804CF; Tue,  3 Nov 2026 14:18:53 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793711929;
	b=RjnMfUoQAroTFB2Tgevjz7UgVGh13nO5tRCvSuRzYpGWjmxBNipbb+SQgtZzxd4nf7Vy
	 cpPqoZ2hRmTNdsG5g4W4iwKyF+I/Z0gD9Holccs8LAReunCLvLTX/D3sRxujJOcKEXkS4
	 ut6twrxL5MdgrLrwrTGWxq6Gg5skPnRh2T8wDvQUlZz2yxEneuV1icz4ih5tnYZygGvXA
	 ldvNFKPpvuecX7HftR1RiCymVUOrlOKqzGS6PaezTAWxX62yM48mDE5SQhHCR3nl7PeIL
	 t61NzlS/9Q1RPFv9bHulfCDQR4XZpA/o5bnfR5SB4fLDUJgJmjPtPhaFA3FZZOF8p0A==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793711929;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=RAmU7wVgiVjmD/zcud3VeW0jp5XOfis5LtiWpBF5AQw=;
	b=BeDCdjyUd/qVfw4b8hpir4nAB2wAQN7ZHy++LOs7hTp8Fm2zU7G1Gj4EbbtMJWxhLLsB
	 h3I4mQrNtO/stKe7iPJykIFXs5i3r0BrtC3CTCyj40xbJaTrdYZnPTkTU5CQIehhbkRjR
	 hiXSUTD9qkv/zrLGLUhP1J4B4ftik04wHOV8ZPIDJnz29B9hQVleQDk6JNL2AGdUP7Onx
	 ANPNp4s0BOEOpWjjyN5rtQMnbXQY+wTNy5z3dB5cpv6yLu/FpRhJhdMhwOJprXzTJ/wzI
	 HOyuSe4V1vEYEjxgZCr0/pNxv1JGOJuvXmlqyDexYorXheW2XNw0Cl315oqloWuiZ3A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ImwKOppS;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=FPHNlegT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D3BFFF80100
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 14:18:47 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3BFFF80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=ImwKOppS;
	dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=FPHNlegT
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A3ClhLr1249277;
	Tue, 3 Nov 2026 07:18:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=iYShYI8F4L9Rc
	gKQj0IgFYJO109B33p0P0OzuX5ENrI=; b=ImwKOppSRh2YqmUuM0a87iQO+k4hl
	oLuQq2MLqc+fz6N7vk5fm0UFbfsH+HIekN8MxmZhWaf0xgAe7UwDUpzjnpuDdl4i
	UmUo121G7/vXYaZWy9s6/xhqvMDQhaQWdLZT4hSLKW7EGJne/kzyo5wQIQArlELc
	POMqd2eaVf/UXClL6oRm5F6YkjIHXBj0eJz+ZVc1f5enm+CV3pw8ieycKAIf1P6g
	4OzlwNXGQt6Aq3vd3oUf7tOlXq2mSl86VwHkJ7cUWjZS0htEMS1Bvm/3J8aQXnpt
	aVJ6P/ef1PWZ6udYidLykKVm5dLZ6RmAz3VtUvBTTdp5c23T8la6Daj4w==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hq0fhw25b-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:18:41 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBBZGzffBWu1ZFyUcWJPTnrj6FbKJcuh7srJFYjUfnskoXKTCT8iOyyxIV9y+K9tx9SuLCERkUFTvbdOxTnGYv7YvxI8EekbEZzzDcjDjreamO0kJ7U+sBS+hPYdzAdGZdQ9gDO9onsuIvV+3/MSRhRKQtTO6FF6oq5tdMJgvVFk6rwPPFiNSWfi74iM51bTi4Hm4g8h1oG5opR+IO5zHo5ckXXizcgAeaVR4zu1yso6/hPkeHmaoKHfZnG+uXoD5gsCwnTwC4DB9KFt5LPO1si3d9DbLUp+0mWCyf04yaDpLBGy8w2hQrVZZcfx3yxUHKQxYwOIFt/eSCF/zv1IeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYShYI8F4L9RcgKQj0IgFYJO109B33p0P0OzuX5ENrI=;
 b=tMCb5JNKZuznE3ZI0meKpG6q/V5/gEWJLF++UmWtcGKvKw1ls3gOuhAxwi4uncf9/F5Du2jlwhXHs/TEd4eoS6+5LI3tK/VQPOtxRHhWrD9Dj9dWjMYBzPN1iaDAdmtTkuEJX/dRVr25KKDko4YlahzeoD/u+WQNkWVCEYgxEorew6Hl1aUHalyQH2RV/qLr4fpbgZB0pp8o7PW51/Q1Qy+kkfuLBTohIFVD4rRhM37i8VsBajdFZx58m+RByQUWTTuGkHJCsNyYgZTeA4/IfdgbnBsXBn8W3CPiRcQTWjqd0dDAoMI3uJXlsfBkoaCAwMvEboZ+P+zzXbUTKGWTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iYShYI8F4L9RcgKQj0IgFYJO109B33p0P0OzuX5ENrI=;
 b=FPHNlegTqVfKWSd0ieA/B2kwjZBkIqKFE4CIejyrVYrek5vpeHJ3KRjr5tKxDfbE/2eaAp5cbZW//egh1f1znlAsBYcFAY1HzzAyHIx86XsXjvDddge/tlIkx1isqO3a5KrR1T8brrVnYzx5/L+67ufQ4byqYk2QNOrxa/LwOzg=
Received: from SJ0PR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:33b::26)
 by CH0PR10MB5067.namprd10.prod.outlook.com (2603:10b6:610:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 13:18:38 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::33) by SJ0PR05CA0021.outlook.office365.com
 (2603:10b6:a03:33b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 13:18:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 13:18:36 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:18:06 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:18:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 3 Nov 2026 07:18:06 -0600
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A3DHxPo3256690;
	Tue, 3 Nov 2026 07:18:00 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v2] ASoC: amd: acp: Add support for more projects on ACP7.0
Date: Tue, 3 Nov 2026 21:17:55 +0800
Message-ID: <20261103131755.1558-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CH0PR10MB5067:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ccf30a0-18a7-4ba1-4caa-08df39acf7bb
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|18002099003|3023799007|56012099006|261021123027099003|261021121427099003|261102123227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 
 /zSx3fV7Ifks2f+LfYveobWymIuxlcJRvuKBmtW0BhsyZeruqJRsf68kFh/0cOCeZfhsLmu/YZ6O7E0lgaKMxXuGYIRMCg1koA+bZp5+ZU0wZZ/u0OzZ7JgnN/CZ9ZUfTTEw04X0rmLMzCyBlJi6Hnst1icDxqTSPLBRUPTV6JWPk2jjS+LYppLEXpw/KfwTnpZrhakookiSiltsMKLgrlGBs+Zq7N68616OLaht+H7YEOrxgQLhH0gH6oSWa2VUVaXq6OC//YW8Jo3q9kce8/hh35yG3054DQxOMUUhnGlZc0/aSWX7r1sGf1eTrA/OMd/Bm8jURgzSA8AJd2D4ueV5Z5QyCUeDJCvL8sCG7FYAKSc1/dIVLWmmgSmPI4naXs2IHlf15xxgWBYDlnlKL93yG18xN3qF1rFX4/4n8ye4JVCKAr8siVHryKUhvnoKm+/NvdKIV3n53pt+k9QzkSy4L1NOgCo5iy8F0vt/Py9FFNgWAQWF+QxQU5ZMwarv7z7b//rgwOQ1ZYNaTEqtzaH93z5TAgbChyjxRfJvyDiIHNmx2B+DiwPMsEK+Mt0npXrzVVdRYzZMT4FUrxdtzqXDthdpJzTK2Tq6JeEN3bpJgM5Eee+5oTCfw/9jwOnwcy8VYZgIcRunobQzBUwU1/Y7g2V1KI6bLPn/9aheTvCurY1XFMaovNln74rv2XQHk5e6kaq9ug9NvaH8vstTqA==
X-Forefront-Antispam-Report: 
 CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(3023799007)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261026121527099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 pLdMLVb/9Td6UhFCCE43Bdhnjq88CuZTsvR5ITRnOSbdFmQKuFRo8S928B/Yon5rBAq5Jthbh4eokO69H4as7JcIZo28pKNqduvyPOxJ9Cl+mtBFMV6xtHsV0K4i+dvP/ox+S9bsNvawhwjRuGw1N0uKqilW2Oa+txjfBTx7alavTWTLggRXp2g59k4ferTYwn+z68NZPq6ifw1cQEcphJE3ex5u1Uu6GLC2OzXDc1WKPmJa1RxiptnLESbMQtA3O8EXSJDjZeczbaQofoIjBXyYLi/lgPNFpEFsYK5o6mETZUlVXMZ5Y1J6HirwoCx8flJ4xY1Cjv/xEXT9JHavhwWViZN5mxDANAtXO37PHKUPSMeIz1NGr2OjopU+SkTvdVtwaZxI6rbxdGgqdQETfUCmRrs/AE0VItl3mFWSIhn3/+k2jWC5DQYaKOX/kPSn
X-Exchange-RoutingPolicyChecked: 
	C1fUrAe+fYrhRxG3WupRjbeM0HXi1DVBWxPo4tmIWYsLxgUUeePME2VbOIu04wJ/kZoL4yixizQXes+F4RtyjdJWZUfWHSSpdTQLegcdOIKfS8IX5wWFk8DLnAAwNJlUFvuxZd0GsD5EwRUKm4V7IoLwohtoIcNZuejxeTumPXr9zBHu5XSIBhDQxIw+02QrEDkmmFA1LGqc6C8CnM+acZdocxELjpP9RZsH3bv6tgcablzdUzaXaS68uotomHL3a8xOonL31TU6JjW2I+Hs3HoWaULPlO0v+/hVEsIbRgsGDIdeRGUmjHAV5iMR8BMdaHsHajO1x5+Zuhwrg1lnwA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:18:36.2074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6ccf30a0-18a7-4ba1-4caa-08df39acf7bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5067
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ae9df31 cx=c_pps
 a=94FLU6K3oGZrB1XHaeOsDA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=SU7n1Q_FUUfMMQDcjbEA:9
X-Proofpoint-GUID: BJs7X6e6M4x6alrgwz0OM4K_mBIe4DtI
X-Proofpoint-ORIG-GUID: BJs7X6e6M4x6alrgwz0OM4K_mBIe4DtI
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX+RcYDAtw1OHa
 aemeif/Vb9yFxpyttJooP57BVhFvz3RcTI1wgkO7JpPbtXvXSxW8n4Paqdb5jtC4NDuisEQXIbw
 jIN2RWnKnWahTYMzEUPe0did4RYnRSs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1MiBTYWx0ZWRfX5E5J/sBDvIqg
 fym2SQbhLnmqjYLKudXJe4Zd/bxInf1kyMfRo2wBQO0yXUydDqMWwKeK/oCJbT5GHNc6iwxe3oi
 Tl9z3cSfVnK3iCqLQjjavpS63LV4M3TBIiI0RjaEUJ602W6x6/3wDX385jFGwlNrpweQT13QlbU
 K6gt9E/uudqCrlHL8NyKtQ5NCFpYMTQM+nojERtaAh2G/QVjYzxpLn/4pIDGXSdvi+aEH2pQw4s
 dHmFwUhaB7K9MHdvWX5Wc4BoCIxbb012oL7lQEIe2Ui4o+xc+POpi2K93ZUFkOh9XkXtljTDzG1
 BMdpbrlPOkY5oCNwH26hV1UnVeHZBCtvrWrhRfgHUNoZQHwcXKWuUJkTlBBHOm4QFWPtFosCeyl
 vCpFlppJlO9zZAHVR7Dq9Jrs7n9aZcWulsdErmuqZWYDTg5asftnTCxheN4Ta3afHed6Mf3Opqe
 Hqyb12khw5YMUZnFyPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030052
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: QMM5JQUXGNP6EZHR2KDT3XG2YYHRX3BM
X-Message-ID-Hash: QMM5JQUXGNP6EZHR2KDT3XG2YYHRX3BM
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:59:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QMM5JQUXGNP6EZHR2KDT3XG2YYHRX3BM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add ACPI match table entries to support additional projects using the
TAS2783 codec on the ACP7.0 platform.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
v2:
 - Delete all entries whose link ID is greater than 2.
 - Remove all ASUS-related projects.
---
 sound/soc/amd/acp-config.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 2fb9789cac0a..3d4c8526cfe2 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -98,6 +98,41 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8EA2"),
 		},
 	},
+	{
+		/* HP Cashmere-A */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EF5"),
+		},
+	},
+	{
+		/* HP Sundae */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8F6D"),
+		},
+	},
+	{
+		/* HP SundaeWhip UMA */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8FA4"),
+		},
+	},
+	{
+		/* HP SundaeWhip DSC */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8FA5"),
+		},
+	},
+	{
+		/* HP Kata-A */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "9056"),
+		},
+	},
 	{
 		/* Dell 14S DS14265 */
 		.matches = {
-- 
2.25.1

