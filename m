Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC25C07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 17:51:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93CB61CC1
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 17:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93CB61CC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 610BE82C;
	Wed,  7 Jul 2021 19:50:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 610BE82C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625680282;
	bh=VaDNkWqm5uNtk7vVWSx8NJ+2DWuA5Q07T0+J+u7NMMY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IufbXWhn4YZ45Yv6Vy7RFydL7kcH9ZS1SRHvWXXmqPA9YUo26uRvjafOPVe9fnodb
	 +m3nRP1dwrCZSznvqryNr+PkxBOq1LJDHgvUD7/7JwXtz9qrFkOfp5wLefQK3zcEg6
	 hWWnvNN8Zr/Vz+79xWyORES2iEt5zzKig/0qrnPo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EE43AF8016C;
	Wed,  7 Jul 2021 19:50:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 364B6F80224; Wed,  7 Jul 2021 19:50:31 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 257E6F8012A
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 19:50:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 257E6F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="tnlVHHbZ"
Received: by mail-ej1-x633.google.com with SMTP id hc16so4589928ejc.12
 for <alsa-devel@alsa-project.org>; Wed, 07 Jul 2021 10:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OIkLwkBAX13D9qppUWtPCZH/Qq7ZqIfNxEiM6945sQ8=;
 b=tnlVHHbZs+0/Sb6fnbPDT9W/lEfr/Np1DpsPYVeiAgTYSuSutd8nvY7KCtHiRSOqGM
 RMuWP3mPFcEbSNQ92cZ6oq21YU73uL+catc/NKYxa3CNyPx+qlgzd+m9eQicVRNXcqY3
 nmcsoHPJoDqlVnBNuZG06jqIzFMXpzQ3hXp7FJ5B2b/w2g3fg95v+ELFnMVy5VFCAdCK
 WRvmVi/XjkFInkn8CVTcFtxcTf7EzodIGVAcvEGPgRdN+B+BC8BvR4B9yGe45wpCsetn
 SkH+QD81NQBcHIX6EQmSDa9QIkg/eKJjqfbpxoiDFxow3pu/3YPy1jQdpOXcfAEvWFlL
 tIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OIkLwkBAX13D9qppUWtPCZH/Qq7ZqIfNxEiM6945sQ8=;
 b=Dt6BdyCtpUJdZoZtQC6dcneDjtrAWsDkFDcocB2RCZVXUCbiYmQuIsouYh6bBFR2yo
 DlQTunBqFplE8oNO5B2UrKl5uGCbs7pZbSexDQPqlx5AwenhsMOa7EANSWTqU+6n9u94
 vITbFEOJfcEuzvP74q8BcGgakT6YG0vvWX2b8S0JV4eQOuDLDcmUer5qzGpEYOo04p5V
 kSlzTUvQpVJcnn9+zNtt8v8Gp3h9GYf4aGjaEdd0uDVt31Oiv4kDbcSBmWYfEbESbE9I
 eJPC7b9BNNIpc11Hk53JYkbu1+cj0ctSDCa/bYa2/NiwFJfS6DdQOVeRvgJc2UJ1+qoQ
 npGg==
X-Gm-Message-State: AOAM530I6gC98VmjofbO3k8sCaFkcUCqYkNfp9WHcNcTLpBi5Uyn4egJ
 6KSSHZi0OrBOaLI4vrD8vo2Ugdv/rWZ9V9rQ8c0=
X-Google-Smtp-Source: ABdhPJyXV09RM9rSxNu2QjCrzq76TegWSfCyvqMEqREhJbRgLyikdNeaa07eF8Yf807ykK8SOJBa0WxKUmVpIfSi4bE=
X-Received: by 2002:a17:906:e088:: with SMTP id
 gh8mr3389574ejb.125.1625680219108; 
 Wed, 07 Jul 2021 10:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <YJ4yBmIV6RJCo42U@google.com> <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com> <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com> <s5hbl9b6mah.wl-tiwai@suse.de>
 <CAMo8BfKKMQkcsbOQaeEjq_FsJhdK=fn598dvh7YOcZshUSOH=g@mail.gmail.com>
 <s5ho8be8v3z.wl-tiwai@suse.de>
In-Reply-To: <s5ho8be8v3z.wl-tiwai@suse.de>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Wed, 7 Jul 2021 10:50:07 -0700
Message-ID: <CAMo8Bf+FF8Ofq=FwoZZXp9vKiMaUZNAm+W=OJmu2j2XN6kLb-Q@mail.gmail.com>
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>
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

On Wed, Jul 7, 2021 at 12:02 AM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 06 Jul 2021 19:50:08 +0200, Max Filippov wrote:
> > linux v5.13 booting on qemu-system-xtensa virt board gets stuck inside
> > snd_intel8x0_probe -> intel8x0_measure_ac97_clock with this patch.
> > Prior to it it boots successfully for me.
> > I'm curious if this issue has been reported yet.
> >
> > What I see is an IRQ flood, at some point snd_intel8x0_interrupt
> > and timer ISR  are called in loop and execution never returns to
> > the interrupted function intel8x0_measure_ac97_clock.
> >
> > Any idea what it could be?
>
> That's something odd with the VM.  As the chip itself has never shown
> such a problem on real systems, maybe the best action would be to just
> skip the clock measurement on VM.  The measurement itself is
> unreliable on VM, so it makes more sense.
>
> That said, something like below would work?

It didn't change anything in my case. My further observation is that
the snd_intel8x0_update is called before the ichdev->prepared
is set to one and as a result IRQ is apparently never cleared.
Perhaps because intel8x0_measure_ac97_clock is called from the
snd_intel8x0_probe, well before the snd_intel8x0_pcm_prepare
that sets ichdev->prepared is called.

> thanks,
>
> Takashi
>
> ---
> diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
> index 2d1bfbcba933..b75f832d7777 100644
> --- a/sound/pci/intel8x0.c
> +++ b/sound/pci/intel8x0.c
> @@ -2199,6 +2199,9 @@ static int snd_intel8x0_mixer(struct intel8x0 *chip, int ac97_clock,
>         pbus->private_free = snd_intel8x0_mixer_free_ac97_bus;
>         if (ac97_clock >= 8000 && ac97_clock <= 48000)
>                 pbus->clock = ac97_clock;
> +       else if (chip->inside_vm)
> +               pbus->clock = 48000;
> +
>         /* FIXME: my test board doesn't work well with VRA... */
>         if (chip->device_type == DEVICE_ALI)
>                 pbus->no_vra = 1;

-- 
Thanks.
-- Max
