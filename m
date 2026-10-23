Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CC1606A326
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=u+V+BRBh;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=em8Akcl2
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7949D601D1;
	Fri, 23 Oct 2026 08:57:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7949D601D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792738635;
	bh=tWWBxRxWqD7CEyA+zpsbr+VkvhQwkrX0YvXtl/ya4pI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=u+V+BRBhPFqpdiy6klDO6cXv8L5S8PmjDW7WB6ggkt536S5DwUESOZG4FzfeQGPeV
	 pfFEZga8AwBTp3BIN/ixHhParRex16HbD2ClfDPV9t8rmdQq+FkEGyuBYzb9jZWL2q
	 9JMtoEYnbRb8YllTcr9/c/ytzKd35OPm5f1wjCJo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12EEEF80753; Fri, 23 Oct 2026 08:54:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9B64F80735;
	Fri, 23 Oct 2026 08:54:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 80B23F8069C; Fri, 23 Oct 2026 08:54:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 61EB3F805C6;
	Fri, 23 Oct 2026 08:54:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61EB3F805C6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=em8Akcl2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bWZhF2G6nZqFWeW4M8KFvh3ntCqKPO/y0RTIe6AU3joz4HTdzVH88tDQX8PPUmMuTPMKbECBUqJOeV3pibhnY2sPx5RCaBFeyTEYKVg3zKHIeYxmJ1cnRddDHwiAszdxJO6xjgb4+2U75ObcIeEk9xz0xaGjDCidKjgMqfQlEcBz4rVa3Ke7vsZJK6oxYJNBIk4b07Am5138Hla5sGIem8vs7i3Ie5xipst1QBH9gWv50mKPtSbtBhw+gzkgeID4zST/AYC7hpA/tuBLL+OJK+3DW8HqPdERT6jqHb1ZJNcjnYxtujDSoXUgxabazBPc8xxJIfHkifNDAms/7w1OAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WC3+dgMuAPV0dVD+o9GkZOO0UoofpWeKaE+7sVTyIlk=;
 b=L4oYvpXs321t1+m3Lh6TYlVaPF4E2TXAGEUIcNZULGnnMCxyhk47hq5gMHFUydwubAo56F9lQE9ieWwKg/nXdqJVOTnxn5XCgbi1WwuNunaTsFXRzKjejYv2SuqADZPOZ/oORAdp7CN+Om37/HmXcjok2HFe1xe3LxwCEyTTF5TsAi0/I1+nGGpgxQeMa2Civ0IL5OxUA9smdbM5GmiD4CmeeiRJKcLqyT/iVO+iFfecsYnhGBNEqufaNXM/1fqvpi6OzXuE2PtVDJdNBObdje9Ym+jMUSNhP+k6mEOdHCcw+g5KRXGGEzOm9i5wGMc04zEHYe9e1P3FzfWS1L5GmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WC3+dgMuAPV0dVD+o9GkZOO0UoofpWeKaE+7sVTyIlk=;
 b=em8Akcl2CJf8inqUbBUD2aJBdsQOU9EUjzaR0tK65z82DGU6QeTBwhhhkgBi0fc7QvdktLl+B++fketv+bukZUWPWUaJP67zI3nMx+vOvfIKKKqSy9g9FNzHmc6gzLifQhRWFWUjDo/D7IBSU4sqKHl4+gKYoAOyNMA++l3C7T4=
