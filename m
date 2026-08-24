Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5070C5DF94
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:46:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC54360252;
	Mon, 24 Aug 2026 13:46:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC54360252
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787572013;
	bh=9gLI5Y+3DvSb/48gHU+W2mTCk+Dw+lsjDsElHI/OJp8=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=JoG0ycPUXjKblBPu85VXxjlaquC4kOKTs2mMjbzlU0VWyiR4hlW5ZZOzCEe0wSQNy
	 VKEMHe1wCoh6adU8IRA6LWLmfbaPLl5Ot7pX3iHEqiwJ7IbgKuFtCKDI5et01hExnX
	 5GmZFLrgG0e1EA2ZFCGHzUAap1Z+Z7/OrkDl/n90=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0B865F80683; Mon, 24 Aug 2026 13:45:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 59C0EF80688;
	Mon, 24 Aug 2026 13:45:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68EFEF805A8; Mon, 24 Aug 2026 09:56:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1787558167;
	b=K4xPXtWIfxF7mEZWXF5t2Oy8GfZnvqd6zKlSaL3Ao+VR3k9Pget1IincBRuxTTTUXEDm
	 WTWb/0cSF70beBTR7gCFbs+7EIQ8Rv7P/nL1edeO6Q02M1wxphE9GVnbHn8UNv8F/Obbi
	 ZtjExgd7Fid4pV+sVwbP5IpetLLfLCVRFDbYl9WPzq4fU3B+frX62896qJmSYe0Xpu0oN
	 XxFZt/Uit6YNol+1XugwG8ROc5/y4aCq6SOVSbec81Fw6E5EtJ9anpLf9Yu88LygNB9L3
	 9la5lfuB+O/TiRFPrjUh0QiXrrK2+UVE+JeFIFXji3RKaUKr+SBOs2NFZSYtPKg2VJw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787558167;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=9gLI5Y+3DvSb/48gHU+W2mTCk+Dw+lsjDsElHI/OJp8=;
	b=bbLNMOJlCJYqtiKxm0AlhNy+KQSE0gr+niaRXl0mHr7DjBsiufuVKTs5VGdWKtps1jmh
	 y/ee/1LaL8qlyq89d6FIDWge90QoMxhuQkfR4tFPUX9kQtRXP6KRxNtmaHYC28n9GzgUb
	 pmhE+cB8BWmd5VXsEimLlG6WHXNc6ahvQxA803wTEHxRAnzA2nyJjGGNRiSw5npjZeBYx
	 2va1DzK/bE7aA5Uz5rNtyHeB4Ypn1N//F6ceKJnlCgSMAk5eWfUZ+ngO2xonjpRnh0Kka
	 9x//iBmRojzRfwzfoDvAfqXmqoDzjPvAXNUo1gzmBMt1ala7yoFr6/vWZJPyyCcMEYQ==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qr2PMeMM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.42
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CE0A3F80075
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 09:56:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE0A3F80075
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qr2PMeMM
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-66d07ddf077so909087d50.2
        for <alsa-devel@alsa-project.org>;
 Mon, 24 Aug 2026 00:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787558164; cv=none;
        d=google.com; s=arc-20260327;
        b=HZtguP7o8Yj4WM+0rYxEbYrG0f9XQ7SXLcqtaJ6as2J4Q11bL4OJIO885iGF7TyZi+
         9dk7HejmK8ma3BsVMpmNsNvNljXjV9p0C/EQadfqIGvvoJO3UwFaO2P0UMCNJFHNyqCc
         mdvlt/i6Mkl54PROnd0DMh2NYJsBCbaHzRihqVeefFvbne2kxVj3AUdkbfptOWM9tqfq
         w32iyIYtvJmpwTmi5cFq/Kvcot2xkyRjahBiYMVOw68r6tRz9iPE3WF4+7H7n8tj71DL
         lC+UBvEp0RfogFcQxtOKngkdw5zPrHsSNee8FY0BDIwvIh07mYhy5Ntw0OVfSet3jHKg
         dnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9gLI5Y+3DvSb/48gHU+W2mTCk+Dw+lsjDsElHI/OJp8=;
        fh=dBSINSrh+dZtWEP0pR2323P8G/MRu1im4fhQaZzZhOY=;
        b=bbNyxbJd8yWbWNPPfS3FcoPoMQFhAS0O2bp7EB47s9QLA+iStYSB4wvX89XwKnX0Iu
         RYruJXHWXjCnP+x/jTbW7h8T2DS1+qzdYnUTu7ojMQH+QwODzSvbg1Sj05C45uW63hiA
         tyX+Fv/gL4LeMMt5cHB+Od4QtpcDdsimO+NpGkMmT8sqSETSy+K0S1Lr6rCHokB3KPe4
         roRDK985uiWW0IpHAz9TqsDdQZHC1TntrdYDASUzA3FbY4ii3LQzQfsEO8MwFdg+fnh8
         9qSJkQBFwBY1kawBqjKOiA0CrzekYDLj+bu3OABU7s9YgIXyuaN+Ff8/MA4VsTbY7f0P
         YoFQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787558164; x=1788162964;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9gLI5Y+3DvSb/48gHU+W2mTCk+Dw+lsjDsElHI/OJp8=;
        b=qr2PMeMM4YrFNbNlAn654MAW8u11wH90RrUQ3sJn6S98Ps6g8CowkPvizKlKdadknj
         8AtheN2tYkPOhy1suzoMwO5/IpSDv0w6P/F10jS73Zz0lPmlSqEsB88q6T7iKS5AieBu
         ZffbueZXclDgRfPD6uF8/GyOkx9jMIFeZPn8LjopV7IxkPnzwz0EkZAcNa7rE9EXXGgd
         FXHbC2/SMFtzyV4DZ9RgvarFBBUZCar9vLhWoeqV44rm3nY+KOAIUVsHd8jm8iAIn7Wz
         P1SpmP6dkTVfTnVQePbXjlzD+Nx2VTZeg5FDGqnF31iTAEXCI38EZc4X5PDXwJPGRNXk
         sJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558164; x=1788162964;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9gLI5Y+3DvSb/48gHU+W2mTCk+Dw+lsjDsElHI/OJp8=;
        b=rQ49QN6pdBxBr/SZkDtYb5m3cYQiCUxbpnn/RNpoYVTe7CM2cH9bSGGA5lP0AWQDBD
         b3khc2LjtZ/KYNX9sLkM+WM+13VU33rKG1qU1FWwyq8F5GOGuTH+eGbkuiFFIdW/i9Ko
         7GQV8vwBmg4HCC2uuyMSKTNkP3eGsQaXmxiOshRK6/08f2lXZAKPuT3ML8t3/LGBJRvz
         q8SLS39MQEgDLS7LcB5+KTSIn1N+y64k1HSMzwnKD5ZVQPolayto4c8x/n6YYwDQfN3L
         IvgIQfRWJ5JMC9BxUXmeUu30ZdJtrNQPEVXgW796bXBUKmQ5CiI5H505ZPNP/Q4LsZak
         hakA==
