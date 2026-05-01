Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 935BCCD342C
	for <alsa-devel@archiver.kernel.org>; Mon,  4 May 2026 11:34:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5DDD6021F;
	Mon,  4 May 2026 13:34:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5DDD6021F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1777894491;
	bh=CQdEQVLWNPbI1YGadXMKF8Othae2k/su9oGjbCb2wTI=;
	h=Date:From:To:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=aMySm6b4x4XjAouPhTdd1g+gPTg/6WehWVtJi86my6HL/cjchBlRkuoSSICuvRYET
	 Jn7LWkzOGAp1lvoyM1oQT5dGwj4bj1UZnXJeYpb2qPKJVYbFloJrJCDaheqXwm7UBm
	 6bP5xWJeuif4KLne4vrqtA59d9FwfghYdTnWZ6sU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E325AF8068D; Mon,  4 May 2026 13:33:32 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A6706F80684;
	Mon,  4 May 2026 13:33:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30090F8055A; Fri,  1 May 2026 14:22:57 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 91E10F80154
	for <alsa-devel@alsa-project.org>; Fri,  1 May 2026 14:22:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 91E10F80154
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=it4mwqfr
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c76c60c7502so1172031a12.0
        for <alsa-devel@alsa-project.org>;
 Fri, 01 May 2026 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777638173; x=1778242973;
 darn=alsa-project.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wZlkX3CD3cRlk11C71fQgMS5e683M63mWsTYXJ62kd8=;
        b=it4mwqfrcoy8CScj/l3GGm4x3jQwQIN9Cnt+qh9elVehB+3pz4OLRVtI59UtISpReY
         wv0VhrrzyAV+RJxYyFkNnz6IL6jDlzAYs6WLdMukurltMH4vTe4UPD+8I9osTS10E9pz
         PvMe3gGsCpj4CT+PnnDFSJgTktO6Mc6uuw2wSkfFrVkXPeFF/ACHz9fWwmAZ3Q+Zt0Hl
         z09chidd0zfHwmdT+L7h6JI3neYNApxLq9sKhv+Zx8bBtGJi8fKoPnh2FjYVw13KxdAd
         Maa9pDm+x9wQCebzq+LmfhutPUmc1GxagdBKQuZQx5kjg0Z/TfMlDa0p0+5VyYh1jrn0
         W3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777638173; x=1778242973;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZlkX3CD3cRlk11C71fQgMS5e683M63mWsTYXJ62kd8=;
        b=d9t1aiM0l/VAmWbvJx5THRlWLxqfgyAytSgJ1zLvrhWgyUaDq/AuaVtXfY74mVpGfV
         76bZP4+yL5j8xJkaZEU1gQdQa4C9D978EQrUhtNMcMsfN+efDYFfMQCnfHVKqppq05t1
         VRUM1Ii4MsiVwma8c8gC6FQPefKCoaQiaEr5tN2DdWCZM7y2n698c33hKDanU9xfR6Ci
         cJxpmbJHns5llhmlbjQYL/PffM/4sjxxynjj9lGVZczv3ecGD4n82aZmL2bG59UU6ReO
         2z5b4rA9AB20BoPM9ioDEXs0IJ2NobnziSBsK9gDae1Uz1gd9F0KmrJgso5clF/c/Z0N
         NAXw==
X-Gm-Message-State: AOJu0YyK3+vOodvRnXjID2Jwchd/ieC5clay5c01v1GPCeoA/P6SJB9F
	YHtQj/9XeKUzA/zWc6XDDUoqDvlsU+wl2RrjnUtdvTMY0n9MtL5X6Bheu+0kAJVU
X-Gm-Gg: AeBDietCWB/MkowiZtMucLnZLeFtjMmaURvEP0hF8g07UtVvOjpbyZHxBYBSn9kVlaV
	4fNX7nOxQFH+j+UyzmOK+Z9Xrm3qxFISc94Y56zZFst4P/5TC+uB0gHZ6rFFDWWa783f7Jw+I6X
	XHsdN5KCAGGzk7Tv56BFRQytgM5s7LHIZg6JuKQB0FWDnTF1ccr4ghUXFXCrEDDJQkPGQaKhyfX
	Toj+Pt7HBeRSAmxTrIc5bxmrFjP8YQZgkCHFME0fIaystTUVIfccGKbJNrTfhFD4lWCzflcdv23
	JQWUz3gUXwIgfGt3BB5WxyNo/tk+X3BpACFl5g7k/SOqDNf8BWMifSBChDQW/VLBnpjnADaDMiL
	ZCxta5xMhueWapT2MOcd/ZYIzLAVSSqsOA2fUGEdoo5hGqO67+XTC6OeAj+9qaREgkmsIZmQmJK
	StkfljcKXKwh2/VK/7xLhf2VzxWVUrOGtEywR2UjcanZ5Z1J4U0qBPVeB/Nsb/ro2Oboz/
X-Received: by 2002:a05:6a20:7d9f:b0:398:8ea8:5f9f with SMTP id
 adf61e73a8af0-3a3d1cf3044mr6477970637.16.1777638172443;
        Fri, 01 May 2026 05:22:52 -0700 (PDT)
Received: from archlinux (d-203-140-186-253.ftth.katch.ne.jp.
 [203.140.186.253])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbc6f511sm2100046a12.16.2026.05.01.05.22.51
        for <alsa-devel@alsa-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 05:22:51 -0700 (PDT)
Date: Fri, 1 May 2026 21:22:49 +0900
From: kay-ws <a3.works@gmail.com>
To: alsa-devel@alsa-project.org
Subject: [BUG] ALC295 internal speaker silent on Panasonic Let's Note CF-SV8
 (PCI subsys 10f7:8338)
Message-ID: <afSbGRSm0KSNnoBA@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-MailFrom: a3.works@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: AAMK3OX5VJGTYHAF24TETGXZ32USDFID
X-Message-ID-Hash: AAMK3OX5VJGTYHAF24TETGXZ32USDFID
X-Mailman-Approved-At: Mon, 04 May 2026 11:33:29 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AAMK3OX5VJGTYHAF24TETGXZ32USDFID/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Internal speaker is silent on a Panasonic Let's Note CF-SV8-2
(Realtek ALC295, PCI subsystem 10f7:8338), while the headphone jack
works correctly.

Hardware confirmed healthy:
  - Internal speaker plays sound under Windows 10
  - Panasonic BIOS HW self-test reports speaker OK

Linux side:
  - Kernel 7.0.2-2-cachyos (CachyOS / Arch)
  - ALSA 1.2.15.2, PipeWire 1.6.4

The driver picks no quirk fixup for this subsys:

  ALC295: picked fixup  for PCI SSID 10f7:8338   <- empty fixup name

PCM data reaches Pin 0x14 (Audio Output 0x02 has stream=1 during
playback, same as 0x03 which feeds the working headphone), Pin-ctls
is OUT, amp is unmuted, but no audio is produced through the
internal speaker.

Tried with no effect:
  - options snd_hda_intel model=thinkpad (fixup chain runs)
  - hda-verb 0x14 SET_EAPD_BTLENABLE 0x02
  - hda-verb 0x01 SET_GPIO_MASK/DIRECTION/DATA 0x03
  - WirePlumber profile output:analog-stereo (non-duplex)

Full alsa-info.sh dump:
  http://alsa-project.org/db/?f=546e2c9fc0e2261cb6d8a7c837f8c3f54f771064

Could a fixup entry for PCI SSID 10f7:8338 be added to the alc269
quirk table? I'm happy to test patches and try Realtek coef
sequences if suggested.

Thanks,
kay-ws
