Return-Path: <SRS0=qvmA=JD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9ABC433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 13:50:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EA4861279
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Apr 2021 13:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA4861279
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D448784C;
	Tue,  6 Apr 2021 15:49:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D448784C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617716997;
	bh=GFToPsWYKbpsXqT2j9CFPxMG4wbUR5SGZK6659mKAOA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NAQQwwj06SVEPfDw7D5uZxqa02e8q/CaJvYjZaBhut3Qs4TkHQUCx7/fFB1g8v9N2
	 kMp7vYN9U+avhkcCw9rxc8bYsd2G6OOSoIuX6v8UbkXBEPT9zvJlJrB2OkYLmJD7lQ
	 T4C5EH3LhLcpT4aCvibEvShyFIpqZOMqRG1i8g6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B457F80169;
	Tue,  6 Apr 2021 15:49:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AA18BF8020B; Tue,  6 Apr 2021 15:49:05 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D638AF800E1
 for <alsa-devel@alsa-project.org>; Tue,  6 Apr 2021 15:48:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D638AF800E1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="ul4kWdmp"
Received: by mail-qk1-x735.google.com with SMTP id q26so14925266qkm.6
 for <alsa-devel@alsa-project.org>; Tue, 06 Apr 2021 06:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HexOfwpOcI42fxXzMG3/0i6wz/IUJnLwROUi6JU1yGk=;
 b=ul4kWdmp6kStkCH0syAyU5sJ5SJRcly2wg0rmziB9hypAub56y+xf/JqcNwoGzOrHh
 BwUQGHt/CAOR6suY7aEjb/boOYuSUgDmgyUSLEi5W7+MEuBhmrEEPfNx5l7ck6rPGPMF
 itAxcOMfLwRz1yzdNX9WEyb0EpTANzh9PXK6+Tu7XASR1cPy3dWDj6xnwFVb+rFFqEj/
 ObhQG5pxHt3ZJsad/g0KW0jpTaYhlRAh6oXcduf3tEmcW0IsUtQ//F5cwxkczRF2r3FR
 kFgVrue4qBOWmIvKGsooKv8LFhVA5KyercWzrLghtvyqS091hZtcJnrxGio+Mkfkomxa
 CjVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HexOfwpOcI42fxXzMG3/0i6wz/IUJnLwROUi6JU1yGk=;
 b=nTn9xxXhXKqOAojdOpswiQrO3et/wa5+kzirx2JpOxaVBXpVXNqUp/TvvuA4yXDMJW
 O9o68wauRW2hgUZCMAdfs9U6QOHQuQKcOiDoi9gptuxuTtGaIEnf1Ub24pdt5bXvRxeC
 qR081FMcLQgfHwhTPBFoh5WiBKh2RHcyF1kceWjpt/tfOcKeGfu2Yib1XohTOhDl4tRh
 8qwJSKzGzUitgCEzM5OdJUEcL7UybuBxV/Z8FStLwgD2XSC1S4Ly+bZo+fs2TfyyL2z6
 qK3ArkN+ZSFT8ZGoNnNdbvNMREKGX1fsfkV6rYjDdqqS7RdmgdoRg5eF6zYd1KutQ3hv
 WOfg==
X-Gm-Message-State: AOAM533BwcjC37kF3hCuHNiEEArYPqVnDkqvflXPSOHhHjTDv+XzPw2T
 EGA+sBR57RmZDgwE6LPcPkvcXxo24dMIRbx5nJ4=
X-Google-Smtp-Source: ABdhPJxCx598AFg1TaDbAtymvDTdwxjYJa+RKBByV+tJ3oxVSLTe/R1+DUjAVcRGQkNR8L2kHgxVI8gMtd2t8HdctcM=
X-Received: by 2002:a37:a38e:: with SMTP id
 m136mr29311568qke.250.1617716931077; 
 Tue, 06 Apr 2021 06:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAEsQvcs9LcciAYjoB64Kt_VaSww4EAW4-qN0ED5jDA0GeeTtDg@mail.gmail.com>
 <s5hsg43bplp.wl-tiwai@suse.de>
In-Reply-To: <s5hsg43bplp.wl-tiwai@suse.de>
From: Geraldo <geraldogabriel@gmail.com>
Date: Tue, 6 Apr 2021 10:44:46 -0300
Message-ID: <CAEsQvctVWAp04hyfGU+FG-4Q1L7Rpx-6S4LgvBZa8ZEZLOykPw@mail.gmail.com>
Subject: Re: [PATCH v2] Pioneer devices: engage implicit feedback sync for
 playback
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: alsa-devel@alsa-project.org, dmitry@d-systems.ee, fabian@lesniak-it.de,
 ard@kwaak.net, marcan@marcan.st, franta-linux@frantovo.cz, dmanlfc@gmail.com,
 livvy@base.nu
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

Works for me Dr. Iwai, thank you!

Much more better styled now, and less hacky.

-Geraldo

Em Ter, 6 de abr de 2021 08:48, Takashi Iwai <tiwai@suse.de> escreveu:

