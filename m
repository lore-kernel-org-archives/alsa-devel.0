Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF73C61DCB
	for <alsa-devel@archiver.kernel.org>; Fri, 28 Aug 2026 17:29:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C425E60203;
	Fri, 28 Aug 2026 19:29:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C425E60203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787938155;
	bh=yzqphP/MXR30DMoibzWP6OgM1V/p+2U1jZEpO+H878Y=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=E/70Wj0fjxFyalK1rbyxNJr1ijSkPe1XwBpOVZfDsLwzSWV2FxEzVX5gApZfyb9XO
	 hIO+4Wt+ctpImSLCZ+izGtRAkxorTNwC+rIpfwbDFIoIoVRncuSP0XjnnomDT57jnQ
	 objHV/wPY8A1QZyLrt96NbMT25UDPSuWj++gM7bk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1861EF805FB; Fri, 28 Aug 2026 19:28:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C9FCFF805EF;
	Fri, 28 Aug 2026 19:28:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 188FDF8055C; Fri, 28 Aug 2026 19:28:35 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787938114;
	b=YMKgZ4Au9uRCt82DIcrwEuuKWNRVE0yJyFgQYIrox8mee6it+Tn6ypaE889dl7hbNGWt
	 nQ6bSSY38nQyF/ksp+w8dyzhWfzX4zsJJ+0BF6S9nNd/sVf5yZgPU4td3Vmxd6NjnI6zS
	 S2CGlIM5qbJ+JtlPmV8nEorPhkEECDWOd/YGjXEXwuCwqBr0zE9JQ9C01IER1ANNHB19E
	 mzpLKPrIJ25fHyqcZcbvThjAnuZ2ieRu94VghbIK+p6JJkDawaUF0gTMgWWbFXwMvIKrN
	 AuVseahSKrKevoIhToyHEmvlokA9i/EBc98Pr7nRlhmuU7R2vL1Cartoxab///DhDGg==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787938114;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=yzqphP/MXR30DMoibzWP6OgM1V/p+2U1jZEpO+H878Y=;
	b=g+zjVOHh225DDrGcHVWu1OMfmE6Nf19zygmZeEt/8vxQxxEM3tzuJNaTteQSb1Pr1lfP
	 u3zmRghkhMj8wLtt/vuEia6GZ3MdphozjQE/nzw6Ug1VDK1hPZHl/s/VLaPDMTeLeYmPF
	 MENiEDRqrYwVPd/fgfXUxjNYBLQMlTj24tptzHg7OMZXrdbpuRJF0ElP3J33Ser8aJE04
	 epzczrv+UXkwn6IEIbYHxreqW8UdF0xLW59+e4wCPFw39CFRt6KObsvx55+hLq3o3Pq3Q
	 PDR8n8AZh1Iusyxt2cvSDnirQ5LtHpNvzFwrWCD6q0pBBnEfaJK60u0N82vEoB47BGQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="J/B7nysW";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com
 [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1FC9F80272
	for <alsa-devel@alsa-project.org>; Fri, 28 Aug 2026 19:28:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1FC9F80272
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=J/B7nysW
Received: by mail-yw1-f176.google.com with SMTP id
 00721157ae682-81ecf499af9so14912807b3.1
        for <alsa-devel@alsa-project.org>;
 Fri, 28 Aug 2026 10:28:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787938110; cv=none;
        d=google.com; s=arc-20260327;
        b=B5JWQbOt7tJogMnbbaHrYQQspAifI2oKnGBaMYoeB5ii/hSE/Iil+6BlJ/FwoGzfbD
         Ml7QVwFAXZEyusx4Ol/QKRxbeewoU1Nlj3quQU3g7h8nvtQL1GkgN/8j9Hzl80zT2Ta+
         4hycSyP5gndR9RM7ki+xBuBgfqxhij0wyu5InNBd+sMQGQnEizQVpZHqNp+m8FVytZxg
         07yDy5CJBCRVs3e9Vy01M02oDV5FpmfWu9PIjeGqkkhGpgls5TDyW6IptWEnKgRI/BiM
         vTDn+0AG/Z3as1/k+jBzXHu+hUOMnQU8R1Rae3Lyg6NDHRdMPYBjHsHb1nNVRLFyhrb2
         ImHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LLSwBtZheV2MAMzKDLDXh05bWeL+hmfW00dB9pa8gJo=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=ZoBSO5aBSj+FUyisccKCuHRLhZduMbVAubORQv0PQTbn9DIi0FBuxpTwcGU4PrYbky
         4y702kYk42lmLlFwKCRHTM8SOSrD0TWRnkg9TpaLMzK6JaGQ5mdE8DxPBkDcdJ1hxbIq
         n1fdSOMqVRB0kSyqCdK4UcY6/RT6H5tOo+1oDoaY1+nOLZ3lqhBPrSfJx7dCH8DTWbOC
         qVjIu2M7GXph0xDqgMxPg/6ZHX6Gz1Krohn9CXaBydCK4M1/w8hA7L95SXPdLhJaJX22
         eh8XqAH5GHXMiPNyZFt+4wWF2Q/Bp6JpX+wdqWQhihhCT3de98MOxJIh/FUnBZt2LbQK
         cZUA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787938110; x=1788542910;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LLSwBtZheV2MAMzKDLDXh05bWeL+hmfW00dB9pa8gJo=;
        b=J/B7nysW1i9tb4m2ukISkRzSQ8Yat7tthymTn/Bdc3CyclkqbOTGanKyYaXbAB3PeR
         pIADZkPXY98pB58vg5pHECnP0Hs3mlD+teLq6J6YTX9daTc1sbBut4LO0TWEYAD/KHIp
         /ol5uEkatIJSKANihCa1lCrRk7VDCxj3r8kUfrx4U0MpHUF70Ktiv0VEChK5OuEM5wDB
         DF0eVyTvhc+N560ZDeCFNIyi+iRnBaomnFkySC9aFAuqSiLhDfev6ZqzIYaqDEj67xcP
         psCbo8KA8S0KlZhcsPDGi/GLS2ujAQ+PH/TDybJVLo1tdgCAIz4pXFFKKC4wF1gugf0Y
         sufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787938110; x=1788542910;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LLSwBtZheV2MAMzKDLDXh05bWeL+hmfW00dB9pa8gJo=;
        b=KctJTznE7LOrlnKK2oX72ko41uOeu9VdsGc6B4wzv4cIhj1qiL41LcnoyoxAM4rolt
         3OIPaXC9t4iyT6ZM1zxUMm5LVvoqa250/caVmEyiq3Ae83JknkOkekpFYGfgvAH2OwKy
         btBdP1eQ4UWb11SfjumTTqIZoxCaokCYi+5fZc5T7O+VA+o/4jaxB4ZzLJTHbKXW+/6G
         m3cpNL6fZum2RIlN0/zMG5i3reV3ehQVZcGDvMX2uUWLxdxqTsH+cwqRPy7IXnxi5b59
         5Od9PFjcxYa5dbkAgtw3DVsRsHVQ6Qh2MKSB9P4tIaT0Ib/ZkS9zfXq6ROq2jGLEow8z
         FzSw==
X-Gm-Message-State: AFuF++kM92ZznhJ91Tsaey6K5/nw/FxObXfuONnaR3yqVDG1mmFgBdQW
	OcF8I43ZQU5yprvSPe3uDZadSxF6TONfCsOzxVIk2+zDZdK92JRoSJk1M2a/RAbtbm6Q1MzPPFB
	Mf1lPht3Bg2uvUpntik35+IxFIEmooDp699sDD/k=
X-Gm-Gg: AYBFou19iRJgHaGJmrRb8pM9iagmJo2m1ygz9796MA1JBTUhZboRZvpPBbUGNHuJe4Z
	6ZD9r7FPcA7gurf4AjVckqkhd+K5QLARXJ1HXYAVERs9CAbkIIgDg62oUt0WJcRgkpm92W9XeVa
	SVPtfNiMQS0d5jQ37uHagGBQLqSIkVhi0TtE0PHflewVhgCtuQH8wy4+eiDqgmWIJZZU7aQ2Pi7
	nwPlg20FXHiNDWy3fqTJRjekaGvhUHcnZ3+gK4ZaCxwGN81GP5RhHRVEXGjH/6V+kknKbvg71Fg
	9AbVPwhaRLsCKBHjjINUAXFQO8avnzNLZi0fTKITgliI
X-Received: by 2002:a05:690c:e286:20b0:80d:c2cc:f673 with SMTP id
 00721157ae682-85d6a2e17famr29059127b3.20.1787938109762; Fri, 28 Aug 2026
 10:28:29 -0700 (PDT)
MIME-Version: 1.0
References: 
 <CAE4UKs-HaCjQiO=TG1qBeNcornyWNq4GoQcnjFM0wwtRHtQ8BQ@mail.gmail.com>
In-Reply-To: 
 <CAE4UKs-HaCjQiO=TG1qBeNcornyWNq4GoQcnjFM0wwtRHtQ8BQ@mail.gmail.com>
From: mmmp l <fxxkyouhacker@gmail.com>
Date: Sat, 29 Aug 2026 01:28:18 +0800
X-Gm-Features: AcwNN1UMmNsqFWtqwk6-4YkH-Zd6-rszIs90QUXXDNAgJZLcShBs6yGvM1PF8Pk
Message-ID: 
 <CAE4UKs9a1515EGZ8FA=OEqK5RF7p0tPKPm4Cwz04i8U6K39n7w@mail.gmail.com>
Subject: Re: ALC257: no internal speaker or internal mic on ThinkPad X14 Gen 1
 (17aa:513d)
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Message-ID-Hash: IX35CVXVWSWONPK63XOGHF5KFHKSPIH3
X-Message-ID-Hash: IX35CVXVWSWONPK63XOGHF5KFHKSPIH3
X-MailFrom: fxxkyouhacker@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IX35CVXVWSWONPK63XOGHF5KFHKSPIH3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Subject: Re: ALC257: no internal speaker or internal mic on ThinkPad
X14 Gen 1 (17aa:513d)

Hi,

Follow-up to my own report: this is a firmware defect, not a codec quirk
issue. No kernel change is needed. Sorry for the noise.

Root cause
----------
On the ThinkPad X14 Gen 1, bit 0 of Embedded Controller register 0x3b is
set at cold boot and nothing clears it. It gates the speaker amplifier.
That is why the codec looked entirely healthy -- pin configuration
correct, GPIO mask and data both zero, no SoundWire links, no DMICs --
while direct playback through plughw:0,0 stayed silent. A suspend/resume
cycle clears the bit as a side effect, which is the giveaway I missed.

The offset was originally identified by:
  https://github.com/hasukuyuki/Thinkpadx14-gen1-speaker-fix

and there is a DKMS kernel module implementing the workaround at:
  https://github.com/RockLakeGrass/thinkpad-x14-speaker-unmute

Resolution
----------
Lenovo fixed it in BIOS 1.10; the firmware now clears the bit itself.
After updating from 1.09, both the internal speakers and the internal
microphone work correctly on this machine. Anyone still on 1.09 or
earlier should update the BIOS rather than patch the kernel.

The same symptom on the same SSID was reported earlier here:
  https://bbs.archlinux.org/viewtopic.php?id=3D313510

I should have found that thread before writing to the list. Apologies
for the wasted attention -- I am leaving this reply in the archive so
the next person searching for 17aa:513d lands on the actual cause.

Regards,
lmmmp

mmmp l <fxxkyouhacker@gmail.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=B8=80 15:55=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> The internal speaker and internal microphone do not work on a Lenovo
> ThinkPad X14 Gen 1 (Intel Panther Lake, Core Ultra 5 338H). Headphone
> output via the 3.5mm jack is not affected as far as I can tell, and USB
> audio works normally.
>
> alsa-info:
> https://www.google.com/url?q=3Dhttps://alsa-project.org/db/?f%3D9c878be2a=
4f3e5bddcd7179c67fec9f4e2b11068&source=3Dgmail&ust=3D1787644380800000&sa=3D=
E
>
> System
> ------
> Distribution: Fedora 44 (KDE)
> Kernel: 7.1.9-200.fc44.x86_64
> Codec: Realtek ALC257
> Vendor Id: 0x10ec0257
> Subsystem Id: 0x17aa513d
>
> Symptom
> -------
> No sound from the internal speakers at all, including a direct
> hardware-level test that bypasses PipeWire:
>
> speaker-test -D plughw:0,0 -c 2 -t wav -l 1
>
> produces no audible output. Recording from the internal mic likewise
> produces nothing.
>
> Relevant dmesg
> --------------
> snd_hda_codec_alc269 hdaudioC0D0: ALC257: picked fixup for PCI SSID 17aa:=
0000
> snd_hda_codec_alc269 hdaudioC0D0: autoconfig for ALC257: line_outs=3D1
> (0x14/0x0/0x0/0x0/0x0) type:speaker
> snd_hda_codec_alc269 hdaudioC0D0: speaker_outs=3D0 (0x0/0x0/0x0/0x0/0x0)
> snd_hda_codec_alc269 hdaudioC0D0: hp_outs=3D1 (0x21/0x0/0x0/0x0/0x0)
> snd_hda_codec_alc269 hdaudioC0D0: inputs:
> snd_hda_codec_alc269 hdaudioC0D0: Internal Mic=3D0x12
> snd_hda_codec_alc269 hdaudioC0D0: Mic=3D0x19
>
> Note that only the vendor-wildcard entry (17aa:0000) is matched; there
> appears to be no quirk entry for this specific SSID yet.
>
> Things already ruled out
> ------------------------
> 1. Auto-Mute. `amixer -c 0 set 'Auto-Mute Mode' Disabled` makes no
> difference. All relevant mixer controls were unmuted and raised.
>
> 2. Codec GPIO. Both are zero, so there does not appear to be an amp
> enable line on the codec:
>
> hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_MASK 0 -> 0x0
> hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_DATA 0 -> 0x0
>
> 3. Existing model quirks. Tried model=3Dthinkpad,
> alc269-fixup-thinkpad-acpi, alc257-fixup-thinkpad-acpi, alc255-acer,
> alc269-dmic and alc283-sense-combo. None produced any output.
>
> 4. SOF path. Forcing snd-intel-dspcfg dsp_driver=3D3 successfully boots
> the DSP and loads topology, but the speaker is still silent:
>
> sof-audio-pci-intel-ptl 0000:00:1f.3: hda codecs found, mask 5
> sof-audio-pci-intel-ptl 0000:00:1f.3: using HDA machine driver
> skl_hda_dsp_generic now
> sof-audio-pci-intel-ptl 0000:00:1f.3: DMICs detected in NHLT tables: 0
> sof-audio-pci-intel-ptl 0000:00:1f.3: Booted firmware version: 2.14.1.1
> sof-audio-pci-intel-ptl 0000:00:1f.3: loading topology:
> intel/sof-ipc4-tplg/sof-hda-generic.tplg
>
> The NHLT tables report no SoundWire links and no DMICs, so this does
> appear to be a plain HDA machine rather than a SoundWire one. I have
> since reverted dsp_driver=3D3 back to the default.
>
> 5. /sys/bus/soundwire/devices/ is empty, consistent with the above.
>
> I am happy to test patches or run any additional commands. Please let me
> know what else would be useful.
>
> Thanks, Yutao Ma
