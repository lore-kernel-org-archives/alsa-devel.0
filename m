Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB235C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:38:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C4C3208E4
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 15:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IwaHGhbi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com header.i=@semihalf-com.20150623.gappssmtp.com header.b="V26TF9RU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4C3208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=semihalf.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45431847;
	Thu, 10 Sep 2020 17:38:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45431847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599752334;
	bh=Cpc3uAN1FJSWCtjEbnsvjRG/vgYDveHlRkJxE8jxdpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IwaHGhbiIVW/jOIRbzPKp4W5eqZ6kFFYMKCyEWz5NTB9xAxWrYCqj9gltmTlgBv0r
	 wFfaglz4ATuYpioFXsKJ6842FPaXVdvHS5P2hmwzxzTxViDqq5l4o2uHAsoYv1PC+H
	 dP+zl2lhyiQY1EqbAckY1Bl9SJtljR24Xzlx4IRs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30251F801F2;
	Thu, 10 Sep 2020 17:38:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0BB95F80264; Thu, 10 Sep 2020 17:38:01 +0200 (CEST)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1DB0F8010E
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 17:37:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1DB0F8010E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=semihalf-com.20150623.gappssmtp.com
 header.i=@semihalf-com.20150623.gappssmtp.com header.b="V26TF9RU"
Received: by mail-wm1-x341.google.com with SMTP id k18so475193wmj.5
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=semihalf-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zOv4Yx7m8nr1wvMGpIto7eo/RQlcFF6HnuE7bwkiImk=;
 b=V26TF9RU0H8cqirlOmhma1qZPwsk3YxxchuEmGY/8twdnEK1YS2MnwDIeU1daMBFjs
 k/DEqCZBPo+G3W8UJ3nwpjPLtJjQbu2fLnXWV3q6NvmLqgrkj/4oIPhIC96AyL4vEACU
 oLwgH5LsRkqY4EuIRR6v6oz0RQ8G5aBWM23n856vUQLnoO/xuVXDgswv8J6xhwi2kpKl
 QVgcffQn+sVZAA4xX3KYJNFGZRyJnC17+7gRQa4MkfGLw3j8aSq5N/ApJ9NL5VR7z/sd
 H/YDNse7EeeDDIlEDMJvfuMEZPAbrWqQXds7sG8j235L5cFAWeaEMHAXfFnQEeUJC5Wo
 2kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zOv4Yx7m8nr1wvMGpIto7eo/RQlcFF6HnuE7bwkiImk=;
 b=cy/cjE9i15Iv4ksVbdILieK8Hg/l9+UkYKxsgr2eS7VlRI9b8FMr2eCe8SD6Qbrl8i
 tohadTcudZR3+mbNK3cA9TXaCStY0I/SXahnsnPDPh+X3LfDKa0DnY7VIJCwW6y5Hp5r
 qbVyX1HmdjIAsF+8sQkk7DD2EchWFTAa42clcN1plVL3VpCutSQBR0p/krneewXFufvi
 XshXG+3/xqNB5cQkKbgoknZpI3/789csQldH6xR3NsEiY3154HnmPQ/OoId2jMHWaOmu
 LlytpUXZGl4wlzJRePvViRFu8Q7ervX875Ns8tw5c92WttmsHXuNVZFqWxK0VTVcykVw
 wC3g==
X-Gm-Message-State: AOAM531VhF70qqYip9S3Md/L4Z/XiGOT99RMTeuQUnk+XmMtvIa2hsrL
 Ffp+kKN1w683G7iDXbE+OgKF2P+75uPJBwXy+9RUDw==
X-Google-Smtp-Source: ABdhPJyIDFrKOnnP30G4eKbpPJvXcHHi4rzlnfXVwO1u6UWNESErT1eGx5zOz+KoNtJPUTNu7uY0AyPiHI2z0b5arVY=
X-Received: by 2002:a1c:6346:: with SMTP id x67mr607078wmb.42.1599752269789;
 Thu, 10 Sep 2020 08:37:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200908200314.22771-1-rad@semihalf.com>
 <50db252a-1274-f681-d5e7-e7fba839c0ee@linux.intel.com>
