Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F77CC61DE1
	for <alsa-devel@archiver.kernel.org>; Sun, 30 Aug 2026 08:36:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 927FD601E1;
	Sun, 30 Aug 2026 10:36:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 927FD601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788078994;
	bh=SZinaHAUgKjYwLr9Sr/txOMgsT30S3s5diAg+H/ieBQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=LPnZZHyPSQ/H5+YXbaJ4Tvy3caYajiCi7B9lSLOBfhCAEoCeNDikA82zCxtPzBbLY
	 EaBkxTXtHi/2Q2LDkOPEH/pAnXWRVdld1itcGi+ljtF/DJHEqccZDkI90m+oCVzhjy
	 tC1ANDy0UjUAUPjsfU83HyGNAjtKCnCeulmIledk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7742EF805F0; Sun, 30 Aug 2026 10:35:59 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B19DF805F7;
	Sun, 30 Aug 2026 10:35:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5AC1CF80549; Sun, 30 Aug 2026 10:35:50 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788078948;
	b=a5Icrz7myRh6ndmwrunMR1HFJsaMqhzdRk8skI9vifur94s87R9L8iEtOIX8N0wnf+Ch
	 EbivyqI8eEjCIUoibo6aqfjFkZXhdf/SQMY3NExCYgcxNHmW6x74H0fa/fyJ78jL2Z7OH
	 /7D4q8QB164VU4syYmGg5Q3AapAxqqaQ40H7h14osfuc4ctsMzTS6lPc94ohGkKZTXBk7
	 pVdeMws2mg/pQRnqS1+W/B5IdudDoFDBDpTbzE4QhK4U0BvrdjQaGAynUW/h+Wof086VZ
	 /DuO3FfqfjzkQBZvfz8C8uFHIg3r0PeBmw4GZMOEeSp2zymTb6w12ABXeBx6TQ9kyPg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788078948;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SZinaHAUgKjYwLr9Sr/txOMgsT30S3s5diAg+H/ieBQ=;
	b=azkp6QApPDrANY7JL+a3ddIsYhMyR4cZ2c4EejKbt3cHHLcpGwBeTCZzH8xjQrUk4Za3
	 fJD/Ur8wzB8NN8YhsJ98aRBVhgyagx2uaMye+qplpcrodd8Vk74K6CqxdRvyE7N++VgE5
	 bFb/U5VD17+spfTPrOOcE4ymi7j7FAXEds9rg8Wz5/a5HHoe3tOcamllXVS5KC1n5SUso
	 BfFegIhCJZITuV++A7w/HXFgSq6PJzDNVcxlewIBDwWUBefYiykO9XW1uI2kS/t9HFn4X
	 zG9Cj55TNW0mvbGEPpvAe8Jv0t5KxkbnqR5mwUXC6+KoxLaqfeHSVrBdBDQmKeEwV6A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FHNjzBhd;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8A2CBF800AC
	for <alsa-devel@alsa-project.org>; Sun, 30 Aug 2026 10:35:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A2CBF800AC
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=FHNjzBhd
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48433f36a21so509123f8f.1
        for <alsa-devel@alsa-project.org>;
 Sun, 30 Aug 2026 01:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788078946; x=1788683746;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zYgS4XBaWrj2K2jqhP1KpAwV8hjy+VSAQbC0FB0+Q3Y=;
        b=FHNjzBhdn1xmWJxMjALbmjIO2igfOxznHQFK+4wWUW1/NvQQCz0mNOV3ryFwZYde3N
         avpEa8JXS6njMdwdbKrBhEFZvLORo8jmel8UVkbJEIDNbuu/r2CYoUSc/SMuGWZdqXzX
         UZ2K0Vaj6V+16FgxCG+pQST5QnhAXxZq9CTLhkGUFFVc2SODO5jpawDjV6ARxGC1qxqQ
         QCJHebmxlkgTKDh+V4x713lF8WD+v9PIg9pIQV2NdSV6iHGNMmDqYWQaMwHNSpRvxnWs
         Yt/XaaSn/J6ssYenPjwAwn0EbfKIkJEFywYC4dzC9cHQEkAtmOWgp2xV4BDT1llE3KTi
         OboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788078946; x=1788683746;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zYgS4XBaWrj2K2jqhP1KpAwV8hjy+VSAQbC0FB0+Q3Y=;
        b=rGZ4KW+V9IV/0esDBMw4OgKcdsv9xuGQAE9aQQdRcStVNkz6HqI4aDXpm+rDG1FT0d
         wHAEPsYtRHZV9PcOcxcl/7Cr1ygFsiryunvN4LPU7NoglSnGFIyTCmP1wsEDGa0v8VPq
         rGSs7vf02NUNa8gEfFjWtb8WZHoie7pJoFl3sJdEG7o5Py5K5ZK07LRGCrDHCxmeWhPA
         ZxrJR5/q+MZmjjNCZ6q2gOM4EB+qtH3NM4PJ3mGX+YMjML/akeUJNE5+zMkJJHwqkw9w
         +yhPxZynMlocFst8XwquIlLhVCV0P0qy/iHJTLVVXO2wxmthe/z5eFsS4ylrKSn2V4pj
         yi+w==
X-Gm-Message-State: AFuF++m5uJhNTUkGhjd5Oqb70csHP8aAPUjTNCXzhJAT8LSxWOyLemTC
	GTbvRrRTHaYNBcC3adUjhC4wDaJIUA7Un1D1zSDvhqQZCP2Jc72ND1PLkICB/Cv9wvs=
