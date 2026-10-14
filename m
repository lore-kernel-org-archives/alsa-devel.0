Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEF6CC6B1D
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Oct 2026 10:12:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 92BDA6023E;
	Wed, 14 Oct 2026 12:12:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 92BDA6023E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791972772;
	bh=UGPSODMEqvMHjVe8T9rHEXyn8efUIfQVQtVbB9lQ7A0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=DiWGsqT9rg043n7SSLFndGutL/6m5OWG9IKU+wLmTCTrRCk1ediSpDcDVZ/Sdvu8w
	 oewHusXnhQCeuiMaGkBrazvsN4u4Q7DkCHKBBUW2qKMXGPpJlUr2i3WwNVCc2oOEpc
	 LaqZnDPcbt/fO1PIBNXJDWjx7aAUwLOqfxm2uBAo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6F8F7F806F2; Wed, 14 Oct 2026 12:10:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 50B83F806F2;
	Wed, 14 Oct 2026 12:10:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 07662F8065C; Wed, 14 Oct 2026 12:10:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.55
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791972637;
	b=S486YpQEmjhGalMq0HwFgJKc8a0czXOguRHCsO5GwYPComO3rO4sswnK4By82/JhXAJF
	 gKyDcLGhmfPkSQMQypfPHCV4xYPq0m2mf7eSFtA5hZvf0bqG7G8aQYJMmrUhbkKHt36IT
	 0iFt7RHHmWijAu9JU8WuMWl4JnrLA6a8ZMg1KeL6YhQpwq16mADK1fX970EVYoRcmF+su
	 6L9HR34BYS8R9FywS6F6VfZzwUQH//cUWRjeRqvuEf0irTs/VQLgFYbgX6WK4AIns8f/d
	 GXL8CcGr+mEUARkQVkNYK4WMbAzXPwGuy+ecwOHAuS0wQBmb4JlmRFyxxEeyVXXwb4w==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791972637;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UGPSODMEqvMHjVe8T9rHEXyn8efUIfQVQtVbB9lQ7A0=;
	b=b1w+Yew5GVfGHXyeL9AN32O+eFCp6Qr+lPU6B6zxW+otVzRT+GKoOrViDiQQMiKEbqqH
	 X4EtnEIhp92jgqiAPiVmDyrXMxQNe/1ImqsaEF2tMI8F0BcbQy+8Rh9Mq3/ymEyQl69B6
	 KucTv5CLGSQm/DrltDJgNLAwloNUQNvhN5nG8+sOb3PGuv7INEH4G9vvooCYIYbOHmakc
	 aFS7jkTY8ejovhrxpJUHNOrbBnrTCHAaTZHE6dh30Y/YC2q/c1E/nRat4EIYE8aBr8Bm7
	 LO7aZGFb9sH0uA6Yei1bRknlY0dWACwXaJPsAMCDnR38jyd5EylLAqrBDZQe67hbbXA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ySg2df78;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.55
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011055.outbound.protection.outlook.com
 [40.93.194.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8988FF80552;
	Wed, 14 Oct 2026 12:10:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8988FF80552
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ySg2df78
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyO/7cfbXhwaYlbiNyd6rllS9lNxFtP8Tf3eUbt28PZS4k0TGRvwVyQBFGjUYVRNIGj8SHgxcB5js07ga96ZNbwtUoJWypDW7agHqhmJvNzlUrsWa4Anq29TSIzB1jYdb+v/aVscr3c/75jcXJ6MHoNxFV16IDKtlfUfGEvTfwWAz0kOkXc0fUPkIVUbuhoBy6XcXF6AIPUrP1LlQ9KEVU5/WlA6Qld+jRNKGRK2S4IK/0AEjVipv+ccuopmTE6tEJHtlN3EMjVpiWKYzC6Swv2AawzGy+ccPMic5KKWwmPx/Qv6dUYOOJaQoKtCDhkoJXZNuUVTcBIgstwa54075g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11FRGgznJc3+c3Z+wuqaU2nTfXf9Tkn3ciKswfRY0xQ=;
 b=yQheVuveCimX3tqW3/7CIYbnoXTTfaZ51pX07FIfJTM5Bb6jGQKUEvFcNb3MpdCsTzklNTDyS0Br7fP4k9CC3qqUVr77sq67i130TyNGtj0cntLqht6C7F4JxRzqaNnl4u1oAhvzxLLmoI9u2T0MnCW0z1R10PrEeYMrhxQl8ZQ8MgzxgfoUImIjXXDaHLC4Bnnk/ST9iyYSpthbBZf2BKmJ3pu9dweo/D4ywhd81a1jCkWVgLTBGYZy/ixSGuobUjXg+/0YTYfoT9+Kg4ohSqwUJivbed2NDncRhcxEIcFe524Iczxohjcs6khGPCoK4jzSd4nrH8PqQ/c8KpH9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11FRGgznJc3+c3Z+wuqaU2nTfXf9Tkn3ciKswfRY0xQ=;
 b=ySg2df78V0eO1lNFkoZ4Mvjr8SrXh1usbjQFivbs9BMf3bkifmwQliJDI+dh7yBJFU++ddIZi6Gm2h6YoA6IvnqI+y/ASnncQ53vsJ63t+0BLMSxCqJUMCg70gNrc7YdHZus0mSPk3gy8GEUyWvbIXFkuTwGo49Iy/QMk3NkesM=
Received: from CH2PR14CA0052.namprd14.prod.outlook.com (2603:10b6:610:56::32)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 10:10:27 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::ac) by CH2PR14CA0052.outlook.office365.com
 (2603:10b6:610:56::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 10:10:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 10:10:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 05:10:18 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Wed, 14 Oct 2026 05:10:14 -0500
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
Subject: [PATCH v2 05/10] ASoC: SOF: amd: Propagate PCI subsystem Vendor and
 Device IDs
Date: Wed, 14 Oct 2026 15:29:13 +0530
Message-ID: <20261014100902.1215212-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
References: <20261014100902.1215212-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 7092b208-ebf6-42d0-486a-08df29db5ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|56012099006|11063799006|261009223027099003|18002099003|10067099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	CN/UEuWTkNKQw16dXEv1U7DFKbD1/Me5eaupNu3l8oFYyz3EXXXHYNeRX8ZZILKC1I3Gzyr69yEndROwmXDQGDvIiWq8ILOaAF6Q6d8oHkgBa6cOFhV09/7kPClYLqZ36kof1l8o3hAw0G6seKzWqiPbwpqnws7LN2ulM/AIaqS4FEDTFoGwLeGqAk2rk4cRztPR3pPe4UwX4aYg+vcjssqT/pW4MohQd6CRtBg6qpwxrvdleaKpfEVzYnBFeEpR673GKmL+5OoJPnc1oZ+ti2f3kUl0cGQOvdg53XZH6ewY8Sehy/Ujml6GrnD9buqc6ox5M3t3W6Kb8+wT/Mh1dqAL8U5R3BclHByBzQt0ODf2GS6YbBjpxcfhcUoGsAvhMxjLmQua0QeolLVZwZr3LXDM5fnYY36V69BqjM2ar+AxcvtshxnjrcqW0l++w9gJgPFNtlyWa+FPsUXhO6wF06GeunSC3Kw5QmvVv8FnH670pU0CXFx68n/uCc0XAnAH7kpnBbmi+sdEjbgx0qTVihFeI+/UbmZ2PSV+G5av7TpgOD+9lfPh0T4UPPaXWIoGTTMzJbJNSWcAJPFrU6kIEkg+JhNAtUJF2JVCs7s0R+nEv7IIowipvAtdut6qIkRgWR1ndlkyxwTN/6HWXiv/2vGyS9+LUbv74KIfvsWCvpvgTMnxi2xcxR4PDMNuxRcDNs7zv5p5cM4+DBJjVbJTAw==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	aVao9trvyyDoxJ+/YCr7BC+Xk/WQbPbjicEVboF5uiR5DwWqoK0CG155Ku57ulsGTb7t1SBVUR9CoxC93E+5PNfXMIzCJPe50HnYegx4q2M/1vkuddqFf1S1wHCcghaKF1yI/MgKrWxDA9fiaPQTqERLm7oON1zDhO7MC2MAxPWtxvvxTuP56KZWiGr1+/WV5CAGgkyMV4V2tmrfBludH3o0c9kTQjPhPATSpXElaMl06KmFD26yRKKa520XegBwa+TRmEGcg0odgri4wEfaJHzNJoCFGHie4fLXQePEgHf8zaxqf4SeVpmjMH+u1tT15kKEiBljf5Fhlzay0dAgW5SjcFH1Evv7YK3pg18rDBKut/9op2ZFJD3DqjA5e0hGC8L2t3+mGATRftLEU7x3KnzYtkX62tCdfbYjAL4BBIX9WeJhXCYy24rs/ALA+ntv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:10:27.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7092b208-ebf6-42d0-486a-08df29db5ee8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787
Message-ID-Hash: ZORIPBQQZGRGKFYUCMQJDCN7PAX7KMRC
X-Message-ID-Hash: ZORIPBQQZGRGKFYUCMQJDCN7PAX7KMRC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZORIPBQQZGRGKFYUCMQJDCN7PAX7KMRC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Extend the AMD SOF machine driver to propagate the PCI subsystem
Vendor and Device IDs so that they may be subsequently used as an
SSID. Store the subsystem IDs in acp_dev_data during probe (both
amd_sof_acp_probe and amd_sof_acp7x_probe), and propagate them
to mach_params in the SoundWire machine select path.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-common.c | 6 ++++++
 sound/soc/sof/amd/acp.c        | 4 ++++
 sound/soc/sof/amd/acp.h        | 2 ++
 3 files changed, 12 insertions(+)

diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
index 33540f7c421b1..60e5c851c8743 100644
--- a/sound/soc/sof/amd/acp-common.c
+++ b/sound/soc/sof/amd/acp-common.c
@@ -155,9 +155,15 @@ static struct snd_soc_acpi_mach *amd_sof_sdw_machine_select(struct snd_sof_dev *
 		}
 		if (mach && mach->link_mask) {
 			mach->mach_params.subsystem_rev = acp_data->pci_rev;
+			mach->mach_params.subsystem_vendor = acp_data->subsystem_vendor;
+			mach->mach_params.subsystem_device = acp_data->subsystem_device;
+			mach->mach_params.subsystem_id_set = true;
 			mach->mach_params.links = mach->links;
 			mach->mach_params.link_mask = mach->link_mask;
 			mach->mach_params.platform = dev_name(sdev->dev);
+
+			dev_dbg(sdev->dev, "SSID %x%04x\n", mach->mach_params.subsystem_vendor,
+				mach->mach_params.subsystem_device);
 			return mach;
 		}
 	}
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index b059039c9e0d1..71c39eb36194e 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -1198,6 +1198,8 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	adata->addr = addr;
 	adata->reg_range = chip->reg_end_addr - chip->reg_start_addr;
 	adata->pci_rev = pci->revision;
+	adata->subsystem_vendor = pci->subsystem_vendor;
+	adata->subsystem_device = pci->subsystem_device;
 	mutex_init(&adata->acp_lock);
 	sdev->pdata->hw_pdata = adata;
 
@@ -1335,6 +1337,8 @@ int amd_sof_acp7x_probe(struct snd_sof_dev *sdev)
 	adata->addr = addr;
 	adata->reg_range = chip->reg_end_addr - chip->reg_start_addr;
 	adata->pci_rev = pci->revision;
+	adata->subsystem_vendor = pci->subsystem_vendor;
+	adata->subsystem_device = pci->subsystem_device;
 	mutex_init(&adata->acp_lock);
 	sdev->pdata->hw_pdata = adata;
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 1bc6b572448d8..929251772526a 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -296,6 +296,8 @@ struct acp_dev_data {
 	unsigned int pdm_sel;
 	bool is_sdw_dev;
 	unsigned int pci_rev;
+	u32 subsystem_vendor;
+	u32 subsystem_device;
 	int acp_sof_signed_firmware_image;
 };
 
-- 
2.48.1

