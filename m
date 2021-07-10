Return-Path: <SRS0=XhfU=MC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56CCC11F66
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:19:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63CF61435
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Jul 2021 02:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63CF61435
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E059E166A;
	Sat, 10 Jul 2021 04:18:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E059E166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625883541;
	bh=V17iZAtlDJtdmfky34MKjTT9SgYihWsXZKBHvFlFewE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p8QCHailXPDW6SX0oAFKsUBEF67PHztVcM2GKpSdMFkclVL0eevkGhy8CTBe8SepB
	 MDEU7Gijxe2dk8gi+Pkp/RfgQ0sRrq+X37vr/EJc90PbKXHu7gymwLjTwr0xk5YVvA
	 SKRiKQWSLdSpExp4ZjQY9SzUOzjI9k6TnymeqP9I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6CAFAF80246;
	Sat, 10 Jul 2021 04:18:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6ED6CF802C8; Sat, 10 Jul 2021 04:18:06 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 416AFF80107
 for <alsa-devel@alsa-project.org>; Sat, 10 Jul 2021 04:17:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 416AFF80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="fWPhrfwG"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B252613C3;
 Sat, 10 Jul 2021 02:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625883472;
 bh=V17iZAtlDJtdmfky34MKjTT9SgYihWsXZKBHvFlFewE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fWPhrfwG63lQ76vVhSvZIRy9g6o71J5zxmCcqH1WECsct04/4AvJQiyMq9j5HQ1LI
 JUU1SJIlm5h0wRjq6IxwB9MNjZUULIE83/Jemc8HKPdXB16SdWi6PNVVqq+bJX+9yL
 nc+mK4Z5L4UgnRYdh1DJ5KK78CfxWtyMETvOLmgvx4h2V+nvnB5FN5L9elOjIcJ9ZC
 W7oCIz6kZ2ntgZT07lIp8geez8lGPy32TYC1u55e8J2ylqKiRALySBMlApgoyWF4c8
 2IwGIYuW+Uj0vew/+sj/zhwgMahyYfWWA1ZE7Bpgxag/IZAaW7HODKcgSI8b9fSkJN
 dYHSwPmGc+1qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 002/114] ASoC: Intel: sof_sdw: add mutual
 exclusion between PCH DMIC and RT715
Date: Fri,  9 Jul 2021 22:15:56 -0400
Message-Id: <20210710021748.3167666-2-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710021748.3167666-1-sashal@kernel.org>
References: <20210710021748.3167666-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Libin Yang <libin.yang@intel.com>, Sasha Levin <sashal@kernel.org>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 35564e2bf94611c3eb51d35362addb3cb394ad54 ]

When external RT714/715 devices are used for capture, we don't want
the PCH DMICs to be used.

Any information provided by the SOF platform driver or DMI quirks will
be overridden.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Libin Yang <libin.yang@intel.com>
Link: https://lore.kernel.org/r/20210505163705.305616-5-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/sof_sdw.c        | 19 +++++++++++++++++--
 sound/soc/intel/boards/sof_sdw_common.h |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index ecd3f90f4bbe..85a2797c2550 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -353,6 +353,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.part_id = 0x714,
 		.version_id = 3,
 		.direction = {false, true},
+		.ignore_pch_dmic = true,
 		.dai_name = "rt715-aif2",
 		.init = sof_sdw_rt715_sdca_init,
 	},
@@ -360,6 +361,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.part_id = 0x715,
 		.version_id = 3,
 		.direction = {false, true},
+		.ignore_pch_dmic = true,
 		.dai_name = "rt715-aif2",
 		.init = sof_sdw_rt715_sdca_init,
 	},
@@ -367,6 +369,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.part_id = 0x714,
 		.version_id = 2,
 		.direction = {false, true},
+		.ignore_pch_dmic = true,
 		.dai_name = "rt715-aif2",
 		.init = sof_sdw_rt715_init,
 	},
@@ -374,6 +377,7 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.part_id = 0x715,
 		.version_id = 2,
 		.direction = {false, true},
+		.ignore_pch_dmic = true,
 		.dai_name = "rt715-aif2",
 		.init = sof_sdw_rt715_init,
 	},
@@ -729,7 +733,8 @@ static int create_sdw_dailink(struct device *dev, int *be_index,
 			      int *cpu_id, bool *group_generated,
 			      struct snd_soc_codec_conf *codec_conf,
 			      int codec_count,
-			      int *codec_conf_index)
+			      int *codec_conf_index,
+			      bool *ignore_pch_dmic)
 {
 	const struct snd_soc_acpi_link_adr *link_next;
 	struct snd_soc_dai_link_component *codecs;
@@ -782,6 +787,9 @@ static int create_sdw_dailink(struct device *dev, int *be_index,
 	if (codec_index < 0)
 		return codec_index;
 
+	if (codec_info_list[codec_index].ignore_pch_dmic)
+		*ignore_pch_dmic = true;
+
 	cpu_dai_index = *cpu_id;
 	for_each_pcm_streams(stream) {
 		char *name, *cpu_name;
@@ -913,6 +921,7 @@ static int sof_card_dai_links_create(struct device *dev,
 	const struct snd_soc_acpi_link_adr *adr_link;
 	struct snd_soc_dai_link_component *cpus;
 	struct snd_soc_codec_conf *codec_conf;
+	bool ignore_pch_dmic = false;
 	int codec_conf_count;
 	int codec_conf_index = 0;
 	bool group_generated[SDW_MAX_GROUPS];
@@ -1019,7 +1028,8 @@ static int sof_card_dai_links_create(struct device *dev,
 					 sdw_cpu_dai_num, cpus, adr_link,
 					 &cpu_id, group_generated,
 					 codec_conf, codec_conf_count,
-					 &codec_conf_index);
+					 &codec_conf_index,
+					 &ignore_pch_dmic);
 		if (ret < 0) {
 			dev_err(dev, "failed to create dai link %d", be_id);
 			return -ENOMEM;
@@ -1087,6 +1097,10 @@ static int sof_card_dai_links_create(struct device *dev,
 DMIC:
 	/* dmic */
 	if (dmic_num > 0) {
+		if (ignore_pch_dmic) {
+			dev_warn(dev, "Ignoring PCH DMIC\n");
+			goto HDMI;
+		}
 		cpus[cpu_id].dai_name = "DMIC01 Pin";
 		init_dai_link(dev, links + link_id, be_id, "dmic01",
 			      0, 1, // DMIC only supports capture
@@ -1105,6 +1119,7 @@ static int sof_card_dai_links_create(struct device *dev,
 		INC_ID(be_id, cpu_id, link_id);
 	}
 
+HDMI:
 	/* HDMI */
 	if (hdmi_num > 0) {
 		idisp_components = devm_kcalloc(dev, hdmi_num,
diff --git a/sound/soc/intel/boards/sof_sdw_common.h b/sound/soc/intel/boards/sof_sdw_common.h
index f3cb6796363e..ea60e8ed215c 100644
--- a/sound/soc/intel/boards/sof_sdw_common.h
+++ b/sound/soc/intel/boards/sof_sdw_common.h
@@ -56,6 +56,7 @@ struct sof_sdw_codec_info {
 	int amp_num;
 	const u8 acpi_id[ACPI_ID_LEN];
 	const bool direction[2]; // playback & capture support
+	const bool ignore_pch_dmic;
 	const char *dai_name;
 	const struct snd_soc_ops *ops;
 
-- 
2.30.2

