Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD7CCD5BC9
	for <alsa-devel@archiver.kernel.org>; Wed, 27 May 2026 10:45:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6CD406026E;
	Wed, 27 May 2026 12:45:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6CD406026E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779878745;
	bh=0F64ylXuSOYz05/2ilWxGG8VHepVEOjFoyC0LXD/HyI=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=M8jcCG4DdhpdEgZHUAqoFUv/dDIU76Wa7tt+p3j2MxglyaPBKUBmo8nNbT8DcQH6R
	 Ea/6spF2wsw71YoUTHXzIvATOSXh8ra+FwvxV8Tuw5EQu07VauND+SRt9odm3gy736
	 ow674mhqNnHi6rrEcgeVxmkGboLzOCBNKzG4RjcQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C57A2F80617; Wed, 27 May 2026 12:45:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8DBAFF80612;
	Wed, 27 May 2026 12:45:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DDA6FF804FF; Wed, 27 May 2026 04:08:56 +0200 (CEST)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A6719F800BD
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2026 04:08:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A6719F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IbxVJV3e
Received: by mail-ed1-f68.google.com with SMTP id
 4fb4d7f45d1cf-67e43a8996fso14069073a12.0
        for <alsa-devel@alsa-project.org>;
 Tue, 26 May 2026 19:08:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779847731; cv=none;
        d=google.com; s=arc-20240605;
        b=Wn9JqehrctRe/p9NrjJ7VAcrmp5PIAwSbDLUtgxhSp9LyznQqc0mC23XVTSEtoW1gt
         +Zm/SpT6LoSzopvwNhkLqBDlO2in0MCXiZEeBmMzzk0RzvC7m9e81IPRJV4X/i+FeHNy
         b/F54c2h6BASxaO0ep11IMn5EKYSc7I6Rwpd4mW0293uetUSPTr441wV2k1bA+fFUlCg
         Qomx/2werrLcyApTDzzaxGNFwLP12EBIy4/SZFsNjIDJIQ81Y7nKgpJzHIcg9VAT5Lyg
         KD46hfnScvmioX0rhyhol9ufWRGwpcVzA3ht6PNhJ2A8lMk3EN+sSl2Z7I7TCUnpZruh
         kYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=0F64ylXuSOYz05/2ilWxGG8VHepVEOjFoyC0LXD/HyI=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=jG7odYrWN3gbJCIzkMJfHFTeesa63ZuBvtaznZO2gwYIPCuumKiia1kVFPmqQ3jLcA
         X7Sah5rzZZRtdJwi6gWCAbmhGdUrizrApov2KQIast8kxTN3+iJK/8E8a2WWJTK8n/9v
         tp9DMEXxPNuSytYD/ozr9fXcw6QMfIaNlrFzi0rLp5oCn5GUw82S2OjlUYQo2CrFha0C
         3gCd16kpgm1C0ft3Cy7JyFWQCsXv4lmfT5BQqarAR92fEmERpOi8PLjsVIhPfL6mAKua
         BYBltHkMcZwxMrEmaF2VVCVbSTEnxolhetGgdADesOdeKAWUGyEK9oup9Zr+579ethWm
         rltQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779847731; x=1780452531;
 darn=alsa-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0F64ylXuSOYz05/2ilWxGG8VHepVEOjFoyC0LXD/HyI=;
        b=IbxVJV3e+2rocrs913V2TLQU//vJZ3etEmKQYJ2VWWkr6pYIESO2eiGEDwrZeW3MFQ
         9yTb8ZugOTa/vj22QXg9wHLKke+2UEMEVagXBamXAQQzb9TWiLwqsovYQ0yO1MfiUt/W
         /d1faFa67GTEaRdl+Y6OO1LZAMa40jZ1tDZ+kOAFX72Mw5AblmyXiXJww73ZqxZhyyXP
         JjcTkjSUISK1REMNBbWm9HqFBPT6MzfGNwUTtf810DRfsTKr64uEFgP1NOigcIM66vwn
         gvrXm6yaSQUy4DlL5jiLEDLD1xbdLzPO5XZfJD0g2Hyx15nevmDfXBdalZmkZA7MBQqB
         oaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779847731; x=1780452531;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0F64ylXuSOYz05/2ilWxGG8VHepVEOjFoyC0LXD/HyI=;
        b=DmyUpT2D2DRw3V/5You2LjlWLL/h56TMtzUWS8iZ08lzts1XVMHDKMQT4SJG/kNgWK
         3a5Ckm7fyvC78RxOdFwlxPynwxZdu6hac6xCXdAqGR9gOT3xW3J/xQ6v9Tftq2jwES+h
         MVy/u6BF4HM1mLdTrJhsZbYUSof/e+vthziSecqJhZdhCqVKLa+2QGuRBDHeSNXnxTr7
         t6+rCn0KRBGl+pAzR/W2OcR9Xmzwz+0yhPVAb6h8bpNAzJLhQWsEYyj+pCe0UY6ECo75
         enhS+8mm84myuTT5kYJ1z55wLTg33g7eX4dq9pLjUZKX8ZKb+DMsY2fWQOahb55Rr/HR
         K+HQ==