X-Gm-Message-State: AFuF++nRwH9pOwUjgSDydcj1ELgqiRhE5cG4UnOQlcJmiyFb1FlWelWt
	P8ogK4pjwifVhiUfBtGNASF3UyVP/nHGdtP3iMcU53ktz8nVxmqmqj71DKMeTD3b2RJFXtmZxo3
	AgQk/Jzz+SzpA7R7cAY3GNcR3o9nbDLvosyfQ
X-Gm-Gg: AR+sD12ZX4T34qWpJI1mt8owBveBjwgHEgiiEhhtdrBXVqWhgUmx3jYAP4kCwfuRoyi
	pcF1LsqLCrm4unO+nydb78KxgaIQH0JprN1L6WKs6b8/p9FHT7ZPwlnnZJKmDUBoTaO0y1y0L+t
	1H6T0RnUU/0+0TKIeuY/fnBIjcY4bc9OD1PAG9WOvoxF2r7HKAiLIrBRnwWhPG/kC3pkqojvue7
	Wnm96cX4FeG9rIKoWvaNbXXNXn7TAJLpyMtE8lZxMfKLM0twyFuiSUGU67uRMG1+UP0tAj039Jr
	LHRyqQRx5IV9WgL4qtCdl6sA6cnvr06qxTefyG30xCih
X-Received: by 2002:a05:690e:bcd:b0:66d:b14:842e with SMTP id
 956f58d0204a3-66d0b148b2fmr743303d50.28.1787558163997; Mon, 24 Aug 2026
 00:56:03 -0700 (PDT)
