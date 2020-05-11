Return-Path: <SRS0=FWLr=6Z=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151C7C47255
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 11:17:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB1420722
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2020 11:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oDBzaqLm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="GGicKJpN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB1420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD677886;
	Mon, 11 May 2020 13:16:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD677886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589195852;
	bh=XpA5UHgxiolQdC8ooRvuNIgbH0vSrDbRZZHaUrUCALo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oDBzaqLmFkoPtBRDQjDOOGW5dx5DQ0Kkpt5HRb7At6yXQ3ogZZt3op465WTI22dDM
	 eMUnELbHlzMRkTP0KlwaiUYk5sdQSUFaWlFnO+kD93lzhopGQhd3IJL8a9+qSaFlRw
	 RbMdSrbMOGndAaFoluwdduBQZlF2jHUrrMmGarHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BD6FF8014C;
	Mon, 11 May 2020 13:16:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9B104F80157; Mon, 11 May 2020 13:16:39 +0200 (CEST)
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C7C2F80107
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 13:16:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C7C2F80107
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="GGicKJpN"
Received: by mail-io1-xd42.google.com with SMTP id k18so128032ion.0
 for <alsa-devel@alsa-project.org>; Mon, 11 May 2020 04:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wbytLfV4nmOtT0WgpBXIzwMsuo72DJMmTPcAhYekQ0U=;
 b=GGicKJpNPw7jAN/rD2qfcGoBsewTM9yTpWHwOSs1ydICyaOkGevGh7f6hMspssZYWk
 GuGzM2V/S+FhT4YqGnPVXyEC/XVlZnvOQup/ahmdBd8dk4Brcf5P2J/9RQBlISadaFTr
 2tblRXp+0oLHkJHn24qCIJYgNQTnRUA5+ni6HjmrsMaU+Uex9KKc1mHPHJjS5KxvKKKz
 Y+jOBzYrbZlZXe/vUlW3EyrHRxMxlc0V666g4NLrseIiBHdiDClcA7RdBDjWbENeVjLD
 xY9KyCk1lkihyPppzLyiae6u3UNTXm4u/o4G5UX2RilFW0ei1t8U5Lc7brfLQ3HXQPtD
 DTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wbytLfV4nmOtT0WgpBXIzwMsuo72DJMmTPcAhYekQ0U=;
 b=AG+s8AyHqIImjcOUCEyJTd/yACZLfIeGAd7rzsWLos7CHC/VVQvu0ujnhAOOA8yCbS
 WUAZrwfKLof6BuPHsgOwEY9E2idifA2BRlJKyWaaI1mrT0pz3s+nwqzmW13gldOn1VWL
 jOtICd4bounQXhUr0rpga/TkeLY678WsFurzaXk8gFH4Aa6TobJ0ZfaMZeSQPCScMHMj
 o2imkiTV4tHnKUzhbBLyLjPmDkNT0Uc9GJUOSTTTVubSH5biRbWdhQfnqfsyZ/frkwyZ
 g3NVcoejCivbE6LAaw+IelGAcmqST+V37xWEgCSEZ8mxWCkAPZZTBglB7dd8dFgbVOAO
 CqNQ==
X-Gm-Message-State: AGi0Pua6J5ncwwgF9nxBIsupnFYXjmISEj6+y44Z7VQEb3aW0gGZiZZ0
 XejhJFnWR7Rn5WvSRwrUnlvQuj2jISm1YGxYbe+Qtw==
X-Google-Smtp-Source: APiQypKBE93oJ/QzEILEEGG3u1vcqebBiJg/mZkuW2yYf35ojFi2IQ3SxLCoeZ7UmK43yS0JteXo8EYe8o/AWjacEZU=
X-Received: by 2002:a05:6638:a47:: with SMTP id
 7mr14399062jap.12.1589195790247; 
 Mon, 11 May 2020 04:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200509031919.9006-1-steves.lee@maximintegrated.com>
In-Reply-To: <20200509031919.9006-1-steves.lee@maximintegrated.com>
From: Tzung-Bi Shih <tzungbi@google.com>
Date: Mon, 11 May 2020 19:16:19 +0800
Message-ID: <CA+Px+wUdavr-qqEEng86ZAuwx++J-qB3va7p28EjOx-K9SyBtg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: max98390: Added Amplifier Driver
To: Steve Lee <steves.lee.maxim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Cc: jack.yu@realtek.com, ALSA development <alsa-devel@alsa-project.org>,
 ryan.lee.maxim@gmail.com, ckeepax@opensource.cirrus.com,
 steves.lee@maximintegrated.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, nuno.sa@analog.com,
 Mark Brown <broonie@kernel.org>, geert@linux-m68k.org, dmurphy@ti.com,
 =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 srinivas.kandagatla@linaro.org, rf@opensource.wolfsonmicro.com
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

