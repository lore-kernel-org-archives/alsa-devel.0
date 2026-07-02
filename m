Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 932FEC43458
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:43:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7323D601BB;
	Thu,  2 Jul 2026 18:42:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7323D601BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783010589;
	bh=5d8Nw6ZQIOeP2rTKY8ofE/NK+WmxgDCqDRW2Ol/rKTw=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=vV4jjDPGm5RDYWX33OFDdRfdzr92L48P/th6gAPup1u4d/Gj3VNIhWReSg1VUOfUc
	 o2UfCtOI4CQjULXkkWRxqUaOTmRIrinNkmkdOioHPA/oDErmaHV/23BWp7s2ZdCgLy
	 1/KRohIcGo23YIw4gicPFMkjL6IHduu2jCrWBLDE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 599C3F805C5; Thu,  2 Jul 2026 18:42:42 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 17A80F8061B;
	Thu,  2 Jul 2026 18:42:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1798AF805CB; Thu,  2 Jul 2026 12:45:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782989113;
	b=YkziTANHa3Nh2+rWGrlh0yGmSJ+Nor168+BBN91IWye9ZCAOnZFhwmOG92dZOHT0UCTJ
	 h4oJUOf1QqXSF9PwTGSElMzpQynITOUjsvrWW+otjqo7U/zf78x+5/20JEp6d2tiaVQLp
	 0ITH4Aj0ZMyb3ayQGcjHQZ2ouJS+7Ok5MyA3CW11EpphWFYJpZdTP5W7jHonSIpbUl+MU
	 L0VdtgdggD//Jn6ceISWHWOoo5nz1BTteQNGo9S2dBK0F3HzouSIT9H38qeNNSwfWkefx
	 4+vP6HzpF2wXsYAVeWKT9T5Rz5TrUnmUCOcJvILuJDhLNltWo0PV23PI8bqO83WZFcQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782989113;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=5d8Nw6ZQIOeP2rTKY8ofE/NK+WmxgDCqDRW2Ol/rKTw=;
	b=cGxeRr5mw0IV0W+zB7/0YW2DirZG0hjAfFJ99mJGZ8vNvavx8keOgAVMo5a5T1TUTkBE
	 8xgCz/UVCc/wW2ww9vWX2RU1k/3UMHTHA3xWEkLV6EMpsTIbW2QkdobWOmFb9ubhLswAf
	 0jDiz4d7QK+GhqNLkWpuYGRKRfuP4agIz/LYNhWhFZYgydzZy2B2+ClWWik69uWuy4WzE
	 g692PHfY7avzqGJybqoPjnyqJoVyUOwoewNS8GtVNLnRrIroEPlXlVYfPOm1fn17t+PYE
	 jpUAI7tSrbwJ4h0NL5OUpNCjLHH5rN/H5UikRhSQja4Z9aplPyAlsCE6G815NYXjFmQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=HjqWwGkU;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mq2k7CSd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3FD8AF8027B
	for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2026 12:45:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FD8AF8027B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=HjqWwGkU;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=mq2k7CSd
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6628boDM1954268;
	Thu, 2 Jul 2026 05:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=o28C8TnGlEJmY
	o4VONYt9ouLor/xPSb3fJbV4MQuOn8=; b=HjqWwGkUH08cq3xaU/WbLhJNESwLA
	A6g7yBa/mI/mp0joqJkDzQvqqac8vx6dI5il0QeA0ejwDavwq2AWAOOuzGGVv7Vk
	OagfQdNXBOU3CZdSo/U4znWysi3W68yRkvaz4dJMlw4ydARbBoyDCqZPO5r37MJ0
	AZ50zw7tbcUuzpVWO2SLo19XkR+JiVccsVSKREkH5wBHUI5HHzYFnTvHYg12h6Jt
	QzFoanCtMWBaABaJVJHzKbdmFbZarzPJ7E8m91+m/1xbXkULayacrjpTZ/t57aAM
	ATrFf9rmIUbkwszaZeChNIN1znidhnMZLBXCXbAkIiYNQUmzqGRE5okzA==