MIME-Version: 1.0
From: mmmp l <fxxkyouhacker@gmail.com>
Date: Mon, 24 Aug 2026 15:55:53 +0800
X-Gm-Features: AcwNN1WbNCWgB0WlrtxPInsr6gCiGHdTIcCsYuaBpWtd0sn9zZqmyUhq_USQNTY
Message-ID: 
 <CAE4UKs-HaCjQiO=TG1qBeNcornyWNq4GoQcnjFM0wwtRHtQ8BQ@mail.gmail.com>
Subject: ALC257: no internal speaker or internal mic on ThinkPad X14 Gen 1
 (17aa:513d)
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: fxxkyouhacker@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: UOCPDIEAZMT3UO5QHNNQ3MKAG45C2TLR
X-Message-ID-Hash: UOCPDIEAZMT3UO5QHNNQ3MKAG45C2TLR
X-Mailman-Approved-At: Mon, 24 Aug 2026 11:45:39 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UOCPDIEAZMT3UO5QHNNQ3MKAG45C2TLR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

The internal speaker and internal microphone do not work on a Lenovo
ThinkPad X14 Gen 1 (Intel Panther Lake, Core Ultra 5 338H). Headphone
output via the 3.5mm jack is not affected as far as I can tell, and USB
audio works normally.

alsa-info:
https://www.google.com/url?q=https://alsa-project.org/db/?f%3D9c878be2a4f3e5bddcd7179c67fec9f4e2b11068&source=gmail&ust=1787644380800000&sa=E

System
------
Distribution: Fedora 44 (KDE)
Kernel: 7.1.9-200.fc44.x86_64
Codec: Realtek ALC257
Vendor Id: 0x10ec0257
Subsystem Id: 0x17aa513d

Symptom
-------
No sound from the internal speakers at all, including a direct
hardware-level test that bypasses PipeWire:

speaker-test -D plughw:0,0 -c 2 -t wav -l 1

produces no audible output. Recording from the internal mic likewise
produces nothing.

Relevant dmesg
--------------
snd_hda_codec_alc269 hdaudioC0D0: ALC257: picked fixup for PCI SSID 17aa:0000
snd_hda_codec_alc269 hdaudioC0D0: autoconfig for ALC257: line_outs=1
(0x14/0x0/0x0/0x0/0x0) type:speaker
snd_hda_codec_alc269 hdaudioC0D0: speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
snd_hda_codec_alc269 hdaudioC0D0: hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
snd_hda_codec_alc269 hdaudioC0D0: inputs:
snd_hda_codec_alc269 hdaudioC0D0: Internal Mic=0x12
snd_hda_codec_alc269 hdaudioC0D0: Mic=0x19

Note that only the vendor-wildcard entry (17aa:0000) is matched; there
appears to be no quirk entry for this specific SSID yet.

Things already ruled out
------------------------
1. Auto-Mute. `amixer -c 0 set 'Auto-Mute Mode' Disabled` makes no
difference. All relevant mixer controls were unmuted and raised.

2. Codec GPIO. Both are zero, so there does not appear to be an amp
enable line on the codec:

hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_MASK 0 -> 0x0
hda-verb /dev/snd/hwC0D0 0x01 GET_GPIO_DATA 0 -> 0x0

3. Existing model quirks. Tried model=thinkpad,
alc269-fixup-thinkpad-acpi, alc257-fixup-thinkpad-acpi, alc255-acer,
alc269-dmic and alc283-sense-combo. None produced any output.

4. SOF path. Forcing snd-intel-dspcfg dsp_driver=3 successfully boots
the DSP and loads topology, but the speaker is still silent:

sof-audio-pci-intel-ptl 0000:00:1f.3: hda codecs found, mask 5
sof-audio-pci-intel-ptl 0000:00:1f.3: using HDA machine driver
skl_hda_dsp_generic now
sof-audio-pci-intel-ptl 0000:00:1f.3: DMICs detected in NHLT tables: 0
sof-audio-pci-intel-ptl 0000:00:1f.3: Booted firmware version: 2.14.1.1
sof-audio-pci-intel-ptl 0000:00:1f.3: loading topology:
intel/sof-ipc4-tplg/sof-hda-generic.tplg

The NHLT tables report no SoundWire links and no DMICs, so this does
appear to be a plain HDA machine rather than a SoundWire one. I have
since reverted dsp_driver=3 back to the default.

5. /sys/bus/soundwire/devices/ is empty, consistent with the above.

I am happy to test patches or run any additional commands. Please let me
know what else would be useful.

Thanks, Yutao Ma
