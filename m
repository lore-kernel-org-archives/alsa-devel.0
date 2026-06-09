Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83643CD8CA4
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:33:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E32B4601DF;
	Tue,  9 Jun 2026 16:33:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E32B4601DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781015620;
	bh=RFUtQ6c5s1AtNz+Cz4q5wq68GlSjx+L584cFFpnqTj8=;
	h=From:To:CC:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nHnM36deUp/rJY2qeY8GU3OZy/koJS2N3zJxAKvDIDmIEniXYzmBC0Cfa3MxPnx1r
	 Y23cNxkbCNEKE10dMc+LYY81XSdUzsRfHzVU6tYlbddZhR05qIRu45QbH0WCoAYbmK
	 P7yjOYHVz79erkmpRV11bG7XzLuYQQwSIFDVOSqY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1FC5CF80600; Tue,  9 Jun 2026 16:33:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 935CFF80601;
	Tue,  9 Jun 2026 16:33:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1B02BF80496; Tue,  9 Jun 2026 16:32:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.4
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1781015574;
	b=J4zqomvBkjJOCpItcXcMmUg4ZYlROpOmwWdUf8uoPkK+6CVErvEOKbnxV0xi7pULpwqf
	 Fyt7kLeaJEZdgePo1Kxu2pgTmygKrUOJyOvY4xy0/d6Ku0CiMRfsUojbFsXS+ESRMukSF
	 1AuhNNVLN3WOYS42/UYwrp2IihOmysXaj5AYoO+OVw3a41UBmQ8DD1Ygs5UT5zqHHG+FX
	 iHH4VT4+5Fl8TmAnSeLcreLQsYYu2BCcosMfTcM6Our1Jp1gkEmWcw4UyGvpKNkpTx1IZ
	 hZ9yU5FUy7PKUZi6cPW6OKGg8XHynrbTkK1O1uL15N1FXb2DSKk7R1CV7i7NCHOSvWQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781015574;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RFUtQ6c5s1AtNz+Cz4q5wq68GlSjx+L584cFFpnqTj8=;
	b=bzOi8SAmF/cFUdj8ygw7/7rB9OqqdRUvs7mM7IWIMKxVsecY5aLXdy5ktDtInpLY0YZ5
	 6RF5WCNUHLCkZV9tzuX80sw6kQUybA5mpXL8DPVp3Q6vGEctPq7trCsBpdoTAYQbXOApG
	 k54ZBroTTWicSYNqt6yOZzzrdKStj/dXsOFdumTHQ6loHS/Shgo1R87F3N/G0dVfvzXaG
	 BAxH1731ZS5EwO9ILjOr7Xc9rpccFYZ0eeal1ykE1ImEpfyOfl1nT4SSQt1ZdZXbadYl/
	 FlEFyPKZym0jDt0jFwVRx8WG0POMcWdEzprJGk+Z+WKgmGxzCvR5pB0jG6t0wm9N2+g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=gP4bJUaH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.4
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013004.outbound.protection.outlook.com
 [40.93.201.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B2DCCF8003C
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 16:32:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2DCCF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=gP4bJUaH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJbXH6UCzoiBV8OH7jMhyH5U8Bs3dH5PQ6Bs0w7joU0mREI/9D4Bp4UNjBp5j+kSgLgUbDQJ/J2pjKxNfh6KNdN06WhPgQZj58QjoCjHk8dHTjodwhuDJ+rx2N2ZianzR5AUJuxZzSVwP2Clvmzjs44MmsrS18LgBTBXZS8TGXx+L3qIvS1mj5I+JJBL/wDI1Dmggh5SlsJI4c3y8mOwMlN4u463CIIlgaAQ3p2yFaxrRlBwK5qScffauwrfCGzxseKV8V+bnPKuOQsR7r7M1PRRfS+9fU2lZ3hlcMBStrDPHyElfoEqg/ZLBA6Kyry4Q9/kspXvjZjiTPpPYsp0PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUZ837SSfCumMzJd8y1qG29vuwq7sd7NlTLUWKKs+qo=;
 b=y9d9QwAg1u+HAXCo6wJWyJMLdmFRrXTmXF0ouKo/5d9i/B9YPWnuPwQ3mCq6uCfEtP/cXVz3H/L+GuOHshxNeuUtjSoY/fwzjiGkZDLz2Rt01lSH8QdyJ6QYLF/mJ5/suVsc+vqc0UuXuD4biHRmeSzcGANripgMqJrSQY9KpFm62ReykjmLRJTdSzcX6ZWL4TgH+dF+kSjFd4rY4qaBbUQn/7tE1Djx6SHlOjbyfVK5TC8biHt1wK7CtuT6Uez+ezajLS1SokLZ2ls+9KeXGhE20pEYmRi86NIRv3VaNSCdnVot5flSAt+FzwbLm+JHPF08K8R8/6YGTm/jqmYB3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUZ837SSfCumMzJd8y1qG29vuwq7sd7NlTLUWKKs+qo=;
 b=gP4bJUaHSLfPg9bzDjoSXhOtFVaHgflRgdhEOr1dt6Jf0fGMRPercWr0+5++lgmob3SGyLMibl8Fqr/H7p080R1D6zl8u1y2dIMsKFsGwAWh3V1+uxZQ5ApXZlkc1jzY76l7aMVdC2glDu5FAivV1nqJkNN/C3K7M6LKT8yNdmk=
Received: from SA9PR13CA0071.namprd13.prod.outlook.com (2603:10b6:806:23::16)
 by MW3PR12MB4378.namprd12.prod.outlook.com (2603:10b6:303:52::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 9 Jun 2026
 14:32:46 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::1a) by SA9PR13CA0071.outlook.office365.com
 (2603:10b6:806:23::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 14:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 14:32:45 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 09:32:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 09:32:44 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Tue, 9 Jun 2026 09:32:42 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <mario.limonciello@amd.com>,
	<Basavaraj.Hiregoudar@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ASoC: amd: ps: honor machine_check in SoundWire machine
 select
Date: Tue, 9 Jun 2026 20:02:12 +0530
Message-ID: <20260609143230.3310356-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|MW3PR12MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8548dc-4aa2-4a21-72fd-08dec633f8fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	60NTfKWguyYLXpdmLH0TAMFeEFSThxD6pjcSVHq/P0W2qWeLpgqQ/sdlq+4viNSyFGwpNS5lR6YZju05nqgnN/YDx84Q3bcsLePzpMl3sljIEYOkRjC3ZUUV7h+lGQdhepl8F1dbIIjr1H7Pm5AdsBwEPFrOPdiVlXsvziXBVzAuf3Dv3MMA4bRIIDJ7KWpu9HSL/6ggdcTGcX36izwVjw7BMXvsghGZwLk/JjQLNfcG+clh5M7wEtLYl/iSp3dKKAYVEqRLLiThuNFOfXEXDaq2QRXxdofHqHqtUiQWgGc0Yy7Y4RqAcLLf9bSJiaS7Ukuoaw7ZKNYC3PuAbSKCQCrsK07iGOatmULLnrk6eG7yaCEgWubozz6YDnKmJCrliyZbjMrbezx4rRveTwAp6CMcZiAlHw2lFKoHgbYvMbakWOjql+h96j9ybbihVfn8R2RpErpBbcpR1YGL8LYhxWUTP+bKTUer9mfVkhOidYoN2MPcLH7IBI1vXMzNqWUIeTxPboe6Z3pKlEGHzN57gKq29IVrRUulw0OQWcZ4iQTdoTDFSe1mjYEDTJVl4eIfKP7QxqLD9WbTZW5/GBEc6iS94Vn0jaNdcccKlSYiy2KlsUBMiU/+ZsPcbkRQswQ4BXU+7Ens2Rt8j5r30DkeMyygH0nNwGgs/GsXKRTYjh/SPZ3O8gbJtfeYeP+pHx6SVUzp/IkZpzIu4aJaJqhICRSVXDAyqM9R1bvVDxwF5qA=
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	+6PMfKEHqImjKSE7iNVukAAs5ssW69Phqrmv4iZ+Bqf6veZgtcJKJ9WH+1EXldyNWiOq4lw0PISHiM8IRXq8A6uiICpJ/KCDIq7rDRM4Aj8LNH05QmPWHGizXXGpdXSeQAfLymL8xrqHugYDzSAARX1r9tsZ/56PYEkyA8CTidHBaLegBE6kDO+uRln4O1Mpq79f3qLjHGkuGr7Q2QXXTfoWCjWbQ8tOT2QIcNPgs4ENYIw0pCuby+34oMznVXodT4ZNq0v40IZ14FEiMI7tKlu043o9LDfHOI/NoLnNW98k91EdDLLgpaubBgLj7v8Orz7OgydLWFEyEMuNz9s9nm6F6VG20+LxhTctTAVlMi1MQVS/OyIHj3Z+/oDZATfE+TXpjnT1WroDBBfrbUJIFHcySXb7JlHx4tm8EFC2vZ/Xly+rGCYCPsfIYZFKxHBl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 14:32:45.5592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6f8548dc-4aa2-4a21-72fd-08dec633f8fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4378
Message-ID-Hash: ZPZMKTIWNPZZB42MZT6FBC5DPUEJTING
X-Message-ID-Hash: ZPZMKTIWNPZZB42MZT6FBC5DPUEJTING
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZPZMKTIWNPZZB42MZT6FBC5DPUEJTING/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Only accept an ACPI machine table entry when machine_check is absent
or returns true, matching other AMD SoundWire machine select paths.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 9751cf0784a6..4ecda224157b 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -329,7 +329,8 @@ static struct snd_soc_acpi_mach *acp63_sdw_machine_select(struct device *dev)
 					break;
 			}
 			if (i == acp_data->info.count || !link->num_adr)
-				break;
+				if (!mach->machine_check || mach->machine_check(acp_data->sdw))
+					break;
 		}
 		if (mach && mach->link_mask) {
 			mach->mach_params.links = mach->links;
-- 
2.48.1

