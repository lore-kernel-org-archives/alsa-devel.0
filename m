Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7967CC624CF
	for <alsa-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:24:39 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B821601DE;
	Tue,  1 Sep 2026 12:24:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B821601DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788258276;
	bh=8qdCKpSYEqyK3CR4mlD1IKDbMPyFGCq9QQGWvL2vR1s=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GCOJbsjsAr5ypOYDRwXrUnKdm+VVX/qoeuXyoJOB7JlMuB94OkCTGUsj5erYTSwFh
	 0NJhdIXsmEDHsb+f82jOcOQcoOPWNsGzq69wysuuNIS/Hffn3EJwYhXxWFxexqKO6T
	 5rSdS6CNNu+/wnKwUWif3vL0XK3ru45cgHCS1oCY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 415B5F805F5; Tue,  1 Sep 2026 12:24:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC55CF805FA;
	Tue,  1 Sep 2026 12:23:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 86D55F804CC; Tue,  1 Sep 2026 12:23:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.56
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788258231;
	b=gGZH9CLX+dRErLMADvWNTH+TlNfOmPjsLuJG78wRA8D9igst60KtiJ2UkGVntlcbDuBF
	 BwXHWXdKfcqHwvRA7UI7nYcD/IB7wu9enSmP84ERtEV/GMoW9X1yn3AYkJwuf0L8Zfh4f
	 uhMlrcz8R0yBXTItD81CC/i2Mjzkkh9MFrtEymVv5buVPRfbOW3M9G3y01kVTPEbdp0Dk
	 j2VTvG6aDZz3G6GrTHWUJ+aC3/9YLaCgL4dbZrIEP1ejKAwS5HaewINyXcOj5c/Yam9Nt
	 jHzUWqURlnhHqDZCF4fXQ6+MpDRLmHoOwLUed/sUjU3VhIpu2Vl2l2LoC89shtIV/2A==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788258231;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8qdCKpSYEqyK3CR4mlD1IKDbMPyFGCq9QQGWvL2vR1s=;
	b=rYbMTq26WEPQJUvMRhk7kCRF/rOhmNtoyoesJeAOK/xfJdx6+zj93PRc2bLtdhH4Ry4Q
	 +J2YRF4Nfk0PFgSBS6KTkWDWJQpUVCEbJB6c08BXjN1AKchuUJyDDERKQaiZwn+E5MX9i
	 2quIsrapl1R/5u6XYcd6ryGY9i3/eSFYi6PcDejRLRcYrAcQaKvI1DjxrrG22xpi19Sgk
	 PE4oepHc5xXmrDw9qq0bD7p2q79GfU5G9m2WpzMqUausMjroHBVIT3lehf6mxhNV0EdHC
	 VFyr1ttqe0YBE7TVDRdwOGYyvbyPpUmpgtLu+jBoZ8Dhu9JBd7jj4BIC4GMCtp/m8pw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hkAs5N7j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.56
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013056.outbound.protection.outlook.com
 [40.107.201.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8C0A5F80246
	for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2026 12:23:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C0A5F80246
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=hkAs5N7j
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqUss/bX1ZSclo3x5P+rwX5lGKGSHmGE2KkJO+bJ/MD0xlY4I5TCXw/ihVXS3Upoor0YqcxcSs0243S5ZxzLRAR+dPlqZxdpGcpP6f1JzJSYNI/6E2XvjeppAaT09XS6zurR6RHOFYe30Hnjmcrf5o8OO+fAiFU9um+OVipCUCaMbxESD5qC9mOgpR6ZPC3UNmSii9KDcl5IlAXCLuSqsNzDJfsTus892tTHTFbvqwzgiKWur4crR336jTOeJSbcfN8h1NGPuLDaxbxRGROHJ6UaqILpgB4rNfXerVtjw/vqhy/pxyXL8R4dMmembD99aCw8pgO+2s9lyVawTP5AVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wAvgHvAsFSGMmCOH4Y6I42T3RK48q+2JbibJ/wTpOk=;
 b=LKHV6mjAqu1/pdfUFSJS/qnla8gAzVGRDv7sDlKsKttZpyvBwr2Wa+lDXRwn0NrJgFbBJ6aO6wUuit+Yq4EaPZUODtz4WPW1ontKXSPrTaPpRglU1lAwLscGHRoXjzeg8UuRVbwqmfpZpheJtcadrhM30Q4Y+WYbW8ZxyerqGodj71KcB6Msr3uHZltTsUGeEO8TP5EIKfAr+dN3Aif6lxg2jIvfTsht6GC3PITmXW3ZNgHjTAbOGsvxrnhXit/omYJi9N9YvOZRbPBWpbIYTvdMh45WXMQv/RaD9uBNQRF6qeKpDnV4NCxIbRkC+5KVtXLFCMb3zlmUd4wEVmde0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wAvgHvAsFSGMmCOH4Y6I42T3RK48q+2JbibJ/wTpOk=;
 b=hkAs5N7jTskER8I6vCO6DGJCCeZVEEIJWkbxjhC7vdtE9Wve28LAkWBRAs/MCfAzk2QNC2wkZ9NtFrJgjZoyjWt5be9UNtTR+tOLhAomh8R+pdjB8wrufEbn0s7N2KjDEkPa5pPNNKX1XYqQjxmf7BhnRTkUy1qhRh0C2+wKdCM=
Received: from SA0PR12CA0030.namprd12.prod.outlook.com (2603:10b6:806:6f::35)
 by DS2PR12MB108293.namprd12.prod.outlook.com (2603:10b6:8:404::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 10:23:44 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::3b) by SA0PR12CA0030.outlook.office365.com
 (2603:10b6:806:6f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 10:23:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 10:23:43 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 05:23:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 05:23:42 -0500
Received: from amd-B550M-DS3H.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 05:23:39 -0500
From: Syed Saba Kareem <syed.sabakareem@amd.com>
To: Mark Brown <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Sunil-kumar Dommati
	<Sunil-kumar.Dommati@amd.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	<eraleexxx@gmail.com>, Venkata Prasad Potturu
	<venkataprasad.potturu@amd.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Zhang Heng
	<zhangheng@kylinos.cn>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Tommaso Soncin <soncintommaso@gmail.com>, Gustavo Salvini
	<guspatagonico@gmail.com>, "open list:AMD ASoC DRIVERS"
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: Add DMI entry for HP 255R G10 laptop
Date: Tue, 1 Sep 2026 15:53:26 +0530
Message-ID: <20260901102338.26403-1-syed.sabakareem@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|DS2PR12MB108293:EE_
X-MS-Office365-Filtering-Correlation-Id: 48070c1a-42b0-46b8-3c46-08df081319ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|7416014|376014|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	opM7CyA8zwzAQdEV09548PQGb9WaKEpw9kmK4QHpu0N2wSlIysOLtk3pYY9Pw+NlICNbueQJGtwaDp5aSmFYUYZhwitzECNpUFisMVFMhjThzO27BEZ413eTGmUtRETclp4Coj3PWZhefeJy98hr8GfVs8jDpqAAA+GkvwVAAEnJB5HvLr1xuxsn37uEFQks5hys/KyMwhphl3dYhieb9RX73skTpRvev79jERhHyzUttR27mDayF6bNfpYZkXwxfOe0RoE7Bu+q9V/4lFA1e0PKDLfpSzVfWsdU1zjqnp6kMSLuAk8y0aDOJNf9rkIH9R2c/rFL6ic3Y7E1YmaE18bexY7f/Z68vuMMU4kHOgEx/crfwXCseptwo2ouAR9cIlvZFNxETO9wiemcJeri5Kt/ssENi6VLj9B+aODD/wE7N1yEFkdfiJ3JxATXRSnjs4QRuKBGzqQD4TYZUbil7TupFaMAfxO5+wyFUrJxNVjGfFsrhKa6r4TV0NmfbBSS5h7QDItWM5uaf92EiaVl33oUxfczz/v8svaV84i1q9Iu1B98A59x1Bm6Pd2XjcE8kqc6Ms+JdcB1TXncpaDZRvwzcvLHPmiDnj+nmYY3xtTo22IoQYtTt69pzCEypRGRG4eeBgrsuc2irJQrJnFybqB7EtZsHHre4oNa0W6eJdZ1Fxf1fAn7/jjIvq4hFM8nlGIe1BOHIUkP0k3/S3ih8Q==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(7416014)(376014)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	HZyujoVh8eL18W5jG35rFF6mzN2XdI4G/Y9sMCZr/Xd+adQJ4zer1C1Ho/CY/YMYXbxCUyxhM2h3EVuPH+JWwRv4tT5FkYbrNlrQcvO67RxHjSkKwI+6uIXFmqYGym5yHDGvfF+0JkGfU4Z7gZskvgUIOU/E/DNhqwZemUOozYufWJnv9LBsKaGHJW2lY9X32A2SGMzJlCM9dwo3TcpvVK6YDHlTEBH2WoX3lfRNC/X+tPcQJf9y3aFQFA9nDP0ao8hfP7af3ZmTpuHmfDxfHmrMOArm4bKSlr3Y7/2PfBG7+x7dcVgWCbgSjl8pM39nYI1o5n5EuIXZ2cacBF6PZRMxN3yyNk8/3PikTeDpH+UvUI9K+2OUTWXFMz9nK0gpiyFBFIDylpdu5erNMPsAzV2HO+khRmLti1VzbUgFg3L4PWs9vnz5Tse4i7CIKO8Q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 10:23:43.7422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 48070c1a-42b0-46b8-3c46-08df081319ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB108293
Message-ID-Hash: BVEKNN4BIAHCBAUUFJIGWVPXB2CNTQ27
X-Message-ID-Hash: BVEKNN4BIAHCBAUUFJIGWVPXB2CNTQ27
X-MailFrom: Syed.SabaKareem@amd.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BVEKNN4BIAHCBAUUFJIGWVPXB2CNTQ27/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Syed Saba Kareem <Syed.SabaKareem@amd.com>

The HP 255R G10 laptop has an internal DMIC connected
to the AMD ACP6x audio coprocessor.
Add a DMI quirk entry so the internal microphone is
properly detected on this model.

Reported-by: eraleexxx@gmail.com
Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 3f852393fc99..e4456249958a 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -878,6 +878,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "TM2423"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP 255R 15.6 inch G10 Notebook PC"),
+		}
+	},
 	{}
 };
 
-- 
2.43.0

