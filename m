Return-Path: <SRS0=FXXq=MY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2092C4338F
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Aug 2021 15:36:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148E1610A7
	for <alsa-devel@archiver.kernel.org>; Sun,  1 Aug 2021 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 148E1610A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE8151841;
	Sun,  1 Aug 2021 17:35:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE8151841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627832187;
	bh=zEOLrgg1+HXGkmr0IwLVO2D3GmvtAOhGru4qnHsyc/o=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r89Nt1HHp2RVzY2AqLQ/QgcU3JyoLsqiFIrcxqZ3HPaICAHEj4vib5GxmjQazZGTG
	 XmT749qw5iiaYh6jetBOa/9b4CWh7gv8djV9eu7tQ1y3koQn76qgVgqzqSB0mjqfga
	 +vJd/Pku9Op2AbH2EgoXUrpXl1C1Rix6BXGYm2x0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B92DF8016D;
	Sun,  1 Aug 2021 17:35:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E5B2FF802E8; Sun,  1 Aug 2021 17:35:33 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0146.hostedemail.com
 [216.40.44.146])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5A30F80095
 for <alsa-devel@alsa-project.org>; Sun,  1 Aug 2021 17:35:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5A30F80095
Received: from omf12.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id A62B3837F24C;
 Sun,  1 Aug 2021 15:35:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf12.hostedemail.com (Postfix) with ESMTPA id 4C2F9240235; 
 Sun,  1 Aug 2021 15:35:14 +0000 (UTC)
Message-ID: <394bd56bf72ac2282207e02e48de6e6bd67a7bc6.camel@perches.com>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: make array clocks static, makes
 object smaller
From: Joe Perches <joe@perches.com>
To: Colin King <colin.king@canonical.com>, Liam Girdwood
 <lgirdwood@gmail.com>,  Mark Brown <broonie@kernel.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org
Date: Sun, 01 Aug 2021 08:35:12 -0700
In-Reply-To: <20210801064807.138641-1-colin.king@canonical.com>
References: <20210801064807.138641-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4C2F9240235
X-Stat-Signature: ksg94apy393dz6drz5igtdar8j46f7fg
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18MS7QZ5XINIs87PUEILFIGu7VAca/8HEM=
X-HE-Tag: 1627832114-829962
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, 2021-08-01 at 07:48 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array clocks on the stack but instead it
> static. Makes the object code smaller by 316 bytes.
> 
> Before:
>    text    data     bss     dec     hex filename
>   63668   28264       0   91932   1671c ./sound/soc/codecs/tlv320aic32x4.o
> 
> After:
>    text    data     bss     dec     hex filename
>   62616   29000       0   91616   165e0 ./sound/soc/codecs/tlv320aic32x4.o
> 
> (gcc version 10.2.0)

That's likely also compiled allyesconfig.
allyesconfig compilations create a lot of superfluous data and text.

It's rather smaller with a defconfig and just the driver selected.

And here are a few additional possibilities for this driver.

$ size sound/soc/codecs/tlv320aic32x4.o*
   text	   data	    bss	    dec	    hex	filename
  38542	   2684	      0	  41226	   a10a	sound/soc/codecs/tlv320aic32x4.o.defconfig.new
  38446	   2792	      0	  41238	   a116	sound/soc/codecs/tlv320aic32x4.o.defconfig.old
  64184	  27880	      0	  92064	  167a0	sound/soc/codecs/tlv320aic32x4.o.allyesconfig.new
  63800	  28264	      0	  92064	  167a0	sound/soc/codecs/tlv320aic32x4.o.allyesconfig.old
---
diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 254a016cb1f36..aeac45cbe1955 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -243,29 +243,29 @@ static const struct snd_kcontrol_new aic32x4_mfp5[] = {
 };
 
 /* 0dB min, 0.5dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_step_0_5, 0, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_step_0_5, 0, 50, 0);
 /* -63.5dB min, 0.5dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_pcm, -6350, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_pcm, -6350, 50, 0);
 /* -6dB min, 1dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_driver_gain, -600, 100, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_driver_gain, -600, 100, 0);
 /* -12dB min, 0.5dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_adc_vol, -1200, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_adc_vol, -1200, 50, 0);
 /* -6dB min, 1dB steps */
-static DECLARE_TLV_DB_SCALE(tlv_tas_driver_gain, -5850, 50, 0);
-static DECLARE_TLV_DB_SCALE(tlv_amp_vol, 0, 600, 1);
+static const DECLARE_TLV_DB_SCALE(tlv_tas_driver_gain, -5850, 50, 0);
+static const DECLARE_TLV_DB_SCALE(tlv_amp_vol, 0, 600, 1);
 
 static const char * const lo_cm_text[] = {
 	"Full Chip", "1.65V",
 };
 
