Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B6EBC55822
	for <alsa-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:30:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ECE360233;
	Wed,  5 Aug 2026 12:30:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ECE360233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785925841;
	bh=wo/DCxD92zC0lV3xq0Ee144B/5Xr+zxz2eVpkz+zwaM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=i9tgzmLcn4GrygFj+hHLTg+qoTye4XrzUrP2oet8TSu+YIaGlHV9C7itlCDh7XTLr
	 +hZ4y5gRmVUxDmc+K+tJR3APT3zmx/priKGz05xej5A26SEquKStwhmMKeEEqNm7yV
	 jCsBRppS3X1OW1bjZNYyWDMT6EyuRVsvM64uuOwU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 72B18F8069A; Wed,  5 Aug 2026 12:29:28 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D8BFFF80693;
	Wed,  5 Aug 2026 12:29:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3063F8027B; Wed,  5 Aug 2026 12:01:21 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1785924077;
	b=PjJj/ZPI+nSyM+FvlEF5JaXZdfmL53h8Htmi5WZn3nAEBn5LqQBq4QwACrwlH4oM5/yy
	 UvXNVoOS7ifJZcS0V2p/CczOL0svLDfuCdjDUsx3tqvzqXvQT3OPohdewbEGs6WEFd7+g
	 wy5M8uNet7+u5MqgRs1nacWMmOA1B1fv8F8VkCekXmqeVvmEXkk6XA/bqYZd9biy++vnM
	 xxUFjOyppA0tnY7xIY4VRdAGS4ueDUhOJDIxCh/AG70tSvo8giThBBWR5ifIV2mhLPpyp
	 SRY3NpxRXiYm3Sj3fMCOsymqQFLAGrGXT2Ub/jvtm5wFSm3CdymwwhKV1U7WYGUQRSQ==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785924077;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=wo/DCxD92zC0lV3xq0Ee144B/5Xr+zxz2eVpkz+zwaM=;
	b=jq/FOFHsUTDmIL5TfZ/dYMUnQw9EYZJBMB2vkvvNESJ/JgePIA8owK+mbd1jjWEosUB4
	 XJ8zkq0jAUzyiaR6eTdNnh4Mqjo+MmV6hqUdn7iZMfETvaRVoXNEQMHV0kMVJ6WJJ/SmS
	 OptyVvM4uXNfIoxayRLJrZ1ubZgg4a91bE4w9a2EzT7KeC8xivHzQ5IRPz23PluHWxObB
	 XD4wxT8S+lhioOyszhC3AzWWyC75TU3NQHgJoo+SvzesFFcpQx2+lXvh9oW/MDr86KOce
	 2FacIovkI0r4dBQCL3qf2f0kU7XZv5ghGPPDJB9DlThus9u6nvRYrmHu2WOHgDWqCjg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="IpcXqr/O";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 5ED51F800C1
	for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2026 12:01:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5ED51F800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IpcXqr/O
