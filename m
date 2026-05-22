Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE1ACD5BD0
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2026 15:08:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8753660225;
	Tue, 26 May 2026 17:07:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8753660225
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779808083;
	bh=TldYYOaoDFlVYsGRXRs3XNGNNjTWti+O8T4sDCkNehw=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=kSDOBhJraIp7c06VSG0ey9qeA7Tw+UDLdw+A+mQ/nWg+Jh7468QTKDfefZdMDaOTo
	 wdO530AeRwpNYTK8kLqo2UyOFS2dxqdCR+hy/AJ+OwDk+Y3f52LjGVZNU8bN9aPKxM
	 BdV8e5uHWLzS+lwj5pw+QUVHrtJIEveIwu0BD5es=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C325F805E8; Tue, 26 May 2026 17:07:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D057F805E8;
	Tue, 26 May 2026 17:07:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BDCBF80557; Mon, 25 May 2026 10:13:43 +0200 (CEST)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com
 [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5928F8001F
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2026 10:13:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5928F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=fGhiA0Tf
Received: by mail-qk1-f177.google.com with SMTP id
 af79cd13be357-90ca6f20872so1211970285a.0
        for <alsa-devel@alsa-project.org>;
 Mon, 25 May 2026 01:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779696819; cv=none;
        d=google.com; s=arc-20240605;
        b=VkpzqItYDjEvezWVJ51O2jx0J3uPotgT6zhDrHbSGKeqaaoeeY49Mh/k+giTsUq0sb
         Yo3kvT43a78I6Sh5FemFPOOcCgRPZJlIe4KMBNnZckR5SNyEZ2oLD0yI05Ykk+2znlq0
         y9xWgnFkrLZqDMT0I7UjGPE1flZnF43i0LfsqikboAZITtlfOv72xy0M53Dwt9Qp8Q2O
         FqR7vAp8oYf/+LZYZJQRgYIonLI0Cj0y7BI5kcLJyIx08AiJLCcwsNGl9XGf8RirrK8s
         RCba6hsdWX3yHgGf9sM9xkwPOQa6Tw6ylJtNyNBGArGO14VuMSJ0u9lpAoCqlhn2qfdI
         zplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=f++9SzwfzKmCuf4mhwq6YSVfhlmUNWVwkvB+SLu5S+8=;
        fh=Wh53t5T7A6ynUYrBgCFa1yJCgnP5nKygwtt89q1T+04=;
        b=Z2tKWvZswuDg6redVaedp4SXDbK2O6x40kjlwRFTYmpqScQllGv5syjrYgUWe4fWnH
         EVI0TGHOdX0ix8rZCD+FUsKZeuaxt8G+/DrW7vGVimzlvMJ2Nyao2WPMBQNkOPfFwQqV
         a437IS3VYaHWznjs74Y5iD4EBiUDpdfsdU/NzOnCUKhu2iUq2Zq9qegJGJwxHo0bu0DQ
         VTZIPvYy3yfNJW0jErakVC8DuYgTxQTDWXvFg7jnWUlXHHx0+HV/ujmhVRh55uUTNSi+
         FzK0BmjohojVy3m92NoAj5KoMHXx/W9WoTpA3z9zQpW8UCt0ey2Xa9b9eJGzqM3SORpL
         3vgg==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779696819; x=1780301619;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f++9SzwfzKmCuf4mhwq6YSVfhlmUNWVwkvB+SLu5S+8=;
        b=fGhiA0TfwTRYZLUhui+8aNQ4/uxJP+j+NVoyW3I8YExbMjoCiScD8Mbq0F/jtyPDHa
         8kmesPUax+5jza3GsMjwi+7/w3ZL8IT4LQ0cmu6hUndVxL1K2E9S5oLXtBGM6nvApKvB
         hB4bnZJHjhHZBeRYCOmUe2aAXGVdm9imdVED0mvzj0V5ASVoRTKEmFLOIuN8knxHlwXH
         RHOYKdFtG9phfZsGbhJG/heXPDDlsfKwKFy5kbSCSZQ5DW704k+Fi4bn3F8e4FZ6hybp
         9iNC++JKxpAkbD5af43aNf5CCiBaI0t458D2zRF5tPgZy2SF7wqXg8tqwhGbAnojbGC3
         J7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779696819; x=1780301619;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f++9SzwfzKmCuf4mhwq6YSVfhlmUNWVwkvB+SLu5S+8=;
        b=Rcl089wcaZcfdVE98PKgrSA454M4JXYSljYM6e9gdjsesu9k7xyMBt4jJD/xu/LLSr
         70p1Eo0wZ5BMoQoX17x6tUbG4c5p21dPkE/ucSH8yBkblCs4XjhcnR5gK5TfHvric7AC
         ySFCGThW71QE6L2PzWKF0n18MVbxt+8gwMBvxedSzrBuI5GvvtoUoApADzUoAfIoKx5l
         cf0UrAC364OIxsg3BRvmXDOWnCQKYKHnRbRz8On0snXOIZudPhagO2Yo6VL5+o7g7MJ4
         1b98QKQ04XCBXqZvpPqZV4jxrjf3wFIW9Rxh80EuZuWLhRlLPF/Zyhrjis3OD49upVRN
         48Sg==
X-Gm-Message-State: AOJu0YxYYdEekOpMcbkg4sT+Sf1JRdXX2ITcOHxg06fh5UPE5dneXseJ
	+bjNwNsZT07QuZCa5erxyWO0MAeIvAkU3IJRq2vbX8BzJCjnDuNKntgPaJQHuJXWwUg8FXe36jI
	EVzjZg/gAIWYbCgmquD51k/1ZDiHhnsadW4DuO2Ouh/TW
X-Gm-Gg: Acq92OGEh+csGwCBO+vuw+hyQYlVmLFJdPEtnbvmr1TyZiZAMhO6Hhl2cW40CunHqsl
	VIQXYdgYxeY6oocaUHBSkC01arjAfU5H4gs/akvZ7vmGm0FGhwHGiM6xBr8ySY0w2c1zz9F6B9L
	x4bjVCIr1HwBB8fULEF3Jl7x2aoLfxt7tFWD9Hf3Vi0Daq5DDnbFhBYenuLKdGiioOG8XdUjX2B
	GkYkX2dG5SlaA20EyIjJ5vCiJcTbqokiQNcSwWcsoel26u2Cr/41pb75Yao/4HfhCoEpb7o49Em
	H1wbdKgV
X-Received: by 2002:a05:690c:a95:b0:7b2:9347:7ba7 with SMTP id
 00721157ae682-7d35801edefmr39683637b3.22.1779478019542; Fri, 22 May 2026
 12:26:59 -0700 (PDT)
MIME-Version: 1.0
From: Gordon Chen <chengordon326@gmail.com>
Date: Sat, 23 May 2026 03:26:46 +0800
X-Gm-Features: AVHnY4JEoZxwKSY0KEcXWHF_YMHlFhtE2L7576pd7Qdl4SyjlKCk4TI5KycBzgE
Message-ID: 
 <CAJxk+sBq4QaqgQF5KjwbLgiSDs0ab8PBrBrErOz7TDX9rWOasQ@mail.gmail.com>
Subject: [BUG] snd-usb-audio: Behringer Flow 8 (1397:050c)
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
Content-Type: multipart/mixed; boundary="0000000000003de08f06526d03cd"
X-MailFrom: chengordon326@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 3WK4XV44UDLWTCNJSTIRWQ5IVDGOR4B2
X-Message-ID-Hash: 3WK4XV44UDLWTCNJSTIRWQ5IVDGOR4B2
X-Mailman-Approved-At: Tue, 26 May 2026 15:07:25 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3WK4XV44UDLWTCNJSTIRWQ5IVDGOR4B2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--0000000000003de08f06526d03cd
Content-Type: text/plain; charset="UTF-8"

implicit-feedback playback EP starves permanently after capture packet
errors

Hi Takashi,

I would like to report what looks like a long-standing silent-stall path
in sound/usb/endpoint.c that triggers reliably on the Behringer Flow 8
USB mixer (idVendor=0x1397 idProduct=0x050c, UAC 2.0, high-speed).

Symptom
=======
After 5-35 minutes of continuous playback at 48 kHz, the playback PCM
hw_ptr stops advancing while substream state remains
SNDRV_PCM_STATE_RUNNING. No XRUN reported, no recovery; only a full USB
device-level unbind/bind clears it (jackd / pipewire restart alone is
not sufficient).

The Flow 8 declares an OUT EP 0x01 with implicit feedback from capture
EP 0x81 (Sync EP Interface=2 Altset=1, Implicit Feedback Mode: Yes per
/proc/asound/F8/stream0). The chip currently has no quirk_flags entry in
sound/usb/quirks.c. Tried setting

  - QUIRK_FLAG_SKIP_IMPLICIT_FB    (no effect; the UAC2 endpoint
                                    companion descriptor explicitly
                                    references the sync EP, so IFB is
                                    wired up by the standard parser
                                    regardless of the quirk)
  - QUIRK_FLAG_PLAYBACK_FIRST | QUIRK_FLAG_GENERIC_IMPLICIT_FB
                                   (same as UMC202/204/404HD; no effect)
  - QUIRK_FLAG_FORCE_IFACE_RESET   (no effect)

None of them addresses the stall.

Evidence (three independent ftrace captures with func_stack_trace)
==================================================================
Each capture covers ~70 ms ending at a STALL_MARKER timestamp written
once a userspace watchdog noticed hw_ptr frozen. In all three captures:

  - 60-70 capture URB completion cycles in the 70 ms window
  - 0 retire_playback_urb / prepare_outbound_urb /
    snd_usb_queue_pending_output_urbs /
    snd_usb_endpoint_implicit_feedback_sink calls
  - every usb_submit_urb in the window comes from
    snd_complete_urb+0x64e (the capture self-resubmit at line 594);
    none from snd_usb_queue_pending_output_urbs

Concurrent dmesg shows recurring (rate-limited) lines from pcm.c
around iso frame status reporting:

    usb 3-1: frame N active: -18      (iso_frame_desc[N].status = -EXDEV)

In some cases two consecutive frames within a single URB hit -EXDEV in
the same millisecond. dev_dbg_ratelimited hides the true rate, but
ftrace confirms the IFB sink is never being called.

Suspected root cause
====================
In snd_usb_handle_sync_urb(), sound/usb/endpoint.c around line 1784:

    for (i = 0; i < in_ctx->packets; i++)
        if (urb->iso_frame_desc[i].status == 0)
            bytes += urb->iso_frame_desc[i].actual_length;

    /*
     * skip empty packets. At least M-Audio's Fast Track Ultra stops
     * streaming once it received a 0-byte OUT URB
     */
    if (bytes == 0)
        return;

When Flow 8 returns a capture URB whose every packet has a non-zero
status (recurrent -EXDEV episodes), bytes stays 0 and we return without
calling snd_usb_queue_pending_output_urbs(). The OUT ring loses its
sole IFB-driven feeder and starves forever, while the IN ring keeps
self-resubmitting through snd_complete_urb()'s pipein branch.

So the "skip empty" path that protects M-Audio Fast Track Ultra is, for
Flow 8 -class devices, an unconditional kill switch.

Proposed fix
============
Add an opt-in quirk QUIRK_FLAG_IFB_SILENCE_ON_EMPTY that, when set,
skips the early return and falls through to the existing
next_packet_fifo_enqueue path. The loop already maps each
iso_frame_desc[i].status != 0 to packet_size[i] = 0, so falling through
naturally produces a silence packet, prepare_outbound_urb keeps the OUT
ring alive, and the device rides through the glitch.

Default behaviour is preserved for every existing device including
M-Audio Fast Track Ultra (no quirk -> early return as today). Only
Flow 8 opts in.

Patch attached (0001-...patch).

Tested
======
On CachyOS kernel 7.0.9-1-cachyos (mainline 6.10-derived). The patched
driver has been running on the Flow 8 for [N] hours of continuous
playback. Will report longer soak results once available.

Anything else useful I can provide:
  - full lsusb -v 1397:050c
  - the three raw ftrace files (~140 KB each around STALL_MARKER)
  - usbmon pcap during a stall episode (200 MB segment, can trim)
  - /proc/asound/F8/stream0, pcm0p, pcm0c snapshots

Happy to spin the patch differently if you'd prefer a different name,
or default-on with M-Audio opting out, or something else.

Thanks for taking a look.

Best,
Gordon

--0000000000003de08f06526d03cd
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-snd-usb-audio-add-IFB-silence-on-empty-quirk-for-Beh.patch"
Content-Disposition: attachment;
	filename="0001-snd-usb-audio-add-IFB-silence-on-empty-quirk-for-Beh.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mphb9b6i0>
X-Attachment-Id: f_mphb9b6i0

RnJvbTogR29yZG9uIDxjaGVuZ29yZG9uMzI2QGdtYWlsLmNvbT4KRGF0ZTogU2F0LCAyMyBNYXkg
MjAyNiAwMzoxMDowMCArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEFMU0E6IHVzYi1hdWRpbzogYWRk
IElGQl9TSUxFTkNFX09OX0VNUFRZIHF1aXJrIGZvciBCZWhyaW5nZXIKIEZsb3cgOAoKVGhlIEJl
aHJpbmdlciBGbG93IDggKDEzOTc6MDUwYykgaXMgYW4gOC1jaGFubmVsIFVTQiBtaXhlciB0aGF0
CmRlY2xhcmVzIE9VVCBFUCAweDAxIHdpdGggaW1wbGljaXQgZmVlZGJhY2sgZnJvbSBjYXB0dXJl
IEVQIDB4ODEgdmlhCml0cyBVQUMyIGVuZHBvaW50IGNvbXBhbmlvbiBkZXNjcmlwdG9yLiBBZnRl
ciA1LTM1IG1pbnV0ZXMgb2YKY29udGludW91cyBwbGF5YmFjaywgdGhlIGRldmljZSBvY2Nhc2lv
bmFsbHkgcmV0dXJucyBhIGNhcHR1cmUgVVJCIGluCndoaWNoIGV2ZXJ5IGlzb19mcmFtZV9kZXNj
IGhhcyBhIG5vbi16ZXJvIHN0YXR1cyAoLUVYREVWIGJ1cnN0cywKdmlzaWJsZSBhcyByYXRlLWxp
bWl0ZWQgImZyYW1lIE4gYWN0aXZlOiAtMTgiIGxpbmVzIGluIGRtZXNnIGZyb20KcGNtLmMpLgoK
SW4gdGhhdCBjYXNlIHNuZF91c2JfaGFuZGxlX3N5bmNfdXJiKCkgYXQgZW5kcG9pbnQuYyBjb3Vu
dHMgYnl0ZXM9PTAKYW5kIGZhbGxzIGludG8gdGhlIGVhcmx5ICJza2lwIGVtcHR5IHBhY2tldHMi
IHJldHVybiBvcmlnaW5hbGx5IGFkZGVkCmZvciBNLUF1ZGlvIEZhc3QgVHJhY2sgVWx0cmEuIEFz
IGEgcmVzdWx0IHRoZSBwbGF5YmFjayBFUCBsb3NlcyBpdHMKc29sZSBJRkItZHJpdmVuIGZlZWRl
ciBhbmQgdGhlIE9VVCByaW5nIHN0YXJ2ZXMgcGVybWFuZW50bHk6IGh3X3B0cgpzdG9wcyBhZHZh
bmNpbmcgd2hpbGUgc3Vic3RyZWFtIHN0YXRlIHJlbWFpbnMgUlVOTklORy4gT25seSBVU0IKcmUt
ZW51bWVyYXRpb24gcmVjb3ZlcnMuCgpUaHJlZSBpbmRlcGVuZGVudCBmdHJhY2UgY2FwdHVyZXMg
KHRha2VuIGF0IHRoZSBtb21lbnQgb2Ygc3RhbGwgdmlhIGEKdXNlcnNwYWNlIHdhdGNoZG9nKSBj
b25zaXN0ZW50bHkgc2hvdzoKCiAgLSA2MC03MCBjYXB0dXJlIFVSQiBjb21wbGV0aW9ucyBpbiB0
aGUgNzBtcyB3aW5kb3cgYmVmb3JlIHRoZSBtYXJrZXIKICAtIDAgcmV0aXJlX3BsYXliYWNrX3Vy
YiAvIHF1ZXVlX3BlbmRpbmdfb3V0cHV0X3VyYnMgLwogICAgc25kX3VzYl9lbmRwb2ludF9pbXBs
aWNpdF9mZWVkYmFja19zaW5rIGNhbGxzCiAgLSBldmVyeSB1c2Jfc3VibWl0X3VyYiBpbiB0aGUg
d2luZG93IGNvbWVzIGZyb20KICAgIHNuZF9jb21wbGV0ZV91cmIrMHg2NGUgKGNhcHR1cmUgc2Vs
Zi1yZXN1Ym1pdCksIG5vbmUgZnJvbSB0aGUKICAgIHF1ZXVlX3BlbmRpbmdfb3V0cHV0X3VyYnMg
cGF0aAoKQWRkIGEgbmV3IG9wdC1pbiBxdWlyayBRVUlSS19GTEFHX0lGQl9TSUxFTkNFX09OX0VN
UFRZOiB3aGVuIHNldCwgdGhlCmVhcmx5IHJldHVybiBpcyBza2lwcGVkIGFuZCB3ZSBmYWxsIHRo
cm91Z2ggdG8gZW5xdWV1ZSBhIHBhY2tldF9pbmZvCndob3NlIHBhY2tldF9zaXplW2ldIGFyZSBh
bGwgMCAodGhlIGV4aXN0aW5nIGxvb3AgYWxyZWFkeSBtYXBzCnN0YXR1cyE9MCBwYWNrZXRzIHRv
IHNpemUgMCkuIHByZXBhcmVfb3V0Ym91bmRfdXJiIHRoZW4gZW1pdHMgYQpzaWxlbmNlIHBhY2tl
dCwgdGhlIE9VVCByaW5nIGtlZXBzIG1vdmluZywgYW5kIHRoZSBkZXZpY2UgcmlkZXMKdGhyb3Vn
aCB0aGUgZ2xpdGNoLgoKVGhlIGRlZmF1bHQgYmVoYXZpb3VyIChlYXJseSByZXR1cm4pIGlzIHBy
ZXNlcnZlZCBmb3IgYWxsIGV4aXN0aW5nCmRldmljZXMgaW5jbHVkaW5nIE0tQXVkaW8gRmFzdCBU
cmFjayBVbHRyYS4gT25seSBGbG93IDggb3B0cyBpbiBoZXJlLgoKU2lnbmVkLW9mZi1ieTogR29y
ZG9uIDxjaGVuZ29yZG9uMzI2QGdtYWlsLmNvbT4KLS0tCiBzb3VuZC91c2IvZW5kcG9pbnQuYyB8
IDEyICsrKysrKysrKystLQogc291bmQvdXNiL3F1aXJrcy5jICAgfCAgMyArKysKIHNvdW5kL3Vz
Yi91c2JhdWRpby5oIHwgIDkgKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvc291bmQvdXNiL2VuZHBvaW50LmMg
Yi9zb3VuZC91c2IvZW5kcG9pbnQuYwppbmRleCBYWFhYWFhYLi5YWFhYWFhYIDEwMDY0NAotLS0g
YS9zb3VuZC91c2IvZW5kcG9pbnQuYworKysgYi9zb3VuZC91c2IvZW5kcG9pbnQuYwpAQCAtMTc4
MSw4ICsxNzgxLDE2IEBAIHN0YXRpYyB2b2lkIHNuZF91c2JfaGFuZGxlX3N5bmNfdXJiKHN0cnVj
dCBzbmRfdXNiX2VuZHBvaW50ICplcCwKIAkJLyoKIAkJICogc2tpcCBlbXB0eSBwYWNrZXRzLiBB
dCBsZWFzdCBNLUF1ZGlvJ3MgRmFzdCBUcmFjayBVbHRyYSBzdG9wcwogCQkgKiBzdHJlYW1pbmcg
b25jZSBpdCByZWNlaXZlZCBhIDAtYnl0ZSBPVVQgVVJCCisJCSAqCisJCSAqIEhvd2V2ZXIsIG9u
IGRldmljZXMgd2hlcmUgYnl0ZXM9PTAgbWVhbnMgZXZlcnkgc3luYy1zb3VyY2UKKwkJICogcGFj
a2V0IGVycm9yZWQgKGUuZy4gQmVocmluZ2VyIEZsb3cgOCByZXR1cm5pbmcgLUVYREVWIGJ1cnN0
cworCQkgKiBmb3IgZW50aXJlIGNhcHR1cmUgVVJCcyksIGFuIHVuY29uZGl0aW9uYWwgcmV0dXJu
IHN0YXJ2ZXMgdGhlCisJCSAqIElGQi1mZWQgT1VUIHJpbmcgcGVybWFuZW50bHkuIFN1Y2ggZGV2
aWNlcyBzZXQKKwkJICogUVVJUktfRkxBR19JRkJfU0lMRU5DRV9PTl9FTVBUWSB0byBmYWxsIHRo
cm91Z2ggYW5kIGVucXVldWUgYQorCQkgKiBwYWNrZXRfaW5mbyB3aXRoIHNpemUgMCBwYWNrZXRz
LCBzbyBwbGF5YmFjayBlbWl0cyBzaWxlbmNlCisJCSAqIGFuZCB0aGUgT1VUIHJpbmcga2VlcHMg
bW92aW5nLgogCQkgKi8KLQkJaWYgKGJ5dGVzID09IDApCisJCWlmIChieXRlcyA9PSAwICYmICEo
ZXAtPmNoaXAtPnF1aXJrX2ZsYWdzICYgUVVJUktfRkxBR19JRkJfU0lMRU5DRV9PTl9FTVBUWSkp
CiAJCQlyZXR1cm47CgogCQlzcGluX2xvY2tfaXJxc2F2ZSgmZXAtPmxvY2ssIGZsYWdzKTsKZGlm
ZiAtLWdpdCBhL3NvdW5kL3VzYi9xdWlya3MuYyBiL3NvdW5kL3VzYi9xdWlya3MuYwppbmRleCBY
WFhYWFhYLi5YWFhYWFhYIDEwMDY0NAotLS0gYS9zb3VuZC91c2IvcXVpcmtzLmMKKysrIGIvc291
bmQvdXNiL3F1aXJrcy5jCkBAIC0yMTI3LDYgKzIxMjcsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHVzYl9hdWRpb19xdWlya19mbGFnc190YWJsZSBxdWlya19mbGFnc190YWJsZVtdID0gewogCQkg
ICBRVUlSS19GTEFHX1BMQVlCQUNLX0ZJUlNUIHwgUVVJUktfRkxBR19HRU5FUklDX0lNUExJQ0lU
X0ZCKSwKIAlERVZJQ0VfRkxHKDB4MTM5NywgMHgwNTA5LCAvKiBCZWhyaW5nZXIgVU1DNDA0SEQg
Ki8KIAkJICAgUVVJUktfRkxBR19QTEFZQkFDS19GSVJTVCB8IFFVSVJLX0ZMQUdfR0VORVJJQ19J
TVBMSUNJVF9GQiksCisJREVWSUNFX0ZMRygweDEzOTcsIDB4MDUwYywgLyogQmVocmluZ2VyIEZs
b3cgOCAqLworCQkgICBRVUlSS19GTEFHX0lGQl9TSUxFTkNFX09OX0VNUFRZKSwKIAlERVZJQ0Vf
RkxHKDB4MTNlNSwgMHgwMDAxLCAvKiBTZXJhdG8gUGhvbm8gKi8KIAkJICAgUVVJUktfRkxBR19J
R05PUkVfQ1RMX0VSUk9SKSwKCkBAIC0yMjgwLDYgKzIyODIsNyBAQCBzdGF0aWMgY29uc3QgY2hh
ciAqY29uc3Qgc25kX3VzYl9hdWRpb19xdWlya19mbGFnX25hbWVzW10gPSB7CiAJUVVJUktfU1RS
SU5HX0VOVFJZKFNLSVBfSUZBQ0VfU0VUVVApLAogCVFVSVJLX1NUUklOR19FTlRSWShNSVhFUl9Q
TEFZQkFDS19MSU5FQVJfVk9MKSwKIAlRVUlSS19TVFJJTkdfRU5UUlkoTUlYRVJfQ0FQVFVSRV9M
SU5FQVJfVk9MKSwKKwlRVUlSS19TVFJJTkdfRU5UUlkoSUZCX1NJTEVOQ0VfT05fRU1QVFkpLAog
CU5VTEwKIH07CgpkaWZmIC0tZ2l0IGEvc291bmQvdXNiL3VzYmF1ZGlvLmggYi9zb3VuZC91c2Iv
dXNiYXVkaW8uaAppbmRleCBYWFhYWFhYLi5YWFhYWFhYIDEwMDY0NAotLS0gYS9zb3VuZC91c2Iv
dXNiYXVkaW8uaAorKysgYi9zb3VuZC91c2IvdXNiYXVkaW8uaApAQCAtMTk1LDYgKzE5NSwxMiBA
QCBleHRlcm4gYm9vbCBzbmRfdXNiX3NraXBfdmFsaWRhdGlvbjsKICAqICBTZXQgbGluZWFyIHZv
bHVtZSBtYXBwaW5nIGZvciBkZXZpY2VzIHdoZXJlIHRoZSBwbGF5YmFjayB2b2x1bWUgY29udHJv
bAogICogIHJhbmdlIGFuZCB2YWx1ZSBhcmUgcmVwb3J0ZWQgaW4gbGluZWFyIGFtcGxpdHVkZSBz
Y2FsZSBpbnN0ZWFkIG9mIGRCLgogICogIE92ZXJyaWRlcyBRVUlSS19GTEFHX01JWEVSX1BMQVlC
QUNLX01JTl9NVVRFCisgKiBRVUlSS19GTEFHX0lGQl9TSUxFTkNFX09OX0VNUFRZCisgKiAgSW4g
aW1wbGljaXQgZmVlZGJhY2sgbW9kZSwgd2hlbiBhbiBlbnRpcmUgY2FwdHVyZSBVUkIgcmV0dXJu
cyB3aXRoCisgKiAgYWxsIGlzb19mcmFtZV9kZXNjW2ldLnN0YXR1cyAhPSAwIChieXRlcz09MCks
IGRvIG5vdCBzaWxlbnRseSByZXR1cm4KKyAqICBmcm9tIHNuZF91c2JfaGFuZGxlX3N5bmNfdXJi
LiBJbnN0ZWFkIGZhbGwgdGhyb3VnaCBhbmQgZW5xdWV1ZSBhCisgKiAgcGFja2V0X2luZm8gY29u
dGFpbmluZyBvbmx5IHNpemUtMCBwYWNrZXRzLCBzbyB0aGUgT1VUIHJpbmcga2VlcHMKKyAqICBt
b3ZpbmcgKGVtaXRzIHNpbGVuY2UpLiBOZWVkZWQgYnkgQmVocmluZ2VyIEZsb3cgOCAoMTM5Nzow
NTBjKS4KICAqLwoKIGVudW0gewpAQCAtMjI3LDYgKzIzMyw4IEBAIGVudW0gewogCVFVSVJLX1RZ
UEVfU0tJUF9JRkFDRV9TRVRVUAkJPSAyNiwKIAlRVUlSS19UWVBFX01JWEVSX1BMQVlCQUNLX0xJ
TkVBUl9WT0wJPSAyNywKIAlRVUlSS19UWVBFX01JWEVSX0NBUFRVUkVfTElORUFSX1ZPTAk9IDI4
LAorCVFVSVJLX1RZUEVfSUZCX1NJTEVOQ0VfT05fRU1QVFkJCT0gMjksCisvKiBQbGVhc2UgYWxz
byBlZGl0IHNuZF91c2JfYXVkaW9fcXVpcmtfZmxhZ19uYW1lcyAqLwogfTsKCiAjZGVmaW5lIFFV
SVJLX0ZMQUcoeCkJQklUX1UzMihRVUlSS19UWVBFXyAjIyB4KQpAQCAtMjU5LDUgKzI2Nyw2IEBA
IGVudW0gewogI2RlZmluZSBRVUlSS19GTEFHX1NLSVBfSUZBQ0VfU0VUVVAJCVFVSVJLX0ZMQUco
U0tJUF9JRkFDRV9TRVRVUCkKICNkZWZpbmUgUVVJUktfRkxBR19NSVhFUl9QTEFZQkFDS19MSU5F
QVJfVk9MCVFVSVJLX0ZMQUcoTUlYRVJfUExBWUJBQ0tfTElORUFSX1ZPTCkKICNkZWZpbmUgUVVJ
UktfRkxBR19NSVhFUl9DQVBUVVJFX0xJTkVBUl9WT0wJUVVJUktfRkxBRyhNSVhFUl9DQVBUVVJF
X0xJTkVBUl9WT0wpCisjZGVmaW5lIFFVSVJLX0ZMQUdfSUZCX1NJTEVOQ0VfT05fRU1QVFkJCVFV
SVJLX0ZMQUcoSUZCX1NJTEVOQ0VfT05fRU1QVFkpCgogI2VuZGlmIC8qIF9fVVNCQVVESU9fSCAq
LwotLQoyLjQ1LjAK
--0000000000003de08f06526d03cd--
