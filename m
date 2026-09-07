Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5157C79F99
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:58:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9DD61601F2;
	Mon,  7 Sep 2026 17:58:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9DD61601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788796699;
	bh=ZEBIeRIKOtupJ8t9t1jf4YqTpgrsf8s5K7EOyzz6C30=;
	h=From:Date:Subject:To:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=klO2yvBkEUIujKgRd7xRviMBSZgh/SWEihq2tn0MCEkRrc7W8c41Y8F5Lve27FzAi
	 pFq3KQMIOONGflFjGhpwth86VeDV4SkXrnoUy/my/yBiz+YjkTjw/vJ5pTiv5Nyat/
	 By7RKDhkE3ktzk1v8sG0a3YnEi7eklEemnLyAJ2w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F11E5F80601; Mon,  7 Sep 2026 17:57:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 76C1BF805FB;
	Mon,  7 Sep 2026 17:57:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DA79EF80571; Mon,  7 Sep 2026 17:57:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1788796658;
	b=BHbRnFwql9Rqc6w9yuFT5enuOVL8p71fqoOgjpgmQobRVY8eq0akB5tuIv09FTQzePZC
	 lfG3NB47jhtR4wrDd+u8FEkNtWVgA9kj5Zbt6LS78gw0gN7FRA4DgzIRA2+6LKAUsQjYk
	 evhboxqpwariRaJa6m+UEn9K34aLwYqRyen+imF2Dr104HqSnfLVuvWDgAe2BiPULq7s0
	 OcSY2O68581eW0K3ue5I7ZrCzhziMIBtSlJzAA8Ypi6UDC9ySnysiyUChedJoC7Y+OOwu
	 /faI/3D8hJgNN25Rrp+HLLkYKXiiT3z4zCKMa5OrxlhruYeEwSSpP6dGvhDT0sGK8Bw==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788796658;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=ZEBIeRIKOtupJ8t9t1jf4YqTpgrsf8s5K7EOyzz6C30=;
	b=e/1EQrcKMq2fhhyly9Vv3rhacZ9rYn5g5l3fBP/CWJn2ShqNzrt2PueiXPLh7o3A/Ft+
	 gDpoxIyozt+h1BdHLAR+3ALiMqV5fooCGu9oQVnfQ8wR3OxBzKHDRLTbHkwvINX9hqaWp
	 ud7MEOxisCrEz2Ju1tlyR1idHrvpgura3OCX20gztWbSw6Z0Ls/W/GfNsItMPmOrE8n5W
	 s0pTzC6ow1eNjcivQ272vqO86zBpLwiG9J3fafuEK1qoTQ2caDn3CEClKrvweHzpBq0Zz
	 lmR9OghkvCvY1hqEWPtHqWEx5/W7xV2wNWmbtnQvcx9uLz3jzemGQK6eJzFkqu01yVw==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JQxvn+M1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8A02CF80088
	for <alsa-devel@alsa-project.org>; Mon,  7 Sep 2026 17:57:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8A02CF80088
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JQxvn+M1
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5b5f21afe8cso5656067e87.1
        for <alsa-devel@alsa-project.org>;
 Mon, 07 Sep 2026 08:57:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788796655; cv=none;
        d=google.com; s=arc-20260327;
        b=AObRfH9898HlAwue/Kd1rzwz3pXfP+xTtJ6oZDsuJCCqNcULBLF2R90OxSw/OCP7V3
         +JAqY0y9PSMrck/VATsonYxfYGJl47LZh/itCXqu8DsYylq4OVp+uH4Zxx/cjj3i95JZ
         bSj79x6CexfGiTrfjiQOeX/4qg7HRSKISZh0lEvlZvD9fY8mrUInCaSD9gA7LXQVQ7cM
         THm4FMiEAuVTuG1ECjsvUtyL4ozSyfwao3hLqUx+TCpzoSl9J1Rw6QSJWyJmvcZENBYw
         /sCMtrOMMiML81OEVY8FmlKRAoKVse3eyddW/Cw4tsnCyeybFkHRv049FWeDb4Dy0xNv
         8kNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zV5ft1eG3e5Lm3Td/PsP2QeCbi2Qu1LTtmzQG9W+2fg=;
        fh=s1h8N4U4ASgl2diPi2yKjEmsLSTuwbZjYBDYrAXLUvw=;
        b=pn7EA4B+oczp9Mwi3/nL45kiY74+jZ/ukA/G8WLBrdup5GDfl87/OIrWJjn4AFhrle
         XHn1n/ddFsxlorlpiEw/AF+8A6C8bjgZrEDHmA0gmGWInclMaxbdzj0YK2yOLLg3w9/Z
         605FHJI1OL/qxmGtUucuszH6Gt01CqcwL6ppyDEhiBUeRWarG5YbPhS4xTizx4IjwanS
         VNnx+dlXSdgPHBkJUZ5GBghNCat90JeXXH2rDSj5fuSAg7L5sFhBd14fWiAlqZ9vqF++
         htX59PKQOwZHbBl7HalPFOy20Wm/lHyS3w0xIHSM5BNNkYGGLMle16R10e59cNZO4Raj
         2m7A==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788796655; x=1789401455;
 darn=alsa-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=zV5ft1eG3e5Lm3Td/PsP2QeCbi2Qu1LTtmzQG9W+2fg=;
        b=JQxvn+M11TcRKLTDcVeCSmxyl8b6hXqM1Lh6u3BLSasAMmEc3jn0gobsM1xLdBaJoG
         yphSxYaNY68nJnl3t06vzB0g5tvM2bBH6huu+Czf73N133qMafMfYgkGLznrMVmCnopl
         8mW0ACAPhYiqHOEZ5NXlds9X620WBAW+Klu78I+QtBMLY4w9GScQBDyAr22ndGdoxl+l
         Uoq2LcokBhNfhmj0NnbF8H+ZD0Fu2CL5bkySDZINp8HqpkXLmzRVUAl5mmToLcFz03Cd
         9asH351kQiw6cgcq/pgb7jBb+CCqNFS0683ovhEukwEppEC7axFGK8/d16iSKURYdXJl
         2vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796655; x=1789401455;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zV5ft1eG3e5Lm3Td/PsP2QeCbi2Qu1LTtmzQG9W+2fg=;
        b=mS0EbBJ4BhO+nsgVjoaHkSrcn5d+pnsR8nYMskOPphWCt4+IvsKnWWxWudtkk+Cieo
         K6DZqclCZBpKmCuKvdqyW49KViC/GV0/hgVUCM7VvG7WWytJ314QtepY2TnwRHAtkkJv
         wupa2c7vax6oufjX21dsFoVuZ4PN9Dy+sRZJomfL9MSq3Hwa/B27rLi5+YXSBInUS4PK
         Tf278lk0Oe7ijJWHWi/YtBpBCxcrXXXcwKyXykFmXaBz2e2JsHwySZp280J2m9DbF3Xh
         yI/Aqeuj6244ItdBihBThnkNiz4jTLFgmxIbXmCcKznRf5A3aAi5TQwd/jchioYnkEjn
         8GvA==
