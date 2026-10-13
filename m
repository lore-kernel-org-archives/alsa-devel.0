Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FD0CC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AA5FA60202;
	Tue, 13 Oct 2026 10:54:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AA5FA60202
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791881675;
	bh=j6ZWkAhaWpl5Wvfvw5PdFy42tR2wYIrAkGaqLbpAZlg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=TR2fme4YLQCmp+GepOtW0Hrmk6kw/6ko5YMNg7W1f3QWu+7jDlNVmwqXWM0Ip8YDy
	 DnXJY1MxEnAwbQYzzuits1nV49Qi1wxleva21rTWAs3jcIR80a/sV+GQSJSIXphrZN
	 vn76WWQ0lawEGdWdUMd1G3OMg9HJuA1whIhYCci4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9A66F806C8; Tue, 13 Oct 2026 10:53:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 28E7FF806C0;
	Tue, 13 Oct 2026 10:53:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 41880F80689; Tue, 13 Oct 2026 10:52:48 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.51
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791881565;
	b=CeFeLyOT2Vc9a1j80ezX/tfluxQvTrpkHkWtEBSEJNqJamzcmabqxGipCnm1Tfga5A67
	 5KKHZcoE6IsHpPXdrDuzRYUdOu5TnpQeQCelltSzKyFsyIPc2NPXSC80eMEUvVen8eid+
	 AirtmrsgycK42MCepVJJxEv6g0URWkdktZoa18nmPSEs6FoVAv1VjIWgn1Xet+Zk31uTV
	 dMQ2WPfma+vIG0RVxGQ1n0aL5zrrfheQXsol7GeT/g2tLGJtsfxo8B+CkmD7T/drI7Fvd
	 ggU5BVEuS7ELzQWEs+NjHkVsLFYX2TIdD3HUBXsYc8zReEvzbqCXWTENnTpckVgR8Cg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791881565;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j6ZWkAhaWpl5Wvfvw5PdFy42tR2wYIrAkGaqLbpAZlg=;
	b=hgub3fH+Xr/LM9aW3zZiBWY/6dwkkf549Z/pOMMoZyEAKzxkHbW7MfPCKqpTDHNk9tKi
	 sX+BL6C1Kdz8cosik2ttFACvdCQ7cEbdPfBv26LvwwTjM17JqcXnoSZZq5FfIgq+hhGRX
	 nFvdh0tIzI+PT+NZJ5BWURjas7XzBHSGx4l+kOCqdnBZ8MDj7MkcmtWsZa1ndje9pY15S
	 K1zGl5s6x+j+MnhamRbAO6LnGHrwPzUgYH8JQouH5lIR9vjKZTipcsPXHG1JqBteSQqS1
	 CSsoBoLAa5987SqWm6rrumlU3WGVoAyFawEvtbR7yHfACYWH7uoeWmYkDlA8h8niG0g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0j0kfkSq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.51
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011051.outbound.protection.outlook.com [52.101.57.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9917DF80651
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 10:52:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9917DF80651
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=0j0kfkSq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3HUEBeQGyWJIZwyKDc2nBghqVt+dAB1WHMVvnbEbTanJlV+k99AtStZuNdQ+QC3QtR3Y2NmB9E29H37qWa+fs1oOa3w7cA5zjEMvHK1karCW/xicH0htfu4eGaUh8F8YbjeLRtMmUcTc49AXAkBO8IRviAJWIlkW8B6BqFom8CLOYejmRF1hlT9bReogvTbYV2Uhl1P6xJ29ZCSohbtFV0OgqMPnHyMJN6puAx5BWdiwDY85FCxfybZ9L4ABqV53m4Z15FvVrI3ViUMhtHigYT/SkTE++pCdDjuuGVH/yRNx2ohZnif4WuLKgTQ35/DJVU0r5BMhPP1XyeyOacIdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXcEEB/rWlVlM/YCXOy7QLZ2sjE2sbD1MRfMg9Ll+uk=;
 b=rLe7hwd9/7OZ72dq4CeOr0hzQfnRIvHPNj0SO/8CFzpFLPt7NOjZ5C+ioJ3JKBRkeQp91clZ8jD3zJuIg3kF3XMa2L3gTp6xhXj1jdsQJlHTu3jJu6aFURmaieKwqaEUjEzT2+j+AzjWIbJZsXA+AKoB7GhUb5ZTG6ZcScYdYJB1zR9smf2qryS7UflYJ/PMoDNlR+NZTjqPx2L0YLE+K0+O7bIZMHgZ2S/Tpqmm2apy5f8BBueXGwXXsR2/LhfBnkJNfFQhmjrrV83BMQPfH5ZJGGeuHsPqX6MHUgmzp8yBj4C2QLiehhr/1n9mGzdX2lH4P94kODDSY2SqWI3cXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXcEEB/rWlVlM/YCXOy7QLZ2sjE2sbD1MRfMg9Ll+uk=;
 b=0j0kfkSqDDgL8sHoFobj1qNMbYjudY7X7MgE1x7C3gTsosq8qExHcr/vGLSHD9YgdJcQFHQZ028nBdtrclXO481Ko6w7KtT/xj9/n8ZFYhkM3XnkTwg7yzq5Zbh1xnbJzWE8JhAEmM5rTIPu6wocHeQaKp0XVCkcI1S5WY2Rw4o=
Received: from PH5P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::13)
 by CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 08:52:35 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:510:34a:cafe::47) by PH5P220CA0010.outlook.office365.com
 (2603:10b6:510:34a::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 08:52:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:52:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:23 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 03:52:20 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V3 05/10] soundwire: amd: fix ctx leak when sdw_amd_startup()
 fails
