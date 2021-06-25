Return-Path: <SRS0=Xi7p=LT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91E3C2B9F4
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jun 2021 18:32:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7237C61965
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Jun 2021 18:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7237C61965
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0CD8615E0;
	Fri, 25 Jun 2021 20:31:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0CD8615E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624645950;
	bh=RFVeIJmoo0aFiStaRLl6H03MHBsgxsuVTaev9Lazlao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ciAUQMmUvjMp9na9ozgYNtpdkmk+mqbR7yAn1kL/LU5LgZt+bsowwF/uayI+cYoTP
	 fLFhIQIkQdvo5Jw08o5d2LUNKNoEVXFsBObElSye0dgM58utfASbZqgrHKXoFKg4mz
	 HGIr8i6TkDGx6KwafoT/MeB195Ss/DbYnFOb004o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95D03F8016D;
	Fri, 25 Jun 2021 20:31:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2270F801D5; Fri, 25 Jun 2021 20:31:38 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 29A4CF8012C
 for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2021 20:31:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29A4CF8012C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.b="vz0uf+jF"
Received: by mail-qk1-x735.google.com with SMTP id g4so20200523qkl.1
 for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2021 11:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hPH2YYNvruWjMm4MiZmXdOLersZ3pJou1O91ls+75Hg=;
 b=vz0uf+jFyJ96Ot7qI/AaKKjadYw4e+0rNTupbZALdCMkUSc/r2FzCtrVJiDOkcATnk
 wu1YlPRnS6533QDGZztwPuQWOdI/YtJUDoqgm332IyQCo0gGSS5lssB6ifl6atMAm5e8
 KKFFTm7+hJ3N0jTxR5kXTBFlePK8mnVFU0eyaqZpKzpMys+id0P9VcQCeBn0JbRWm+LG
 nUNlq0+4/u3tobpr+TPdon7F4R6dhyypRhSPkO6doA5vCW8iy8eqZg8BgpZo0FgVBwGz
 XJeH2m3qBCxRCXx5cihzCW/0R3I+DJmz4K8wkZqj2tO/Z+vIFI+l1yFSdhh4IyP56A+X
 cVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hPH2YYNvruWjMm4MiZmXdOLersZ3pJou1O91ls+75Hg=;
 b=LuG57RhvylrEzkxCxSTKssp8Nh1I31dZmD29lGKHokQEW7mfm7jWp367KQqRxYvhkL
 rYMZyVW7P32JnR+KDY3IzPE+mUSgFMdHXLVIehYOnRfG1NsgSkT6ZrDBL7rrh+ms/rNt
 BSWOXTrLsoCt/1FQbaNu1ZFpZ7uzLMQ39R46MaVZhGoo7LYUgDDRFRN7ZB7Rba1soNyZ
 XnFlz+BluBh6iGv9ptaGLrbHt96nUV+pbpL/nQHw5uPuEuDVtv0+0cxZyS45UWWxsdwq
 oOxLUtwTuwI/sVNQkUOfzNhFf9W4+SPYmbXHVg+EHWZZxgvzdJ7Uso0/kKjfZMdiSpXc
 yLTQ==
X-Gm-Message-State: AOAM533aEOC22YaQalWlNR7tqMyd+98ZrPqEUUvbTmYpexqDLXHj3em2
 GZ+bTjS7YR90R92s2Wo0M4GNJAuB0p3q49YowzsO1g==
X-Google-Smtp-Source: ABdhPJyUQZu5jqnUbsaB6sC6mDjhmHvAxbP1jnarZHr0t5J671lVzYlpyrcJhfUU17E0tp6qTY5GMHPAtMrAldVGo94=
X-Received: by 2002:a37:66d0:: with SMTP id
 a199mr12972648qkc.238.1624645890003; 
 Fri, 25 Jun 2021 11:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210617090809.16901-1-shumingf@realtek.com>
 <20210617123914.GD5067@sirena.org.uk>
 <d6374c5158c844d69b4f546fd741f07f@realtek.com>
 <20210617132716.GE5067@sirena.org.uk>
 <638be5ea-a310-3711-df08-798f7bee5804@linux.intel.com>
 <CAOReqxhDT8Z6jC89=m_Hka4diaxJqwhyKZmrVAw626wAAL72Fw@mail.gmail.com>
In-Reply-To: <CAOReqxhDT8Z6jC89=m_Hka4diaxJqwhyKZmrVAw626wAAL72Fw@mail.gmail.com>
From: Curtis Malainey <cujomalainey@google.com>
Date: Fri, 25 Jun 2021 11:31:19 -0700
Message-ID: <CAOReqxhY2zZJ4zsHvhHhDFuFawUnVtrcuuHiJ1g_n_0+7cMPcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ASoC: rt711: remap buttons
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "lars@metafoo.de" <lars@metafoo.de>,
 Jimmy Cheng-Yi Chiang <cychiang@google.com>,
 Curtis Malainey <cujomalainey@chromium.org>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
 Mark Brown <broonie@kernel.org>,
 =?UTF-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
 "Flove\(HsinFu\)" <flove@realtek.com>,
 =?UTF-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
 "jairaj.arava@intel.com" <jairaj.arava@intel.com>, "Lu,
 Brent" <brent.lu@intel.com>, "bard.liao@intel.com" <bard.liao@intel.com>
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

> > Intel has no specific requirement, we just follow what the Google 4-button description says [1]
> >
> > That said, I can't recall why half of the machine drivers follow one pattern and the other half a different one.
> >
> > Same as spec:
> > sof_da7219_max98373.c:  snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> > sof_da7219_max98373.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> > sof_da7219_max98373.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> > sof_da7219_max98373.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
> >
> > sof_cs42l42.c:  snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> > sof_cs42l42.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOLUMEUP);
> > sof_cs42l42.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEDOWN);
> > sof_cs42l42.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
> >
> > swap wrt. spec:
> > sof_sdw_rt711.c:        snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> > sof_sdw_rt711.c-        snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> > sof_sdw_rt711.c-        snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> > sof_sdw_rt711.c-        snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> >
> > kbl_rt5663_max98927.c:  snd_jack_set_key(jack->jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
> > kbl_rt5663_max98927.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_1, KEY_VOICECOMMAND);
> > kbl_rt5663_max98927.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_2, KEY_VOLUMEUP);
> > kbl_rt5663_max98927.c-  snd_jack_set_key(jack->jack, SND_JACK_BTN_3, KEY_VOLUMEDOWN);
> >
> > Brent, Curtis, Jimmy, can you comment on the order?
>
> Sorry for the late reply, I couldn't figure out why this slipped by my
> email filter, I guess I should look closer next time. Soraka has been
> checked (kbl_rt5663_max98927) and yes the mapping does appear to be
> incorrect, volume up key returns voice command in evtest. Sathya will
> have to check the headset button mapping, on rt711 but my guess is it
> is also incorrect.

I stand corrected, misread the datasheet. So rt711 and rt5663 are
correct based on datasheet specs but when grabbing an off the shelf
headphone they did not work with the volume up. Hmm, I wonder if this
split is "what usually works" and "what is correct."