X-Gm-Message-State: AFuF++lbAB9XzXUm2V9Rt4xoShZgfZ3VNnIdNNfDv3ytZE4MI50V1Dvl
	sJ36j0/vJOTLZOkJTkN4bsL8T2Hl3wldu3baK7MN4rPFz2Jxfnao8viSkaiCb4qxyYjf5J34rXr
	c0JjJ1m6PBbFn+CdxVV6Y4nT69Cd5gjWIvJne
X-Gm-Gg: AYBFou0Yo/dJxW4ec9brgCsk4JNmM8sth68AmslzMQ7Av3vUKcl1lufp1F0y0a6Il/I
	oqI/NyDEhx1/FnwckGR8sCT/+d96YIJWrxT0R8ShKLvuLTs5MP2s1GD6vsWfg6uIlk4OqvkF3Nj
	8QIDL1L5nsOKOrFtryDaaqihSV5Fr5Ajq4zx81yKcYVkk+9/PzN19aZxCopTiFXhe4gWb3u8ONc
	nS7D7atHxFJt4BJ3+ySwSVE/cVCFhAPwHmGOUey6V5vYMRLQJ1/h0QqkVVHyaT21xxQPYWhEARz
	aXPVbgPGJmyhaEJuhH/LHgXw+cxY3oObI0cprLOzCdo=
X-Received: by 2002:a05:6512:2506:b0:5b6:10bc:dc52 with SMTP id
 2adb3069b0e04-5b610bcde23mr4028825e87.41.1788796654731; Mon, 07 Sep 2026
 08:57:34 -0700 (PDT)
