Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63750CC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:21:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5258E6025C;
	Wed, 14 Oct 2026 12:21:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5258E6025C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973288;
	bh=qRYAd/L0SWXXN8TCJJBTmnd+JBe0gumou5wtRL21zFM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D+lDCoM7x7d21hbZy7tVgz/PqMii8HtdYSV2xBbVLGyBOn7KPuDhuQ//6r2mY5/U+
	 Ilz6kCYpjc1ZM7cn0Wp5NpMlPKtVQEltpZ+RGolGqB97zLQrh9YAFTvkM+hPkNu+J9
	 TYYevOfj+Lsd65E67R7droKiy4JgnWuyPvyq8HOY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2228F806B0; Wed, 14 Oct 2026 12:19:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0F2CCF806A2;
	Wed, 14 Oct 2026 12:19:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EBFAF80640; Wed, 14 Oct 2026 12:19:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.53
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973187;
	b=BS+tcg3bNkKEGzQfyOr/uVXa0Gn1iozNSXC7QwUgEos4c2lfNZrBbK5BXvCDsJMSbNCU
	 z78TFNRlqz1HDJSnOVi5kd3jec+kE3Kk5gj03NdH3SL45S+yLwIlP9cwmV/3ckW+mGiMs
	 +2VPjpXSQEWY3LEUyXIuGBpBHYv2K/WVwmqZjhyMzoL1lc0xXs4A7aC/LyPlFgyoReZaz
	 oVKDgWQ/YOQMFVjtfU6Ax/IdQZ4Ml/krkNMISH8n/qsoVefIEl2sRZV36JYSRJk3XkbaQ
	 x/KZAvsW7q7DWxFAw7VSkvoW63C4bDDWSVMjKsdullYjauxOo3b765n/aJfybbwayCw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973187;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qRYAd/L0SWXXN8TCJJBTmnd+JBe0gumou5wtRL21zFM=;
	b=Veisxkq6Ejw2SexKtsvcJi9Pw4RO/BpRKvnw0JhLP9lzxU/lf07FdGo2ZmoyerL7o3e2
	 K231+6HTZj84j3/r6GKDCrYggE8uRPssJqRoCw4Xtfi7NnArfkk+uj92oYj/EWE49ZkSw
	 2WDsWju/gMyP+N409Mpu//l8AmjpbPWz41XaERnmwq+dA/ItnqfGGUv+hMWrXvS7ag0I9
	 sxbs/oRMZWcaJcmTBGj5kh5RX6ehs1hWZOXdjHHZ1vxhHA0ATLRfzMwlP79hy//8OnTDQ
	 w8JbAR1OXr3YMJ9nRrQARV1gCM+2LmvyPvoe0nQNFMrPG9YwfCr6INODlG9Z3EEV1SQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=F8HwjBwy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.53
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5E337F8062E;
	Wed, 14 Oct 2026 12:19:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E337F8062E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=F8HwjBwy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DY3YzWK8qvwEBajYRp9BeYGljvjFl7oS1Z/2EuKRJB2pdLn4JeqgXZz4VocVJJYZ+M8VwYRcze/75+8W+Lo50dq27CakngXWQDo5z9pP2mhYs0EU8qR9e9XAFshuY0Lgo8pdI32xxgfGRvwDYByjH7nAUq5lw8cKKdAuTNwcdjXlfKG1PjdYV4S71gOGF9jcDgr1LV1sghIl8nqHjZMlW6PUJkhZExHDTyhSZLGy3akyljNNlRjy0904AHO/34JvilkxzSnFFwnAfHfHpKbANtHxVvfbU4kn2o3IRL7Pn8qjMdBzBYatjZqB8vg/xwQTdgLxX/lJZvXIWkiCwon3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zC+j6RR5YLuxmHD20yKGU3foHh5dckU6AFXHlONT+RY=;
 b=rt/nSdL7GtRGiGlU8HzwOuCii3k36KWojNktdeL/R8q1RD6rHh+eyjeha80riicjc3ArrEx4sRTi5vouUAC43k16LJggmKgNpWUwu4Zpg5TDZcepxS78cwyCkZ2zGA0BE6aymS2wqUPmlHmRgO4l6eY+tJEGpZTFpNktCdWyFvFFsCdk3MhMKoq/4w87s+usihAItj6ncLZPRtZnMRA58+It2jl7v1BnTcX4nsSfSydq25vLujIqqxszbbZc7cb6q6LASsPL+eIYlr2kGKUhtNs5A+b76V+WWi/eSAj1hNEW9q13A6akD58EbKh6dCprxzJm817TwS5jkfJpTbQgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zC+j6RR5YLuxmHD20yKGU3foHh5dckU6AFXHlONT+RY=;
 b=F8HwjBwyBI6ZQKpqnXVhbjlktHQnAfbfAHnElVtv9OkHyrbWuIkm9RhtVYZrqV5jNmOFq+uDa3OfRPC26JyZ6Jr4tt2fIjvR8Ok28QJ4teB3uw1INntZScGTqelUZN7Hn4Q6U4aziA4SdDyR9fxF7Wl2DPY97CZHwxrEtDKXfIE=
