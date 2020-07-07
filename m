Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0C8C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:22:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BC65206E9
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WLlHIrUL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC65206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17F171683;
	Tue,  7 Jul 2020 21:21:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17F171683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594149754;
	bh=3mc8sODnkxLN+lgeqU7NGCItxqS9gGLy9vIw/Qn/QrA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WLlHIrULqD0moi2vDxO9AemPj4p6/iSbCz4kMnHtC0WlxVaJK/6q63R5LPeeLXzx1
	 mqivKCcp92y4aWVRICYNnz+d7cAoYH/dt9S7SukgAsBLzTnIx00QaF9C/4ff3+X8+V
	 0w7MjDTI45x75OdE2G+OYJzBZUUIp2ac+as3nAQM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD204F80304;
	Tue,  7 Jul 2020 21:16:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 984E4F802FF; Tue,  7 Jul 2020 21:16:54 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EB2C5F802BD
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 21:16:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB2C5F802BD
IronPort-SDR: xGWm8FDfuRmiAGO7o6TqO+crNiVxgZNtTVBnIP29uEtRI3t4MyzRzR5C9YjwCm1GzDKRVTKShk
 qnJSD3IMUUHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="147690705"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="147690705"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:16:43 -0700
IronPort-SDR: j+jImmB6/72maJYxi5VoSGFc3/TtazHxKZ3cw4p5rZwed+llD3YdVVOo9Gw5qYIkSZkKhigEs5
 A3k+CNrWgS+w==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; d="scan'208";a="388601656"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.77.62])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2020 12:16:42 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 08/10] ASoC: codecs: rt5659: Remove many unused const
 variables
Date: Tue,  7 Jul 2020 14:16:13 -0500
Message-Id: <20200707191615.98296-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
References: <20200707191615.98296-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, broonie@kernel.org,
 Lee Jones <lee.jones@linaro.org>
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

From: Lee Jones <lee.jones@linaro.org>

Looks as though they've never been used.

Fixes the following W=1 kernel build warning(s):

 In file included from  sound/soc/codecs/rt5659.c:25:
 In file included from sound/soc/codecs/rt5659.c:25:
 sound/soc/codecs/rt5659.c:1232:2: warning: ‘rt5659_ad_monor_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1232 | rt5659_ad_monor_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_R_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1231:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1231 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1228:2: warning: ‘rt5659_ad_monol_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1228 | rt5659_ad_monol_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_L_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1227:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1227 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1224:2: warning: ‘rt5659_ad_sto2_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1224 | rt5659_ad_sto2_asrc_enum, RT5659_ASRC_3, RT5659_AD_STO2_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1223:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1223 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1220:2: warning: ‘rt5659_ad_sto1_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1220 | rt5659_ad_sto1_asrc_enum, RT5659_ASRC_2, RT5659_AD_STO1_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1219:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1219 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1216:2: warning: ‘rt5659_da_monor_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1216 | rt5659_da_monor_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_R_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1215:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1215 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1212:2: warning: ‘rt5659_da_monol_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1212 | rt5659_da_monol_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_L_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1211:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1211 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~
 sound/soc/codecs/rt5659.c:1208:2: warning: ‘rt5659_da_sto_asrc_enum’ defined but not used [-Wunused-const-variable=]
 1208 | rt5659_da_sto_asrc_enum, RT5659_ASRC_2, RT5659_DA_STO_T_SFT, 0x7,
 | ^~~~~~~~~~~~~~~~~~~~~~~
 include/sound/soc.h:359:24: note: in definition of macro ‘SOC_VALUE_ENUM_DOUBLE_DECL’
 359 | const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, | ^~~~
 sound/soc/codecs/rt5659.c:1207:8: note: in expansion of macro ‘SOC_VALUE_ENUM_SINGLE_DECL’
 1207 | static SOC_VALUE_ENUM_SINGLE_DECL(
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5659.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 541fc6f1089b..41e5917b16a5 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -1195,43 +1195,6 @@ static const struct snd_kcontrol_new rt5659_if3_dac_swap_mux =
 static const struct snd_kcontrol_new rt5659_if3_adc_swap_mux =
 	SOC_DAPM_ENUM("IF3 ADC Swap Source", rt5659_if3_adc_enum);
 
-static const char * const rt5659_asrc_clk_src[] = {
-	"clk_sysy_div_out", "clk_i2s1_track", "clk_i2s2_track",
-	"clk_i2s3_track", "clk_sys2", "clk_sys3"
-};
-
-static unsigned int rt5659_asrc_clk_map_values[] = {
-	0, 1, 2, 3, 5, 6,
-};
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_da_sto_asrc_enum, RT5659_ASRC_2, RT5659_DA_STO_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_da_monol_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_L_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_da_monor_asrc_enum, RT5659_ASRC_2, RT5659_DA_MONO_R_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_ad_sto1_asrc_enum, RT5659_ASRC_2, RT5659_AD_STO1_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_ad_sto2_asrc_enum, RT5659_ASRC_3, RT5659_AD_STO2_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_ad_monol_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_L_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
-static SOC_VALUE_ENUM_SINGLE_DECL(
-	rt5659_ad_monor_asrc_enum, RT5659_ASRC_3, RT5659_AD_MONO_R_T_SFT, 0x7,
-	rt5659_asrc_clk_src, rt5659_asrc_clk_map_values);
-
 static int rt5659_hp_vol_put(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
-- 
2.25.1