Received: by mail-ot1-f51.google.com with SMTP id
 46e09a7af769-7e6b5737bb2so754676a34.1
        for <alsa-devel@alsa-project.org>;
 Wed, 05 Aug 2026 03:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785924073; cv=none;
        d=google.com; s=arc-20260327;
        b=C0Jejs+3/N2zkx10WtCthgHelGxNBHzaBDweuNlU/wQbhLEr8bAcSU9pc4ylBNryhG
         Q1TmAS9l9tsRQjLzoqnk4BVDVsYbj8jgMUc7NdRwGC6/FJ5Vr6nnVz9Zr0BnIS8OupAq
         OvvXV7zapji3yISc1YCuExxa5OF6QMy7rguhL2kYWMNcCBQOmOCQLhTA2008fZ/lcPML
         7RhG6Au5VClkMAYsO3Qea5jIyALqzW2JMLhoOSfjQkp8Wm8jL9+3DcWBaIv0KOpqdy9G
         Gr04vvxM6gixioIEQ/O9/E4+YNbJewnNA81JSoWF329NGVFHijYN80ATiR2hiOY98U5Y
         aySA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=fmceNGyrHkwdQg5NJnPrVl4ppw7BZmzGIe4wZK0Fl74=;
        fh=9DJtwjQDTgkWZakrAC8nFAVWqr2ElCjSMgK5MyTPh/0=;
        b=nytbH5COtYzPIF2be9C9tuqhSf4CzajaUv+6loBEDav2eIvp9Hw6/fv8EtznQZ4149
         vKbL1pcc7JZuJ/XqbhZZB7Jub+8/cVAq0c+6OhxH2IJ9gGgRSZPhq0EPvYiNRLwJ8xXZ
         6LvUlPP9AhjRDPIfkElO7TKwMH6WtkzNEC2YXFcg1t5U+4NZQbJYWkGr/1QI0waMBZiq
         BRpRgSjFsTu1tmyWTsqccojbX4CqMW+ovI0YGtS9aXHJNwmPHmONRjTVeejA3iNH5xYs
         jEHbgzoSZxH9z9EMwhOT1IGzSMFUnMZuqliZRyY51JTQVUVHbs0RyJJZ38wF8Us/3uB/
         DFdg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785924073; x=1786528873;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fmceNGyrHkwdQg5NJnPrVl4ppw7BZmzGIe4wZK0Fl74=;
        b=IpcXqr/OTfAhXIr3vQlWWRWHO7I1HFgDt92mO/9L4fcsYcfqVuIxnuR+7SO+PFlsS0
         zcxrhlbcuul2mJfEF1Uv6ovdKKTy69n1EMq4nZ/JF5+mH45GB39XdfoFFj6FsK9LgDaq
         XSZ7ngrVCmOsz7nMiAGG94vWO4T0x7eVpgQYIRCmjfI5J3SJuJ05StWi/XWqM2TZExsl
         7GsbZXozd1VoYwbt18fgZegHraXF1Nm9C7IviX9IMX1CZMSS+15iiaRePRTDBUiS6tGn
         S5X/8sDPQEOHhXwNvt+4gQU0x5xpO3+vj64qviJ2gChE7f0IF+riASOv6x7S5fHKX0wD
         xUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785924073; x=1786528873;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fmceNGyrHkwdQg5NJnPrVl4ppw7BZmzGIe4wZK0Fl74=;
        b=FE0ikG0fUIYP2qYl0/odNnaKImQ33SQUMxU38sr66Kd1vMDlYieBoGeoGTwn9I4BIk
         po/bLMXzzzlJEAYo5Wn3h/YtECi0zJWSXHUeOFl4UdjbyoMA0vU6XFtieNjeiAJb3v89
         b0bCjJQWSHzHBDSSpBo8eKEpCnVZkJ7ykUdcV+/+ArFiCvHV77aYLucRwkOBFPmsOUSw
         d0VU72OZ2h+rfV8FMXxudGKGM455TaKnX5c9CbdywrsolzWPF7IUgIop0MWAjP6AFw3i
         47hYxjt3nvI6ItG9/awL+p5ffgSeXlXvMqytnCqbxaZGLtVo+gYL+pAY3OQFQsez2B57
         KUrQ==
X-Gm-Message-State: AOJu0Yw2WyCvV4YC89FJYvrQEb0pDFobzWjYJ0wmL3p8vmjpQDwYhFDZ
	ZjBRWJxgi7AYC59NDlXKlWAYuitxbl/PWRYLhNCOosdjteL3rbESfp5XOl6xpIHXN7PCgICp6f2
	dEoYnxLYd5K/jrrEha+xoYf50p5xRBX8=
X-Gm-Gg: AR+sD103fKWW8y3CqTREp1Z6hw6PdXpPzeGqzqq05yuvB6KUScM5OS4Fx6kvEcoM2bg
	xBwI1KOJGldTH3gXRZR4jglpdjsLQC2pcXM8DdI0j38A0Ww0FVPE+qXf+veYj7RzJ7n0FeJLCmn
	IUpBffSYZ4sAiAr/FSZoasa4uR+DBWoWXdG2mAK/jV3IRMhKbOGoxxY9cC0LWJU6EkbaolmHJjP
	MXQBedrMUzkjFKaeiMHBRHwK88g706+no4+mcBmmDR84+/1bVBZGNOq+2mTX9DNcBvyhI/GDFEk
	GR7dsGh1db5pi/KcBx1lmRsHAMS/UAFbQkwzlejH+CE=
