Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2352BF8A14B
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:21:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 78B3560206;
	Thu, 16 Apr 2026 11:21:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 78B3560206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776331271;
	bh=6AYlwuiSl7sAbEfuNHnNOQJCIWxT7DJEDSiRqwD5ROk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=cpG1cb12Bz4D44WCnxGiiaXCWyUv/uNXWM63RYCpcxY6SBftXjcmGlnggDnjjy4RA
	 YgPcfYuMfDuNkXO8z5P+9cOwJiweMFyn0kClcvOzXPc77Aaolk2eH50dSFX2eKmkho
	 mWB2aBhJYLQXI+wfcKgIcV9j2HgvryrZd6M2eaNo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA60AF805F2; Thu, 16 Apr 2026 11:20:35 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A5571F805EF;
	Thu, 16 Apr 2026 11:20:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 419F8F80510; Tue, 14 Apr 2026 08:37:29 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B1442F8003C
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2026 08:37:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B1442F8003C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CmOmZ6A9
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2b2494440f3so17639555ad.2
        for <alsa-devel@alsa-project.org>;
 Mon, 13 Apr 2026 23:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776148644; cv=none;
        d=google.com; s=arc-20240605;
        b=KazCmsIuiC+nAg9Zx07LQ3NDWj3YN74N3QJ3pqd3eJRg8i1neUAvjchPquDLw8Jmct
         UfTlwX0R+BhUja2fqr+5b1NVMFp3yrmWLCuo9iKQLC73EQThHjod6074Hqg9QETq0XeH
         yTGVzWV+tclAFTya66mtmSUE9x7IT0/H9/NZzKz/cw+6YWVBr5Mm561/ygtJ1cEUh4gB
         YpmCS//Kt1sT1w0wJAMQBNkDLLEfXM2gaNMwC3Q9n0TgHL+SkYV7vH1n+ToDLu34ZtC3
         10A7NwbTkl5wCqyZMgeeNbON2BfR38nJBuZJJwiqVUpkOLypz346YggxckJZGwnNt3+2
         Dgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=insLynn11+1MMlEVZgdZja3tQdpQK7VuHFjY0dKWpWQ=;
        fh=KQ5ftnHp0HXiV69rhI83vfaxRR1oRru4vys7WGan/UY=;
        b=NVIWEcFfnQKcPGQylBmRH0z+jOcy4QWXDcvvdQyS0w6K9aONu5wFRf61bxdC2XE5Oc
         GumkEy5UTJxds7kfVILmSAWeHFtGc464IrXDSDJSciMrT8PyFCmcApOJF3NSa/6jvgUT
         7U+CYpruTRVUHeXbOqqC2JKxah7XABOXG/jtiAXGnXePhJyLR9Kl1nOTC7hk2cTU/Nb6
         gyU+lA2MtA7Tki87i22ByOx8tT9UdVOgKE6E4z8nTSZhKIo34fLlTtr2nw5OeW7tSrSD
         xVEzMm/5TkqnOIOA1vV6iIS5/zwxAGT/9glWUGTuGWTAxVxMzKBywrqTbY+yeBEMzC3V
         wsIg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776148644; x=1776753444;
 darn=alsa-project.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=insLynn11+1MMlEVZgdZja3tQdpQK7VuHFjY0dKWpWQ=;
        b=CmOmZ6A9+0swLCi8nJxYTQc2iktOPK3/U1u4hQsDXTknd4VAMZki/hnMSepBjuib6G
         wK8IKi90XgVXoauxHRelXUikhQdKJn8VwskAr6MPLOCiLayCf7+QNziOq/QyypXx8E5g
         9h0z9JMwHmv62GYpptiVYzoPPhWlK6hkPLkrzbLhBRozbEOV1IQbQQQgetDJesW9yEWw
         11+T0OA4gY+xy/CzFD5Q42yCN+fQrc/I4ELF/8El+3n0PqJS+TYCmXlD2GwRrqP9DTE9
         FZyJdTogpYW4OM39EbzAQnM3sZg+YjLkjBtUikN2bh7GfEHoTFMh/ifj4oS//lto2eet
         LaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776148644; x=1776753444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=insLynn11+1MMlEVZgdZja3tQdpQK7VuHFjY0dKWpWQ=;
        b=SEPROHZ8wbqXsFmMuMrdyXN1QX4YjPYl47uxxxJ2lVT0cN2eGFwKX2N4NO61g9oC06
         Mlr8zCSJKz2QKSTMqk/kiPpaGXjjkFdBDVHapNmHJc8pK5XKo0MgT4hL4EAeGfnL/Uzi
         ap737V51oS8KoAQsLAigGYTtYbPNptzZSbxpneK6MCbRskoigvyUAKA+4JzxwhrSZq7/
         xTScqYbdn/z/s2oXVSBEeypVvO7JHK44wuvot7MoxTZ8YaLNsDLRLFhjyhPnf8Xao4Xp
         SItrGLIMXNWcnV3zO2EVuKjrJDBcDkyF4JtTQDM1IWSSIQP2ImWxfyZGsremAtO0C0xQ
         yTww==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Oc+EJOlp8k1733IpfJh1quWU4YkmWSagU3yzssnC7M/MQkZyAs6756SvzefEhw3AE9CJPnFbQVPys@alsa-project.org