Received: from MN0P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::20)
 by CH3PR12MB9024.namprd12.prod.outlook.com (2603:10b6:610:176::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.17; Fri, 23 Oct
 2026 06:54:27 +0000
Received: from MN7PEPF0000014A.namprd04.prod.outlook.com
 (2603:10b6:208:531:cafe::33) by MN0P222CA0012.outlook.office365.com
 (2603:10b6:208:531::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 06:54:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN7PEPF0000014A.mail.protection.outlook.com (10.167.254.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 06:54:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:54:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:54:26 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 01:54:22 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <pierre-louis.bossart@linux.dev>,
	<yung-chuan.liao@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH v3 13/13] ASoC: SOF: amd: register SoundWire alt_machines for
 ACP7.B
Date: Fri, 23 Oct 2026 12:20:49 +0530
Message-ID: <20261023065216.3473883-14-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
References: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014A:EE_|CH3PR12MB9024:EE_
X-MS-Office365-Filtering-Correlation-Id: 66807626-ea79-4bc8-9f95-08df30d27af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|7416014|82310400026|261009223027099003|261021121427099003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	U8OzuQLwj/Ru12TW4ad7rBBDZVhP+Cf/5WEA66HF4LAW3T/MF844pyKC1GL7pB3rU/N/8/AEZ8NFFBklvk8lPfO0RQ8s4LGINYGu2KhSrBVcPGiQeDPfyo0khzY8RfDBBadUJVDz2UiJNDgmB8DQVV8V+eSMHjW5Lz5pcFmg/hksCfxCFe5YxnhTd1ZDPWpTssdxxSM+v1KdDpAia6uYg6Lgu/qcWa3EbntvVAeueTHfjLSB3hTtPcBHCqdsXqPpc91/DcdJ9pvxp3Oq5JiuNswlqhxk0DMHbnELcnaT+Cle9I3m2iw3amXJ2k4yGcCITk8J6ZI4RBSiXzf5dEd1L6GvORDOUy6icXd13KA3gnT6K6qZT3/SH1mNx9JZoXTbTC5fITC0BSElRcr7A7GT+ILIxFKaZp/wkbzuQSPiYMLR7esLpDZd40KOERXUm/BX6XItrrYO8ewTa4qvnFQtOlVL5F1j/AXQ82Q9o/nWAWSbIHRRGi7axPLyoR1GR5/z8Hvcuy5pSDMcKKYLI+Bc+THbDKWTdmdyJFRHHg13a5NzyR0omUeYmcd0k8fqh44GQFMNA9haHRt+rzo6nCKlylcuDWEp9mDV0yBOSssSEiZjl8WWJO9AWEcgWDSQXPM3h8o71JjgRM/aPAKooybIbLNY9T0o/QsSauDb/7iicl7S+o5p0w06c5HG82kEved77CY6eq8l+fjpgUVECW8mDA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(7416014)(82310400026)(261009223027099003)(261021121427099003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	4OIKkYELkzp8yrxW+pppwXXVJH2HX2LaFCkwFCFqdAtgQeTPSmGD/Zce0YmwqfqdApU0dDbG9QrQDHit7ZC4M8u91ZmZiXpj/ZsQrTSJIg5UAd1r3XVRXuvymvsymJ5FFoBOAb8vLTMCVizCRLAoZ547i9CentJ0cEtX5llEweOjI1w8y35obn05m7IFfbUQd1PxVCoKlp1dx545pTyL/H0YlFA+w7+ufje3beFOr7ipcAoNZe3qYNsr3qbAPQDUqYUMxEFQMKD1x6ahQq3NRzNamKZS09o0QQEj4E7Qme1xIEnwuwIu8tlhvBdGYshmKyTmJkXXNSU2CdfVvDXq4NI/mIUH/o768g7IyIp+lxMH5NwZ9kzSJfpxFFliCiL7N1RAzXBRSPvGk9LmbSY8Sk+8A0AmRNTRmoiVG/JgWTCPeIscKIdcnw1tqw1kgaPK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:54:27.3905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 66807626-ea79-4bc8-9f95-08df30d27af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN7PEPF0000014A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9024
Message-ID-Hash: SXMGHWFRUI4ZZ4EFJU2PJQVISULX6QYZ
X-Message-ID-Hash: SXMGHWFRUI4ZZ4EFJU2PJQVISULX6QYZ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SXMGHWFRUI4ZZ4EFJU2PJQVISULX6QYZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Register snd_soc_acpi_amd_acp7b_sof_sdw_machines as alt_machines in
the ACP7.B SOF device descriptor so that the SOF core selects the
SoundWire machine driver when ADR devices are detected on ACP7.B
platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/pci-acp7x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/pci-acp7x.c b/sound/soc/sof/amd/pci-acp7x.c
index 2999dc6d72a63..6aa16d1a12b95 100644
--- a/sound/soc/sof/amd/pci-acp7x.c
+++ b/sound/soc/sof/amd/pci-acp7x.c
@@ -47,6 +47,7 @@ static const struct sof_amd_acp_desc acp7b_chip_info = {
 
 static const struct sof_dev_desc acp7b_desc = {
 	.machines		= snd_soc_acpi_amd_acp7b_sof_machines,
+	.alt_machines		= snd_soc_acpi_amd_acp7b_sof_sdw_machines,
 	.resindex_lpe_base	= 0,
 	.resindex_pcicfg_base	= -1,
 	.resindex_imr_base	= -1,
-- 
2.48.1

