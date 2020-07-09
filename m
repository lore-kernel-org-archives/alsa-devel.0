Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80FCC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:30:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F3F2207DF
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Dx7P7JVO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F3F2207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0D68F9F6;
	Thu,  9 Jul 2020 18:29:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0D68F9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594312248;
	bh=3mc8sODnkxLN+lgeqU7NGCItxqS9gGLy9vIw/Qn/QrA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Dx7P7JVO6pM+JtBiP06p1arfEd9bRm36em8QF2KlJKj9MDU0IZK8VzdorfIxsJgU2
	 dG5NXLHjNfDlBsBUOjfA3UJ7+qUdqf9P9GiA3/uTljqjgXzpewdF6XHS7vVXoLGVkd
	 qT6fpZgL+LEV7diUcONhOwREUNhDurNsSAO8K17A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 42E80F8031A;
	Thu,  9 Jul 2020 18:24:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5290F802E8; Thu,  9 Jul 2020 18:24:21 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 958C5F802A0
 for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2020 18:24:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 958C5F802A0
IronPort-SDR: 5x5agL99A/bXzIKyHHVLG5JvIpkRkutdLB1hz4u4Lj/sXmFkL2NtFehB2cS3GA82g0OWw/WJt8
 PP0S19qVpBrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="149515645"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; d="scan'208";a="149515645"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 09:23:56 -0700
IronPort-SDR: q7xN7MUROKVsdJ7GXWSyBfKwPE+66GAwH8jWl8fMmfIzoTT/twgswESkldIvAWkkR2mz/1ku8M
 GMRTTsG6NYoQ==
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; d="scan'208";a="280353038"
Received: from mdcoakle-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.231.43])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2020 09:23:55 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v4 08/10] ASoC: codecs: rt5659: Remove many unused const
 variables
Date: Thu,  9 Jul 2020 11:23:25 -0500
Message-Id: <20200709162328.259586-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
References: <20200709162328.259586-1-pierre-louis.bossart@linux.intel.com>
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

