Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC23ECC6B03
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:55:07 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D19D86021B;
	Tue, 13 Oct 2026 10:54:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D19D86021B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791881704;
	bh=DqashJMrQX49tCkDDmSpfSNfdAdwDr3UHYDIG6k0Dbw=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=EZy4C9vyH4nE+C7epxrvHEMPD7jDqEqp2ZFKpdcd0g8TDqGHSZYi47ow4Soqhh0hR
	 HJ9WUBKsoEUBNxkUk+hEP8iDvo2rigNIUJQwxfBBMMkufIFX7hGQlDNs+ld86X3lFc
	 WLMSx4olhn+mbDK3jFGox+fQkc+AuDwxYBciZpUc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A1A0F800B0; Tue, 13 Oct 2026 10:53:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 070CDF8070B;
	Tue, 13 Oct 2026 10:53:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A131AF806A6; Tue, 13 Oct 2026 10:52:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.18
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791881576;
	b=Gf84wP57In+k45WhWXvFQGNaeucNfSPovZoQoCcvojOgxSr7dOqDx/i9DbmxJsS+PmOC
	 3XM36nz9d7syGaoAnIQxnmNHuGY9TGEg9u5aywRwJYACIIREhBHkxS4izyzkV3W3Y/WgC
	 U9F7lxLG3ifB9OyKP3VmCUChG0cZ+fpnhCiXUm9yCl3vwZVl1JXLmaTmfPQjYImY9su57
	 pWW7BjWQwkNFBDpxclmSFVzd5EvQoelk+bEadxSILBU7zf/vrN9QbO7sHUnWjOglW+Jwi
	 PNrTG5l5sN/TPfxmMFj3Yi70Oi490GNlSOkLzjLu1u/OEiz08G6+z+D3aOdSD3DoF9A==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791881576;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DqashJMrQX49tCkDDmSpfSNfdAdwDr3UHYDIG6k0Dbw=;
	b=LEExpzK5nfB9NaVAHZzhL1/bAdbrYJFxHEoBua2Ivzi0/tHGOHwBXwntgFgg+euUSp15
	 vxGeLL4Lds9CqJE7Y0fo8wC9IQcuUjn8GCdgwYRByPwlayRnFHKmu8Jy38WWsUe/RkA43
	 vVXxgdP0cLWTLWUjGo+cPHXzP83XMiz1i4IbTTkUVZtRJHLhRTNRZJUAkYNo2/ODEOGv5
	 9kLwMWOQ4ccr8TNRIXfBrx7BdDye00uZIuuG7mJVzzufoLCsweFu10OAjHRyx0clayZFy
	 bl3Q2PJfQwacLgSKoh8pF62im6e3Y8AaZY4ODudTb1gXieRRHPGoEeF3e1ZlAM6vD0A==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FHd8HKSY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.18
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B3ACAF806A3
	for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2026 10:52:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3ACAF806A3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=FHd8HKSY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgJ/umiIItkLAexSDuj7WG1JJDb/RgidMW4OyUHr8MnOCvFAdg+pvDh6ajW6KmLfE38NamJttKFtcvHjqo9pfNVON7bVJaryZCr1eUTboJTP0Rr7X1AewDwOw1i7AAHqkLEFDYlrgWRFXxPdxRc9bRI/37tV1sa7wXObA+ljnAM6t1c/JGR9uCIib+o80Df/EfyVGspoveGbv2vLf7WCVKNExAugyP5cTGjP51V+h5Z5/NfMNmK9MKG/yt+WDhYm4/LZgoCsRYrAOADtUHXH9w4Sq5xtd6z6/OpHlOszpjIi4kyEIJ9h07b7YiYfafE4FgXKRL/SzhO5674GALPI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKeHN3IJ2uXIWj3bKKfuPjV7ploK0JTlIbpwvQf9FME=;
 b=J+kJT2m81v+eTtEKi1ZzsEkX4WsqEjFNhcsZgLRliXFMR1cxHagqshVcPHYmPUhJFMxUMR7RMCmKGoGKoxtWuaHzOQdZiEYgQugB0wHR3gAza2I4OOcidH2AM3N3AsiraqZvV3Ld2MQyFOveuwYcwDjeeUauNLWMhelRmF+LgjV/NwHufdhqw7mn/740IPAC+QcIOTD5cjGFuLIwiarti6DsHuBLwL33wh/O3MCQTnc8HpXY1+rvEYbSeOmvmz0RVEMcfrUe8fKzCqmE3pvr4JhVAls9xJb92I/rFh8bjV/qOW1rsL/YKIUPiJ4ZugWLhqrIJgekds7JDy06P+x80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKeHN3IJ2uXIWj3bKKfuPjV7ploK0JTlIbpwvQf9FME=;
 b=FHd8HKSYcaEFL9Hx5cmYhN9RiK5gU7SR/xFlB+fF4mjBgIlLrQPAktGxe5O9uz/rdlnV2tYAEgP2fXmWHHizumsGAsn0o5nCPBpxkH2VFbB3HgAhf+AZjviXfgGV1zv508QmBNYiegFnurqKlA2PbKGT9S808zJvgvyjvzm2q0E=
