Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FE7C79FB9
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2026 13:25:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B8B2E6028B;
	Thu, 10 Sep 2026 15:25:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B8B2E6028B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789046728;
	bh=/WS5vY1Ufmcua5S8BpTXI9I0EOwH+K/h5fIXtfST7gU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=aG/cgIjbtSL+GSPdkrTERd5HFObd3/tOZSMVIqpsjv3IUGpCEwyIkU1BxT7BFRURf
	 Crse2iSFu1R6Bhd0Dbj5uDjH7x00ON1Mao97UYHX5bfjY/ywjJu9Fp5j1datF3FYxb
	 BCNC01ZP92zto4sOhHVlNdXNqmMB7o7gmQdQW81Y=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4307DF8062E; Thu, 10 Sep 2026 15:24:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CB2BDF80622;
	Thu, 10 Sep 2026 15:24:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4994F8051D; Thu, 10 Sep 2026 15:24:18 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.47
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789046656;
	b=eMgsi9SImsTAJLEaa68GqN8HhMBJLjEiGW3wW33B1sDQYH3xh3pKBkgVbNgcR8ng4GKS
	 Qzk3S19XYj0F+F1ZURoYqGF5bC03jXaMlSwVQR0XLoXXS709T29kmYySU/feyc9WgX/CQ
	 Yf3M0DkINMHOF2uEF77Qev7q1aPh2qkN0VSVpGmiSFjgQhfCu/NgBJCtPzmUIvbECWe28
	 FJfQQSlbVR2r8v94oscQfgtQGeHe7+rjH/5N2hiO7C4dLrCRvJ3eHCxsM7qWg41QGcYQw
	 fwhTX5gSKkGSqu7pXI0QLtBnmt/N6BGLQdQ20yV9YvmhV6/Gpve6U6xpysNGLH5tw9w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789046656;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/WS5vY1Ufmcua5S8BpTXI9I0EOwH+K/h5fIXtfST7gU=;
	b=aPXusQoLImLPJfaboxkhW9qA0UpnQSJ+9uJ3CQ0nFY6pgqO/DR9pEClebZnW7KdJH7Vs
	 m1zwKWF0FEaGwI9cpCA+vTBwpT9ZfeTsSv//sUaJ9/2rzbGnIb2FfOyG+iQReLu230U0Z
	 1T7siN/bRoWt6DoBghmyuf5ufB5hSBsigBLxQbkip+vGO7DI1VJwVjfPkvBzAmf/Lhg0A
	 dKLf7iiSOEa6AY3s2PObgAq9IbK/JdHmbjO2yswDnQj9TgHCOua9unZDC58ll/JVhP5SA
	 Ed/EPLoGHqYvoHKPRiyHkiLmaC3/z/1H/wDstNMRQDKpcrwfGwJFperWDlAMuzXeJEA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=siWP3Kn3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.47
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 09BCDF8003C;
	Thu, 10 Sep 2026 15:24:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 09BCDF8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=siWP3Kn3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACQIY19ixJPb/bJCgyY2iY/xGfplAHQakqPfmZKU0LQ/AI6wW524EcRoFJoCQCjaMvKF3KUbNGXXjAa4t1Lt8GczkdIDFNnTF2NFVCt3w7MjlEx+0nmb5h/a3+CGLvdRAdMeAKTxERhvh9MGo3ZWQutiux5h+BKGEBj3ti6iO9crFq1E5pCzjK1KgfbPi7khiKPIJ9SaEv8AhIicPV4K3jiy1bi9Qw4JHZDrNObLQi+ZXqipaTXACVHfrON7DVLUS2wazYGeWWwfsrv8jJ+NiT5jovtzwQGzewEXEbXefwDlY9H+PYgrpDZOkXER362hubPPztKc7vJ+jkndKwQWiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KroA82CRk/g8bZB6XKSUddaxdaAEtB0qiaPRNS99cs=;
 b=rk0HCkwwM2OHd/pZPgVhEMkjNnKg9z58eIEJOeC4HznaZIk7+0jTZpJ3S0vs0BkRbaRjb7uiac++M+xt5hiIDKOvMUhUYpt9Gow9K0qv4lcPupRotQpqDiBGpLhokeW8KYZNuT7GZSPpRXyhuh0ARXwlSCmTOnZBU8vE1Eb+/br7bAZ3+mZO7NGdb+dsYciHsnWQ3E5LWqY9OUdW6kaRvgU/p4arW/sllGxLZlms8yJ2Qw00fbwrd9iQb3dySpD6xWi2wkM/9nhzSl8bnU2HST9r1kHgv//cq0hCJnjxkkEKQu81vHudBtFR6SKwumMqynuLp7Bf2TQp8eqlp3D1uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KroA82CRk/g8bZB6XKSUddaxdaAEtB0qiaPRNS99cs=;
 b=siWP3Kn3WHOjRieJuf5s88Cy50eXdf4VzfdLg/v4eVDLQ5Z2py89faZXeJ+DQfWZIQ0prJGol7+ryvkbn80mYIAJ78JD3WhH77uOVshyWxDoGLwl99SNC1nhmSCgcyT+TVqotqBTBybFgo+E4HSWy+sCY9iCuAFEfZ+eAhzTglw=
