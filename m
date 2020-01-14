Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD60C33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:55:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192822084D
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cap1PNpG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="p+LbF+p+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192822084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8350A1796;
	Tue, 14 Jan 2020 17:54:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8350A1796
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579020946;
	bh=TihdUso9sqamq8sy3xnM7K5IFX2D4z0thvAhMiZLlWs=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cap1PNpGdjCTb1biFRu7eOfhhvcOdsLY1CyyHephvW7fDAZvnRl9o/A/STIDHetHE
	 +lIY4klAGcHW47Ug9QQfkTH4NdsyZyIxs/lLhCUZafvMX9DwrsJcQN3ryqrQgxfuSg
	 Gl86pBJ+uT8aROTI/t+dp3NBerBa2yUm9LVQ+8Jc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01B6CF8014D;
	Tue, 14 Jan 2020 17:54:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1AF33F8014E; Tue, 14 Jan 2020 17:54:54 +0100 (CET)
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5301::7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28AF2F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2020 17:54:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28AF2F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="p+LbF+p+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1579020886;
 s=strato-dkim-0002; d=gerhold.net;
 h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=XTuiCUsIlnJ+X3ivCI8ddFT+ejNqgg6BGA1grKEcrR4=;
 b=p+LbF+p+gx4kSVM9LWWav32OhkC45Fje0tQ7S1MmkE6kraJXHe9HasNBBc7GlIUUj4
 tKKnOhF/JJfBgNq8yrCm9fC/hkHAq59ef37rB8I/mKKxH3vOcCmbefvRl9rDGjpATfdR
 3JZOPB2qyTNoDHeZsQ4S4s0jgD/mY6mJJNcjGhSzvyVxa/uwadPtYTse+mV7AJpu6fO/
 D+KKG7Q//s4CosSYpsiKxWh4RGznt8i7URCBzNTT1xpu+N/TVmdrgqPP9Dyqfcsoox52
 lGNwzT9ZwNUPm+SUWU96nOltcE7X76hOQ5hOp9AJXJuFncJyB2nNMBwB2Rl+jKCnAdED
 YKrA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267EpF+OQRc4oDWF5yUxHE="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net by smtp.strato.de (RZmta 46.1.4 AUTH)
 with ESMTPSA id h048a6w0EGsgXNj
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 14 Jan 2020 17:54:42 +0100 (CET)
Date: Tue, 14 Jan 2020 17:54:37 +0100
From: Stephan Gerhold <stephan@gerhold.net>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20200114165437.GA897@gerhold.net>
References: <20200111164006.43074-1-stephan@gerhold.net>
 <20200111164006.43074-4-stephan@gerhold.net>
 <314b9a9b-13cd-94f5-0967-f0d4e66d65a1@linaro.org>
 <20200114120817.GA52379@gerhold.net>
 <2b2a7407-d0be-224c-706a-ab193956ae80@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2b2a7407-d0be-224c-706a-ab193956ae80@linaro.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 ~postmarketos/upstreaming@lists.sr.ht, Nikita Travkin <nikitos.tr@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/4] ASoC: msm8916-wcd-analog: Simplify MIC
	BIAS Internal
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Tue, Jan 14, 2020 at 01:03:22PM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 14/01/2020 12:08, Stephan Gerhold wrote:
> > On Tue, Jan 14, 2020 at 10:54:44AM +0000, Srinivas Kandagatla wrote:
> > > 
> > > 
> > > On 11/01/2020 16:40, Stephan Gerhold wrote:
> > > > At the moment, MIC BIAS Internal* and MIC BIAS External* both reference
> > > > the same register, and have a part of their initialization sequence
> > > > duplicated.
> > > > 
> > > > In general, the sequence for enabling MIC BIAS InternalX seems to be:
> > > >     1. Enable MIC BIAS ExternalX
> > > >     2. Enable internal RBIAS resistor
> > > 
> > > Does not sound correct to me.
> > > 
> > > What external means here is if the MICBIAS has external pull up resistor or
> > > not. And this is very much board specific. In order for driver to
> > > enable/disable internal pull up resistor in such cases we use two dapm paths
> > > to differentiate it.
> > > 
> > 
> > You are right. Maybe the naming is a bit confusing here.
> > Let me try to clarify it:
> > 
> > If I understand it correctly, setting the MICB_EN bit in CDC_A_MICB_1_EN
> > enables the MIC_BIAS1 supply. This supply can be either used with an
> > external pull up resistor ("MIC BIAS External1") or with the internal
> > pull up resistor ("MIC BIAS Internal1"). Which one of them, is board-specific.
> > 
> > To use the internal pull up resistor, we need to set the TX1_INT_RBIAS_EN
> > bit in CDC_A_MICB_1_INT_RBIAS additionally.
> > 
> > In other words, the sequence for enabling MIC BIAS Internal1 is:
> >    I1. Enable MIC_BIAS1 supply (MICB_EN bit in CDC_A_MICB_1_EN)
> >    I2. Enable internal RBIAS (TX1_INT_RBIAS_EN bit in CDC_A_MICB_1_INT_RBIAS)
> > 
> > The sequence for enabling MIC BIAS External1 is:
> >    E1. Enable MIC_BIAS1 supply (MICB_EN bit in CDC_A_MICB_1_EN)
> 
> In theory, We should also disable the internal pull up here. if not we end
> up in two parallel resistors, effectively 1/2 the value of external
> resistor.
>

