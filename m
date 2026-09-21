Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECB3CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:06:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 928EF6022A;
	Tue, 29 Sep 2026 21:06:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 928EF6022A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708789;
	bh=g9/te5WvsHjHBvdvhfPd73b3h3dKIHi50yfhrHRAfeg=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=IImS3mM2jJLZHAGAL+ox0lhBqJf3M/9UsEC3gqB9kIo1waEAV2jnio0lBfvaM2XNE
	 a7OsLanED4yTPwDhq/l2FEdz+UJtSNpg0xrj0S4iJ3fBox7wnqX6lGqcimWQ9Zhtvx
	 IiVaR2IbiBmLVLmYIN0K7wPfAL0DE4vWvOOe4JZo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 53971F806AE; Tue, 29 Sep 2026 21:05:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BC6BF806A9;
	Tue, 29 Sep 2026 21:05:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F29BEF804F3; Mon, 21 Sep 2026 13:22:23 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789989739;
	b=otlBOwQFwcw13sZDQrDu8/d0K9SiQa7zOPBmE5PsFV2neSC4HkrOM88grr1QlIermBnf
	 zbe7VSCvxDs+qLREeFYfBXzOmNu1Y1OlE/YyJpBTr1fqhj1z7t5nG3YBiixU4UWNlxBl8
	 Npuvcaw6Vldl5bUQcv1zPEPc3/E8OlocyMaXWDqT7GmMFofH5IOjS1Ip8EePoC0TshvBe
	 pHcA8Xjegdgtyn1vjluCR7O9uUMceCW/f9mvL78YU27Mbdp+KL3Qgv0U9C+94V0osKNe5
	 WUoNj0mYUfHHUFSYHec/gTBopH4NARe2haq5qzpT1KA0LD1knwx4OjkaKdLOPnCXLPA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789989739;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=g9/te5WvsHjHBvdvhfPd73b3h3dKIHi50yfhrHRAfeg=;
	b=SE0OvAoQf/Hlp+Bl/jQAuXVLw8fAyLzg5sMrFyd7XR//1JkwZXTiAXXQlFK2v7mMOlXf
	 gbzlgWk7svcQSGUH5RzVosc1Ce9vA+BvoMRGrSU/RG/d6gZnzcLyiLWnFUpg4xTAFQYPT
	 vacfbQVqFrQAIDHK6rykWgzwA3TgxsW+MDnFum8no5aFxwgmVMCB+d5l06tUMAGLazIBL
	 QbP6kJQyMA/cy8HVU/TmpqB6glc/Xf/WjtgKffPvn/zrcK8wzwy+5c78/Rajth/1cjLyI
	 JF+QbJ3JxVj6ZxL81iWszn92DO/nTyUnSc3JHlHHBjAspD/gZ6VA1yOGHzylvkO9BfQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=F2z1B4FN;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=RK8mTXQu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0273AF801F7
	for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2026 13:22:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0273AF801F7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=F2z1B4FN;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=RK8mTXQu
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68LAfJgx668739;
	Mon, 21 Sep 2026 06:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=2nKFF44/VHxdb
	0bi3G/euatML3Y7aet/Oa0ERJnlurI=; b=F2z1B4FNvbNfK/c/WVe6z9D1sGBhk
	aM92WjQ8kbUoPXBRHKXQJRXU1I4G74sRkgUwY+xmdB8oFVaXERLy0aW1fM8/QXJL
	O2ElwfAZNN8NHl9IW6MMx5lLDqa/C0i6k3ZHk0Qcgb7tamOSmdVV06ERjSh+1G7e
	DglOG/vDzh4XkCRzpFgpKwRbDpdyZjou1TFwpgndbj5Rs09n5Oy7M38v7L7JzPt1
	cRix0pUL7aWE1WkD4IEtreP/oDKxiMHy8zgv+VLUj85pTWFerERDGEkPTwaEDtSr
	qH81bHPwou8TAmUlrqmTBjoihGvNkVWxK8OD9y4jhe3l+UBIOvP2svtpQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gtcbnp2xk-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 06:22:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=goe3xP0/TNqwg3iB0TKMXMmpH1K2mbW1Gh5dWPr1bRQ2BCeqwNj8uAaGkVa0bDFNOjuO8k+tNi/ccVQCzPkPxOpuxM6/uekkES3D75bgqX7JO/F0v5tHvV/S3LJjApEC9snDD70Cs0WCkmDP/ca+4dQwKzEfxlsy0hWxct60RM1vkvtv7JmxB/iGDZHLpAja9agdYhFaAzrNQ++rvfMJjVl6x0LtkqSw2Z9B1on+tZF34z0OYngRY4okF4X8zMKHpPqcFY4EZhI1p9tr5ozdp3frxVBhOcRHj8mpZGTfxQhumvTpn1lgPoCSAagqjurIEZJepZzD0uBuRo69thkIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2nKFF44/VHxdb0bi3G/euatML3Y7aet/Oa0ERJnlurI=;
 b=itptCy5NWIDcZiSeJDJU7kE4pvmu+s4OQZFelRJja+ltIv+Mv+IlHHoTt0m6vCd5DP6Ad3ZptDAgj5ytmp6uSMrLBuWGyWCZ/f9Ca2FE9TX91OYoofv/cpkgA/8U1pXcylKG3EfBnlm1yApxusbzjXLmFW8tjMBSmPMOSXqtjRWirdSQpzmSUAVNPpYGfRddoSC0As7gHbUV3beKsdez8yWMDXAKaZayGb2+wpMYHIAJLKKCiqqkOOMNQAAWvko32gY2H6MkYhpknI/qzGVMdqNuJNvAsSceluvCUUCabkb4xa4TUyz/Rj/Omc/xlchYg823DAI/VpeEwLkrQDAtFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nKFF44/VHxdb0bi3G/euatML3Y7aet/Oa0ERJnlurI=;
 b=RK8mTXQu5Bf8JT5ixxzG/ErI9B9emNU2Z/G9CCEBmcmgu0gkk96bkN9hJyozh/oDR4HTcroXtHi3I9f3G1uH53vbdwAH5H2XKB10yynJViY8nGl5f7q7JZhqxaW7oHmFIPrTmvYRJeN3HQrXxBQfPCKE0eZ0uG9alAQCMuq4SI4=
