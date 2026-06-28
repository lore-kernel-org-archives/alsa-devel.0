Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABE1FC43458
	for <alsa-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:57:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1BA906026E;
	Tue, 30 Jun 2026 13:57:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1BA906026E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782820639;
	bh=lDedeQgodsJI59cK1a6u8k+pfAqQr74OAHHiBkmd0sE=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=IVPDZbf9mPufSMLEvTTg5BVVCwGFOfiVjL9uR4dvDsExCvgOS+EHZ7iOvLCDfe3fa
	 sXVMTG7N5B+lgvLVBYsJqDidsI7BgoG+TAOCBYdPp05/0JS/1Epr6zbqEqUuls5nxO
	 WuFAuaaOpWHiBoHyZ3/sNjglYOZK+Fuzy8aYlGww=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2FBC1F8058C; Tue, 30 Jun 2026 13:54:29 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E89BF80792;
	Tue, 30 Jun 2026 13:54:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CBCADF80548; Sun, 28 Jun 2026 14:26:32 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1782649591;
	b=DhksdzwLlBqH50c8JPZ45rP4e9LYwyKNUFATpamo/w88lZeBtLup9VSrQrnUMuBIVdEw
	 JfA9FLLKCF27dNahx2Z9PJQGfy++YqX8rMN7jJ8XP2vMclhTszpC+w9Gt3li/BOb1Laj0
	 7N4GRvSjHQ6Y1IreG0mQUG0uwdAkRy5RVPP+Z1buZju8NoGbLvSkOohgmVQSFjxAyPYhX
	 I8EXox+VJlpdJy60pSZrASTIm8Jpv54nTz7/Xjo1Qt+krj+JJgr9x8g3Quv8w+V4/mk+U
	 80zPLXf6m1iglc7w3RmADpA96MoUSGr7xIDJkCS+gpxtb5K6+ZRYzEtMt4wjyrbZrmA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1782649591;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=lDedeQgodsJI59cK1a6u8k+pfAqQr74OAHHiBkmd0sE=;
	b=R5t7C+iDUM5r3aZ/KBrUoN+71/LdICBsdFUmbsapGSmSdOKjz1w092+vJ0Azj+pHR4hT
	 i01JoyXMg3f/1Ru51FWog5klpmQ5QpzKOFyKZGzVv0bCK1KddnqHJlWVxSEPS0HlsRM6g
	 VDnwwzTt7KMwhTt/axCxLmtlP82VCzzWb1Vv1cmsEMoxOmJwOQgC8+cWUu44OXZTHSD7X
	 tUU8dhTPsoMNKbNORc1PLSZD85fR4JPfM3Spa5/3ZSz9HIx0hp7xkvpPraGpZMbHPLBAO
	 BfVIyz0iKsY0opI0dzHtol64S29PAptfGBXBACyT5mej83qqtAF/Ukt7IsoLw3ZDKnQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mlc4q0Sp;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ZBan+GeQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 17E89F80212
	for <alsa-devel@alsa-project.org>; Sun, 28 Jun 2026 14:26:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17E89F80212
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mlc4q0Sp;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ZBan+GeQ
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SBCTcB3392791;
	Sun, 28 Jun 2026 07:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=3WAAQhvQd7r6V
	IpfxNodqGNfvnp7vmx9ue65tGsrx1o=; b=mlc4q0Spli0S8dIUq/q50iVg/RiyM
	81D7htkBVE2ZTqRMgwQyuYBNsN/cTCvz0pzj6CKJ/vyq1JEh31MlZA42zwCAVxs2
	26dgr4uD3FxvFTeFwFZ79bJQkVePVLA7H0Xw7ibbbPnAkQOsDgCRpHAB661Mqq9N
	3uhajvNXeu8QbRJr9o7K+WVEugUD0tgAfwUSvQEr1H58mvn6twsuWwOp+3w3z8OY
	0INVVugPESFns/Ni0ARDUGhcMvQSJVrLT5cEzTIaVsM4jVzrbNlgNOnvk8Eoesog
	XjXj5N0aQ8rvZdDPCi6STOtoh0FdzmD65Dy/wncswEqFGg08g+WFxQfWg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012002.outbound.protection.outlook.com [52.101.53.2])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f32hjg72a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 28 Jun 2026 07:26:23 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CKi3R40ZHZQWGrpxgKT38Be0rryNm38+dOTD+VBoAOzGDZrF3AClqslojPGGZ6Gjl35A8kIr5daApR9QgD0H0lxhuS288o+BVlVR36U7pno1Y5SUy8RaLpKcAMbj+jxmzqYJV/77pqK7ibSgASbIbhA4bvf8bS9EMWF7yCSkCY/j6CEAp9dyq+7JivuGyZry9e4v2apCIIVOfdyTHMjJTTeCOWh0F/kjUf9nUnDLf0zJtEK0+UtHLwDL3wEecVTUqnGs72GopLy/y2BErFIGijU2V7cRIwMNerXreOAiUNb2nRMyipSgr0ueMMn8SH1muCl+dZS6MMoT9UKifL4AMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WAAQhvQd7r6VIpfxNodqGNfvnp7vmx9ue65tGsrx1o=;
 b=ryH3wcqcNZ21de22q4wdr4xCrjZfELzSBmni0cY+YxHZwhRIq9zUmJTc2BIRBihEuqthHyT74oLAWBQWx2uVayKHYHTTUbZRqt+Mgq4A49m0H70CCww/2YuFLfUEDA4+qnR5YAu/2YHq+B9zOki4YvFeMbbrXN1SUOVN6JrsFbL6S1cOp7eYzNz/6G4F078FFmkl68QRqK23035zWuYOMLqP3a4E52omff2KPUkR96JruZOGilWSHvZbEg9DsBqsJjfInzHTx9LREXfj5kI3kiqv0UUC2BeQxrZbmcgtfgO1LZif5zFsRX+SVaeEN98+vFYsvWZNzNVzvSLwkEpnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WAAQhvQd7r6VIpfxNodqGNfvnp7vmx9ue65tGsrx1o=;
 b=ZBan+GeQum5JX2+ISuqFgxp2oaSy+AU3bFXTRdI2YKBUdxP+qj3kgB/SOvyARrSrPFxiRDep0zatSqJL8Ia291cKjKNqU2HVobN105nwO9KCKi8PdH/Mv2amJoRrIHOXZ+l6D+I3hPdnM6KSWYhH/ptwdeKcz0UgoC6BloqcjVE=
