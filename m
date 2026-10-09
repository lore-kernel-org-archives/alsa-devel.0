Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B562CA9EC0
	for <alsa-devel@archiver.kernel.org>; Sat, 10 Oct 2026 19:43:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A73E60297;
	Sat, 10 Oct 2026 21:43:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A73E60297
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1791661409;
	bh=HP4oKljIm8A1tbLIw9FD1AKYGFAbknP741VMRtCB644=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Zj8pUCnmzLrUKRu5lmsJKBpyuyfQ4T7XHslPRAgv3TA6jby1puhgApFYlBYgXFMWN
	 nVYpE3sCI53uLKgm7eKTMfjnrRNAs5joun28Doj8P4dATPu2o7+c/aeTFFu9/+UwIv
	 4jhPr/pjA5eAtQYEId2vGBUH3ZajcbafsOW7jBqE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0A031F806CF; Sat, 10 Oct 2026 21:41:55 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 29BD7F806CA;
	Sat, 10 Oct 2026 21:41:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24C71F80557; Fri,  9 Oct 2026 23:19:57 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1791580793;
	b=h4MLDw6zOcfN/VF9F/opyONfLpMY3IsJEy0vGhEZuhQIVAJDcJ3uWh29QLIV340nFMbH
	 R+9qhnsxMxDnNHv5Rn5n7mimfF3XMnrnDWyhLfS3T9rsFcvri/F72YtHgEn0Ri11Kycky
	 p6iIdp2oAk9loK8hZXWhXs+cujn+YJGcrpGfrB2LUEntvcylKD4wGB57Y1Uj417AKYV6N
	 48RbrpSE67LcF0Y8GJqJIBCjcY8RvzLTLG3zXOv3hAnlHdd2LIzNWiKguqsZzWCaCBSZL
	 +DHemTfhrubzh5XII4p+me+IyK0sz8tIZ9ZlxlNzYQbOKG0Rt6U1KKEJRc7JCRWF8Ww==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1791580793;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=HP4oKljIm8A1tbLIw9FD1AKYGFAbknP741VMRtCB644=;
	b=qhtWgg4/RAhRAgygx8y7o3leuy5eoZDsq4bS95TotQH+EUqKpawmD8QRhWDAn7HR8Xpk
	 4vjN030W62n672FsjOa+Oz7xyXKJnLAh9EtbCrX/EC0EMGM3iH4Pm5RJbuvaTAgcaEcQ3
	 WpNqZzCAo9SWCragz1Ui0yl4jiX7RrtX0EmE4b198aLcD+VFNkEpr2cKER2fLQ73hchCH
	 MZYFV+plzfaps3SKJtUY8ZWG6Yn9hrLyCe+nj8YxOQlTePxWFw3/guBA4nGTwsjssKqtD
	 jV9ShgeHUZfp++1eJKEUS6CUG58GDQmQ4itzoUJTWwq7TfMAhKtCO9CTfc5anSW0GVA==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="P/3HjQ/7";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com
 [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B83FEF8026A
	for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2026 23:19:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B83FEF8026A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=P/3HjQ/7
Received: by mail-qv1-f48.google.com with SMTP id
 6a1803df08f44-9178aabd30dso2719086d6.1
        for <alsa-devel@alsa-project.org>;
 Fri, 09 Oct 2026 14:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791580791; cv=none;
        d=google.com; s=arc-20260327;
        b=rsfH9XXg5rpcIbRCZq3cVYO1yv5BMjFSJfYr3KCFOugjGL7pQU0TjT+GGAR2RoET/6
         v4vC6aVzERLMwLkeCL+2efUrNUB5wgvayBVqn456KOxazZNDbfWYPA5vOv+E/33/awM7
         izuFixkRWzRzoI0PUPZ02AZvAcTqf8L/wkaw74ivhgvqWpKuENANE1P2r4wnQOZOBBKP
         uXC6jTl2X4qyDeDlXAligRCP5ENsIfKvrxnBJIQ2b2/PBudS5arF3F3pJQ8JHf/R2ewZ
         /RNkhPY0j67dUmlCWiIoZcmIJkGFOhDEf1lVOz5WnYBkWcAR1HF1PmFy7pBfCCGAlN/l
         PjeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=8PfLCZv26J4obnNs3881wTOhGsGYZus4yuq9PNPKkTg=;
        fh=Lhe1ZyQbOT2pTgUCIT6p/fyDw152gYVIDRRlqrpqGoQ=;
        b=LbYxKesvv6aXtJzbMZ/0+ONDK/WnFY9BvydOEK2JQtTCgJO/zR4OHLC5E41jZVd/Oc
         Ps22BL50jvo7SExJVXIEYAd5y7CHs+F+SvQB6B6dMiG9D0wyqWKCoYWpEQk8qqsakmuz
         WCKE5UC3DFNOEPwML40eFc2vNrcPxX1iQX0Eh0NZu/zXilWcb1EKge3yXT9Z8xbtPhgj
         Icn8AtdvfJ+q8r7a2kXStj/TYw1uNfdtLlbora1W6OhDgew3lj3jo9hxR+a0LiuLZHx0
         4U4zea1KnefdeQkpg+3W3VpuGBnfd2KeUgNdDzVtudAjl/HOPzpvTsnjyQRUZcghVLrP
         6tpA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791580791; x=1792185591;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8PfLCZv26J4obnNs3881wTOhGsGYZus4yuq9PNPKkTg=;
        b=P/3HjQ/7SKumG+OXB9DpxTyo5vzN9h/PUgxunCNR1MYT8cc3K+2A2PlXyFgC+v1S6l
         xN3psjk93FAkt8dbruhUzBxW1nPVnRoWDqEMP1yJF1xDceih9/woUc5eYPHb2ilaqO4r
         Iq+grxm7ZPL5BZ6mDHCmX9aV/tQMsEG5vhkgRLgll/Px0uqP/j/jf8YKKKGgf1Q9uITz
         sMmeSE8YywApNa+9Bp6G8DBuFbYkcnMMcXy/vPuEqS1IokuR856hRRAPEf9WijB7zzKI
         WYPeehiCAwZWedW6XezTk3Gko+30ip8UVrgU9mtIuvE8tfu4nE/C4sj1qRlX0xqP+y5p
         VfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791580791; x=1792185591;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8PfLCZv26J4obnNs3881wTOhGsGYZus4yuq9PNPKkTg=;
        b=xq1OCSbtFtWVjgXQlPBSeUKGtpzjcWkROf/UQxEjqoiJ9C4l9KVM/FSvXs2m+kYJBu
         NV3IkwVBj23isvdVaBXvysEZnWMpO1yEzD75qA8iZAW6kJ3wH+PallziW7D801TVppgh
         dKynankkv+s19UnBNzkYaUgYwXnjupT1zlQ/YUtzaePmUkWJBZntTZzj8xs0ZRoy2nfR
         SDc/NBMLqium9f4nFQfkmHiDI7E22eVd4qU1Ifqzv8crW1YEK22JNfb/yVdqbBchiJze
         nzfK6vRe9aNirc4kAzxMnlRXjDfOR0nZRAP+zJgCUn0CQEngQGYOqEYBr3zzZDpU+92S
         RYLQ==
X-Gm-Message-State: AFq9FYJX4ERQCvtOD/RiRTv7H+KS6sTJ8l8MDmPXQkoMG5Sq9eCLOQdO
	Xs29Cg9BGFY68312apDp4eBJ0wisjn9cpMTgza/eeKxQhNhiY9fJq0k+jE8kUkVJb+emjZ50lgL
	P+MBCW7Z9lvfzAkW/N0LiLQ/AksUF1CAemn0gPfQ=
X-Gm-Gg: AYBFou3AhjUQChGThfDA8Fa6U4m5xB7f5pcyN+rk8w0yHNM2wa4SN4beC95R1RaPyH5
	Lm8ulKAGVolsrrFMYlOMuUu14suimF+38lxzmxPSiG4gzyN6YnjyYHnVU9CW0iTV3hFqiQTaPIx
	mZUjfUvE488iHGtnR/uH8yPSZ8N2u80CBZhMkC0hol0Zrmqwswn2H+/yAF1hXxSmHmcSqlygEJE
	nNlqTNrLtuh3DPAVt1VgCUHo98GLzjJc1dael0eF7KqC/HLstm0d8vyILERm8m/2l0jpObutgbl
	66o32J3u2peHpiu4bADpHppYQmjBHjUu0nwDZ7jGLn3K/wTv/D6ofcU6Jg==
X-Received: by 2002:a05:6214:328d:b0:91b:5d3b:4abd with SMTP id
 6a1803df08f44-91b5d3b4da4mr43259836d6.50.1791580790626; Fri, 09 Oct 2026
 14:19:50 -0700 (PDT)
MIME-Version: 1.0
From: Alex James <igotmysoul@gmail.com>
Date: Fri, 9 Oct 2026 23:19:39 +0200
X-Gm-Features: AclHuK9x4w1zNOPCZuvfOG5Pk6eXxx-M5Iw5o-lzQdKvMsi3uw9SttYodrL7eAE
Message-ID: 
 <CA+YQcmcUKi98dKYRWjg8MR6hQoxoOEvXAuSDLgUUVK-L=ge7JA@mail.gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix internal mic capture on ASUS ROG Flow
 Z13 GZ302EA
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: igotmysoul@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DAGOGROEE4AURIRASZ2SDFIPTEINVOYI
X-Message-ID-Hash: DAGOGROEE4AURIRASZ2SDFIPTEINVOYI
X-Mailman-Approved-At: Sat, 10 Oct 2026 19:41:36 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DAGOGROEE4AURIRASZ2SDFIPTEINVOYI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The ASUS ROG Flow Z13 GZ302EA (Realtek ALC294, SSID 1043:1fb3) exposes
two fixed internal mic pins, 0x12 (0x90a60140) and 0x13 (0x90a60130), as
capture sources "Internal Mic" and "Internal Mic 1". The input mux
defaults to 0x12, but on this model 0x12 is defective: its right channel
rails to -32768 and the left channel carries heavy noise, so out of the
box the internal microphone records loud noise/hum.
Pin 0x13 captures clean audio on both channels (at lower level). The
mic array is not reachable through the AMD ACP70/PDM path either: forcing
it on via ACPI _WOV=1 creates the dmic-codec device but all samples rail
at -32768, so HDA is the only usable capture path.
The existing quirk for this SSID only initializes the two CS35L41 I2C
smart amps (speakers). Disable the broken 0x12 pin via pincfg so that
0x13 becomes the sole "Internal Mic" capture source, and keep the CS35L41
initialization by chaining it in a new fixup.
Measured on a GZ302EA (arecord, 48 kHz S16LE, identical gain):
  pin 0x12: L 47% clipped samples, R 15% clipped (railed noise)
  pin 0x13: <0.3% clipped, hum components below -65 dBFS
The fix was validated on the target hardware without building a kernel
by applying the same pincfg override (0x12 -> 0x40000000) through a
boot-time HDA patch firmware (snd-hda-intel patch=). With the override
the codec parser drops pin 0x12 entirely: the card comes up with a single
"Internal Mic" (0x13), the Capture Source mux control disappears (single
input is hardwired), and capture is clean and stable across boot,
suspend/resume, and PipeWire/WirePlumber route re-applies. Note that a
runtime hda-verb override alone is not sufficient because the bus driver
builds its pin cache at codec registration.
Also observed on this SSID while testing: repeated
"ALC294: Invalid fixup type 2016568172" messages in dmesg during probe
with the current quirk; likely unrelated but worth a look.
Link: https://github.com/CachyOS/linux-cachyos/issues/880
Tested-by: aic0d3r <funforfreeapps@gmail.com>
Signed-off-by: aic0d3r <funforfreeapps@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c
b/sound/hda/codecs/realtek/alc269.c
index be54825..20b5c82 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4219,6 +4219,8 @@ enum {
  ALC294_FIXUP_ASUS_ALLY,
  ALC294_FIXUP_ASUS_ALLY_PINS,
  ALC294_FIXUP_ASUS_ALLY_VERBS,
+ ALC294_FIXUP_ASUS_GZ302EA,
+ ALC294_FIXUP_ASUS_GZ302EA_PINS,
  ALC294_FIXUP_ASUS_HPE,
  ALC294_FIXUP_ASUS_COEF_1B,
  ALC294_FIXUP_ASUS_GX502_HP,
@@ -5889,6 +5891,19 @@ static const struct hda_fixup alc269_fixups[] = {
  .chained = true,
  .chain_id = ALC285_FIXUP_THINKPAD_X1_GEN7
  },
+ [ALC294_FIXUP_ASUS_GZ302EA] = {
+ .type = HDA_FIXUP_FUNC,
+ .v.func = cs35l41_fixup_i2c_two,
+ .chained = true,
+ .chain_id = ALC294_FIXUP_ASUS_GZ302EA_PINS
+ },
+ [ALC294_FIXUP_ASUS_GZ302EA_PINS] = {
+ .type = HDA_FIXUP_PINS,
+ .v.pins = (const struct hda_pintbl[]) {
+ { 0x12, 0x40000000 },
+ { }
+ },
+ },
  [ALC294_FIXUP_ASUS_HPE] = {
  .type = HDA_FIXUP_VERBS,
  .v.verbs = (const struct hda_verb[]) {
@@ -7937,7 +7952,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
  SND_PCI_QUIRK(0x1043, 0x1f62, "ASUS UX7602ZM", ALC245_FIXUP_CS35L41_SPI_2),
  SND_PCI_QUIRK(0x1043, 0x1f63, "ASUS P5405CSA", ALC245_FIXUP_CS35L41_SPI_2),
  SND_PCI_QUIRK(0x1043, 0x1f92, "ASUS ROG Flow X16", ALC289_FIXUP_ASUS_GA401),
- SND_PCI_QUIRK(0x1043, 0x1fb3, "ASUS ROG Flow Z13 GZ302EA",
ALC287_FIXUP_CS35L41_I2C_2),
+ SND_PCI_QUIRK(0x1043, 0x1fb3, "ASUS ROG Flow Z13 GZ302EA",
ALC294_FIXUP_ASUS_GZ302EA),
  SND_PCI_QUIRK(0x1043, 0x3011, "ASUS B5605CVA", ALC245_FIXUP_CS35L41_SPI_2),
  SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
  SND_PCI_QUIRK(0x1043, 0x3061, "ASUS B3405CCA",
ALC294_FIXUP_ASUS_CS35L41_SPI_2),