Received: from SJ0PR03CA0112.namprd03.prod.outlook.com (2603:10b6:a03:333::27)
 by PH3PPFBA17DA552.namprd10.prod.outlook.com (2603:10b6:518:1::7c3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Mon, 21 Sep
 2026 11:20:13 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:333:cafe::92) by SJ0PR03CA0112.outlook.office365.com
 (2603:10b6:a03:333::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Mon,
 21 Sep 2026 11:20:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Mon, 21 Sep 2026 11:20:11 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 06:19:39 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 21 Sep
 2026 06:19:39 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 21 Sep 2026 06:19:39 -0500
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68LBJXnp1945608;
	Mon, 21 Sep 2026 06:19:34 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v7] ASoC: tas2783-sdw: add firmware download status check
Date: Mon, 21 Sep 2026 19:19:30 +0800
Message-ID: <20260921111930.1040-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH3PPFBA17DA552:EE_
X-MS-Office365-Filtering-Correlation-Id: 774bce24-1cac-43dc-c9b9-08df17d24d63
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|6133799003|18002099003|3023799007|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
 ig8T0XoqO/h9bXX+N7gCNjE/SScr9j5JTH7UOl9ct+A74ZDJmOx+BJtEI7QKlgiUmHJIqrUzGKiTeOiCzvrr+OJGYQ8+XYw837eDztvU/tP/TpNm58azwx6nEbVEogOhbB+rfMauaHJVTLPI5QcOIVBQ6kW+uX7vM1tSTSuWkTIlJrTvuUHAVF9jn6OOV8JrL989c/0TF2/Yk6WlXyjeGiPo2lzEYun0ptnVrp75y/hXK50614jcfOmtNJP/LbrAQK1iPZjpp/6u97RDDv/3I9kO7W0s5JlsaA1Wkr44TG7IiV7eX4GE3ArMYCVYMwsGBcZlHQvYz9JYi4acExu/54LiILZy5urqMhPfV/uAtXm2cW7HPuE5VWl8iprd6KK4sX1tRYAG0uXUUeZoBw3Y5Q9x6DrskLrbBRrlOV8M5JCgC/rA4uLSgfit64YPJgTTeqXRpJfVKa2hgoSAHH1k/hXJvOCt1iag9IrjkJLGwJuFj/oMfSwS7STqJ+jMAXl9+O7HSiyOAysFPly4yVla5FOB51y+wTSnbCm6HKELZFlgKmxtEZhH30J7BH3CiCiDb7dCkEjG0TGr3j5tpwM6byaXQhTSDBaE9PAMzaVS1RXA3Jxzx71U1ZfxfAdfWRbzn/kB1sqcpn1lU4uKQzWS2ndX2KqwZMt+0SPoCuQ4ieha3UqcdUH/l4w8pJuTnF/Soi8v2xyjiIeFWW3hlAzAJQ==
