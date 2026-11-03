Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFA606A329
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=j24/7SGl;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=AKTH3tDU;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=Oklh7OJQ
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6C20960223;
	Tue,  3 Nov 2026 08:58:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6C20960223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1793692742;
	bh=eKUl9gJJ+GNa3JRsxt+Fz6JhObBOLFIZR3UtQqPOsrI=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=j24/7SGlFMROA0U4/NNbYVJUX78+EZ79zhHtjcmXYBDTJ//2mfRGXqTkSbYbX3KaB
	 SCn7v4pERlGDM6GDJwNdTnY4La8g+UhLFuZQbirxkOpe+XjbVwiW1UAePTbqGGcfPd
	 G7WqWAcR+rBHV3qIQkQ9lt6m8IyW3ltVPvQAybYY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2E72F80632; Tue,  3 Nov 2026 08:58:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F368CF8061A;
	Tue,  3 Nov 2026 08:58:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 71E61F804CF; Tue,  3 Nov 2026 04:45:09 +0100 (CET)
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
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793677505;
	b=EwU8SsqKgxqK/6svXlGJ/4wkNf7m4dZDBR+E5wtiI67TK+LLBNkSOJ9OG+ei35d2rfIX
	 QBOKSiErFZMwrI2yqfxHkDNZReYnYFOQse4skUcSShFpn1VblVPnkBBR89O4tqpFYIGVc
	 j6omJCfHLeHV8rIua8A164WzQjk3o6VCR+2UrumyALsEn5meB9wXGx28EQ32oSCvy4Udy
	 KncaK99YM0y2EdBeETus9NJ0rQl89gMEKRg0i8YuMZ/wdPaZS4b4m2HD3KDtQ6mRhGZy9
	 8khB3Dk1eAxTyfRd3avIP/JM5xmIBvRmVePPkIoZsJRr2gnvHBLWn40oxD4QrVuVEmw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793677505;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=eKUl9gJJ+GNa3JRsxt+Fz6JhObBOLFIZR3UtQqPOsrI=;
	b=pG1iYT2keixOd3juYjnkEKfGILeK3lA2uDiCr3PahT3U0XTew/I5bB1Xt3skJv3W3v3C
	 0CdZGjBVNteelhkmNuiS/OpbMFB9XOLMNgtUqKe4r0u8p3M6Cji3K0eqFhWRvuWjcn2jl
	 z4dT/0ZGVMN9yKrzRd2Z/5nRNkIGsXn7PmKdORcrqcvF1yPBz2RxwSlgaZSRrXmOkTcLA
	 +BnoARJntsluqHalSA8iaBK9+c7poeD7614Oz5FDxlYFX31FADt1eOYjI8l2/nk5JXQoE
	 QrpA9KAUTyhVuI3GzV388dLmSclRYsZKPwWKG1r6vFwUzBtw7GxyJk2xhBHB+Z2cjaQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=AKTH3tDU;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=Oklh7OJQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 73751F80100
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 04:45:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 73751F80100
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=AKTH3tDU;
	dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=Oklh7OJQ
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A31gtkw4162273;
	Mon, 2 Nov 2026 21:44:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=0ufZ57+0ceSef
	FrCAIFhIdwvRjBVmWCP+U232dGpg2Y=; b=AKTH3tDU8t+9aqt6hB7aLC6640g1q
	Rg18BFoiOQJmAGVthYioYX7JK/9QgyAnU6Y4j07A4DWiU/1gEdo6/QGfJN4A2r4p
	i2jOas6OCEWS3fKPsc2XnhegK0WK5Ycw8QHuTqjJz6AOV/JjaGbEDn9+Eb4JofUP
	jixZ/vjiWilD6UY+RBiizr2/eANDR/JO0gSbK2816gWdwrUZyi89F5zQxVjyfcaB
	UMLQGDDNgqKIaD6NSqdZoOL1Lv6INEHedUCUx5nSbLErbKtb2IVR0EaEOo2t/lZS
	Ba04bji7076YBPVpRM6QN2R0vJBCnX1whRIH9YWT37MmGJhtFvv+0DU5g==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hq0fht99s-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 21:44:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYcXQDxIN9PUtuZykOnqgHXKMV+icSHlHh/DuIWPx22cpj8Wi35gSntkWlJF80RSHdpY80xHhDI4363paoNfYinrrzybyUprJtCiRbjl3fsImJlJd3BtXNPxUecWq/op32O0Kxur9HQNwpfyBgcu8zpu6Ayo5L0lYYuBdii2caAr0R3NhO1nX3LwLKspZI8fLkBUGEf2mZ3NWe+wHvXUOprSLACcyPVooiEEEPooCWHbcRNfboX/e8XLp+Z2wooa95O3TkBE7Y53vllGscpZm4sKto0S0Ot+prEMymH/+VVBk6x4rtKiZ3tnKgWCaDllakDvtkkPUqZdvZasMbEQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ufZ57+0ceSefFrCAIFhIdwvRjBVmWCP+U232dGpg2Y=;
 b=rmU0oDy1tLeRNLZyvwuEj21TVqXbFZenKG/WzIwShk5vJmzHfbGDM3frBMDkolKxJN8Tz88qG52VEBRV52fz0EiptR5lGmCpdQT7tFzWbLsX+6rQ0LVrfbRHm41j3ciOQvfbinnHdebOZpkSbsyxZm1YjZzNrWb51XRCpFMTSJdr7RKoyQJHMGuzvszcSsuvJ+tgVfq4/ViMVGntnis5/hyYJdehD1S0AjzZek1nckt86JaoZs1ij5oTqOY4RfBmEqvVqv6SsWWy048xiB4Cg1kaqeKs5F7AWqYaKYXp+njAgZEv0cGOg6BjOJbxKJDmFfyqVgW44l6jbZL2aEqXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ufZ57+0ceSefFrCAIFhIdwvRjBVmWCP+U232dGpg2Y=;
 b=Oklh7OJQpCHGuZqLYp0yfeXiV/2OcchynIsWVqxcNQVotDA+xZQ0OFPlXur/wp3VoQhIuflLT71nf5npqToF78g7srWBYOeGzbbhEj9ClLDanDz35PyuIUjYVec4ENOA+osNSYCnzKVA47/ldX6swCjFftYJRCLmC4f7mPBBn1o=
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by CH4PR10MB8049.namprd10.prod.outlook.com (2603:10b6:610:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:44:51 +0000
Received: from BN7PEPF00000096.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::4) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 3
 Nov 2026 03:44:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN7PEPF00000096.mail.protection.outlook.com (10.167.245.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 03:44:49 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 2 Nov
 2026 21:44:26 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 2 Nov
 2026 21:44:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 2 Nov 2026 21:44:26 -0600
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A33iJ5J2405520;
	Mon, 2 Nov 2026 21:44:20 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v1] ASoC: amd: acp: Add support for more projects on ACP7.0
