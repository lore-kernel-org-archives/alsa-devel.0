Return-Path: <SRS0=0Rat=K2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEC2C47082
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 08:09:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EFA60240
	for <alsa-devel@archiver.kernel.org>; Mon, 31 May 2021 08:09:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EFA60240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C69E847;
	Mon, 31 May 2021 10:08:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C69E847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622448570;
	bh=Upx0dz3g62JBgA2elBVr6mgz8WGnGRqHx9pUoIe8zdU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fc2TbZA7BSWK6axgvaGuTl1nAxgX/ipd2TMTSrkZWss3LmAYIZ4MYNeF5XhXSfRQp
	 uktKyevHZAaB8fzI76hFqh0ZXl21OXzU29Xo7heO7jyJNJyM0VOyBeehWOdWhr7FuV
	 umCUppTRcIXiprSPlWT0lQJfYZlb7sOrp/6SYFfw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2DAF3F80168;
	Mon, 31 May 2021 10:08:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B6C5F80253; Mon, 31 May 2021 10:08:39 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51198F80088
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 10:08:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51198F80088
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="jUbwI26a"
Received: by mail-ed1-x530.google.com with SMTP id dj8so217426edb.6
 for <alsa-devel@alsa-project.org>; Mon, 31 May 2021 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=c+pwhGgkZwVwJSlAkd+SILIfBZyexjldGK0DQMbe5B0=;
 b=jUbwI26axnplE39v5+sh5CnOSjPGa++0V0t9MtFTRE70jO3uFWMNLE+3gYrHYk4qYY
 tA7gD14wpBDMVdLTbLu6nUKc8XuykRRsQZPy/qSfARNPSF7O1k18KA+PQ9BYASycG57f
 veCEV0S+ClmaFN7SJhwo0GT/NdF6ixdVru5zHnhs7YEDQacstUQf8dTOzOeLeqNaFsKE
 1vi4h0es1VOr05Zxg2PHptFK7hXv2QF2dlM4kgDDgQ0HicXrM3Ci4PffvG707EcE9hS/
 OSJkvZbYA2cZvTZzvpN4G4zN5c0ZH7r1J03I2YXvoO5+QTEWxjx/lElUadA0egqzPvvo
 0iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=c+pwhGgkZwVwJSlAkd+SILIfBZyexjldGK0DQMbe5B0=;
 b=R3ukwnSp5h7q350mlc38IacRCXvlb294DmKzXlVtbpYsG/frQXQ8BTNigffhp1cldG
 7QAodqUs8Gkc4oggUafaJbNpmswoyiaJRNeKiuLcG2O4LBKxpYLzAm9q0XnQk6CQSeZT
 86C2G1/BaYEwkZ7W5TzoOCEMNigcglmt0TZ4BVtB7TwXqYUhT9Ynq9PoYwEJNJvXJg42
 J5Mf5/35IJuN3kNuBCAsu/mlnfZYAcUcghbOv6OYTn9a9kKlPihpYmq+latnpAP2T/ku
 OCUPer4oHTqVws5NscWRHdwx1Lf3SIUGCArYvhwwaWxkrBcnqeFwRTz5sMqjQD7qFCgv
 QHEA==
X-Gm-Message-State: AOAM533OSOPwa51Bl8FiIXNvW1Bx8/Z/K7XEJqd0Yv3yccIonC9ADCGd
 SRDlFJDZeT2eQZaHtzt4eHdtdNFgcb+b0FGiIUs=
X-Google-Smtp-Source: ABdhPJxOTryzEua54hvVaBaAzjMBgkBfDeJuKV9+vA0IKBDVEFDkhDPAg0TyqiwYLSNadIWsyVMiyKNOWb31KE8eCWA=
X-Received: by 2002:a05:6402:60a:: with SMTP id
 n10mr24125109edv.241.1622448511246; 
 Mon, 31 May 2021 01:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210528131757.2269989-1-mudongliangabcd@gmail.com>
 <20210528133309.GR24442@kadam>
 <CAD-N9QVWcEJjoziA6HVoQiUueVaKqAJS5Et60zvCvuUE7e6=gg@mail.gmail.com>
 <20210528140500.GS24442@kadam>
 <A622EB84-DC4A-47A4-A828-CE6D25DC92EB@gmail.com>
 <CAD-N9QVjhDDJxRnNrDzwt05BNijr1o11nE8xjvq8GrakEJ8EuQ@mail.gmail.com>
 <20210531044022.GU24442@kadam>
 <CAD-N9QWBBP6_Wwi4z3e4yJM-tS54=1=CcvAA+2__Qj8NsTLq9g@mail.gmail.com>
 <20210531070337.GV24442@kadam>
 <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
