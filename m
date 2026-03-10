Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F56F106703C
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:24:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DB0DD601FE;
	Thu, 12 Mar 2026 16:24:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DB0DD601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773329084;
	bh=42EEnIo48m+E4ZUcaEDasfHmBleywoOljOZE8Z+sEMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=NLXzEbxnSnV73NyrZZtGyHDIi8N36MZeu2luEhVZqEjsou3WffjB8P+XfTps+fpho
	 V7rDew6QoFyKvRksax/vfZ1KCOqOF827DlaiL36WbSqxOiW+hg/XyZCgJzeEXzrg+r
	 eHqI3p+jb/pfuwE9u554QTUNVqqZv/M/m5W+Zy6A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4A22F80634; Thu, 12 Mar 2026 16:23:45 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 54CB5F8063B;
	Thu, 12 Mar 2026 16:23:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67B5BF8053B; Tue, 10 Mar 2026 10:41:13 +0100 (CET)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 45AD6F8047D
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2026 10:41:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 45AD6F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=iaowWhLW
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-829781b2b01so3894498b3a.2
        for <alsa-devel@alsa-project.org>;
 Tue, 10 Mar 2026 02:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773135669; cv=none;
        d=google.com; s=arc-20240605;
        b=JdYR08rTJ7TTEzumDP90YRt29ittoaRZqJn8ETWVTJxnPl+vYJszgKWEKCVloNU3jR
         s22tP94wsU9mBHqwnKO+PNIEl59oKo4HTslNvVXduShia6bU6VrQqDnKJ/7xZSeSLZNO
         ud/zMOcMPpkhkjTUY4ziuNcjGbckZsdyNQPsZlQDz5GEQV4ZmfpMHW/nryne0d8CU3ct
         CTtC7ZtOgR/2rJQk3srNIcDwYphw+Pxpd2zdM2NSFPGkvn+F33UukXMyYgm1Sb85YqpH
         H+KiiqZdKEBdRRex4xnrhN+8YombCIHhXmP+LBgx+RQ60F4Ctl+BYIN09mpJhxb5gKwh
         F08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Too0WbBvqqA2xsVan1ZK/sbxWcWO3tAja3epVtAoaes=;
        fh=tOix8eBuiz6sGVYpwwP+0+pTDNJh5CSGal5ElMLXDEE=;
        b=kbY2hU9c7kbWuKT1VBtHgNrp+luKDtEHinW6OBKp71wckngTr0ZzvNVK1mi4E+l9W9
         2ElyeJmxfgEziJn+mbHEKQ9x83bh1Z8KwrSP5xYuv074SeWHRU20aHOvjD3NhaXR4+D9
         e1o0hDhGQgACopa60Yk6+sWivV0HU/aKHcX6gmk+2esWj0cj3t5nAHl8dsbAJzCXCpH3
         u7rDJoTtbXtj8sKszIdjsljz8djY1CTbty0Fy1FYM25T+SzQHE9V5Ux3nJ/JlOC6GHzR
         qE9B6DWVP23N512AevTMqenAOjoYfX0AIfmjKagnqWP5lmkwXceuwvf1Nq3r+ti4xPSB
         A+9Q==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773135669; x=1773740469;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Too0WbBvqqA2xsVan1ZK/sbxWcWO3tAja3epVtAoaes=;
        b=iaowWhLWPV6NoLkDwiruZY1URhbDXrgp4fh71YSK/Clkd2L6IM1fbca5O+NOBR8CeX
         eT7tO1itLNvNSJCaIOQv44C1hH2FnPEZAG7i4Srd+RSmEMQ/C7QDu1fPeMsF0+VG3WIe
         Nfl4KUIdY62VG6spuxCcvMM5Y7oEJOrITKlSDOH6Zf+9535+/AKhHt198SBHe/q1El8Q
         +eTbb2Znjgh6bVIaig21PBkj0jWYTYTUk6O1uqQ5oOJFro8wZuZ7LfUB8NypmZhddMxy
         ZE2rORV2kMUMeLSjzOfMYGcEQME5ZBsz2BMvnyjlfwmJwDgFSbTou1VakmHfMnehUgvd
         bYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773135669; x=1773740469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Too0WbBvqqA2xsVan1ZK/sbxWcWO3tAja3epVtAoaes=;
        b=uBJld9ENCE8PP4QDTKgPQThBhqjS4ASHbJVrOURoz2AIqeXgZEZUJVIc0v3klUZGtQ
         Dqnf6yOLFxabvVe9DAQ1MdeaKBQcARzKM4QAwkh0Lqu+QeIq3iPrOsV8Ei3RZTkGgY2e
         BS6o5A8mz7m0Uc7eLdF+WG8x4x3t0DyG2r7ABKe5Sdy6uIyKwB+EMXiMNc9CtsolOv9F
         B4GVJCSuf680UmukWBIf/jKZiGpNQVcalnFLjXE08hXlw0f/vP+J2Bd5NkQ03wmmU35C
         CuTtasG61Imie90aNz/1wSVOgJHF8XeWeDuNNimm2JZCYlAZR3iFdsqGUv6/8UbGsY3M
         QwHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOKxpPmR1mvjEIciMn9wX8IcOpdaeKolRDDcOvAn3IjxD/MNEFb9teepCdmkD3bBVdSjPbFmNamwn7@alsa-project.org