Received: from PH7P221CA0056.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::30)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 10:19:39 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::32) by PH7P221CA0056.outlook.office365.com
 (2603:10b6:510:33c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 10:19:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:19:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:30 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:26 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH 04/13] ASoC: amd: acp: log ASOC_SDW_ACP_DMIC1 quirk in SOF
 SoundWire machine driver
Date: Wed, 14 Oct 2026 15:46:23 +0530
Message-ID: <20261014101817.1240200-5-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 255c2b16-d8ba-484f-a1e6-08df29dca750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|11063799006|18002099003|22082099003|56012099006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	Rsg2vAi3NXdZguLVOqFi6pCJtiGU1ZRVfnFzaoy7mAbalBxSV8AtKwNhq0P/6GflNn2oqcp2yCVmgwMlngQ/Ho3JzSuRBB0YPMvC7/UYLIfH1jzCB4SVAQE0AsRYK2tnFnPf5zdpeUo5v5Gfp7zS4MDrcc94v9llWdm02y1I5ReTO46SZGXUQeIHAg9q4Yj8NJ59J8pqH3j5Gtg8n/Ai/dzLRR2w06hHHMMKNSV104GfIwfBBT2Ad5zS0vp35LfpMRKkD7L9c4f5kJLCYJFlZ48QUvkR0IOxildwTQoUmYIQTTCG00HejEWL4DaH2i4JZlBTWu5/FdBX/CJwr1B+10TsouUpXHGXGmxkEDZIlOR0rb0qYNbeD7YCjbDM35Aw/LvQ67mtom9iuMwyHmtBGvvFPa+wzEFlS5poa4JMftekdqhtrRA+bdRWHjhvOOf9QwNnvBS7+kIRaPUH/dMTmNhbK43ldlNHiEelOjNIzUZAadzuf+o6/yftW5ojnrEFcFswLdiupe6mHWq6dtXqtY1fdhouYdnH1Ja/o333uMUFe2/TacQ09eiKdNUBc0mObqiQwLJ4In1ZaKtZgjEbSuuCsvXlzKYuXIQHLk69OZiwlFnvllTGKU5kNOUZVkOjANjPKuMALsY06DFNmJUOZtjpNnmZoR4LMfMhHDeI8BAPDMBy0vg+5xdhkllC6m9XJKJAh+pbykfQxovb4iOpdQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(11063799006)(18002099003)(22082099003)(56012099006)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	W50pmJmNoOq+znPOmBPbr47XyHgW6nZnAWT2HMfAsVjBdpvuViNpH11fEm+am57XrhEb/TFWuoz4Ls8+aejTb5lbp0gB8ITiXeHshcYnZHynluFUR5VAF96sMblDJns6RDw9Tw0Qu1ue8W4ZSal9XS6qcLEXUnTqNPKi9W47091fQ26GmGU3yz05jP28zEG81epCEQ5pCJDCtXSAfiJsKu2Q3JAfei3V4ALkAMR/NhjCEVI2xOhslTzcoojfVVElkMEExhZ4vAple1l61MPGCjhlyK6c3vciREYU6AA8W9Wm/bEpY84N80QWNMPaxFf33JCdoNFujD4/DxpdX7G6EsQIZ7N4+YNF15DcnhA9tGnmcFAOjbFogKDsPbpVbqphVSn7tTafoXQ04EMPd3rWD5fCRBC9/Cets6sjYzuftTe7fuS8Fv6jnMbyU6PtgWHs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:19:38.5647
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 255c2b16-d8ba-484f-a1e6-08df29dca750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
Message-ID-Hash: VGUGIPSWLQKRD6UMD4HER35GXVVJOVZI
X-Message-ID-Hash: VGUGIPSWLQKRD6UMD4HER35GXVVJOVZI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VGUGIPSWLQKRD6UMD4HER35GXVVJOVZI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add ASOC_SDW_ACP_DMIC1 to log_quirks() so the active PDM controller
selection is visible in boot-time diagnostics alongside the other
ACP quirk bits.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 2fb5c7ecafd8b..41160f47b1201 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -28,6 +28,8 @@ static void log_quirks(struct device *dev)
 			SOC_JACK_JDSRC(sof_sdw_quirk));
 	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC)
 		dev_dbg(dev, "quirk SOC_SDW_ACP_DMIC enabled\n");
+	if (sof_sdw_quirk & ASOC_SDW_ACP_DMIC1)
+		dev_dbg(dev, "quirk ASOC_SDW_ACP_DMIC1 enabled\n");
 }
 
 static int sof_sdw_quirk_cb(const struct dmi_system_id *id)
-- 
2.48.1