Received: from bn8pr05cu002.outbound.protection.outlook.com
 (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	by m0380145.ppops.net (PPS) with ESMTPS id 4f5mn58jtj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 05:45:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeMPvsd7S19pKgdhMx0tb2fGS+DuzI4E4QkJqCDAgArbr6aIadX/n9uxU3TBMieFDx7TA1gXxDyMW2TI1mCWFFippwtXGVtGMHiGJDfO/+dVeo+qv3Qj5q4yCuNrCFFEAim/AGlx3Va3V1c0POAudGCNK3mz/5TLnbyYJ+rXAMyz44W1+mCASJOB2T6F1sxiVTURbNXY1UExHiuyVMn99wcZQIc6Akfdwrh8/NxGQAJekvqAtWTM81+76ctNrMZIuq5aJw9GzTjE6XweO6Vx++iJZKolKA5dkeTFC5JrBYq2gSEbuNSGIYJ+ejsFjq+8xaB++bHSh1/qkKMTEdiWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o28C8TnGlEJmYo4VONYt9ouLor/xPSb3fJbV4MQuOn8=;
 b=m9RHvqflN9PTyF88K40l8jXfdImkVkRYRrlKVeIOixuxz+ZPV1P9tLlC6iNSaZp86/PhvqVhmG3/cx1EsafHig1ySPHIoBWl8G9VvFsLYmSmdaYkoU2H09fkE+7ggsRBPuAAubuJZpYJ0OMDJa5d7PYsI0bEryzVezrdMjhEdoK0DoV3RghCGOSuTEcPeQjCFBzjw02+KiSn30EAtBTc/yLDsuyDxJfkzkamQyE1+SnESvDLorw6FYTlrgJ1t6ic+af5Jqkv6nwvpsNNgtk2gHU3mzkAwVfiFIS7ZUFPCER5cXR2Hm1/ujMYhqv6r6csMdv9G90mB976K2vl5DyExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o28C8TnGlEJmYo4VONYt9ouLor/xPSb3fJbV4MQuOn8=;
 b=mq2k7CSdYLzlvHQTiFxJHcEDS2LYYxBkM067Tug3YEqlE4ssTrOwEcj2R4y7Sf3MrVc1nGZAtZ3WkiDVzkF1IF5X/x2fcJxKr3KUHaPAbx0xJhZHefgZ/okeZyao9oEXY7knmfYPpdB+a1/4BLR4WVw/cwNbfnxfb0RVBQcL6S4=
Received: from DS3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:45f::10) by
 DS0PR10MB7429.namprd10.prod.outlook.com (2603:10b6:8:15d::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Thu, 2 Jul 2026 10:45:02 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:8:45f:cafe::81) by DS3P220CA0008.outlook.office365.com
 (2603:10b6:8:45f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Thu, 2
 Jul 2026 10:45:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 2 Jul 2026 10:45:01 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 05:45:01 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 2 Jul
 2026 05:45:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 2 Jul 2026 05:45:00 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.105])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 662Aish03742421;
	Thu, 2 Jul 2026 05:44:55 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <Syed.SabaKareem@amd.com>