In-Reply-To: <CAD-N9QU-uqFr=b1hMi1h1ytq2Uf2XKL44f9OHBRhM70zhkiO7w@mail.gmail.com>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 31 May 2021 16:08:04 +0800
Message-ID: <CAD-N9QW5C2ssA7H_U+eiM=SbsPj29Ooo6Sk=r4d1qELbZQjuPA@mail.gmail.com>
Subject: Re: [PATCH] ALSA: control led: fix memory leak in snd_ctl_led_register
To: Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: syzbot+08a7d8b51ea048a74ffb@syzkaller.appspotmail.com,
 linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org,
 tiwai@suse.com
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

On Mon, May 31, 2021 at 3:34 PM Dongliang Mu <mudongliangabcd@gmail.com> wr=
ote:
>
> On Mon, May 31, 2021 at 3:03 PM Dan Carpenter <dan.carpenter@oracle.com> =
wrote:
> >
> > On Mon, May 31, 2021 at 02:20:37PM +0800, Dongliang Mu wrote:
> > > On Mon, May 31, 2021 at 12:40 PM Dan Carpenter <dan.carpenter@oracle.=
com> wrote:
> > > >
> > > > On Mon, May 31, 2021 at 11:03:36AM +0800, Dongliang Mu wrote:
> > > > > On Sat, May 29, 2021 at 5:35 AM =E6=85=95=E5=86=AC=E4=BA=AE <mudo=
ngliangabcd@gmail.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > > On May 28, 2021, at 10:05 PM, Dan Carpenter <dan.carpenter@or=
acle.com> wrote:
> > > > > > >
> > > > > > > On Fri, May 28, 2021 at 09:50:49PM +0800, Dongliang Mu wrote:
> > > > > > >>
> > > > > > >> Can you please give some advise on how to fix this WARN issu=
e?
> > > > > > >
> > > > > > > But it feels like it spoils the fun if I write the commit... =
 Anyway:
> > > > > >
> > > > > > It=E2=80=99s fine. I am still in the learning process. It=E2=80=
=99s also good to learn experience by comparing your patch and my patch.
> > > > > >
> > > > > > >
> > > > > > > regards,
> > > > > > > dan carpenter
> > > > > > >
> > > > > > > diff --git a/sound/core/control_led.c b/sound/core/control_le=
d.c
> > > > > > > index 25f57c14f294..dd357abc1b58 100644
> > > > > > > --- a/sound/core/control_led.c
> > > > > > > +++ b/sound/core/control_led.c
> > > > > > > @@ -740,6 +740,7 @@ static int __init snd_ctl_led_init(void)
> > > > > > >                       for (; group > 0; group--) {
> > > > > > >                               led =3D &snd_ctl_leds[group - 1=
];
> > > > > > >                               device_del(&led->dev);
> > > > > > > +                             device_put(&led->dev);
> > > > > > >                       }
> > > > > > >                       device_del(&snd_ctl_led_dev);
> > > > > > >                       return -ENOMEM;
> > > > > > > @@ -768,6 +769,7 @@ static void __exit snd_ctl_led_exit(void)
> > > > > > >       for (group =3D 0; group < MAX_LED; group++) {
> > > > > > >               led =3D &snd_ctl_leds[group];
> > > > > > >               device_del(&led->dev);
> > > > > > > +             device_put(&led->dev);
> > > > > > >       }
> > > > > > >       device_del(&snd_ctl_led_dev);
> > > > > > >       snd_ctl_led_clean(NULL);
> > > > >
> > > > > Hi Dan,
> > > > >
> > > > > I tried this patch, and it still triggers the memleak.
> > > >
> > > > Did your patch fix the leak?  Because my patch should have been
> > > > equivalent except for it fixes an additional leak in the snd_ctl_le=
d_init()
> > > > error path.
> > >
> > > The syzbot link is [1]. I have tested my patch in the syzbot dashboar=
d
> > > and my local workspace.
> > >
> > > I think the reason why your patch did not work should be
> > > led_card(struct snd_ctl_led_card) is already freed before returning i=
n
> > > snd_ctl_led_sysfs_remove, rather than led(struct snd_ctl_led). See th=
e
> > > implementation of snd_ctl_led_sysfs_remove for some details. Please
> > > correct me if I make any mistakes.
> > >
> > > static void snd_ctl_led_sysfs_remove(struct snd_card *card)
> > > {
> > >         unsigned int group;
> > >         struct snd_ctl_led_card *led_card;
> > >         struct snd_ctl_led *led;
> > >         char link_name[32];
> > >
> > >         for (group =3D 0; group < MAX_LED; group++) {
> > >                 led =3D &snd_ctl_leds[group];
> > >                 led_card =3D led->cards[card->number];
> > >                 if (!led_card)
> > >                         continue;
> > >                 snprintf(link_name, sizeof(link_name), "led-%s", led-=
>name);
> > >                 sysfs_remove_link(&card->ctl_dev.kobj, link_name);
> > >                 sysfs_remove_link(&led_card->dev.kobj, "card");
> > >                 device_del(&led_card->dev);
> > >                 put_device(&led_card->dev);
> > >                 kfree(led_card);
> > >                 led->cards[card->number] =3D NULL;
> > >         }
> > > }
> >
> > This is frustrating to look at because it's not a diff so it doesn't
> > show what you changed.  I think you are saying that you added the
> > put_device(&led_card->dev);.  That's true.  There are some other leaks
> > as well.  We should just fix them all.  Use device_unregister() because
> > it's cleaner.
>
> Oh, I see your point. Yeah, we should fix these memory leaks all. I
> agree with device_unregister.
>
> >
> > If both device_initialize() and device_add() succeed then call
> > device_unregister() to unwind.
>
> BTW, have you tested this new patch on two memory leaks?
>