X-Gm-Gg: AR+sD13tc7QqztXEqa9RjyHDhKv3aFWC5mKPmjRNOS3/WoX7GIY3jSx8kSy64GDKdtV
	adXxxSjyj9x0gijRdsLVnU8h5I4LFFdSgQM6SXm2x+mkd2Ic7RSvZaOtSMHYBTPpc4scVk7N0Xc
	O1bWjfmyvsSGSpQw4Rf1Z55K36/q5Q/BRy7pcYrFsHnkX0BmPr8v7zUQtFCn3DRl9lVhm2fkSZX
	FsOik01SkPUxc0TLPcL8ttGWvaHByy+XHFj6wi+O6CR5ZiVCjMgkyymDbucjKoaI/HFC+GjJSX4
	ckXb/CTlQ0QlB8k9XHqsYLmagszpfrSi+jb4hpkF6I3Kk8eXpAx+ctPoT7jH7Ph1u9Ny2KwvlXD
	QGUw2M5C+LF2VwinUJrehufkYhwAZYPnl40dtXSMGgsg5ejHO1cKGgq6f1AbKH/P+eALyCv6PbA
	gHg2RB0/Tb5UA4uIHYcS5BGQHz+lHmZ1RSprdKtr20mhStBK54PIB37w9HwpalMzo=
X-Received: by 2002:a05:600c:5491:b0:49b:4eb6:6ffd with SMTP id
 5b1f17b1804b1-49cd53987cfmr15697265e9.5.1788078946230;
        Sun, 30 Aug 2026 01:35:46 -0700 (PDT)
Received: from archlinux.lan ([188.75.207.210])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b94dcaf61sm178340365e9.4.2026.08.30.01.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 01:35:45 -0700 (PDT)
From: Viktor Menshin <ripeeerr@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
Subject: ALC287 (SSID 17aa:3912) audio distortion on Lenovo Xiaoxin Pro 14
 ASP10 - root cause and headphone fix
Date: Sun, 30 Aug 2026 17:35:30 +0900
Message-ID: <20260830083530.6461-1-ripeeerr@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4YENRZ7XMXWUGOPKOPHNTT4JSOBQK7BT
X-Message-ID-Hash: 4YENRZ7XMXWUGOPKOPHNTT4JSOBQK7BT
X-MailFrom: ripeeerr@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4YENRZ7XMXWUGOPKOPHNTT4JSOBQK7BT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Reporting an audio issue on a Lenovo Xiaoxin Pro 14 ASP10 (83LR), AMD
Ryzen AI 9 365 (Strix Point), with a Realtek ALC287 codec, PCI SSID
17aa:3912.

Symptom: both the internal speakers and headphone output produce heavy
distortion/crackling (not volume-dependent) on every Linux kernel and
distro tested, and also on Windows before installing the Realtek driver
package.

$ uname -a
Linux riper-83lr 7.1.6-arch1-1 #1 SMP PREEMPT_DYNAMIC Tue, 04 Aug 2026 11:19:27 +0000 x86_64 GNU/Linux

$ lspci -nnk | grep -iA3 audio
c2:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Ryzen HD Audio Controller [1022:15e3]
	Subsystem: Lenovo Device [17aa:38b2]
	Kernel driver in use: snd_hda_intel
	Kernel modules: snd_hda_intel

Relevant dmesg:
snd_hda_codec_alc269 hdaudioC1D0: ALC287: picked fixup  for PCI SSID 17aa:0000
snd_hda_codec_alc269 hdaudioC1D0: autoconfig for ALC287: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:speaker
snd_hda_codec_alc269 hdaudioC1D0:    hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
snd_hda_codec_alc269 hdaudioC1D0:    inputs:
snd_hda_codec_alc269 hdaudioC1D0:      Mic=0x19

Root cause: there's no quirk entry for SSID 17aa:3912 in patch_realtek.c,
so the codec falls back to the generic "17aa:0000" Lenovo fixup. The
ALC287 vendor-specific processing coefficients (node 0x20) are left at
generic/uninitialized defaults, while the Windows Realtek driver programs
a model-specific coefficient table into this node at init. That's what
causes the distortion.

To find the real values, I passed the physical HD Audio controller
(0000:c2:00.6) through to a Windows 10 VM via VFIO, ran the stock Realtek
driver, and logged CORB verb traffic with a patched QEMU, using
https://github.com/ryanprescott/realtek-verb-tools
(wiki: https://github.com/ryanprescott/realtek-verb-tools/wiki/How-to-sniff-verbs-from-a-Windows-sound-driver)

Headphones: fixed. A single coefficient write completely eliminates the
distortion on the headphone output, confirmed stable across reboots and
under load:

  hda-verb /dev/snd/hwC1D0 0x20 SET_COEF_INDEX 0x36
  hda-verb /dev/snd/hwC1D0 0x20 SET_PROC_COEF 0x77d7

As a kernel-style fixup:

  static void alc287_fixup_lenovo_xiaoxin_pro14_asp10_hp(struct hda_codec *codec,
                                                          const struct hda_fixup *fix, int action)
  {
          if (action != HDA_FIXUP_ACT_INIT)
                  return;

          alc_write_coef_idx(codec, 0x36, 0x77d7);
  }

Suggested quirk table entry:

  SND_PCI_QUIRK(0x17aa, 0x3912, "Lenovo Xiaoxin Pro 14 ASP10",
                ALC287_FIXUP_LENOVO_XIAOXIN_PRO14_ASP10_HP),

Speakers: not fixed yet. I captured a much larger coefficient table from
a speaker-only session (headphones unplugged) and replayed it, but it did
not resolve the speaker distortion. Still investigating.

Full codec dump (cat /proc/asound/card1/codec#0) available on request.

Thanks,
Viktor Menshin