Subject: [PATCH v3] ASoC: amd: acp: amd-acp70-acpi-match: Add tas2783 support
Date: Thu, 2 Jul 2026 18:44:29 +0800
Message-ID: <20260702104429.1157-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|DS0PR10MB7429:EE_
X-MS-Office365-Filtering-Correlation-Id: d4720bd8-f535-4127-7300-08ded826f851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	+Vj5+tMdsUNDjVZfBfXEOcSTanaLn2Mq+t8Qk8gfZHPT0XbNDSdC0pde8//MF5//Qra+bKUPcst13C7OPN55hYSlKYlSOP6DxCARojBTR+aBLzHyj9bDv/DNoE6g/+sv+thVpMUuJ5xn/i5XGOBlruqo9OaLfzsOssWRVm3O4zxTO79dw5qec14fpCvkt5IecmdQY1jkw2yhPolkDpHrAFUnTY74v5mweh/rElzL8CUwP1V45mdrsVrIe7m9RJEh6O0QdXcN4cOEWlT1qjjn9KNnlxZjCPGpbmZozu/csfIvSiagxbbLZgfxBUkcRXAzUXCSwQSyNyUWVPetUJh95OvWfuCJC+3r1QLLjWqfS480r0oHyZLVSiUg7M9MhHD4t5Jmzqwk+MGVTb4Xh0OLj+K5+QXIRz2vNvNvGR3z3da479nZry1C2GOYDXbdBrYckQaebTkB2fJ+I7GhO4NzuuvgVhJpEt3niY7wmKOq3wS/dnCmZBevKL2rp3G1h0WnJLyPwREJoddOABDdDZzyLDaWLTpLm/D6b++uYCCe2LAEGzqHNu/aGDR3+c9pEZkmtIUpn17Dgwlthyr2eZzf3yxVxwQLV5poAV9E5wycIvrajp/yGxXrsr59AKteQaMZatU0zQIE6mI/CgMskp0y751uNtDjQzHuVzTvcimf4zCBhk5LXW/PFn/4nCLGQWcq4pbzCQnCv2SLHefWxE4TFg==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+fWXh9urikEyxMtJBvzdwggnAZ68iQHu/GnDmCjKQ1k8qzjGS9uOjrb74gb8P7H3z3Pp+d0FwfIj/feke7cVPDkFhkgR1Iz5f0DKTi4n/OOqp38p0N7UgZBJMzQCMk8u2ozPPxtXyKdV6lHlK42GmMMUXGtITxkOVpDXv5ObvliB2yD/fVLS5vR9V3fEhXYpeDL5mLFAP2EPwXkDpdZVTkptwsOq0/qbchHKB9ktiKqhamPyJAJpXGutm2JYdvtKrNkYN0b+vAvQz/N/LpCBmHt0ABeVH4j/lpEhsCsyWxEJtoVcgAoUzfqGYRQ+8x0zBxiDHWw8PNpQsso+761+c70zOLC9+zu90wScZMTVqmphQd73V/is/KWiqM38AdHfZDHff2V/6IOAO0QbGuQWpaI8E5h9Wj9T7J9ZCZiVzaon7+UDlncO07zX6dhddBHS
X-Exchange-RoutingPolicyChecked: 
	rks9j0iU0edDlM2u5lszbl4jnLnM1nM7A7bhktInDR0K0N8OGw4M0P02oMvZLEhk8E1Daihlx6/tyr6FefVr1FmIJpnV6eY5cqKGLqGbnFELfq9ThdCnqYr9LsdI59mLc8E2Q2Xw33VriY1XWBtCRv1SIplmEJv+s4jbALw4B7Jaejqea73Mqi3TCAnHWMk1O2+Yn2IDWPFVAuX/5RprcZCaPwODYs2z69u5s01tIScNyaaBSdKGZf3SAkNtOpPU+Nrz0j20OPRjL7eG9AfpupBqFo131QCKJx1evjorhagX38NeBIOeI8Hm8QminHrCbyyQnXvEjGH7V/0+qsQTWw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 10:45:01.8860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d4720bd8-f535-4127-7300-08ded826f851
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7429
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX298NHC7USoLb
 BFARyviQ1sk2Fe8+kLJl3OgJxBeFkhNPQ5QkB39hi3v1MxJVnRb6sGDpL63Fi2EBCQnNNPOgRtm
 HhJVxJXc/pqu2lOFXJwPI8dWjRAVYywI8QRcLFg2uQFXcyrhpL3pwAFYPADvClG4d8bRle5kc5q
 rzPlgmrr1UpRGRRRKYFE9McwGzhv0Hth1iu8a1Xg6Q/uEoGaZHkAnq63bCHZxpKwzUFIrIZWGCV
 JtrDLcx4RjCQUdpJCcC0Ut2aO+bnhXc4vMd3CoX174kVV9vgQ9Noop92QGqcKygB7lj8WIMf74T
 GdUjr09ZnS6Yu3m9JA8jzrMV+ECNRIc0YJdWiAE+fWzQOeHo0X1qfKloL/8AN6KxVL4DzD3VtJ2
 BhNuHoJYKGRVVJTtX5jKAS7Hs9iv/Qwk0xhSNGYuN0Cwo4j0hhHZ4OWhT4fqvtvnkC8LGCgx5E3
 GNiY+QrxEisfA5uFiqA==
