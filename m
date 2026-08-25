Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A132EC61DB6
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2026 09:05:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 483E4602A0;
	Tue, 25 Aug 2026 11:05:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 483E4602A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787648722;
	bh=jfD/BelKkpziNPeDi93EK8r0hgZBtNL1HOMaQR+WNdg=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=BffP9kFO6cyDHsuoFvJ0/Y7a8Ees/hjEcMUKh5H4w86x6QR6PkGoJoYUc3LQjCF2f
	 rUJ2RilNDQ0iadVa+Gn7qEYhs8Za9nGxcEIRXGd15ZInxNyLQDNxybPuNtKkiMH0Jx
	 /X9dhYwt7esh18Zcn+SPoaJc1SupPhgjAp7ZZ3fQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 22689F805FF; Tue, 25 Aug 2026 11:04:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BE3AF80600;
	Tue, 25 Aug 2026 11:04:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72FB1F8027B; Tue, 25 Aug 2026 11:04:36 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787648675;
	b=oCYR2w1XHBXy2QoZn95NSA+CHMED4dGMySAcGtKkRkfonVYF5mk2jLdZajIEcw8y7X/V
	 d06liAZvjEDiEQWRO/ybO55MvQ0F/SUXnne+tj6cp2L7NQYR7wECnjJKMe2QdKKeamvWH
	 XQfjazrYri2oNkHxpLzOo0HYOZ5ymKU+C7eL1Yuulrv7YCoZrtZqVu+02MvvT1ENj7dKW
	 WSD/C0d2QM78YrC52Rc4Lq715sTq1z4l0dul5kyLNmGwVvlKqhF07NN3NSQFfuByCBK+3
	 cuRNk1Z1NnZCG3YRUPjToUywXles1S+D0D/r3emQx00l7i7HjwV4pp1O8jTrgDZEfEw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787648675;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=jfD/BelKkpziNPeDi93EK8r0hgZBtNL1HOMaQR+WNdg=;
	b=GgvDOXbBpjdXfh9eBIM4yvpmyf47Q9B+e3i6zxDKZ6AjvvEU9PHsgh6TWnwWBv64gzzQ
	 7tz2k+tgfsWHZCVMzArDEOLNi1ZQBMotwdhxZ2KQcd0vb7uP2infL1XsNUnI98vmcNlGZ
	 P0JXMiNNA3yBpSMi7DCpcJisAFv5uuhMyaQ1JQdShtpGUtmGNkexgJEaJW9j4CfgkB3sr
	 M6cqDvOuRgVex5gHWldjjVEpt+AjAczXMjPHC171FFXYtKYD/eQQsgYwMXCjncUrUU8vG
	 c1yAcEEZmyH0O0xEkZnR/xur9YhkKQVM5znx0sB6KZUwSeTnF6EJ4QMcME7YtVahNsg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QTqAINFj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 283B4F80075
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2026 11:04:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 283B4F80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=QTqAINFj
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-7f3f52143cdso4315377a34.2
        for <alsa-devel@alsa-project.org>;
 Tue, 25 Aug 2026 02:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787648672; cv=none;
        d=google.com; s=arc-20260327;
        b=fQv4ANdRgG+2FYAwgla078hOLS5IERnGBq6LnCj4da/zbV0jjxDg28VRpmAQi7kpHg
         jUgHbP7hVQFhzuXOXgs9v5Loe98vymlHm8Nt32LPSwrto6JgknaM8M/buVzSDcaJZ66k
         4qFDtuhCEiqPIRymWANofU9kzYxOr5O1PZ3pJGe5M2EjmkAcBIQ/LxFcTSYD+KTa3w9l
         HVisp/uBiVazW+hXWLXtdeaoTpIJS/ud/Dsf7iQjzzeqakLw//EBrAUnxxLx+QRgBeG5
         F/fIuGcyvnCkc0mkscKpAjIvaq7c/x+6sjaeuHE6rDWqoPNmg3cXyMmwOz8S5F4/1kzu
         OXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jfD/BelKkpziNPeDi93EK8r0hgZBtNL1HOMaQR+WNdg=;
        fh=msFQX9NJ3oPmqWLZvu+hmzfKks7q+f2dFW2fk/Lo7cY=;
        b=SoZKdT7Hg5q67pjTAvQ4p9dtkOT+ZIG05sBzoblcit+gemacVk3m62t52avEm6D1kg
         KcfBFSxYI794pZASlNSRVYm4bQgtuqAIrlJvzOlcFDNhleIDCBjcevfxri1xEKrqYcHT
         1GlnKev24tGPSGE8CZIwh3Qta8Hdi1DSDCUxSzWAa9YexNbQBnH4HHV7AQRIBMNuzl/C
         WLLMNyKyMtWmWPK5CZ4HvFyM4grGKIV+0vPvFqdtXUAGgb1mPmRqgrNWthVlSqXFQt4U
         x614Hlgp+JKLIecG6BKrgbyZqdES494aA69ttgqQTnTZ2xHhXJMPv6OfJL0Li6xr46kM
         /Lmg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787648672; x=1788253472;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfD/BelKkpziNPeDi93EK8r0hgZBtNL1HOMaQR+WNdg=;
        b=QTqAINFjKI+LZ3k4D7AS3KwlYlQNcvzHCizuZe2d4stTVaQnY1EGAGIeTcp+v/3Y5C
         5kC6MmYawVSpIj28sEn+22ddzHfgfSfxA99G/lK3T7e/uZboE7EioS3zawgQ5Zc2Y4Eq
         BaPxvF5uZzMLG12JyYb118koUFhKileECWQWYyNKNu/4jjKkjXcGwwhif/aOvlKzB4JX
         TJVo+N3O1GEoyB5lHmsX8HwTXGL8nU8aqhIcV5bOg8AHIpsiF2vPzVWz/zs+Lf0r7vLQ
         eE5wc2V8sY7Bg2H3fimxEPIq/F2pgsEoZxgl69ANXZouMqT0S+UEOOb7aB3Z0fiwMLpc
         SIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787648672; x=1788253472;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jfD/BelKkpziNPeDi93EK8r0hgZBtNL1HOMaQR+WNdg=;
        b=Ak4rxDZDnABnI+dWiuvEv66gx6D+qsrAyoQ5TtBumrfmIG09HGk0z2uDbQHsNINnna
         z7lE8Wz0xb2XGXvMhM25PxjjyING1NbidNOF1MZs+l3xhIfF0VFh8biSRMuYVUeBwbOd
         ioT6zGt/wGNIqTHDBomla0ZTUD762D8jkktFvCmmf780sVxAh8zSXhK4+dm9waX8Vp91
         oAjKTz5PFx6V1iZEGdA6QR5bfbek2Uj3RobqkTSPAqKI7uUNObtl/kwFfI5pHBhQcPyq
         Uoijw/NDzNdlXUAtSRVPgvlRKt8oKzdIE8tShMVZSNxKc/5dG2CKC3km6OdY2trC6FaI
         2PNQ==