MIME-Version: 1.0
From: slihump <cleancountry200@gmail.com>
Date: Tue, 8 Sep 2026 00:57:22 +0900
X-Gm-Features: AcwNN1Wv-mClMM76f7PXzYroUjhN2WfnAyYguYTX_CZOBNaZv1whX1nls8B8VqE
Message-ID: 
 <CACC0HWCjUNOK=PU8ARxDD5UOptEBm5KJhc5yzweLyb2004UY4w@mail.gmail.com>
Subject: [BUG] ALC298 (SSID 1854:0548): internal speakers silent after warm
 reboot from Windows
To: alsa-devel@alsa-project.org
Content-Type: multipart/mixed; boundary="0000000000002e5b58065ae6adcc"
Message-ID-Hash: LBUH3MOX577XWSNWAWHU6PMUU2VJVDMU
X-Message-ID-Hash: LBUH3MOX577XWSNWAWHU6PMUU2VJVDMU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LBUH3MOX577XWSNWAWHU6PMUU2VJVDMU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--0000000000002e5b58065ae6adcc
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a reproducible internal-speaker failure on an LG gram
laptop with a Realtek ALC298 behind Intel SOF (skl_hda_dsp_generic). I
have narrowed the difference between the working and failing states down
to six vendor COEF registers, and would appreciate guidance: two of them
appear to be latched in hardware and I cannot find any way to clear them
from the driver side.


1. SUMMARY
==========

After booting Windows and then performing a *warm* reboot ("Restart")
into Linux, the internal speakers are completely silent. Everything the
driver exposes reads as correctly configured: the speaker pin is
unmuted, its pin control is set to OUT, EAPD is enabled, the DAC has the
stream assigned, all mixer controls are on, and the PCM reaches RUNNING
with hw_ptr advancing normally. There is simply no audible output.

A *cold* boot (full power off, then power on) always restores sound. A
warm reboot from Linux to Linux also works, because Linux leaves the
codec in a good state. Only the "the last OS that ran was Windows" case
fails, and only because a warm reboot never removes power from the
codec.

Note that Windows Fast Startup is not involved: Fast Startup applies to
Shutdown only, and the failure reproduces via Restart, which always
performs a full Windows kernel restart. It also still reproduces with
hibernation disabled (powercfg /h off) on the Windows side.

Headphone output could not be tested (no 3.5 mm device available). USB-C
headphones work, but they bypass the codec entirely.


2. SYSTEM
=========

Machine        : LG Electronics 16Z90TP-GA5BK (LG gram 16, board 16Z90TP)
BIOS           : Phoenix A1ZJ3340 X64, 07/15/2025
CPU            : Intel(R) Core(TM) Ultra 5 225H (Arrow Lake-H)
Distro         : Ubuntu 24.04.4 LTS
Kernel         : 7.0.0-31-generic (#31~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC)
Codec          : Realtek ALC298
  Vendor Id    : 0x10ec0298
  Subsystem Id : 0x18540548   <-- no machine-specific quirk matches this
  Revision Id  : 0x100103
Card           : sof-hda-dsp / LGElectronics-16Z90TP_GA5BK-0.1-16Z90TP
Machine driver : skl_hda_dsp_generic
SOF firmware   : intel/sof-ipc4/arl/sof-arl.ri, booted version 2.14.1.1
SOF topology   : intel/sof-ipc4-tplg/sof-hda-generic-2ch.tplg (ABI 3:29:1)
firmware-sof-signed : 2023.12.1-1ubuntu1.11
alsa-ucm-conf       : 1.2.10-1ubuntu5.14
Userspace      : PipeWire 1.0.5 / WirePlumber 1.0.5

/sys/class/sound/hwC0D0/modelname is empty and no fixup/quirk messages
appear in dmesg, so this machine runs through the generic ALC269-family
path.

Pin configuration as parsed by the driver (identical in both states):

  snd_hda_codec_alc269 ehdaudio0D0: autoconfig for ALC298:
      line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
      speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
      hp_outs=1 (0x21/0x0/0x0/0x0/0x0)
      mono: mono_out=0x0
      inputs: Mic=0x18

  NID 0x17 = 0x90170110 [Fixed] Speaker at Int  (internal speaker)
  NID 0x21 = 0x03211020 [Jack]  HP Out at Ext Left
  NID 0x14, 0x1a, 0x1e = 0x411111f0 (not connected)


3. REPRODUCTION
===============

  1. Boot Windows (dual boot on the same machine). Sound works there.
  2. From Windows, choose "Restart".
  3. Boot into Linux.
  => Internal speakers are silent for the entire session.

  4. Full power off, wait ~15 s, power on, boot Linux.
  => Internal speakers work again.

100% reproducible in both directions, verified over several cycles.


4. KEY FINDING: ONLY VENDOR COEF REGISTERS DIFFER
=================================================

I dumped the full codec state in a known-good session (cold boot) and in
a failing session (warm reboot from Windows), using HDA verbs issued
through /dev/snd/hwC0D0 (SET_COEF_INDEX 0x5 followed by GET_PROC_COEF
0xc on NID 0x20 for the coefficients).

The two dumps are byte-identical except for six COEF registers. Pin
controls, EAPD state, amplifier gain/mute values, power states,
connection selects, GPIO mask/dir/data, the complete
/proc/asound/card0/codec#0 dump and full amixer output are all
identical.

  COEF index | good (cold boot) | bad (warm reboot from Windows) | writable
  -----------+------------------+--------------------------------+---------
    0x22     |      0x0039      |             0x0000             |   yes
    0x23     |      0x23ff      |             0x0000             |   yes
    0x25     |      0x0001      |             0x0000             |   yes
    0x26     |      0xb001      |             0x3000             |   yes
    0x28     |      0x0000      |             0x003f             |   NO
    0x5b     |      0x0000      |             0x4342             |   NO

COEF indices 0x00-0x7f were scanned; all other indices matched.


5. WHAT I TRIED (all failed)
============================

a) Restored 0x22, 0x23, 0x25, 0x26 to their known-good values. The
   writes verified correctly on read-back, but the speakers stayed
   silent.

