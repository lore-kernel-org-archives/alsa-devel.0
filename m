Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 114D6C982C1
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Sep 2026 06:29:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89520601E7;
	Wed, 16 Sep 2026 08:29:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89520601E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1789540186;
	bh=C//WHmIKNIOsz+BzZ0CbA2rnrddzkweBy7yrd2pND/8=;
	h=Date:From:To:CC:Subject:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=TBmHsNsNbA7Nw42v/GZVPiKrStxAVV0mNSeDgFeg5FPo7kH3pi9Gpvjk45E1RqG1d
	 3dg/pFbCgP1IrZeub2Q4+IG8FcXCebwJaplbmBxmtnqwdjT4BvnXjUKHsQAcV3DB4L
	 u/8ZmqRkpHrMKzXmfXGRmopv3OjbyEwGP2k28D7k=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D49BAF80609; Wed, 16 Sep 2026 08:28:50 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 21800F8060B;
	Wed, 16 Sep 2026 08:28:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 25ED8F80544; Sat, 12 Sep 2026 10:45:00 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=1.95.21.17
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1789202698;
	b=GddAVMiwVhpOODjmWPaqPmVguv+HPFNvAWJZSGtWFXI+am1md/TM5Slak0b1+pQowVt1
	 YQWQOe7L9eCu0BKs5r0Nk/aP0fZwtEX4W5yAsg3DfuSLtQIOUlDjMHfCzkkLraW68bvN/
	 txMxUChfDzIJWDkYqw9zsmJdbyxp87NnzePA75gLnuw7eyvr1WHM+H3GkbyREaDRsg8jj
	 J6Cms+VERNHfa1tNqVgMuai2aQtFqG62RierzDbdTWLWUnMdIfBh4eORYAewc0aU1G0gP
	 fyQcUeDDfTT4ucniJNSjpU9ISncGSlFSV6wDqPmU2BqiMSlC3c8azA3JLbS+tYjbIeg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1789202698;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version;
	bh=C//WHmIKNIOsz+BzZ0CbA2rnrddzkweBy7yrd2pND/8=;
	b=Bas7o3OqUxb3PqPn5ssgSY4zrGZSXDgsZmFMMJ3MDRHKreZ1IZyG0lOO+KcnBq+GllbT
	 NAkYQSFNPwSH1sHaKwTCYl6t3Rbz8GrmyBq0BkXF+OKupIiGoz1mdjvMzYs9753DPmTjx
	 vbSMeykp6X/5efozpPQZq+PbOozY9lQa2ab9nc1jJGGvIwoIT7b044gDQ5dYmH2Y+HsyC
	 k9jUL7bv9aD7L27FX8K7nSVbpqmpzcI/jXKNeQiWeSyyKcFrC148ANLux/iTROICXfThz
	 Pjft4x9VepbkG5fR+XgWS561B+rILsUYAXIQ5Al8FyxICZY5dAyPRrkEZPaf6WDP7kw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=yeah.net header.i=@yeah.net header.a=rsa-sha256
 header.s=s110527 header.b=knOT1gbf;
	arc=none smtp.remote-ip=1.95.21.17
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E750AF801F5
	for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2026 10:44:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E750AF801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=yeah.net header.i=@yeah.net header.a=rsa-sha256
 header.s=s110527 header.b=knOT1gbf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=EoOP8VxZVKVDxf1TYiUEHlgqMdieGBSKm5YIuDpSqCo=;
	b=knOT1gbfZM11LXIeVV0/6zj+CvJQMa6qGRd9S+E6jK0Q8C+aDKTiBV9soCniWl
	6GGAevlNj7vpO5q7rrizGtmL2OJhSAs2UIPlugz4fMobANZRC/qB7yyL7qomDwNU
	juQrT3ldZNFG/Ukyp63gXfD+eRWRaeyK+VgNNfecgPnjw=
Received: from ehlo.thunderbird.net (unknown [])
	by gzsmtp3 (Coremail) with UTF8SMTPA id M88vCgC3JxL5EKVqDZRnCA--.26558S2;
	Sat, 12 Sep 2026 16:44:43 +0800 (CST)
Date: Sat, 12 Sep 2026 16:44:41 +0800
From: Starry2233 <qu20121118@yeah.net>
To: linux-kernel@vger.kernel.org, x86@kernel.org
CC: bp@alien8.de, tglx@linutronix.de, mingo@redhat.com,
 dave.hansen@linux.intel.com, linux-acpi@vger.kernel.org,
 alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz,
 platform-driver-x86@vger.kernel.org, regressions@lists.linux.dev
Subject: =?US-ASCII?Q?=5BBug=5D_Spontaneous_emergency_reset_=28=22softwar?=
 =?US-ASCII?Q?e_wrote_0xE_to_0xCF9=22=29_on_AMD_Ryzen_9_8945H?=
 =?US-ASCII?Q?X_=28Lenovo_Legion_R9000P_2025=29_with_7=2E3=2E0-rc?=
 =?US-ASCII?Q?2_--_twice_in_one_day=2C_no_Oops/panic_logged?=