X-Forefront-Antispam-Report: 
 CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(18002099003)(3023799007)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 hJ4/vkMSXKKXN8z/fLT8n4pyRfzwQR4RUfrBgCTFr3yOZjtUTg7alObnyAnEv0rIDseGQT+7NwWzj4TagvzBwc5am6KmwXhI5TPtAR9NhINQf08cBIkA6xpny9xvKfCWNprIydvqH31JGkO1LpyW+UJoZ95lubQUgV7gMREG1QWMpsywLcxzuiXXDlPfACtNsKaMXTEquD8/75+mhPpiYVBG5Co5blAtnGPETI2FUFNjkPS5xHs+Zq9yvO7+3tVKrLS8pYuFjwSRiEfTQJ6TZli7xOfJmklsu/qHpDsTncult+buIGLi1YiDuCUKqdU/9Wk1/smJM2c+BM071ICJ1tF4dq4wehSKGgCdNnr2/vIjNANUkZ1ehsoCjtxIi09YDrOBzr3qwkf7JSWIogb5wbwj5Kb4zgWdN2oFoUExNWfxmikWmJ1AfkOnpvKy2LXm
X-Exchange-RoutingPolicyChecked: 
	Tj+zULaSFC8oIqpdfeUDhJub0aBtR1t4AFNNtClLAhWatgEd2tz/C6PsFf9k9vTKMt+v2q1ynO0SlMo5sMWO+DSHROlekT8yCN14brI0BPm0f3KBEGq7CVlLeGimgzr5rtTtNGtf1wXb1zRgABiJONU2bDatUJ5eACtA1iGSogNUAZmAIkhelwchr3TEhWgHupWAqzFzaR9x0hfKjq2DEc4f17n4Zc/YruklWWYNiIimRDSHA/uStMRiB0PR654SelsoBmiwzGksfJ/VwfOVzjL0ZbzAC8ICx6SSgD6amDi3eZ7hTM9R6LkEv9+ioqjZkOl8Z83t4xDphPsa1pQ5LA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:20:11.7484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 774bce24-1cac-43dc-c9b9-08df17d24d63
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFBA17DA552
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE2NCBTYWx0ZWRfXzhmTPUyy9lT9
 XLx5myNvw62br8QXE40hSPmeMEqswlvwkB7mvE3ZpIf9vGmCVVJ9PzuC0d7AKkQZ3V8uJitmqND
 OYYjvbFoQOlBy7yTOiG5bof4MMTqQb8=
