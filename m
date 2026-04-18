Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4ACEF99C90
	for <alsa-devel@archiver.kernel.org>; Sat, 18 Apr 2026 19:59:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E480B60215;
	Sat, 18 Apr 2026 21:59:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E480B60215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776542372;
	bh=rN0rCz67QdG2jhAVzl3/13MZcZfoqt8FbqTTiRbeLbk=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=EHvTsDB0ZMIe2AeQy6sk0+Wykrwq7xHIUFEdyZk7NLie+YBHbPQzm/M1xCwyDHxJw
	 wcr3IVQ0SwQLcSSDh4JfAXtUNMHIe9VU9yW5bdi91y/O55rWcAOO/WidahFxKLzR75
	 YXNFu2hgN2QCKn2KyzW2SMa57eP24lHGm6nJCcpM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CF547F805EF; Sat, 18 Apr 2026 21:58:57 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E1F6F805E7;
	Sat, 18 Apr 2026 21:58:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5C8F2F804CF; Sat, 18 Apr 2026 12:57:11 +0200 (CEST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 558EFF8024C
	for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2026 12:57:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 558EFF8024C
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IlAZWTgp
Received: by mail-qk1-f176.google.com with SMTP id
 af79cd13be357-8d68f702851so196876385a.0
        for <alsa-devel@alsa-project.org>;
 Sat, 18 Apr 2026 03:57:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776509827; cv=none;
        d=google.com; s=arc-20240605;
        b=BzScwe/Julsoj1fN3xLlIAI+41iPYdzRy0Mn4dtQhLu+qPzAFqAkTTqJQ5dvtmNuQX
         UAdVniW66f9e22XEutKXsbqX2ER1KnWLzypiSbVBx/hUdjA7eZvRjxlLuuELBNr8m7He
         pN+m7FeqezWH/WMzTTeADwAJKLHQhMZtYtmJN3Qa8aVyg4JLu/wT4avae+GToz5SWPG8
         X3yPvouZvmM+O6rhyJ8IF4eEnUol+ff0GU7cMDdxpc3R8fHUBjy5HZp/fWQGMEOAtIbm
         v5ojXIc9zdK7YyacGympVb6x2aV4bcqXDyoTI4+XE0CSY4RrPzLGGs8iEGdWaUCLw/bb
         6pCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jIwYJqa08VJEV3K596gVFxVWx4Ul9UaRbzeJJTtC9Ns=;
        fh=IU7OLltWMHrWih3TQesDjxbAKgN6R6ysHYXT2Tj3Ang=;
        b=YrhJRUtwCzCOJgnLIgpppYlS+nBOcAYa9DtNsMYNZ94zmQeKUtlVfsx/ZK2WFA7jwC
         AiyMozsgu1jVKRH78TSwGbn/P1CEZWQxPtif2vA9XXmlRDuKMux00k7c+eBtpre08p2d
         RlaFtAPtEqI9451HBe8DWgJaVRkSRDhURaGFyU9crtW+9KwcofAWmEnp5hkO8dJUn0BQ
         +AxN9+t4U+hGJ8SbrM/uqEIiAMREUyaP0MPXJ4/dKZjVFclQBXnhdwGa89PoLxFRPwn7
         aWVMB/T+ozptCuLdKPAtm4v5zfelMpQh9YQmTASS2ekGoi/vkQzkFd1wN0Utp5AdN9cl
         bXAA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776509827; x=1777114627;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jIwYJqa08VJEV3K596gVFxVWx4Ul9UaRbzeJJTtC9Ns=;
        b=IlAZWTgpeb3Mj1ZpHqo2f8netmIAILwVLU/zrGN8ismx1spPZY0I6+m5vrtgLgcxIc
         DCgKU8/UfxPX6y9QsHQBHX2aH10EmK2YOPzFD1btCesHGRnHDl+KVR5bynrdMG/rxgDW
         tgA//xvlIeIbAAFMoX4Dmd4PEOPiO4vh8Ere9v3LCNKthtp+rrHP7esOhvUTrBDAM0C8
         fJWw1lHuNB9PptuJsaBq3vn+86D0yteQrdu9ju2VVklSlzKRGMrupqevOZV6Es71LyLz
         g/TFIdx/ZQJIHmAd39J2XFUqxjvtfhfNrKqwgUP8FgGmwALIu2WxPgubH61J3zRz2ZrR
         vM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776509827; x=1777114627;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIwYJqa08VJEV3K596gVFxVWx4Ul9UaRbzeJJTtC9Ns=;
        b=Ut9a+SCBuZdgsiZsqVi8QqUu4xceqK3lobJDp4MTevEzNsJsM7bvOhC4EheQa7CL5A
         1LQmn8dLA2wTbfPBFv3mF73xTwF0K/ylJgMwm0YwoALsKFtL9r4/b1QT6q1II2Uhm+HJ
         GYCsOxBRWlol2pxjWfD3hyiDdpDoNOpkgtSHcLhY161Rz8/R44Lj7HpA3xhZ4vC6soit
         YQ94+LrrWDQU1AkczI+wcPPu48+HI0l+deaiUdvFjl1qUj2TzDwQfV7HzxCeTG5Fq6Jm
         wcEqCDAaPNNQcmRMLdOjVpTNQuJycruGEV7pFGYN4q37pcpFYzjky+dOe3Lp5EmgfuEC
         ZI3g==
X-Gm-Message-State: AOJu0YzWn7V1ASnE76g8vDngzFDBJkZ6DzXeoVTpYRa6GBtIhZbu8T7P
	cHQ0WNUtTpJ+7ybdwNjeV2MJ58mgspskQ1Ty2e0vY6qiCit8E1IDD08ga1EDVcb0LgJIKRdHLvF
	AqkyjGI/IiLUxwbkyF28gx0Ytx2c80aPVqnof
X-Gm-Gg: AeBDiesRqASkoar9vpbY05K/hu8y4nF9k8v7TqN1eY/CEWKP1VL5RgllK/9TB1iZyZ6
	V/nY2JNycwxaymheCYiFd4eKbR87Vc/ZgNtv8vN/6bMeT3MLYPiFUiV+QnxHkbr3j+kjwAPyPXP
	UzAkINv9lz3apY9GSLz++Nedcrzrne3BItiMc+Tsy1WFIoOCT88E2masG6ORwqSbtufIaCXDLnW
	+AI5cN5B8Zq5d6s5/scj5NzIMTaMc+rsAAqTtxKYzVoRrGAkymtKmsKH86+kuoHvN6VPhFPEgG1
	x4BPxfaL8/8Xz6qyucjjg+TL4xHus8DqOV6LQELFL0myDfI=
X-Received: by 2002:a05:620a:29c3:b0:8cd:942e:82dc with SMTP id
 af79cd13be357-8e7916b2195mr833919085a.41.1776509827296; Sat, 18 Apr 2026
 03:57:07 -0700 (PDT)
MIME-Version: 1.0
From: Paul Cleghorn <cleghornp@gmail.com>
Date: Sat, 18 Apr 2026 11:56:56 +0100
X-Gm-Features: AQROBzC7pJ4SdmmrrSIijEXTG4_3Z3NUbKQp0Klz5Gz1HmJZ9A17P584VRuCz8g
Message-ID: 
 <CAAa+JJf8cR4oMWjzZo6qmRDtTq1cU8O7VmWNmMeLz0qEO6t9AQ@mail.gmail.com>
Subject: ALC287 Lenovo Yoga 9 14IRP8 (SSID 0x17aa3895): missing speaker quirk,
 only 2/4 speakers driven, generic SOF topology loaded
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com, kailang@realtek.com, perex@perex.cz
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: cleghornp@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: C7FE737F4572L3Z5HFYZNLOSBEWIYFUC
X-Message-ID-Hash: C7FE737F4572L3Z5HFYZNLOSBEWIYFUC
X-Mailman-Approved-At: Sat, 18 Apr 2026 19:58:51 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C7FE737F4572L3Z5HFYZNLOSBEWIYFUC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

On a Lenovo Yoga 9 14IRP8 (machine type 83B1), the built-in speakers
produce very thin / tinny audio under Linux. Only the front-facing
speaker pair appears to be driven; the rotating-soundbar woofers/tweeters
that Windows uses produce no sound, and no smart-amp DSP/tuning is
applied. The ALC287 quirk table picks an empty fixup name for the PCI
SSID and the SOF driver falls back to the generic 2-channel HDA topology.

alsa-info:
  http://alsa-project.org/db/?f=90a062f3fa1c64544a893a35fe9c75a1728fbf17

Hardware
--------
  Laptop                : Lenovo Yoga 9 14IRP8 (convertible)
  DMI product name      : 83B1
  DMI product version   : Yoga 9 14IRP8
  CPU                   : 13th Gen Intel Core i7-1360P (Raptor Lake-P)
  PCI audio             : 00:1f.3 Intel Raptor Lake-P/U/H cAVS (rev 01)
  PCI subsystem ID      : 17aa:3801
  HDA codec             : Realtek ALC287 (10ec:0287)
  HDA codec subsystem ID: 0x17aa3895
  BIOS                  : current per fwupdmgr (no updates available)

No Cirrus CSC3541 / CLSA01xx ACPI devices are present.
/sys/bus/soundwire/devices/ is empty. The only SPI devices are spi-nor
flash. So either this model uses different amps from the predecessor
14IAP7 (which used CS35L41), or amps are present but not enumerated via
ACPI. cs35l41 / scodec-cs35l41 modules and /lib/firmware/cirrus/cs35l41/
firmware are both present on disk but no consumer binds.

Software
--------
  Distro                : Fedora 43 Workstation
  Kernel                : 6.19.12-200.fc43.x86_64
  SOF firmware          : 2:2:0-57864 (ABI 3:22:1)
  Topology loaded       : intel/sof-tplg/sof-hda-generic-2ch.tplg (fallback)
  Userspace             : PipeWire 1.4.11

Relevant kernel messages
------------------------
sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
sof-audio-pci-intel-tgl 0000:00:1f.3: loading topology:
intel/sof-tplg/sof-hda-generic-2ch.tplg
snd_hda_codec_alc269 ehdaudio0D0: ALC287: picked fixup  for PCI SSID 17aa:3801
snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC287: line_outs=2
(0x14/0x17/0x0/0x0/0x0) type:speaker
snd_hda_codec_alc269 ehdaudio0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)

