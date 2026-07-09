Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F68C4451B
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Jul 2026 09:38:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E1376022B;
	Sat, 18 Jul 2026 11:38:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E1376022B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1784367525;
	bh=6SMCHuy00s9l0hfP90+AD8AyjGEzNImrpyQbKe/qJTE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=JaYOE48Sx4NknmatkiyZ6PDh5L06e9XRbBZcSoMc5/EUcP2XaVVO8IRbJ+Dstozmd
	 /k/7zeWZ6x5SYwelRhLDwLnfZ4D6VLl/yPJLWX/OdtVDads/hZtsrFLbPuTm/uoc9N
	 ZB3vSUFAYpb7FTJjw2Ys4A21bC1S1vE4tLjgbbNc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AF260F806B2; Sat, 18 Jul 2026 11:36:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 690C6F806D2;
	Sat, 18 Jul 2026 11:36:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF500F80495; Thu,  9 Jul 2026 09:10:37 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1783581036;
	b=T+wqEbTCa/trtbzDahsDkaMeqarOuSIIBVS/Xej4rAo/FhnMcY2CnkwEJyLSdYaT559X
	 gBTyDi0L3gFDTec/CBbtRki398vbtBQJID8fs8TnW2m/aFhfzmwe0L7BHGfX761qgVx+F
	 26nChELHJryDglUG5SxipkoYpTB64LJDTVsht0CNUWdWdlQVg9VjoneGlAKvWsRDtU/gB
	 WC6L6c9D8MvdFee/HI3f7gyaFQ3NcKG8o6phYHrIBauyTh7l9Y47MPLnlktB2bwLTQ726
	 TrF0gg1kMN9Wbhv6O3HLh3NS84cPXUCS0ANvVTNugBAKr10TCou8uVovXXV1Ecd4KlA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1783581036;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=6SMCHuy00s9l0hfP90+AD8AyjGEzNImrpyQbKe/qJTE=;
	b=f+8jWfSX0hlz6ZxgPPuuV0x3b/SXkbPw00zYWoYXbKngCEIKCr4pbMQ4cziPHd6TE1Mf
	 +L2EhOqthMJ7yn6UuK+6YnJdPCcUdfBwd2XukZ9nn19kZCV5LE9+NKl0nMvK141UOmqxY
	 d4jsrc4alUh917YUEz+2Mhy2CpQa6btSodOL+0P08tz6ns+MfZb3mPH2do/IHg5WAHQhj
	 vQQ0BzA8114B7jG3tmu4Njh2u5LNtd2Ept5dxYRdjJ+zJ1PfvIOQmcQn9HXf2cRgOluxK
	 WmJ34exUrm7/JBWYbK3GkzWQ4LWLPZ6W1AAA/ZsSuVBhSxQ7UobSFEhhSo82RSbN0CA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rV33zNZw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 262E2F800C1
	for <alsa-devel@alsa-project.org>; Thu,  9 Jul 2026 09:10:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 262E2F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=rV33zNZw
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-6a0e525db1eso969853eaf.1
        for <alsa-devel@alsa-project.org>;
 Thu, 09 Jul 2026 00:10:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783581033; cv=none;
        d=google.com; s=arc-20260327;
        b=GFCxu71CkIQXJozmDMlAoot4mowyYq6hQeH8qxnCaYEgG523bxsRnzjGMtKa3GomLA
         q33xA6DQ/34e1U4PEwd+4Sv94p4YJOF5mYm8UXvx5bgP1XYCQWgI07nWdEjB8b2Xcnor
         rOotZPB87id4Lzh+orVcqYGk8kEgWNfESBUnCBdPluaUbLZou2mfWH8byFAcvmWG5TYY
         /Uqp6O1pk/sncBIlQItFHgVAnzf/xDHm7XeQSP9NtowqHcDkar0cuQAkcw1+dw0f/RwB
         Biw04zQNJ8/sA2zWfZ6wLYQsxvRjwDI9vVjNxYDcooNiBebZH19oAIEcCWNIwirOVBIl
         zMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GRXeQ5qE6qZskG9oXPGJsVaA14ddyhrHMKes6w0dbtw=;
        fh=tc+qik/f3zYLHu3enVKrJt1x1rWUdtV1x6F66wot+c0=;
        b=ckhkqmyePctr4AGpuYJZdfiyAMyfGEgPsqqWuvODkj1+AtAYdmYDTZvr7VUA7/Tx7q
         RAsPZFiw5E3BgCwjCflEprFzx0GGpxbHmPLEVvgJkAg8+MxNLdnVVHKD6TbpNrKLUU+g
         CehZBf+wXRmtjMbKNuW6gpISZZS/yvHswiSVdX3KUJY3aa9AWpXGax4xoRc2lOD2tZ8w
         eGMl67qxhkNKCj7qhMD4h5OLxFreOeWl7OGqGAQCJqXp1tv5pxcp+GAXyJAYyTfGOHE6
         Y8Y0oGMW3irgBxQKOPT+J9DhzT1/r9BSM3OF0Mrn3xGSjWwQ/NhZwbkLncXSvyJEg6Iz
         DwxA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783581033; x=1784185833;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GRXeQ5qE6qZskG9oXPGJsVaA14ddyhrHMKes6w0dbtw=;
        b=rV33zNZw0vtmL47ERpOmLU1G1hE6fmigUx5oWsfDGR31cHK5J2ZZgLARcTuubJRZG1
         SAOUWv1hUv2h9vhGS1V3ypA09Dmk8PWJln+TQCxKtI6PtXyuZyjn26aRdfecjjzcHN9u
         vzx9heQ+WtOv9JGh8iFzUUaXXI0LYmB1oBXWY6XNM1f9ru0k5D5B5mcrRDpAFRYt8W7V
         h0AxawcvkKh+ry8xv0U7j4JpHpzGNoT4M4swMwhzNvd3faTRSblKQqshOwbQO1fSb7WH
         Qd/6IMHnrKzXzC4Lnhr63qabbPXTPiFoKP9Ff0r9/slVtdQQLOY9BN13vFAm5/5rOm4J
         HR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783581033; x=1784185833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRXeQ5qE6qZskG9oXPGJsVaA14ddyhrHMKes6w0dbtw=;
        b=pjoiWVlJHSD+GF5A3xHlDF3w2rRN0flpwFrbnpPdHPgrVGPaLPOm7HASO/62i/n6ck
         PVLdUr/gq420oBeSVQJtdB3PzFOTNRO30FqBIFDSREPV9aLWrSZFsrZ/z3x5HVrcHbs/
         ZUyVSZi/Cbz1skl9tbb7a65yXCBeiEhzylDJhihi8KHZsBRa1XvB3YEAAicYONXiwylw
         x/isMpzTdQOEtpEJrByGyMrRkdnkghoNWLIjyTWdUQXJ5eyzHU/wHkyAoGk0EaKgAIhk
         lFZrq/L1KEVj1lDzqsPs+n/2GAuIbJ8vMq9UWRKmYtudGjXrINrq2jgRFv5K3Bs1KBrt
         96iQ==