X-Gm-Message-State: AOJu0YxhGWkQlDW69V8qtbzB88piwozK9lREphnWgS2N3dZ628IKfWGq
	8updh9d+Kwhxgt9POslTWCBC5wYoyUvmj5/hegT1KZTp37mEkkVE0K5A9ZRuW7gq6JG1FmWlS9A
	K4B5ylShRMQC5fggXG6+hKOe2Ar1Lr+7j1FAH1LfyVEOHoQg=
X-Gm-Gg: Acq92OHJkVbPoC42NTat7mH2GJbKe6SCtsgNC/13kkTHUmAjyqhqYBsHgJA7BjuLwsH
	gOM8aLGS1Nl9639pjh/a8HNG45nWB5Rbq6eJBB466DZxhvy7yqbTA/w4tzRo10EWJrraikUnFMT
	SfEvV0V8WyVpCkiZg5phDXXET/GBJzcrEBP0G2Ni10S1QUoJqUsKCE0x1tUFXRYqTN26bfjX1HW
	v9q30fXSAzdkKVqV11rSk24mYarT1YQcFb6DO9W66j7uCMjcfGd6YyQ29tihYTfmjtlPrxrBKLc
	4Ya0Yv0RsYUc9pB+2+4R
X-Received: by 2002:a17:906:c112:b0:bdb:7c37:183f with SMTP id
 a640c23a62f3a-bdd22944808mr1361371666b.4.1779847730686; Tue, 26 May 2026
 19:08:50 -0700 (PDT)
MIME-Version: 1.0
From: whisp <ag.whisp@gmail.com>
Date: Tue, 26 May 2026 20:08:41 -0600
X-Gm-Features: AVHnY4JSL6UoCXRahxdPSyTQ_Hb8zNatYrPNEa9kYo-ZDA2VyGxRq-isg-v1Gcw
Message-ID: 
 <CAFeKA7ap6S7EuM7g_PvhbJmT0MV6+3ZJSMLS-Hn5Mdun89uX0A@mail.gmail.com>
Subject: [BUG] ALC256 headset audio distorted when TRRS headset is present at
 boot
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: ag.whisp@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: MSEG7DHID6SLSXPJEPQSLQXLFYK6AE5J
X-Message-ID-Hash: MSEG7DHID6SLSXPJEPQSLQXLFYK6AE5J
X-Mailman-Approved-At: Wed, 27 May 2026 10:44:59 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MSEG7DHID6SLSXPJEPQSLQXLFYK6AE5J/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Laptop: Acer Aspire A315-44P (board Callisto_LC, BIOS V1.08)
Codec: Realtek ALC256, subsystem 1025:1640
Kernel: 7.0.8-arch1-1
Distro: Arch Linux
Headset: Sennheiser HD 400S with TRRS cable

Problem:
If the headset is connected before boot, playback is distorted/low
quality until I unplug and replug it once. After replugging, audio
becomes normal.

This reproduces across multiple distros, so it does not look like a
userspace configuration issue.

Observed state:

In the bad state, the headphone output pin is detected, but the
headset mic pin stays absent.

After unplug/replug, both headset mic and headphone pins are detected correctly.

A copy of the alsa-info.sh output is available @ https://pastebin.com/aP4MdTY9