Date: Tue, 13 Oct 2026 14:19:26 +0530
Message-ID: <20261013085111.2009061-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
References: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 836000c6-7e7b-40cb-9c01-08df290753ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	dDwk1gJloxHmylwEIfETFm0hl5F6wl6G+ovYy0kAr0Iwp2lZYRF7Kr6mrUN1DlPmqf/fPHI+SCUs3NKHxXN33t8/fxM/4XlFKzBjHbm5/0NOe3tdpvgJdGPNVfnTOnFj8DhAXhrz3ajVFsvFIvlHqH5tC7whNOb5pmYdNMVsLaWxUDxPvAKi7t1BdV5MQ4V8b/STUOlzdc4CsHWv/vj8F6uIAhYm8v4z5XRYjIeY1Q8ei1sXrhD135KS5xJmfw7eKdtAWDOcqaRwbOCMSEGy/6q9H3C+W5JSaTGjSQgEEmZMzq3lrPPEg4eZMkXyZ+HZ+Vuj6tt/+KKORx92eSzbvY14HJozkaWZEzB6Gdklp+SsZ8wcYiFBFfZ5PbQvSCTbI0DKytClQMAyfe/GepiozFMQZwnM4VifoGHZ6sjKXH4/G0/bRq8K4NckIKFvNqQUTvPmu2QOBALl3pgMrVMiujYkjgXJ7DK69F6xPKmbOvQoas4RL1AqgLlxy0AyIodj+Y2xymGLZlVwXZlo90BVQIsogThxon82pwwbeGf3EVEdqqnIQFKZJn2ubd7bHaXrrh65sJTOuD7MF2U0mfQy38etJ9su15Zmgdz5rAuCPFqdDFd/YR6G0dOFQUV8F6wy9UAhdJPvRZFGVQAWmHHYHj22zjMkpplhF25hdim23WPoCOUgwU6tGx1nnCwzbW8QlA3U88sMMpNSUBvYRX/L1g==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JIxnJ6Rnu2IB0QCO1yuoiS9iETiPQ4g9irdOkyVHLRHXF3IVeeufTQKrEIsTr3mmevB+teQgPV4zBOyUXDrVWYHEmIKE2QfHPys2cvhZVyCTOQDQXn6t2PcHQMIPcEZ2U7dHAvnCrMCfDJUFd3mwAclCfuvvnzoT0LSnUWOYIANsXImPIlVBIDwdFNiGyIKxpcLPTQUQHLc8918YmmT8S6I1Z2GEO2KW8SePmTa924jdFfjqB3u31hFhwUmouqyMWM3wYI09zMOwdA4VdM48VJQxxbjI8RKX/X1WmQG8cw5Yuht1rl6KxKE+kWT7wzf4PA+A8dbCtakWNoy1Q1I91J6O72Kzk7gFuEwGiu8sBOO17VunDjpfkysatQfg5y1BeHf8vrIPsZWxEmcNY1jBU+WjYtB3//hE9tWpU7L4WvWLbpC+lBp4GGcoT0HAeeyq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:52:35.3914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 836000c6-7e7b-40cb-9c01-08df290753ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600
Message-ID-Hash: 6ELNORDDRBZ4ZCTMIHTOMB2K4NO2NRDH
X-Message-ID-Hash: 6ELNORDDRBZ4ZCTMIHTOMB2K4NO2NRDH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6ELNORDDRBZ4ZCTMIHTOMB2K4NO2NRDH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

sdw_amd_probe() allocates a context and registers platform devices via
sdw_amd_probe_controller(), then calls sdw_amd_startup() to start each
manager. If sdw_amd_startup() fails, the error was returned directly,
leaving *sdw_ctx non-NULL with the allocated context and its registered
platform devices leaked.

Call sdw_amd_exit() on the failure path to unregister the platform
devices and free ctx, then clear *sdw_ctx so callers observe a
consistent NULL on error.

Fixes: ed5e8741b8db ("soundwire: amd: refactor amd soundwire manager device node creation")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_init.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/amd_init.c b/drivers/soundwire/amd_init.c
index 8e419ddfa516..88004d59322e 100644
--- a/drivers/soundwire/amd_init.c
+++ b/drivers/soundwire/amd_init.c
@@ -166,11 +166,18 @@ static int sdw_amd_startup(struct sdw_amd_ctx *ctx)
 
 int sdw_amd_probe(struct sdw_amd_res *res, struct sdw_amd_ctx **sdw_ctx)
 {
+	int ret;
+
 	*sdw_ctx = sdw_amd_probe_controller(res);
 	if (!*sdw_ctx)
 		return -ENODEV;
 
-	return sdw_amd_startup(*sdw_ctx);
+	ret = sdw_amd_startup(*sdw_ctx);
+	if (ret) {
+		sdw_amd_exit(*sdw_ctx);
+		*sdw_ctx = NULL;
+	}
+	return ret;
 }
 EXPORT_SYMBOL_NS(sdw_amd_probe, "SOUNDWIRE_AMD_INIT");
 
-- 
2.48.1