-static SOC_ENUM_SINGLE_DECL(lo_cm_enum, AIC32X4_CMMODE, 3, lo_cm_text);
+static const SOC_ENUM_SINGLE_DECL(lo_cm_enum, AIC32X4_CMMODE, 3, lo_cm_text);
 
 static const char * const ptm_text[] = {
 	"P3", "P2", "P1",
 };
 
-static SOC_ENUM_SINGLE_DECL(l_ptm_enum, AIC32X4_LPLAYBACK, 2, ptm_text);
-static SOC_ENUM_SINGLE_DECL(r_ptm_enum, AIC32X4_RPLAYBACK, 2, ptm_text);
+static const SOC_ENUM_SINGLE_DECL(l_ptm_enum, AIC32X4_LPLAYBACK, 2, ptm_text);
+static const SOC_ENUM_SINGLE_DECL(r_ptm_enum, AIC32X4_RPLAYBACK, 2, ptm_text);
 
 static const struct snd_kcontrol_new aic32x4_snd_controls[] = {
 	SOC_DOUBLE_R_S_TLV("PCM Playback Volume", AIC32X4_LDACVOL,
@@ -341,14 +341,14 @@ static const char * const resistor_text[] = {
 };
 
 /* Left mixer pins */
-static SOC_ENUM_SINGLE_DECL(in1l_lpga_p_enum, AIC32X4_LMICPGAPIN, 6, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2l_lpga_p_enum, AIC32X4_LMICPGAPIN, 4, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3l_lpga_p_enum, AIC32X4_LMICPGAPIN, 2, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in1r_lpga_p_enum, AIC32X4_LMICPGAPIN, 0, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in1l_lpga_p_enum, AIC32X4_LMICPGAPIN, 6, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in2l_lpga_p_enum, AIC32X4_LMICPGAPIN, 4, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in3l_lpga_p_enum, AIC32X4_LMICPGAPIN, 2, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in1r_lpga_p_enum, AIC32X4_LMICPGAPIN, 0, resistor_text);
 
-static SOC_ENUM_SINGLE_DECL(cml_lpga_n_enum, AIC32X4_LMICPGANIN, 6, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2r_lpga_n_enum, AIC32X4_LMICPGANIN, 4, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3r_lpga_n_enum, AIC32X4_LMICPGANIN, 2, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(cml_lpga_n_enum, AIC32X4_LMICPGANIN, 6, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in2r_lpga_n_enum, AIC32X4_LMICPGANIN, 4, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in3r_lpga_n_enum, AIC32X4_LMICPGANIN, 2, resistor_text);
 
 static const struct snd_kcontrol_new in1l_to_lmixer_controls[] = {
 	SOC_DAPM_ENUM("IN1_L L+ Switch", in1l_lpga_p_enum),
@@ -373,13 +373,13 @@ static const struct snd_kcontrol_new in3r_to_lmixer_controls[] = {
 };
 
 /*	Right mixer pins */
-static SOC_ENUM_SINGLE_DECL(in1r_rpga_p_enum, AIC32X4_RMICPGAPIN, 6, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2r_rpga_p_enum, AIC32X4_RMICPGAPIN, 4, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3r_rpga_p_enum, AIC32X4_RMICPGAPIN, 2, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in2l_rpga_p_enum, AIC32X4_RMICPGAPIN, 0, resistor_text);
-static SOC_ENUM_SINGLE_DECL(cmr_rpga_n_enum, AIC32X4_RMICPGANIN, 6, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in1l_rpga_n_enum, AIC32X4_RMICPGANIN, 4, resistor_text);
-static SOC_ENUM_SINGLE_DECL(in3l_rpga_n_enum, AIC32X4_RMICPGANIN, 2, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in1r_rpga_p_enum, AIC32X4_RMICPGAPIN, 6, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in2r_rpga_p_enum, AIC32X4_RMICPGAPIN, 4, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in3r_rpga_p_enum, AIC32X4_RMICPGAPIN, 2, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in2l_rpga_p_enum, AIC32X4_RMICPGAPIN, 0, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(cmr_rpga_n_enum, AIC32X4_RMICPGANIN, 6, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in1l_rpga_n_enum, AIC32X4_RMICPGANIN, 4, resistor_text);
+static const SOC_ENUM_SINGLE_DECL(in3l_rpga_n_enum, AIC32X4_RMICPGANIN, 2, resistor_text);
 
 static const struct snd_kcontrol_new in1r_to_rmixer_controls[] = {
 	SOC_DAPM_ENUM("IN1_R R+ Switch", in1r_rpga_p_enum),