In-Reply-To: <50db252a-1274-f681-d5e7-e7fba839c0ee@linux.intel.com>
From: =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>
Date: Thu, 10 Sep 2020 17:37:34 +0200
Message-ID: <CAOs-w0+2uk56-R6RVhno=uTbK4m5UH+tmeiOfcTVgydUdPuXog@mail.gmail.com>
Subject: Re: [PATCH V3] ASoC: Intel: boards: Use FS as nau8825 sysclk in
 nau88125_* machine
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: Lech Betlej <Lech.Betlej@intel.com>, alsa-devel@alsa-project.org,
 Todd Broch <tbroch@google.com>, Harshapriya <harshapriya.n@intel.com>,
 John Hsu <KCHSU0@nuvoton.com>, Alex Levin <levinale@google.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 "Sienkiewicz, Michal" <michal.sienkiewicz@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Vamshi Krishna <vamshi.krishna.gopal@intel.com>,
 Marcin Wojtas <mw@semihalf.com>, linux-kernel@vger.kernel.org,
 Yong Zhi <yong.zhi@intel.com>
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

Thank you Pierre.
All your comments are addressed in V4.
skylake_nau8825_resume_post() is in fact unnecessary as my test shows
no difference if we do the FLL setup in skylake_nau8825_trigger().
patch is coming...

wt., 8 wrz 2020 o 22:59 Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> napisa=C5=82(a):


>
> Sorry, I couldn't resist adding three more comments to improve further:
>
> > -static int skylake_nau8825_hw_params(struct snd_pcm_substream *substre=
am,
> > -     struct snd_pcm_hw_params *params)
> > +static int skylake_nau8825_trigger(struct snd_pcm_substream *substream=
, int cmd)
> >   {
> >       struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> > +     struct snd_pcm_runtime *runtime =3D substream->runtime;
> >       struct snd_soc_dai *codec_dai =3D asoc_rtd_to_codec(rtd, 0);
> > -     int ret;
> > -
> > -     ret =3D snd_soc_dai_set_sysclk(codec_dai,
> > -                     NAU8825_CLK_MCLK, 24000000, SND_SOC_CLOCK_IN);
> > +     int ret =3D 0;
> >
> > -     if (ret < 0)
> > -             dev_err(rtd->dev, "snd_soc_dai_set_sysclk err =3D %d\n", =
ret);
> > +     switch (cmd) {
> > +     case SNDRV_PCM_TRIGGER_START:
> > +             ret =3D snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL=
_FS, 0,
> > +                                          SND_SOC_CLOCK_IN);
>
> Maybe a simple comment to explain what this does?
>
> > +             if (ret < 0) {
> > +                     dev_err(codec_dai->dev, "can't set FS clock %d\n"=
, ret);
> > +                     break;
> > +             }
> > +             ret =3D snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rat=
e,
> > +                                       runtime->rate * 256);
> > +             if (ret < 0)
> > +                     dev_err(codec_dai->dev, "can't set FLL: %d\n", re=
t);
> > +             break;
>
> You could replace this by a /* fallthrough */ statement?
>
> > +     case SNDRV_PCM_TRIGGER_RESUME:
> > +             ret =3D snd_soc_dai_set_pll(codec_dai, 0, 0, runtime->rat=
e,
> > +                                       runtime->rate * 256);
> > +             if (ret < 0)
> > +                     dev_err(codec_dai->dev, "can't set FLL: %d\n", re=
t);
> > +             break;
> > +     }
>
> > +static int __maybe_unused skylake_nau8825_resume_post(struct snd_soc_c=
ard *card)
> > +{
> > +     struct snd_soc_dai *codec_dai;
> > +
> > +     codec_dai =3D snd_soc_card_get_codec_dai(card, SKL_NUVOTON_CODEC_=
DAI);
> > +     if (!codec_dai) {
> > +             dev_err(card->dev, "Codec dai not found\n");
> > +             return -EIO;
> > +     }
> > +
> > +     dev_dbg(codec_dai->dev, "playback_active:%d playback_widget->acti=
ve:%d codec_dai->rate:%d\n",
> > +             codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK],
> > +             codec_dai->playback_widget->active,
> > +             codec_dai->rate);
> > +
> > +     if (codec_dai->stream_active[SNDRV_PCM_STREAM_PLAYBACK] &&
> > +         codec_dai->playback_widget->active)
> > +             snd_soc_dai_set_sysclk(codec_dai, NAU8825_CLK_FLL_FS, 0,
> > +                                    SND_SOC_CLOCK_IN);
>
> And that part is also worthy of a comment, e.g. why not do this as part
> of the TRIGGER_RESUME and why only for playback?
>
>
> > --- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
> > +++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
>
> same comments for this other machine driver.
>