User-Agent: Thunderbird for Android
Message-ID: <AE089773-00AF-44F9-A679-9E22133D0C2D@yeah.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: M88vCgC3JxL5EKVqDZRnCA--.26558S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AFW8tF4ftFy8Cw45Kw4xtFb_yoW3JFW8pF
	WfKwnIkr4kJFy8Zr48Aw1UuF10vws3tay5CrZ8Kr40yF15CF1IyF1I9a40vFyUArWxW34Y
	qF1Utr17uan0gaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUUUUUU=
X-Originating-IP: [2409:8929:b53:83e9:caf8:b2e7:d93b:e7ba]
X-CM-SenderInfo: ttxsiiisrrimo61htxgoqh3/1tbiNBtG6WqlEPvNWAAA3x
X-MailFrom: qu20121118@yeah.net
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 3LTHDEMEU7OER7KPM5QNE6HHZMBK7G73
X-Message-ID-Hash: 3LTHDEMEU7OER7KPM5QNE6HHZMBK7G73
X-Mailman-Approved-At: Wed, 16 Sep 2026 06:28:42 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3LTHDEMEU7OER7KPM5QNE6HHZMBK7G73/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>




Hi,




I'm running the Ubuntu mainline 7=2E3=2E0-rc2 build on a Lenovo Legion R90=
00P

2025 and since switching to the 7=2E3 rc's the machine will, every so ofte=
n,

just hard reset itself out of nowhere=2E No timeout, nothing written to th=
e

log right before -- the box is mid-work and then it's gone, rebooted like

someone pressed reset=2E




The AMD FCH reset-reason decoder says both resets were an emergency softwa=
re

reset (0xE written to the 0xCF9 reset control register), not a clean reboo=
t

and not a power loss=2E On 7=2E3=2E0-rc1 the exact same symptom showed up =
as a

sudden power-off instead; on rc2 it comes back as a warm emergency reset=
=2E

Either way, no Oops, no panic, no MCE, no hung-task/lockup message anywher=
e

- the journal is alive until the very last line and then the machine reset=
s=2E




I'm kind of stuck on an RC kernel by necessity: the AW88399 subwoofer amp =
in

this particular model only got driver support in 7=2E3-rc1, which is why I

can't just fall back to the 6=2E12 stable kernel=2E So I'd rather report t=
his

properly than silently ride it out=2E Apologies in advance if this should =
go

to bugzilla instead -- point me at the right place and I'll move it=2E




Hardware / software

-------------------




- Lenovo Legion R9000P 2025 (DMI product LNVNB161216, baseboard "Legion

  R9000P ADR10", BIOS RLCN29WW, 2025-08-14)

- AMD Ryzen 9 8945HX (Hawk Point-HX, 16C/32T)

- NVIDIA GeForce RTX 5060 Max-Q (GB206M, 10de:2d59, rev a1),

  nvidia-open 595=2E99=2E02 via DKMS, KDE Plasma 6 / Wayland

- Audio: AMD ACP (1022:15e2), AMD HD-Audio (1022:15e3), Realtek ALC287,

  AW88399 subwoofer amp on I2C (SSID 17aa:3928)

- WLAN: Realtek RTL8922AE 802=2E11be (rtw89_8922ae)

- USB: 3x AMD Raphael xHCI (1022:15b6 / 15b7 / 15b8); a Google Pixel phone

  (18d1:4ee7) is usually plugged into usb3-port1

- Kernel: Linux 7=2E3=2E0-070300rc2-generic #202609070545 SMP PREEMPT_DYNA=
MIC,

  built Thu Sep 10 12:34:01 UTC 2026 (Ubuntu mainline, gcc-15)

- cmdline: BOOT_IMAGE=3D/boot/vmlinuz-7=2E3=2E0-070300rc2-generic

  root=3DUUID=3D83395a8d-ed16-43ad-8b2b-6989f78045eb ro quiet

- Debian 13 (trixie)




What the logs look like

-----------------------




(All timestamps below are local time, UTC+08:00=2E)




1) FCH reset-reason decode, read at the start of the boots right after eac=
h

   crash=2E Both abnormal events decode identically:




   x86/amd: Previous system reset reason [0x00300800]: software wrote 0xE

            to reset control register 0xCF9

   x86/amd: Previous system reset reason [0x00300800]: ACPI power state

            transition occurred




   Every normal reboot of the same box on the same kernel decodes as:




   x86/amd: Previous system reset reason [0x00080800]: software wrote 0x6

            to reset control register 0xCF9




   So the two crashes are exactly the emergency reset path

   (emergency_restart() -> machine_emergency_restart(), which writes 0x0E)=
=2E




