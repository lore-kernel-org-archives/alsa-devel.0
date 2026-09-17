Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1912EC88E72
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:42:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2220460240;
	Thu, 17 Sep 2026 10:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2220460240
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789634548;
	bh=ZtbntJycbmSbN6o0sZVzksLKG5qXW2LBBgQv3q0WiPQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I2VcCAhLQgBIovL4wufBZcsmgUMWoZBKkalSldoZygtTo0FnN10HA+55q5W1cX9vs
	 ympH2NjsodUDIu4IX2PD6pM/SVwykB1AFBKyw5dCJTD6XTTx/HrCzAwTKfeVK2DEpy
	 EUsmVme7aO165acjzCNqlk4PnJPqinongk9E/+MM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5CF24F80616; Thu, 17 Sep 2026 10:41:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E000F805EE;
	Thu, 17 Sep 2026 10:41:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 55FE9F805EC; Thu, 17 Sep 2026 10:41:20 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.15
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1789634476;
	b=FlCH/+8WtD7Wd0LafJ2IvU1NZ7QdMqLqxiLKLcr6/nMAurrdF7rBpf3XSgnYvIboU+Xr
	 Ru4iavY1Lpk+dqS3OTYGe00MtHuzW4zpE3oU0v3Dr7YVtQbU3ofnY2Beuw2Z/Mm8kS8wI
	 NOaaBqw55p1pFlmTecjZXZlzmJ5P9lB+V4vbJtPwVltQloRwsdELDgIEh+tD8PtJUvZG6
	 rdyC/TorsCCIOd+jVlYcYFLRoJGAf8mMMeWW69S1i/PTV9G0B49ujHIQb3bzd5sDiUXxz
	 aGNZj7eb4WP8ivOex8q8Hw7iL4UK9EJX/dEOIfm4JowccKUjle65+V+S0ef/lAXwnUg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789634476;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZtbntJycbmSbN6o0sZVzksLKG5qXW2LBBgQv3q0WiPQ=;
	b=cLTzBgyajLKtUBQ5OK/cnjzXjzNc+AtWVIKRvh0z10amlrSh6Xl82lWCiCXVWVYGJi/o
	 FiyHUc7fHpad3IX2vGzV+xG0UMzS4kJaZjtVK3v3NgmHYWJsmSG6K5T28I6CSzE9bvqPQ
	 NJXBgi3gnUb0rewd/ICScq+4cV2foTzcxrHKcmAwxqOkz94yE3ayYtwDNOA1fh1IrBA/Y
	 kvK0FSCCIfmOf1OB1a6uQfdxuANaajVKbIRHRkecY5NL8JvJkwPU5o0KYw11RNTbdJolw
	 AUKjxUIDNHx/Xe3dpZijvlYOQNd9af+5i94SHGppbH7Hk0y0E/Do9pSnRr4GadgoaEg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4V28R9KJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.15
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011015.outbound.protection.outlook.com
 [40.93.194.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0F9C4F8007E
	for <alsa-devel@alsa-project.org>; Thu, 17 Sep 2026 10:41:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F9C4F8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=4V28R9KJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WEOC7QoC99FZZ8NQ7Pqfo1ybr/lV2PFLzS44OkfBcZ8TB8Y5hU/E8Pz1H5NasWcrQ9boeCFjx6ImByu0WHL8w3TdjQyss1yllOVQKkmqz2Vh3fGaPYUzN2aP+y0jLEWKbVmbHHqolZGvpM9WDPO4N/0B4ey1hydJkWbIBDB8FvGgMnw/DrQWKVBBIeOHfMc62tTx4WG4DX3dyN3IqjEJ0w2iVoCAL/CNOqcOmX10qWsl6QqeaynX7XDDc/ggVsSc1W75ot1JdmJlzNmV4QOjd+580sgZUmXeZuaZHgfwraqMItqhlWDZiweMxZHvEmGov4G5H6S7VOIbdW3h1ZqBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fS3oxGWZfkHEQHkHrwT/tlXhEfWx6AObVf3HmcYXOhs=;
 b=fVcK/51NrXqe0BViI3tt9ntGChMrjKmxsLBqi0XfOdBh6G5Dpbo06EiaRJ8hOwZFPupIdzmQobQV6kx9fpy88PWNCdErct516dbrvVNlAZ0eX7i4hYPH8V4X94dBCF4j+QDGVorVnITNawzmMRaXrjiJHcCSoxCyNPHcmdZrS7Qu4SgcU+BadZO31bPD91wfFf0RtEdX8NxSeSSamTZ1wkZsi/tNZL07WzxSQriBtK1edL/Qw7e1/mZa44KUPcUMRF7DPq7xRfPbKKwfDRJ/CX9CSU9tEY6YVPEkm7HKaaPA7PkTrFntS+p875tQjTPMVO1fQ2HTnOgvJfEcAjz80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fS3oxGWZfkHEQHkHrwT/tlXhEfWx6AObVf3HmcYXOhs=;
 b=4V28R9KJKBNuY2XP90vGuxMJfgZbASWkqtP1w99kO6ZOlLxXJloQHiC1IQVzYsx1wET3tq/MXvAcLOnzPUo0NcGZpak+6Zyq8z2jKPuWIfXxCi/32Q2mHPGKQLnkdFJU/ApQttCm4zXUHEa6+wkvqg5bEE6mK46aHjEGExD4l2Y=
Received: from SA9P223CA0027.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::32)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 08:39:10 +0000
Received: from MWH0EPF000C618F.namprd02.prod.outlook.com
 (2603:10b6:806:26:cafe::9) by SA9P223CA0027.outlook.office365.com
 (2603:10b6:806:26::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Thu, 17
 Sep 2026 08:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000C618F.mail.protection.outlook.com (10.167.249.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 08:39:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 03:39:08 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49
 via Frontend Transport; Thu, 17 Sep 2026 03:39:04 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <vkoul@kernel.org>
CC: <broonie@kernel.org>, <alsa-devel@alsa-project.org>,
	<yung-chuan.liao@linux.intel.com>, <pierre-louis.bossart@linux.dev>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Vijendar
 Mukunda" <Vijendar.Mukunda@amd.com>
Subject: [PATCH V2 6/9] soundwire: amd: propagate amd_init_sdw_manager() error
 on resume
Date: Thu, 17 Sep 2026 14:04:17 +0530
Message-ID: <20260917083732.3803526-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
References: <20260917083732.3803526-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618F:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 890496a7-705b-4ef9-10bc-08df149724f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 
	RGjQ89YorKGmNUxWX+ob01Hs9BS8XCuiO4dO50tIK/VVBZOn17tRONySrIvzqtDEswe7yWbbpzUCwJzxOC3ipfieUowy6pTG94BsPpH7NJ2Q76AbO9+ZEm3xYC9VaDy8J26Yu2zKVPABMUpxKu20v4/RONRMQS/lR77wTyPKaFatAG/v2VxxZcvYezRDlJraSiPRDRLWp6Kk7woBzorqQVDkQCT9OQqtfGNI3hBFA4stjqVPuTzq2Eqs9AysvQh/Ln1ZSoZkii0NjL4kCdtyZU8WTaN84wd3Pcs35P4O7uOKAC8npCROAipv22GFZgUSmMifYGU/oynfkxtkV8fBhsTq8Pm8IHvmhg3BmHKib/ouwZcr26ZgH0bYdF8sLCq+HeHk5fGVjPe60otWmYLRqRO/KrAxgP1FIBJV8RB/Z+LN46z4KYR729DB8KHuNO1Ai3kfrNBDVjECZXOLdDRsOsLSD1wh+LceZgM5ccoEv9bWFjhyMUef8oHk/onJzrOqxP6J8feIyQ77HVsIMXkbDRnIc9Oy/OLJUJXjqQQKxwGrPN8n0kLMCIDqVsPDWIoolVbqr1c9kK9pgmZhac1AA3hOBU6c5PIWTYFudd2/h1DVFEaREh70Fgr/s2uJtCsTv0Re3SkbdtHztxydDWofDy5jOpjDyyqBNuQF5bHy4V2ybvf6OLUkdn5TqN4+HFR1SG2JYE1bX76EDFOiunCbWg==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	OCSQ0wvAHnFUDXxpbKrFMxOpi/zwMdyjpdtP89H7RcMvhlSbX1tZIHcHWRy7ZW0Yiudt8gl7MzUYYjjX8irgTOm7osdfvQbzPXYGEUpfo3UTCxQHCCLPLBuo99GwnCKqSBBUhfGTCeypk6kArixvNfixQcfvt93J1YhIbM4ThVa25A8/sgKDrRuOFD5aLRn48bG+oNoqJU29RNSr/DJvsJtatA6bnyYTzJww4xuZVvzI6n1cglNCZGvXtECOia4Ag43+pniu/DgshqlpRcZvYi2tmHkbsUBldM/85C02/U2oZ2OjZcqxNPou+oHkEzNULVGtCXNFWl0r5nvlS4xU5BpVSUCA51kboDssU5jC+0uKhwxhh10Z0/wcsfdgJqOcM9XUZ1QRpKmNjhVf5AvavW+iex0nNLglHetH/Q52QCGVyL+FTiOU2nKw/B5aZGh9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 08:39:10.0857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 890496a7-705b-4ef9-10bc-08df149724f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000C618F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969
Message-ID-Hash: 6NAEIY5Q3A5VGQEJD2HKE6F5YK4AV2A6
X-Message-ID-Hash: 6NAEIY5Q3A5VGQEJD2HKE6F5YK4AV2A6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6NAEIY5Q3A5VGQEJD2HKE6F5YK4AV2A6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In amd_resume_runtime() POWER_OFF_MODE, amd_init_sdw_manager() was
called without capturing its return value. The function performs
hardware bus resets using readl_poll_timeout() and can return
-ETIMEDOUT if the hardware does not respond. When that happens,
execution fell through to amd_enable_sdw_interrupts() and
amd_enable_sdw_manager() on hardware that may still be in a broken
reset state.

Fix by capturing the return value and returning early on failure.

Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD SoundWire manager driver")
Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 drivers/soundwire/amd_manager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index bbe1e73ed255..2d2f628230ee 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -1456,7 +1456,9 @@ static int __maybe_unused amd_resume_runtime(struct device *dev)
 		ret = amd_sdw_clk_init_ctrl(amd_manager);
 		if (ret)
 			return ret;
-		amd_init_sdw_manager(amd_manager);
+		ret = amd_init_sdw_manager(amd_manager);
+		if (ret)
+			return ret;
 		amd_enable_sdw_interrupts(amd_manager);
 		ret = amd_enable_sdw_manager(amd_manager);
 		if (ret)
-- 
2.48.1