Please keep in mind that if we don't have any release method for
struct snd_ctl_led_card, it will trigger a WARN[1] in the
device_release function. That's why I have to add one dummy release
function.

if (dev->release)
        dev->release(dev);
else if (dev->type && dev->type->release)
        dev->type->release(dev);
else if (dev->class && dev->class->dev_release)
        dev->class->dev_release(dev);
else
        WARN(1, KERN_ERR "Device '%s' does not have a release()
function, it is broken and must be fixed. See
Documentation/core-api/kobject.rst.\n",
dev_name(dev));

[1] https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L211=
0

> >
> > diff --git a/sound/core/control_led.c b/sound/core/control_led.c
> > index 25f57c14f294..561fe45e4449 100644
> > --- a/sound/core/control_led.c
> > +++ b/sound/core/control_led.c
> > @@ -700,7 +700,7 @@ static void snd_ctl_led_sysfs_remove(struct snd_car=
d *card)
> >                 snprintf(link_name, sizeof(link_name), "led-%s", led->n=
ame);
> >                 sysfs_remove_link(&card->ctl_dev.kobj, link_name);
> >                 sysfs_remove_link(&led_card->dev.kobj, "card");
> > -               device_del(&led_card->dev);
> > +               device_unregister(&led_card->dev);
> >                 kfree(led_card);
> >                 led->cards[card->number] =3D NULL;
> >         }
> > @@ -739,9 +739,9 @@ static int __init snd_ctl_led_init(void)
> >                         put_device(&led->dev);
> >                         for (; group > 0; group--) {
> >                                 led =3D &snd_ctl_leds[group - 1];
> > -                               device_del(&led->dev);
> > +                               device_unregister(&led->dev);
> >                         }
> > -                       device_del(&snd_ctl_led_dev);
> > +                       device_unregister(&snd_ctl_led_dev);
> >                         return -ENOMEM;
> >                 }
> >         }
> > @@ -767,9 +767,9 @@ static void __exit snd_ctl_led_exit(void)
> >         }
> >         for (group =3D 0; group < MAX_LED; group++) {
> >                 led =3D &snd_ctl_leds[group];
> > -               device_del(&led->dev);
> > +               device_unregister(&led->dev);
> >         }
> > -       device_del(&snd_ctl_led_dev);
> > +       device_unregister(&snd_ctl_led_dev);
> >         snd_ctl_led_clean(NULL);
> >  }
> >
