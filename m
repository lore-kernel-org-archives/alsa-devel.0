Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45410C4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:39:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3AF4F60239;
	Sat, 18 Jul 2026 11:38:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3AF4F60239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367539;
	bh=Ma9hZYGKmWu+c4bk/cBfQ6DPevX5CRoMpK8Z9/3dTjQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=WytsO4mSzOKVn+VJqyOHqH/lnAo0G8V/s7wgGtRVvTyFon96dN8xiTpb9BpG/ItIA
	 7N0Cwp18+a3iyU9hsMTCdcVjirIJAOj3mxLEDid78QcDdHhek6tKTuxhgvLTxCwuIZ
	 TurXavtuoOaOuqKbMlCD1ATtARmjBAzJBiPxb88I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9CA50F806E7; Sat, 18 Jul 2026 11:36:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A405F806F1;
	Sat, 18 Jul 2026 11:36:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A3DB3F80495; Thu,  9 Jul 2026 09:54:58 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783583697;
	b=J9lLyAv/w8F2pBK1Tq4lsIFvHm53jT0dApiCCMfj0eKboFSCxEtXo6JYNru6Tjz16twA
	 yHKcvhp9YI5pBpTR59cLa7Fg8RA17VEov4qDxal+Pb3+FKfXFJRWOhpEoMSuhbpbLVfWe
	 FDgz0ZlnmwEvt48E+5Gfvd6pYDBDrNLkRlC+N2ChcP2vVgSt/mPiFN4rC7QoIXHN7Nc0T
	 t15GGSBNzHSEiMe5O0PIDY42Qswqq9i22pukz7/psrftsISjMgVtu5BgXaNOpkPuiqJNE
	 1RkpemJLlU+l1AhmJjT9T4G2Zni60X2QCG0UMjmaI0K0BwfFNh8rc2jQevvTyNJoUBA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783583697;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=Ma9hZYGKmWu+c4bk/cBfQ6DPevX5CRoMpK8Z9/3dTjQ=;
	b=oqEXajliDVTEFIpzKjoOjqUXr+6AAl9BISo1J0r3mkw9dp6EfOUrTtNCw9UBatrg+//7
	 Ej3RZcCrCrjNpOcMUxBUhqUh+JYwyfzcOeMo3h32sVEKOfDhQn7NuNLJ19vj6GCLVQXos
	 LUA6AdDg/BppNu5vxSAYoiarISkt+bGIUF6KIydsbkKB5m+k8h8PByTPT0z5jEK9r5hz4
	 71nZEr24bNtoh2fpdg8UXj19AKvzoOcmtTTXq2nwiAS/pMEdtZkvO7N4BK18K5dRBLqQE
	 sbQwswD8UX+eMO9jPaNYzLf4eSMhA6LvX/Z2JIVoqoQerEOPCHtFuPHe24IbXlkpdwg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CWW4Jihn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com
 [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CA637F80124
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 09:54:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA637F80124
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CWW4Jihn
Received: by mail-ot1-f45.google.com with SMTP id
 46e09a7af769-7eb1dc6bd53so422882a34.2
        for <alsa-devel@alsa-project.org>;
 Thu, 09 Jul 2026 00:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783583694; cv=none;
        d=google.com; s=arc-20260327;
        b=CdxPDZG23tPi+FKtbLvxgyhc+18Us9XEtuWUaiRQB86H8bIeI0OAxh9E+F67KxGkuO
         kMAzgcq+whlOqwymK36/DYrKAtMacAK1pvC3aCJR2j9CA/XieOl/CY+k9Ev1b49lIrhm
         4aIuH+VAKycs2SrJfwPytQGZHnNVZMxVETHdUzwRp7bcya6DKP7aiBtfdz2lYNe0Vm3I
         KS53jCjFaetUp+hQg5sR3S9oxRj+fXhjWxqEv2eAVBsukoMUpuso2ySSkrslBO83rE8m
         NRlC7peXVrNr3OUZzu0QBPPSLxuvbc9n/Uet7Fx7yn8QecmfJ+3eTJPlgOFC87Gc6O/M
         4qDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FX00PmUaBGhdxGjtEcp4ojX6h8tPyR/nQ8Y5AXR41uM=;
        fh=8MVHGZY4jBXBpbaBVkD0xn7Kh3bOMgLdRpvHKoFetcA=;
        b=nDyqoaDSGchHPf1OsxcNZmECenVjdw9jLxnMkCASqzutZyz/SrvORLr9thNotggNVV
         ucGRCgDvq8bNxFc0N+e2jsVFfFocLXquEROySTtaUUWeAp8n0ubnZnpno4XilUo9Cjim
         ZQnQaCW4+P7FGxIWv/rBEFXLatBWL8lM1+kjntjCw+xPK49GbM6oha8ivzIdshw3RQy6
         HUjiOQ0zQeJgzLv/8l/kmPdcQ2UkKGjr5mJIq5KSzVbtsQR94Ahq3Ta1wkxbLTy5U4K6
         xi2LrzkGB76tkoT60vVs37B3PdrS8fD5tLRvYYeI9xawSndOCXoLvCtWxUEBTsZS8e7f
         58sw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783583694; x=1784188494;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FX00PmUaBGhdxGjtEcp4ojX6h8tPyR/nQ8Y5AXR41uM=;
        b=CWW4Jihng1SvFfZat/F9oyMgsEsiHl8A33FG9fKwegDHEDj86YUKWnubklVACHV2Lp
         py2RzHurF1J7AYy+DZWpCQQ3uFHnpDYPklmV4uehjyWMH8P4puJTSZPPLoLSsWe40Qrz
         FtDj51L3UgNorXmbMgebmNfbsgOAJw3+5/5EZZeEKA0Cm4b9Hut1LPDjQqUS/SFOclF8
         6u6Y4qhcFOI8MUwllGO5es7lvKXisNniYu/dn7hK5XEvmsOWixGfpqeBPlnlT8+lN5bv
         WNe0IYuI0lhloVcSriCTguzNeWIXPCQo03VV6vWwLptcOTP1WyyOoszw41+W1mIfGxod
         RH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783583694; x=1784188494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FX00PmUaBGhdxGjtEcp4ojX6h8tPyR/nQ8Y5AXR41uM=;
        b=K3u1RQAkbtC2/4SIYXFjKGNTfWvljI6YQxC/Ea2YtwVqca4sKbxgO7gqow4LexmNOD
         GzkhQIlgqi18q5sbyTOczE7UPbeZK9oVDYPZalnmyBBiizFnMiyYjTa/cUyP5VTmiNiX
         NwO8xjrkON8jNTh9to00Sryg+YphG3GFLWk37SJ6QYQN4OGQq2WyV2qrH90XcyhnhgLH
         sKO10TvKKsyZhkAOtlVnWWH/P4+lIKfnjXPvXtIuK4ZOIQon3d2sBG5zXVAI/cZauqji
         auleUyHyfOJhfxdR0flAksrFix7fFsckuYi9/DLejalyF2kfhZLaDCOS6typrCjXm7UF
         vbpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xP6e2kUmXuGOJ6el/6Mp7bWAoXnrew6gRMxBZ0A3l74a320rdTwsQMoMnz04d7v6jHlIg3ziHilF3@alsa-project.org
X-Gm-Message-State: AOJu0YwY0oidXA68qBeNr5YSbKPzvS2N6CEGFiyItwTDgVqMaSLqecbU
	sfvCBaJVF+6y6/v19iSKJlM9M3He9lEQOXnK+zlWimKjgA7r6J4n9YeBDUGHWzmo1a6WZ5xeZb3
	lrdVSJp2x+gpSMozNRKOOUJmasmd7A9k=
X-Gm-Gg: AfdE7clBQHO3B+cBMTuJWauF3nAyzB/D+77lcTxOuuv726Efs1tqU+GkMtBVS+Uchjt
	gHlWa9lYjwJZmztYxqTnsYOU0N0po5StPlwdZWtEm0Ah9ABgvfjJfOFeRCPAIGE8Z/na3umuR38
	KxhrF1B3dnsiuy47sJGK9BC+f2Wsz2cMehgHZzgiCtlRWTmv5YVBUfPseWU4HaTEyDAvo8IJEfy
	sGbu9SOwMDP6kLGgUjBylziipz6CYcaES3uXefIokgP/U5/aUUGm5nSQQmtr2HHxKAw8GB/IBM=
X-Received: by 2002:a05:6830:82a8:b0:7e9:c8e3:4473 with SMTP id
 46e09a7af769-7ebd02a39famr4920086a34.16.1783583694520; Thu, 09 Jul 2026
 00:54:54 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAOdyq+qFaqCh=tK_wNnA64hv5pQuA1Y09ANxQ=xK8yR-t4mf9Q@mail.gmail.com>
 <4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
 <87bjcg4nyh.wl-tiwai@suse.de>
In-Reply-To: <87bjcg4nyh.wl-tiwai@suse.de>
From: Salvador Blaya <tiniebla6@gmail.com>
Date: Thu, 9 Jul 2026 09:54:43 +0200
X-Gm-Features: AVVi8CdD75YylWj7sWl9WVm_PTcKz4gGLBge_a1BeaeSo4zknRXfOV8Ydp_BhoI
Message-ID: 
 <CAOdyq+ook_mDq_5wc_Na182bLvxZ1YJUJEchJ6MochU17QecQA@mail.gmail.com>
Subject: Re: [REGRESSION] snd-usb-audio: commit da3a7efff64e ("ALSA:
 usb-audio: Update for native DSD support quirks") breaks DSD playback on
 Musical Fidelity M6s DAC (2772:0502), plays ~8.8% fast
To: Takashi Iwai <tiwai@suse.de>
Cc: Jussi Laako <jussi@sonarnerd.net>, alsa-devel@alsa-project.org,
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: tiniebla6@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DBHOAW6KFCI2ZPAAFKVOLWQFDNTFFWXM
X-Message-ID-Hash: DBHOAW6KFCI2ZPAAFKVOLWQFDNTFFWXM
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:36:41 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DBHOAW6KFCI2ZPAAFKVOLWQFDNTFFWXM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,

Thank you - that approach would fit this case well, and the risks you
mention are fortunately minimal here:

- The M6s DAC has been discontinued for years and the defect was first
  reported to the vendor (via their Windows ASIO driver users) back in
  2018, with no firmware fix ever published. I have an inquiry open
  with Musical Fidelity about firmware and will report back if
  anything changes.

- The only other model possibly sharing this ID, the M6sR successor,
  exhibits the same defect per the Roon thread in my original report,
  so an empty entry for 2772:0502 cannot break a working device. The
  current MF models known to work with native DSD (M3x, M6x) already
  worked before the vendor flag was added, so they use different IDs.

I'm happy to test the patch on my unit - both that native DSD is no
longer offered (MPD falling back to dsd2pcm as on 6.12.y) and that
normal PCM playback is unaffected. Just let me know.

Best regards,

Salvador

El jue, 9 jul 2026 a las 9:33, Takashi Iwai (<tiwai@suse.de>) escribi=C3=B3=
:
>
> On Thu, 09 Jul 2026 00:28:00 +0200,
> Jussi Laako wrote:
> >
> > Hi,
> >
> > I don=E2=80=99t think we currently have exclusion method for devices wi=
th buggy firmware, which claim to support native DSD, but do it incorrectly=
. And reverting with device specific white-listing is not a good approach f=
or future maintenance. Having to device-specific white-list each new device=
 appearing on the market from the manufacturer just because some old device=
 is broken is not really a sustainable model.
>
> While I fully agree that white-listing all needed devices won't scale,
> blacklisting the broken device might work.  We can an empty quirk
> entry for 2772:0502 for skipping the vendor match, something like
> below, as an ad hoc fix.
>
> Though, this blindly assumes that there aren't so many broken devices,
> and there will be no firmware fix or another model that works with the
> same ID.  If a model is relatively new and/or the vendor often updates
> the firmware, such an entry can be risky, too.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -2463,6 +2463,8 @@ static const struct usb_audio_quirk_flags_table qui=
rk_flags_table[] =3D {
>                    QUIRK_FLAG_DSD_RAW),
>         DEVICE_FLG(0x2708, 0x0002, /* Audient iD14 */
>                    QUIRK_FLAG_IGNORE_CTL_ERROR),
> +       DEVICE_FLG(0x2772, 0x0502, /* Musical Fidelity M6s DAC */
> +                  0), /* for avoiding QUIRK_FLAG_DSD_RAW with vendor mat=
ch */
>         DEVICE_FLG(0x2912, 0x30c8, /* Audioengine D1 */
>                    QUIRK_FLAG_GET_SAMPLE_RATE),
>         DEVICE_FLG(0x2a70, 0x1881, /* OnePlus Technology (Shenzhen) Co., =
Ltd. BE02T */