X-Gm-Message-State: AFuF++msLAUbuvvxw2oYw9qkeCbmmKH8/mwEwf1cK4ni3xw9W20PVtU0
	lVvXw5s8Cv6F70um/DcwG2wZhIMR816zzqXSYnACVBb/SXDi+II78GcWMAa/WFtGJjhrRg8cFUw
	DLYErV2tvGwhY7AICulHwUoW6ceba+iDUzrEcfzijQUDF
X-Gm-Gg: AR+sD13g2Kr36Sg88kSzCuDL1b/oS2eTwDkNHC4f/PItPJgm24GanlSUVqn5j843yf3
	a6Q4QwRah0G+U/OlLUI87vybWQmnfCaAVB4RkPDzyplPTreFMsqH9ey4jO/PYoCtn+h9czbFylU
	m/Qs6zJJvyBc7XSBAYeROaBLRnq1sUCw3axVnc+lXJBME7SI2zRx3VkOWXjwTsIEJ3l7q1Crjkn
	zQLoarBAQcD5CcvH2XukXMGMYIvYQL+0diXAK6cuVa6RSyHV8lbw77rlUrO7IDFHfSOWZElTzHW
	420K7ayjJ/BOPGP15k1Y6BrgP23VB/hnQmEWI2WE6+gfpzA1S2TsIvaU/RiinH7R/ir74Pjup3J
	3h3h9kwE8YoVrp0/Szv92MJ3OnqMugg==
X-Received: by 2002:a05:6820:161f:b0:6b1:3ec0:6090 with SMTP id
 006d021491bc7-6b19038590dmr3795761eaf.11.1787648671468; Tue, 25 Aug 2026
 02:04:31 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CABXGCsMuopDFyQ88+00wECHTON7tQLAkoGOQvquqpAg+92vDcA@mail.gmail.com>
In-Reply-To: 
 <CABXGCsMuopDFyQ88+00wECHTON7tQLAkoGOQvquqpAg+92vDcA@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 25 Aug 2026 14:04:20 +0500
