Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E297EC6FD1F
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Mar 2024 12:45:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3EC712CA1;
	Fri, 29 Mar 2024 13:45:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3EC712CA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711716321;
	bh=qLWcvGpBZeQ7lY3R7E7DyEAzB9HEpBbU7NWlU2SvO+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=YnrlLpMQsYD/gXNmZWRLt5tb49pVxu3BVYdxI2bvlIo95dgkZBURLoFgf8vboQMHZ
	 oPFTWAC6WVHP/pWjG5QKDeAt6oaY2OB0o8OVcIXxN0aD/PBw7kwsJcG5WumwRrl/kL
	 uF7/CkSIQ5P0WQjZ8Kk+sHnrkyA2IMMDGiZs3QDk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D4A10F805D4; Fri, 29 Mar 2024 13:44:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D3B51F805EE;
	Fri, 29 Mar 2024 13:44:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 010E3F801EB; Fri, 29 Mar 2024 13:44:36 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 63994F801EB
	for <alsa-devel@alsa-project.org>; Fri, 29 Mar 2024 13:44:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 63994F801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sXekF4Kg
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D8C196192A;
	Fri, 29 Mar 2024 12:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11AEC433C7;
	Fri, 29 Mar 2024 12:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716272;
	bh=qLWcvGpBZeQ7lY3R7E7DyEAzB9HEpBbU7NWlU2SvO+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sXekF4KgohKg+1NWX8csZq5Gq5/4A5Gotp4Wf1R2jKoRHHwaQcIgb4MsqC8bDCm6S
	 dTecj6CC/qqKimbhPYHX9Fb098FiPMa+FT/riyZxzSJ8T/llij9LhGsIUpBy/o1OMo
	 l+443DcvWcpwN2XGK8K1CbKuBEHSlh8tpLKDtpn0v5fjiJCe16JVwZMD1VDJLGih/g
	 5rNUvaSJIFAtk9+RipvYMtEcaRITA/mx/5Kf7AZRcGbEo0Kv82r7V/wUa/TicOrLff
	 RZ6IJOMSjsJceUoETs/QhDg2MeVJOxcj2Vj03nxdEh4vBIhi5I6g/vVxa9/Vw4V/Kv
	 fMXlns4pJ7WFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	pierre-louis.bossart@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com,
	andriy.shevchenko@linux.intel.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 33/75] ASoC: Intel: avs: Populate board selection
 with new I2S entries
Date: Fri, 29 Mar 2024 08:42:14 -0400
Message-ID: <20240329124330.3089520-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 7FZCA2VMII5QUIXBJDNJC5NWEHAANKXI
X-Message-ID-Hash: 7FZCA2VMII5QUIXBJDNJC5NWEHAANKXI
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7FZCA2VMII5QUIXBJDNJC5NWEHAANKXI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit 5b417fe0cded0b5917683398e6519aae8045cd40 ]

Update board selection with tables specifying supported I2S
configurations. DMIC/HDAudio board selection require no update as
dmic/hdaudio machine boards are generic and not tied to any specific
codec.

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Link: https://msgid.link/r/20240220115035.770402-11-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/avs/board_selection.c | 85 +++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
index 59a13feec57b2..0db5e530a8de2 100644
--- a/sound/soc/intel/avs/board_selection.c
+++ b/sound/soc/intel/avs/board_selection.c
@@ -227,6 +227,82 @@ static struct snd_soc_acpi_mach avs_gml_i2s_machines[] = {
 	{},
 };
 
+static struct snd_soc_acpi_mach avs_cnl_i2s_machines[] = {
+	{
+		.id = "INT34C2",
+		.drv_name = "avs_rt274",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt274-tplg.bin",
+	},
+	{
+		.id = "10EC5682",
+		.drv_name = "avs_rt5682",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(1),
+		},
+		.tplg_filename = "rt5682-tplg.bin",
+	},
+	{},
+};
+
+static struct snd_soc_acpi_mach avs_icl_i2s_machines[] = {
+	{
+		.id = "INT343A",
+		.drv_name = "avs_rt298",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt298-tplg.bin",
+	},
+	{
+		.id = "INT34C2",
+		.drv_name = "avs_rt274",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt274-tplg.bin",
+	},
+	{},
+};
+
+static struct snd_soc_acpi_mach avs_tgl_i2s_machines[] = {
+	{
+		.id = "INT34C2",
+		.drv_name = "avs_rt274",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt274-tplg.bin",
+	},
+	{
+		.id = "10EC0298",
+		.drv_name = "avs_rt298",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "rt298-tplg.bin",
+	},
+	{
+		.id = "10EC1308",
+		.drv_name = "avs_rt1308",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(1),
+		},
+		.tplg_filename = "rt1308-tplg.bin",
+	},
+	{
+		.id = "ESSX8336",
+		.drv_name = "avs_es8336",
+		.mach_params = {
+			.i2s_link_mask = AVS_SSP(0),
+		},
+		.tplg_filename = "es8336-tplg.bin",
+	},
+	{},
+};
+
 static struct snd_soc_acpi_mach avs_test_i2s_machines[] = {
 	{
 		.drv_name = "avs_i2s_test",
@@ -287,6 +363,15 @@ static const struct avs_acpi_boards i2s_boards[] = {
 	AVS_MACH_ENTRY(HDA_KBL_LP, avs_kbl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_APL, avs_apl_i2s_machines),
 	AVS_MACH_ENTRY(HDA_GML, avs_gml_i2s_machines),
+	AVS_MACH_ENTRY(HDA_CNL_LP,	avs_cnl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_CNL_H,	avs_cnl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_CML_LP,	avs_cnl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_ICL_LP,	avs_icl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_TGL_LP,	avs_tgl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_EHL_0,	avs_tgl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_ADL_P,	avs_tgl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_RPL_P_0,	avs_tgl_i2s_machines),
+	AVS_MACH_ENTRY(HDA_RPL_M,	avs_tgl_i2s_machines),
 	{},
 };
 
-- 
2.43.0