X-Gm-Message-State: AOJu0YyUxGHzE0lC33pAx1PjTHcEP0EO3YsvSf9IzTy9UngIPgzFja/u
	anGD/XPBk23w2b9l4Jw3WxQe5wsKuc71X9h+F6SEH/3G0DQZmdV8fwd11X330Ec9/ZcaimLlwFM
	9cJzYVGeBTOnc7maGeGeX0vsqx9R4DCg=
X-Gm-Gg: ATEYQzz6H8iZSF0i+O4v7v/YCvO4QPNEQn+37Dgr2aHS86NW16ozXEFkhK9qSwttZmk
	pDhDpP/Voo4S5HxYPiPZbRwvQTv4rl7TOqOMUyoLwYZlcWzlqDf3D+c0yeuyGyRYL4io5hpc9V+
	aOb0GXtkcJJEaqndPXic2d9/zj2kT1h4UGXnjmgYCQgT1MqCG4wa29wTJJnVsT64KLuf6RnRMvT
	aYP7IrpjA4hRI/4TpTgs9XE68jvGFAFvW3h5L75bnZj/SobLVgo1VXnDNHCK4VxaIGEF1TV1zF+
	hRkgxSfYfqDYtRSz8aLePcbkp5isFc+9ljwBiROuPLwnor+qTg==
X-Received: by 2002:a05:6a00:2789:b0:823:9e5:855e with SMTP id
 d2e1a72fcca58-829a2b460c1mr12731502b3a.0.1773135668517; Tue, 10 Mar 2026
 02:41:08 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com>
 <87a4wgrxil.wl-tiwai@suse.de>
 <CAC88DfvjQvZvdvGdZ00woMymE2tUWk=2Dbqi3EzuzSHxGjEnzw@mail.gmail.com>
 <871phsrsnf.wl-tiwai@suse.de>
In-Reply-To: <871phsrsnf.wl-tiwai@suse.de>
From: =?UTF-8?B?SsOpcsOpbXkgQmV0aG1vbnQ=?= <jeremy.bethmont@gmail.com>
Date: Tue, 10 Mar 2026 16:40:56 +0700
X-Gm-Features: AaiRm53XcUwyb-5gh4G-OUgUJCFpiE_MjC72GceFp0Xp0OciyYPxLtNoIGmtRic
Message-ID: 
 <CAC88Dfv9S+BVJAZeZ+rfyRQHB4C05mSNSHyLh+DTvUAyGOCX=g@mail.gmail.com>
Subject: Re: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC287)
 after commit d2e01e0c5e94
To: Takashi Iwai <tiwai@suse.de>
Cc: Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MailFrom: jeremy.bethmont@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: FQSSQXTY7ZD7JEAU4K5ZHOOGUM3TPROO
X-Message-ID-Hash: FQSSQXTY7ZD7JEAU4K5ZHOOGUM3TPROO
X-Mailman-Approved-At: Thu, 12 Mar 2026 15:23:29 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/FQSSQXTY7ZD7JEAU4K5ZHOOGUM3TPROO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi,

