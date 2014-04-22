From: Oder <oder_chiou@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: Add codec driver
Date: Tue, 22 Apr 2014 09:04:31 +0800
Message-ID: <CAD+35SOp8qTv3OSHVj_L7Z-crsgq1kHHNrpAiekh6oOa7tXCSg@mail.gmail.com>
References: <1397212459-26495-1-git-send-email-oder_chiou@realtek.com>
 <20140414202837.GA25182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id B77552608B7
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 03:04:42 +0200 (CEST)
Received: from mail.realtek.com (rtitcas11.realtek.com.tw[172.21.6.12])
 by rtits2.realtek.com (8.14.5/2.37/5.60) with ESMTP id s3M14Yrt011572
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 09:04:35 +0800
Received: by mail-la0-f52.google.com with SMTP id el20so317956lab.25
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 18:04:31 -0700
 (PDT)
In-Reply-To: <20140414202837.GA25182@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org

>
> > +static int rt5645_set_bias_level(struct snd_soc_codec *codec,
> > +                     enum snd_soc_bias_level level)
> > +{
> > +     switch (level) {
> > +     case SND_SOC_BIAS_STANDBY:
> > +             if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
> > +                     snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
> > +                             RT5645_PWR_VREF1 | RT5645_PWR_MB |
> > +                             RT5645_PWR_BG | RT5645_PWR_VREF2,
> > +                             RT5645_PWR_VREF1 | RT5645_PWR_MB |
> > +                             RT5645_PWR_BG | RT5645_PWR_VREF2);
> > +                     mdelay(10);
> > +                     snd_soc_update_bits(codec, RT5645_PWR_ANLG1,
> > +                             RT5645_PWR_FV1 | RT5645_PWR_FV2,
> > +                             RT5645_PWR_FV1 | RT5645_PWR_FV2);
> > +                     snd_soc_update_bits(codec, RT5645_GEN_CTRL1,
> > +                             RT5645_DIG_GATE_CTRL,
> RT5645_DIG_GATE_CTRL);
> > +             }
> > +             break;
>
> Since the device can power up and down very quickly it should make sense
> to set idle_bias_off for a power saving when idle.


We've set the idle_bias_off as true in struct "soc_codec_dev_rt5645", is
there any thing i miss it?