X-Received: by 2002:a05:6820:821:b0:6aa:f0fd:3f0a with SMTP id
 006d021491bc7-6ae96fb02f0mr2482917eaf.30.1785924073023; Wed, 05 Aug 2026
 03:01:13 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5byg5bu6?= <soldierjazz2013@gmail.com>
Date: Wed, 5 Aug 2026 18:01:04 +0800
X-Gm-Features: AUfX_mxlR5OlRCkaTKl-7Gf90udyr8-i7aV8yn_m-izCb3cvQ_WeTARC4l7w4IQ
Message-ID: 
 <CAEoG+NTVcGqWVKurr_f6CrXx1zmsR9KSoxYY229riwL_qZCjFg@mail.gmail.com>
Subject: [BUG REPORT] sound/usb: Fix Use-After-Free in snd-usb-audio
 error_timer during device disconnect
To: "clemens@ladisch.de" <clemens@ladisch.de>, perex@perex.cz,
 "tiwai@suse.com" <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: soldierjazz2013@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: EIDL33GSYHXWCV3TLOVLHMPK52HQ3K7Z
X-Message-ID-Hash: EIDL33GSYHXWCV3TLOVLHMPK52HQ3K7Z
X-Mailman-Approved-At: Wed, 05 Aug 2026 10:29:22 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/EIDL33GSYHXWCV3TLOVLHMPK52HQ3K7Z/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi Linux ALSA/MIDI maintainers,

We identified a reproducible Use-After-Free (UAF) kernel panic in
`sound/usb/midi.c` during USB MIDI device hot-unplug under active URB
transfers.

The issue was reproduced on Qualcomm platforms (Snapdragon 8 Gen 3
Linux 6.1.145 / Android 14, Snapdragon 8 Elite Linux 6.6.77 /
Android16 etc.). The crash consistently hits `__run_timers` (timer
softirq) dereferencing poison pointer.

Meanwhile, we tested numerous Android systems with other processors
and did not encounter this anomaly. Due to limitations, we were unable
to port the standard Linux kernel to Qualcomm processors for testing.

### Crash Trace

