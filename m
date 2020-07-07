Return-Path: <SRS0=w3Zw=AS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0473C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:53:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AE820771
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jul 2020 14:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bD4HUeZh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkvVhQeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48AE820771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CD7F61684;
	Tue,  7 Jul 2020 16:52:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CD7F61684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594133618;
	bh=NCtYYHmh/Hk6m+9uLA0/GithztxMt6Zw9EiRAcooUf8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bD4HUeZhcFPFz5S0p7Z0MDbKonH0RBoPWxiMuPXhUF0VhuPKajGbOSIrCogP8SXLo
	 ADCzzZg740ULOGVGTlJWYkO1670CI01Cr6Wux//fpRx+8KskYwkrrq8deZweHukVLX
	 ZrsyFjDrO719a5PaneWlpZ5FH1xiwvlK/SJqgUkQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ACA20F803BE;
	Tue,  7 Jul 2020 16:38:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F20C5F8037F; Tue,  7 Jul 2020 16:38:39 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 67311F80342
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 16:38:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 67311F80342
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="EkvVhQeZ"
Received: by mail-wm1-x341.google.com with SMTP id 22so43541412wmg.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Jul 2020 07:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Uo5lua4EqbM6dOWxZ2PX5/59WiGZNeMIYC5zygYLP+w=;
 b=EkvVhQeZcbznKFNyswSPNfIpD0zKHsz7OYbVpSmbN1UoZNh7AB//jJ1rDyTWShSr0g
 hlji9myJ68m3wT3PmKjNfBCeRJgcPprmUP3Ji6FYkBNNvv2lkgj/BtT4DXpSZIlD3vrd
 Qj11Tz1SitZoY4wY7or2PmiJjE05AQzNAxkKROt0u2VBp0Ia1fULkhdkzSixMwMwNKld
 2tCpxhtvORX31gwxMi8CQH4o0+Zh4L6npspKdvTQPeeO3sJK7zyqL7GwADWUon9cuxgW
 lReKFJtZnPkhwndK1255bnN6ss+/scJF7BBXN6bHGE69BrxkluiAz/vTHHSOE1XbFck/
 fy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Uo5lua4EqbM6dOWxZ2PX5/59WiGZNeMIYC5zygYLP+w=;
 b=kzzqxTPe4fNMKq9WvT5oHc+oNrygXJmzQEW5WswfGjxNnm7JzmOaxJ7JdMlObPdKYS
 8+wSFeZhPCc8uvHE/YGr/w6AYsV7ArUvrvOCQY9fZO/Frc+0GYSwWS3np8b+1g8E+s5P
 oPmP8D6FZ7YHZI9J5Vme3jPeJxzMvq4bb4yT3rRqxRkH6TVing/km0y61mQ/8Y1lVUc5
 tr2smX3NiK+912pf47tR32bEF0lx8SmH0sqk6GlXwg+zhXnOwz/vpcfMwAPFEgcyY6bm
 soRWnqW2DjV1netmeyUq+C949RrjXA9G7z3t3vpb4zQWfm7BwTM3RmVhgqrMc9xpl000
 miXA==
X-Gm-Message-State: AOAM533BMOtOr8fKqoKQgUxI5h1yEz2k3lDlnv9RugQdp7JR0r8YGlFc
 jeCIo9jlKEfHDYc62VbaIPINWQ==
X-Google-Smtp-Source: ABdhPJz7JLveveXiGAhwhWb1T2d1+Mq9KbtFkHkKS4L32J0B+qK7tacl/+WudhETU2bpnBREID1Alw==
X-Received: by 2002:a1c:5646:: with SMTP id k67mr4722964wmb.61.1594132702903; 
 Tue, 07 Jul 2020 07:38:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
 by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 07:38:22 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2 26/28] ASoC: codecs: rt5659: Remove many unused const
 variables
Date: Tue,  7 Jul 2020 15:37:40 +0100
Message-Id: <20200707143742.2959960-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>,
 Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
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
Cc: Bard Liao <bardliao@realtek.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/rt5659.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 541fc6f1089bb..41e5917b16a5e 100644
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

