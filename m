Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD6ECC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:22:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 29B6B602B5;
	Wed, 14 Oct 2026 12:22:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 29B6B602B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791973377;
	bh=iwv8yqU23j6aZez7HwOtoCit8LXrhuQFGnVEuImPeQc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bTbAE+aZYXIiQWps53VQ1T4XgXcGlSt9brKMkpFs9VFD1CrHsRqn+nsi1hLzFlpP1
	 8QVeZ/nJhJAdKG1dw7znIvIA94QZQGe1GPrVGPin39168JsKQOc9j9FDVOBhRNqJ77
	 GkTOaBcYlcwFF6nDTI8FMnCa6QRjaYigySwjNo14=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E454F807A2; Wed, 14 Oct 2026 12:20:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2AB08F807C3;
	Wed, 14 Oct 2026 12:20:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A690F806ED; Wed, 14 Oct 2026 12:20:08 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.47
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791973204;
	b=TT/2mafzeouFpfqLPRGKMmMX6zKf9ZJDB8mdXu2dy489HRRycTVrjs+SW1q58JSfAUAs
	 mgAQJiosL0pAlBMy4Gmm6ATmNhqZ2C0zg0vw0eUOGIjcpIbqqoUxlB+s7sL0LjYnOxxA7
	 wOcfVp89cQwlybH88HZ3uEf+93PU0l789Z8X2NKDIavCctbiFGwY+WHDGW/FV/NDUuFBs
	 Ks9eYqRWaJY0gLijCh121ZLC7hseKN6pcscCFseT2HSV7C9+wOvOlpG+z/2kkFAU4Ewcr
	 Fy+tggEOQAcFHyQME+U4m66KG2C8vmPnNQSUb74ell6hxFOGnj6PqxVM2Ji5pMdWmFg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791973204;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=iwv8yqU23j6aZez7HwOtoCit8LXrhuQFGnVEuImPeQc=;
	b=F7ukdCAERsELywTph5Ve+76SmdVUHX9lDZeqkraz34zkFTKzRezD2WR3R35ad8H3fpRh
	 vf75XQ8PkALspn7uL4ZH/nCu/Hex7KO+buiW0w3aM85AG4fJL4wNlbU3UdtNfFBM1Y7Xb
	 Sl2y/rwOWuVlKG8ZB4De6qAJlYXaruPw3Vhuu7SCIqZCwh255kZWr2pf2JxlPQSQquWNR
	 deZ51xSb/utlOmoN6RRIn+GrJBR+l2WsMV/wTawhTVrlOwJP9nmh4WOI9RkD0Wl6XAWxU
	 J5Pv240jE71mpJ/De6YXcoJwjXyyUJIdej3vsv8oI5li3JHRZoxvJg9iNTI5gzt+yiA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=bu7Y2EKm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.47
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D41FDF806C6;
	Wed, 14 Oct 2026 12:20:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D41FDF806C6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=bu7Y2EKm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFEmFxojdG5Fp2w1AZo42SEf/ck8G469kHuycvf2ulJGTFknmu2OevoLJ5nAY2a6sCgmObzMA9fRacMJa0w8QMhoK+ovNUf60wzlepChA/e7pl4N6gODziAX2NTeEtPvY83q2YGRLlKGwC1n5lT85fLYx3eHsFyBm4owrEHbATHYQGjWDEIaFX7p7TgyJZ+DQk5QqqVsUUyPwnCqFAQgB3+MgPBQnEELcwC9zzQI6XFn1CXx0+Jwzl/Ta33IJPPxaNQS8JKLWeU4UexQQpOL4nrtGoCABAnEmQ3Xp0DnPZlIl2pDvxouK84xIsUH+vMvj609Wv26R0eM9mRY/1i44A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b4e2WFVCSIu5xKS4QuzRIXd6qP96kqIZFQpoO1myH8=;
 b=LLWxs95azd0KJQzctf+z4qMVtiXeClheq1owNVJdyMYCplkxIDL+HAKKzkezwdTAgFLx2dpp7wgzuA43uCiqzPuhKrblchVYAFx0UC4JWdmOKpYvolcsW59DghuEBMElu2cHMdoxONjFtgmWPBCtxd7m5rk7jWbJqGAhrZ369Dlyw9+4JQ2WbOJ+vsN3p4GQ65czMlsAHjc1Dx7XYhLcZn87qRpqb7Ybz8fP2SQVlaiwKz2Pzb9KF2NZ8pmS83Sd2T4nrhhtRhrMGbDFcilprbsdKcuEnI5UyO+tzxjCSiaIB7C8JW72kihkVnyRjeGzBh73BJxePeHC541HrXoM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b4e2WFVCSIu5xKS4QuzRIXd6qP96kqIZFQpoO1myH8=;
 b=bu7Y2EKmIvgwEc+POfjsGVuC9sG/hDppEMpew45688xWCjrB0wXbbkQcyoU2MoqU9a1j5NzF2XObtgnZO+/XUq8ugU0WM/IXzZnOFChxgIdu/JZMYjimGFwQu0kRd9hOK3PmQxL0CrKBWOb+gPmrAizkYTjtg5o9g/GWsrQbgUU=