I think this should not happen in practice with this patch.

The internal pull up is a separate DAPM supply with my changes.
As such, the ASoC core will disable it whenever it is not needed.

Therefore, the only way to trigger this situation is to specifically
craft broken DAPM routes in the device tree, e.g.

	qcom,audio-routing =
		"AMIC1", "MIC BIAS Internal1",
		"AMIC1", "MIC BIAS External1";

Which is obviously wrong, because you should select either Internal1
*or* External1, depending on your board design.

> 
> 
> > 
> > Right now we have:
> >    SND_SOC_DAPM_SUPPLY("MIC BIAS Internal1", CDC_A_MICB_1_EN, 7, 0, ...) // I1
> >    SND_SOC_DAPM_SUPPLY("MIC BIAS External1", CDC_A_MICB_1_EN, 7, 0, ...) // E1
> > 
> > I2 is done in the PM event handler (pm8916_wcd_analog_enable_micbias_int1).
> > 
> > The idea of this patch is to simplify this, and use one DAPM supply
> > that handles the common (I1/E1), and one DAPM supply that handles (I2).
> > 
> > Translated to code we get:
> >    SND_SOC_DAPM_SUPPLY("MIC BIAS1", CDC_A_MICB_1_EN, 7, 0, ...) // I1/E1
> >    SND_SOC_DAPM_SUPPLY("MIC BIAS Internal1", CDC_A_MICB_1_INT_RBIAS, 7, 0, ...) // I2
> >    SND_SOC_DAPM_SUPPLY("MIC BIAS External1", SND_SOC_NOPM, ...) // dummy
> > 
> > And the routes:
> >    {"MIC BIAS Internal1", NULL, "MIC BIAS1"} // If I2, also do I1
> >    {"MIC BIAS External1", NULL, "MIC BIAS1"} // Only do E1
> 
> This should work! and makes it much clear too.
> 

I will submit a v2 with this setup. I think I simplified it a bit too
much in this patch.

> 
> > 
> > As you can see, for "MIC BIAS External1" we just do "MIC BIAS1".
> > The confusing element of this patch might be that I simplified it a bit
> > further and combined "MIC BIAS1" with "MIC BIAS External1".
> > This works because we don't do anything extra for "MIC BIAS External1".
> Should we not make sure that internal resistor switch is disabled here?
> 

See above. (I don't mind sending a v3 if we decide that we really need to
disable the internal rbias explicitly.)