X-Authority-Analysis: v=2.4 cv=EMA2FVZC c=1 sm=1 tr=0 ts=6a464131 cx=c_pps
 a=0F+T9beUwIReeq27KEkavQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=u63tYauSxxi1GrxpF78A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX3m5l8CoXsMw3
 sRwMTQTkKhSI/ETNutTSy/yaNSw9s/lOz/u14K05L6y/556sRkrOJVqyqL3XeMNI85YX/i1Kil4
 gvABu975CqWz8fI9fXoT/q2oU3lHl9c=
X-Proofpoint-GUID: U7xlKU02ocN18SOC0vaSpEoUx3myniFO
X-Proofpoint-ORIG-GUID: U7xlKU02ocN18SOC0vaSpEoUx3myniFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 4NBFLWOK4C6NF2TBAUBWJY6JR76M4BPS
X-Message-ID-Hash: 4NBFLWOK4C6NF2TBAUBWJY6JR76M4BPS
X-Mailman-Approved-At: Thu, 02 Jul 2026 16:42:37 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4NBFLWOK4C6NF2TBAUBWJY6JR76M4BPS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add driver data and ACPI match table entries for the TAS2783 on ACP7.0 and
ACP7.1 platforms using SoundWire link 0.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
v3:
 - Remove unreferenced link_adr, adr_device and endpoints for tas2783_l0.
v2:
 - Add comma for the non-terminator entries.
 - Correct endpoints from spk_r_endpoint to spk_l_endpont.
 - Add two more devices for current test project.
---
 sound/soc/amd/acp/amd-acp70-acpi-match.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/sound/soc/amd/acp/amd-acp70-acpi-match.c b/sound/soc/amd/acp/amd-acp70-acpi-match.c
index 18f2918d4ada..f92c6f5831af 100644
--- a/sound/soc/amd/acp/amd-acp70-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c
@@ -553,6 +553,46 @@ static const struct snd_soc_acpi_link_adr acp70_rt722_l0_rt1320_l1[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_adr_device tas2783_2_adr[] = {
+	{
+		/* left */
+		.adr = 0x00003c0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1",
+	},
+	{
+		/* right */
+		.adr = 0x00003d0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-2",
+	},
+	{
+		/* left */
+		.adr = 0x0000390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-3",
+	},
+	{
+		/* right */
+		.adr = 0x00003a0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-4",
+	},
+};
+
+static const struct snd_soc_acpi_link_adr acp70_tas2783_2[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(tas2783_2_adr),
+		.adr_d = tas2783_2_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_adr_device rt1320_0_single_adr[] = {
 	{
 		.adr = 0x000030025D132001ull,
@@ -659,6 +699,11 @@ static const struct snd_soc_acpi_link_adr acp70_rt721_only[] = {
 };
 
 struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[] = {
+	{
+		.link_mask = BIT(0),
+		.links = acp70_tas2783_2,
+		.drv_name = "amd_sdw",
+	},
 	{
 		.link_mask = BIT(0) | BIT(1),
 		.links = acp70_rt1320_l0_rt722_l1,
-- 
2.25.1

