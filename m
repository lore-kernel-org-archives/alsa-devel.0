Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19729CCF9E3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Nov 2025 14:45:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9885660205;
	Mon, 10 Nov 2025 15:45:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9885660205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1762785915;
	bh=s1N3NdUeVcoT58SoUhT/8Dkw0ocJuxYMOksUv4wzaYE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=g3DqaLiE/3kWHK4rnhckRFv23fGl8FwMZHrot5faQa3eUr7oeDThtlFmpYSeXxmwt
	 aY11FAAD3r/N1RjfnScxZwmc4BIWNFghOL8+mMnUcd1C3L704iwsmCZoAFXfNf9gFL
	 YYW2Qj/5c+D8b9IsQEnBVeuTGG0m3onddNGcwrgA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 74B71F80CB5; Mon, 10 Nov 2025 15:40:58 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EF0AF80CB6;
	Mon, 10 Nov 2025 15:40:57 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4A7E1F8051D; Fri, 12 Sep 2025 10:37:19 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0A0E2F800E3
	for <alsa-devel@alsa-project.org>; Fri, 12 Sep 2025 10:37:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A0E2F800E3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=ti-com-17Q1 header.b=ZAvK5zti
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58C8bEmj567587;
	Fri, 12 Sep 2025 03:37:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1757666234;
	bh=8z80+cxELcclVb1Sw1gI6kg3mt3dNGNWa9P08UAOgNE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ZAvK5ztiYsvS1lQT+Gx7+qMwtp6ogwllx+OC4JjgySoZqaJfZQl/q4TGQjfKtVa4i
	 ia47tx+3Van5z+zjmwCOA/U3fOf3pWTSckrMSdNfsrbL4coPEEWgBl6IwnFn9HbqVn
	 ++oAjG3jpsX0/1jhoLUs5vLgRbjT3BplYmJYt3EE=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58C8bETY1850083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 12 Sep 2025 03:37:14 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 12
 Sep 2025 03:37:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Sep 2025 03:37:13 -0500
Received: from LTPW0EX92E.dhcp.ti.com (ltpw0ex92e.dhcp.ti.com [10.82.30.14])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58C8afmD3320658;
	Fri, 12 Sep 2025 03:37:08 -0500
From: Niranjan H Y <niranjan.hy@ti.com>
To: <alsa-devel@alsa-project.org>
CC: <linux-sound@vger.kernel.org>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <yung-chuan.liao@linux.intel.com>,
        <cezary.rojewski@intel.com>, <peter.ujfalusi@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
        <pierre-louis.bossart@linux.dev>, <navada@ti.com>,
        <shenghao-ding@ti.com>, <v-hampiholi@ti.com>, <baojun.xu@ti.com>,
        Niranjan H Y <niranjan.hy@ti.com>
Subject: [PATCH v5 5/5] tas2783A: Add acpi match changes for Intel MTL
Date: Fri, 12 Sep 2025 14:06:24 +0530
Message-ID: <20250912083624.804-5-niranjan.hy@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <20250912083624.804-1-niranjan.hy@ti.com>
References: <20250912083624.804-1-niranjan.hy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-MailFrom: niranjan.hy@ti.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: RNURTLZI56IJYQMBRJJZZGT6SERTA43T
X-Message-ID-Hash: RNURTLZI56IJYQMBRJJZZGT6SERTA43T
X-Mailman-Approved-At: Mon, 10 Nov 2025 14:39:37 +0000
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RNURTLZI56IJYQMBRJJZZGT6SERTA43T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

acpi match changes to support tas2783a on mtl
on link 0 for 2 devices

Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Niranjan H Y <niranjan.hy@ti.com>
---
 .../intel/common/soc-acpi-intel-mtl-match.c   | 30 +++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index 75dc8935a..ec9fd8486 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -948,6 +948,30 @@ static const struct snd_soc_acpi_adr_device cs42l42_0_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device tas2783_0_adr[] = {
+	{
+		.adr = 0x0000380102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "tas2783-1"
+	},
+	{
+		.adr = 0x0000390102000001ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "tas2783-2"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr tas2783_link0[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(tas2783_0_adr),
+		.adr_d = tas2783_0_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr cs42l42_link0_max98363_link2[] = {
 	/* Expected order: jack -> amp */
 	{
@@ -1080,6 +1104,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-mtl-rt715-rt711-rt1308-mono.tplg",
 	},
+	{
+		.link_mask = BIT(0),
+		.links = tas2783_link0,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-mtl-tas2783.tplg",
+	},
 	{
 		.link_mask = GENMASK(3, 0),
 		.links = mtl_rt713_l0_rt1316_l12_rt1713_l3,
-- 
2.45.2

