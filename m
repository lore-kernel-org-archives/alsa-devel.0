Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E05BF8A145
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:21:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 519F560216;
	Thu, 16 Apr 2026 11:21:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 519F560216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776331296;
	bh=cyILk8t7InVIOJNZ3XmJnPZ58qdD6YBPdOMJgkFAPVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kbmWCZd3vBy+7cixqzRWNAfNFAoOQnx35Donv497sS4DbaUJZ0V6Vom4eax8h0QWP
	 0b8PGE8LPVj/o6hjW+QGEAolnsuNAbO0unbQX+89BMBYqZoXJ6AjW78RLlQMogNtPV
	 /GGnjx+IGHHNrA+Drn0IV8ajwK72XRSPpz0BeG/s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EF668F80601; Thu, 16 Apr 2026 11:20:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A216F80612;
	Thu, 16 Apr 2026 11:20:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0708DF80510; Tue, 14 Apr 2026 09:23:53 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8EA1BF800C1
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2026 09:23:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EA1BF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=svaxeNTQ
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c74244dc0b3so3280281a12.2
        for <alsa-devel@alsa-project.org>;
 Tue, 14 Apr 2026 00:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776151425; cv=none;
        d=google.com; s=arc-20240605;
        b=EMG47ueL2pN4q/aaPvodH9O3WR49wqwyf2KGhBc2EyoFZBKWTg1IDFsTt4ZBGWlXx4
         JYdpcB8Q/VgPTVtulBwWAuleObZkxDcRecw1ksjeGBPVfgYP0CA3wAs/VAUbGY1o4555
         4V0TUDBXXgIKLMJo2PAOCeWEy/ZGaX+zsypP3g4bXNPem8tbbdXPPxtcRhFv1iPd3/dJ
         HdYRrzH8IU8LdJM76DsVvHzaw+9Duf7KuUOjHSxn5wsgUF/agOcXs6L5lh8KwcShZiB/
         hQQ9C34IDWLBWPsWZaDT0/3IdopfY19LYwINABPSQXQPQbKXjmda1EDzhqT+U4vRWZij
         wx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PNMQ3xS5M00U6S5Ye1ZFAEQmJL8P2236+qc+vTRch98=;
        fh=vZU44/W+ndmu7MuCvE0I3UfNCjvJKAS2iXYggcj5oLM=;
        b=E+6ri2lU9o+/W9y6h/CthNf+TcaH8JDBnb4p9cKT+RNO9MaCFiGwVREUbPmrRp5Sj7
         GM1i2IYK9qm83sErwuZQ4kVs1E7nfsFh6INuHsG+SktEMYTjCW1XXezlHnyEIK1qPdWI
         p0qYsSAZudE4lT/YBf7h4gqbWs/F2w/ZOZmIGPmHStrqdmKHoeshsepLKpidqInn6N1p
         5nPLmAtqmYuxcM93Im0pbAx7qXcJoDUAfav1RzbypIblDBXYZ71Vn8TbJWBCXI4nUURF
         6J5+WU6VDY4KijOs3S2crO2Ve36ThVPb6FOgOx80otleNTQXZcmCFzOTIR6iv/Fqfo2M
         tbFg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776151425; x=1776756225;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNMQ3xS5M00U6S5Ye1ZFAEQmJL8P2236+qc+vTRch98=;
        b=svaxeNTQ40YmmhpHvSKPxnOaV+dhhugCcwtE1XmcOoWANaD8chLcyRketW1Nkztrp1
         lX0qKOWn/bFcp2AythyfwuGg0xxZLgFTEshxCQwSvGJ0Y73URfqCZ/FAaF2sRR/VGlao
         geF4l8/KSm/OFkQLDXocJbiuTGdY8PqGK5mn7ErRy5kemG2XG1x/f6gyLbwDX/HX7hI/
         gbO18YRem3DabtOVh8o4Tfdda1+ClHI7h1NyHl8qrFD1frmNwgpd7SKtlk+K/2O2bb34
         Q9c6NzvX3i2LnRkfe0MVGrBXNAYpTuy8hrA5BhUCyZjVCC4TNN2XW90MCKLRDVhfY5Pg
         rWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776151425; x=1776756225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PNMQ3xS5M00U6S5Ye1ZFAEQmJL8P2236+qc+vTRch98=;
        b=K1adi/XhfhV5fNkWnaEeiSmE6SxQOYFkUXs0KN/wxbVsy5dsBfLsMPL+Ncuuoi0ucS
         FTG6Oi8XxNYQwn/Qjrlq0LjIiFlQ9XKNHNwRGapXfFWioKCb0jZmhWXUu59ei8KWtSLa
         PZcEv5Bs8CQk10NlgKCh/INpKvFUDdsv+GCzqmtHx0EpSQyMi3lHiJ3ybFAeRBDpEsXQ
         YDLCCb39TintCu5E3s2oToklY11XCc20Ao7qOS4lbATdi+8JDa9MH8Lsx3cw3Ksx7lrN
         gYLddSxeT7ogAm77SjtbvFupBS6dV7R5/oKOotLfDn5kAFaUdPoNmDBZmDJcFazLWtxu
         y5pQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/APWHwBv2XjEDEpqEEhdqko4Ml14RiUfiCFKG9IRvN0kJs3Gxz4kLMDEI/iQop6y0yOqFpNdeKeKMt@alsa-project.org