Note the empty fixup name after "picked fixup" -- there appears to be a
quirk entry for this SSID but with no identifiable fixup id.

Codec pin configuration
-----------------------
Only one internal speaker pin is enabled in BIOS pin defaults:
  Node 0x14  Pin Default 0x90170120  [Fixed] Speaker at Int N/A
All other speaker-type pins use 0x411111f0 (not connected). Node 0x17 is
the second speaker-out pin complex in hardware but BIOS-configured as
unconnected. Headphone pin (Node 0x21) and internal mic (Node 0x19)
behave normally.

Expected vs actual
------------------
- Windows: full 4-speaker output through the Bowers & Wilkins rotating
  soundbar, with DSP tuning, meaningful bass.
- Linux on this kernel: front pair only, no DSP, noticeably tinny,
  quieter than expected. Headphones work fine.

What this looks like
--------------------
A missing or incomplete entry in sound/pci/hda/patch_realtek.c for SSID
0x17aa3895 (and/or PCI SSID 17aa:3801) -- probably needing one or more
of:

  - a proper ALC287 fixup wiring Node 0x17 as a second internal speaker
    pin (0x90170121 / 0x90170131-style pin override),
  - an external smart-amp hookup (e.g. CS35L41 via I2S) plus
  - a matching SOF topology (4-ch or Yoga-specific) instead of
    sof-hda-generic-2ch.tplg.

I'm happy to test patches on this hardware -- please send anything you'd
like me to try and I'll report dmesg/alsa-info back.

Thanks,
Paul