> --srini
> 
> > 
> > Does that make sense?
> > 
> > Thanks for taking the time to review all my patches.
> > Stephan
> > 
> > > 
> > > --srini
> > > 
> > > 
> > > 
> > > 
> > > > 
> > > > This means that we can simplify the code by modelling MIC BIAS InternalX
> > > > as supply connected to MIC BIAS ExternalX. MIC BIAS InternalX is only
> > > > responsible for enabling the internal RBIAS resistor (2). The DAPM enable
> > > > sequence will automatically enable MIC BIAS ExternalX (1).
> > > > 
> > > > This makes it much easier to add support for MIC BIAS Internal3
> > > > as a next step.
> > > > 
> > > > Tested-by: Nikita Travkin <nikitos.tr@gmail.com> # longcheer-l8150
> > > > Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > > ---
> > > >    sound/soc/codecs/msm8916-wcd-analog.c | 57 ++++++---------------------
> > > >    1 file changed, 13 insertions(+), 44 deletions(-)
> > > > 
> > > > diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
> > > > index 1f7964beb20c..930baae6eff5 100644
> > > > --- a/sound/soc/codecs/msm8916-wcd-analog.c
> > > > +++ b/sound/soc/codecs/msm8916-wcd-analog.c
> > > > @@ -389,23 +389,17 @@ static int pm8916_wcd_analog_enable_micbias_ext(struct snd_soc_component
> > > >    	return 0;
> > > >    }
> > > > -static int pm8916_wcd_analog_enable_micbias_int(struct snd_soc_component
> > > > -						 *component, int event,
> > > > -						 int reg, u32 cap_mode)
> > > > +static int pm8916_wcd_analog_enable_micbias_int(struct snd_soc_dapm_widget *w,
> > > > +						struct snd_kcontrol *kcontrol,
> > > > +						int event)
> > > >    {
> > > > +	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> > > >    	switch (event) {
> > > >    	case SND_SOC_DAPM_PRE_PMU:
> > > > -		snd_soc_component_update_bits(component, reg, MICB_1_EN_PULL_DOWN_EN_MASK, 0);
> > > >    		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
> > > >    				    MICB_1_EN_OPA_STG2_TAIL_CURR_MASK,
> > > >    				    MICB_1_EN_OPA_STG2_TAIL_CURR_1_60UA);
> > > > -
> > > > -		break;
> > > > -	case SND_SOC_DAPM_POST_PMU:
> > > > -		pm8916_wcd_analog_micbias_enable(component);
> > > > -		snd_soc_component_update_bits(component, CDC_A_MICB_1_EN,
> > > > -				    MICB_1_EN_BYP_CAP_MASK, cap_mode);
> > > >    		break;
> > > >    	}
> > > > @@ -437,26 +431,6 @@ static int pm8916_wcd_analog_enable_micbias_ext2(struct
> > > >    }
> > > > -static int pm8916_wcd_analog_enable_micbias_int1(struct
> > > > -						  snd_soc_dapm_widget
> > > > -						  *w, struct snd_kcontrol
> > > > -						  *kcontrol, int event)
> > > > -{
> > > > -	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
> > > > -	struct pm8916_wcd_analog_priv *wcd = snd_soc_component_get_drvdata(component);
> > > > -
> > > > -	switch (event) {
> > > > -	case SND_SOC_DAPM_PRE_PMU:
> > > > -		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
> > > > -				    MICB_1_INT_TX1_INT_RBIAS_EN_MASK,
> > > > -				    MICB_1_INT_TX1_INT_RBIAS_EN_ENABLE);
> > > > -		break;
> > > > -	}
> > > > -
> > > > -	return pm8916_wcd_analog_enable_micbias_int(component, event, w->reg,
> > > > -						     wcd->micbias1_cap_mode);
> > > > -}
> > > > -
> > > >    static int pm8916_mbhc_configure_bias(struct pm8916_wcd_analog_priv *priv,
> > > >    				      bool micbias2_enabled)
> > > >    {
> > > > @@ -564,9 +538,8 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
> > > >    	switch (event) {
> > > >    	case SND_SOC_DAPM_PRE_PMU:
> > > > -		snd_soc_component_update_bits(component, CDC_A_MICB_1_INT_RBIAS,
> > > > -				    MICB_1_INT_TX2_INT_RBIAS_EN_MASK,
> > > > -				    MICB_1_INT_TX2_INT_RBIAS_EN_ENABLE);
> > > > +		snd_soc_component_update_bits(component, CDC_A_MICB_2_EN,
> > > > +					      CDC_A_MICB_2_PULL_DOWN_EN_MASK, 0);
> > > >    		break;
> > > >    	case SND_SOC_DAPM_POST_PMU:
> > > >    		pm8916_mbhc_configure_bias(wcd, true);
> > > > @@ -576,8 +549,7 @@ static int pm8916_wcd_analog_enable_micbias_int2(struct
> > > >    		break;
> > > >    	}
> > > > -	return pm8916_wcd_analog_enable_micbias_int(component, event, w->reg,
> > > > -						     wcd->micbias2_cap_mode);
> > > > +	return pm8916_wcd_analog_enable_micbias_int(w, kcontrol, event);
> > > >    }
> > > >    static int pm8916_wcd_analog_enable_adc(struct snd_soc_dapm_widget *w,
> > > > @@ -878,12 +850,10 @@ static const struct snd_soc_dapm_route pm8916_wcd_analog_audio_map[] = {
> > > >    	{"SPK PA", NULL, "SPK DAC"},
> > > >    	{"SPK DAC", "Switch", "PDM_RX3"},
> > > > -	{"MIC BIAS Internal1", NULL, "INT_LDO_H"},
> > > > -	{"MIC BIAS Internal2", NULL, "INT_LDO_H"},
> > > > +	{"MIC BIAS Internal1", NULL, "MIC BIAS External1"},
> > > > +	{"MIC BIAS Internal2", NULL, "MIC BIAS External2"},
> > > >    	{"MIC BIAS External1", NULL, "INT_LDO_H"},
> > > >    	{"MIC BIAS External2", NULL, "INT_LDO_H"},
> > > > -	{"MIC BIAS Internal1", NULL, "vdd-micbias"},
> > > > -	{"MIC BIAS Internal2", NULL, "vdd-micbias"},
> > > >    	{"MIC BIAS External1", NULL, "vdd-micbias"},
> > > >    	{"MIC BIAS External2", NULL, "vdd-micbias"},
> > > >    };
> > > > @@ -937,11 +907,10 @@ static const struct snd_soc_dapm_widget pm8916_wcd_analog_dapm_widgets[] = {
> > > >    	SND_SOC_DAPM_SUPPLY("RX_BIAS", CDC_A_RX_COM_BIAS_DAC, 7, 0, NULL, 0),
> > > >    	/* TX */
> > > > -	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal1", CDC_A_MICB_1_EN, 7, 0,
> > > > -			    pm8916_wcd_analog_enable_micbias_int1,
> > > > -			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> > > > -			    SND_SOC_DAPM_POST_PMD),
> > > > -	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal2", CDC_A_MICB_2_EN, 7, 0,
> > > > +	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal1", CDC_A_MICB_1_INT_RBIAS, 7, 0,
> > > > +			    pm8916_wcd_analog_enable_micbias_int,
> > > > +			    SND_SOC_DAPM_PRE_PMU),
> > > > +	SND_SOC_DAPM_SUPPLY("MIC BIAS Internal2", CDC_A_MICB_1_INT_RBIAS, 4, 0,
> > > >    			    pm8916_wcd_analog_enable_micbias_int2,
> > > >    			    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> > > >    			    SND_SOC_DAPM_POST_PMD),
> > > > 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
