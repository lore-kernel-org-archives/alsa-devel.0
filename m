Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03F27C43602
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:03:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 109E960238;
	Tue,  7 Jul 2026 08:03:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 109E960238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1783404228;
	bh=W6JDhkwq9EuYs2VIGD3OuieMTvpD/mbAByoD+jcGLzs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XnAjXl962ZH/a/5BDtj9eF9TZLGfdIC0Sgm0dM3/fCEpNMadOZ+/D/nfzB+n0kB8u
	 PLdb1CYlIYVc5b1jKuNu+a0IiPtZxLqc/yg1BQPGrusZ+GtSSNva7moDpRUbFcnbLA
	 sE3YVlFDE4fIYe/QDILwi0PXvTHWXXHMpylpJdng=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EE023F80678; Tue,  7 Jul 2026 08:02:41 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 63746F80689;
	Tue,  7 Jul 2026 08:02:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 43249F80622; Tue,  7 Jul 2026 08:02:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.71
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783404151;
	b=O3yKR4WLNxvon8LNBH+Ly9U27LMID/HOjm6A1QVi0zV3uGwnuXEvA9V4UySiB6aNvUoA
	 UImHOSI/q/AmD+Uv92cvc3snrd6iTRTgqfD3Z9Nh1EpwmaQhNqs7lWt+IweBD9bwKr5ic
	 3CUl6TVF6S+ZchjVNSH56XspuZ4v14i7gQ0pBV867/h1zzuQdwOS+n69rvhts8d4CR0y6
	 4sZPaybKktQH4Evxg9zy0sFjRLwBdpYN/4BvCi/t8N4VKNjvs5r/yFydAuPf+5iLA+aXV
	 rxvHvvIBeReAQeC5/6ZfvaIyjpZhy4HuwxKlA8E5NceKyiZkG4yttjENlbJyP4BD+TA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783404151;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=W6JDhkwq9EuYs2VIGD3OuieMTvpD/mbAByoD+jcGLzs=;
	b=d+HFgBNCrdNEyRHZOjC0qPQCgA43q0RL8VsIeXU44v2tov5ZpGh4OuCPMs1jwr0+Qasw
	 yDQZ166XxqhODgHzb4igTfdXjC1513R1yc4TBmpqlAz0YuLSc13t9ibzVPVk0h6B7JWok
	 zHrUvhfrQvmzzREP8IGm514Taplyv73Yfj22YYgc8ZH0zN1ikwG4OpHEQI9ue54kGNZHj
	 G2iE1TVu9WjBDsK+36mRAV72RoV13U+SVpVTF2yY0QFHOV94jqZHmzszeih07yLLCt4HO
	 YSczBGjN3y9XeyYyyTUkxejG2P7UKhnTJkeMl3ez9Ec1ai5RwO5m+lLGQOB08mfD64g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VL7ywG72;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.71
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A4B89F8061D
	for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2026 08:02:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A4B89F8061D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VL7ywG72
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qof0epHpUNiauHvxDtE1lel6tCnPuOp2RejHpqIWa9XwBkw89vtHiJg+iLo7oW+p8xFi92jsZ+J2c0TrYLEcg780hyG5W2IFYW2NoPitQnvmjG83TDS2CwgxyeSfDgSSMIGotZk3LTudr54dOcF+kB4RTop/6g50C2UWusOsPYgkzjsUtZKb19VcsLqegt83PH35SJ/SHqQzShv6SKCGHzmOgP1INn817Ej5doscrumVGXHuli/qzI/BLzVh0ny47XFMlraTqc+1WmymlkY3IZqikSTrdbSoW5zbCtnKyoVRUgL6ZO7fmW7gxM3DxYeX7CquisA5sATzT2PvYBINLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3oUsfBUYdEN5StXZ0uh/YXaBVtnXTBYipyDAYVMgGI=;
 b=pNzEld11hWZF4cW/oeQO4SsuBUc91P2IxyD1066mjEoN1wI3oO1fdhVbzgpB5aLTcxF98u1qBjDFNf5GI61Fh8+HmMai0Cf6W1zK1TVrzXFaajGuisjT/GITH851UPBLSMZvTt4pxEbbI5kiFxKNwp7y7/NjHxg7Rwk1zLjjoo+A6Pg46LaZNrBNDf7n/NDe+MYNBHl+T3EcgvoG2i2bq3Fu4e1GCTP1FDd3uuT61kLTwRLYe+Aep4YRw2WAjKTSDvYh8kY326ZnWIUfxxZZIuBJKE9COWjn8vJzOJytwhVS2brXkTgbohO2LQBv2WnHaZ8SMoeYv8T0p+7IPqWKxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3oUsfBUYdEN5StXZ0uh/YXaBVtnXTBYipyDAYVMgGI=;
 b=VL7ywG723peHeeRF+nWyYPWmiW1et5IzeX1NwQ6l2N/eIbXQ/JLeJuTzFcD6icAXQBYBEbvBbYdqDL0hmp74E9lp0cceej5D3R+nn+rwRg4vBQr1SNxVzOOn+kdHho1XuQzkN8JTRPUJKEiWEY+Q5W2THrZXRUVZezSENcS4JsI=
