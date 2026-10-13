Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACC3CC6B16
	for <alsa-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:51:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB442601FD;
	Tue, 13 Oct 2026 17:51:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB442601FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791906683;
	bh=UGPSODMEqvMHjVe8T9rHEXyn8efUIfQVQtVbB9lQ7A0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=XtEpl94fkLxWZBHGm72LLBeQy9TtOEil4EoEcxWTTjYY5LdMI8aaae4FsgXBcQ56K
	 NgN2Trwyop6/evgYERdZZr1D1ghARLp50n+6LSC9vjuC/FQpM43zCauwrWEewdopXt
	 D4rll75BsEj3xd4D+xd1I6IbeJ9UZkQ3jDSx/bIk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6EC77F80814; Tue, 13 Oct 2026 17:48:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F041EF80791;
	Tue, 13 Oct 2026 17:48:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E391F80717; Tue, 13 Oct 2026 17:48:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791906513;
	b=mpV9ahgajjg52slxgOUGCGurZ4s5Sig3weNLQYGQ5f2SLpitavuyZT9ZxsTHjzEKoWmK
	 oPJHykBjX0hNcPJNoHNqbDMFy27t+vpsWWLbZFqAYtb3vimd6DuzbU9ubId9QpSYz8MCm
	 eOrhGdDizBFnGi3l//L/9V8twZW+/9tANkaO5EjoVZp3PgUygaXAunLk+oxa+rFDuByhg
	 wldSwIBqd8sK6CwODtaosvTdy1fVIdX7QBZ/LO365b67wBCGK8rbHORaJ6mXmpgg//3P8
	 NsQ1Dj/GcD+vRG+zqmsumT/ZbkGOiQ9gezrdw6/mWx3lTGkG6dHhL5LU0G+Hh5DhwIw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791906513;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=UGPSODMEqvMHjVe8T9rHEXyn8efUIfQVQtVbB9lQ7A0=;
	b=bw0730h4AxL4StkEQQCDN3nlo46q8/jfzBD8i2/ic64sXISk1T6e73SCR7Vu15X7oDpx
	 Wor6ROrw7d4wir3cAf8Aoxn2wTrFmgeLWd4wvAkjisHBNI+U414oFuMW/i6h7p3Cce8MR
	 IwhxJ3VPZQiuKUdFyG+17ZXELNdkbnBeorI707fyOwGLFKhSeiiGTXdBbhp8exbWU7ILT
	 J9ASsHszgdtZQBjWu1xtHNgahfUYk+A32KaucEGzgCnOZrF4Qq3EV2+217SAOZdZpdbTw
	 mcYyTGKQ9BCFg+yqh4OvXWhOiU1Y4C0DVZaWC3MrtqFbfMvmnHj85KbEYpoxdjtp9Fg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=a1jn4BEr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.1
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E28F9F800EE;
	Tue, 13 Oct 2026 17:48:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E28F9F800EE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=a1jn4BEr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l00V2+hQCL/ix9xrIT7PtZMW7gnFkD3G0kVthAGFMpgoJyaRc1/6xDHHWp78gbzeBsoC9bNEmiWdiM+fvvhYpFfQXcnRc2Zf0CG7apdjGyE1yCYnqPsotddh5UD86XE/nCblOoY+rpbf1HN22cdWT6DJAyuxxUIQ5gta3cfqKls630zUwZJXWosKRyK3nGkzBkWot4Dt/RI03wD655EeP7gKpmtj/Vw1lHY3hCLImN9nXO8VwMxe0Y342vJKDoRuBeGMJv3rqLLCJ1ek/o8noA7hYjfNsUFnBy9djl8q0S3W2jt6ivJ5mgnwx/Is0jZClfw0mhkI2YtXe+6Wrk2Wfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11FRGgznJc3+c3Z+wuqaU2nTfXf9Tkn3ciKswfRY0xQ=;
 b=WkpBBUXmndzLuiCRClFutsIAkbREEAxl+R+N3iV3y0f/Q65NBiB1ShguxV7vc9jxWVGR8IThl/gMS60Jauu27r53D3I/5+egPJv0w8pZNuwzbI0YrrfB2MTqgODP8EudEP1+kmmz5hNqrak7CGrQicuM9/vWm5iA7QaFbOq4KzEaFF7PdZG2Fyv8E/YJlaisNuIlMst9C2GvDvpmwUcSrRFmHJkOTLUXYtnKFkXJAcY5AwbKXaqFrCDI3R8K1yhjMaQTVoquHZL8bB+JxtpeDQH/dLh91KaNgBNW9JjHS7pp5S26FNQPxKJWCx/BGxhp2bKAruKGVbVDq3AdhE4tuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11FRGgznJc3+c3Z+wuqaU2nTfXf9Tkn3ciKswfRY0xQ=;
 b=a1jn4BEr344BsHa9MCpSQ0QO+PqOPrt32t4CVviUawnRxwN9ub+pnrdn+/XoPo8fs5VGnb6M8sA+DCoqypCpm69qMm3OCZhLbluEhk97ChWWYb7DehgM+2n4sNMB7CkQDbB9H7u1SAbZF871iKqvC9dFUjLQIe2quR6ssx3Vj9o=
