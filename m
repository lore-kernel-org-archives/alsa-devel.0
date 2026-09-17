Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C41C982D0
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:42:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E999260240;
	Thu, 17 Sep 2026 10:41:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E999260240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634525;
	bh=DqashJMrQX49tCkDDmSpfSNfdAdwDr3UHYDIG6k0Dbw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=CfQZUzoKr/qIHEDEK19a6mzlc9ygb+XWlDTs23jb4hsE2IeFyTk/f6uP1WLjLzJME
	 G52yPUYKG0Mrho0scdMmeAptgowrY1GP38vd0dqQDGK829RqYhwobPsPKEspyKAH/E
	 VbXt/V+wVtdVWYXqRpMb+oDjR9WL60/1qNn5gZ2U=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D525DF80746; Thu, 17 Sep 2026 10:39:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D2D72F80726;
	Thu, 17 Sep 2026 10:39:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A121DF806DF; Thu, 17 Sep 2026 10:39:38 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.58
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634374;
	b=KG2ffLjryyB5r+ou+D61L65KSxVH7wMyo6ykWppiDW8fV6wnA+BgWT5l7KA6Aeb5m1Bu
	 OmcptE7mo3XoiPVRhscTwQtLn5dd8uCJe8CKufPDh941FCol5jkEIFkohIHwDc+gEeMJ3
	 tRqD8QeLrKcQvye5Uvhvknx/DgDQN43C+3zKO84HVnpXB+MXFtwI/VLm3FSmi7a2xl/Ck
	 pbZsODFruqsaECgucNGuxMwPgHZpWJuh/a6AIJ8+yE5mWN/m1XHUEfVSE6khfI4rxf8RC
	 1yuIIcyFxfZQaqhcd6nyV0TKSqog5GQ1qMCKHX8xIMRI2QdjDLPtpriubZJgdoC1GdQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634374;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DqashJMrQX49tCkDDmSpfSNfdAdwDr3UHYDIG6k0Dbw=;
	b=ar5SawO73P/aCZLtfKJCMNltQWdC6lSoSdwaNrYlrOo+/Ce5OS65daf84Yhmr9l3EQ19
	 YsoZFMB5yClcK/nqBJBLo03TJ5FBV/SKC9pBq2TBNkJG22XKLVhbFzrb0PeUO1No0WVrt
	 rhrsefTCM0s04HAVXtoaS+nThKjh4RrvhaeU7IE7GcN/LLyoLo8Zpu+U2fvc3kbX36ZrI
	 uJKaxm8cPVhwxfJeo4JmGXA9+UvmkI/XNM3xm1i7WJH0/fqWQKTAxkUIY4Jr5+SVn+paQ
	 rb1c+5P22tEnaOvhwOCCUDNzwyWitEWLxzVLWATsyFzsdCIHeqHEq2mVp2xFh7xnRdw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b="NW2k/Y5h";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.58
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010058.outbound.protection.outlook.com
 [40.93.198.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 068C4F806B6
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 068C4F806B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=NW2k/Y5h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmtNsi+TJjKpTZf23YRgenJCO2gexWWYQO5YEHRlT4tLlTsfBMdRWxChrWzOXymUQeVGtjv6XSuIGb1UmRc11dxISby7Z4KJIKgzKGPT2HMkmgFYWpAKUA/Lwko6BF+91il1XTmTTIBkKdyp3p71TNP4eC1ljH5saMl+dA13NFt2NZXUkcGsOaeJfOfEYOFMzVjzJeNA+EFrjwlh2A1iltGtA1WPir95meupmlBMJIPyN45n73lvIa3TJ/U0+LmoIaxJC6X0+k0js8+31k9kEtqzITWmZ+VeTy29HKn6AMAJ4lEoY1pe0jVCz0PEsWuZh8YrTJOkjgb/cLv0KqXXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKeHN3IJ2uXIWj3bKKfuPjV7ploK0JTlIbpwvQf9FME=;
 b=iTUHOF22FzvuclAAGd8cbiq4kU0+DC6UZGoofnNQk+URo7ExUxygoN7YGpsXR4Gxn274wxy89vQKKUviPq+sZ/9YUkTbhP8BygvbqcJezcqK90N6bhtV+7fN74u8TW/a57ZKPgKMbWCFa/7cbtBL0euj85GVX7S7Ja+KgLchRNvl7hfjw87aCCPGxDZeZp2pjpWngicXAVL99OOUC5TAVTnZMV8kUon7jdwfTlsDhkddnMfUH4EmRMGwevWOrvw7RVpsQQVbTPJORI4Sndj/aYeJeavaVyGMnOSFdwQEBoHrWIHy3XefYM9doH2PjBBwM1TDuEsFWf+NqnbuEdqFmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKeHN3IJ2uXIWj3bKKfuPjV7ploK0JTlIbpwvQf9FME=;
 b=NW2k/Y5h+lSFZ/bR2vTrY5+Noig1Zv8DyUHDOvKDfdo9H5VfJoVK8sSyJNjcEoEGqdRpDtevKXd+idNioUOg/T+M6cwRR/BfMGSavHW7wsOwYFBRrxLh1MPqREPZGtQG32TR9xV4mpZxKfKRQReZYiC2Aer4outREfTHfhlZK9Y=
Received: from CY5PR22CA0040.namprd22.prod.outlook.com (2603:10b6:930:1d::16)
 by IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 08:39:21 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::a3) by CY5PR22CA0040.outlook.office365.com
 (2603:10b6:930:1d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 08:39:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 08:39:20 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:39:20 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:39:16 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 9/9] soundwire: amd: fix interrupt gate and work drain
 ordering in PM ops