Received: from BN9PR03CA0610.namprd03.prod.outlook.com (2603:10b6:408:106::15)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 08:52:46 +0000
Received: from BN6PEPF00000072.namprd03.prod.outlook.com
 (2603:10b6:408:106:cafe::1d) by BN9PR03CA0610.outlook.office365.com
 (2603:10b6:408:106::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 08:52:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN6PEPF00000072.mail.protection.outlook.com (10.167.248.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:52:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:52:39 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 03:52:36 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V3 09/10] soundwire: amd: fix interrupt gate and work drain
 ordering in PM ops
Date: Tue, 13 Oct 2026 14:19:30 +0530
Message-ID: <20261013085111.2009061-10-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
References: <20261013085111.2009061-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000072:EE_|BY5PR12MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 042df28d-7350-48a3-0ba8-08df290759f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|261009223027099003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	wuO84+zQY0W+zPvLT5DXW7eXoxjSJr0gavpXDck5xQBp75W/2aeynmR0nUzgKLTK3We1B4SFXZ6Lk3XQ/qSVeG5FbodEdRnYMj7Q/hBYBnhzZ8RjS1c2KH3B1Y+LJFeiOpw9MJzefICU/WJCLa2Yft5sLeXbdPvfvS/dEQIgns63mZz6/u0YshgTOahCJlicMlzQSUC99URlrPGPxrVRB0J7807IWRKaf2XHh+mtIpWFL2lh75wo5uIFtPHEliIpZdRYIr2l5kbERxHp7jz+cd/lQM1nOsHgEqyX7o4uQd0o/W63TFoBupYvPGqw3pJDFdU2hbeRAFbQBUq0pDh8lnCjDGUoChUVhAkv6JX/KV/ev/RSAn1l2AY+wqms03kpA37zTUdTHS8wErgApKDujhDVvWO7BgiTUrJ9NtXQKCSU9HluiOzjwjTX/kRdO+AQ5KA6Nt1IrpnTOMMLipP3VBegL1r6Wie8MO+Nw33aSonAiCEPlpayV9c2QPa1GifhghOEZ1pAdP5M7ShoP4Zbt7aahOhLr306cnY2azY6OsPNIBrIxYjgF1RCKMw7iNYazGXe4De8+uUsRD7i6+cTwxrs2SoumwETMSwVUDDivBf++hzVKID0zYlr7NWgUnPl6iDVZTId22XwJvxDnTg2St6UZNdhuGcLjnXpKgZfdGKarYZTP/5PrTV7VxzYABQzGXoaktlX2OjmAl6DjasTAw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(261009223027099003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Ea1RZ2UZBZnlO1SZRK4zaAPTmdwwl13rX3iQ1N9wEUrIgbNPz99SI/BXSBrD0g1N2FHqD472ejcqLDxfyg8tR29av49ZsClmQDHzb4GD2pHXBye3+m4h8ydXoKIIa0X6wQrf5KoyaHWeUe5SNLJ99QCqLtUIpM0OauoI0oe0xA9qLxFoED6UAXORqIoa80RQKwPJE6ewRX4TaOc1U4XqPPTD1FKwtGBS5BwsLB5bfcViTSdzxNS4+0KMBLjWlWFc+JGTCh5JVNKp+nvw6+06nUOW96n0Avnq72DZ5slnfIst5RVZafUin4atVKb8SiLDo69H+lG+/tDMq04UAGPIJIzic5n5jUyiO75IZlWJtsXHcJXdiD/hjcGgY3KWNx4WUr7reFjuqz8zyKaTd+7IoQaSYeyUj0gqMG09asmf2+++xvf2m7VJZ6+ESG/kqKVn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:52:46.0213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 042df28d-7350-48a3-0ba8-08df290759f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN6PEPF00000072.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211
Message-ID-Hash: O5A63TW3CJSHMTW4P6CVTY427CZDIM73
X-Message-ID-Hash: O5A63TW3CJSHMTW4P6CVTY427CZDIM73
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/O5A63TW3CJSHMTW4P6CVTY427CZDIM73/>
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

