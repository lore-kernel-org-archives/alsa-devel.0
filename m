Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047F606A326
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Jy4mLDkj;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=VfMcVBRl;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=DMEEPZxo
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D8C366020F;
	Mon,  9 Nov 2026 16:00:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D8C366020F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794236416;
	bh=u9mbrONinww1BncTJphzJLiy/SoTCQSss3LxUYbGmKc=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Jy4mLDkjsk24MJH7ZFT48CWa6KwHZTi/m2IJslqPyE1x6mu8AsMOe8A4lDYamL6He
	 3+KkeZ1q/DfyIBzvzNGsaqfamCQluWziEagFGrbDbwxwIGdd0Wz8y7Qa4BkfjN/BBQ
	 kdyrXifCO1BCt3Cw0b9mLZQifvSMKlcSms/whcwM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7C337F8060B; Mon,  9 Nov 2026 15:59:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C64EFF8061E;
	Mon,  9 Nov 2026 15:59:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E1534F804CF; Tue,  3 Nov 2026 14:40:12 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1793713203;
	b=CnChlwthNRh4xtsSQjKPnDM6MlcwOyNJZNzbNcoM9XGu1Th8haAcTYJ/Ey7mdZ2oLP+H
	 mWtcSxYnlvAGT4L3pEYS3h60AxF4ZXC+wKnTfM4YLZOtaEi8qHZ0JjsYWvIqlgphHZ0We
	 O4Sj80vVZgVQii2O2UQjtrOqJNS8lUiub5HkN3NdzKNwOIeuFtnDh83Z6XQ8t4qLstJpC
	 iBpOKTdFVJB0zbyg6L5vWalu/Nix1VAINhxGQZc8QHYex0QGJUGJvEotwr/n1tB8FCaTe
	 gFTDUYYXXmEhvN8pPAAfCY4Z1jcWtGilPb3Wpp1J8czf/Gs4PWi37Izpj5riK1jA5Gg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1793713203;
	h=DKIM-Signature:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=u9mbrONinww1BncTJphzJLiy/SoTCQSss3LxUYbGmKc=;
	b=ox1uwoBdwpAPPio89ayrWdHFKfMVNcSkXSA8TU7XMSWPHqcrUow6TPq1KjbH/fuXXERD
	 SX0ir34JTTQRqHX3ppZJcIHLwbr/QVXtHafvXHK3C/d6Pm+AfVMcD84oZ2rduMn14Jl1p
	 9FTyywlIcVfH2uce830g9yqYyf+TfJmtccRV1MdguifG1s3KmAs/2axgd5V4aumrJW7IZ
	 1mGwK3MP2GryDvS+liXF93CyuDoBl8HIUlLdYBQMDjynPuOyOzFE6ruF5TJFprcef7i7b
	 L7nUQYgHWaDPXECgud7ZZchxzmNW7ddwfjwY3WvT36XpW+nov43Szj8ihGDapjRnbkg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=VfMcVBRl;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=DMEEPZxo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DCF7DF8021D
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2026 14:40:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DCF7DF8021D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=VfMcVBRl;
	dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=DMEEPZxo
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3Dc3Hh3278813;
	Tue, 3 Nov 2026 07:39:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=EzWOUl7WyciTo
	fv0uXArwK+7/3TEbBnLD/hz/Gk+iuI=; b=VfMcVBRlKeGBb8M61VbmPVT6+h6sw
	UBaghTI6zlTFETT/Xj1qW44WpdqNtcCssBOfsJqB4y5iICbh3QW5vsA3aBbiphh6
	lci2WX0I2Hg+1yIk0DBYSmK/x1RO62Ho9GVgJCEuhzJ7FJzFbgBegShDGgdAuWHC
	GsyO78VJQ8cG74umyg95DGcafm7DLX45qEFCt+veKYyyoyiaJThRN/DG4CtDM3nP
	/1PIw/gXiszbd14Uzq7E1X1jfrsm5L8yijiq5M3h2i6tVkMzIujj3qnDGw0qHtCc
	SqkbPwsYFkrsFbq1kWpZJAQZ/OQP+b9fC2sVYySaUNTocIG0Mm20Aea7Q==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012018.outbound.protection.outlook.com [40.107.209.18])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hqcrvs7c6-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 07:39:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eO1qs3xEk0+iyno0o/8eouh/oJ9YcnDiRbZhwS5GztqGp0fT1ZyadbE0feHby8PU7kMIHvbOeN5FJdNnNqsCWzcj8I8ZIvzfptfpY8N3VgRZCeGFG4+fhNuIcAgZj6j61/9PCkAJTdXUZkQt0u8UEy+JZms1nD9dH9+4ftWRFHAFmPvCip5eOzvEYahhBoLfxCfd6u8icfI5twd9vWb5GFNbJvekbQB+wBCXIIr4PnywXZJPXXFGX/IoG8FmxANRisuWvJLxgh9fATnfW0l+6cSnHlRIaJXiRk9/Kz062HrP5UVvJAH13L4SNrcQxEUHEcmtjlSryuOsNnzuWq+hgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzWOUl7WyciTofv0uXArwK+7/3TEbBnLD/hz/Gk+iuI=;
 b=YYdbQjbBYR4z1XCLvJEJcZGaLzHUhCSYXt6hgMHlddL5xTSROKJypR0ppm+lThEGcDj+vPSfaw9V3PmeiZEJcvy297+CfEgzp/R9n16W1Nd9OLQS7EXpf1YFBw2UUELGdUyGJ3SJmW6xWm0TQoQN2rCrtrTPs+WcHIMUkqcyIG9EpM3OhTpOz3XObO3pQ7dIZpw5X4pYkfiupX3mEMT4SkcJ/IhfXYUaZ+kLJHpt2j0/p7Q6a8RcCNv0bAYC6a/N0K6OOQnLqA5gGqHXHAsNXTVw+AZ3758G5fF6FPioULU8HbKzed6uRj57zwsaFMmBImWCINj1KthMYHrCTydXsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzWOUl7WyciTofv0uXArwK+7/3TEbBnLD/hz/Gk+iuI=;
 b=DMEEPZxobIc69OrdjMGZmr3ibX0fi3rm1dj+nBC7CxkAAH0NMD9PZvlyfvXDmnjHfxzizx7L297y9WzG9HF1k0LKNp30Zn6Zt0RhYSaJgoqgBzTS/VaF5noxextd+UU4o7FGh+atZRJRHR7ZBzThpMrs4jJGiAhvLODzdRJ997E=