```
[  169.493907] I[ 1: surfaceflinger: 1794] Internal error: Oops - CFI:
00000000f2008234 [#1] PREEMPT SMP
[  169.493941] I[ 1: surfaceflinger: 1794] sec,qc-rst_exinfo
soc:samsung,qcom-rst_exinfo: fault handler : unknown
[  169.495442] I[ 1: surfaceflinger: 1794] CPU: 1 PID: 1794 Comm:
surfaceflinger Tainted: G S      WC O
6.1.145-android14-11-3254743-abS9280ZCS6DZF2 #1
[  169.495447] I[ 1: surfaceflinger: 1794] Hardware name: Samsung E3Q
PROJECT (board-id,09) (DT)
[  169.495455] I[ 1: surfaceflinger: 1794] pstate: 02400005 (nzcv daif
+PAN -UAO +TCO -DIT -SSBS BTYPE=--)
[  169.495464] I[ 1: surfaceflinger: 1794] pc : call_timer_fn+0x44/0x26c
[  169.495471] I[ 1: surfaceflinger: 1794] lr : __run_timers+0x1b8/0x30c
[  169.495475] I[ 1: surfaceflinger: 1794] sp : ffffffc00800be40
[  169.495480] I[ 1: surfaceflinger: 1794] x29: ffffffc00800be40 x28:
dead000000000122 x27: 0000000000000000
[  169.495490] I[ 1: surfaceflinger: 1794] x26: ffffffc00800be90 x25:
0000000000000001 x24: ffffff8a713312b0
[  169.495501] I[ 1: surfaceflinger: 1794] x23: ffffffc00a427000 x22:
ffffff8868a70000 x21: ffffff804c485c40
[  169.495511] I[ 1: surfaceflinger: 1794] x20: ffffff804c485c58 x19:
0000000000000100 x18: 0000000000000000
[  169.495522] I[ 1: surfaceflinger: 1794] x17: 0000000091b4a83a x16:
0000000000000000 x15: 0000000000000000
[  169.495532] I[ 1: surfaceflinger: 1794] x14: ffffff804c485c40 x13:
000000000000000d x12: 0000000000000028
[  169.495542] I[ 1: surfaceflinger: 1794] x11: ffffffc00800be98 x10:
ffffff8a71331240 x9 : 0000000100000100
[  169.495553] I[ 1: surfaceflinger: 1794] x8 : 0000000100000100 x7 :
0000002776497736 x6 : 0000002776497736
[  169.495563] I[ 1: surfaceflinger: 1794] x5 : 0000002776497736 x4 :
0000000000000001 x3 : 00000000000009c4
[  169.495573] I[ 1: surfaceflinger: 1794] x2 : 00000000ffff808d x1 :
ffffff804c485c58 x0 : ffffff804c485c40
[  169.495584] I[ 1: surfaceflinger: 1794] Call trace:
[  169.495591] I[ 1: surfaceflinger: 1794]  call_timer_fn+0x44/0x26c
[  169.495598] I[ 1: surfaceflinger: 1794]  __run_timers+0x1b8/0x30c
[  169.495605] I[ 1: surfaceflinger: 1794]  run_timer_softirq+0x24/0x4c
[  169.495614] I[ 1: surfaceflinger: 1794]  handle_softirqs+0x120/0x3e0
[  169.495621] I[ 1: surfaceflinger: 1794]  __do_softirq+0x14/0x20
[  169.495628] I[ 1: surfaceflinger: 1794]  ____do_softirq+0x10/0x20
[  169.495635] I[ 1: surfaceflinger: 1794]  call_on_irq_stack+0x3c/0x74
[  169.495641] I[ 1: surfaceflinger: 1794]  do_softirq_own_stack+0x1c/0x2c
[  169.495648] I[ 1: surfaceflinger: 1794]  __irq_exit_rcu+0x54/0xb4
[  169.495655] I[ 1: surfaceflinger: 1794]  irq_exit_rcu+0x10/0x1c
[  169.495665] I[ 1: surfaceflinger: 1794]  el0_interrupt+0x54/0x174
[  169.495671] I[ 1: surfaceflinger: 1794]  __el0_irq_handler_common+0x18/0x28
[  169.495677] I[ 1: surfaceflinger: 1794]  el0t_64_irq_handler+0x10/0x1c
[  169.495683] I[ 1: surfaceflinger: 1794]  el0t_64_irq+0x1a4/0x1a8
[  169.495690] I[ 1: surfaceflinger: 1794] Code: 72950751 72b23691
6b11021f 54000040 (d4304680)
[  169.495696] I[ 1: surfaceflinger: 1794] ---[ end trace 0000000000000000 ]---
```

### Root Cause & Race Condition

There is a sequence defect in `snd_usbmidi_disconnect()` combined with
the URB completion handler:

1. In `snd_usbmidi_disconnect()`,
`del_timer_sync(&umidi->error_timer)` is invoked BEFORE killing
in-flight IN URBs via `usb_kill_urb()`.
2. Prior to `usb_kill_urb()` finishing, an in-flight IN URB completes
with an unconventional error status (e.g., -EPIPE) when USB
disconnect.
3. `snd_usbmidi_in_urb_complete()` calls `snd_usbmidi_urb_error(urb)`.
When receiving non-disconnect error codes (This error code is outside
the scope of the error codes handled by snd_usbmidi_urb_error.), it
invokes `mod_timer(&ep->umidi->error_timer, ...)` without checking
`umidi->disconnected`.
4. This re-arms `error_timer` AFTER `del_timer_sync()` has already executed.
5. `snd_usbmidi_disconnect()` completes and frees `struct
snd_usb_midi` in `snd_usbmidi_free`.
6. Later when `error_timer` fires on deallocated memory, leading to a
UAF panic in `__run_timers`.



Please let us know your thoughts on this issue.

Thanks!