X-Gm-Message-State: AOJu0YxrItE5a5IrVNe0LEqrOQo+jV7nVCu+JTcqdz6pD23maCEqM/VI
	e2f7s5W0ypivE/kOjOrkJWWqz0/MS2H8nFIVH8LkZe8bmMmutVRuevYSOojKFTN9J+1txILCo1J
	V3wqNKhb1w93PDSDdwj8NYm+uZIJQgvM=
X-Gm-Gg: AeBDiesoQ1wYGY1xoVEBtCwpT+2jl6LYPV8YUw1br4JPGhXfFZ9w8jXFnBs+dk6FjBx
	cAuOi/tvqpjdeNiSccb1dx+r0JJxjCK44iMtQz/D4J5jdVwHH+mAXSIIHhbfz6upbmYZtvKPnYi
	RPrQeTK087UXnw0OQT1KMFjYzQI3UBUgczJu0HdU2gCxzeHDLAWUZ1zWj1gvveKBKOfNXzHfcyU
	cP0mhxHIUmP2z/4snXilQw0hMzg9k5T74Q9oYnBBIJxLKvYjPJPoBvYfneelunZBJ3zL8as5cNO
	0bDLLTsao4V/BRJKEabvXeQYWj8g2PcOdOrQbpe27sJXNwj8
X-Received: by 2002:a17:902:fe8b:b0:2b2:5840:80c5 with SMTP id
 d9443c01a7336-2b2d5a8a99cmr110805135ad.37.1776151425306; Tue, 14 Apr 2026
 00:23:45 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com>
 <87a4wgrxil.wl-tiwai@suse.de>
 <CAC88DfvjQvZvdvGdZ00woMymE2tUWk=2Dbqi3EzuzSHxGjEnzw@mail.gmail.com>
 <871phsrsnf.wl-tiwai@suse.de> <f59a70ca796b4d09822f514e7f25ac5c@realtek.com>
 <CAC88DftEBEEEvODGUZzkry+kgAm=SfH=PAsxwu+SABMBMRMs=Q@mail.gmail.com>
 <658f53ada52f4de9a0c852dd56554a2a@realtek.com>
In-Reply-To: <658f53ada52f4de9a0c852dd56554a2a@realtek.com>
From: =?UTF-8?B?SsOpcsOpbXkgQmV0aG1vbnQ=?= <jeremy.bethmont@gmail.com>
Date: Tue, 14 Apr 2026 14:23:31 +0700
X-Gm-Features: AQROBzDuOKQ-Sqh7dOPc0fOQ_0mD5HzIWXtRaG_1ih6Nu4he2z_S0UIbTfvgGRw
Message-ID: 
 <CAC88DfvyuWeD99hhKKsHum+wpjjQrOKsdWvKVZMefjhcx3sKBw@mail.gmail.com>
Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC287)
 after commit d2e01e0c5e94
To: Kailang <kailang@realtek.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"regressions@leemhuis.info" <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: jeremy.bethmont@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DC2ZP3NUCBPPBN4BS5P7U667XP454YMO
X-Message-ID-Hash: DC2ZP3NUCBPPBN4BS5P7U667XP454YMO
X-Mailman-Approved-At: Thu, 16 Apr 2026 09:20:27 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DC2ZP3NUCBPPBN4BS5P7U667XP454YMO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Kailang, Takashi,

I can confirm that applying this patch completely resolves the issue!

I compiled and tested it on my ThinkPad X1 Carbon Gen 12 (ALC287)
running kernel 6.19.11. The hardware popping noise upon PCM suspend is
entirely gone.

Thank you both for your incredible work on this. You can add my
Tested-by tag when this gets merged upstream:

Tested-by: Jeremy Bethmont <jeremy.bethmont@gmail.com>

Best regards,
Jeremy