Received: from DS7PR03CA0212.namprd03.prod.outlook.com (2603:10b6:5:3ba::7) by
 IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:48:20 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::5a) by DS7PR03CA0212.outlook.office365.com
 (2603:10b6:5:3ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 15:48:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 15:48:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 10:48:00 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Tue, 13 Oct 2026 10:47:56 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
	<Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
	<venkataprasad.potturu@amd.com>, <Syed.SabaKareem@amd.com>,
	<Mario.Limonciello@amd.com>, <Richard.Gong@amd.com>,
	<Vijendar.Mukunda@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sound-open-firmware@alsa-project.org>
Subject: [PATCH 5/9] ASoC: SOF: amd: Propagate PCI subsystem Vendor and Device
 IDs
Date: Tue, 13 Oct 2026 21:11:37 +0530
Message-ID: <20261013154644.3788064-6-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
References: <20261013154644.3788064-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: f9cf8222-3b8b-4c77-4212-08df294167f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|10067099003|18002099003|3023799007|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	X0DJzxO2V10q0guuoYDViJMXLGbVVLNjcXt/Qd1Nq52vkxrkGLcgrFfWeeWQMYFgjAAzrWW+3j1UjAemDb8V3kHM4O0DNlPt9hD6sxCzeyNtOab3cotEKuOEHWqv7ShaIwmctktcdfR5icBQE3nONRNlqtaeizjFhsL86CZN4r/KhA2PamusM02LvirGkK5izgb48lHlk3wjpXE0gGhFnQ66YwRSyeNEIfkCyY8igAUIM40FSHzzwk433+nqZ0TX1W2sxbmGcF+x6RFc3XPuFz3gbGre63HIcWAFZiTtgamAysLJgvAJqUZXRLeItL9Vyl+U4YuQfaZpCM+EjgdeeBEr5Q0qzpjX1dlTqtkeJCsrRbJPfX4JpVSBD6HZ8LJJgR7aepZ4Ep+memmjjpeia73Wacf14xJ+YQrmYZpHvjLeH8tTPKeobIL+5Hiob1B9hs/cO92EuFFvmR86rBxl4QvT2AZTol79N662UoFbjegLZ0D48hyqNvyzUcswjU68iGd87/xzjtUD0/Yo21AwO9NyuwAiJui2w/S0zNPfAg4Gx1SVhfNBPzJYCRXedgv4rHVs9mqjW8JZSz9P1BFngfX9pB4qjqHlhJIW3TYVLQNzb4Bv7HS1QbN1XtnSjLDQlZBhAmODXohraU7/czZ2DsLxPZ9Jo/r4h6FzqLNShzLLuebmdO9r6l/Cf9JM61/EYlgy6/bsdbe84uJsofcqYQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(10067099003)(18002099003)(3023799007)(22082099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	lFjUALhiYr1IuhVeh7lNkt2WTVrjYus30XNX18EBHjLbgtllNzsY7AzQNaxtBB6059DEf9IfXRo4ube0kOMf1V3LpLz+3F/6pEyPAOKXPqMxPZaYhLzQmuOoU0DG6KU1zZrE4LPH2uPXUNpu7taDMUL4ML5ijVDkeHsv3wDMC7clZ5DUvTcixrk5WyoQYD3ZeFfGdUp62U8tNm7xFqrXWKYDjxSLQnHaiKCXdHwyQEXhjWmqGqzGJuNvwaLsNqHtfvfEDt5Y/+Avlf9KrObb9CBUkLvH0Aja10PbVNQYw8emWepM0XUAj91ueeQvNUUaZUMuix4HeOf5RGcB3wc+k9P1qBXXJ1AmQ9aGF6WREX5QMAA5nCIhhVeFMAinWp2mPGMdZ8B2a3ke6oGMR/Ar2+fGcfQqSlV6bDtgYCTXsZBoEiXQ2Qaxnxvzu4x/Uzue
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:48:20.2924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f9cf8222-3b8b-4c77-4212-08df294167f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529
Message-ID-Hash: 66OYQQ3W27NFHGCR3L4XTLJENGK2KE3C
X-Message-ID-Hash: 66OYQQ3W27NFHGCR3L4XTLJENGK2KE3C
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/66OYQQ3W27NFHGCR3L4XTLJENGK2KE3C/>
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

