Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E52C5DF94
	for <alsa-devel@archiver.kernel.org>; Sat, 22 Aug 2026 01:02:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8B136602A9;
	Sat, 22 Aug 2026 03:02:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8B136602A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787360531;
	bh=5tiZscwbiNc4IPp1Y0lM+j045t5GbtoQu9Eri2oFBAc=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=c1g5Ut/G/azSzQQW9yy93K7paPmCncctk5SHPOiXFbeUeAd6tkecKEO6CcxaJNuBV
	 OB3SedMB4aJtrjlTx0VuSb1arlX8H2eKgOOI1asWnUDHEHcb+G7A9uZb6nmYYTNpKB
	 ZhsBa2vHS6Vrn1QIe9Ybkdalu+M83S2HAMcoxd9g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C302F805F6; Sat, 22 Aug 2026 03:01:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D1946F80602;
	Sat, 22 Aug 2026 03:01:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 490D9F804F3; Sat, 22 Aug 2026 03:01:29 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787360488;
	b=UoM2P7yTE8Y192TmmyKIu8yJokoG4yXNj3zuG1FONIghPnpWUep6n8uwKvre2ofw8EGK
	 Q0X4Mm/2cBe3Y17ujFd588eaN91yNi+owzUy+7JtWg3C5ZbDEl+3mqGLzb9QQcR/5fPZi
	 ZebInwUOi5i0/LSrSmFTN7ggHStVXcb9SFxGezJxmfsL3/vF9oqgivQJjcMcmokbA3qTa
	 tD09ZxVyP21fV7/UB9CZwl+pDrHmIAVB3ppX9E8WnrXThhdTwJyZrM8hJYOYuSa76Gqd1
	 hjNXnsc60QXSjIRBivMwrvoLxioE50+fXsKV6j8x2Lzc5lZs85vR080DmyUG+lOt5PA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787360488;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=5tiZscwbiNc4IPp1Y0lM+j045t5GbtoQu9Eri2oFBAc=;
	b=ceLRzNukFBhKp2vRN4cjWXv4UU2GdLgVgKgSR7DnMmX/F963IJYjnxOOBCoCj62ej0om
	 gfLkBOBC0ljeQxPLJsaWKyKo/3oGdk0hktC8A+/xB85abC+QFqtlkZmrYDt6S5biAbiBA
	 fXfbl0nH/516I0mJjCUX7KL4u57ECYx5w5Q9Kwptuzc1BdsxYZ2bQI3+jxR8qhexVfB2e
	 0Dc4oIc2dtaFikzJjJPMOYipjNUfr0RSiRzJ4jjFrgBacotk3ia0/4TMvlf/ECjoec2bB
	 kxGALHY/QgLQzCrY642VmKKwjS98FM3DizqQmV/6HjT18+NG6Yh4mgLRFK3+ZyzCXAg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sfCoCcoQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8026FF80075
	for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2026 03:01:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8026FF80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=sfCoCcoQ
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7e9ecb1e13cso2534810a34.3
        for <alsa-devel@alsa-project.org>;
 Fri, 21 Aug 2026 18:01:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787360485; cv=none;
        d=google.com; s=arc-20260327;
        b=P9x3JYp0Skz4IlPLm93faCCyRnYYKJ7ZRfiB/wzpTiwKlPNhKYIBNsTyyFkObyp5HP
         Wg39XraEXsvKg2h9FtnzzO7RGLXzrkfQsGi4nAjGkLWXcDtmp2p7qcckw+Gxd5FEfkdu
         BfEslS1MF2TVmGXdImPFrbarCX9xX6XU9+1ma4FRgTkeJhs2Trs5ptNZhTlsyYmUb1rr
         20RP/VUqQM1lop6m5TqvqCfqfpCWZRmpZEP+7ZXFItgnhW5ez9fNwrh1qx4H/pd9VFUn
         fDNJbvmyep7Nv4YUH2iDxV6NRvaTP8OTgIvZOK4bN1L+LfGxfjSLjs6NS/8HtGJwcwdy
         3brQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2MUZ8Q7JL6sWk6EdE9h4GD/hcKRyaeIQz4GQD5oEMHk=;
        fh=msFQX9NJ3oPmqWLZvu+hmzfKks7q+f2dFW2fk/Lo7cY=;
        b=dv0nPURUAF4/d8kmxKL+oyt7EbSz7RZ5IxQYj3yTdljeJGWIMADqUzKhTRmNxXdgNx
         +mNg9R1l0IWM4uUv90ipdPmnH6NyLtyxToB/yo8H7zf0Nz/cQ7GWotcsYL7/yU1595kT
         3MbYI0DclqKrMMXhkDMxWVe5kUdBD9fxA2XB9lkmKmuOvsyIZqGkDPWEnTXsYIF5HKR7
         5LR9IwMAyMkX05jV3x5pv03EfQy99CG4uYi+YmDcCt9UgmsFln7ICA1RmYT96XZsQBqv
         gAI3KyvDouMtNInoMY6n3L9KIbYxuLZTHnesLRpkLnkzfVFwidva9XQOjXhsvSCDYbhj
         aE3g==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787360485; x=1787965285;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2MUZ8Q7JL6sWk6EdE9h4GD/hcKRyaeIQz4GQD5oEMHk=;
        b=sfCoCcoQOxVRztDrSmhpycJGpSYAIkvICNevRdgFKhoklmeDjrUuvE1UdfdkLbewy6
         IYcYUgfSlsBMawWHlFb0KFgKgVkMmY5XW3eg1enZfHSoxfU/Bhgrfl2fAK8LnVEUHkXR
         vMruSfpZ340gSd82075mJWEM46EY+0QKqAeqP9zB4d37wjalfhy+DTlUslFtegBGd86L
         +xBHVNUERe1iZI3hAol7duWirEicFIcLBO+IZv7NLxW4raW7nFHfCBq7XbIq/CjeDem2
         drfwjPmuOqWWaUpm+fzTOZ9PlLKM7WFcUlSLTT0k44q9qJqI2d9YUm6ZYnLWuhGClee4
         TkYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787360485; x=1787965285;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2MUZ8Q7JL6sWk6EdE9h4GD/hcKRyaeIQz4GQD5oEMHk=;
        b=FofbJ+0UFyvXFHfDNs9TsMb57t96FXB44dk/ggxM/eHPqNRe4i+8Dypc3Uk3mJtcKI
         Qvqf/6LQBJ8iWomkfQoVMYpZ0yaw9hxwP1Z0U9tk8HskUrT8o1WWYouzBcGThs5UdyYC
         WQRZ+weyYCiDbrtY3gV0cI6EbNbGNfaONHOaPLvp4TrD1qSB4RzUQUKlY80jYwbvE334
         zN94YetbCsWajHpn0Bxmiyv7e/Yx17bIkODEvJQkZOEubiJh0yKYYFS1Ctm9ei9Af6ji
         54ehkgaahxD2m5ZEocQtMYW4tZWz2T7rx4/FtCdIYQLutwbLAOo+tDQ5vqZ7zn0/hBKA
         yiqA==