(The patch passed 2 round review in https://crrev.com/c/2083354)

On Sun, May 10, 2020 at 4:23 PM Steve Lee <steves.lee.maxim@gmail.com> wrote:
> +static int max98390_dai_set_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
> +{
> +       struct snd_soc_component *component = codec_dai->component;
> +       struct max98390_priv *max98390 =
> +               snd_soc_component_get_drvdata(component);
> +       unsigned int mode;
> +       unsigned int format;
> +       unsigned int invert;
> +
> +       dev_dbg(component->dev, "%s: fmt 0x%08X\n", __func__, fmt);
> +
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBS_CFS:
> +               mode = MAX98390_PCM_MASTER_MODE_SLAVE;
> +               break;
> +       case SND_SOC_DAIFMT_CBM_CFM:
> +               max98390->master = true;
> +               mode = MAX98390_PCM_MASTER_MODE_MASTER;
> +               break;
> +       default:
> +               dev_err(component->dev, "DAI clock mode unsupported\n");
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(max98390->regmap,
> +               MAX98390_PCM_MASTER_MODE,
> +               MAX98390_PCM_MASTER_MODE_MASK,
> +               mode);
> +
> +       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +       case SND_SOC_DAIFMT_NB_NF:
> +               break;
> +       case SND_SOC_DAIFMT_IB_NF:
> +               invert = MAX98390_PCM_MODE_CFG_PCM_BCLKEDGE;
> +               break;
> +       default:
> +               dev_err(component->dev, "DAI invert mode unsupported\n");
> +               return -EINVAL;
> +       }
> +
> +       regmap_update_bits(max98390->regmap,
> +               MAX98390_PCM_MODE_CFG,
> +               MAX98390_PCM_MODE_CFG_PCM_BCLKEDGE,
> +               invert);
invert will be uninitialized in the SND_SOC_DAIFMT_NB_NF case.

> +static int max98390_dai_hw_params(struct snd_pcm_substream *substream,
> +               struct snd_pcm_hw_params *params,
> +       struct snd_soc_dai *dai)
Lack of 1 tab indent.

> +static int max98390_adaptive_rdc_get(struct snd_kcontrol *kcontrol,
> +               struct snd_ctl_elem_value *ucontrol)
> +{
> +       int rdc, rdc0;
> +       struct snd_soc_component *component =
> +               snd_soc_kcontrol_component(kcontrol);
> +       struct max98390_priv *max98390 =
> +               snd_soc_component_get_drvdata(component);
> +
> +       regmap_read(max98390->regmap, THERMAL_RDC_RD_BACK_BYTE1, &rdc);
> +       regmap_read(max98390->regmap, THERMAL_RDC_RD_BACK_BYTE0, &rdc0);
> +       rdc0 |= rdc << 8;
> +       ucontrol->value.integer.value[0] = rdc0;
ucontrol->value.integer.value[0] = rdc0 | (rdc << 8);

> +static int max98390_dsm_init(struct snd_soc_component *component)
> +{
> +       int ret;
> +       const char *filename;
> +       struct max98390_priv *max98390 =
> +               snd_soc_component_get_drvdata(component);
> +       const struct firmware *fw = NULL;
> +       char *dsm_param = NULL;
Don't need to initialize fw and dsm_param in the case.

> +
> +       filename = "dsm_param.bin";
Either:
- initialize when declaring the variable
- remove the variable and inline into request_firmware() call

> +       ret = request_firmware(&fw, filename, component->dev);
> +       if (ret) {
> +               dev_err(component->dev,
> +                       "Failed to acquire dsm params: %d\n", ret);
> +               goto err;
> +       }
> +
> +       dev_info(component->dev,
> +               "max98390: param fw size %d\n",
> +               fw->size);
> +       dsm_param = (char *)fw->data;
> +       dsm_param += MAX98390_DSM_PAYLOAD_OFFSET;
> +       regmap_bulk_write(max98390->regmap, DSM_EQ_BQ1_B0_BYTE0,
> +               dsm_param,
> +               fw->size - MAX98390_DSM_PAYLOAD_OFFSET);
> +       release_firmware(fw);
> +       regmap_write(max98390->regmap, MAX98390_R23E1_DSP_GLOBAL_EN, 0x01);
> +
> +err:
> +       return ret;
> +}

> +static int max98390_probe(struct snd_soc_component *component)
> +{
> +       struct max98390_priv *max98390 =
> +               snd_soc_component_get_drvdata(component);
> +
> +       /* Update dsm bin param */
This comment makes more sense if before max98390_dsm_init().

> +       regmap_write(max98390->regmap, MAX98390_SOFTWARE_RESET, 0x01);
> +       /* Sleep reset settle time */
> +       msleep(20);
> +       max98390_dsm_init(component);

> +       /* Check Revision ID */
> +       ret = regmap_read(max98390->regmap,
> +               MAX98390_R24FF_REV_ID, &reg);
> +       if (ret < 0) {
if (ret)