2) There is no kernel log at all preceding either reset=2E The journal kee=
ps

   getting messages (wireplumber, systemd, chrome) right up to the last

   second, then nothing=2E No panic, no oops, no hung task, no lockup, no =
MCE=2E

   pstore / efi_pstore has nothing from today either, which makes sense fo=
r

   a reset that isn't a panic=2E




3) What was happening at the time:

   - Crash #1 (session ended ~14:31, 2026-09-12): a screen recorder called

     "Cap" was running with ALSA/JACK via PipeWire; last log lines are its

     playback stats ("effective_fps=3D60=2E1")=2E

   - Crash #2 (session ended ~15:11): a few minutes earlier the Pixel phon=
e

     on usb3-port1 went through a bad enumeration storm:

       15:08:53 usb 3-1: device descriptor read/64, error -71

       15:09:00 usb 3-1: Cannot enable=2E Maybe the USB cable is bad?

       15:09:00 usb 3-1: unable to enumerate USB device

     (it finally enumerated at 15:09:12 as device #11), then about two

     minutes later the reset=2E Chrome was mid-playback at the same time

     (its last line is "Frame latency is negative: -0=2E045 ms")=2E




4) Sysctl timeline, because it rules out the obvious: I set

   kernel=2Epanic=3D10 / panic_on_oops=3D1 on this box at ~14:52, which is=
 after

   crash #1 (so that one ran with kernel=2Epanic=3D0 and cannot be a

   panic-timer emergency_restart) and before crash #2 (which, even with

   panic=3D10 active, produced no panic message while the journal was heal=
thy

   up to the last moment)=2E




5) Why I'm reporting this without a call stack: every reboot-path symbol

   rejects kprobe/ftrace on this kernel=2E register_kprobe() returns -22 f=
or

   all of:




     emergency_restart

     machine_emergency_restart

     native_machine_emergency_restart

     machine_restart

     kernel_restart




   (a probe on panic() registers fine, so the reset path is squarely on th=
e

   kprobe blacklist)=2E My fallback plan is a small module that detour-pat=
ches

   emergency_restart()'s entry to log the caller, but if there's a proper,

   supported way to get the caller I'd rather use that=2E




What I suspect

--------------




- Both crashes happened with the GPU and the audio pipeline busy at once

  (screen recording over JACK/ALSA with compositing in one case, Chrome

  playback in the other), and the audio side is exactly the code that is

  new for this model in 7=2E3-rc1 (ALC287 + AW88399)=2E The fact that the

  behaviour flipped from power-off (rc1) to warm emergency reset (rc2)

  between two RC releases is a good signal that something changed in that

  window, audio or reset-handling related=2E

- Not fully sure about this, but it feels like the resets happen when I'm

  playing a video that has audio (rather than silent content or plain

  static load)=2E Both events so far fit that pattern (Cap screen recordin=
g

  and Chrome playback both had audio going), but take it with a grain of

  salt - I can't claim it's a reliable trigger=2E

- nvidia-open 595=2E99=2E02 prints two boot-time assertions on this SBIOS:




    NVRM: GPU0 nvAssertOkFailedNoLog: Assertion failed: Invalid data

    passed [NV_ERR_INVALID_DATA] (0x00000025) returned from

    PlatformRequestHandler failed to get target temp from SBIOS @

    platform_request_handler_ctrl=2Ec:2174

    =2E=2E=2E failed to get platform power mode from SBIOS @ =2E=2E=2E:211=
7




  Looks benign (Lenovo doesn't implement PlatformRequest), just adding it

  for completeness=2E

- Not a thermal event: temps are normal and the reset-reason decode points

  to a deliberate software emergency reset, not an EC/platform trip=2E




Questions

---------




1=2E Given that the journal was still writing normally right up to the res=
et,

   is a "panic with a wedged console" scenario actually plausible, or shou=
ld

   I assume a direct emergency_restart() caller that simply never logs?

2=2E Anything known between 7=2E3-rc1 and -rc2 that touches ACP / SoundWir=
e /

   snd-hda-codec-realtek / AW88399, or the reboot/emergency-reset path,

   that could plausibly end in an unlogged emergency reset? The power-off =
->

   warm-reset behaviour change between the two RCs feels like a regression

   window I can bisect=2E

3=2E Where is the best place to track this - LKML, bugzilla=2Ekernel=2Eorg=
, or

   the ALSA or x86 lists? Who should I Cc?




Happy to help however I can: full journalctl -k dumps from the affected

boots, a serial console if I can set one up, testing patches, or running

a bisect between rc1 and rc2=2E And if someone can confirm a clean way to

catch the emergency_restart() caller despite the kprobe blacklist, that

would nail this in one shot=2E




Thanks for reading this far,

Starry



P=2ES=2E If anyone replies anywhere, please make sure to Cc me so I actual=
ly

see the answer - I'm reading the lists through a forwards-only account=2E