X-Authority-Analysis: v=2.4 cv=P7CvFSAu c=1 sm=1 tr=0 ts=6ab11363 cx=c_pps
 a=p5SqRtR3VJW1kgksvcX22A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=jCSrLPWn5dSP2qGiRh8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE2NCBTYWx0ZWRfX3j0lZGm35pkJ
 as94cXQp5vE+eaNiQC+vZk6ZBszNY88TXImU/23q7UcGTUZpt5lWjTSZ2aughS5mlCtQ0WNRKvE
 jDTT84YmRgbMcf4ab7VRF2zokdpcTrNMkAFQyoqGCwJLsq0rjHsU2xLbkpleJCXf41gpihJVa0g
 jdAAzKS1ikgaonQX7/PMoSn3W/GiwdZr8vC/qmZnk8OfbJFkEJtgp/ef+3FhEFYFJnFW+hdDjr+
 cCn2IjrW0wxvTdd9ZZVDQDh2VXT6/PWpZjzwdhaXKbFovL2+9kJWJeYRe9pc3VDa4i9hSOxDCDx
 bxrmaRECWceOrDgquetbkAvPIgcEpsii9HGAU+MOANtfb7Nf85O54cTZQPrBFGJGbdMB2NvSAcz
 QAuZkY9DcM30WRgJKnWwrpEBWFPPWlTCy8o6ztApwJ1Em2bRjeVqFFeMq6pamQyiJiEvuZsyk1u
 2/DfgjtXP3gsUMpszyQ==
X-Proofpoint-GUID: AjNvb7s_ZEV-aK9Q-oAt1nYQ7RHcn6Mv
X-Proofpoint-ORIG-GUID: AjNvb7s_ZEV-aK9Q-oAt1nYQ7RHcn6Mv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210164
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: YGMWOBAWGI5OXHVHTD52XVKVKIM2T3OC
X-Message-ID-Hash: YGMWOBAWGI5OXHVHTD52XVKVKIM2T3OC
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:04:43 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YGMWOBAWGI5OXHVHTD52XVKVKIM2T3OC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Currently, firmware download during system resume from suspend introduces
significant wake-up latency. However, since PRAM content in the AMP
persists across resets and is not erased, this step can be optimized.
By verifying that the firmware version read from registers matches the
expected value, we can confirm that memory content was retained.
Consequently, the PRAM download can be skipped, significantly reducing
resume latency.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
v7:
 - Update the description about this patch.
 - Restore PRAM and YRAM in tas2783_sdca_mbq_size to avoid register access
   error, it will cause download failed without this.
 - Remove register check for firmware download.
v6:
- Exclude PRAM and YRAM from the MBQ register group.
- Revert changes to usleep_range().
- Replace uint with unsigned int for kernel coding style compliance.
- Remove AMP reset logic from the driver remove path.
v5:
- Add fw_version field for PRAM status check.
- Adjust register range from pages 1–127, 253 to pages 0–1, 253.
- Include PRAM and YRAM ranges in tas2783_sdca_mbq_size.
- Set max_register to the end of PRAM.
- Add PRAM status check before firmware download to skip reloading if PRAM
  content is retained.
- Add a retry mechanism after download failure to handle register write
  issues on initial power-up.
- Call regcache_drop_region() after firmware download to ensure correct
  firmware version reading.
- Read firmware version after download for subsequent comparison.
- Remove the "separate two monos to stereo" workaround as it causes missing
  audio on the right channel; stereo configuration should be handled by the
  DisCo table.