Received: from CYZPR10CA0013.namprd10.prod.outlook.com (2603:10b6:930:8a::21)
 by MW4PR12MB7143.namprd12.prod.outlook.com (2603:10b6:303:222::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:19:56 +0000
Received: from CY4PEPF000392DC.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::59) by CYZPR10CA0013.outlook.office365.com
 (2603:10b6:930:8a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 10:19:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF000392DC.mail.protection.outlook.com (10.167.247.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:19:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:19:49 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:19:45 -0500
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
Subject: [PATCH 08/13] ASoC: amd: acp: set PCI subsystem ID for SOF SoundWire
 machine driver
Date: Wed, 14 Oct 2026 15:46:27 +0530
Message-ID: <20261014101817.1240200-9-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
References: <20261014101817.1240200-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DC:EE_|MW4PR12MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: fcabd9d4-f5e6-446e-958e-08df29dcb1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	5dTpZ09BD0lH6NBuaT0yzLYw2SM7j5DRw4t+gVdLCLhoGzWX7VioEN4GSGHVaZu2WCUsn+y2rL1QCIsK+0iz4OjAKNBaVr/ZaD4AqGb9+w9dLbM00OEN8woWVdImHFcOvDunsI3jcdliMTkZ8u9TlD/eitILsIapm5MWofq7KEkpku6adhMLdUWI1adnTJOeN9x4OHYzO3PrZwO9S+3a2RFzQJ7/UnIgNTL3igclizF6y0RXpKM8OapGSP7elSZOoKwKx+/Mtehr2YSwFr+FVw/a9Mb/EUYmWiV3e+2IC/TU116GSMty+bbsuCr3FDhVeY/wft+VfBKgHCgwRcPaUx+gJbQpV60T73A3d4oQkVgCwIMGPJV25om3pxuG0vKlRuC2vuYGnQW1jbAMDCWEQAAe027xDQxKIxxZjAhhpWYcOr/T0oK3sT5hH0c4XK9MSFfT300XfCVkItaOZS8QkJTBb9W3UwXkmveEjo7cPRYEdFJv4Aaw6uAE1y9ynxFhzf9ye3xgYIFxphSmIYhblrpGLFWk0fnoabN9KK9jZRoVwP3H5cv4fsvGsi8Vn+Ntz1eJYanfjz01GKapjpvyoszio7QwcNGMnvjWQJ4V+6IcEzhLbJlVMwsS0j6MYXbfCE/WRIsZR2hRynRXJvklaEkXF9SEXCshirohLYEv6xoQcZ437qaTt46eXK+hJS03M0pRFan6pk2KMjPbFXQ/Cw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9Fy8U18/EHNy7hetCVRJHfd62N9Y+JAYbtBuFiGFExquyEw40SBpMBLeFCeKey55XWh3fr2jLd0B0LCsJ4ZzlAhUcwYLs3OQiy9NU/O8SBzkc6fyWmbiOIS8VwUGr+5/TrPKHXsZAWG8kQ0DMWxlyhbw69kOZzsehmD7onTDOEWXYzoO8Y3YK8LR/NRAp47Qe/NBnf7gmPldmuVYpwlzoAlhQQiPuJnQdsl4aUxGSkxFby9jbKHghtyRcKsKbMapCijY+PXmZirfLI7ah0OgrEsoAxoUYGT72RurJjJ4zed4l0dW4hrKz2rwufQwI2TEEYQ9BwmiRKQZqbf53PHAqZllMT7SsoRedpOuO3eyfkbhx8nlBVZKjYekvjaV+x6N3R3PZCKePZIlAvfKpKnyddTipjassnBO2tHq2TFGLbkejR03cxgmK79UPnWWy1zu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:19:56.3942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fcabd9d4-f5e6-446e-958e-08df29dcb1f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CY4PEPF000392DC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7143
Message-ID-Hash: 4MLDTGCKY6IBKIMDJJJEIRQKXCG3H6DV
X-Message-ID-Hash: 4MLDTGCKY6IBKIMDJJJEIRQKXCG3H6DV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4MLDTGCKY6IBKIMDJJJEIRQKXCG3H6DV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Call snd_soc_card_set_pci_ssid() when subsystem_id_set is indicated
in the machine params, propagating the PCI subsystem vendor and device
IDs to the ALSA card for correct device identification on ACP
SoundWire platforms.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-sdw-sof-mach.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/amd/acp/acp-sdw-sof-mach.c b/sound/soc/amd/acp/acp-sdw-sof-mach.c
index 416cf58a58a2a..b80accf7817c6 100644
--- a/sound/soc/amd/acp/acp-sdw-sof-mach.c
+++ b/sound/soc/amd/acp/acp-sdw-sof-mach.c
@@ -440,6 +440,11 @@ static int mc_probe(struct platform_device *pdev)
 
 	snd_soc_card_set_drvdata(card, ctx);
 
+	if (mach->mach_params.subsystem_id_set)
+		snd_soc_card_set_pci_ssid(card,
+					  mach->mach_params.subsystem_vendor,
+					  mach->mach_params.subsystem_device);
+
 	dmi_check_system(sof_sdw_quirk_table);
 
 	if (quirk_override != -1) {
-- 
2.48.1