Date: Tue, 3 Nov 2026 11:44:15 +0800
Message-ID: <20261103034415.1495-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000096:EE_|CH4PR10MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 772c86fb-fc78-4aa2-e5f8-08df395ccfb5
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|261102123227099003|56012099006|261021121427099003|260925021311599003|260925022911599003|260925021911599003|261009223027099003|261026121527099003|261021123027099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
 8aCswc/3xpGqiT9ypgnwnTNMggVDvFu5wZuz0o2XiH8BS33DuNL0WqDgrsWSDF2izzlhBuKj7C7mKChOBzG13TXMeKk/JMhMO9nYeXYdvrcbrYLwIHhuN+swsvFwkXX8Ee1tFGZ/D5uDot2TXJ5T8i+1sx/0LqewCpYHr0ku80e7wU7LZl4JcZEFg83gCWrzzxaqUvJT32VJGvhw5IIIs0XVhV8G9A6w3M4XaoRPUNrNpUjIbKkg/NO+zP+QtvC1ElKIyOyXAEgT/PaXoXmrHXnqaGQEeShqE40f6+3omKoHSxuVDWNvkRmNCHS1hD1s9Tyt2gew7cGKSVPnTvG2wnIw5jlzw8/HvKqEaXhuXMQG5uT1mHqtCCHQGk0l/r+ZYL17JBQIp9Czv7Db4cXxKbinD7hzRWaYf0dr/6u6sOv0RHS2oUaL7RRCLrK4E571K2TTQ4acZ58UOIts2UUaWED3a9kiT+1LW4Speo2Jywfuro7bz9tr8rmaXEI7rAthwrPHHFY8Fx7MfOCXXUmHIyyJN96jvl6BnA//w8sJ4o7TekjqkU5erR69Lmc9pKgWAxLvcd9qeF8/5a1p7StP70s566c3u/2J05TWYZifjKJAOyPh3fc/+kcAxCrqV1eTfHEY198iGRkRzF0DTgAIIO0QzzRihBnHPafzVyN4QNoEQKnr2spooDKLCLHr1jeBddiB2OHX4VsIiANC6y6xnw==