X-Gm-Features: AcwNN1XHtvfphvaPOLib8SWCP0VBAXeD9JRv-TawA1H2d04rPCJI6h4yfkc9q-s
Message-ID: 
 <CABXGCsPczShK2QY7vv_Au0LR757fKap4w318h7jwGAsZ6eRYeA@mail.gmail.com>
Subject: Re: UCM: is there a way to act when a device becomes the active one?
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: 3VFFKOC3LNOSVKKR7DKQOKQDOHWLVUCR
X-Message-ID-Hash: 3VFFKOC3LNOSVKKR7DKQOKQDOHWLVUCR
X-MailFrom: mikhail.v.gavrilov@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3VFFKOC3LNOSVKKR7DKQOKQDOHWLVUCR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On Sat, Aug 22, 2026 at 6:01=E2=80=AFAM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi,
>
> Two problems from one card, and I suspect one missing piece behind
> both.
>
> The card is a USB interface with ten playback channels and two
> physical outputs, headphones and a phone jack. A UCM profile splits
> the ten channels into five stereo outputs, and the desktop shows five,
> which is right: they are five independent pairs and different
> applications can go to different ones.
>
> The first problem is that they all sound the same. Each physical
> output listens to ONE source chosen inside the card -- an internal mix
> or a single playback bus -- and that choice is made in the vendor's
> control application, which exists for Windows and macOS only. So you
> pick "Playback 3/4" in the sound settings, the audio goes into bus
> 3/4, and you hear whatever the output was last pointed at. Nothing on
> the system says why.
>
> A kernel driver for the card's vendor protocol publishes that selector
> as an ordinary enumerated control, so the host can set it now. My plan
> was to have each of the five outputs point the headphone stage at its
> own bus from that device's EnableSequence, so that choosing an output
> would mean hearing it.
>
> It does not work, and I think the reason is structural. WirePlumber
> enables every device of the verb at once, so all five sequences run at
> startup and the last one wins. Choosing an output afterwards is a
> change of default sink, which no UCM sequence observes.
>
> The second problem is worse, and it is what makes me write. The card's
> analogue volume belongs to the physical output, not to the bus, so all
> five devices name the same mixer element. Each sink then remembers its
> own volume while the hardware has one: set Playback 1/2 to full, move
> to Playback 3/4, and the slider shows something else while the control
> still reads 99. The desktop is showing a number that is not true. I
> can avoid it by naming the digital per-bus trim instead, but that
> attenuates before the converter and throws away resolution, which is
> exactly what the analogue stage exists to avoid.
>
> Both come from the same gap, as far as I can see. UCM can say "this
> device exists" with EnableSequence, and cannot say "this device is now
> the one being used". With that, the profile would point the output at
> the right bus and name the analogue element honestly, because only one
> device would be active at a time.
>
> So: is there an existing way to express this that I have missed? A
> modifier, a property, something on the PipeWire or PulseAudio side
> rather than in UCM? I know ports are the usual answer to "choosing an
> output switches hardware", but ports come from devices sharing a
> mapping, and in alsa-ucm.c the mapping name is built per device, so
> five split PCMs are five sinks by construction.
>
> If there is no way, would a per-device sequence that runs on
> activation be a reasonable thing to propose? The shape is not specific
> to this card: any interface whose outputs are fed from an internal
> matrix has it.

A follow-up, since your answer in the other thread bears on this one.

You suggested multiple verbs there, and for that case it is the right
answer. I tried it here too, and it does work: five verbs, one per
output, would make the outputs mutually exclusive, so each one's
EnableSequence would run when its verb is selected and the routing
would follow.

But that costs the very thing the split is for. The five outputs are
five independent stereo buses; a user can send one application to one
and another to another, and that is the point of describing the card
this way. Making them mutually exclusive to gain the routing gives up
the simultaneity to buy it.

Since I wrote, the kernel side has been through review and is at v7 on
linux-sound, so the control is no longer hypothetical: the selector is
an ordinary enumerated control. What is still missing is only the
moment to write it.

The other half of the problem has not moved either. The card's analogue
output volume belongs to the physical output, not to the bus, so all
five devices name the same mixer element and each sink remembers its
own value; set one to full, move to another, and the slider shows a
number the hardware does not hold. Naming the digital per-bus trim
instead avoids that and throws away resolution before the converter.

Both would be answered by a per-device sequence that runs on
activation, since only one device would be active at a time. If that is
not the right shape, I would rather hear what is than keep guessing at
it.

--=20
Thanks,
Mikhail Gavrilov.