To answer your question: no, if I disable runtime PM (or prevent the
audio server from suspending the sink), the pop noise does not appear
at all.

The pop is completely eliminated as long as the device remains awake.
It strictly occurs at the exact moment the audio stream closes and the
device drops into a suspended state.

Best regards,
Jeremy

On Tue, 10 Mar 2026 at 15:32, Takashi Iwai <tiwai@suse.de> wrote:
>
> On Tue, 10 Mar 2026 09:24:38 +0100,
> J=C3=A9r=C3=A9my Bethmont wrote:
> >
> > Hi Takashi,
> >
> > Thank you for looking into this so quickly.
> >
> > As requested, I have attached the output of `alsa-info.sh --no-upload`
> > from my machine.
> >
> > Please let me know if you have a proposed patch you would like me to
> > test. I am happy to build it and verify if it resolves the popping on
> > my hardware.
>
> I guess dropping the alc_process_coef_fw(codec, en_coefs) call at
> closing would fix your problem while keeping the one at open.
> But I'm not sure about any side-effect by that.
> Kailang, could you check this?
>
> BTW, when you disable runtime PM, does the pop noise still appears?
>
>
> thanks,
>
> Takashi
>
> >
> > Best regards,
> > Jeremy
> >
> > On Tue, 10 Mar 2026 at 13:47, Takashi Iwai <tiwai@suse.de> wrote:
> > >
> > > On Tue, 10 Mar 2026 01:01:11 +0100,
> > > J=C3=A9r=C3=A9my Bethmont wrote:
> > > >
> > > > Hi Takashi, Kailang,
> > > >
> > > > I am reporting an audio regression introduced in kernel 6.18.13 on =
the
> > > > Lenovo ThinkPad X1 Carbon Gen 12 (Meteor Lake, Realtek ALC287 codec=
,
> > > > SSID: 0x17aa231e).
> > > >
> > > > Since this update, the laptop emits a short, noticeable hardware
> > > > pop/blip from the speakers exactly when an audio stream closes and =
the
> > > > PCM state suspends. It happens consistently a few seconds after
> > > > playback finishes (e.g., after a system notification or terminal
> > > > bell).
> > > >
> > > > I have tracked the regression down to the following commit:
> > > > d2e01e0c5e947da0b5005ca89efa82baeb232adc ("ALSA: hda/realtek - fixe=
d
> > > > speaker no sound")
> > > >
> > > > #regzbot introduced: d2e01e0c5e947da0b5005ca89efa82baeb232adc
> > > >
> > > > Root cause analysis:
> > > > The commit modifies the `alc287_alc1318_playback_pcm_hook` function=
,
> > > > adding raw COEF writes to disable/enable AMP silence detection on
> > > > HDA_GEN_PCM_ACT_OPEN and HDA_GEN_PCM_ACT_CLOSE.
> > > >
> > > > Because `alc287_alc1318_playback_pcm_hook` is a shared hook used by
> > > > multiple Lenovo ALC287/ALC1318 devices, these unconditional
> > > > `WRITE_COEF` instructions are being sent to hardware that does not
> > > > need the silence detection fix. On the X1 Carbon Gen 12, executing
> > > > `alc_process_coef_fw(codec, en_coefs)` upon stream close triggers a=
n
> > > > immediate electrical pop. Monitoring with `pw-mon` confirms the
> > > > hardware pop coincides perfectly with the monitor_FR / monitor_FL
> > > > ports going idle/suspended.
> > > >
> > > > Proposed solution:
> > > > Could we revert this commit, or alternatively, wrap these specific
> > > > silence-detection COEF writes in a targeted `ALC287_FIXUP` quirk
> > > > matched via SSID/DMI, rather than executing them globally in the
> > > > shared playback hook?
> > >
> > > Could you give alsa-info.sh output?  Run the script with --no-upload
> > > option and attach the output.
> > >
> > > I guess the bug might not be specific to your device but happening in
> > > general with all matching ones.  As a workaround for such a pop noise=
,
> > > we often need to reorder verbs or put some delay between verbs.
> > >
> > >
> > > Takashi
> >
> >
> >
> > --
> > J=C3=A9r=C3=A9my Bethmont
> >



--=20
J=C3=A9r=C3=A9my Bethmont
