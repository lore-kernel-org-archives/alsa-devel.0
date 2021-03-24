Return-Path: <SRS0=3oXn=IW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1371C433C1
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53F961A09
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53F961A09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 292A91686;
	Wed, 24 Mar 2021 18:53:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 292A91686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616608476;
	bh=6wA/GWvJjvbbS7ZJVb9Vn2NArdq2Hd0B+rkFOMIGuUQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JW6lgxMo1S/Qab+Q6RFyO5WYvXmVikj2qlsK92P7R0gvvBAeV99dHCz2RduP7wBqZ
	 fFYghXhKgN6bBJF1CLuX3exnNBuitBxpdCQJ0xd6P9zrthnB8zu4YTvaM/bdB4DTpf
	 7o0Wao3XO6ay3vrTVDQOfuyVLeLtwg7lxEZd8xEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EF14EF8032C;
	Wed, 24 Mar 2021 18:52:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07170F8032C; Wed, 24 Mar 2021 18:52:48 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDE99F800FF
 for <alsa-devel@alsa-project.org>; Wed, 24 Mar 2021 18:52:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDE99F800FF
IronPort-SDR: fUJ+fqVfvCjk1f6C9ZdAf5U35UKiH80Pa8R2uCQPbHDkCSL2eIuOSdgkNm6+9or56WuSOCfLdp
 ODYyAaT5NBjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="187452414"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="187452414"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 10:52:35 -0700
IronPort-SDR: 3Ata4bdp/BOiwl11z2YxipmnfFew8tqdfd+hXDiCUkh2R3/NR28eOejTaTwLmCh8h5mBesc0aw
 /W6BNgqcrNzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="442344397"
Received: from snappy-s2600wt2r.iind.intel.com ([10.223.163.26])
 by fmsmga002.fm.intel.com with ESMTP; 24 Mar 2021 10:52:32 -0700
From: vamshi.krishna.gopal@intel.com
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoc: Intel: board: add BE DAI link for WoV
Date: Wed, 24 Mar 2021 23:22:00 +0530
Message-Id: <20210324175200.44922-3-vamshi.krishna.gopal@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324175200.44922-1-vamshi.krishna.gopal@intel.com>
References: <20210324175200.44922-1-vamshi.krishna.gopal@intel.com>
Cc: harshapriya.n@intel.com, broonie@kernel.org, sathya.prakash.m.r@intel.com,
 biernacki@google.com, vamshi.krishna.gopal@intel.com,
 pierre-louis.bossart@intel.com
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

From: Mac Chiang <mac.chiang@intel.com>

create dai link in kbl_da7219_max98357a driver for wake on voice
functionality.

changes picked from broonie's tree
commit 0c7941a63a0f
("ASoC: Intel: Skylake: Use refcap device for mono recording")
commit 2154be362c90
("ASoc: Intel: boards: Add WOV as sink for nau88l25_ssm4567 machine")

Signed-off-by: Mac Chiang <mac.chiang@intel.com>
Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
Tested-by: Kaiyen Chang <kaiyen.chang@intel.corp-partner.google.com>
Tested-by: luke yang <luke_yang@compal.corp-partner.google.com>
Tested-by: Grace Kao <grace.kao@intel.com>
Tested-by: Kaiyen Chang <kaiyen.chang@intel.com>
Reviewed-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/intel/boards/kbl_da7219_max98357a.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/intel/boards/kbl_da7219_max98357a.c b/sound/soc/intel/boards/kbl_da7219_max98357a.c
index 1d6b2855874d..c9d83eebf4a8 100644
--- a/sound/soc/intel/boards/kbl_da7219_max98357a.c
+++ b/sound/soc/intel/boards/kbl_da7219_max98357a.c
@@ -44,6 +44,7 @@ struct kbl_codec_private {
 enum {
 	KBL_DPCM_AUDIO_PB = 0,
 	KBL_DPCM_AUDIO_CP,
+	KBL_DPCM_AUDIO_REF_CP,
 	KBL_DPCM_AUDIO_DMIC_CP,
 	KBL_DPCM_AUDIO_HDMI1_PB,
 	KBL_DPCM_AUDIO_HDMI2_PB,
@@ -335,12 +336,36 @@ static struct snd_soc_ops kabylake_dmic_ops = {
 	.startup = kabylake_dmic_startup,
 };
 
+static const struct snd_pcm_hw_constraint_list constraints_refcap = {
+	.count = ARRAY_SIZE(ch_mono),
+	.list  = ch_mono,
+};
+
+static int kabylake_refcap_startup(struct snd_pcm_substream *substream)
+{
+	substream->runtime->hw.channels_max = 1;
+	snd_pcm_hw_constraint_list(substream->runtime, 0,
+					SNDRV_PCM_HW_PARAM_CHANNELS,
+					&constraints_refcap);
+
+	return snd_pcm_hw_constraint_list(substream->runtime, 0,
+					SNDRV_PCM_HW_PARAM_RATE,
+					&constraints_16000);
+}
+
+static struct snd_soc_ops skylaye_refcap_ops = {
+	.startup = kabylake_refcap_startup,
+};
+
 SND_SOC_DAILINK_DEF(dummy,
 	DAILINK_COMP_ARRAY(COMP_DUMMY()));
 
 SND_SOC_DAILINK_DEF(system,
 	DAILINK_COMP_ARRAY(COMP_CPU("System Pin")));
 
+SND_SOC_DAILINK_DEF(reference,
+	DAILINK_COMP_ARRAY(COMP_CPU("Reference Pin")));
+
 SND_SOC_DAILINK_DEF(dmic,
 	DAILINK_COMP_ARRAY(COMP_CPU("DMIC Pin")));
 
@@ -415,6 +440,16 @@ static struct snd_soc_dai_link kabylake_dais[] = {
 		.ops = &kabylake_da7219_fe_ops,
 		SND_SOC_DAILINK_REG(system, dummy, platform),
 	},
+	[KBL_DPCM_AUDIO_REF_CP] = {
+		.name = "Kbl Audio Reference cap",
+		.stream_name = "Wake on Voice",
+		.init = NULL,
+		.dpcm_capture = 1,
+		.nonatomic = 1,
+		.dynamic = 1,
+		.ops = &skylaye_refcap_ops,
+		SND_SOC_DAILINK_REG(reference, dummy, platform),
+	},
 	[KBL_DPCM_AUDIO_DMIC_CP] = {
 		.name = "Kbl Audio DMIC cap",
 		.stream_name = "dmiccap",
-- 
2.17.1