Received: from SJ0PR05CA0099.namprd05.prod.outlook.com (2603:10b6:a03:334::14)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 13:24:05 +0000
Received: from BY1PEPF000264B0.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::72) by SJ0PR05CA0099.outlook.office365.com
 (2603:10b6:a03:334::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.5 via Frontend Transport; Thu, 10
 Sep 2026 13:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF000264B0.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 13:24:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 08:24:03 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46
 via Frontend Transport; Thu, 10 Sep 2026 08:23:58 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<perex@perex.cz>, <tiwai@suse.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH 01/11] ASoC: SOF: amd: return -EINVAL for unknown PCI revision
 in acp7x suspend
Date: Thu, 10 Sep 2026 18:50:01 +0530
Message-ID: <20260910132251.1171943-2-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
References: <20260910132251.1171943-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B0:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 225f1170-62b6-4b6a-dbc9-08df0f3ec944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	be7ErUS6Hu2iqmSUrq/kTWhjMMH2ScbTKGifMbDpNFUC1Tsl18876oYK9Mbhc3h/b08QkW8PHepEDXiyPT/oowMH3qFdTdwkASffZ5ZM3een8agOka1Opp70WKy8jZ7GBZS4QxLKLOIK6h4W7OfPTpY+3EEwp8vQwUbJ4lxErKv7vK+S1jMJU9eJ/fg7wU/2FJAm1bcRDy4cq4JhNKdLHcplPKcrbEGPyGeoVj604eHa1Mkgxsbms4LGRWQeRnIAIBLSWedUBNJnZXcQhbtAx+3tNCQnssGYhnhLc9vClvBG3TKVDlDNPGe7br2oEO2Ae5sroJU/k0+dACjpNoBUI/dWE0OV+ECEf8P+YtQsv7mH838N63pE5FJKmxvO0pb4m5PpBzwQUPb85xwastjA0oDBif1z+bIYh+WlJZBPdyC0LfeqAF1fv3DmrpxQLFVEuerkFUvILpfqgANfO+LGtilSUhH6KbWEK8viF106kMKn48A5eVZcNm9hxCeJAgtnPTb0tr+fCaqy428oRCnANP6uQEq2hdzJCPfY1q1rShkXg7lIusqwfdP/ty0qCBB8/BI/biyj2GhlKuqgv0mVTVcD4gd2B07rcymnhDLHBDz559C8keqXLMPeL8fF++S6cOr6GTRnTJVa8HabqU61fStWB78FIBvVoJxmXW2BV6+BS5+mqfoJWMzg3ChSYEH5uMLPmzjNMSGzNjWI95R2kA==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ClQCkj+gfOfE1RkAQK2p/hNkWhaghES1Gqc25Lb482RBOyCyET3rbM+e/A/VugJfVxFqYni0WqCliozPtz9T4ao+PlsxcvaXaf3cHqYwGoaIKGEB99uhvzo6BB/Cll0+7YHBPIscbt9343jwhkPdREPyG6OelRC2EBXVFU0M9RGX69b+WmFfzINz/qmDxxSSqCFjU5hBGUEP5bBzQu+f25qJbZaVsoPVcGmQBF9K0t4LM7lVEndWyoxBKsvGeZPleHzkQUIZrD3gddfX0hy5iGeAC+c8bTz9S3lqsgGkUkEj10UZMGhjb3Hp2jdhBNbiBJ0DluLVDtiH+5QP5vIneJJCZOPBO+3ZzHF3Ph8p3IJxtoz+iVDeC0WGxK4efLdXYfGmL8Pc+zumlx9/31TJmAhZ53jyRKzKs5f0i8EqvMmbJzkZOeCVVo67rpvCRFZu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 13:24:04.7733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 225f1170-62b6-4b6a-dbc9-08df0f3ec944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BY1PEPF000264B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
Message-ID-Hash: D4T3DTEPCEL7LWJF4RSRZJX2YWKQMOJI
X-Message-ID-Hash: D4T3DTEPCEL7LWJF4RSRZJX2YWKQMOJI
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/D4T3DTEPCEL7LWJF4RSRZJX2YWKQMOJI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

amd_sof_acp7x_suspend() is registered only for ACP7.B and ACP7.F
platforms. If an unexpected PCI revision reaches the switch statement
the default case previously fell through, leaving ACP_CONTROL
with a stale value (enable=false) before writing ZSC_DSP_CTRL=1.
Return -EINVAL instead to surface the programming error immediately.

Fixes: 1c9646f3180e ("ASoC: SOF: amd: add system and runtime PM ops for ACP7x")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index f89ad86260b4..688df7acd2e2 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -1197,7 +1197,8 @@ int amd_sof_acp7x_suspend(struct snd_sof_dev *sdev, u32 target_state)
 		enable = true;
 		break;
 	default:
-		break;
+		dev_err(sdev->dev, "Unexpected PCI revision: 0x%x\n", acp_data->pci_rev);
+		return -EINVAL;
 	}
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_CONTROL, enable);
 	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP7X_ZSC_DSP_CTRL, 1);
-- 
2.48.1