X-Gm-Message-State: AOJu0YyP4mhimFz8Ba8bEliUG3UkR1JtqR8OcXeZkB5SJ+wpBGaANz/a
	73BgzeeN04Bmz4C7sCxVB5WMhRIZZQ1YCRLR6xhuiQGFfFfWLLdgyQ7IFDdYFtVOQ7VWaIavZ9K
	dcLzfpCa+ZE4sW444HS/KAXI5pVDH6Vk=
X-Gm-Gg: AfdE7cki2KpFkPTk8D+xG0GDxVVHJkMWRESB6cmCFy+2q4bZ8qnZw3NmDuTkMMHzBaW
	FbO2mmknL5mPeYj9SqaEUzaiqmBuSZQj6w3+yXyoWqLzaorbtDin4pLPzUPkbdhLgJsPUncxYaU
	sb3uhzw0pDvWqKaZtvdBjF7Ydr/5N+bNDPRWXK6r2VqwEZD/hYnhxIJFH2DH8TOeanp9ZFLlKrI
	IXM795yIax4lXrpLTsQOpA7HiFxPfEK6bBCJ5u8PXXOHlKQVj+jxFj2OD4o08DNSwiTccJ4Qsw=
X-Received: by 2002:a05:6820:2087:b0:6a3:1e40:6329 with SMTP id
 006d021491bc7-6a36d85fea1mr4429171eaf.13.1783581032902; Thu, 09 Jul 2026
 00:10:32 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAOdyq+qFaqCh=tK_wNnA64hv5pQuA1Y09ANxQ=xK8yR-t4mf9Q@mail.gmail.com>
 <4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