X-Forefront-Antispam-Report: 
 CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(261102123227099003)(56012099006)(261021121427099003)(260925021311599003)(260925022911599003)(260925021911599003)(261009223027099003)(261026121527099003)(261021123027099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 jOWLmEoN4QA7bEMLsrZYQ9vr3LEtRpD5K9bFbM3bqc2mahPQG2fHLKKNMktmxzxgtlKcr0CL9FGY5bVlUr9V9yQbFZIB5YRqVfo6xHJOiHdtTr2w0dRWjsoUA6isb6TptQKMVVLbh2Xu+mnSut+2gwNivjHAh/yZC2UY+6NMAuIOrXXxq1QDd7tAy118q3tRq4Q011eHTaZdRG/6hyUDVONHElKspbzBsEQKFWZXslRgUZp7A3fOz35OCaYCyMzmdqWtPBACL653IseiPMFqoRANhZvCS2iNWH2imQBf9BqByFL04dxM81Jp3HbsdLItXaxFmzLr8L+WOxAPotd9qi1RlDRZx4/Ji99wkpp53AJJzr74LeNLQ2/O3WOcuNYhvGgbMVOClDAmSqoLGtJhvr7Ydp50mNF8DOIDbt1mgkXVJYSvr478bm1ctPuIS4fi
X-Exchange-RoutingPolicyChecked: 
	5G3iF59kgW3iiFnK1iemifgFD9zrHC3W+aqfD4wFTJWfSgQQBawf47/r236zX1/afUxpcOD/qBKqsL4EQArI6yV23EdFZdVhrY7ao3e9QwF4xiCg0pbkVlDTurpVTQ5l0XklKCgB5XHdQV/spts4Dph3SaZvdgWwVD90FjWAoV4surdyWAFxMiCg6GgDoNJa1A2WFX+lCkSsfSxll3Mx9Vw4Ks4XddNk3q5+dffmdUA0lfdaKGafNwQjkfyRFYnTtJ6Mx5AP/IrSgdhyiLuqYmlVhEN22K/BV8gUs9l+2lwsr4mD16gMfbq/XK/4ArhzOsfT/qCB/D91iKX5xwVk3Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:44:49.3285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 772c86fb-fc78-4aa2-e5f8-08df395ccfb5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 BN7PEPF00000096.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8049
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ae958b8 cx=c_pps
 a=gjcLB77VbSPYcqvaeYBpgA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=TcxrbrMTMqHS3ul9X8YA:9
X-Proofpoint-GUID: ldZVOZInc6P0XGQah01cK6HyoLtwstV5
X-Proofpoint-ORIG-GUID: ldZVOZInc6P0XGQah01cK6HyoLtwstV5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAxNCBTYWx0ZWRfX6jA/75Z/QnGn
 CN5cwlubLvSQ2ahchveR1MNMXZOyuXRbsmQNU2AI44OHzRm4JW+U2C34WPSIO4obpVJUY3GVhQs
 c6gxyePk5BPl/7iPLgjngPTFJEJ4Btc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAxNCBTYWx0ZWRfX1NJejXavYDhF
 pQNH8Cl8Gq4yqBSHMu5Aei9Oji6AdGyZ8OQ4bhFD4yB1AMcF+XPNuYB787jXs0vzN6pivDe7oxK
 MIVG0dWS8qEGZs0IAM7M0E2pTcSZshuKD1IvMS7wYiiniN+PnmaEnU7B4kC1gFITsVeH6MFKluO
 NaQwbkCdvogZ/JDxNh0lJ3dryLbgsGWaRwzE3JvRs/w88IaofM88tn3yA5byGG4JC7hDVcJe9n2
 O5eNGKE+fGw9R788BYOmS1Ir7pfw2p67BMr0eiEESVHjJPDBlil//K9+/6lOxAckGxQ4FQCLg69
 p0OlQccFq2USZCMthnKWO8PTeLE7z8WG/zZCAdexYJG6fvIbQxZacPAOjR7K5gZfcp/c31MGBoX
 2PLUU8bKqyftSuBP3CEI9GhZK55/79PP1DeT0Oe7u8I2L9/ZlAsWL3HMjMzfJqqtx9qL2w52eRp
 tuFMWjK2pktV6zyAghA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030014
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: OBA7E4ZOAY4G7RAU2EKO6BV4SQZWMT7W
X-Message-ID-Hash: OBA7E4ZOAY4G7RAU2EKO6BV4SQZWMT7W
X-Mailman-Approved-At: Tue, 03 Nov 2026 07:58:02 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OBA7E4ZOAY4G7RAU2EKO6BV4SQZWMT7W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add driver data and ACPI match table entries to support additional projects
using the TAS2783 codec on the ACP7.0 platform.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/soc/amd/acp-config.c               | 105 +++++++++++++
 sound/soc/amd/acp/amd-acp70-acpi-match.c | 192 ++++++++++++++++++++++-
 2 files changed, 296 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-config.c b/sound/soc/amd/acp-config.c
index 2fb9789cac0a..473d68ebde14 100644
--- a/sound/soc/amd/acp-config.c
+++ b/sound/soc/amd/acp-config.c
@@ -98,6 +98,111 @@ static const struct dmi_system_id acp70_acpi_flag_override_table[] = {
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
+		/* HP Kamo (Koki) */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "9012"),
+		},
+	},
+	{
+		/* HP Dominion 16 A */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "9028"),
+		},
+	},
+	{
+		/* HP Dominion A LW */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "9029"),
+		},
+	},
+	{
+		/* HP Kata-A */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "9056"),
+		},
+	},
+	{
+		/* ASUS HN7306 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUS"),
+			DMI_MATCH(DMI_BOARD_NAME, "1714"),
+		},
+	},
+	{
+		/* ASUS RC74XA */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUS"),
+			DMI_MATCH(DMI_BOARD_NAME, "1954"),
+		},
+	},
+	{
+		/* ASUS RC74RA */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUS"),
+			DMI_MATCH(DMI_BOARD_NAME, "1964"),
+		},
+	},
+	{
+		/* ASUS UX3408GA */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUS"),
+			DMI_MATCH(DMI_BOARD_NAME, "1AC4"),
+		},
+	},
+	{
+		/* ASUS B7406CKA */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUS"),
+			DMI_MATCH(DMI_BOARD_NAME, "1B94"),
+		},
+	},
+	{
+		/* ASUS CHG01LA */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUS"),
+			DMI_MATCH(DMI_BOARD_NAME, "1C64"),
+		},
+	},
+	{
+		/* ASUS UX3480ZA */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUS"),
+			DMI_MATCH(DMI_BOARD_NAME, "1E54"),
+		},
+	},
 	{
 		/* Dell 14S DS14265 */
 		.matches = {
diff --git a/sound/soc/amd/acp/amd-acp70-acpi-match.c b/sound/soc/amd/acp/amd-acp70-acpi-match.c
index c2f0479301eb..a6df59c212bc 100644
--- a/sound/soc/amd/acp/amd-acp70-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp70-acpi-match.c
@@ -582,7 +582,7 @@ static const struct snd_soc_acpi_link_adr acp70_rt722_l0_rt1320_l1[] = {
 	},
 	{}
 };
-
+/* HP: Sundae, Cashmere-A. */
 static const struct snd_soc_acpi_adr_device tas2783_2_adr[] = {
 	{
 		/* left */
@@ -614,6 +614,116 @@ static const struct snd_soc_acpi_adr_device tas2783_2_adr[] = {
 	},
 };
 
+/* HP: Dominion 16 A */
+static const struct snd_soc_acpi_adr_device tas2783_3_1_adr[] = {
+	{
+		/* left */
+		.adr = 0x00023C0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1",
+	},
+	{
+		/* right */
+		.adr = 0x00023D0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-2",
+	},
+};
+
+static const struct snd_soc_acpi_adr_device tas2783_3_2_adr[] = {
+	{
+		/* left */
+		.adr = 0x0003390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-3",
+	},
+	{
+		/* right */
+		.adr = 0x00033A0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-4",
+	},
+};
+
+/* HP: Dominion A LW. */
+static const struct snd_soc_acpi_adr_device tas2783_4_1_adr[] = {
+	{
+		/* left */
+		.adr = 0x00023C0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1",
+	},
+};
+
+static const struct snd_soc_acpi_adr_device tas2783_4_2_adr[] = {
+	{
+		/* right */
+		.adr = 0x0003390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2",
+	},
+};
+
+/* HP: Kamo (Koki). */
+static const struct snd_soc_acpi_adr_device tas2783_5_adr[] = {
+	{
+		/* left */
+		.adr = 0x00023C0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1",
+	},
+	{
+		/* right */
+		.adr = 0x0002390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2",
+	},
+};
+
+/* ASUS: CHG01LA, UX3408GA, UX3480ZA. */
+static const struct snd_soc_acpi_adr_device tas2783_6_adr[] = {
+	{
+		/* left */
+		.adr = 0x0000380102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1",
+	},
+	{
+		/* right */
+		.adr = 0x00003B0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2",
+	},
+};
+
+/* ASUS: B7406CKA. */
+static const struct snd_soc_acpi_adr_device tas2783_7_adr[] = {
+	{
+		/* left */
+		.adr = 0x00003B0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1",
+	},
+	{
+		/* right */
+		.adr = 0x00003C0102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2",
+	},
+};
+
 static const struct snd_soc_acpi_link_adr acp70_tas2783_2[] = {
 	{
 		.mask = BIT(0),
@@ -623,6 +733,61 @@ static const struct snd_soc_acpi_link_adr acp70_tas2783_2[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr acp70_tas2783_3[] = {
+	{
+		.mask =  BIT(2),
+		.num_adr = ARRAY_SIZE(tas2783_3_1_adr),
+		.adr_d = tas2783_3_1_adr,
+	},
+	{
+		.mask =  BIT(3),
+		.num_adr = ARRAY_SIZE(tas2783_3_2_adr),
+		.adr_d = tas2783_3_2_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp70_tas2783_4[] = {
+	{
+		.mask =  BIT(2),
+		.num_adr = ARRAY_SIZE(tas2783_4_1_adr),
+		.adr_d = tas2783_4_1_adr,
+	},
+	{
+		.mask =  BIT(3),
+		.num_adr = ARRAY_SIZE(tas2783_4_2_adr),
+		.adr_d = tas2783_4_2_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp70_tas2783_5[] = {
+	{
+		.mask =  BIT(2),
+		.num_adr = ARRAY_SIZE(tas2783_5_adr),
+		.adr_d = tas2783_5_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp70_tas2783_6[] = {
+	{
+		.mask =  BIT(0),
+		.num_adr = ARRAY_SIZE(tas2783_6_adr),
+		.adr_d = tas2783_6_adr,
+	},
+	{}
+};
+
+static const struct snd_soc_acpi_link_adr acp70_tas2783_7[] = {
+	{
+		.mask =  BIT(0),
+		.num_adr = ARRAY_SIZE(tas2783_7_adr),
+		.adr_d = tas2783_7_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_adr_device rt1320_0_single_adr[] = {
 	{
 		.adr = 0x000030025D132001ull,
@@ -804,6 +969,31 @@ struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[] = {
 		.links = acp70_tas2783_2,
 		.drv_name = "amd_sdw",
 	},
+	{
+		.link_mask = BIT(2) | BIT(3),
+		.links = acp70_tas2783_3,
+		.drv_name = "amd_sdw",
+	},
+	{
+		.link_mask = BIT(2) | BIT(3),
+		.links = acp70_tas2783_4,
+		.drv_name = "amd_sdw",
+	},
+	{
+		.link_mask = BIT(2),
+		.links = acp70_tas2783_5,
+		.drv_name = "amd_sdw",
+	},
+	{
+		.link_mask = BIT(0),
+		.links = acp70_tas2783_6,
+		.drv_name = "amd_sdw",
+	},
+	{
+		.link_mask = BIT(0),
+		.links = acp70_tas2783_7,
+		.drv_name = "amd_sdw",
+	},
 	{
 		.link_mask = BIT(0) | BIT(1),
 		.links = acp70_tas2783x2_l0u9c_rt712_vb_l1u0,
-- 
2.25.1

