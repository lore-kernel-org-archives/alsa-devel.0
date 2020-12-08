Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F34C433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 05:19:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C31B923A60
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 05:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31B923A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=endlessos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 420C116F9;
	Tue,  8 Dec 2020 06:18:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 420C116F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607404746;
	bh=2+yR3yuo4D7zMCR8NK9mW5qO7VOsix8sqbs+j4+m0Gg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SkIGYwEM/M8LpQt0Obex2XgFoWE8mqtE+NYmZtjVKA30ZXrANgX6dyAnms5hHQwzp
	 nKX1b55bVT4QshQk12S0u69vGOYwGNBSYjYrUpO1J6IVm2rVA02OVmIG84Md3rarAD
	 vNqMnS5XSNLOoMYYjcLurdg5fbR0dp/9lJw6ojSE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 89AEBF80130;
	Tue,  8 Dec 2020 06:18:15 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B7E9AF8019D; Tue,  8 Dec 2020 06:18:12 +0100 (CET)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17B17F80130
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 06:18:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17B17F80130
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org
 header.b="MxvmroRx"
Received: by mail-pg1-x543.google.com with SMTP id g18so11159323pgk.1
 for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2020 21:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=endlessos.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6B27MjfiQVy0rXuqasBw27ufwoC3xQGBEn2nziAxKKw=;
 b=MxvmroRxK7TMgJsiKckqSSoIB1O+g9Hvlhy4w/byUGZUDIJ6Jg1CBBkjd8zwI+Uc4T
 8OrBN1jwckJQo+Xuo17WQmP+SiKRlvKZY9ux9srN+/s3vucDJ0/32U43b2mz13WU5/k+
 K6oArXu2qDuUK1hGbaOmAokFYwVPGvmt5B1/uCbXhVK0r4JgsxzIEdgaHStnW4pG/4p3
 XHHtaKke6fFEMUTOLi4eVH5LfFj1OSW8ucnYpAO0LM9fIUSpnnsmdCypbtWGcBpM2a2f
 OXmAQ7tp4kwE39Lvfxs9DEfDO3udXI5o0T6joSdPWXuN4rWa49yuH/i14tGxVCbC79lw
 ic2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6B27MjfiQVy0rXuqasBw27ufwoC3xQGBEn2nziAxKKw=;
 b=RBfFjVYmz6TiB9qAF1gLZc8IMXbFVx1+RcPJGUVrwdTqCxKZMyXVwCXQf5dvFNpsim
 mYXnEXkJEkXlzTYSPx5SHOKeBJ+CLs5nvSAm6XYHRXsIlL51mC/s2fg3QkqqeRVaHql4
 cGLmEdxyScMAWyXFHYv3y4QWCmX8RCtpTRf9Kjrpn6fGRXEOMvNXc5S2BaYtT9GmSYgQ
 CN7FrSIbCJAKGZZ2dEoP/jq9Qkzwqf5ujYTyoyRhil3NKCz2r4kfRdn7w0au9P1qKmHU
 PvBtYHofqMfP4i9AEcnQPmdsqF5Epxm/GDzNzc4TYRjdKJ7aW+AYGyFWtTHbvXCP8z2t
 s5Nw==
X-Gm-Message-State: AOAM530JevjLRRDX3G65vt5gSgFHJYiUez1pKhDAa1F7WXlTfn81nd0r
 sjq5PmbwOmjFZKTyZJpJO7FmCrm5FDr4LnldAocz2A==
X-Google-Smtp-Source: ABdhPJxAyat6w/s5kIrYWRiG8fkEEx0Fy4ugnBvg0BiPnvUvHJ9D+f7afjLBBjveFnwE5uOkVGTPnEKZr1qNWQiKdYw=
X-Received: by 2002:a62:1dd5:0:b029:19d:fc87:5f45 with SMTP id
 d204-20020a621dd50000b029019dfc875f45mr9281048pfd.63.1607404679429; Mon, 07
 Dec 2020 21:17:59 -0800 (PST)
MIME-Version: 1.0
References: <20201207073346.16571-1-chiu@endlessos.org>
 <s5h360i2eov.wl-tiwai@suse.de>
In-Reply-To: <s5h360i2eov.wl-tiwai@suse.de>
From: Chris Chiu <chiu@endlessos.org>
Date: Tue, 8 Dec 2020 13:17:48 +0800
Message-ID: <CAB4CAwcuZxz260Q=7VntkZnit_x0K4Pthcdnv1xD=NgmcRCDew@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda/realtek - Add support for Memeza EDL03 headset
 mic
To: Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: alsa-devel@alsa-project.org, Kailang <kailang@realtek.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, Jian-Hong Pan <jhp@endlessos.org>,
 tiwai@suse.com, linux@endlessos.org
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

On Mon, Dec 7, 2020 at 4:38 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 07 Dec 2020 08:33:46 +0100,
> Chris Chiu wrote:
> >
> > The Memeza laptop EDL03 with codec ALC256 can't detect the headset
> > microphone. The headphone jack sensing works after we add a pin
> > definition for it by ALC256_FIXUP_ASUS_MIC_NO_PRESENCE.
> >
> > Signed-off-by: Chris Chiu <chiu@endlessos.org>
> > Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
> > ---
> >  sound/pci/hda/patch_realtek.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> > index d5e4d0ba1008..8b9b94cfc67e 100644
> > --- a/sound/pci/hda/patch_realtek.c
> > +++ b/sound/pci/hda/patch_realtek.c
> > @@ -7871,6 +7871,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
> >       SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
> >       SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
> >       SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
> > +     SND_PCI_QUIRK(0x10ec, 0x115a, "Memeza EDL03", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
>
> This looks suspicious.  10ec is the vendor ID for Realtek, i.e. it
> implies that the BIOS on this machine didn't give the proper unique
> ID.  As you can see, the other entries with 10ec are only reference
> boards.
>
> If the newer BIOS still doesn't fix the PCI SSID, you can check the
> codec SSID instead.
>
>
> thanks,
>
> Takashi

Thanks for the feedback. This is a special case that the ODM didn't
flash the DMI information
and assign a formal SSID. They simply ship with the current status w/o
any BIOS customization.

I agree that we should push the vendor for a BIOS fix or figure out a
generic solution for this
instead of a pin quirk. Please ignore this. Thanks

Chris