- Add AMP reset in the driver remove path.
- Update PRAM_ADDR_END from 0x7f to 0x80 in tas2783.h.
- Add address definition for the firmware version register in tas2783.h.
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
 sound/soc/codecs/tas2783-sdw.c | 70 ++++++++++++++++++++--------------
 sound/soc/codecs/tas2783.h     |  4 +-
 2 files changed, 44 insertions(+), 30 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index 85ab3fd83c7b..a57230e01f75 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -97,6 +97,7 @@ struct tas2783_prv {
 	u8 rca_binaryname[64];
 	u8 dev_name[32];
 	bool hw_init;
+	unsigned int fw_version;
 	/* wq for firmware download */
 	wait_queue_head_t fw_wait;
 	bool fw_dl_task_done;
@@ -315,8 +316,10 @@ static int tas2783_sdca_mbq_size(struct device *dev, u32 reg)
 	case 0x300 ... 0x340: /* Data port 3. */
 	case 0x400 ... 0x440: /* Data port 4. */
 	case 0x500 ... 0x540: /* Data port 5. */
-	case 0x800000 ... 0x803fff: /* Page 0 ~ 127. */
-	case 0x807e80 ... 0x807eff: /* Page 253. */
+	case TASDEV_REG_SDW(0, 0, 0) ... TASDEV_REG_SDW(0x00, 0x01, 0x80):
+	case TASDEV_REG_SDW(0, 0xfd, 0) ... TASDEV_REG_SDW(0, 0xfd, 0x80):
+	case PRAM_ADDR_START ... PRAM_ADDR_END:
+	case YRAM_ADDR_START ... YRAM_ADDR_END:
 	case SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_UDMPU23,
 			  TAS2783_SDCA_CTL_UDMPU_CLUSTER, 0):
 	case SDW_SDCA_CTL(1, TAS2783_SDCA_ENT_FU21, TAS2783_SDCA_CTL_FU_MUTE,
@@ -517,7 +520,7 @@ static const struct regmap_config tas_regmap = {
 	.volatile_reg = tas2783_volatile_register,
 	.reg_defaults = tas2783_reg_default,
 	.num_reg_defaults = ARRAY_SIZE(tas2783_reg_default),
-	.max_register = 0x41008000 + TASDEV_REG_SDW(0xa1, 0x60, 0x7f),
+	.max_register = 0x41000000 + PRAM_ADDR_END,
 	.cache_type = REGCACHE_MAPLE,
 	.use_single_read = true,
 	.use_single_write = true,
@@ -745,6 +748,7 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 	const u8 *buf = NULL;
 	s32  img_sz, ret = 0, cur_file = 0;
 	s32 offset = 0;
+	u32 val[4], fw_version;
 
 	struct tas_fw_hdr *hdr __free(kfree) = kzalloc_obj(*hdr);
 	struct tas_fw_file *file __free(kfree) = kzalloc_obj(*file);
@@ -786,6 +790,11 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 	}
 
 	mutex_lock(&tas_dev->pde_lock);
+	ret = regmap_bulk_read(tas_dev->regmap, TAS2783_FW_VERSION, &val, 4);
+	fw_version = (val[0] << 24) | (val[1] << 16) | (val[2] << 8) | val[3];
+	dev_dbg(tas_dev->dev, "Get Firmware version: %08x == %08x?, err=%d",
+		fw_version, tas_dev->fw_version, ret);
+
 	while (offset < (img_sz - FW_FL_HDR)) {
 		offset += tas_fw_get_next_file(&buf[offset], file);
 		dev_dbg(tas_dev->dev,
@@ -794,6 +803,13 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 			file->version, file->length,
 			file->dest_addr, file->fw_data);
 
+		if (tas_dev->fw_version == fw_version &&
+		    file->dest_addr >= PRAM_ADDR_START &&
+		    (file->dest_addr + file->length) <= PRAM_ADDR_END) {
+			cur_file++;
+			dev_dbg(tas_dev->dev, "Ignore PRAM block");
+			continue;
+		}
 		ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
 				       file->dest_addr,
 				       file->length,
@@ -801,17 +817,34 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		if (ret < 0) {
 			dev_err(tas_dev->dev,
 				"FW download failed: %d", ret);
-			break;
+			/*
+			 * We do retry here for some special case of download
+			 * failed after Power-On.
+			 */
+			ret = sdw_nwrite_no_pm(tas_dev->sdw_peripheral,
+					       file->dest_addr,
+					       file->length,
+					       file->fw_data);
+			if (ret < 0) {
+				dev_err(tas_dev->dev,
+					"FW download failed again: %d", ret);
+				break;
+			}
 		}
 		cur_file++;
 	}
 	mutex_unlock(&tas_dev->pde_lock);
+	regcache_drop_region(tas_dev->regmap, 0, UINT_MAX);
 
 	if (cur_file == 0) {
 		dev_err(tas_dev->dev, "fw with no files");
 		ret = -EINVAL;
 	} else {
 		tas2783_update_calibdata(tas_dev);
+		ret = regmap_bulk_read(tas_dev->regmap, TAS2783_FW_VERSION,
+					&val, 4);
+		tas_dev->fw_version = (val[0] << 24) | (val[1] << 16) |
+				       (val[2] << 8) | val[3];
 	}
 
 out:
@@ -962,30 +995,6 @@ static s32 tas_sdw_hw_params(struct snd_pcm_substream *substream,
 	snd_sdw_params_to_config(substream, params,
 				 &stream_config, &port_config);
 
-	/*
-	 * The two mono amps each render one channel of the stereo stream:
-	 * snd_sdw_params_to_config() hands every codec the full mask for
-	 * playback, which leaves the pair in mirror mode and one channel
-	 * unreproduced.  Claim a single channel instead, keyed off the
-	 * machine-assigned component prefix rather than the SoundWire
-	 * address, which is board-specific: soc_sdw_ti_amp.c names the amps
-	 * tas2783-1..4.
-	 *
-	 * Which side an amp then renders does not follow from the bit that
-	 * is set - sdw_compute_slave_ports() advances the payload offset by
-	 * the popcount of ch_mask and never looks at which bit it is - but
-	 * from the amp's position in the codec order of the DAI link, which
-	 * on these boards matches the prefix numbering.
-	 */
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
-	    params_channels(params) == 2 && component->name_prefix) {
-		const char *idx_str = strrchr(component->name_prefix, '-');
-		unsigned long idx;
-
-		if (idx_str && !kstrtoul(idx_str + 1, 10, &idx) && idx)
-			port_config.ch_mask = (idx & 1) ? BIT(0) : BIT(1);
-	}
-
 	/* port 1 for playback */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		port_config.num = 1;
@@ -1074,7 +1083,7 @@ static const struct snd_soc_component_driver soc_codec_driver_tasdevice = {
 	.num_dapm_widgets = ARRAY_SIZE(tas_dapm_widgets),
 	.dapm_routes = tas_audio_map,
 	.num_dapm_routes = ARRAY_SIZE(tas_audio_map),
-	.idle_bias_on = 1,
+	.idle_bias_on = 0,
 	.endianness = 1,
 };
 
@@ -1234,6 +1243,8 @@ static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 			ret = regmap_multi_reg_write(tas_dev->regmap, tas2783_init_seq,
 						     ARRAY_SIZE(tas2783_init_seq));
 
+		/* Re-active AMP after resume. */
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 2), 0);
 		if (ret)
 			dev_err(tas_dev->dev,
 				"init writes failed, err=%d", ret);
