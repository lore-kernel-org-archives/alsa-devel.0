Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EB3106703C
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2026 15:24:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E7BE6020D;
	Thu, 12 Mar 2026 16:24:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E7BE6020D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1773329052;
	bh=aj2/mhOw+/vLYR7j0XunhSKOHIYNbegxzFpbvCsoVCY=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=EcniHrwt7GDy2kNvNnW80Hi8mBZiw9Vsv8Y44xWQNe8iRwd72noakMFKYKLd19Hwr
	 J4l774vcCnH4zp61iTGpc+R4rY0cg7Z1zWmfsE0oijIn+XoH9gJrPq3o5hVbZrsXdi
	 PyS5mQ2sAKK9iIWxtFCWjwB5ZpPm1mc05PV7iXZ8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A070DF805E4; Thu, 12 Mar 2026 16:23:36 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5CBB9F805EE;
	Thu, 12 Mar 2026 16:23:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F430F8053B; Tue, 10 Mar 2026 01:01:26 +0100 (CET)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 627A9F8047D
	for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2026 01:01:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 627A9F8047D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20230601 header.b=BfmfvV4I
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-829ac8d56c5so2966351b3a.3
        for <alsa-devel@alsa-project.org>;
 Mon, 09 Mar 2026 17:01:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773100882; cv=none;
        d=google.com; s=arc-20240605;
        b=Y6w7hkz22iLIZ4yycjGUfLKYnbHmTbUs69fXfpHRan42lqOOKiP/jh84DZ3MC6IX0Z
         pNaO9ok5niCc8aexb6RsRLbytyXZdWOwNc/LJ338zvcR50knls9NMb2Gwoj6U/jVVfoX
         0vLP2c2fTB72QXh1gocvBKeiw4DgfXk/OSRYMDsvC2j96LtSXl9fpY47Z9tdgPr5BUoh
         jj5lpNT0/7PkubO46w2gU/aDzyHLQRUaQT8RxIeDreUWlRCO8sbmxdd3gLVxaEGpdFOG
         9jZt3QFC0SZrzJho8Mj19Dkt1Q/bX6NmKpapYJQj7BsDrbHKrZpFsgveprqXcBU1i2yH
         us1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aj2/mhOw+/vLYR7j0XunhSKOHIYNbegxzFpbvCsoVCY=;
        fh=Pv7sdOQpDOxj6fjc+m6K9w7Ei1F71anJvhuCa9w8EGU=;
        b=J0e4Jxfv39Nl8aRR7824DHLgF9SjAYKoRtQqmiexcWeswAGbcpcwssZUyq9yq+zcPh
         XylM15HBiAdXXabmueHy+EvZLsiUMnl0rgZdjw3Py5OgG8Lrc8dnEz1fX89NrCy7ggbY
         Umg5K4nktrjvY1hfUjV11EOaLYga0vBbNypdpqQhA/y9n7ziSJI0BOCdkqnOFCmtrC2I
         Wc9qqIMFtnxr3XcV/+OBCZqOEaH0MTrzLf1lZeViUOpyefPoz5XT1vVt8f9gCm7reE4v
         k4Cvfvlru4uxuFxlm0G8dv4EaFOiWokXLzH2yVzNCREY2WhoKpAbm2oyxuAWQ01W+SmY
         uEHg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773100882; x=1773705682;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aj2/mhOw+/vLYR7j0XunhSKOHIYNbegxzFpbvCsoVCY=;
        b=BfmfvV4IdW/d5x4GfiVm6EcSM6UvV4HekveoO55qhnAVLBuTlY+izVutF+DEJNdov4
         UvCdcClomq12FffhoT5rUzzhO8dsYqoOp+Mjg5LTmX4zKzbgpTr/O5zmaTYnTuYHfN/q
         UAsQHsDVB7uIZmR3g9B7V8xb8bcYgEOeHI120efWG+dUS5nb0ywMqfEk3yhizsbkkwG9
         GNLdiwl+ZMSdS9XNJc0yXQhQjH0w9TrH+UkAve6+WsmGZHEuCCmKOfLIvCkr0lKlgnPv
         FPlRjPNpjtH6tH8Q1xrx2IlQJaDBA6llcwAsQzJM/5YKtYZqi9GIbM7reelUYRAdHbgn
         8KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100882; x=1773705682;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aj2/mhOw+/vLYR7j0XunhSKOHIYNbegxzFpbvCsoVCY=;
        b=aGKRJdkvkmas59I5Sy4A0bDbz0cm+1G/fUbJ6nSyZAkjROPzzq0b+kGJ15Xo7CL/Ys
         qWSTfZFqOcBPwPyRfD5X7Gvi6dq3hFhlC/IpNN69QAp6wA3jwLCIN/YX2WHR4vGHURZc
         rWRf0QN7ES6CAy4NxRkObxh1vxY0lzwZId1Swu+LoTSZRQUYuicXcFYvwW6QVE3SYhPq
         gfoM8LMncWip08n7bwbsRV86onWftkkbZVTSXd/4P+9Kw1+9tuJ+h0wKIHR/uUpq2z6+
         NqmB3jowjbao2T8nhR0UAhZlhnW5LFiqA7W852rXOH2qf4+RQeRLA+eaMtE2EiqKhfex
         /DVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJTSoTXGbQ6aGo/T+9KbB0Ll8TwG02kNVr1AwQDAIO2padK/F0hc1nYwI6h4Bkr09XCAFISz0gjIW8@alsa-project.org
