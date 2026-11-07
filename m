Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010BB606A32D
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Nov 2026 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=Dhg9j8JO;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=v3voyPk4
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2055F601F3;
	Sat,  7 Nov 2026 18:57:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2055F601F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794074282;
	bh=NYqVQL93dB9jIAB/U+xkyiMXUxEHW8ZvBvQ6fFRPoeg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Dhg9j8JOE/XDwnxNICVBbpgh9+k0+5za5kGU5Yuyk8wOYhN5QgbpZANkTSnyoJ8KP
	 4/6YN6iUF2n8n71poBhdeGsqez6mRID5O+jvXBusL42Mh/YtNes22vl9fdk820QOTr
	 AxmNKcjX/KFX54ZzoMutVpGx7RdJSLguR0fa3+q4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 60892F805F7; Sat,  7 Nov 2026 18:57:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 788F8F805F3;
	Sat,  7 Nov 2026 18:57:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29B13F805A8; Sat,  7 Nov 2026 18:57:23 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.59
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1794074242;
	b=ECIRhgGGQQYIeiGwxy1XIHicaanOLCDzIC+4SKqzuhZLp0znekalU0yjclbzu5IuFnEc
	 7wgZuaWROMwBCqih5fUbdSsTlFLXe0A0rI6ynBI9cxizwBfKqPuH3b/W2GR8PH3Uk9gUb
	 Acyd0W+5PWwhXghgtK6KLPivQqTVBfhcj13fB5MLKOl1Z+hJLAamml8oMJqw3Ol9PVSCc
	 LysDSjg5bTjhzjuBMI7EffmQ1u70xgWDHWZ8mRYCDi+ESQsLMs86bLUaCvq4MvXqK/OiH
	 bT8NV/6RBFJXhfcfRx0BXJLLcmDxeTJvCh6hR3vVsMvLyk4TGI9HvK5NsdrAAVNAQhg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794074242;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=NYqVQL93dB9jIAB/U+xkyiMXUxEHW8ZvBvQ6fFRPoeg=;
	b=bF4kG52L33oERUpoNvYhn3T6cn7FkRQP9BXWZ2kR9DyodtKdJImA4FRSvUicXHBoWDxv
	 kdnO6WsepuQuDHC3X6dtbM7YEZNvIRI3gnudiV9g6L+/cp0zo1Ynt/hrUOQfDLRiVbHCo
	 WBXa30M/nrEj0DT9JJ6Q9SkW6ZqP/SoI4V2pKl5DGx/a/ZPhGkhNfLNiybtIveJ7Ac73d
	 BOV1gWOR7TMc0vsSrq2TQyWbSU+8EEqZNKTUXLC7GRA6YbhOfRfHk5bulHAei37GOme3m
	 YoYuGD9cuoVWvP1M90rpbXElJ0ajfDzCxRHlaLrlMSprQwmSty+6bD4CLFFveZ3D7tA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=v3voyPk4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.59
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010059.outbound.protection.outlook.com [52.101.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 19113F80124;
	Sat,  7 Nov 2026 18:57:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 19113F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=v3voyPk4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RMJa1U5J/Y7KA+qlvhBrCrZV5tQScUt9CJy7XiSsMTFUGiEN+aI1m477LScfMybekI4Gzjk6iU9dk9gaeKoCtvccJH8v3fCw7nfJ/RTA7PSIeueAr2BdVrJLLVLz5dmomTDtYetSfHi/gPfCQ2l3Ol29fDG7ZmLX222sEWmTMzByTEAzOyYpN5psq07HPUcBX/9U//pka3LLsfhsEn54w4p98MAuezWFhNm5y13xTOXu5e8cianxFQEWd1KH9Z9N2sIUnln/mGn5VFUL0svw6TiOdgxkY8sg3sbFRvFKdz0sR6NN9rcI9fdqduB+McUnNVpTGJujWCntXRHnZbKoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4R7jWWPNLtRHzN/NGNzMq8lUyt+CMie8SDaZgXjGs8=;
 b=dRc/NBmFgbER//vqBDSJ7e2v75Nk747mVWttERybV6O7LrnEHRi/evJO9hJ0xnodNHSdQk97zBHhptfXF7eslDbJ6hySISdskBODUXTXiw8PzG6iroB3geR+HFqIO4xzrxaFYEVNQ/EYHnJL3Hn6MtcBM3OtEc+Jq2aibp282OyunzgUC3zONaXeiOY6Lkmbz46a3eXPyvFsdbde+Q7CfKho0qynFKPcEvvXPeZC03lisYDCOdDDf2VBgMsnu+v5/GcC2aGgYBINapqPS3ON2inRwrsgBNRfFmUSZpr6xbZdBbYV2AZx9sUnEe/1yvdZZ1fJOIESpQSv3pKIKkyn4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4R7jWWPNLtRHzN/NGNzMq8lUyt+CMie8SDaZgXjGs8=;
 b=v3voyPk4mzpA/otRPd6NsLwfSmp3v/88NV6O35LcEtywUrfIZHSVsJr60WZsClHoo5v3euv/m+Bq2FNR2KAEEkZu0GPtZ9kNqenWmz+V1HT20R1tGXkMyIh3tLgUaRfSNGtdMkvbStc98WajZbT660FWYWcu5lU9Waxi2hBk7go=
Received: from BN9PR03CA0466.namprd03.prod.outlook.com (2603:10b6:408:139::21)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 17:55:01 +0000
Received: from BN6PEPF00000075.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::11) by BN9PR03CA0466.outlook.office365.com
 (2603:10b6:408:139::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Sat, 7
 Nov 2026 17:55:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000075.mail.protection.outlook.com (10.167.248.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Sat, 7 Nov 2026 17:55:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sat, 7 Nov
 2026 11:55:01 -0600
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Sat, 7 Nov 2026 11:54:56 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <vkoul@kernel.org>, <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
	<perex@perex.cz>, <tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>, <Poojitha.N@amd.com>,
	<lee@kernel.org>, <Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 2/4] ASoC: SOF: amd: guard adata->sdw dereferences with NULL
 check in IRQ handler
Date: Sat, 7 Nov 2026 23:22:27 +0530
Message-ID: <20261107175339.3547918-3-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107175339.3547918-1-Vijendar.Mukunda@amd.com>
References: <20261107175339.3547918-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000075:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 8358f08e-7026-4670-b286-08df3cf83efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|7416014|23010399003|82310400026|36860700016|11063799006|56012099006|261021121427099003|261022075727099003|261021123027099003|261009223027099003|261026121527099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	w7M221V4pF9Izfqc1P2SoT/zZxigiCoQ9O+9uxBANiI6xirSBKey+bfgOyFGd7++4cHJTpiSFK7n8Id9A/X3UnyXCewwHxqw53YxxzQ0+5wMYHmX1+/f/pXKI2hk/qUs6yK+bIQRLXPNUs81S1NMRjW8HNFhwhEm9Uc/ve5IAu/jbVqt2N4jm7q43M6aMEsAg5gT9xoNk+Rnj9FCL93yfTL40JGmvO8CclCr3MzMJTG9AGFiO6T3TpBYQbuaLCJ39K3RD3x54ieR/gidCJAKk8r3Sscm0mV34cBw5YgXq7b/Uysd5GTiLL8bSGu8h+aySuS612APglvSpLViPZzdLJqpvXNCpmyHolx7CoZ6V5S81BF0bEmVJsFt8HCtBDKl0NyGeYhjSpagf4fWYDzAFc+bTHltR1Mx/IsLVZ1sj9nCAbhdY09cyQgQMesf3odGGxyG3Fm5ZekFbjWlrrWTSD6FJuXfFw3HNf98EZK7Gltk5kRdLhahWge320s9fVfCpWIpEEmgxNDnfRKJ9mz1LNxa8Kwr8FooFGgQum31eZtQ5TOFTrJ79DNEiCOg6CZ+Y5nJBcMaaPWLep4xJE0x7Ga8C1t9d4QU4T1vKAEugrT3s1aGIBz7CUkRSIDaaAnKc+rKE5SHGpCbbJHTepuhLh94OU5myFCgIwAxgrfB0q0asrfVmMRpCZPIfkzJ/5Icd2sAu6+TFEQtleK7UbZSpg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261009223027099003)(261026121527099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	O5gd2XBW/IqThmJW7HYF5f9lcOkgO/12NkWBDdqVz+tjlyb+eFp0nBlJN5vImgYa0MelTBu3GabpwUHJsHjhdii9eqeBjLB2w0P1kU22KHOy7IDIIuniEzPXDq6FVon8TM9fhoL27rInE9LiVSOztOxnGNH7HGEwtfPnTZXCT6FrzV7bnNrr+M2zTjkAhtQ4+9PbPWjQALz1GD1Ei+MKoJLVnaKkKQ51ZVzrmGJU+7QuO5Zvxmf+LUZvjoYSNZ4eu1Z9N7e2GB0S3n/Idn4xQL+uwLQmzaJkGs6vT15mJQptnPEAZQEe2e47v+z8/mbZ9KjeJXKORFBQgiB2kXfUivLiriGmhfoxPi9pojYEMDE1rWD44mcJv9h7xX4YE0E6WWYcVY8wHjd4RbjjKmTzh4uCqJxj329JSfDu8IyyAhG/gelXvl/mkdfenxPObmiO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 17:55:01.5875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8358f08e-7026-4670-b286-08df3cf83efd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN6PEPF00000075.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454
Message-ID-Hash: ZLJCB6RMSA4N4HZ2KFRFIAXTJPSXMR4W
X-Message-ID-Hash: ZLJCB6RMSA4N4HZ2KFRFIAXTJPSXMR4W
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZLJCB6RMSA4N4HZ2KFRFIAXTJPSXMR4W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

The ACP external IRQ handler is registered before sdw_amd_probe() assigns
adata->sdw, so a stray interrupt in the probe window could reach the
adata->sdw->pdev[i] dereference with adata->sdw still NULL.

The same window exists on the teardown side: after sdw_amd_exit() frees
the context but before adata->sdw is cleared by the caller.

Add NULL checks for adata->sdw in acp_irq_handler() before dereferencing
->pdev[0] and ->pdev[1], and in amd_sof_handle_acp70_sdw_wake_event() for
the same reason.  The interrupt-status register write that acknowledges the
IRQ is kept outside the guard so the hardware bit is always cleared
regardless of whether the SoundWire context is live.

Fixes: 96eb81851012 ("ASoC: SOF: amd: add interrupt handling for SoundWire manager devices")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 86e2402b8ffd..623e016f38b8 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -478,16 +478,20 @@ static void amd_sof_handle_acp70_sdw_wake_event(struct acp_dev_data *adata)
 	struct amd_sdw_manager *amd_manager;
 
 	if (adata->acp70_sdw0_wake_event) {
-		amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
-		if (amd_manager)
-			pm_request_resume(amd_manager->dev);
+		if (adata->sdw) {
+			amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
+			if (amd_manager)
+				pm_request_resume(amd_manager->dev);
+		}
 		adata->acp70_sdw0_wake_event = 0;
 	}
 
 	if (adata->acp70_sdw1_wake_event) {
-		amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
-		if (amd_manager)
-			pm_request_resume(amd_manager->dev);
+		if (adata->sdw) {
+			amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
+			if (amd_manager)
+				pm_request_resume(amd_manager->dev);
+		}
 		adata->acp70_sdw1_wake_event = 0;
 	}
 }
@@ -579,10 +583,12 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
 	if (val & ACP_SDW0_IRQ_MASK) {
-		amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_SDW0_IRQ_MASK);
-		if (amd_manager)
-			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		if (adata->sdw) {
+			amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
+			if (amd_manager)
+				schedule_work(&amd_manager->amd_sdw_irq_thread);
+		}
 		irq_flag = 1;
 	}
 
@@ -608,11 +614,13 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 	if (desc->ext_intr_stat1) {
 		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat1);
 		if (val & ACP_SDW1_IRQ_MASK) {
-			amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
 			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat1,
 					  ACP_SDW1_IRQ_MASK);
-			if (amd_manager)
-				schedule_work(&amd_manager->amd_sdw_irq_thread);
+			if (adata->sdw) {
+				amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
+				if (amd_manager)
+					schedule_work(&amd_manager->amd_sdw_irq_thread);
+			}
 			irq_flag = 1;
 		}
 		switch (adata->pci_rev) {
-- 
2.53.0