@@ -1413,6 +1424,7 @@ static s32 tas_sdw_probe(struct sdw_slave *peripheral,
 	tas_dev->dev = dev;
 	tas_dev->sdw_peripheral = peripheral;
 	tas_dev->hw_init = false;
+	tas_dev->fw_version = 0;
 	mutex_init(&tas_dev->calib_lock);
 	mutex_init(&tas_dev->pde_lock);
 
diff --git a/sound/soc/codecs/tas2783.h b/sound/soc/codecs/tas2783.h
index d5996c73526c..2f034617e356 100644
--- a/sound/soc/codecs/tas2783.h
+++ b/sound/soc/codecs/tas2783.h
@@ -35,10 +35,12 @@
 #define TAS2783_AMP_LEVEL_MASK	GENMASK(5, 1)
 
 #define PRAM_ADDR_START		TASDEV_REG_SDW(0x8c, 0x01, 0x8)
-#define PRAM_ADDR_END		TASDEV_REG_SDW(0x8c, 0xff, 0x7f)
+#define PRAM_ADDR_END		TASDEV_REG_SDW(0x8c, 0xff, 0x80)
 #define YRAM_ADDR_START		TASDEV_REG_SDW(0x00, 0x02, 0x8)
 #define YRAM_ADDR_END		TASDEV_REG_SDW(0x00, 0x37, 0x7f)
 
+#define TAS2783_FW_VERSION	TASDEV_REG_SDW(0x00, 0x20, 0x3c)
+
 /* Calibration data */
 #define TAS2783_CAL_R0		TASDEV_REG_SDW(0, 0x16, 0x4C)
 #define TAS2783_CAL_INVR0	TASDEV_REG_SDW(0, 0x16, 0x5C)
-- 
2.25.1