X-Gm-Message-State: AOJu0YwEF+cSK+nsTdHnzdnf7zEiaBNTIGLddkspevmmazpEp+CqyHOb
	/f4Phdfh/cE5ng46d+9u+v287vfwb3uo6EPukIY/VK6tcoyDGVXxxi/2Vz7+xcPX6VJ2mnL035m
	VLAK8nLW52quldkikjiyPzNLQcevbegM=
X-Gm-Gg: AeBDiesMpDGhJ0IwfTm7TaeQiryeGDPzl8C441fYrHwsvSKbklcnixvhfK+9S3Xn6Zi
	O5SWI2cGpPToNWtAjPGTMM1yIgbntv1qbj1vXWkPwiaPWhTlrcba6idjOUUruzHRahGQuMsMkCK
	L1OAp1iqRfmBp3GDJj7cGoE6PF5w4JOKM4ZQ9b0YXlQ4V3Q1DgzwrB7j+M2t7AFrtt41lOaQIUB
	krlebNV4otspegLbOAb5vA4qN1WeIgPuY8ES/T3VKi3CgJBt2OKr5h+f22cXF4urf3SbLrBvLih
	hsoXTnV/6r0emU/bIVtngoje7WeX2m5rwd9JNg==
X-Received: by 2002:a17:902:da82:b0:2b4:6470:75f4 with SMTP id
 d9443c01a7336-2b4647078femr47230175ad.28.1776148643730; Mon, 13 Apr 2026
 23:37:23 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com>
 <87a4wgrxil.wl-tiwai@suse.de>
 <CAC88DfvjQvZvdvGdZ00woMymE2tUWk=2Dbqi3EzuzSHxGjEnzw@mail.gmail.com>
 <871phsrsnf.wl-tiwai@suse.de> <f59a70ca796b4d09822f514e7f25ac5c@realtek.com>
In-Reply-To: <f59a70ca796b4d09822f514e7f25ac5c@realtek.com>
From: =?UTF-8?B?SsOpcsOpbXkgQmV0aG1vbnQ=?= <jeremy.bethmont@gmail.com>
Date: Tue, 14 Apr 2026 13:37:11 +0700
X-Gm-Features: AQROBzC6xEqhYrpdRvJxGXEJ7XxoE0pMXS_rqFAWmaM1oAaQaL4Fxq0dujM5SyI
Message-ID: 
 <CAC88DftEBEEEvODGUZzkry+kgAm=SfH=PAsxwu+SABMBMRMs=Q@mail.gmail.com>
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
Message-ID-Hash: L6S57K3QJEQPBD4IO3ZMUCDLIPAL5NBL
X-Message-ID-Hash: L6S57K3QJEQPBD4IO3ZMUCDLIPAL5NBL
X-Mailman-Approved-At: Thu, 16 Apr 2026 09:20:26 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L6S57K3QJEQPBD4IO3ZMUCDLIPAL5NBL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Kailang,

Thank you for the patch. However, I believe you may have attached the
wrong file by mistake.

The attached patch ("0000-x1-gen12-speaker.patch") is dated November
12, 2024. Its commit message mentions fixing an issue with older BIOS
versions.

Could you please double-check?

Best regards,
Jeremy

On Mon, 13 Apr 2026 at 16:16, Kailang <kailang@realtek.com> wrote:
>
> Hi Jeremy,
>
> You can test attach patch.
>
> BR,
> Kailang
>
> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, March 10, 2026 4:33 PM
> To: J=C3=A9r=C3=A9my Bethmont <jeremy.bethmont@gmail.com>
> Cc: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org; regressio=
ns@lists.linux.dev; regressions@leemhuis.info
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
> I guess dropping the alc_process_coef_fw(codec, en_coefs) call at closing=
 would fix your problem while keeping the one at open.
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
> > > > I am reporting an audio regression introduced in kernel 6.18.13 on
> > > > the Lenovo ThinkPad X1 Carbon Gen 12 (Meteor Lake, Realtek ALC287
> > > > codec,
> > > > SSID: 0x17aa231e).
> > > >
> > > > Since this update, the laptop emits a short, noticeable hardware
> > > > pop/blip from the speakers exactly when an audio stream closes and
> > > > the PCM state suspends. It happens consistently a few seconds
> > > > after playback finishes (e.g., after a system notification or
> > > > terminal bell).
> > > >
> > > > I have tracked the regression down to the following commit:
> > > > d2e01e0c5e947da0b5005ca89efa82baeb232adc ("ALSA: hda/realtek -
> > > > fixed speaker no sound")
> > > >
> > > > #regzbot introduced: d2e01e0c5e947da0b5005ca89efa82baeb232adc
> > > >
> > > > Root cause analysis:
> > > > The commit modifies the `alc287_alc1318_playback_pcm_hook`
> > > > function, adding raw COEF writes to disable/enable AMP silence
> > > > detection on HDA_GEN_PCM_ACT_OPEN and HDA_GEN_PCM_ACT_CLOSE.
> > > >
> > > > Because `alc287_alc1318_playback_pcm_hook` is a shared hook used
> > > > by multiple Lenovo ALC287/ALC1318 devices, these unconditional
> > > > `WRITE_COEF` instructions are being sent to hardware that does not
> > > > need the silence detection fix. On the X1 Carbon Gen 12, executing
> > > > `alc_process_coef_fw(codec, en_coefs)` upon stream close triggers
> > > > an immediate electrical pop. Monitoring with `pw-mon` confirms the
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
> > > I guess the bug might not be specific to your device but happening
> > > in general with all matching ones.  As a workaround for such a pop
> > > noise, we often need to reorder verbs or put some delay between verbs=
.
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