b) Tried to write 0x28 and 0x5b. The verbs are accepted without error,
   but the registers do not change; they read back the failing values.
   They appear to be read-only status registers or hardware-latched
   state.

c) Codec reconfiguration via /sys/class/sound/hwC0D0/reconfig:

     write error: Device or resource busy

   The codec is bound as a component of the SOF/ASoC card, so the legacy
   HDA reconfig path is unavailable.

d) HDA function group reset (AC_VERB_SET_CODEC_RESET, verb 0x7ff on NID
   0x01): The verb is accepted without error, but nothing is actually
   reset -- values I had written to 0x22/0x23 immediately beforehand
   survived the reset unchanged. Manually restoring the whole playback
   path afterwards (power states, pin controls, amplifier mute/gain,
   EAPD, connection select, COEFs) still gave no sound.

e) PCI-level cold re-initialisation of the audio controller (unbind/bind
   0000:00:1f.3 on sof-audio-pci-intel-mtl): firmware and topology
   reload cleanly and the ALC298 autoconfig output is identical to a
   fresh boot, but the speakers remain silent. This does not remove
   power from the codec.

Also ruled out by measurement, in case it helps: hardware failure
(speakers work under Windows), mute/volume state, PipeWire/WirePlumber
(restarting the stack, and playing via ALSA directly with plughw:0,0,
hw:0,0 and the deep-buffer PCM plughw:0,31 with all mixers at 100%), UCM
(bypassed by the direct hw access), a kernel regression (audio init logs
for 7.0.0-30 and 7.0.0-31 are identical), SOF firmware/topology
integrity (dpkg -V clean), and snd_hda_intel.power_save (setting it to 0
changed nothing; after the cold boot that restored sound it was back at
the default 1).


6. QUESTIONS
============

  1. Are COEF 0x28 and 0x5b on ALC298 known to be writable at all, and is
     there a documented unlock sequence or a different coefficient page/NID
     (e.g. a coefex NID) that should be used to reach them?

  2. Is there any supported way to force a genuine codec re-initialisation
     when the codec is bound to an ASoC card, given that reconfig returns
     -EBUSY and verb 0x7ff appears to be a no-op here?

  3. If the values above look like a plausible speaker-path configuration,
     would a machine quirk for SSID 1854:0548 that programs the known-good
     COEF values during codec init be the right fix?

I am happy to test patches -- the failure is trivially reproducible on
demand. alsa-info output from both a working and a failing session is
attached, along with the two full codec/COEF register dumps referenced
above.

Thanks for your time.

--0000000000002e5b58065ae6adcc
Content-Type: application/gzip; name="lg-gram-alc298-dumps.tar.gz"
Content-Disposition: attachment; filename="lg-gram-alc298-dumps.tar.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_mtrfbeqx0>
X-Attachment-Id: f_mtrfbeqx0

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
5VRO5VRO5VT+j/IfM6DOWQAwAgA=
--0000000000002e5b58065ae6adcc--