> On Mon, 05 Apr 2021 15:49:20 +0200,
> Geraldo wrote:
> >
> > Dear Linux users of Pioneer gear, please disregard v1 of this patch and
> test
> > this instead if at all possible.
> >
> > My initial assessment that we needed to let the capture EP be opened
> twice was
> > clearly proven wrong by further testing. This is good because if we
> really
> > needed that it would require a lot of reengineering inside ALSA.
> >
> > One thing that still boggles my mind though is why we need a special
> Pioneer
> > case inside snd_usb_parse_implicit_fb_quirk that returns 1 like a capture
> > quirk was found.
> >
> > This is a highly experimental patch on top of 5.12-rc6 that's supposed to
> > engage implicit feedback sync on the playback for Pioneer devices.
> Without
> > implicit feedback sync the inputs started glitching due to clock drift in
> > about an hour in my Pioneer DJ DDJ-SR2.
> >
> > Once again I'd like to thank Takashi Iwai. He's the true author of the
> bulk of
> > this code, I just adapted it and coerced it into working.
> >
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
>
> Thanks for the patch!
>
> It's interesting that Pioneer devices would actually work with the
> implicit feedback mode.  It seems that the key point is to skip the
> capture side; IIRC, we checked applying the quirk to the playback
> side, but this wasn't enough or not properly working on some devices.
>
> If that's the case, I believe a patch like below would be safer and
> more inconsistent: it checks the device from both playback and capture
> quirks with the same helper function.
>
> Could you check whether this one works?   (It's totally untested.)
>
>
> thanks,
>
> Takashi
>
> ---
> --- a/sound/usb/implicit.c
> +++ b/sound/usb/implicit.c
> @@ -167,18 +167,27 @@ static int add_roland_implicit_fb(struct
> snd_usb_audio *chip,
>                                        ifnum, alts);
>  }
>
> -/* Playback and capture EPs on Pioneer devices share the same
> iface/altset,
> - * but they don't seem working with the implicit fb mode well, hence we
> - * just return as if the sync were already set up.
> +/* Playback and capture EPs on Pioneer devices share the same iface/altset
> + * for the implicit feedback operation
>   */
> -static int skip_pioneer_sync_ep(struct snd_usb_audio *chip,
> -                               struct audioformat *fmt,
> -                               struct usb_host_interface *alts)
> +static bool is_pioneer_implicit_fb(struct snd_usb_audio *chip,
> +                                  struct usb_host_interface *alts)
> +
>  {
>         struct usb_endpoint_descriptor *epd;
>
> +       if (USB_ID_VENDOR(chip->usb_id) != 0x2b73 &&
> +           USB_ID_VENDOR(chip->usb_id) != 0x08e4)
> +               return false;
> +       if (alts->desc.bInterfaceClass != USB_CLASS_VENDOR_SPEC)
> +               return false;
>         if (alts->desc.bNumEndpoints != 2)
> -               return 0;
> +               return false;
> +
> +       epd = get_endpoint(alts, 0);
> +       if (!usb_endpoint_is_isoc_out(epd) ||
> +           (epd->bmAttributes & USB_ENDPOINT_SYNCTYPE) !=
> USB_ENDPOINT_SYNC_ASYNC)
> +               return false;
>
>         epd = get_endpoint(alts, 1);
>         if (!usb_endpoint_is_isoc_in(epd) ||
> @@ -187,8 +196,9 @@ static int skip_pioneer_sync_ep(struct snd_usb_audio
> *chip,
>              USB_ENDPOINT_USAGE_DATA &&
>              (epd->bmAttributes & USB_ENDPOINT_USAGE_MASK) !=
>              USB_ENDPOINT_USAGE_IMPLICIT_FB))
> -               return 0;
> -       return 1; /* don't handle with the implicit fb, just skip sync EP
> */
> +               return false;
> +
> +       return true;
>  }
>
>  static int __add_generic_implicit_fb(struct snd_usb_audio *chip,
> @@ -297,13 +307,11 @@ static int audioformat_implicit_fb_quirk(struct
> snd_usb_audio *chip,
>         }
>
>         /* Pioneer devices with vendor spec class */
> -       if (attr == USB_ENDPOINT_SYNC_ASYNC &&
> -           alts->desc.bInterfaceClass == USB_CLASS_VENDOR_SPEC &&
> -           (USB_ID_VENDOR(chip->usb_id) == 0x2b73 || /* Pioneer */
> -            USB_ID_VENDOR(chip->usb_id) == 0x08e4    /* Pioneer */)) {
> -               if (skip_pioneer_sync_ep(chip, fmt, alts))
> -                       return 1;
> -       }
> +       if (is_pioneer_implicit_fb(chip, alts))
> +               return add_implicit_fb_sync_ep(chip, fmt,
> +                                              get_endpoint(alts,
> 1)->bEndpointAddress,
> +                                              1,
> alts->desc.bInterfaceNumber,
> +                                              alts);
>
>         /* Try the generic implicit fb if available */
>         if (chip->generic_implicit_fb)
> @@ -324,6 +332,8 @@ static int audioformat_capture_quirk(struct
> snd_usb_audio *chip,
>         if (p && p->type == IMPLICIT_FB_FIXED)
>                 return add_implicit_fb_sync_ep(chip, fmt, p->ep_num, 0,
>                                                p->iface, NULL);
> +       if (is_pioneer_implicit_fb(chip, alts))
> +               return 1; /* skip */
>         return 0;
>  }
>
>
>
