Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD192606A31B
	for <alsa-devel@archiver.kernel.org>; Fri, 23 Oct 2026 06:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=D02xDfW5;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=c4APwBmO
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33E2A60226;
	Fri, 23 Oct 2026 08:56:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33E2A60226
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792738614;
	bh=MhGxkHqsb4rHcJjbCffuwwyPWqH3q7JYH6AWAEFSPec=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=D02xDfW5cvXauwii0pBMVq5F5ckegDMRlSt3TtT3S0wuPyZVTQnlpE5WMZyLkZ5WZ
	 fiENIZt4Kc2NamX73zTRkozqoTPIGKkMAHO0d8OUNpqIlMjgUQkgMUbofPvtE0MFTD
	 Q3m1+ajXzdy45Y3rgnXSuLs8Elw2n0FQ6Mm3ABV8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 130B9F806F9; Fri, 23 Oct 2026 08:54:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DEFFAF8070B;
	Fri, 23 Oct 2026 08:54:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A770F805F0; Fri, 23 Oct 2026 08:54:34 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011037.outbound.protection.outlook.com [52.101.52.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D432AF8067A;
	Fri, 23 Oct 2026 08:54:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D432AF8067A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=c4APwBmO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afabtyb2zVlP4Fl4tZrzg+7L91O+K8jV6spi7AoDm4iDfKPxm6QgWhR238BNMLBwXwEQlmmDboHRS8ffS1nk4QDlcFoPMRM4h4cC+0rvJf2gNGSdlRecyH0jC4wFR+pt9MeNcn1r3R8+rFeViDjaen9F1/Z90Ckn6Rrm4oEyYZfXEbfZyBg9KMoHw3IHoAE53ptJtmxyuzXc96NzgtDS1x1HvaUpX4uvHGduT1SaVxkFziGBCkHNe7nV8FB3gLHaMVZ/34ZKmsHVMLzfgRw8oJwRxpfEXmWfE1FNL1pDFKre8t55h7ykY9Za8CwWsVDjz5mcPX99kYJY47ioNf1RsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+Ge2gz/ZBN0D3k0WD7n+CAHlDgWiAT9XThasimNDG0=;
 b=ph2r+BZ8zXDu7XIszcyz0nN3i37qpXICb5FM5yH7rTSmSUOtZ66sl/qjkNkwt04RQTqXYhWHgXasObYj7g/Xh1CJ6ggHTmi1c4Eqqjr2Wwa4pXCZRDi0oAGT707pKCSKV51SSbbz+rCKO9UBVJVs85Pahaw8l9z8aYutyfDXno+6pbrY40L9rxMfST/f5/ZNIqG82do3sRrGl77MJpzsSJbIC1657nWVxLl6sYs0b7DJrgHsAr8dODecpfHopFNTxOkAdzw24lMWKIz+lO/K1u5GsaVwYFkC6/4wLMMLQjLoENkyH9+jD4OUmKAplTTnJkHkKvgr0NJaivUpsqIF+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+Ge2gz/ZBN0D3k0WD7n+CAHlDgWiAT9XThasimNDG0=;
 b=c4APwBmO/YUvj1GxVK1rhCOaDMQw/tD+fDplzgYR0A4hxQp3/LAvhZMscMC4+Vm3TjLPYIPQcCkjkTvg1jzh8b+KaqNm5RSWmu4t9d/ddRor33jKrF2nes7ZdHHqx13VVUzho+SWYMxd5veT0pPySma5MsRChhmdtTpTuOhWUgg=
Received: from MW4PR03CA0307.namprd03.prod.outlook.com (2603:10b6:303:dd::12)
 by DS8PR12MB899436.namprd12.prod.outlook.com (2603:10b6:8:446::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 06:54:22 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::63) by MW4PR03CA0307.outlook.office365.com
 (2603:10b6:303:dd::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Fri,
 23 Oct 2026 06:54:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Fri, 23 Oct 2026 06:54:22 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 01:54:21 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53
 via Frontend Transport; Fri, 23 Oct 2026 01:54:17 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>
CC: <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
	<tiwai@suse.com>, <pierre-louis.bossart@linux.dev>,
	<yung-chuan.liao@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <venkataprasad.potturu@amd.com>,
	<Syed.SabaKareem@amd.com>, <Mario.Limonciello@amd.com>,
	<Richard.Gong@amd.com>, <Vijendar.Mukunda@amd.com>, <Poojitha.N@amd.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sound-open-firmware@alsa-project.org>
Subject: [PATCH v3 12/13] ASoC: amd: acp: add SoundWire machine table for
 ACP7.B platform
Date: Fri, 23 Oct 2026 12:20:48 +0530
Message-ID: <20261023065216.3473883-13-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
References: <20261023065216.3473883-1-Vijendar.Mukunda@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DS8PR12MB899436:EE_
X-MS-Office365-Filtering-Correlation-Id: b080ba56-ff65-4a71-6ab2-08df30d2782f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|7416014|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|261009223027099003|261022075727099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	RFy490n+vNhCBXZwvv97hiUbCCnoGdBGvyFiLTNGdN0Ml6dlS90UpMNsdlGlM4QNsBx9HVfw/a7fz5g01acgPF684T8iNtDZKl7mJrOfgJCewM/MiO6QAKnXbf02NUsecGR3tMl/JClA6YdTRjywOj/z79NGg2I515wTEuzIHyjJ9IVpBYTAski2MaHkZLjrTH85WL1KLGSveLWgyExZ6gGvp2ZUGqntmVPWjKV6TyIfnh8Fv4wi2EaZWmNbq7wjD5Y2xxkwfZTEFvI3YG+xV1xX0Pd9AoNuUEtpSBfPi31XKBfLso6ZP3AJVv36KH8n/zrCqu7DQHtTmm/KAgKIbIJyXsTnGojts5OT+W+9rI1eFokVI8YKpZ4Mdm1BfL9VGUe/MsMdqVlp1hZCSvRhCJUnVReN2+DglZCDvfCmJm1Lrvp3gREErI/M2bfyWQ1kGSCvJfREXiMhvnKBYP8puj8p01Sjw5JjDPX0hzUDuAwHmJyB+V4A09Mn0Ki7dwVmzUD6Rg2qmwmn60GWIICW6H3EAsQqU1RtysW7BcOX0bw51iXnRXhodF25zE4pEOKvf4hvTeQqtpqhuYe+qEgT0Rr2U1QYpYRB2BbFriYvD8c/4Jj4KXSAf+uUlm6fjYB5NVGUbQExuIoY6aQVPwHKolAubQwkElGbpJMWiRmQSz/LKMXbjNEOytYWDy9m/l8CmPyfhPQA9Pl9lyypk/epyQ==
X-Forefront-Antispam-Report: 
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	guR3YLacb0a49BIIretAsF9OL9SqB+WDBe4IYJOyxz+EnU73/ivCpOsWgKsytHuUKP/bwt7qFxEmCJ4o12SIRH+koC92q2aHHMyw240TGbspcm/lntaE+eEd0GuV008v6Aqya69nDIio4Y+yE7so+xRxaEUpfNhienbH1ZSs6mpQvkyJamCWbtiYYyVg6wGeqOXumtUWiK6H25BPzT97CctJLrZioONKqnTOmcdMFSQiCLFPgokR3HTCTOb0oNA03fbJYhbnQvIw8tJOaIFzLkMJT0UZLqw+cQyAiFycBcqNQByLTlEhGJpu1QUG7U4IadYd1Q3R5tQB/cnj4h+h3+8xtznhy2ANkY6+MRTTzQsanAJ4xIspFgJDuVb7DpJRg4YOqFEOcSf/wCkHwSwl3mGkoryjXtuGvFoNsgsx6f8tTrVD7R/dj/Anr0IQDIC3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:54:22.6169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b080ba56-ff65-4a71-6ab2-08df30d2782f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS8PR12MB899436
Message-ID-Hash: MR3E6WTSNB5IHRRDPQUGTZ2ZOROZSRUC
X-Message-ID-Hash: MR3E6WTSNB5IHRRDPQUGTZ2ZOROZSRUC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MR3E6WTSNB5IHRRDPQUGTZ2ZOROZSRUC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

Add snd_soc_acpi_amd_acp7b_sof_sdw_machines with one entry for the
RT721 (L0: jack + DMIC) + RT1320 (L3: speaker) SoundWire configuration
on ACP7.B. Export the table for use by the SOF descriptor.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/amd-acp7x-acpi-match.c | 12 ++++++++++++
 sound/soc/amd/mach-config.h              |  1 +
 2 files changed, 13 insertions(+)

diff --git a/sound/soc/amd/acp/amd-acp7x-acpi-match.c b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
index 2f5e060ec79b4..830c59966a356 100644
--- a/sound/soc/amd/acp/amd-acp7x-acpi-match.c
+++ b/sound/soc/amd/acp/amd-acp7x-acpi-match.c
@@ -148,6 +148,18 @@ static const struct snd_soc_acpi_link_adr acp7x_rt721_l0_rt1320_l3[] = {
 	{}
 };
 
+struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_sdw_machines[] = {
+	{
+		.link_mask = BIT(0) | BIT(3),
+		.links = acp7x_rt721_l0_rt1320_l3,
+		.drv_name = "amd_sof_sdw",
+		.sof_tplg_filename = "sof-acp7b-rt721-l0-rt1320-l3.tplg",
+		.fw_filename = "sof-acp7b.ri",
+	},
+	{},
+};
+EXPORT_SYMBOL(snd_soc_acpi_amd_acp7b_sof_sdw_machines);
+
 struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[] = {
 	{
 		.link_mask = BIT(0) | BIT(3),
diff --git a/sound/soc/amd/mach-config.h b/sound/soc/amd/mach-config.h
index 321af4682fd30..09ea9f5259557 100644
--- a/sound/soc/amd/mach-config.h
+++ b/sound/soc/amd/mach-config.h
@@ -29,6 +29,7 @@ extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp70_sof_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_machines[];
+extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7b_sof_sdw_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_machines[];
 extern struct snd_soc_acpi_mach snd_soc_acpi_amd_acp7f_sof_sdw_machines[];
 
-- 
2.48.1

