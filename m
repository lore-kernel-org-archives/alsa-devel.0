Return-Path: <SRS0=cpJH=YO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC61DCA9EB0
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:39:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01BB214AE
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 19:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pCx7ZEVj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="XKXkc88h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01BB214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 771139F6;
	Mon, 21 Oct 2019 21:38:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 771139F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571686778;
	bh=TzY4hH5+OcghcM7wHbJzFiiGF1xpZ6b78VnD0X9Ztpc=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pCx7ZEVj3LYZa5VA35GW4PoRocxcJP100vk8YdTUHWDGggAX0DWIscY8+ZeJn3qs8
	 d7G8hDjC9vysDtNgJX6NZwltW+LebHX6YBkqDQdh6YJQwR7HXKYTWMZso9Y2IpHRCu
	 jRDQih3IvjW5rgEpJtW2oUvNcacGVIWHUviRkpEY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED53FF80321;
	Mon, 21 Oct 2019 21:38:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 11FEAF80368; Mon, 21 Oct 2019 21:38:46 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0F4AFF80112
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 21:38:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0F4AFF80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="XKXkc88h"
Received: by mail-qk1-x743.google.com with SMTP id f18so13264821qkm.1
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8qHokbgu9blUotjBQyHcClGPYSbxHG/UB94S6R9JMkE=;
 b=XKXkc88hk+zJmcYzv5wO0oXBwEQKwdUtZM4iNJXuytVyioToRwm15NJEq5RzZRnZR7
 tgZO0Tb0CJeB3YfnNsmQ5eOUrJ/5YMsb/p1hMmuTdFvw+pU4Iu8pEeIKBSTz1z0kwJKB
 aTD6d4VtrbJIfzl9fypAkcprXAShFruMBgZanAR97hEWVOSJFXumaBis/ffczuHBk1za
 wNVkvcHN9TQ+KezezE2S9N+HJjd6BMVe7SA1+WRlBzd/fCl7ff0CaFA942zYf3O0VMhw
 EfQMjG2VkCJRsa32piMYHoAbt3J96rGsLgi+VTKIMs7uvRBQ2ALFxEU18kDEB1El77IM
 +PpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8qHokbgu9blUotjBQyHcClGPYSbxHG/UB94S6R9JMkE=;
 b=FRx7xUAPzpTlp0RG5m363A7qKco5ipw7B/hDahdESeRxajcWux6csnbAKD3D9a4biG
 N+dd13YB8Iy4YvBGWe9MzXoK4AuvPTeaD3576rlGcpwvxg1QXP5gIoer8m2G3YPN9kpZ
 z9BmtiEqzALMrUPIFxRU68+74QIkHTcldtwyurZCUlILdGiKHuX4jq0s0FoKYpZ5TnrR
 4PPNHRu0NKT4GiUE/zYaoZMXV+LYjS79AV34VsfGAY5pkut0xWNGj4A1pdCD/gtosqEY
 veDcBzNfJBmpeKoBL4LuKUcxR8t/T6HWhFDjg3DIFs7319urBJHlARwzNRNVtHa6wdGn
 8QRQ==
X-Gm-Message-State: APjAAAVaB9EOI1nmaVJYbhzz7+ztmxvf497ywDopOx+buuPGgvUBeLvt
 fwiXO0zf9oaMDQLR/+4xcGA6iBDYDo6rOm1KuceNrw==
X-Google-Smtp-Source: APXvYqwP8grPe3Qq4J11lqi/byBaQ6UIBU3S7HiLJDQIH5XBdDBIZ68+0pR19oswf29VK3cPf+taAwDxgQp7wLf1Ly0=
X-Received: by 2002:a37:6d04:: with SMTP id i4mr24496712qkc.36.1571686720591; 
 Mon, 21 Oct 2019 12:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191018200449.141123-1-cujomalainey@chromium.org>
 <20191018200449.141123-12-cujomalainey@chromium.org>
 <6be89c8d-e3d4-311f-667c-8e7096f76fab@intel.com>
In-Reply-To: <6be89c8d-e3d4-311f-667c-8e7096f76fab@intel.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Mon, 21 Oct 2019 12:38:29 -0700
Message-ID: <CAOReqxg1chOd56PTho1ggUSmRnukajjGJqF3vLdS8poQPNhotg@mail.gmail.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 ALSA development <alsa-devel@alsa-project.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Ben Zhang <benzh@chromium.org>, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Richard Fontana <rfontana@redhat.com>, Mark Brown <broonie@kernel.org>,
 Bard Liao <bardliao@realtek.com>, Curtis Malainey <cujomalainey@chromium.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [alsa-devel] [PATCH v2 11/12] ASoC: rt5677: Set ADC clock to
 use PLL and enable ASRC
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

On Sun, Oct 20, 2019 at 1:38 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2019-10-18 22:04, Curtis Malainey wrote:
> > Use the PLL to kept the correct 24M clock rate so frequency shift does
> > not occur when using the DSP VAD.
> >
>
> > +static int bdw_rt5677_dsp_hw_params(struct snd_pcm_substream *substream,
> > +     struct snd_pcm_hw_params *params)
> > +{
> > +     struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +     struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +     int ret;
> > +
> > +     ret = snd_soc_dai_set_sysclk(codec_dai, RT5677_SCLK_S_PLL1, 24576000,
> > +             SND_SOC_CLOCK_IN);
> > +     if (ret < 0) {
> > +             dev_err(rtd->dev, "can't set codec sysclk configuration\n");
> > +             return ret;
> > +     }
> > +     ret = snd_soc_dai_set_pll(codec_dai, 0, RT5677_PLL1_S_MCLK,
> > +             24000000, 24576000);
> > +     if (ret < 0) {
> > +             dev_err(rtd->dev, "can't set codec pll configuration\n");
> > +             return ret;
>
> nitpick: you may skip "return ret" here and drop parenthesis as
> function's final line does the job.
>
> > +     }
> > +
> > +     return ret;
>
> If you decide to stick with leaving above as is, explicitly returning 0
> would be preferred.
>
fair enough, if there are no issues with the patch series I can follow
it up with a quick change to return 0.
>
> > +}
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