Date: Thu, 17 Sep 2026 14:04:20 +0530
Message-ID: <20260917083732.3803526-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 15d64c83-9014-4c74-258d-08df14972b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	6npDY0dxzf69dcyq4PrTGoKiZiMY25J5v7cHqi57EUbyNCBpJKqRIBdu1/+WD+vrxGqvdjEUEGfeZToCNXNBY0N9bfxiYbHx1t8GzLkkhpvyGxwmY9MghWKbHu4MDj9ThcV140pLydokH9SiaPi4CqjIfcH6oZ297oSB23kdiwNMOCm3Sn28x9zrYZrc8hUCEB7k916zIowopqDIV1QhHcpMSSyIx0ouBNcRU4Q/1XLTde7FapOaz+mz3jCopIOVUPN6ITwg5EH7fmavmpMwowYJnRjRGfiDSTYz2vmhe9gGNldCvzKXNYAgPG/+mIMQflYXtVrUssLyMeMWdtC2uBHhhum8G4EWso1W+WkfVl+H6vnGEQYypXjDp+gcCnUAndNm4edTWiRWFVVOUWxr6Ozz7dMHtuBSsqwkUpoTXExznE996F/XTDSCdREnu7eD8dMN0gqQ5vAdCOo22MoojUD8BBfbdJicWYuzp9HuCFNrYCu3VJ/WauWQBNhHnv+35EpxA/d5HTCRlxLCp3o5dpfl/mLd21hKi9NdkXEmmo3wqgahcDyDPdY0dvJcH29Knoy5DsJqlJ1BolLQ/e/GHreNTzmPDODtxQhi5wWnG3P+Uj8MYkjLAt8WKi4fVLCmrXTs/XiGd5xblnSNNqLBs8YyAIYPO33UAYIIbZi19lyZhzC9xlFcmj++QotrauwpgxKuK0gmmeOSi8NyzSL0kw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	obKQu6kPaOXnyzj+wy3A2M0nKCK1HPXAroyf3BPyOYHW26QbrFvPI7vUs7c6Z+5sd3kWY+EBNEZlYNFXI3hP5nTwRCwQcbQUpEJKZ0SkunAsCNOzDZDP6sOM2aPsLT/Kc4sD3ZWkohupQ3XNeBbLDwxmjdbrrPc0yFV5aCEaQ1ZhjYf7dFpUBEna4TOQPXjU/F2JIudl1Z7ADejuePFxwxeIu9y9ByEihqA3jbD7riUs235mmfZL/8pJky8OiCJgBAbV+dU37TEGD7d4UeKawPqhD1FEga3ppoGRykVy4czGJ9OA8y4Gsz6hG176Gnwv09Tsclim7l/xIg3XlmgwzRx431LW/5fDas8MunA8CKj7igOkWoZU2aLbZdSZTvMm2H+wgX73DtiUIeylmsEoC3vfMEwYxV2WaWWzbQXwSPIjhVXVsUQleiK6KrSB9nNf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:39:20.8987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 15d64c83-9014-4c74-258d-08df14972b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
Message-ID-Hash: UWN5KE74TMUTJY2PULY6CM4XQNTFULRN
X-Message-ID-Hash: UWN5KE74TMUTJY2PULY6CM4XQNTFULRN
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UWN5KE74TMUTJY2PULY6CM4XQNTFULRN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The CLK_STOP_MODE branches in amd_suspend_runtime() and amd_suspend()
did not close the ACP_EXTERNAL_INTR_CNTL delivery gate before draining
amd_sdw_irq_thread and amd_sdw_work. The ACP PCI parent driver interrupt
handler dispatches SoundWire interrupts to the AMD SoundWire stack by
scheduling amd_sdw_irq_thread. Because the gate was open, an ISR already
running when the drains completed could re-queue work after
cancel_work_sync() returned, racing amd_sdw_clock_stop().

