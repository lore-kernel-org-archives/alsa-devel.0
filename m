Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11E8C98302
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2026 14:02:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1ED37601E6;
	Wed, 23 Sep 2026 16:02:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1ED37601E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790172173;
	bh=n2kcedHfvTWnDY8j5j/zRPLsbGCDKraSK8I5pYJ8o4c=;
	h=In-Reply-To:References:From:Date:Subject:To:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=N4JddRZCbPXn3UdrInV3potluisHe5mHr0zvOZxH8CcmoVcouO+kmufHLSDgpQGfu
	 SFkzmDGi85MvrIvjVXkL3MdMh+iXiEWxQ2rSsOHgF1oTuAOmcJucYPhcCiOzKEUZYj
	 zmKCjaT5NWZKZUz57Isu9rKMnYhtSTNQX1rHa56A=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6BF81F805F6; Wed, 23 Sep 2026 16:02:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id CA843F805F3;
	Wed, 23 Sep 2026 16:02:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4FA94F8051F; Wed, 23 Sep 2026 16:02:07 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.205
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1790172125;
	b=I7Ni9ZW5dps15P3+wDU5Cc+6ILMDyb00pN6jB2uiSEYwbtNLWEih/vIYgYYapJwAMkwn
	 ESQBelPVhOPMMVSWahK7Sa+P0xyLEezOtDSc7F6Blg/k9JpitcGlOplfkraRyqHZ2qobE
	 nzIkQXt+U1H7Bn0nRBUgbol47VC2xAe5Rr5bBpnyOP2MRotp5axdIeNEswhHdlF8v4mZQ
	 DacBWP4hUQtO3l/DfsoA/cBY+leG/BXT4UjufdfTuhpFpo9nhTsA/VRNEaGMVWtShnDDZ
	 4qvu0Na2znyEVu0j4/pqRUpbk0CmCKvfSypY5C1ybKJyyw7FDRDXed5jj/1qsVLRQXA==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790172125;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=n2kcedHfvTWnDY8j5j/zRPLsbGCDKraSK8I5pYJ8o4c=;
	b=M8btbCnw5oF2pLWL6qdqqE88rcJkzvTCt5Bm6FYwcn37xNLDqY0vBvK9mNpDM8RFp+WB
	 nvwZOQRpuYpVGmAd+lBOptY4MDCASlWFLehtQxtLGy+Z1ckNfG8pen+I5r8/k1Ji/tb75
	 zch5JPSRQxKdj7TcYSWH3Mv5SG7zsMxZnJGI4X0acnj3h06BNyZAINBnLY5WORzLDJHJE
	 2WMt2s/+JNMtcjx+DbFYgKcHRzUJVRiojvOoBHbMDlRmuy8CDMLZ8hyzdEP+7Zpy2bWR7
	 UV/byR8qs50HqEolK4RFpoCwhYX/ELynJlm9YXvuvDgn4iXYFEm5KX9mHQ6D8mtaC0g==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=od4oT6p3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.229.205
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com
 [74.125.229.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8E928F801F5
	for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2026 16:02:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E928F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=od4oT6p3
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b5e4f15b79so825544e87.1
        for <alsa-devel@alsa-project.org>;
 Wed, 23 Sep 2026 07:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790172123; cv=none;
        d=google.com; s=arc-20260327;
        b=HfHyxghVpT4wKWgK+LvYU+eLbMx2p0Wc9FatT4hPJmnteBuTVnuhX/5Zc+zZvrovB+
         4TVAQG6yZ6KzqZboKsdqeiL4LBdhP6vWAz01nk5k+rAhcOfeEYx4YHFtiU07eFEwXf52
         rIndlniBmZnBawZSNIZLMuo8ry5vfnYfOcNLfHk8R6FBh2w8TLuS6wGTx5Gaw+0TfreH
         lwMuBMkEHzLM5ugBeK3IVc83MQS9J1TgH7i+u72DgWoOHiS2/nRZT9+tbuVITxxbUHq7
         xYaHSkgVdnLyGR1hqBPGxVGwwhjxht1g+vCzW98dROlyWB7dIemLZ8LLUR3g2mLBrNml
         i/dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature;
        bh=rGTyrZAmCwYojS2wv6ItMjUz/mDkXr0cQmLBOV0dpd0=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=Oa7SOegFzg8XBxhPVoA6g3LK9m/IEvhwet+VBK8SHv9Jr387WhWR3h9AzrZRK/EHyt
         /CWvgUh/HDXxRnVf+RrX6XLBigMwgyEQGHmIQLQzwtLpmh6JoqPoZiO4CJBXBySV/6o2
         ANT6FiZVBaS/rNBcFIZ8hAyCaY6LNnOX8Z3w1Ytm6zuMB/99poJUGdg74WO49CUkPBIc
         Yiq/z8qBXGHtggWBOhAZ5cpag8Dr0Mo1AP0ZPxxaqjd4KZCMh0+eINS2yfmV0TGuj0JR
         VHIo2D1AYfH5MIkan0+HAExfTdXi33HF/xCqjolo+v6ApEg/v65YG7l8/0Eo2zUz9u2q
         ROYA==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790172123; x=1790776923;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rGTyrZAmCwYojS2wv6ItMjUz/mDkXr0cQmLBOV0dpd0=;
        b=od4oT6p35kvkj25Rm5Zj0qIJC84dVuZo5LTlLjzs5hqFDEnVTfdoKaK2Xfe6PXsB0r
         cDfOQQaPFDBRGQ54YjjurLchHeAn3ZOFcZWuYbz5PGRP7cdv/sQYHmc1CMe1ZxAwgCtz
         ASEOxS7CS1wiooq78B924T7YuruaggVujf+V2O3YulI3+S3ruFsJw4NS5OXa5f1TrpeY
         Rd44ci2qXTXAyJn7ktdwanq/kNXF2FmT59Ku/mNTZaJaMhKmgFkaTS56gQCsKtTN2+dM
         En8ajHlk30BLZgss0MulZB2Ya12/elFZMJBKCBeIKFMYkI/mZ3OUQF6Peyo4IP6R8734
         wCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172123; x=1790776923;
        h=content-type:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rGTyrZAmCwYojS2wv6ItMjUz/mDkXr0cQmLBOV0dpd0=;
        b=jYj1AwHbQT9kE1qbEcBBAPR3t0W/cPIRcuxSk4sI6YRCGaKxgpKfs1V/ZY1N20XANW
         j16gFIeyZ3TqeKzoPERiOJMVtPHVa2urgA5lcyg2rg+66utu9P53cm5psRB/qo0uOP0R
         ON5aaIdW++KHPGELxg54zShh4g9xMJIXdRGaHD+4DN58jjjwRfGFYdG9aL8hEypdtUbT
         TDYgCK4snDA1AdT09QBVRB4KiFpCnmVtPIC6qsejqun98/bP4uNmDoFSW6yT8x/rlvhO
         JUKTy94gDshDIBtwX8kSZm3Ah1bMF5f9f+QNDD/mUyVmDgI8W4oLNOLcacm9A9oh8X39
         O2eQ==
X-Gm-Message-State: AFuF++nZ8NSd3byuK1xA/6C/SPTbowIr9p7OmwoFtaKmtemytnLcmCOE
	+n5gfWlAgtlyXBZPRHyur7mm3yjPCLUvpaoHuRfIDcehTyUjJO3DJR9aP4gwPepoARnrK/MuzL5
	A5hvmEAqVCB/YCCSbnvrCxGJDR1SIx09eLA==
X-Gm-Gg: AYBFou0P5hBSrHil2y+7V8h8qREkNL2k6F8ODkVf4RhYqFjbItF6hpwaI4Zyk8OLnKy
	m5CeeQboXQEafDPKxKcOnYxo8XY7OSGszCfMtGg3bEQZNh2LCBcsc1+25eBDdkPFufgvjEkqEAA
	pqz4E6QuPtjdTcNrwUzLGHrHOnpt94BQoapRC+OCLqWJ8oxAk4z21Jis8n3rC6YTohFblvyYYqn
	oLkYO9Lrs5N2HahXMz0WSrJxulPMtXiR0S4yLVD6xkUo01YMV29rfHOi9rDydQgc2Y8MSR24J2u
	C3eZwvx7sxAYjsEHANfJsCRzDmLg3w1KScQlHilYPCA+shs0Fq5gt79KfYWv8qdt
X-Received: by 2002:a05:6512:65c5:20b0:5b8:bc5e:b577 with SMTP id
 2adb3069b0e04-5b8d89ba183mr732932e87.47.1790172122952; Wed, 23 Sep 2026
 07:02:02 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 23 Sep 2026 07:02:01 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 23 Sep 2026 07:02:01 -0700
MIME-Version: 1.0
In-Reply-To: 
 <CACC0HWCjUNOK=PU8ARxDD5UOptEBm5KJhc5yzweLyb2004UY4w@mail.gmail.com>
References: 
 <CACC0HWCjUNOK=PU8ARxDD5UOptEBm5KJhc5yzweLyb2004UY4w@mail.gmail.com>
From: slihump <cleancountry200@gmail.com>
Date: Wed, 23 Sep 2026 07:02:01 -0700
X-Gm-Features: AclHuK_MQQVyb-ZC2_YfuglrmB-Fdq48u0SdNz7yKHCfbkQKSNkRa71GNpUV5PE
Message-ID: 
 <CACC0HWDvXGXxT3o2TKD-wgPKPwnC42KJgxvXbgnwC=Y7MyAWkw@mail.gmail.com>
Subject: Re: [BUG] ALC298 (SSID 1854:0548): internal speakers silent after
 warm reboot from Windows
To: alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Message-ID-Hash: ANWF2O223EHJKI3D22SWUH7BXIQZXUKE
X-Message-ID-Hash: ANWF2O223EHJKI3D22SWUH7BXIQZXUKE
X-MailFrom: cleancountry200@gmail.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ANWF2O223EHJKI3D22SWUH7BXIQZXUKE/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hi,

Following up on my LG gram ALC298 speaker report below. The issue
remains reproducible when I restart from Windows into Linux; a full
power-off restores sound.

I can run additional diagnostics or test a patch if that would help.
Please let me know if there is a more appropriate place to report
this.

Thanks,
slihump


On Tue, 08 Sep 2026 00:57:22 +0900, slihump <cleancountry200@gmail.com> wrote:
> Hi,
>
> I am reporting a reproducible internal-speaker failure on an LG gram
> laptop with a Realtek ALC298 behind Intel SOF (skl_hda_dsp_generic). I
> have narrowed the difference between the working and failing states down
> to six vendor COEF registers, and would appreciate guidance: two of them
> appear to be latched in hardware and I cannot find any way to clear them
> from the driver side.
>
>
> 1. SUMMARY
> ==========
>
> After booting Windows and then performing a *warm* reboot ("Restart")
> into Linux, the internal speakers are completely silent. Everything the
> driver exposes reads as correctly configured: the speaker pin is
> unmuted, its pin control is set to OUT, EAPD is enabled, the DAC has the
> stream assigned, all mixer controls are on, and the PCM reaches RUNNING
> with hw_ptr advancing normally. There is simply no audible output.
>
> A *cold* boot (full power off, then power on) always restores sound. A
> warm reboot from Linux to Linux also works, because Linux leaves the
> codec in a good state. Only the "the last OS that ran was Windows" case
> fails, and only because a warm reboot never removes power from the
> codec.
>
> Note that Windows Fast Startup is not involved: Fast Startup applies to
> Shutdown only, and the failure reproduces via Restart, which always
> performs a full Windows kernel restart. It also still reproduces with
> hibernation disabled (powercfg /h off) on the Windows side.
>
> Headphone output could not be tested (no 3.5 mm device available). USB-C
> headphones work, but they bypass the codec entirely.
>
>
> 2. SYSTEM
> =========
>
> Machine        : LG Electronics 16Z90TP-GA5BK (LG gram 16, board 16Z90TP)
> BIOS           : Phoenix A1ZJ3340 X64, 07/15/2025
> CPU            : Intel(R) Core(TM) Ultra 5 225H (Arrow Lake-H)
> Distro         : Ubuntu 24.04.4 LTS
> Kernel         : 7.0.0-31-generic (#31~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC)
> Codec          : Realtek ALC298
>   Vendor Id    : 0x10ec0298
>   Subsystem Id : 0x18540548   <-- no machine-specific quirk matches this
>   Revision Id  : 0x100103
> Card           : sof-hda-dsp / LGElectronics-16Z90TP_GA5BK-0.1-16Z90TP
> Machine driver : skl_hda_dsp_generic
> SOF firmware   : intel/sof-ipc4/arl/sof-arl.ri, booted version 2.14.1.1
> SOF topology   : intel/sof-ipc4-tplg/sof-hda-generic-2ch.tplg (ABI 3:29:1)
> firmware-sof-signed : 2023.12.1-1ubuntu1.11
> alsa-ucm-conf       : 1.2.10-1ubuntu5.14
> Userspace      : PipeWire 1.0.5 / WirePlumber 1.0.5
>
> /sys/class/sound/hwC0D0/modelname is empty and no fixup/quirk messages
> appear in dmesg, so this machine runs through the generic ALC269-family
> path.
>
> Pin configuration as parsed by the driver (identical in both states):
>
>   snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC298:
>       line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
>       speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
>       hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
>       mono: mono_out=0x0
>       inputs: Mic=0x18
>
>   NID 0x17 = 0x90170110 [Fixed] Speaker at Int  (internal speaker)
>   NID 0x21 = 0x03211020 [Jack]  HP Out at Ext Left
>   NID 0x14, 0x1a, 0x1e = 0x411111f0 (not connected)
>
>
> 3. REPRODUCTION
> ===============
>
>   1. Boot Windows (dual boot on the same machine). Sound works there.
>   2. From Windows, choose "Restart".
>   3. Boot into Linux.
>   => Internal speakers are silent for the entire session.
>
>   4. Full power off, wait ~15 s, power on, boot Linux.
>   => Internal speakers work again.
>
> 100% reproducible in both directions, verified over several cycles.
>
>
> 4. KEY FINDING: ONLY VENDOR COEF REGISTERS DIFFER
> =================================================
>
> I dumped the full codec state in a known-good session (cold boot) and in
> a failing session (warm reboot from Windows), using HDA verbs issued
> through /dev/snd/hwC0D0 (SET_COEF_INDEX 0x5 followed by GET_PROC_COEF
> 0xc on NID 0x20 for the coefficients).
>
> The two dumps are byte-identical except for six COEF registers. Pin
> controls, EAPD state, amplifier gain/mute values, power states,
> connection selects, GPIO mask/dir/data, the complete
> /proc/asound/card0/codec#0 dump and full amixer output are all
> identical.
>
>   COEF index | good (cold boot) | bad (warm reboot from Windows) | writable
>   -----------+------------------+--------------------------------+---------
>     0x22     |      0x0039      |             0x0000             |   yes
>     0x23     |      0x23ff      |             0x0000             |   yes
>     0x25     |      0x0001      |             0x0000             |   yes
>     0x26     |      0xb001      |             0x3000             |   yes
>     0x28     |      0x0000      |             0x003f             |   NO
>     0x5b     |      0x0000      |             0x4342             |   NO
>
> COEF indices 0x00-0x7f were scanned; all other indices matched.
>
>
> 5. WHAT I TRIED (all failed)
> ============================
>
> a) Restored 0x22, 0x23, 0x25, 0x26 to their known-good values. The
>    writes verified correctly on read-back, but the speakers stayed
>    silent.
>
> b) Tried to write 0x28 and 0x5b. The verbs are accepted without error,
>    but the registers do not change; they read back the failing values.
>    They appear to be read-only status registers or hardware-latched
>    state.
>
> c) Codec reconfiguration via /sys/class/sound/hwC0D0/reconfig:
>
>      write error: Device or resource busy
>
>    The codec is bound as a component of the SOF/ASoC card, so the legacy
>    HDA reconfig path is unavailable.
>
> d) HDA function group reset (AC_VERB_SET_CODEC_RESET, verb 0x7ff on NID
>    0x01): The verb is accepted without error, but nothing is actually
>    reset -- values I had written to 0x22/0x23 immediately beforehand
>    survived the reset unchanged. Manually restoring the whole playback
>    path afterwards (power states, pin controls, amplifier mute/gain,
>    EAPD, connection select, COEFs) still gave no sound.
>
> e) PCI-level cold re-initialisation of the audio controller (unbind/bind
>    0000:00:1f.3 on sof-audio-pci-intel-mtl): firmware and topology
>    reload cleanly and the ALC298 autoconfig output is identical to a
>    fresh boot, but the speakers remain silent. This does not remove
>    power from the codec.
>
> Also ruled out by measurement, in case it helps: hardware failure
> (speakers work under Windows), mute/volume state, PipeWire/WirePlumber
> (restarting the stack, and playing via ALSA directly with plughw:0,0,
> hw:0,0 and the deep-buffer PCM plughw:0,31 with all mixers at 100%), UCM
> (bypassed by the direct hw access), a kernel regression (audio init logs
> for 7.0.0-30 and 7.0.0-31 are identical), SOF firmware/topology
> integrity (dpkg -V clean), and snd_hda_intel.power_save (setting it to 0
> changed nothing; after the cold boot that restored sound it was back at
> the default 1).
>
>
> 6. QUESTIONS
> ============
>
>   1. Are COEF 0x28 and 0x5b on ALC298 known to be writable at all, and is
>      there a documented unlock sequence or a different coefficient page/NID
>      (e.g. a coefex NID) that should be used to reach them?
>
>   2. Is there any supported way to force a genuine codec re-initialisation
>      when the codec is bound to an ASoC card, given that reconfig returns
>      -EBUSY and verb 0x7ff appears to be a no-op here?
>
>   3. If the values above look like a plausible speaker-path configuration,
>      would a machine quirk for SSID 1854:0548 that programs the known-good
>      COEF values during codec init be the right fix?
>
> I am happy to test patches -- the failure is trivially reproducible on
> demand. alsa-info output from both a working and a failing session is
> attached, along with the two full codec/COEF register dumps referenced
> above.
>
> Thanks for your time.