On Tue, 14 Apr 2026 at 13:44, Kailang <kailang@realtek.com> wrote:
>
> Sorry!! Attached wrong file.
> Attached again.
>
> -----Original Message-----
> From: J=C3=A9r=C3=A9my Bethmont <jeremy.bethmont@gmail.com>
> Sent: Tuesday, April 14, 2026 2:37 PM
> To: Kailang <kailang@realtek.com>
> Cc: Takashi Iwai <tiwai@suse.de>; alsa-devel@alsa-project.org; regression=
s@lists.linux.dev; regressions@leemhuis.info
> Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC=
287) after commit d2e01e0c5e94
>
>
> External mail : This email originated from outside the organization. Do n=
ot reply, click links, or open attachments unless you recognize the sender =
and know the content is safe.
>
>
>
> Hi Kailang,
>
> Thank you for the patch. However, I believe you may have attached the wro=
ng file by mistake.
>
> The attached patch ("0000-x1-gen12-speaker.patch") is dated November 12, =
2024. Its commit message mentions fixing an issue with older BIOS versions.
>
> Could you please double-check?
>
> Best regards,
> Jeremy
>
> On Mon, 13 Apr 2026 at 16:16, Kailang <kailang@realtek.com> wrote:
> >
> > Hi Jeremy,
> >
> > You can test attach patch.
> >
> > BR,
> > Kailang
> >
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Tuesday, March 10, 2026 4:33 PM
> > To: J=C3=A9r=C3=A9my Bethmont <jeremy.bethmont@gmail.com>
> > Cc: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org;
> > regressions@lists.linux.dev; regressions@leemhuis.info
> > Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12
> > (ALC287) after commit d2e01e0c5e94
> >
> >
> > External mail : This email originated from outside the organization. Do=
 not reply, click links, or open attachments unless you recognize the sende=
r and know the content is safe.
> >
> >
> >
> > On Tue, 10 Mar 2026 09:24:38 +0100,
> > J=C3=A9r=C3=A9my Bethmont wrote:
> > >
> > > Hi Takashi,
> > >
> > > Thank you for looking into this so quickly.
> > >
> > > As requested, I have attached the output of `alsa-info.sh
> > > --no-upload` from my machine.
> > >
> > > Please let me know if you have a proposed patch you would like me to
> > > test. I am happy to build it and verify if it resolves the popping
> > > on my hardware.
> >
> > I guess dropping the alc_process_coef_fw(codec, en_coefs) call at closi=
ng would fix your problem while keeping the one at open.
> > But I'm not sure about any side-effect by that.
> > Kailang, could you check this?
> >
> > BTW, when you disable runtime PM, does the pop noise still appears?
> >
> >
> > thanks,
> >
> > Takashi
> >
> > >
> > > Best regards,
> > > Jeremy
> > >
> > > On Tue, 10 Mar 2026 at 13:47, Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Tue, 10 Mar 2026 01:01:11 +0100, J=C3=A9r=C3=A9my Bethmont wrote=
:
> > > > >
> > > > > Hi Takashi, Kailang,
> > > > >
> > > > > I am reporting an audio regression introduced in kernel 6.18.13
> > > > > on the Lenovo ThinkPad X1 Carbon Gen 12 (Meteor Lake, Realtek
> > > > > ALC287 codec,
> > > > > SSID: 0x17aa231e).
> > > > >
> > > > > Since this update, the laptop emits a short, noticeable hardware
> > > > > pop/blip from the speakers exactly when an audio stream closes
> > > > > and the PCM state suspends. It happens consistently a few
> > > > > seconds after playback finishes (e.g., after a system
> > > > > notification or terminal bell).
> > > > >
> > > > > I have tracked the regression down to the following commit:
> > > > > d2e01e0c5e947da0b5005ca89efa82baeb232adc ("ALSA: hda/realtek -
> > > > > fixed speaker no sound")
> > > > >
> > > > > #regzbot introduced: d2e01e0c5e947da0b5005ca89efa82baeb232adc
> > > > >
> > > > > Root cause analysis:
> > > > > The commit modifies the `alc287_alc1318_playback_pcm_hook`
> > > > > function, adding raw COEF writes to disable/enable AMP silence
> > > > > detection on HDA_GEN_PCM_ACT_OPEN and HDA_GEN_PCM_ACT_CLOSE.
> > > > >
> > > > > Because `alc287_alc1318_playback_pcm_hook` is a shared hook used
> > > > > by multiple Lenovo ALC287/ALC1318 devices, these unconditional
> > > > > `WRITE_COEF` instructions are being sent to hardware that does
> > > > > not need the silence detection fix. On the X1 Carbon Gen 12,
> > > > > executing `alc_process_coef_fw(codec, en_coefs)` upon stream
> > > > > close triggers an immediate electrical pop. Monitoring with
> > > > > `pw-mon` confirms the hardware pop coincides perfectly with the
> > > > > monitor_FR / monitor_FL ports going idle/suspended.
> > > > >
> > > > > Proposed solution:
> > > > > Could we revert this commit, or alternatively, wrap these
> > > > > specific silence-detection COEF writes in a targeted
> > > > > `ALC287_FIXUP` quirk matched via SSID/DMI, rather than executing
> > > > > them globally in the shared playback hook?
> > > >
> > > > Could you give alsa-info.sh output?  Run the script with
> > > > --no-upload option and attach the output.
> > > >
> > > > I guess the bug might not be specific to your device but happening
> > > > in general with all matching ones.  As a workaround for such a pop
> > > > noise, we often need to reorder verbs or put some delay between ver=
bs.
> > > >
> > > >
> > > > Takashi
> > >
> > >
> > >
> > > --
> > > J=C3=A9r=C3=A9my Bethmont
> > >
>
>
>
> --
> J=C3=A9r=C3=A9my Bethmont



--=20
J=C3=A9r=C3=A9my Bethmont