In-Reply-To: <4A4C8B42-D8BB-44D1-BE0B-CB5B4617F29E@sonarnerd.net>
From: Salvador Blaya <tiniebla6@gmail.com>
Date: Thu, 9 Jul 2026 09:10:21 +0200
X-Gm-Features: AVVi8CdUsfr78jpgn-JwLl42qCQn9v_JWlL3kgayPW3yVSKfETZqdr_RJMRxS98
Message-ID: 
 <CAOdyq+oMPFYnF4F=vkX26TiKydOX7DnZiTrRj8D2R7jK5VOPnw@mail.gmail.com>
Subject: Re: [REGRESSION] snd-usb-audio: commit da3a7efff64e ("ALSA:
 usb-audio: Update for native DSD support quirks") breaks DSD playback on
 Musical Fidelity M6s DAC (2772:0502), plays ~8.8% fast
To: Jussi Laako <jussi@sonarnerd.net>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: tiniebla6@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: GPNXLFV4FMG6PBFWBRMTLJCMF2FHZYFN
X-Message-ID-Hash: GPNXLFV4FMG6PBFWBRMTLJCMF2FHZYFN
X-Mailman-Approved-At: Sat, 18 Jul 2026 09:36:41 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GPNXLFV4FMG6PBFWBRMTLJCMF2FHZYFN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Jussi,

Thanks for the explanation - that's fair enough, understood. Since the
defect is in the device firmware and affects every OS, I agree the
right place to pursue a real fix is the manufacturer, which I'm doing
separately.

For the record, and for any other M6s DAC owner finding this thread:
the device plays DSD correctly only via DSD-to-PCM conversion. With
MPD this can be enforced regardless of kernel version by omitting dsd
entries from allowed_formats, e.g.:

audio_output {
    type            "alsa"
    device          "hw:CARD=3DM6sDAC,DEV=3D0"
    mixer_type      "none"
    dop             "no"
    allowed_formats "352800:32:2 176400:32:2 96000:32:2 88200:32:2
48000:32:2 44100:32:2"
}

This restores the pre-7.0.7 behaviour (dsd2pcm at 352.8 kHz), which
plays correctly.

Consider this report resolved as "device firmware defect, workaround
documented". Thanks again for your time.

#regzbot resolve: device firmware defect, not a kernel bug

Best regards

Salvador

El jue, 9 jul 2026 a las 0:28, Jussi Laako (<jussi@sonarnerd.net>) escribi=
=C3=B3:
>
> Hi,
>
> I don=E2=80=99t think we currently have exclusion method for devices with=
 buggy firmware, which claim to support native DSD, but do it incorrectly. =
And reverting with device specific white-listing is not a good approach for=
 future maintenance. Having to device-specific white-list each new device a=
ppearing on the market from the manufacturer just because some old device i=
s broken is not really a sustainable model.
>
> So I would just suggest using PCM with the device if it=E2=80=99s DSD imp=
lementation is buggy/broken, while it claims to have such. Or alternatively=
 update the firmware with a fixed one.
>
> Newer MuFi devices work fine though, like for example the M3x DAC I have =
for testing this, and the M6x you mention.
>
> Additional challenge is that many manufacturers use the same USB interfac=
e implementation with same VID:PID on multiple different products. So it is=
 not even necessarily possible to distinguish a particular problematic prod=
uct.
>
>
> Best regards,
>
>         - Jussi
>
>
> > On 8. Jul 2026, at 19.33, Salvador Blaya <tiniebla6@gmail.com> wrote:
> >
> > To: alsa-devel@alsa-project.org
> > Cc: tiwai@suse.de, jussi@sonarnerd.net, regressions@lists.linux.dev
> > Subject: [REGRESSION] snd-usb-audio: commit da3a7ef ("ALSA: usb-audio:
> > Update for native DSD support quirks") breaks DSD playback on Musical
> > Fidelity M6s DAC (2772:0502), plays ~8.8% fast
> >
> > Hi,
> >
> > Commit da3a7efff64e ("ALSA: usb-audio: Update for native DSD support
> > quirks") added VENDOR_FLG(0x2772) with QUIRK_FLAG_DSD_RAW for Musical
> > Fidelity devices. This vendor-wide match also catches the (older,
> > discontinued) Musical Fidelity M6s DAC, USB ID 2772:0502, which exposes
> > a UAC2 altsetting with bmFormats 0x80000000 (RAW_DATA, 32-bit) but
> > whose firmware cannot actually clock DSD playback correctly in any
> > mode. As a result, since this commit, applications like MPD prefer the
> > newly offered native DSD over DSD-to-PCM conversion and playback is
> > audibly broken (runs ~8.8% fast, raised pitch), where kernels without
> > the commit (e.g. 6.12.x) play correctly.
> >
> > Could 2772:0502 be excluded from the vendor flag (or the vendor flag
> > be narrowed to the specific products that support native DSD, such as
> > the newer M6x DAC)?
> >
> > Evidence gathered on Debian trixie, MPD, direct hw: access, no
> > resampling:
> >
> > 1) Native DSD (observed on 7.0.7 through 7.0.12): host side is correct
> >   - hw_params shows format DSD_U32_BE, rate 88200 (correct for DSD64)
> >   - but playback runs ~8.8% fast with raised pitch. A 4:41 track
> >   finishes in ~4:15, matching a 48 kHz-family clock (3.072 MHz)
> >   applied to a 2.8224 MHz DSD64 stream (ratio 1.0884).
> >
> > 2) DoP (6.12.9, MPD dop=3Dyes): host side again correct - hw_params
> >   shows S32_LE, rate 176400 - same ~8.8% fast playback. So the DAC's
> >   internal DSD decoding path is misclocked regardless of transport.
> >
> > 3) Control test: the same DSD64 track converted to PCM FLAC at
> >   176400 Hz plays at correct speed/pitch through the exact same path
> >   (S32_LE @ 176400). The 44.1 kHz rate family is fine for PCM; only
> >   DSD decoding inside the DAC is broken. This rules out any host-side
> >   rate issue.
> >
> > 4) The same fault has long been reported for this DAC on Windows 10
> >   with the official ASIO driver ("DSD via DoP plays noticeably
> >   faster"):
> >   https://community.roonlabs.com/t/musical-fidelity-m6-sdac-dsd-issues/=
39450
> >   including a follow-up for the successor model (M6sR). This is an
> >   OS-independent firmware defect that the manufacturer never fixed,
> >   which is presumably why this model was specified as DoP-only.
> >
> > Working configuration for reference (correct playback): MPD with
> > dop "no", MPD's dsd2pcm conversion to 352800 Hz - i.e. the behaviour
> > kernels without the commit provide by default for this device.
> >
> > Since these quirk updates tend to be backported to stable/LTS trees,
> > please consider the fix for stable as well, so that currently working
> > LTS kernels (e.g. 6.12.y) don't regress.
> >
> > Full lsusb -v output attached. Happy to test patches.
> >
> > #regzbot introduced: da3a7efff64ec0d63af4499eea3a46a2e13b5797
> >
> > Please CC me on replies, I'm not subscribed to the list.
> >
> > Best regards,
> >
> > S. Blaya
> > <m6sdac-lsusb.txt>
>