Fix both suspend paths by calling amd_disable_sdw_interrupts() first to
close the ACP-level gate before work drains.

In amd_suspend() CLK_STOP_MODE:
 - Add amd_disable_sdw_interrupts() and cancel_work_sync(irq_thread)
   before the existing cancel_work_sync(work).
 - Call amd_enable_sdw_interrupts() after clock stop to reopen the gate.
   ACP remains powered in CLK_STOP_MODE (only the SoundWire bus clock is
   gated), so the interrupt path must be live to allow wake events to
   reach the CPU during system sleep.

In amd_suspend() POWER_OFF_MODE:
 - Add amd_disable_sdw_interrupts() and cancel_work_sync(irq_thread)
   before the existing cancel_work_sync(work).
 - Remove the redundant post-clock-stop amd_disable_sdw_interrupts() call;
   the gate is already closed at the top of the branch.

In amd_suspend_runtime() CLK_STOP_MODE:
 - Add amd_disable_sdw_interrupts() and cancel_work_sync(irq_thread)
   before the existing cancel_work_sync(work).
 - Call amd_enable_sdw_interrupts() to reopen the gate. ACP remains
   powered in CLK_STOP_MODE (only the SoundWire bus clock is gated), so
   the interrupt path must be live to allow wake events to reach the CPU.

In amd_suspend_runtime() POWER_OFF_MODE:
 - Add amd_disable_sdw_interrupts() and cancel_work_sync(irq_thread)
   before the existing cancel_work_sync(work).
 - Remove the redundant post-clock-stop amd_disable_sdw_interrupts() call;
   the gate is already closed at the top of the branch.

Fixes: 86a4371b7697 ("soundwire: amd: fix for handling slave alerts after link is down")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index 0cb5f4694e9a..1a252a81269a 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1321,6 +1321,8 @@ static int __maybe_unused amd_suspend(struct device *dev)
 	}
 
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		amd_disable_sdw_interrupts(amd_manager);
+		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
@@ -1329,7 +1331,10 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
+		amd_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		amd_disable_sdw_interrupts(amd_manager);
+		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
 		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, false);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, false);
@@ -1342,7 +1347,6 @@ static int __maybe_unused amd_suspend(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_disable_sdw_interrupts(amd_manager);
 		ret = amd_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
@@ -1377,6 +1381,9 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		return 0;
 	}
 	if (amd_manager->power_mode_mask & AMD_SDW_CLK_STOP_MODE) {
+		amd_disable_sdw_interrupts(amd_manager);
+		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
+		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
@@ -1384,7 +1391,11 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
+		amd_enable_sdw_interrupts(amd_manager);
 	} else if (amd_manager->power_mode_mask & AMD_SDW_POWER_OFF_MODE) {
+		amd_disable_sdw_interrupts(amd_manager);
+		cancel_work_sync(&amd_manager->amd_sdw_irq_thread);
+		cancel_work_sync(&amd_manager->amd_sdw_work);
 		amd_sdw_wake_enable(amd_manager, true);
 		ret = amd_sdw_host_wake_enable_by_rev(amd_manager, true);
 		if (ret)
@@ -1392,7 +1403,6 @@ static int __maybe_unused amd_suspend_runtime(struct device *dev)
 		ret = amd_sdw_clock_stop(amd_manager);
 		if (ret)
 			return ret;
-		amd_disable_sdw_interrupts(amd_manager);
 		ret = amd_disable_sdw_manager(amd_manager);
 		if (ret)
 			return ret;
-- 
2.48.1