Received: from CH2PR18CA0002.namprd18.prod.outlook.com (2603:10b6:610:4f::12)
 by SA3PR10MB6997.namprd10.prod.outlook.com (2603:10b6:806:31a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 13:39:50 +0000
Received: from MN1PEPF000793FF.namprd05.prod.outlook.com
 (2603:10b6:610:4f:cafe::65) by CH2PR18CA0002.outlook.office365.com
 (2603:10b6:610:4f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 13:39:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF000793FF.mail.protection.outlook.com (10.167.249.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 13:39:49 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:39:09 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 3 Nov
 2026 07:39:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 3 Nov 2026 07:39:09 -0600
Received: from LAPTOP-70RJ5B8Q ([10.250.165.249])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A3Dd2eZ062285;
	Tue, 3 Nov 2026 07:39:03 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>
CC: <tiwai@suse.de>, <andriy.shevchenko@linux.intel.com>,
        <13916275206@139.com>, <alsa-devel@alsa-project.org>,
        <shenghao-ding@ti.com>, <baojun.xu@ti.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>,
        <niranjan.hy@ti.com>, <pin-hao.huang@hp.com>,
        <Syed.SabaKareem@amd.com>
Subject: [PATCH v1] ASoC: tas2783-sdw: Add basic BPT support
Date: Tue, 3 Nov 2026 21:38:53 +0800
Message-ID: <20261103133853.1612-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.55.0.windows.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FF:EE_|SA3PR10MB6997:EE_
X-MS-Office365-Filtering-Correlation-Id: 63bfe518-0a07-49da-e219-08df39afee89
X-LD-Processed: e5b49634-450b-4709-8abb-1e2b19b982b7,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|18002099003|261102123227099003|56012099006|261028144727099003|261026140227099003|261022115727099003|261022105027099003|261009223027099003|261022075727099003|261026121527099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: 
 2jr8cLFIN3ZCxfbbdd8jHfBxM6AZlzq3IMIO9UP0PDXZs52uRkP6qWZHaWfgAAVDF+ZbQ9SX2bspbv0CwdIdVyKG2ROOk6txjt0VVAC+MrZiiOT3F2iAmq5nKc7GKTtRYI/5OQBw1VTQ7QiL0fzb/GnRX5ynRovp5yC9FoMA9FHCKAwc18/7k5MMWApKSC1KuBtMl/JVY/A6+hUn3Lzix8dNXnE00XfzdwqI7dth3G8bYtnDs9x6n9cay2dOlFfxlj2pU5lZ9qomHVOsVP/pyu/IF/iw6nJjeep6zpkLv5v6UqEJV8Ta16i8ojN+sZpwWJ4t0UmpgxVJjgPkxVuraOxU6z00OUwPjtdOZ8JSfY4QFWzFASsZsUkN3i/Zwsy4ditLm619YTzvpp/rKJMNeQNh3jZLWou2NdeLJOa3PuePpL1OHpvKtncbXuOHQ++nMx8wn0auCNwpYpJUJF7DgFiOAwr+/PqnHiYf/zIfGy1Da/AwoNW/L1t0zz0kZjBhPgzCzzHQJFTI3JbqsR1ACmhJWtSy+/yEWHQQe4hA2WOa+uZqLiuf0pFn6y2qoPOzdftEHza6LO2exkK8zofcyYtjrGmD3Ot09nKh3YLRxLnyxFNmt7ornuQKFGLWStpb6Am1D3YVj/Pi4RAypfXiQkuvOgUAWfWVSs7A1bTgFuvyEz40bplvln6QVDYD7tOLg1il2Wk/r9Ss0RDaJpI2ig==
X-Forefront-Antispam-Report: 
 CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(261102123227099003)(56012099006)(261028144727099003)(261026140227099003)(261022115727099003)(261022105027099003)(261009223027099003)(261022075727099003)(261026121527099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 ep/+of5IjgH7WxwrfI8P0ZaZ/kI56WOnJY3ynpWUcLx1+2ts1YmQF5vf1QVzOjxos7vJiCAxuL5JzpN8u5bubz0Ur0QIM3W2jPngk0AcBe9wS3iFz3/GL02IeexYdCxfijN5Drxu+E9mpu4eIzIz48aZmda442WzqlYO7Tp34eMPtDltVUIca+6+0iHQaBBrjs8/AYKgzWEQtgLeXmNqdLSAm2k+NXVktbZ9ONzXH0vObMQDADiKZLuvETWuYjLy2FN2yR+vKl7nAYl5fbuFyhq5cyRD1Gm+tBGOOfBQteLfJu89Byl5kYdhw5I3vNAldKN+Xy37BJAHcOWdKnzOgD1U+z9HBw4wiFCYWI7uTl0mRSKiBUMojOquKjVbzD2p3QR57F4j2e8lApx9N1fSBwx8aIgZS7m79ozMH0OWe0ATcdOiHxgkXoZCabCzD9pJ
X-Exchange-RoutingPolicyChecked: 
	3gb759Ncc2iFA/okOQzGD4h5yk8LUIcwzp8qZT15l6poCLgnwwnN3qWHBtN1BhXW9w2sDHwaaxh1lkzvlFdK+VXJvaoxTMP8EMh/NreTIDYTWj+8lksjRWwS0foyk/vuvjzh9oJkazcOZUdaIhLbig2oRvYdxzU7f99oeiOTRFshpoO50eGRIW51vvkPWuhIQxwp878w4FKu6lxCLoBAfFeywi6lmAWLFktEIbHdzIPxcx+06hRVK/g2MZL+kDg8htzDIAu31pCB3eGo2LyNbeFoVtC0Pt9IvKhRmJqnv4/JtvmE5JhG9Gf5JNJGPYdZsWxYa5cQc+sKeGV+hoSNTA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 13:39:49.2809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 63bfe518-0a07-49da-e219-08df39afee89
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
 MN1PEPF000793FF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6997
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX0ZULn3SvgD5Y
 +pXB8dBPqsAhun+zfPhhJAVz0Gi8fp4igJmbErEGg1XurSDiFFa7q1Ziyq+FmovW0ygGKAraQSw
 u2F7X0R6PjZER1Y+OpdvLfjfgLX8CDNRdDxuAKakQNs/LFhdTHK3o2LY/XYmNVuLYM9vK46E5pz
 w3UDXCCWttEXvvS6uadvVrLGJOxNwvdUYBrnBxaLnOpiw1pHjLpaxYlakDGdbyMpj2FltVzs9tF
 EJRQUNfdX8pCCOkV6CszVN/qlhyypQyadJO1bwmEAO4IvdGWvslRrH8ySjdhZ6Mz05mbXuHdU/R
 YEo/uZtJt7fyJBPoWndiRAE9bVnI8DOikbma1qxF2spGd9S7RTrkc0GqZN3tv9nZAM6udCpCUnK
 QdcbtiR7QzdV9D1ZRvHXxD0tYr9EDSHE+3XFZPio1L/dhcqRg8MYVb03puIxIQlLDpp6zDB3zmI
 po47B+QTC3NCJ6bkfsw==
X-Authority-Analysis: v=2.4 cv=BflNQbt2 c=1 sm=1 tr=0 ts=6ae9e42b cx=c_pps
 a=Av3Y+FYNlx8hu8JbWhmVwg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=sozttTNsAAAA:8 a=f773zAT_vNfO4xF40LMA:9
X-Proofpoint-ORIG-GUID: 03EYFYvFH3d7hLvvLiCm5ebKxt3eI3ko
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA1NCBTYWx0ZWRfX96cJ/MwS5nw1
 nuZ1HvuOt3vQM41a9QxWcQn4XngKee3ASn6zgH7bqiQIICycADZY7kfHul8OMGOmjIhEBJVk+dI
 KULDEjZ65y6V1kl6kSVEdE+jD9gGg/4=
X-Proofpoint-GUID: 03EYFYvFH3d7hLvvLiCm5ebKxt3eI3ko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030054
X-MailFrom: baojun.xu@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: SXJWGBW7RQLZJGHLCP5UZZFRJNKU5VP6
X-Message-ID-Hash: SXJWGBW7RQLZJGHLCP5UZZFRJNKU5VP6
X-Mailman-Approved-At: Mon, 09 Nov 2026 14:59:24 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SXJWGBW7RQLZJGHLCP5UZZFRJNKU5VP6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add for BPT supported.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/soc/codecs/tas2783-sdw.c | 188 ++++++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/tas2783-sdw.c b/sound/soc/codecs/tas2783-sdw.c
index a57230e01f75..c1c74707b633 100644
--- a/sound/soc/codecs/tas2783-sdw.c
+++ b/sound/soc/codecs/tas2783-sdw.c
@@ -47,6 +47,26 @@
 #define TAS2783_CALI_GUID EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc, \
 				   0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92)
 
+#define TAS2783_MAX_FW_SECTIONS	256
+
+enum {
+	SDW_MSG_FLAG_READ = 0,
+	SDW_MSG_FLAG_WRITE,
+};
+
+struct sdw_bpt_section {
+	u32 addr;
+	u32 len;
+	u8 *buf;
+};
+
+struct sdw_bpt_msg {
+	struct sdw_bpt_section *sec;
+	int sections;
+	u8 dev_num;
+	u8 flags;
+};
+
 static const u32 tas2783_cali_reg[] = {
 	TAS2783_CAL_R0,
 	TAS2783_CAL_INVR0,
@@ -738,7 +758,103 @@ static s32 tas_fw_get_next_file(const u8 *data, struct tas_fw_file *file)
 	file->dest_addr = get_unaligned_le32(&data[16]);
 	file->fw_data = (u8 *)&data[20];
 
-	return file->length + sizeof(u32) * 5;
+	return file->length + FW_FL_HDR;
+}
+
+static int tas2783_fw_download_bpt(struct tas2783_prv *tas_dev,
+				   const struct firmware *fmw)
+{
+	struct sdw_slave *slave = tas_dev->sdw_peripheral;
+	struct sdw_bpt_section *sections = NULL;
+	struct sdw_bus *bus = slave->bus;
+	struct sdw_bpt_msg msg = {0};
+	struct tas_fw_file file;
+	struct tas_fw_hdr hdr;
+	size_t offset = FW_DL_OFFSET;
+	size_t img_sz = fmw->size;
+	const u8 *buf = fmw->data;
+	int num_sections = 0;
+	int i, ret;
+
+	if (img_sz < FW_DL_OFFSET)
+		return -EINVAL;
+
+	tas_fw_read_hdr(buf, &hdr);
+	if (hdr.size != img_sz)
+		return -EINVAL;
+
+	while (offset < (img_sz - FW_FL_HDR)) {
+		size_t adv = (size_t)tas_fw_get_next_file(&buf[offset], &file);
+
+		/*
+		 * Reject a section whose payload runs past the image. Compare
+		 * file.length (not adv) against the space left after this
+		 * section's header, so the check is immune to the size_t wrap
+		 * in tas_fw_get_next_file() on 32-bit kernels.
+		 */
+		if (file.length > img_sz - offset - FW_FL_HDR) {
+			dev_err(tas_dev->dev,
+				"Firmware section at offset %zu exceeded.\n",
+				offset);
+			return -EINVAL;
+		}
+		if (num_sections >= TAS2783_MAX_FW_SECTIONS) {
+			dev_err(tas_dev->dev,
+				"BPT fw has too many sections (max %d)\n",
+				TAS2783_MAX_FW_SECTIONS);
+			return -EINVAL;
+		}
+		offset += adv;
+		num_sections++;
+	}
+
+	if (num_sections == 0)
+		return -EINVAL;
+
+	sections = kcalloc(num_sections, sizeof(*sections), GFP_KERNEL);
+	if (!sections)
+		return -ENOMEM;
+
+	offset = FW_DL_OFFSET;
+	for (i = 0; i < num_sections && offset < (img_sz - FW_FL_HDR); i++) {
+		size_t adv = (size_t)tas_fw_get_next_file(&buf[offset], &file);
+
+		sections[i].addr = file.dest_addr;
+		sections[i].len = file.length;
+		sections[i].buf = file.fw_data;
+		offset += adv;
+
+		dev_dbg(tas_dev->dev, "BPT section %d: addr=0x%x len=%d",
+			i, file.dest_addr, file.length);
+	}
+
+	msg.sec = sections;
+	msg.sections = num_sections;
+	msg.dev_num = slave->dev_num;
+	msg.flags = SDW_MSG_FLAG_WRITE;
+
+	dev_dbg(tas_dev->dev, "BPT starting: %d sections, dev_num=%d",
+		num_sections, slave->dev_num);
+
+	ret = sdw_bpt_send_sync(bus, slave, &msg);
+
+	if (ret < 0)
+		dev_err(tas_dev->dev, "BPT firmware download failed: %d", ret);
+	else
+		dev_dbg(tas_dev->dev,
+			 "BPT firmware download complete: %d sections",
+			 num_sections);
+
+	kfree(sections);
+	return ret;
+}
+
+static bool tas2783_bpt_supported(struct tas2783_prv *tas_dev)
+{
+	struct sdw_slave *slave = tas_dev->sdw_peripheral;
+	struct sdw_bus *bus = slave->bus;
+
+	return bus && bus->ops && bus->ops->bpt_send_async;
 }
 
 static void tas2783_fw_ready(const struct firmware *fmw, void *context)
@@ -761,7 +877,7 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 	if (!fmw || !fmw->data) {
 		if (!tas_dev->fw_use_fallback) {
 			tas_dev->fw_use_fallback = true;
-			dev_info(tas_dev->dev,
+			dev_dbg(tas_dev->dev,
 				"Failed to read preferred fw binary: %s, attempting fallback binary load\n",
 				tas_dev->rca_binaryname);
 		} else {
@@ -774,6 +890,30 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		goto out;
 	}
 
+	/* Try BPT first if supported, fallback to legacy method */
+	dev_dbg(tas_dev->dev, "BPT check: async=%p wait=%p",
+		 tas_dev->sdw_peripheral->bus->ops->bpt_send_async,
+		 tas_dev->sdw_peripheral->bus->ops->bpt_wait);
+	if (tas2783_bpt_supported(tas_dev)) {
+		ret = tas2783_fw_download_bpt(tas_dev, fmw);
+
+		if (ret == 0) {
+			dev_dbg(tas_dev->dev, "Firmware downloaded via BPT");
+			cur_file = 1;
+			goto calibrate;
+		}
+		/*
+		 * -ESHUTDOWN means the manager is clock-stopping the bus for
+		 * system suspend and refused the transfer. The legacy fallback
+		 * would only thrash the dying bus with command timeouts, so
+		 * bail and let the next attach cycle (on resume) reissue it.
+		 */
+		if (ret == -ESHUTDOWN)
+			goto out;
+		dev_warn(tas_dev->dev,
+			 "BPT failed (%d), falling back to legacy method",
+			 ret);
+	}
 	img_sz = fmw->size;
 	buf = fmw->data;
 	offset += tas_fw_read_hdr(buf, hdr);
@@ -834,6 +974,7 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		cur_file++;
 	}
 	mutex_unlock(&tas_dev->pde_lock);
+calibrate:
 	regcache_drop_region(tas_dev->regmap, 0, UINT_MAX);
 
 	if (cur_file == 0) {
@@ -841,6 +982,7 @@ static void tas2783_fw_ready(const struct firmware *fmw, void *context)
 		ret = -EINVAL;
 	} else {
 		tas2783_update_calibdata(tas_dev);
+		regmap_write(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), 0x22);
 		ret = regmap_bulk_read(tas_dev->regmap, TAS2783_FW_VERSION,
 					&val, 4);
 		tas_dev->fw_version = (val[0] << 24) | (val[1] << 16) |
@@ -1216,25 +1358,32 @@ static s32 tas_fw_load(struct tas2783_prv *tas_dev, struct sdw_slave *slave)
 static s32 tas_io_init(struct device *dev, struct sdw_slave *slave)
 {
 	struct tas2783_prv *tas_dev = dev_get_drvdata(dev);
+	uint val;
 	s32 ret;
 
 	if (tas_dev->hw_init)
 		return 0;
 
-	tas_dev->fw_dl_success = false;
-
-	ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
+	regmap_read(tas_dev->regmap, TASDEV_REG_SDW(0, 0, 7), &val);
+	dev_dbg(dev, "Got B0P0R7 = %02X with %d.", val, ret);
 	if (ret) {
-		dev_err(dev, "sw reset failed, err=%d", ret);
+		dev_err(dev, "Get FW download status failed, err=%d", ret);
 		return ret;
 	}
-	usleep_range(2000, 2200);
-
-	tas_dev->fw_use_fallback = false;
-	ret = tas_fw_load(tas_dev, slave);
-	if (!ret && tas_dev->fw_use_fallback)
+	if (val != 0x22) {
+		tas_dev->fw_dl_success = false;
+		ret = regmap_write(tas_dev->regmap, TAS2783_SW_RESET, 0x1);
+		if (ret) {
+			dev_err(dev, "sw reset failed, err=%d", ret);
+			return ret;
+		}
+		usleep_range(2000, 2200);
+		regcache_cache_only(tas_dev->regmap, false);
+		tas_dev->fw_use_fallback = false;
 		ret = tas_fw_load(tas_dev, slave);
-
+		if (!ret && tas_dev->fw_use_fallback)
+			ret = tas_fw_load(tas_dev, slave);
+	}
 	if (!ret) {
 		if (tas_dev->sa_func_data)
 			ret = sdca_regmap_write_init(dev, tas_dev->regmap,
@@ -1382,6 +1531,21 @@ static s32 tas_sdw_probe(struct sdw_slave *peripheral,
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "slave property read failed");
+	/*
+	 * BPT firmware download uses DP0 and relies on the SoundWire stream
+	 * framework to prepare/deprepare DP0. Ensure DP0 properties exist for
+	 * the framework prepare/deprepare sequence.
+	 */
+	if (!peripheral->prop.dp0_prop) {
+		peripheral->prop.dp0_prop = devm_kzalloc(dev,
+			sizeof(*peripheral->prop.dp0_prop), GFP_KERNEL);
+		if (!peripheral->prop.dp0_prop)
+			return dev_err_probe(dev, -ENOMEM,
+					     "dp0_prop alloc failed");
+
+		peripheral->prop.dp0_prop->simple_ch_prep_sm = true;
+		peripheral->prop.dp0_prop->ch_prep_timeout = 25;
+	}
 
 	tas_dev = devm_kzalloc(dev, sizeof(*tas_dev), GFP_KERNEL);
 	if (!tas_dev)
-- 
2.25.1