X-Gm-Message-State: AFuF++k0Jp5hoLjwu+i/GR57MPk/rSD30q1rrwzgj9uf3gJNAbEWqwit
	HPVdt6Zz+wMXh59SSG6lex8weJiQrzfHIFYgz03Y5RZCM9am2/oXom7yYR8m8etNUyvO4GBOUcB
	eJW9IAIjXL6ZsqMKOW3l+IZztBiVxta55XvBH6j4HnA==
X-Gm-Gg: AR+sD10bGcLBx1GIE84vJXcHGqQyxHubdV/9YVtFuU6WKMrizsewT1zFruUXgepEEFS
	EicwjER1fg1ajjp2tEUrBw+TlVijaJK/SRNfIXRBAn3jNzzDhTdbDoL3ry4NCWVODkl3FaJSDfD
	ct4H59H4GkFbyKFj/aNmaDnJekmeKvr9nG9QoyQqBNAevZYVmkwIiCri9y6IOFISp/6kelT+D9g
	ATgUvtnoHq/mf1cxeL6BJBBAV/zd52XoEPyojYRd1TB4OJ2rkf6liAK++bdylsUOqJogbcb7zS9
	P7C/eaXqVJlIe3sAAC2y/dzjYMgGyX7LuI70UYIBGkpUnL+JAFoGtLwnfrl08v2CetLK1GUoZWM
	yETAhAqxhBDfU6sn1ufterKpuT7qNL6CAqg==