Received: from BL1PR13CA0167.namprd13.prod.outlook.com (2603:10b6:208:2bd::22)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 06:02:21 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::36) by BL1PR13CA0167.outlook.office365.com
 (2603:10b6:208:2bd::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 06:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 06:02:21 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 01:02:18 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 7 Jul 2026 01:02:15 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <mario.limonciello@amd.com>,
	<syed.sabakareem@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 3/3] ASoC: amd: ps: replace bitwise OR with logical OR in IRQ
 return check
Date: Tue, 7 Jul 2026 11:29:38 +0530
Message-ID: <20260707060130.2514138-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260707060130.2514138-1-Vijendar.Mukunda@amd.com>
References: <20260707060130.2514138-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b297c5-8cf6-45a6-6776-08dedbed4f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Oj7fAesZtuZYVSZGM9tA7I7ueRnvm2CTn+OUckQuSTptk/0HYeKzhXsQQbbLRbsQt/PWER9KHivAMozrQxTT5NOA1OW1PqQzZewHuQyR/4oip1zcMdLrVGQQQ77WPv/1eQ183I1XBF9XkOYZahVZ3IpjlCKPeAcckTK6ezxkj6cZ+lqcrBz77ATg15twM3bQczi+0bW5dFS/JIaHfzZa7rDLa/Dad9CMukWUTNIbM1wFfAK+knLtMYzb77rFLLMJ27WM6EheIPCBlzOuAotvUoSOBzi4Fjj3henOcl6fdJB5Ysc+wks4hb9uvxrqvydJHPiSDDLKt8s7439yYIRiJWD0p8PHV3GhN8y2N6RiRb/Uce466pemXeaFvxBeFWUnGSBCdgHL6PD7mamsbsOiXnOYI0sDBh0Z4ZGxpPqoSNfJPqCbab2Q5ue19qXV68I1qvHN/kO2uwTqd3/2QqgdLBzmWjc8xSSgnJDrbKrDIweE7Zv0IE2NOiwpxhqF0cKpRK5TjiB9d91o0dSRtjPGkK22eQCdYJnJe4cuG6F6u8aOpALW2yANRTSUY9G0PLC/Ohuf00AVQpNziG4dQYuejgrSwNkwua/q14pchiP1BH5x4w/910aaiXXOVETA4HqpoBAoVvux1rmMdv4E+yCL5gp+3IVQiZ/DpV4kVMPRX4a1Ux6wvTB3hM989NaL12VIbZGndfoyEwVg+D9G80uCMg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ZybAqZVPMjme8sWG9wB+lqyUOOZKfbTK56hbzu06mobjz6q/9KnMMUJIOz0pnb288XPy0/NVBkQk0uhMkt4kjK9ijwJkTvV16EDJohb+RyCoCxOAWRj+U4fLbZrLP8ITSkwmGpfXjKb9QyqHWSQakwqw6Ww0r8gYOvIoCG2PJl40OTcHv4lefI0pwtLyDIEmJ3hQOOZpoT+TDte6mxyJuYpEwfTAqQXhq8iX7r4EhsT5Rwmf+kFaXFNg8kZ6Z8tuVU1b0YDUiBD7KrUgeIauiQX5AB2hU3au2Lsxvybl1OKkklZPYafzQpbY5mIFOwD+kkxb4Uv3yMvsLDpkg2tIPHh5+KhAOnBguNW9oE1VXr6RIgLLbbLshNPaAHuUA7bkBPRShsW9KLlnnHuDkEaAPe8cXUt0EI+bS+H8IdQlY+G2jUmS64hikm0u9czgxylA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 06:02:21.6750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 78b297c5-8cf6-45a6-6776-08dedbed4f4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160
Message-ID-Hash: O62O3NHYPHJWUBDU5R6Z7TQBQTT67P5A
X-Message-ID-Hash: O62O3NHYPHJWUBDU5R6Z7TQBQTT67P5A
X-MailFrom: Vijendar.Mukunda@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O62O3NHYPHJWUBDU5R6Z7TQBQTT67P5A/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The condition 'irq_flag | wake_irq_flag' uses bitwise OR to combine two
integer flags that are used as booleans. Replace with logical OR '||' to
correctly express the intended boolean check.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 1162d13d8505..729f9aaba69e 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -248,7 +248,7 @@ static irqreturn_t acp63_irq_handler(int irq, void *dev_id)
 	if (sdw_dma_irq_flag)
 		return IRQ_WAKE_THREAD;
 
-	if (irq_flag | wake_irq_flag)
+	if (irq_flag || wake_irq_flag)
 		return IRQ_HANDLED;
 	else
 		return IRQ_NONE;
-- 
2.48.1