Received: from SJ0PR03CA0133.namprd03.prod.outlook.com (2603:10b6:a03:33c::18)
 by SN7PR10MB6523.namprd10.prod.outlook.com (2603:10b6:806:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Sun, 28 Jun
 2026 12:26:19 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::5c) by SJ0PR03CA0133.outlook.office365.com
 (2603:10b6:a03:33c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 12:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 12:26:19 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 28 Jun
 2026 07:26:18 -0500
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sun, 28 Jun
 2026 07:26:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sun, 28 Jun 2026 07:26:18 -0500
Received: from lelvem-mr06.itg.ti.com ([10.250.165.105])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65SCQCt01716969;
	Sun, 28 Jun 2026 07:26:13 -0500
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>
Subject: [PATCH v1] ASoC: Intel: soc-acpi-ptl-match: add tas2783 support
Date: Sun, 28 Jun 2026 20:25:43 +0800
Message-ID: <20260628122543.757-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|SN7PR10MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cb735f-8c98-4d8e-776a-08ded5107539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|18002099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 
	1sd9qkRU2dmeY0BvxRG05GCd7UTnheJ2qiBbQPOoDYikcUqyyaIS/N4pJA4u+omNxmytTMsHbeU+3/8Garhoc4RDwsYo7up+5anBtFzdCXxyG9jgLNoC18woqgUEN5AOvoQIDDziV9DmMI2nGb8KbuGXqXswvX+B3b6PnKNIKqQaxRCzBsoXzFeeoOwXwlXomYBAHhYUDXItpgY4DIVeXAgyY8NTugXR1pVIYcitnUeq3jdZVQk7iTqO045Mnp2xm7MyiOXvhLDsTYP0lsYd13RVKpIYfhSKf5VygkOBXEdlTtOeRQiMHxZ5YsDgSAhBNX3ArFQ0t+4UdLRE8YOdLbznemf+FaDXFX2HQ9OKr6kibPm51PDtHMwXnvuIGK/LjAvtu5K7TAIajGE2kUMazvL6VwAGumOZQ1w8I+x8n5RZYb2Wa4p9aFAScEsDvpU0M/B9K4ap1KWBc0liwjNNG916sAOWaqag9v6SDUGJr//xWFx4NfDvt5V+SpS+nXIOOaYKWYa5o572vPg6JlblYSyK4BQ3c9dvEOOK4NrFHJFCq7lxr10dKyxv17Tki1yxadAMDWkx5WZr/altXfVuEXjG5IbuCPTWEsGtLHWUW9r2eih7C+oTul2Z4B+5cQfVd4YQzFKjieKLWn29obKC89oaA/tt+F97YUhudQ9irS5wHhb11UfplzSIf1+/fdzUPDWxy/xn+qTmVfyabY9G/A==
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	21Ombh9Adt+tJ57gKpNdEhpIAxkDZ9eshwkK26DDpfXCsE5LFXQx6BIOgPrSTWF+YpM46q2zO8A0vSuhqityJqCq3rntI8GG133Nj4j0VUa8Enm7Tmlc791bSxnYZeR/XRiVBxLSuo6waz262Arwr7WnWTupis5BQhkJuTDt3JASuM7f0qF6wga/50MuFyzo9rTOjnHV7B8DPansOkw172YZcMd1UoyjCONuudJhsBZ++3UFLquB6uBVathyVmDmrRv7I3edWJliQ0DMwpm1C6w/yPoU9m+v51VeV3NiIOeKff3Y6DC968eWcStEoCWeuaEfgOMjRi6YBACvw23Ull2gWklM7iKl3YbIbeIsBMIgh4h+5zQ+TRzWEplvAgjRwsUHCNdBgHLsnz3tA89Bvh0/0fJrX8TpRN4ppACteLgWj0lOONkx2wqUUza3MvOL
X-Exchange-RoutingPolicyChecked: 
	QYzzRUujtMoseiSGgoiDNzepFQTf3bU9QI0lKxFXSUHyRptQxUqj5GUc0t8n74uYA7uuIBpcdyfxes8OU/UY4GhM8JZMiGRUIMRyD4YIcqm8eXQJJXT+aqzifnLAtaCmVRs7UijevIQR3Um6OiKpAF+quH9AGwv7sDUDhXVZoInNSu8SAzyfUHCNIL+coJguMxRhI2bTr6FUaClQ/6UGxoWhB8TgLSOyIyF9zvfKMD1rdcc3iaQ1rWEHqlm5lRGkNMDpeO+JOkZRNq0ldU9DWmN2FBmAzKSQFdwo47EMa8BpLvS6fc3RMJPKUNqLo30gz3eDLZ6MUeMO0JD4Wy4d3Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 12:26:19.4717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 17cb735f-8c98-4d8e-776a-08ded5107539
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6523
X-Authority-Analysis: v=2.4 cv=DrlmPm/+ c=1 sm=1 tr=0 ts=6a4112ef cx=c_pps
 a=boTDQTO5XcRoDQ12XycLVw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=6vQK-t_yByiTr5j5hSsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDEwOSBTYWx0ZWRfX/aQW/MmSQ81B
 8+uZBftE/z+Y3Uk/N51EzfOiAzSEeY14gdavYpYRfLpxkP8GF72QsHKtDA4lIdBQnY7uGZ1KuEv
 xANdix+C+kRml4rxjCx6JCikMPe/3oyIUz5uSAHWGCxnkqFh0TdYwmi5L9o0aan4GDHQIFYNmlC
 X5NEhgdOwFD0gUaeERXTImg4l/iLntAJFOtUb5CG3qK3EGkd4V6V+/Hr2vIUsHqRz2ToRToQ8Dt
 asF5c5Rxb9+FRdOd/KJ0bXdIEI/8yAo/UjfX6RoF3tHfV3STHS3LWQH+WWEYUT1IFeDxxuBq3ug
 ZxY67rJF9lTlQgKPU6kFi5Ps4kaRwlJJBTl3TeQRcqFcQsqDWpqAO4oHEbgbhv6jmoRuwZCLNpJ
 WKR+nvUrbnffvHraHgDXLArTxuRHiYyx9RoF6lBzvGtrfDqbkgfzMo3nly+C/DnfqXGH+0m6RaL
 FbWlwuNKfq2OTyVsbNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDEwOSBTYWx0ZWRfXwyeP7jF6mq/w
 WC2qweqMPji6N91RcIcTd0PMGt9vzDrraGvVAe7vEVD1toBXJtFtDEbGWMtTlU+h/YUrvGfv6Yo
 CJuSJQyp4Z9bxsrdaHjzgLquES5H//E=
X-Proofpoint-GUID: hmAK2QOIJE3WsiWLTw0HmYRZsguGqOVH
X-Proofpoint-ORIG-GUID: hmAK2QOIJE3WsiWLTw0HmYRZsguGqOVH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606280109
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 2WKRJFXYCISHRU6R4ACJ5LUX76WSSEHN
X-Message-ID-Hash: 2WKRJFXYCISHRU6R4ACJ5LUX76WSSEHN
X-Mailman-Approved-At: Tue, 30 Jun 2026 11:54:23 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/2WKRJFXYCISHRU6R4ACJ5LUX76WSSEHN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Added tas2783 support in some projects.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/soc/amd/acp/amd-acp70-acpi-match.c      | 64 ++++++++++++++++
 .../intel/common/soc-acpi-intel-ptl-match.c   | 74 +++++++++++++++++++
 2 files changed, 138 insertions(+)

diff --git a/sound/soc/amd/acp/amd-acp70-acpi-match.c b/sound/soc/amd/acp/amd-acp70-acpi-match.c
index 18f2918d4ada..a04075730f4f 100644
--- a/sound/soc/amd/acp/amd-acp70-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c
@@ -45,6 +45,21 @@ static const struct snd_soc_acpi_endpoint spk_3_endpoint = {
 	.group_id = 1
 };
 
+static const struct snd_soc_acpi_endpoint tas2783_endpoints[] = {
+	{ /*Playback Endpoint*/
+		.num = 0,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+	{ /*Mic Capture Endpoint*/
+		.num = 1,
+		.aggregated = 0,
+		.group_position = 0,
+		.group_id = 0,
+	},
+};
+
 static const struct snd_soc_acpi_endpoint jack_amp_g1_dmic_endpoints[] = {
 	/* Jack Endpoint */
 	{
@@ -91,6 +106,15 @@ static const struct snd_soc_acpi_endpoint jack_dmic_endpoints[] = {
 	},
 };
 
+static const struct snd_soc_acpi_adr_device tas2783_0_adr[] = {
+	{
+		.adr = 0x0000300102278301ull,
+		.num_endpoints = ARRAY_SIZE(tas2783_endpoints),
+		.endpoints = tas2783_endpoints,
+		.name_prefix = "tas2783"
+	}
+};
+
 static const struct snd_soc_acpi_adr_device rt712_vb_1_group1_adr[] = {
 	{
 		.adr = 0x000130025D071201ull,
@@ -406,6 +430,15 @@ static const struct snd_soc_acpi_link_adr acp70_cs35l63x4_l0u0246[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr tas2783_l0[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(tas2783_0_adr),
+		.adr_d = tas2783_0_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr acp70_cs42l43_l0u1[] = {
 	{
 		.mask = BIT(0),
@@ -553,6 +586,32 @@ static const struct snd_soc_acpi_link_adr acp70_rt722_l0_rt1320_l1[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_adr_device tas2783_2_adr[] = {
+	{
+		/* left */
+		.adr = 0x0000390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-1"
+	},
+	{
+		/* right */
+		.adr = 0x00003c0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2"
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
@@ -659,6 +718,11 @@ static const struct snd_soc_acpi_link_adr acp70_rt721_only[] = {
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
diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index f7694b2a2b02..6b27b09d9f98 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -301,6 +301,68 @@ static const struct snd_soc_acpi_adr_device rt1320_3_group2_adr[] = {
 	}
 };
 
+/* For 0x8EB4103C. */
+static const struct snd_soc_acpi_adr_device tas2783_0_adr[] = {
+	{
+		.adr = 0x00013A0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1"
+	},
+	{
+		.adr = 0x00013D0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2"
+	},
+	{
+		.adr = 0x0002390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-3"
+	},
+	{
+		.adr = 0x00023C0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-4"
+	}
+};
+
+/* For 0x8EA4103C, 0x8EA5103C, 0x8EA6103C, 0x8EA8103C. */
+static const struct snd_soc_acpi_adr_device tas2783_1_adr[] = {
+	{
+		.adr = 0x00023C0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1"
+	},
+	{
+		.adr = 0x0002390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr tas2783_link0[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(tas2783_0_adr),
+		.adr_d = tas2783_0_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr tas2783_link1[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(tas2783_1_adr),
+		.adr_d = tas2783_1_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr ptl_cs42l43_agg_l3_cs35l56_l2[] = {
 	{
 		.mask = BIT(3),
@@ -464,6 +526,18 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-ptl-rt722.tplg", /* Reuse the existing tplg file */
 	},
+	{
+		.link_mask = BIT(1) | BIT(2),
+		.links = tas2783_link0,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-tas2783-2ch.tplg",
+	},
+	{
+		.link_mask = BIT(2),
+		.links = tas2783_link1,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-tas2783-2ch.tplg",
+	},
 	{
 		.link_mask = BIT(1) | BIT(2) | BIT(3),
 		.links = ptl_sdw_rt713_vb_l2_rt1320_l13,
-- 
2.25.1