X-Received: by 2002:a05:6830:448f:b0:7dc:c7aa:22bd with SMTP id
 46e09a7af769-7f4763b684emr3802341a34.6.1787360484915; Fri, 21 Aug 2026
 18:01:24 -0700 (PDT)
MIME-Version: 1.0
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 22 Aug 2026 06:01:13 +0500
X-Gm-Features: AcwNN1WaTNH4rJZO3R7SSUSWWiMCddNN9RXbBBuayProfTptOm8mWYRxTXtqSvg
Message-ID: 
 <CABXGCsMuopDFyQ88+00wECHTON7tQLAkoGOQvquqpAg+92vDcA@mail.gmail.com>
Subject: UCM: is there a way to act when a device becomes the active one?
To: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: QRKR6DH2XIUESKFU2GXTEAODO35B6XOQ
X-Message-ID-Hash: QRKR6DH2XIUESKFU2GXTEAODO35B6XOQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/QRKR6DH2XIUESKFU2GXTEAODO35B6XOQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Two problems from one card, and I suspect one missing piece behind
both.

The card is a USB interface with ten playback channels and two
physical outputs, headphones and a phone jack. A UCM profile splits
the ten channels into five stereo outputs, and the desktop shows five,
which is right: they are five independent pairs and different
applications can go to different ones.

The first problem is that they all sound the same. Each physical
output listens to ONE source chosen inside the card -- an internal mix
or a single playback bus -- and that choice is made in the vendor's
control application, which exists for Windows and macOS only. So you
pick "Playback 3/4" in the sound settings, the audio goes into bus
3/4, and you hear whatever the output was last pointed at. Nothing on
the system says why.

A kernel driver for the card's vendor protocol publishes that selector
as an ordinary enumerated control, so the host can set it now. My plan
was to have each of the five outputs point the headphone stage at its
own bus from that device's EnableSequence, so that choosing an output
would mean hearing it.

It does not work, and I think the reason is structural. WirePlumber
enables every device of the verb at once, so all five sequences run at
startup and the last one wins. Choosing an output afterwards is a
change of default sink, which no UCM sequence observes.

The second problem is worse, and it is what makes me write. The card's
analogue volume belongs to the physical output, not to the bus, so all
five devices name the same mixer element. Each sink then remembers its
own volume while the hardware has one: set Playback 1/2 to full, move
to Playback 3/4, and the slider shows something else while the control
still reads 99. The desktop is showing a number that is not true. I
can avoid it by naming the digital per-bus trim instead, but that
attenuates before the converter and throws away resolution, which is
exactly what the analogue stage exists to avoid.

Both come from the same gap, as far as I can see. UCM can say "this
device exists" with EnableSequence, and cannot say "this device is now
the one being used". With that, the profile would point the output at
the right bus and name the analogue element honestly, because only one
device would be active at a time.

So: is there an existing way to express this that I have missed? A
modifier, a property, something on the PipeWire or PulseAudio side
rather than in UCM? I know ports are the usual answer to "choosing an
output switches hardware", but ports come from devices sharing a
mapping, and in alsa-ucm.c the mapping name is built per device, so
five split PCMs are five sinks by construction.

If there is no way, would a per-device sequence that runs on
activation be a reasonable thing to propose? The shape is not specific
to this card: any interface whose outputs are fed from an internal
matrix has it.

Happy to write the patch if the direction is agreeable, and happy to
be told I have the model wrong.

-- 
Thanks,
Mikhail Gavrilov.
