Return-Path: <SRS0=XYKd=JY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEEDC433ED
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 11:13:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E98B613F5
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Apr 2021 11:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E98B613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A2EBD16DF;
	Tue, 27 Apr 2021 13:13:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A2EBD16DF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1619522030;
	bh=qIlNf/IEIW3ook//3IongKpRAdJ8biD/0JEOYampAqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n/rTMbcteWjye8AvhagJpTg+kWKgxg99gDZ7w4q6kWV01jWEjNsTISdMS3L6+WGoo
	 rxpIBnRG8jjDhJV9p2ON6Jor32tiaLgXAiVw+UhHsW8f/dWDkEtRDYaJT8LOt2vQnt
	 CM95qtHlnkM1WKIvUyVf3JGDFELz7bzGqLHSXAws=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD7F1F8012A;
	Tue, 27 Apr 2021 13:12:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D492F801EC; Tue, 27 Apr 2021 13:12:57 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04846F8012A
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 13:12:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04846F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="bg8BRGZe"
Received: by mail-qk1-x72b.google.com with SMTP id v23so7460224qkj.13
 for <alsa-devel@alsa-project.org>; Tue, 27 Apr 2021 04:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0hP9KV+QzDMi9Ee3A915nGBhou5oqVpoVswUzp1mehQ=;
 b=bg8BRGZeDyUMhxijqaqZ2uEmaDmSiY82LeYiRIRNuBPn3Tyod3SucxVqlvtzvkcc4g
 43fRU7nmDwN5gZ8Rt5ZPQZYHJWDdDa2UOSX9heML9Q73tAUEww046ugWvUJ4Ai+NpBOj
 /pL/ibGJ654F8rgriYQxq+87LoRSaAmio77R2XzGN1G4KBohpX6Ct65Oiz3OGkOsUXzK
 GpX9eCa9eU1hBRdsto7u8rKTfvh/YbpCRqfina9A7LQBjIAVl55ArmGThHQvOSy7cdOz
 YNQHW070OAaqsZTb+pndAVPl3739f9egFm+JyjYXYBoRVAcDbpr38vkYPcc8igCpVlCy
 z3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0hP9KV+QzDMi9Ee3A915nGBhou5oqVpoVswUzp1mehQ=;
 b=mcK00dFtPGRygOfEn0eITVN/f8XAgF7KexMXVhftJMsNn/jer0ICedQTf/lhfshGOI
 yR/aAJDy3w1szExHNb89A86ogT8WiQPQFpy22D9QvV6DrfuSh9gNaqHGq4ZbnpcRyKNk
 YhFnjAmIWxdpDUPmIdg/VePKpxY/+D/7gObLy8meQMlYeRd1Inwgpzp9WMl4ErAd07OU
 vilAZ4jxB8YjABdicK9aM4vk/GlXZjHP4PAKny31X6PiIhthU6Vn8LesfryNDFnd72pR
 H6RavSmsqFfPYOAvglsbx4h3JEh/X0JeihteNZVe7ANPPraQ1+W2fvartxFtqFOeZyeT
 T1QQ==
X-Gm-Message-State: AOAM531CMZjN4uxcigs3bjY64HFO9vfZUL7j+xNwLpMZSuCMSDiJSpFz
 NOzp/zsrukrayiRpZHY1sYfcRjv67vhJ0V+N/aY=
X-Google-Smtp-Source: ABdhPJxbs9d47JINdGB66ElNk6J0qHjHBi2Nw+rqEbRhR/7qc+uJbqNSiGD2C//W9pmtLQdJy/4eEHKA9sB2WaDZHzM=
X-Received: by 2002:a05:620a:2903:: with SMTP id
 m3mr10050569qkp.37.1619521964090; 
 Tue, 27 Apr 2021 04:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <1619519663-10406-1-git-send-email-shengjiu.wang@nxp.com>
 <s5hpmygyp2x.wl-tiwai@suse.de>
In-Reply-To: <s5hpmygyp2x.wl-tiwai@suse.de>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Tue, 27 Apr 2021 19:12:33 +0800
Message-ID: <CAA+D8ANB1CZ41Qz6HK2uxT6QjHV3zfL0ayT59oYExX8h5ccW6Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] ALSA: pcm: Add support for 705.6KHz and 768KHz sample
 rate
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>
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

On Tue, Apr 27, 2021 at 6:56 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 27 Apr 2021 12:34:22 +0200,
> Shengjiu Wang wrote:
> >
> > Some high resolution codecs support 705.6KHz and 768KHz rates.
> > So extend supported sample rate to 768kHz in pcm.h.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> How many devices require it for now?

I have two devices, AK4458, AK5558.

>
> I don't want to extend the core definitions blindly unless those rates
> are really commonly used.  You can add those specific rates in the
> codec driver instead.

Ok, this is an option.

>
>
> thanks,
>
> Takashi
>
> > ---
> >  include/sound/pcm.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> > index 2e1200d17d0c..88056824ffec 100644
> > --- a/include/sound/pcm.h
> > +++ b/include/sound/pcm.h
> > @@ -121,6 +121,8 @@ struct snd_pcm_ops {
> >  #define SNDRV_PCM_RATE_192000                (1<<12)         /* 192000Hz */
> >  #define SNDRV_PCM_RATE_352800                (1<<13)         /* 352800Hz */
> >  #define SNDRV_PCM_RATE_384000                (1<<14)         /* 384000Hz */
> > +#define SNDRV_PCM_RATE_705600                (1<<15)         /* 705600Hz */
> > +#define SNDRV_PCM_RATE_768000                (1<<16)         /* 768000Hz */
> >
> >  #define SNDRV_PCM_RATE_CONTINUOUS    (1<<30)         /* continuous range */
> >  #define SNDRV_PCM_RATE_KNOT          (1<<31)         /* supports more non-continuos rates */
> > @@ -136,6 +138,9 @@ struct snd_pcm_ops {
> >  #define SNDRV_PCM_RATE_8000_384000   (SNDRV_PCM_RATE_8000_192000|\
> >                                        SNDRV_PCM_RATE_352800|\
> >                                        SNDRV_PCM_RATE_384000)
> > +#define SNDRV_PCM_RATE_8000_768000   (SNDRV_PCM_RATE_8000_768000|\
> > +                                      SNDRV_PCM_RATE_705600|\
> > +                                      SNDRV_PCM_RATE_768000)
> >  #define _SNDRV_PCM_FMTBIT(fmt)               (1ULL << (__force int)SNDRV_PCM_FORMAT_##fmt)
> >  #define SNDRV_PCM_FMTBIT_S8          _SNDRV_PCM_FMTBIT(S8)
> >  #define SNDRV_PCM_FMTBIT_U8          _SNDRV_PCM_FMTBIT(U8)
> > --
> > 2.27.0
> >