X-Gm-Message-State: AOJu0YxBv8GfKQV/Ok73VjZ4SlHYNmdb3om75Lxf75p5t6LKunDxRqqO
	zbz6yQGU3EFnLplVD3WcSiaAfdUuwy0SdETnd8em7BgfrvYuCpzkAEsESgFygSn44EH3BmO6Gt1
	WNey0IkiLZWzDg/4tWdJ/I9YRZVqeNtM=
X-Gm-Gg: ATEYQzzD8zrna+xkC5ywT9Nm7wfWIHdFocFrlVy0RXU22Bb80xq7xfjDEfuIg/wb4Fv
	gastVQp7kDAgRj1Fi6tdYexxbQ9mlbI/1F0SaEWUuEFDXMotMrktVd5wKVSgxUQS76GzPdBXtux
	7l7gD3I90IWJ4F950UMayLKRJWgClCW7eFHkfNcwchc1MklT07anw65EutyoC+rWjRGkO0O6p2N
	A41SAkzOMwBPo7YlqNLH0+ddraX0SJMREpHEKaNfRD0sLbjiGfMObkVKOh45vjFRy/15vEvvgHg
	pdFkThnNQpo+n2K9BmHaciJpcnhxT9mc3EULGl4E9lCUOKiHfeM=
X-Received: by 2002:a05:6a00:3d98:b0:827:3307:170 with SMTP id
 d2e1a72fcca58-829a2eaad00mr8786787b3a.37.1773100882040; Mon, 09 Mar 2026
 17:01:22 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?SsOpcsOpbXkgQmV0aG1vbnQ=?= <jeremy.bethmont@gmail.com>
Date: Tue, 10 Mar 2026 07:01:11 +0700
X-Gm-Features: AaiRm50pY7ECADzxEHrEGJC6CAC-sKCD4SV6tlcLSz4hX9fclZ7RXRRVe-t1yOo
Message-ID: 
 <CAC88DfsHrhyhy0Pn1O-z9egBvMYu=6NYgcvcC6KCgwh_-Ldkxg@mail.gmail.com>
Subject: [REGRESSION] Audio popping on ThinkPad X1 Carbon Gen 12 (ALC287)
 after commit d2e01e0c5e94
To: Takashi Iwai <tiwai@suse.de>
Cc: Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
	regressions@lists.linux.dev, regressions@leemhuis.info
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: jeremy.bethmont@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: L2ICUOEUQXLHKRF7DAZK4O52QZYMCHTH
X-Message-ID-Hash: L2ICUOEUQXLHKRF7DAZK4O52QZYMCHTH
X-Mailman-Approved-At: Thu, 12 Mar 2026 15:23:28 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/L2ICUOEUQXLHKRF7DAZK4O52QZYMCHTH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Takashi, Kailang,

I am reporting an audio regression introduced in kernel 6.18.13 on the
Lenovo ThinkPad X1 Carbon Gen 12 (Meteor Lake, Realtek ALC287 codec,
SSID: 0x17aa231e).

Since this update, the laptop emits a short, noticeable hardware
pop/blip from the speakers exactly when an audio stream closes and the
PCM state suspends. It happens consistently a few seconds after
playback finishes (e.g., after a system notification or terminal
bell).

I have tracked the regression down to the following commit:
d2e01e0c5e947da0b5005ca89efa82baeb232adc ("ALSA: hda/realtek - fixed
speaker no sound")

#regzbot introduced: d2e01e0c5e947da0b5005ca89efa82baeb232adc

Root cause analysis:
The commit modifies the `alc287_alc1318_playback_pcm_hook` function,
adding raw COEF writes to disable/enable AMP silence detection on
HDA_GEN_PCM_ACT_OPEN and HDA_GEN_PCM_ACT_CLOSE.

Because `alc287_alc1318_playback_pcm_hook` is a shared hook used by
multiple Lenovo ALC287/ALC1318 devices, these unconditional
`WRITE_COEF` instructions are being sent to hardware that does not
need the silence detection fix. On the X1 Carbon Gen 12, executing
`alc_process_coef_fw(codec, en_coefs)` upon stream close triggers an
immediate electrical pop. Monitoring with `pw-mon` confirms the
hardware pop coincides perfectly with the monitor_FR / monitor_FL
ports going idle/suspended.

Proposed solution:
Could we revert this commit, or alternatively, wrap these specific
silence-detection COEF writes in a targeted `ALC287_FIXUP` quirk
matched via SSID/DMI, rather than executing them globally in the
shared playback hook?

Thank you for your time and work on this.

Best regards,
Jeremy
