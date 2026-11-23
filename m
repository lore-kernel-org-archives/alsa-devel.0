Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F7606A31A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=X7F/pyJ8;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RPx/4bgv
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E694560229;
	Mon, 23 Nov 2026 13:05:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E694560229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435546;
	bh=mrLdCv7514CfNuSO2zJ1x+6SKg/fHO9mnQrZyf3PNv8=;
	h=Date:To:Cc:Subject:From:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=X7F/pyJ8tPKc6nOSJWU0JYHpDzgl8BnBs58g2QEv7tfdDziw4vn7Rw3GIvPsD4INn
	 qI6DBQe2dfUfgDJugBPZqQe2ESl8wvf5igIQ0i3tqnNACqqFzU4KZ11rKU5CZxGWqn
	 voLCsg9FqyuEdhOCOQb6qPjws7Or5DyLLsAsjia0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17240F80793; Mon, 23 Nov 2026 13:03:06 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1653EF80799;
	Mon, 23 Nov 2026 13:03:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DE182F80552; Mon, 23 Nov 2026 07:45:31 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.231.75
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795416307;
	b=hPUDDB2RhhZAdP4khJRJDQR2aG9Aykbo95hgjFN0yqObrabk0hy2wQIcEQI+wLanvt+9
	 FTGpXF45IQkt8eFB6bIPfyRGyqXmg14P4OJR3fdlCO1HeWA822z4ViDq2+PDj9NexAYAw
	 zVHoPIxAogbtClksueU9fzchqD//z5qPWw/gnqNHV+YG50Pc7m8MxYnhfKqKpjLVmc4AU
	 y/D2uDaOxQkrkmcd/4ei66PTL5MctDtt2Q51TS7WM84sKbdWHuxmS+ONh33T9yhkiNwVl
	 9HEANUGIdBgN7IhAxUOAMqDYaWaJ/WwAPaX7ls7mK7wfOUmr6wqPLxj/1mao4rswPIA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795416307;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:To:Subject:From;
	bh=mrLdCv7514CfNuSO2zJ1x+6SKg/fHO9mnQrZyf3PNv8=;
	b=nuPrpks7YWj2wUnrHl1uoz6Wv3ZplIG6b8nOcMgEN0/X60FBouYcE5PeHi17pX2+Z/vM
	 Dpw2XRkurhMSaT9nIP/OPnIeZpvXYXMxHeyFuMokktQVRbS9CwgrTfoLrpduY4EFn9kYT
	 pUbA616CkJd7s56UlPZMeJn3rRL9mzqkiGlaXrGjoQLkHeeH0rKXkNeN2Ye8sooXylE2C
	 7/XlEIvfS598+ZBGR8Oqt32Y4th6ei+zqQoPAQ/Sp5MUVaAk35m9D47uNMMYR3xJUpdcb
	 eXz4ziQRpxmEI6okuLuTc8WSuyzv/UQ6q2OLLrhO79yGxDgyykH2BRS5FTz/v3if9lg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="RPx/4bgv";
	arc=none smtp.remote-ip=74.125.231.75
Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com
 [74.125.231.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6582CF800B5
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2026 07:45:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6582CF800B5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RPx/4bgv
Received: by mail-oa2-f11.google.com with SMTP id
 586e51a60fabf-4a77fe1bc0bso1207171fac.0
        for <alsa-devel@alsa-project.org>;
 Sun, 22 Nov 2026 22:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416304; x=1796021104;
 darn=alsa-project.org;
        h=from:content-language:subject:cc:to:user-agent:mime-version:date
         :message-id:content-type:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CkVLRbZmroDEA4bHwK7ENmgK431SZ8RdLQBT6GBFXbg=;
        b=RPx/4bgv/rsESlG/8soe3ttBy2dfk2WLXhurzRC3sb8mj3lpIS2v3Owm51wKpYptPf
         VaWZh8tVRVOZYC4KgG5SsEYfgqw36U059kv3fzgwHaGAmFpG6tk7tcZw4IGVBpsODUaO
         nm7+IY0yRJfJHa3n5PlRtRB3U1hX4NnL4ZSrdO3aG6tsqXtHE+bDwBzSzCmPPTtgUR4A
         OpixKzGwUkWfRw1nhWYUo6XrGkKudVSAqNM1n1XpH2Peel+iJhCEc9crA0/GC3fXgIQq
         cRppZgT4dbGHl+9zxz9CmfqEodjRuFreSorpxT2UXjG4Kj1icAdY/ceZTd5QqyU3a9dj
         jJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416304; x=1796021104;
        h=from:content-language:subject:cc:to:user-agent:mime-version:date
         :message-id:content-type:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CkVLRbZmroDEA4bHwK7ENmgK431SZ8RdLQBT6GBFXbg=;
        b=ArWG1qNlIAKzE7mFUm0UBLN7J9e+Tq4CSCs5LQz2iY+sdhL8wG5brxuxE9du609A79
         TKUpYUo0YNI+7O282J52vXFyOoOemYG3eCPanXhuEFXru5UMkhCq3XqYtXc4v/mM7qNw
         XkIPdd5eiEG9dwjLvH8A2+nqRsRwItuaHPAOJSutqshYVGmVHM8kqwou2WxrDoZVs1IK
         tuXdM7Q79rc+pEfhYidTTe7nInnqXCahhpr1EX6ziOgyfOxyt0/9NPMKOvTxEah2QMyT
         i4R8G7vVCbJSJjS3anFpcmZE05XlAyJWnl4WAWxeleM7OYIUpK5px+vX+RzgiNYZ8s5J
         yALA==
X-Gm-Message-State: APuU4Z+8k9mQWh3kCaalNcjcXp9QvQgt2jdmFm2Y/UJi2/Js8+EM6OGd
	zan04GvT7kRZl5fPbvjIvobRutujiPXzzHrN7k72vjijdrcoQuWdVQqx5TzoYi2A4oBOyg==
X-Gm-Gg: AZFdTZe7FXLu2N3RzHDl6fEkzTbeAsvWa8Us3VH8RMvjGO0ofOygi2fbu15SdMmoyGw
	uycpK3MH+9x5G8jnW/GoddfxTgT+hgnoY6CTI4NSkFx1JfjR1OKqvX+S5ZOyEKk7bcj8s+2eNv7
	ug+gGLRtUjg7hThxZH0SFkGCfIyVguR+gTrITO1HTWRSNqnYuzf+Zb28VotSjbSnsT+jYsrgXI8
	q/JXGlXQEgW9MiCyL7oHV9Iugo+DjH90fMZMYL0MTFp0U9gczHTK9lTi9uoqFxgcCl7fxZDskbJ
	BmYkLnM8t66WWQC3Q1cGhAexmxrVcBKStFnO8NF90NkWRjts/evLmpB96HIIauxWMDAU2P75Kvw
	O58UfkDeV+13degYUmCxO1J+mqBY4ixvm+6oowe7ldPnKcIpDybQBKVUdkmDF4r2wYXoAES0wDd
	pBMODvcy5S5DXGU8UYuQ48129kPNjIM/vMGhLLbr9fd25/jwmnZnQlM6fKByWusSZDB0h8tPTpA
	O5NnJK5QBx0TvxoXvvaXRtBTqyeYWfU/v0R0MaNxlWRHNW6lSaRSwajnOi+euu85sn26nUqPEW9
	EcARyOo+m+EAyfBDiaTOOB4eTfsH
X-Received: by 2002:a17:902:f609:b0:2ef:f61c:f72 with SMTP id
 d9443c01a7336-2f03f1beeebmr93697915ad.72.1795415838292;
        Sun, 22 Nov 2026 22:37:18 -0800 (PST)
Received: from [198.18.0.1] ([117.174.170.61])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f04913a77csm39858215ad.34.2026.11.22.22.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 22:37:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------clqANTxl0gfzoJEWvXn1dIAG"
Message-ID: <59a8eaf5-d406-4996-8834-e45a8c45516f@gmail.com>
Date: Sun, 22 Nov 2026 22:37:14 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Subject: [BUG] sof_sdw Xiaomi Book Pro 14 TM2424 speakers randomly silent -
 SoundWire link 3 rt721+rt1320 bus clash
Content-Language: en-US
From: wqy <qianywu@gmail.com>
X-MailFrom: qianywu@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: U2AZK3FYSL5JFETDEDGCOHWXE42FEPGH
X-Message-ID-Hash: U2AZK3FYSL5JFETDEDGCOHWXE42FEPGH
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:15 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U2AZK3FYSL5JFETDEDGCOHWXE42FEPGH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

This is a multi-part message in MIME format.
--------------clqANTxl0gfzoJEWvXn1dIAG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[BUG] sof_sdw: Xiaomi Book Pro 14 (TM2424, PTL) internal speakers randomly
 go silent; SoundWire link 3 rt721+rt1320 reports bus clash / parity error

TL;DR
-----
Internal speakers on the Xiaomi Book Pro 14 2026 (TM2424, Panther Lake)
randomly stop producing sound while PipeWire still reports RUNNING and
the mixer state is untouched. dmesg shows Bus clash / Parity error on
SoundWire link 3 (RT721 + RT1320). A card profile toggle (bus reset)
restores audio without a reboot. No board match entry or DMI quirk
exists for this machine, so the generic machine driver with function
topologies is used.

Environment
-----------
  Machine   : XIAOMI Xiaomi Book Pro 14, board TM2424 V14E1,
              SKU TM2424-77079
  BIOS      : XMAPT4B0P0A0A (2026-06-17)
  CPU       : Intel Core Ultra X7 358H (Panther Lake)
  Audio PCI : 8086:e428
  Kernel    : 7.3.5-2-cachyos (distro build, no external audio patches)
  Userspace : PipeWire 1.6.11, WirePlumber, alsa-ucm-conf
  Codecs link 3: 025d:0721:01 RT721, 025d:1320:01 RT1320

Boot log:

  sof-audio-pci-intel-ptl 0000:00:1f.3: No SoundWire machine driver found
    for the ACPI-reported configuration:
  sof-audio-pci-intel-ptl 0000:00:1f.3: link 3 mfg_id 0x025d part_id 0x0721
    version 0x3
  sof-audio-pci-intel-ptl 0000:00:1f.3: link 3 mfg_id 0x025d part_id 0x1320
    version 0x3
  sof-audio-pci-intel-ptl 0000:00:1f.3: Use SoundWire default machine driver
    with function topologies

Loaded topologies: sof-sdca-jack-id0.tplg, sof-sdca-mic-id4.tplg,
sof-sdca-1amp-id2.tplg.

Symptom
-------
Playback to the internal speakers works after boot, then at some point
stops producing sound. Userspace sees nothing wrong:

  pactl:  State: RUNNING, Mute: no, volume 70%
  amixer: 'Speaker' [on], 'rt1320-1 FU21' 87/87 (100%)

aplay / speaker-test also open the PCM and "play" without error.

Recovery (no reboot)
--------------------
  pactl set-card-profile alsa_card.pci-0000_00_1f.3-platform-sof_sdw off
  sleep 1
  pactl set-card-profile alsa_card.pci-0000_00_1f.3-platform-sof_sdw HiFi

Sound comes back immediately and no further link errors are logged. This
is consistent with the bus reset described in
Documentation/driver-api/soundwire/error_handling.rst ("after a number
of such errors are detected the bus might be reset").

dmesg around the failure
------------------------
Suspend/resume in the same boot: 01:46, 01:48, 01:50, 01:51, 10:28,
15:35, 20:27, 20:42.

  Nov 22 17:55:48 soundwire_intel.link.3: Bus clash for control word
  Nov 22 17:55:48 soundwire_intel.link.3: Bus clash for data word
  Nov 22 17:55:48 rt1320-sdca sdw:0:3:025d:1320:01: Bus clash detected
  Nov 22 18:00:06 soundwire_intel.link.3: Bus clash for control word
  Nov 22 18:00:06 soundwire_intel.link.3: Bus clash for data word
  Nov 22 18:11:10 soundwire_intel.link.3: Bus clash for control word
  Nov 22 18:11:10 soundwire_intel.link.3: Bus clash for data word
  Nov 22 18:19:36 soundwire_intel.link.3: Bus clash for control word
  Nov 22 18:19:36 soundwire_intel.link.3: Bus clash for data word
  Nov 22 20:42:15 rt721-sdca sdw:0:3:025d:0721:01: Bus clash detected before
    INT mask is enabled
  Nov 22 22:01:22 soundwire_intel.link.3: Bus clash for data word
  Nov 22 22:05:50 soundwire_intel.link.3: Parity error
  Nov 22 22:05:50 soundwire_intel.link.3: Bus clash for control word
  Nov 22 22:05:50 soundwire_intel.link.3: Bus clash for data word
  Nov 22 22:05:50 rt721-sdca sdw:0:3:025d:0721:01: Parity error detected
  Nov 22 22:09:50 soundwire_intel.link.3: Bus clash for control word
  Nov 22 22:09:50 soundwire_intel.link.3: Bus clash for data word

Notes:
- The clashes at 17:55-18:19 have no suspend nearby, so this is not only
  a resume path problem.
- 20:42:15 is the resume instant; that one matches the known spurious
  "clash before INT mask is enabled" pattern.
- At 22:05 / 22:09 both master and slave report errors, i.e. actual data
  word corruption on the wire.

Extra observation: -61 on the RT721 endpoints after the bus reset
----------------------------------------------------------------
Right after re-initialising the card, the speaker path comes back but
the jack/mic endpoints fail with -ENODEV:

  rt721-sdca sdw:0:3:025d:0721:01: ASoC error (-61): at
    snd_soc_pcm_component_pm_runtime_get() on sdw:0:3:025d:0721:01
   SDW3-Playback-SimpleJack: ASoC error (-61): at __soc_pcm_open()
   Jack Out: ASoC error (-61): at dpcm_be_dai_startup()
   SDW3-Capture-SmartMic: ASoC error (-61): at __soc_pcm_open()

Runtime PM state of link 3
--------------------------
  sdw:0:3:025d:0721:01: control=auto status=suspended
  sdw:0:3:025d:1320:01: control=auto status=suspended

Both peripherals autosuspend (SoundWire clock stop) when idle; the
silence occurs on the idle -> streaming transition.

Why I think it is not a hardware fault
--------------------------------------
- The same RT1320 plays fine right after a bus reset, no reboot, same
  mixer values.
- Both peripherals stay Attached; their controls remain readable.
- No error is surfaced to userspace, which is the main annoyance.

Related reports on other PTL machines (same codec family, generic fallback)
--------------------------------------------------------------------------
- Lenovo Yoga Slim 7i 14IPH11 (83QM): rt721 + rt1320 on link 3, a ghost
  RT722 in ACPI makes the default machine driver misbuild the card, -61
  and silence; DMI quirk proposed (ptl_sdw_rt721_l3_rt1320_l3, and the
  ghost must be dropped).
- MSI Prestige 16 AI+ C3MG: RT1320 + RT713, silent internal speakers with
  the generic fallback.
- Surface Pro 11 (Intel): DMI quirk for a ghost RT1320.

On TM2424 there is no ghost RT722 - only 0721 and 1320 are enumerated on
link 3 - so the Lenovo quirk does not directly apply.

Questions
---------
1. Is this a known SoundWire clock-stop/restart race on PTL with
   RT721 + RT1320, or should TM2424 get its own soc-acpi match entry /
   DMI quirk so the machine driver knows the two-peripheral layout?
2. Is -61 from snd_soc_pcm_component_pm_runtime_get() on the RT721
   endpoints after a bus reset expected, or a second issue?
3. Would setting power/control = on for the link 3 peripherals be a
   valid way to confirm the clock-stop theory? I am happy to test
   patches, module parameters, or debugfs changes on this hardware.

Attachments
-----------
- alsa-info.txt     full alsa-info.sh dump
- dmesg-audio.txt   filtered sof/sdw/rt1320/rt721 log
- hardware.txt      DMI, kernel, lspci, aplay -l
- card-info.txt     /proc/asound cards and pcm

Thanks,
wqy <qianywu@gmail.com>
--------------clqANTxl0gfzoJEWvXn1dIAG
Content-Type: text/plain; charset=UTF-8; name="alsa-info.txt"
Content-Disposition: attachment; filename="alsa-info.txt"
Content-Transfer-Encoding: base64

dXBsb2FkPXRydWUmc2NyaXB0PXRydWUmY2FyZGluZm89CiEhIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKISFBTFNBIEluZm9ybWF0aW9uIFNjcmlwdCB2IDAuNS40CiEhIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKCiEhU2NyaXB0IHJhbiBvbjogTW9uIE5v
diAyMyAwNjoxNTo1NyBVVEMgMjAyNgoKCiEhTGludXggRGlzdHJpYnV0aW9uCiEhLS0tLS0t
LS0tLS0tLS0tLS0tCgpJRF9MSUtFPWFyY2ggUFJJVkFDWV9QT0xJQ1lfVVJMPSJodHRwczov
L3Rlcm1zLmFyY2hsaW51eC5vcmcvZG9jcy9wcml2YWN5LXBvbGljeS8iCgoKISFETUkgSW5m
b3JtYXRpb24KISEtLS0tLS0tLS0tLS0tLS0KCk1hbnVmYWN0dXJlcjogICAgICBYSUFPTUkK
UHJvZHVjdCBOYW1lOiAgICAgIFhpYW9taSBCb29rIFBybyAxNApQcm9kdWN0IFZlcnNpb246
ICAgCkZpcm13YXJlIFZlcnNpb246ICBYTUFQVDRCMFAwQTBBClN5c3RlbSBTS1U6ICAgICAg
ICBUTTI0MjQtNzcwNzkKQm9hcmQgVmVuZG9yOiAgICAgIFhJQU9NSQpCb2FyZCBOYW1lOiAg
ICAgICAgVE0yNDI0CgoKISFBQ1BJIERldmljZSBTdGF0dXMgSW5mb3JtYXRpb24KISEtLS0t
LS0tLS0tLS0tLS0KCi9zeXMvYnVzL2FjcGkvZGV2aWNlcy9BQ1BJMDAwQzowMC9zdGF0dXMg
CSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMvQUNQSTAwMEU6MDAvc3RhdHVzIAkgMTUKL3N5
cy9idXMvYWNwaS9kZXZpY2VzL0JMVFA3ODUzOjAwL3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2Fj
cGkvZGV2aWNlcy9JTlQzM0ExOjAwL3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNl
cy9JTlQzNDBFOjAwL3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9JTlRDMTA5
RDowMC9zdGF0dXMgCSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMvSU5UQzEwQkM6MDAvc3Rh
dHVzIAkgMTUKL3N5cy9idXMvYWNwaS9kZXZpY2VzL0lOVEMxMEJDOjAxL3N0YXR1cyAJIDE1
Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9JTlRDMTBCQzowMi9zdGF0dXMgCSAxNQovc3lzL2J1
cy9hY3BpL2RldmljZXMvSU5UQzEwQkM6MDMvc3RhdHVzIAkgMTUKL3N5cy9idXMvYWNwaS9k
ZXZpY2VzL0lOVEMxMEJDOjA0L3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9J
TlRDMTBENDowMC9zdGF0dXMgCSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMvSU5UQzEwRDU6
MDAvc3RhdHVzIAkgMTUKL3N5cy9idXMvYWNwaS9kZXZpY2VzL0lOVEMxMEQ1OjAxL3N0YXR1
cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9JTlRDMTBENTowMi9zdGF0dXMgCSAxNQov
c3lzL2J1cy9hY3BpL2RldmljZXMvSU5UQzEwRDU6MDMvc3RhdHVzIAkgMTUKL3N5cy9idXMv
YWNwaS9kZXZpY2VzL0lOVEMxMEQ1OjA0L3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2
aWNlcy9JTlRDMTBENTowNS9zdGF0dXMgCSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMvSU5U
QzcwMDI6MDAvc3RhdHVzIAkgMTUKL3N5cy9idXMvYWNwaS9kZXZpY2VzL0lPVEQwMDAwOjAw
L3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9MTlhQT1dFUjowMC9zdGF0dXMg
CSAxCi9zeXMvYnVzL2FjcGkvZGV2aWNlcy9MTlhQT1dFUjowMS9zdGF0dXMgCSAxCi9zeXMv
YnVzL2FjcGkvZGV2aWNlcy9MTlhQT1dFUjowNS9zdGF0dXMgCSAxCi9zeXMvYnVzL2FjcGkv
ZGV2aWNlcy9NU0ZUMDAwMTowMC9zdGF0dXMgCSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMv
TlRBRzUzMzI6MDAvc3RhdHVzIAkgMTUKL3N5cy9idXMvYWNwaS9kZXZpY2VzL1BOUDAxMDM6
MDAvc3RhdHVzIAkgMTUKL3N5cy9idXMvYWNwaS9kZXZpY2VzL1BOUDBBMDU6MDAvc3RhdHVz
IAkgMTUKL3N5cy9idXMvYWNwaS9kZXZpY2VzL1BOUDBBMDU6MDEvc3RhdHVzIAkgMTUKL3N5
cy9idXMvYWNwaS9kZXZpY2VzL1BOUDBDMDI6MDEvc3RhdHVzIAkgOAovc3lzL2J1cy9hY3Bp
L2RldmljZXMvUE5QMEMwMjowMi9zdGF0dXMgCSA4Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9Q
TlAwQzAyOjA0L3N0YXR1cyAJIDgKL3N5cy9idXMvYWNwaS9kZXZpY2VzL1BOUDBDMDI6MDYv
c3RhdHVzIAkgMwovc3lzL2J1cy9hY3BpL2RldmljZXMvUE5QMEMwMjowNy9zdGF0dXMgCSAz
Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9QTlAwQzBBOjAwL3N0YXR1cyAJIDMxCi9zeXMvYnVz
L2FjcGkvZGV2aWNlcy9QTlAwQzBDOjAwL3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2
aWNlcy9QUlAwMDAwMTowMC9zdGF0dXMgCSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMvUFJQ
MDAwMDE6MDEvc3RhdHVzIAkgMTEKL3N5cy9idXMvYWNwaS9kZXZpY2VzL1BSUDAwMDAxOjAy
L3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9QUlAwMDAwMTowMy9zdGF0dXMg
CSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMvVVNCQzAwMDowMC9zdGF0dXMgCSAxNQovc3lz
L2J1cy9hY3BpL2RldmljZXMvZGV2aWNlOjA1L3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkv
ZGV2aWNlcy9kZXZpY2U6MjQvc3RhdHVzIAkgMTUKL3N5cy9idXMvYWNwaS9kZXZpY2VzL2Rl
dmljZTozNi9zdGF0dXMgCSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMvZGV2aWNlOjM3L3N0
YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9kZXZpY2U6Mzgvc3RhdHVzIAkgMTUK
L3N5cy9idXMvYWNwaS9kZXZpY2VzL2RldmljZTozYS9zdGF0dXMgCSAxNQovc3lzL2J1cy9h
Y3BpL2RldmljZXMvZGV2aWNlOjNiL3N0YXR1cyAJIDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNl
cy9kZXZpY2U6M2Mvc3RhdHVzIAkgMTUKL3N5cy9idXMvYWNwaS9kZXZpY2VzL2RldmljZTo1
Ny9zdGF0dXMgCSAxNQovc3lzL2J1cy9hY3BpL2RldmljZXMvZGV2aWNlOjVmL3N0YXR1cyAJ
IDE1Ci9zeXMvYnVzL2FjcGkvZGV2aWNlcy9kZXZpY2U6NjQvc3RhdHVzIAkgMTUKCgohIUFD
UEkgU291bmRXaXJlIERldmljZSBTdGF0dXMgSW5mb3JtYXRpb24KISEtLS0tLS0tLS0tLS0t
LS0KClJlYWx0ZWsgMHgwMDAzMzAwMjVkMDcyMTAxClJlYWx0ZWsgMHgwMDAzMzAwMjVkMTMy
MDAxCgoKISFLZXJuZWwgSW5mb3JtYXRpb24KISEtLS0tLS0tLS0tLS0tLS0tLS0KCktlcm5l
bCByZWxlYXNlOiAgICAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSwgMjAgTm92IDIwMjYg
MTk6MzQ6MTUgKzAwMDAKT3BlcmF0aW5nIFN5c3RlbTogIEdOVS9MaW51eApBcmNoaXRlY3R1
cmU6ICAgICAgeDg2XzY0ClByb2Nlc3NvcjogICAgICAgICB1bmtub3duClNNUCBFbmFibGVk
OiAgICAgICBZZXMKCgohIUFMU0EgVmVyc2lvbgohIS0tLS0tLS0tLS0tLQoKRHJpdmVyIHZl
cnNpb246ICAgICBrNy4zLjUtMi1jYWNoeW9zCkxpYnJhcnkgdmVyc2lvbjogICAgMS4yLjE2
LjEKVXRpbGl0aWVzIHZlcnNpb246ICAxLjIuMTYKCgohIUxvYWRlZCBBTFNBIG1vZHVsZXMK
ISEtLS0tLS0tLS0tLS0tLS0tLS0tCgpzbmRfc29jX3NvZl9zZHcgKGNhcmQgMCkKCgohIVNv
dW5kIFNlcnZlcnMgb24gdGhpcyBzeXN0ZW0KISEtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCgpQaXBlV2lyZToKICAgICAgSW5zdGFsbGVkIC0gWWVzICgvdXNyL2Jpbi9waXBld2ly
ZSkKICAgICAgUnVubmluZyAtIFllcwoKSmFjazoKICAgICAgSW5zdGFsbGVkIC0gWWVzICgv
dXNyL2Jpbi9qYWNrZCkKICAgICAgUnVubmluZyAtIE5vCgoKISFTb3VuZGNhcmRzIHJlY29n
bmlzZWQgYnkgQUxTQQohIS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgogMCBbc29m
c291bmR3aXJlICAgXTogc29mLXNvdW5kd2lyZSAtIHNvZi1zb3VuZHdpcmUKICAgICAgICAg
ICAgICAgICAgICAgIFhJQU9NSS1YaWFvbWlCb29rUHJvMTQtVE0yNDI0CgoKISFQQ0kgU291
bmRjYXJkcyBpbnN0YWxsZWQgaW4gdGhlIHN5c3RlbQohIS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCgowMDoxZi4zIE11bHRpbWVkaWEgYXVkaW8gY29udHJvbGxl
ciBbMDQwMV06IEludGVsIENvcnBvcmF0aW9uIENvcmUgVWx0cmEgUHJvY2Vzc29ycyAoU2Vy
aWVzIDMpIEhEIEF1ZGlvIFs4MDg2OmU0MjhdIChyZXYgMDEpCglTdWJzeXN0ZW06IFhpYW9t
aSBEZXZpY2UgWzFkNzI6MjQyNF0KCgohIUxvYWRlZCBzb3VuZCBtb2R1bGUgb3B0aW9ucwoh
IS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKISFNb2R1bGU6IHNuZF9zb2Nfc29mX3Nk
dwoJcXVpcmsgOiAtMQoKCiEhU3lzZnMgY2FyZCBpbmZvCiEhLS0tLS0tLS0tLS0tLS0tCgoh
IUNhcmQ6IC9zeXMvY2xhc3Mvc291bmQvY2FyZDAKRHJpdmVyOiAvc3lzL2J1cy9wbGF0Zm9y
bS9kcml2ZXJzL3NvZl9zZHcKVHJlZToKCgohIVN5c2ZzIGN0bC1sZWQgaW5mbwohIS0tLS0t
LS0tLS0tLS0tLQoKISFDVEwtTEVEOiAvc3lzL2NsYXNzL3NvdW5kL2N0bC1sZWQvbWljL2Nh
cmQwCkxpc3Q6IAoKISFDVEwtTEVEOiAvc3lzL2NsYXNzL3NvdW5kL2N0bC1sZWQvc3BlYWtl
ci9jYXJkMApMaXN0OiA3MCA2OQoKISFIREEtSW50ZWwgQ29kZWMgaW5mb3JtYXRpb24KISEt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KLS1zdGFydGNvbGxhcHNlLS0KCkNvZGVjOiBJ
bnRlbCBQYW50aGVyIExha2UgSERNSQpBZGRyZXNzOiAyCkFGRyBGdW5jdGlvbiBJZDogMHgx
ICh1bnNvbCAwKQpWZW5kb3IgSWQ6IDB4ODA4NjI4MjIKU3Vic3lzdGVtIElkOiAweDgwODYw
MTAxClJldmlzaW9uIElkOiAweDEwMDAwMApObyBNb2RlbSBGdW5jdGlvbiBHcm91cCBmb3Vu
ZApEZWZhdWx0IFBDTToKICAgIHJhdGVzIFsweDBdOgogICAgYml0cyBbMHgwXToKICAgIGZv
cm1hdHMgWzB4MF06CkRlZmF1bHQgQW1wLUluIGNhcHM6IE4vQQpEZWZhdWx0IEFtcC1PdXQg
Y2FwczogTi9BClN0YXRlIG9mIEFGRyBub2RlIDB4MDE6CiAgUG93ZXIgc3RhdGVzOiAgRDAg
RDMgQ0xLU1RPUCBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMCwgQ2xvY2st
c3RvcC1PSwpHUElPOiBpbz0wLCBvPTAsIGk9MCwgdW5zb2xpY2l0ZWQ9MCwgd2FrZT0wCk5v
ZGUgMHgwMyBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDY2MTE6IDgtQ2hhbm5lbHMgRGlnaXRh
bAogIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5uZWw9MAogIERpZ2l0YWw6IEVuYWJsZWQK
ICBEaWdpdGFsIGNhdGVnb3J5OiAweDAKICBJRUMgQ29kaW5nIFR5cGU6IDB4MAogIFBDTToK
ICAgIHJhdGVzIFsweDdmMF06IDMyMDAwIDQ0MTAwIDQ4MDAwIDg4MjAwIDk2MDAwIDE3NjQw
MCAxOTIwMDAKICAgIGJpdHMgWzB4MWFdOiAxNiAyNCAzMgogICAgZm9ybWF0cyBbMHg1XTog
UENNIEFDMwogIFBvd2VyIHN0YXRlczogIEQwIEQzIEVQU1MKICBQb3dlcjogc2V0dGluZz1E
MCwgYWN0dWFsPUQwCk5vZGUgMHgwNCBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDA3NzhkOiA4
LUNoYW5uZWxzIERpZ2l0YWwgQW1wLU91dCBDUAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAs
IG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBb
MHgwMCAweDAwXQogIFBpbmNhcCAweDA5MDAwMDk0OiBPVVQgRGV0ZWN0IEhCUiBIRE1JIERQ
CiAgUGluIERlZmF1bHQgMHgxODU2MDAxMDogW0phY2tdIERpZ2l0YWwgT3V0IGF0IEludCBI
RE1JCiAgICBDb25uID0gRGlnaXRhbCwgQ29sb3IgPSBVbmtub3duCiAgICBEZWZBc3NvY2lh
dGlvbiA9IDB4MSwgU2VxdWVuY2UgPSAweDAKICBQaW4tY3RsczogMHgwMDoKICBVbnNvbGlj
aXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQb3dlciBzdGF0ZXM6ICBEMCBEMyBFUFNTCiAg
UG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAogIERldmljZXM6IDAKICBDb25uZWN0aW9u
OiAwCk5vZGUgMHgwNSBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDY2MTE6IDgtQ2hhbm5lbHMg
RGlnaXRhbAogIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5uZWw9MAogIERpZ2l0YWw6IEVu
YWJsZWQKICBEaWdpdGFsIGNhdGVnb3J5OiAweDAKICBJRUMgQ29kaW5nIFR5cGU6IDB4MAog
IFBDTToKICAgIHJhdGVzIFsweDdmMF06IDMyMDAwIDQ0MTAwIDQ4MDAwIDg4MjAwIDk2MDAw
IDE3NjQwMCAxOTIwMDAKICAgIGJpdHMgWzB4MWFdOiAxNiAyNCAzMgogICAgZm9ybWF0cyBb
MHg1XTogUENNIEFDMwogIFBvd2VyIHN0YXRlczogIEQwIEQzIEVQU1MKICBQb3dlcjogc2V0
dGluZz1EMCwgYWN0dWFsPUQwCk5vZGUgMHgwNiBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDA3
NzhkOiA4LUNoYW5uZWxzIERpZ2l0YWwgQW1wLU91dCBDUAogIEFtcC1PdXQgY2Fwczogb2Zz
PTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZh
bHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAweDA5MDAwMDk0OiBPVVQgRGV0ZWN0IEhCUiBI
RE1JIERQCiAgUGluIERlZmF1bHQgMHgxODU2MDAxMDogW0phY2tdIERpZ2l0YWwgT3V0IGF0
IEludCBIRE1JCiAgICBDb25uID0gRGlnaXRhbCwgQ29sb3IgPSBVbmtub3duCiAgICBEZWZB
c3NvY2lhdGlvbiA9IDB4MSwgU2VxdWVuY2UgPSAweDAKICBQaW4tY3RsczogMHgwMDoKICBV
bnNvbGljaXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQb3dlciBzdGF0ZXM6ICBEMCBEMyBF
UFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAogIERldmljZXM6IDAKICBDb25u
ZWN0aW9uOiAwCk5vZGUgMHgwNyBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDY2MTE6IDgtQ2hh
bm5lbHMgRGlnaXRhbAogIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5uZWw9MAogIERpZ2l0
YWw6IEVuYWJsZWQKICBEaWdpdGFsIGNhdGVnb3J5OiAweDAKICBJRUMgQ29kaW5nIFR5cGU6
IDB4MAogIFBDTToKICAgIHJhdGVzIFsweDdmMF06IDMyMDAwIDQ0MTAwIDQ4MDAwIDg4MjAw
IDk2MDAwIDE3NjQwMCAxOTIwMDAKICAgIGJpdHMgWzB4MWFdOiAxNiAyNCAzMgogICAgZm9y
bWF0cyBbMHg1XTogUENNIEFDMwogIFBvd2VyIHN0YXRlczogIEQwIEQzIEVQU1MKICBQb3dl
cjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCk5vZGUgMHgwOCBbUGluIENvbXBsZXhdIHdjYXBz
IDB4NDA3NzhkOiA4LUNoYW5uZWxzIERpZ2l0YWwgQW1wLU91dCBDUAogIEFtcC1PdXQgY2Fw
czogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAt
T3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAweDA5MDAwMDk0OiBPVVQgRGV0ZWN0
IEhCUiBIRE1JIERQCiAgUGluIERlZmF1bHQgMHgxODU2MDAxMDogW0phY2tdIERpZ2l0YWwg
T3V0IGF0IEludCBIRE1JCiAgICBDb25uID0gRGlnaXRhbCwgQ29sb3IgPSBVbmtub3duCiAg
ICBEZWZBc3NvY2lhdGlvbiA9IDB4MSwgU2VxdWVuY2UgPSAweDAKICBQaW4tY3RsczogMHgw
MDoKICBVbnNvbGljaXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQb3dlciBzdGF0ZXM6ICBE
MCBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAogIERldmljZXM6IDAK
ICBDb25uZWN0aW9uOiAwCk5vZGUgMHgwOSBbQXVkaW8gT3V0cHV0XSB3Y2FwcyAweDY2MTE6
IDgtQ2hhbm5lbHMgRGlnaXRhbAogIENvbnZlcnRlcjogc3RyZWFtPTAsIGNoYW5uZWw9MAog
IERpZ2l0YWw6IEVuYWJsZWQKICBEaWdpdGFsIGNhdGVnb3J5OiAweDAKICBJRUMgQ29kaW5n
IFR5cGU6IDB4MAogIFBDTToKICAgIHJhdGVzIFsweDdmMF06IDMyMDAwIDQ0MTAwIDQ4MDAw
IDg4MjAwIDk2MDAwIDE3NjQwMCAxOTIwMDAKICAgIGJpdHMgWzB4MWFdOiAxNiAyNCAzMgog
ICAgZm9ybWF0cyBbMHg1XTogUENNIEFDMwogIFBvd2VyIHN0YXRlczogIEQwIEQzIEVQU1MK
ICBQb3dlcjogc2V0dGluZz1EMCwgYWN0dWFsPUQwCk5vZGUgMHgwYSBbUGluIENvbXBsZXhd
IHdjYXBzIDB4NDA3NzhkOiA4LUNoYW5uZWxzIERpZ2l0YWwgQW1wLU91dCBDUAogIEFtcC1P
dXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEK
ICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAweDA5MDAwMDk0OiBPVVQg
RGV0ZWN0IEhCUiBIRE1JIERQCiAgUGluIERlZmF1bHQgMHgxODU2MDAxMDogW0phY2tdIERp
Z2l0YWwgT3V0IGF0IEludCBIRE1JCiAgICBDb25uID0gRGlnaXRhbCwgQ29sb3IgPSBVbmtu
b3duCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MSwgU2VxdWVuY2UgPSAweDAKICBQaW4tY3Rs
czogMHgwMDoKICBVbnNvbGljaXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQb3dlciBzdGF0
ZXM6ICBEMCBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAogIERldmlj
ZXM6IDAKICBDb25uZWN0aW9uOiAwCk5vZGUgMHgwYiBbUGluIENvbXBsZXhdIHdjYXBzIDB4
NDA3NzhkOiA4LUNoYW5uZWxzIERpZ2l0YWwgQW1wLU91dCBDUAogIEFtcC1PdXQgY2Fwczog
b2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0
IHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAweDA5MDAwMDk0OiBPVVQgRGV0ZWN0IEhC
UiBIRE1JIERQCiAgUGluIERlZmF1bHQgMHgxODU2MDAxMDogW0phY2tdIERpZ2l0YWwgT3V0
IGF0IEludCBIRE1JCiAgICBDb25uID0gRGlnaXRhbCwgQ29sb3IgPSBVbmtub3duCiAgICBE
ZWZBc3NvY2lhdGlvbiA9IDB4MSwgU2VxdWVuY2UgPSAweDAKICBQaW4tY3RsczogMHgwMDoK
ICBVbnNvbGljaXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQb3dlciBzdGF0ZXM6ICBEMCBE
MyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAogIERldmljZXM6IDAKICBD
b25uZWN0aW9uOiAwCk5vZGUgMHgwYyBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDA3NzhkOiA4
LUNoYW5uZWxzIERpZ2l0YWwgQW1wLU91dCBDUAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAs
IG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBb
MHgwMCAweDAwXQogIFBpbmNhcCAweDA5MDAwMDk0OiBPVVQgRGV0ZWN0IEhCUiBIRE1JIERQ
CiAgUGluIERlZmF1bHQgMHgxODU2MDAxMDogW0phY2tdIERpZ2l0YWwgT3V0IGF0IEludCBI
RE1JCiAgICBDb25uID0gRGlnaXRhbCwgQ29sb3IgPSBVbmtub3duCiAgICBEZWZBc3NvY2lh
dGlvbiA9IDB4MSwgU2VxdWVuY2UgPSAweDAKICBQaW4tY3RsczogMHgwMDoKICBVbnNvbGlj
aXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQb3dlciBzdGF0ZXM6ICBEMCBEMyBFUFNTCiAg
UG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1EMAogIERldmljZXM6IDAKICBDb25uZWN0aW9u
OiAwCk5vZGUgMHgwZCBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDA3NzhkOiA4LUNoYW5uZWxz
IERpZ2l0YWwgQW1wLU91dCBDUAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0w
eDAwLCBzdGVwc2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAw
XQogIFBpbmNhcCAweDA5MDAwMDk0OiBPVVQgRGV0ZWN0IEhCUiBIRE1JIERQCiAgUGluIERl
ZmF1bHQgMHgxODU2MDAxMDogW0phY2tdIERpZ2l0YWwgT3V0IGF0IEludCBIRE1JCiAgICBD
b25uID0gRGlnaXRhbCwgQ29sb3IgPSBVbmtub3duCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4
MSwgU2VxdWVuY2UgPSAweDAKICBQaW4tY3RsczogMHgwMDoKICBVbnNvbGljaXRlZDogdGFn
PTAwLCBlbmFibGVkPTAKICBQb3dlciBzdGF0ZXM6ICBEMCBEMyBFUFNTCiAgUG93ZXI6IHNl
dHRpbmc9RDAsIGFjdHVhbD1EMAogIERldmljZXM6IDAKICBDb25uZWN0aW9uOiAwCk5vZGUg
MHgwZSBbUGluIENvbXBsZXhdIHdjYXBzIDB4NDA3NzhkOiA4LUNoYW5uZWxzIERpZ2l0YWwg
QW1wLU91dCBDUAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVw
c2l6ZT0weDAwLCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNh
cCAweDA5MDAwMDk0OiBPVVQgRGV0ZWN0IEhCUiBIRE1JIERQCiAgUGluIERlZmF1bHQgMHgx
ODU2MDAxMDogW0phY2tdIERpZ2l0YWwgT3V0IGF0IEludCBIRE1JCiAgICBDb25uID0gRGln
aXRhbCwgQ29sb3IgPSBVbmtub3duCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MSwgU2VxdWVu
Y2UgPSAweDAKICBQaW4tY3RsczogMHgwMDoKICBVbnNvbGljaXRlZDogdGFnPTAwLCBlbmFi
bGVkPTAKICBQb3dlciBzdGF0ZXM6ICBEMCBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAs
IGFjdHVhbD1EMAogIERldmljZXM6IDAKICBDb25uZWN0aW9uOiAwCk5vZGUgMHgwZiBbUGlu
IENvbXBsZXhdIHdjYXBzIDB4NDA3NzhkOiA4LUNoYW5uZWxzIERpZ2l0YWwgQW1wLU91dCBD
UAogIEFtcC1PdXQgY2Fwczogb2ZzPTB4MDAsIG5zdGVwcz0weDAwLCBzdGVwc2l6ZT0weDAw
LCBtdXRlPTEKICBBbXAtT3V0IHZhbHM6ICBbMHgwMCAweDAwXQogIFBpbmNhcCAweDA5MDAw
MDk0OiBPVVQgRGV0ZWN0IEhCUiBIRE1JIERQCiAgUGluIERlZmF1bHQgMHgxODU2MDAxMDog
W0phY2tdIERpZ2l0YWwgT3V0IGF0IEludCBIRE1JCiAgICBDb25uID0gRGlnaXRhbCwgQ29s
b3IgPSBVbmtub3duCiAgICBEZWZBc3NvY2lhdGlvbiA9IDB4MSwgU2VxdWVuY2UgPSAweDAK
ICBQaW4tY3RsczogMHgwMDoKICBVbnNvbGljaXRlZDogdGFnPTAwLCBlbmFibGVkPTAKICBQ
b3dlciBzdGF0ZXM6ICBEMCBEMyBFUFNTCiAgUG93ZXI6IHNldHRpbmc9RDAsIGFjdHVhbD1E
MAogIERldmljZXM6IDAKICBDb25uZWN0aW9uOiAwCi0tZW5kY29sbGFwc2UtLQoKCiEhQUxT
QSBEZXZpY2Ugbm9kZXMKISEtLS0tLS0tLS0tLS0tLS0tLQoKY3J3LXJ3LS0tLSsgMSByb290
IGF1ZGlvIDExNiwgMTIgTm92IDIyIDAxOjM5IC9kZXYvc25kL2NvbnRyb2xDMApjcnctcnct
LS0tKyAxIHJvb3QgYXVkaW8gMTE2LCAxMSBOb3YgMjIgMDE6MzkgL2Rldi9zbmQvaHdDMEQy
CmNydy1ydy0tLS0rIDEgcm9vdCBhdWRpbyAxMTYsICAyIE5vdiAyMiAwMTozOSAvZGV2L3Nu
ZC9wY21DMEQwcApjcnctcnctLS0tKyAxIHJvb3QgYXVkaW8gMTE2LCAgMyBOb3YgMjIgMDE6
MzkgL2Rldi9zbmQvcGNtQzBEMWMKY3J3LXJ3LS0tLSsgMSByb290IGF1ZGlvIDExNiwgIDYg
Tm92IDIyIDIyOjE1IC9kZXYvc25kL3BjbUMwRDJwCmNydy1ydy0tLS0rIDEgcm9vdCBhdWRp
byAxMTYsICA0IE5vdiAyMiAwMTozOSAvZGV2L3NuZC9wY21DMEQzMXAKY3J3LXJ3LS0tLSsg
MSByb290IGF1ZGlvIDExNiwgIDcgTm92IDIyIDIyOjExIC9kZXYvc25kL3BjbUMwRDM1cApj
cnctcnctLS0tKyAxIHJvb3QgYXVkaW8gMTE2LCAgNSBOb3YgMjIgMDE6MzkgL2Rldi9zbmQv
cGNtQzBENGMKY3J3LXJ3LS0tLSsgMSByb290IGF1ZGlvIDExNiwgIDggTm92IDIyIDIyOjEy
IC9kZXYvc25kL3BjbUMwRDVwCmNydy1ydy0tLS0rIDEgcm9vdCBhdWRpbyAxMTYsICA5IE5v
diAyMiAyMjoxMiAvZGV2L3NuZC9wY21DMEQ2cApjcnctcnctLS0tKyAxIHJvb3QgYXVkaW8g
MTE2LCAxMCBOb3YgMjIgMjI6MTIgL2Rldi9zbmQvcGNtQzBEN3AKY3J3LXJ3LS0tLSsgMSBy
b290IGF1ZGlvIDExNiwgIDEgTm92IDIyIDAxOjM5IC9kZXYvc25kL3NlcQpjcnctcnctLS0t
KyAxIHJvb3QgYXVkaW8gMTE2LCAzMyBOb3YgMjIgMDE6MzkgL2Rldi9zbmQvdGltZXIKCi9k
ZXYvc25kL2J5LXBhdGg6CnRvdGFsIDAKZHJ3eHIteHIteCAyIHJvb3Qgcm9vdCAgNjAgTm92
IDIyIDAxOjM4IC4KZHJ3eHIteHIteCAzIHJvb3Qgcm9vdCAzMjAgTm92IDIyIDAxOjM4IC4u
Cmxyd3hyd3hyd3ggMSByb290IHJvb3QgIDEyIE5vdiAyMiAwMTozOCBwY2ktMDAwMDowMDox
Zi4zLXBsYXRmb3JtLXNvZl9zZHcgLT4gLi4vY29udHJvbEMwCgoKISFBcGxheS9BcmVjb3Jk
IG91dHB1dAohIS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpBUExBWQoKKioqKiBMaXN0IG9mIFBM
QVlCQUNLIEhhcmR3YXJlIERldmljZXMgKioqKgpjYXJkIDA6IHNvZnNvdW5kd2lyZSBbc29m
LXNvdW5kd2lyZV0sIGRldmljZSAwOiBKYWNrIE91dCAoKikgW10KICBTdWJkZXZpY2VzOiAx
LzEKICBTdWJkZXZpY2UgIzA6IHN1YmRldmljZSAjMApjYXJkIDA6IHNvZnNvdW5kd2lyZSBb
c29mLXNvdW5kd2lyZV0sIGRldmljZSAyOiBTcGVha2VyICgqKSBbXQogIFN1YmRldmljZXM6
IDEvMQogIFN1YmRldmljZSAjMDogc3ViZGV2aWNlICMwCmNhcmQgMDogc29mc291bmR3aXJl
IFtzb2Ytc291bmR3aXJlXSwgZGV2aWNlIDU6IEhETUkxICgqKSBbSERNSSAxXQogIFN1YmRl
dmljZXM6IDEvMQogIFN1YmRldmljZSAjMDogc3ViZGV2aWNlICMwCmNhcmQgMDogc29mc291
bmR3aXJlIFtzb2Ytc291bmR3aXJlXSwgZGV2aWNlIDY6IEhETUkyICgqKSBbSERNSSAyXQog
IFN1YmRldmljZXM6IDEvMQogIFN1YmRldmljZSAjMDogc3ViZGV2aWNlICMwCmNhcmQgMDog
c29mc291bmR3aXJlIFtzb2Ytc291bmR3aXJlXSwgZGV2aWNlIDc6IEhETUkzICgqKSBbSERN
SSAzXQogIFN1YmRldmljZXM6IDEvMQogIFN1YmRldmljZSAjMDogc3ViZGV2aWNlICMwCmNh
cmQgMDogc29mc291bmR3aXJlIFtzb2Ytc291bmR3aXJlXSwgZGV2aWNlIDMxOiBEZWVwYnVm
ZmVyIEphY2sgT3V0ICgqKSBbXQogIFN1YmRldmljZXM6IDEvMQogIFN1YmRldmljZSAjMDog
c3ViZGV2aWNlICMwCmNhcmQgMDogc29mc291bmR3aXJlIFtzb2Ytc291bmR3aXJlXSwgZGV2
aWNlIDM1OiBEZWVwYnVmZmVyIFNwZWFrZXIgKCopIFtdCiAgU3ViZGV2aWNlczogMS8xCiAg
U3ViZGV2aWNlICMwOiBzdWJkZXZpY2UgIzAKCkFSRUNPUkQKCioqKiogTGlzdCBvZiBDQVBU
VVJFIEhhcmR3YXJlIERldmljZXMgKioqKgpjYXJkIDA6IHNvZnNvdW5kd2lyZSBbc29mLXNv
dW5kd2lyZV0sIGRldmljZSAxOiBKYWNrIEluICgqKSBbXQogIFN1YmRldmljZXM6IDEvMQog
IFN1YmRldmljZSAjMDogc3ViZGV2aWNlICMwCmNhcmQgMDogc29mc291bmR3aXJlIFtzb2Yt
c291bmR3aXJlXSwgZGV2aWNlIDQ6IE1pY3JvcGhvbmUgKCopIFtdCiAgU3ViZGV2aWNlczog
MS8xCiAgU3ViZGV2aWNlICMwOiBzdWJkZXZpY2UgIzAKCiEhQW1peGVyIG91dHB1dAohIS0t
LS0tLS0tLS0tLS0KCiEhLS0tLS0tLU1peGVyIGNvbnRyb2xzIGZvciBjYXJkIHNvZnNvdW5k
d2lyZQoKQ2FyZCBzeXNkZWZhdWx0OjAgJ3NvZnNvdW5kd2lyZScvJ1hJQU9NSS1YaWFvbWlC
b29rUHJvMTQtVE0yNDI0JwogIE1peGVyIG5hbWUJOiAnSW50ZWwgUGFudGhlciBMYWtlIEhE
TUknCiAgQ29tcG9uZW50cwk6ICdIREE6ODA4NjI4MjIsODA4NjAxMDEsMDAxMDAwMDAgIGNm
Zy1hbXA6MSBpZWM2MTkzNy1wY206Nyw2LDUgaHM6cnQ3MjEgbWljOnJ0NzIxIHNwazpydDEz
MjAnCiAgQ29udHJvbHMgICAgICA6IDcxCiAgU2ltcGxlIGN0cmxzICA6IDQxClNpbXBsZSBt
aXhlciBjb250cm9sICdIZWFkcGhvbmUnLDAKICBDYXBhYmlsaXRpZXM6IHBzd2l0Y2ggcHN3
aXRjaC1qb2luZWQKICBQbGF5YmFjayBjaGFubmVsczogTW9ubwogIE1vbm86IFBsYXliYWNr
IFtvZmZdClNpbXBsZSBtaXhlciBjb250cm9sICdTcGVha2VyJywwCiAgQ2FwYWJpbGl0aWVz
OiBwc3dpdGNoIHBzd2l0Y2gtam9pbmVkCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBN
b25vOiBQbGF5YmFjayBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdNaWNyb3Bob25lIENh
cHR1cmUgRFJDIHN3aXRjaCcsMAogIENhcGFiaWxpdGllczogcHN3aXRjaCBwc3dpdGNoLWpv
aW5lZAogIFBsYXliYWNrIGNoYW5uZWxzOiBNb25vCiAgTW9ubzogUGxheWJhY2sgW29uXQpT
aW1wbGUgbWl4ZXIgY29udHJvbCAnTWljcm9waG9uZSBDYXB0dXJlIFRERkIgYW5nbGUgc2V0
IGVudW0nLDAKICBDYXBhYmlsaXRpZXM6IGVudW0KICBJdGVtczogJy05MCcgJy03NScgJy02
MCcgJy00NScgJy0zMCcgJy0xNScgJzAnICcxNScgJzMwJyAnNDUnICc2MCcgJzc1JyAnOTAn
CiAgSXRlbTA6ICcwJwpTaW1wbGUgbWl4ZXIgY29udHJvbCAnTWljcm9waG9uZSBDYXB0dXJl
IFRERkIgYmVhbSBzd2l0Y2gnLDAKICBDYXBhYmlsaXRpZXM6IHBzd2l0Y2ggcHN3aXRjaC1q
b2luZWQKICBQbGF5YmFjayBjaGFubmVsczogTW9ubwogIE1vbm86IFBsYXliYWNrIFtvbl0K
U2ltcGxlIG1peGVyIGNvbnRyb2wgJ0lFQzk1OCcsMAogIENhcGFiaWxpdGllczogcHN3aXRj
aCBwc3dpdGNoLWpvaW5lZAogIFBsYXliYWNrIGNoYW5uZWxzOiBNb25vCiAgTW9ubzogUGxh
eWJhY2sgW29mZl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ0lFQzk1OCcsMQogIENhcGFiaWxp
dGllczogcHN3aXRjaCBwc3dpdGNoLWpvaW5lZAogIFBsYXliYWNrIGNoYW5uZWxzOiBNb25v
CiAgTW9ubzogUGxheWJhY2sgW29mZl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ0lFQzk1OCcs
MgogIENhcGFiaWxpdGllczogcHN3aXRjaCBwc3dpdGNoLWpvaW5lZAogIFBsYXliYWNrIGNo
YW5uZWxzOiBNb25vCiAgTW9ubzogUGxheWJhY2sgW29mZl0KU2ltcGxlIG1peGVyIGNvbnRy
b2wgJ0hlYWRzZXQgTWljJywwCiAgQ2FwYWJpbGl0aWVzOiBwc3dpdGNoIHBzd2l0Y2gtam9p
bmVkCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBNb25vOiBQbGF5YmFjayBbb2ZmXQpT
aW1wbGUgbWl4ZXIgY29udHJvbCAnUG9zdCBNaXhlciBKYWNrIE91dCcsMAogIENhcGFiaWxp
dGllczogcHZvbHVtZQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQg
UmlnaHQKICBMaW1pdHM6IFBsYXliYWNrIDAgLSA0NQogIE1vbm86CiAgRnJvbnQgTGVmdDog
UGxheWJhY2sgNDUgWzEwMCVdIFswLjAwZEJdCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDQ1
IFsxMDAlXSBbMC4wMGRCXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnUG9zdCBNaXhlciBTcGVh
a2VyJywwCiAgQ2FwYWJpbGl0aWVzOiBwdm9sdW1lCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZy
b250IExlZnQgLSBGcm9udCBSaWdodAogIExpbWl0czogUGxheWJhY2sgMCAtIDQ1CiAgTW9u
bzoKICBGcm9udCBMZWZ0OiBQbGF5YmFjayA0NSBbMTAwJV0gWzAuMDBkQl0KICBGcm9udCBS
aWdodDogUGxheWJhY2sgNDUgWzEwMCVdIFswLjAwZEJdClNpbXBsZSBtaXhlciBjb250cm9s
ICdQb3N0IE1peGVyIFNwZWFrZXIgUGxheWJhY2sgRFJDIHN3aXRjaCcsMAogIENhcGFiaWxp
dGllczogcHN3aXRjaCBwc3dpdGNoLWpvaW5lZAogIFBsYXliYWNrIGNoYW5uZWxzOiBNb25v
CiAgTW9ubzogUGxheWJhY2sgW29uXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnUHJlIE1peGVy
IERlZXBidWZmZXIgSmFjayBPdXQnLDAKICBDYXBhYmlsaXRpZXM6IHZvbHVtZQogIFBsYXli
YWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBDYXB0dXJlIGNoYW5u
ZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IDAgLSA0NQogIEZyb250
IExlZnQ6IDQ1IFsxMDAlXSBbMC4wMGRCXQogIEZyb250IFJpZ2h0OiA0NSBbMTAwJV0gWzAu
MDBkQl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ1ByZSBNaXhlciBEZWVwYnVmZmVyIFNwZWFr
ZXInLDAKICBDYXBhYmlsaXRpZXM6IHZvbHVtZQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9u
dCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBDYXB0dXJlIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0g
RnJvbnQgUmlnaHQKICBMaW1pdHM6IDAgLSA0NQogIEZyb250IExlZnQ6IDQ1IFsxMDAlXSBb
MC4wMGRCXQogIEZyb250IFJpZ2h0OiA0NSBbMTAwJV0gWzAuMDBkQl0KU2ltcGxlIG1peGVy
IGNvbnRyb2wgJ1ByZSBNaXhlciBKYWNrIE91dCcsMAogIENhcGFiaWxpdGllczogcHZvbHVt
ZQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1p
dHM6IFBsYXliYWNrIDAgLSA0NQogIE1vbm86CiAgRnJvbnQgTGVmdDogUGxheWJhY2sgNDUg
WzEwMCVdIFswLjAwZEJdCiAgRnJvbnQgUmlnaHQ6IFBsYXliYWNrIDQ1IFsxMDAlXSBbMC4w
MGRCXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAnUHJlIE1peGVyIFNwZWFrZXInLDAKICBDYXBh
YmlsaXRpZXM6IHB2b2x1bWUKICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZy
b250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFjayAwIC0gNDUKICBNb25vOgogIEZyb250IExl
ZnQ6IFBsYXliYWNrIDQ1IFsxMDAlXSBbMC4wMGRCXQogIEZyb250IFJpZ2h0OiBQbGF5YmFj
ayA0NSBbMTAwJV0gWzAuMDBkQl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0MTMyMCBPVDIz
JywwCiAgQ2FwYWJpbGl0aWVzOiBwc3dpdGNoCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250
IExlZnQgLSBGcm9udCBSaWdodAogIE1vbm86CiAgRnJvbnQgTGVmdDogUGxheWJhY2sgW29u
XQogIEZyb250IFJpZ2h0OiBQbGF5YmFjayBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdy
dDEzMjAtMSBCcm93biBPdXQnLDAKICBDYXBhYmlsaXRpZXM6IHBzd2l0Y2ggcHN3aXRjaC1q
b2luZWQKICBQbGF5YmFjayBjaGFubmVsczogTW9ubwogIE1vbm86IFBsYXliYWNrIFtvbl0K
U2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0MTMyMC0xIERTUCBGVyBVcGRhdGUnLDAKICBDYXBh
YmlsaXRpZXM6IHBzd2l0Y2ggcHN3aXRjaC1qb2luZWQKICBQbGF5YmFjayBjaGFubmVsczog
TW9ubwogIE1vbm86IFBsYXliYWNrIFtvZmZdClNpbXBsZSBtaXhlciBjb250cm9sICdydDEz
MjAtMSBGVScsMAogIENhcGFiaWxpdGllczogY3ZvbHVtZSBjc3dpdGNoCiAgQ2FwdHVyZSBj
aGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0IC0gUmVhciBMZWZ0IC0gUmVhciBS
aWdodAogIExpbWl0czogQ2FwdHVyZSAwIC0gNjMKICBGcm9udCBMZWZ0OiBDYXB0dXJlIDIz
IFszNyVdIFswLjAwZEJdIFtvZmZdCiAgRnJvbnQgUmlnaHQ6IENhcHR1cmUgMjMgWzM3JV0g
WzAuMDBkQl0gW29mZl0KICBSZWFyIExlZnQ6IENhcHR1cmUgMjMgWzM3JV0gWzAuMDBkQl0g
W29mZl0KICBSZWFyIFJpZ2h0OiBDYXB0dXJlIDIzIFszNyVdIFswLjAwZEJdIFtvZmZdClNp
bXBsZSBtaXhlciBjb250cm9sICdydDEzMjAtMSBGVTIxJywwCiAgQ2FwYWJpbGl0aWVzOiBw
dm9sdW1lCiAgUGxheWJhY2sgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBSaWdodAog
IExpbWl0czogUGxheWJhY2sgMCAtIDg3CiAgTW9ubzoKICBGcm9udCBMZWZ0OiBQbGF5YmFj
ayA4NyBbMTAwJV0gWzAuMDBkQl0KICBGcm9udCBSaWdodDogUGxheWJhY2sgODcgWzEwMCVd
IFswLjAwZEJdClNpbXBsZSBtaXhlciBjb250cm9sICdydDEzMjAtMSBPVDIzIEwnLDAKICBD
YXBhYmlsaXRpZXM6IHBzd2l0Y2ggcHN3aXRjaC1qb2luZWQKICBQbGF5YmFjayBjaGFubmVs
czogTW9ubwogIE1vbm86IFBsYXliYWNrIFtvbl0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0
MTMyMC0xIE9UMjMgUicsMAogIENhcGFiaWxpdGllczogcHN3aXRjaCBwc3dpdGNoLWpvaW5l
ZAogIFBsYXliYWNrIGNoYW5uZWxzOiBNb25vCiAgTW9ubzogUGxheWJhY2sgW29uXQpTaW1w
bGUgbWl4ZXIgY29udHJvbCAncnQxMzIwLTEgUjAgQ2FsaWJyYXRpb24nLDAKICBDYXBhYmls
aXRpZXM6IHBzd2l0Y2ggcHN3aXRjaC1qb2luZWQKICBQbGF5YmFjayBjaGFubmVsczogTW9u
bwogIE1vbm86IFBsYXliYWNrIFtvZmZdClNpbXBsZSBtaXhlciBjb250cm9sICdydDEzMjAt
MSBSMCBMb2FkIE1vZGUnLDAKICBDYXBhYmlsaXRpZXM6IHZvbHVtZQogIFBsYXliYWNrIGNo
YW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBDYXB0dXJlIGNoYW5uZWxzOiBG
cm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IDAgLSA0Mjk0OTY3Mjk1CiAgRnJv
bnQgTGVmdDogMCBbMCVdCiAgRnJvbnQgUmlnaHQ6IDAgWzAlXQpTaW1wbGUgbWl4ZXIgY29u
dHJvbCAncnQxMzIwLTEgUjAgVGVtcGVyYXR1cmUnLDAKICBDYXBhYmlsaXRpZXM6IHZvbHVt
ZQogIFBsYXliYWNrIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBDYXB0
dXJlIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQKICBMaW1pdHM6IDAgLSAy
NTUKICBGcm9udCBMZWZ0OiAwIFswJV0KICBGcm9udCBSaWdodDogMCBbMCVdClNpbXBsZSBt
aXhlciBjb250cm9sICdydDEzMjAtMSBSQUUgVXBkYXRlJywwCiAgQ2FwYWJpbGl0aWVzOiBw
c3dpdGNoIHBzd2l0Y2gtam9pbmVkCiAgUGxheWJhY2sgY2hhbm5lbHM6IE1vbm8KICBNb25v
OiBQbGF5YmFjayBbb2ZmXQpTaW1wbGUgbWl4ZXIgY29udHJvbCAncnQxMzIwLTEgUlggQ2hh
bm5lbCBTZWxlY3QnLDAKICBDYXBhYmlsaXRpZXM6IGVudW0KICBJdGVtczogJ0wsUicgJ1Is
TCcgJ0wsTCcgJ1IsUicgJ0wsTCtSJyAnUixMK1InICdMK1IsTCcgJ0wrUixSJyAnTCtSLEwr
UicKICBJdGVtMDogJ0wsUicKU2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0NzIxIEFEQyAwNyBM
IE11eCcsMAogIENhcGFiaWxpdGllczogZW51bQogIEl0ZW1zOiAnRE1JQzEgUkUnICdETUlD
MSBGRScgJ0RNSUMyIFJFJyAnRE1JQzIgRkUnCiAgSXRlbTA6ICdETUlDMSBSRScKU2ltcGxl
IG1peGVyIGNvbnRyb2wgJ3J0NzIxIEFEQyAwNyBSIE11eCcsMAogIENhcGFiaWxpdGllczog
ZW51bQogIEl0ZW1zOiAnRE1JQzEgUkUnICdETUlDMSBGRScgJ0RNSUMyIFJFJyAnRE1JQzIg
RkUnCiAgSXRlbTA6ICdETUlDMSBGRScKU2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0NzIxIEFE
QyAwOCBMIE11eCcsMAogIENhcGFiaWxpdGllczogZW51bQogIEl0ZW1zOiAnRE1JQzEgUkUn
ICdETUlDMSBGRScgJ0RNSUMyIFJFJyAnRE1JQzIgRkUnCiAgSXRlbTA6ICdETUlDMSBSRScK
U2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0NzIxIEFEQyAwOCBSIE11eCcsMAogIENhcGFiaWxp
dGllczogZW51bQogIEl0ZW1zOiAnRE1JQzEgUkUnICdETUlDMSBGRScgJ0RNSUMyIFJFJyAn
RE1JQzIgRkUnCiAgSXRlbTA6ICdETUlDMSBGRScKU2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0
NzIxIEFEQyAwOSBNdXgnLDAKICBDYXBhYmlsaXRpZXM6IGVudW0KICBJdGVtczogJ01JQzIn
ICdMSU5FMScgJ0xJTkUyJwogIEl0ZW0wOiAnTUlDMicKU2ltcGxlIG1peGVyIGNvbnRyb2wg
J3J0NzIxIEFEQyAxMCBMIE11eCcsMAogIENhcGFiaWxpdGllczogZW51bQogIEl0ZW1zOiAn
RE1JQzEgUkUnICdETUlDMSBGRScgJ0RNSUMyIFJFJyAnRE1JQzIgRkUnCiAgSXRlbTA6ICdE
TUlDMiBSRScKU2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0NzIxIEFEQyAxMCBSIE11eCcsMAog
IENhcGFiaWxpdGllczogZW51bQogIEl0ZW1zOiAnRE1JQzEgUkUnICdETUlDMSBGRScgJ0RN
SUMyIFJFJyAnRE1JQzIgRkUnCiAgSXRlbTA6ICdETUlDMiBGRScKU2ltcGxlIG1peGVyIGNv
bnRyb2wgJ3J0NzIxIEZVMDUnLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUKICBQbGF5YmFj
ayBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRzOiBQbGF5YmFj
ayAwIC0gODcKICBNb25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDg3IFsxMDAlXSBbMC4w
MGRCXQogIEZyb250IFJpZ2h0OiBQbGF5YmFjayA4NyBbMTAwJV0gWzAuMDBkQl0KU2ltcGxl
IG1peGVyIGNvbnRyb2wgJ3J0NzIxIEZVMDYnLDAKICBDYXBhYmlsaXRpZXM6IHB2b2x1bWUK
ICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0CiAgTGltaXRz
OiBQbGF5YmFjayAwIC0gODcKICBNb25vOgogIEZyb250IExlZnQ6IFBsYXliYWNrIDg3IFsx
MDAlXSBbMC4wMGRCXQogIEZyb250IFJpZ2h0OiBQbGF5YmFjayA4NyBbMTAwJV0gWzAuMDBk
Ql0KU2ltcGxlIG1peGVyIGNvbnRyb2wgJ3J0NzIxIEZVMEYnLDAKICBDYXBhYmlsaXRpZXM6
IGN2b2x1bWUgY3N3aXRjaAogIENhcHR1cmUgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9u
dCBSaWdodAogIExpbWl0czogQ2FwdHVyZSAwIC0gNjMKICBGcm9udCBMZWZ0OiBDYXB0dXJl
IDYzIFsxMDAlXSBbMzAuMDBkQl0gW29mZl0KICBGcm9udCBSaWdodDogQ2FwdHVyZSA2MyBb
MTAwJV0gWzMwLjAwZEJdIFtvZmZdClNpbXBsZSBtaXhlciBjb250cm9sICdydDcyMSBGVTE1
IEJvb3N0JywwCiAgQ2FwYWJpbGl0aWVzOiB2b2x1bWUKICBQbGF5YmFjayBjaGFubmVsczog
RnJvbnQgTGVmdCAtIEZyb250IFJpZ2h0IC0gUmVhciBMZWZ0IC0gUmVhciBSaWdodAogIENh
cHR1cmUgY2hhbm5lbHM6IEZyb250IExlZnQgLSBGcm9udCBSaWdodCAtIFJlYXIgTGVmdCAt
IFJlYXIgUmlnaHQKICBMaW1pdHM6IDAgLSAzCiAgRnJvbnQgTGVmdDogMCBbMCVdIFswLjAw
ZEJdCiAgRnJvbnQgUmlnaHQ6IDAgWzAlXSBbMC4wMGRCXQogIFJlYXIgTGVmdDogMCBbMCVd
IFswLjAwZEJdCiAgUmVhciBSaWdodDogMCBbMCVdIFswLjAwZEJdClNpbXBsZSBtaXhlciBj
b250cm9sICdydDcyMSBGVTFFJywwCiAgQ2FwYWJpbGl0aWVzOiBjdm9sdW1lIGNzd2l0Y2gK
ICBDYXB0dXJlIGNoYW5uZWxzOiBGcm9udCBMZWZ0IC0gRnJvbnQgUmlnaHQgLSBSZWFyIExl
ZnQgLSBSZWFyIFJpZ2h0CiAgTGltaXRzOiBDYXB0dXJlIDAgLSA2MwogIEZyb250IExlZnQ6
IENhcHR1cmUgNjMgWzEwMCVdIFszMC4wMGRCXSBbb25dCiAgRnJvbnQgUmlnaHQ6IENhcHR1
cmUgNjMgWzEwMCVdIFszMC4wMGRCXSBbb25dCiAgUmVhciBMZWZ0OiBDYXB0dXJlIDYzIFsx
MDAlXSBbMzAuMDBkQl0gW29uXQogIFJlYXIgUmlnaHQ6IENhcHR1cmUgNjMgWzEwMCVdIFsz
MC4wMGRCXSBbb25dClNpbXBsZSBtaXhlciBjb250cm9sICdydDcyMSBGVTMzIEJvb3N0Jyww
CiAgQ2FwYWJpbGl0aWVzOiB2b2x1bWUKICBQbGF5YmFjayBjaGFubmVsczogRnJvbnQgTGVm
dCAtIEZyb250IFJpZ2h0CiAgQ2FwdHVyZSBjaGFubmVsczogRnJvbnQgTGVmdCAtIEZyb250
IFJpZ2h0CiAgTGltaXRzOiAwIC0gMjEKICBGcm9udCBMZWZ0OiAxIFs1JV0gWzAuMDBkQl0K
ICBGcm9udCBSaWdodDogMSBbNSVdIFswLjAwZEJdCgoKISFBbHNhY3RsIG91dHB1dAohIS0t
LS0tLS0tLS0tLS0tCgotLXN0YXJ0Y29sbGFwc2UtLQpzdGF0ZS5zb2Zzb3VuZHdpcmUgewoJ
Y29udHJvbC4xIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0NzIxIEZVMDUgUGxheWJhY2sg
Vm9sdW1lJwoJCXZhbHVlLjAgODcKCQl2YWx1ZS4xIDg3CgkJY29tbWVudCB7CgkJCWFjY2Vz
cyAncmVhZCB3cml0ZScKCQkJdHlwZSBJTlRFR0VSCgkJCWNvdW50IDIKCQkJcmFuZ2UgJzAg
LSA4NycKCQkJZGJtaW4gLTY1MjUKCQkJZGJtYXggMAoJCQlkYnZhbHVlLjAgMAoJCQlkYnZh
bHVlLjEgMAoJCX0KCX0KCWNvbnRyb2wuMiB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdydDcy
MSBGVTBGIENhcHR1cmUgU3dpdGNoJwoJCXZhbHVlLjAgZmFsc2UKCQl2YWx1ZS4xIGZhbHNl
CgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJ
CWNvdW50IDIKCQl9Cgl9Cgljb250cm9sLjMgewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAncnQ3
MjEgRlUwRiBDYXB0dXJlIFZvbHVtZScKCQl2YWx1ZS4wIDYzCgkJdmFsdWUuMSA2MwoJCWNv
bW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgSU5URUdFUgoJCQljb3Vu
dCAyCgkJCXJhbmdlICcwIC0gNjMnCgkJCWRibWluIC0xNzI1CgkJCWRibWF4IDMwMDAKCQkJ
ZGJ2YWx1ZS4wIDMwMDAKCQkJZGJ2YWx1ZS4xIDMwMDAKCQl9Cgl9Cgljb250cm9sLjQgewoJ
CWlmYWNlIE1JWEVSCgkJbmFtZSAncnQ3MjEgRlUzMyBCb29zdCBWb2x1bWUnCgkJdmFsdWUu
MCAxCgkJdmFsdWUuMSAxCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJ
dHlwZSBJTlRFR0VSCgkJCWNvdW50IDIKCQkJcmFuZ2UgJzAgLSAyMScKCQkJZGJtaW4gLTIw
MAoJCQlkYm1heCA0MDAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUuMSAwCgkJfQoJfQoJ
Y29udHJvbC41IHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0NzIxIEZVMDYgUGxheWJhY2sg
Vm9sdW1lJwoJCXZhbHVlLjAgODcKCQl2YWx1ZS4xIDg3CgkJY29tbWVudCB7CgkJCWFjY2Vz
cyAncmVhZCB3cml0ZScKCQkJdHlwZSBJTlRFR0VSCgkJCWNvdW50IDIKCQkJcmFuZ2UgJzAg
LSA4NycKCQkJZGJtaW4gLTY1MjUKCQkJZGJtYXggMAoJCQlkYnZhbHVlLjAgMAoJCQlkYnZh
bHVlLjEgMAoJCX0KCX0KCWNvbnRyb2wuNiB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdydDcy
MSBGVTFFIENhcHR1cmUgU3dpdGNoJwoJCXZhbHVlLjAgdHJ1ZQoJCXZhbHVlLjEgdHJ1ZQoJ
CXZhbHVlLjIgdHJ1ZQoJCXZhbHVlLjMgdHJ1ZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3Jl
YWQgd3JpdGUnCgkJCXR5cGUgQk9PTEVBTgoJCQljb3VudCA0CgkJfQoJfQoJY29udHJvbC43
IHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0NzIxIEZVMUUgQ2FwdHVyZSBWb2x1bWUnCgkJ
dmFsdWUuMCA2MwoJCXZhbHVlLjEgNjMKCQl2YWx1ZS4yIDYzCgkJdmFsdWUuMyA2MwoJCWNv
bW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgSU5URUdFUgoJCQljb3Vu
dCA0CgkJCXJhbmdlICcwIC0gNjMnCgkJCWRibWluIC0xNzI1CgkJCWRibWF4IDMwMDAKCQkJ
ZGJ2YWx1ZS4wIDMwMDAKCQkJZGJ2YWx1ZS4xIDMwMDAKCQkJZGJ2YWx1ZS4yIDMwMDAKCQkJ
ZGJ2YWx1ZS4zIDMwMDAKCQl9Cgl9Cgljb250cm9sLjggewoJCWlmYWNlIE1JWEVSCgkJbmFt
ZSAncnQ3MjEgRlUxNSBCb29zdCBWb2x1bWUnCgkJdmFsdWUuMCAwCgkJdmFsdWUuMSAwCgkJ
dmFsdWUuMiAwCgkJdmFsdWUuMyAwCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0
ZScKCQkJdHlwZSBJTlRFR0VSCgkJCWNvdW50IDQKCQkJcmFuZ2UgJzAgLSAzJwoJCQlkYm1p
biAwCgkJCWRibWF4IDMwMDAKCQkJZGJ2YWx1ZS4wIDAKCQkJZGJ2YWx1ZS4xIDAKCQkJZGJ2
YWx1ZS4yIDAKCQkJZGJ2YWx1ZS4zIDAKCQl9Cgl9Cgljb250cm9sLjkgewoJCWlmYWNlIE1J
WEVSCgkJbmFtZSAncnQxMzIwLTEgRlUyMSBQbGF5YmFjayBWb2x1bWUnCgkJdmFsdWUuMCA4
NwoJCXZhbHVlLjEgODcKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0
eXBlIElOVEVHRVIKCQkJY291bnQgMgoJCQlyYW5nZSAnMCAtIDg3JwoJCQlkYm1pbiAtNjUy
NQoJCQlkYm1heCAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUuMSAwCgkJfQoJfQoJY29u
dHJvbC4xMCB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdydDEzMjAtMSBSWCBDaGFubmVsIFNl
bGVjdCcKCQl2YWx1ZSAnTCxSJwoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUn
CgkJCXR5cGUgRU5VTUVSQVRFRAoJCQljb3VudCAxCgkJCWl0ZW0uMCAnTCxSJwoJCQlpdGVt
LjEgJ1IsTCcKCQkJaXRlbS4yICdMLEwnCgkJCWl0ZW0uMyAnUixSJwoJCQlpdGVtLjQgJ0ws
TCtSJwoJCQlpdGVtLjUgJ1IsTCtSJwoJCQlpdGVtLjYgJ0wrUixMJwoJCQlpdGVtLjcgJ0wr
UixSJwoJCQlpdGVtLjggJ0wrUixMK1InCgkJfQoJfQoJY29udHJvbC4xMSB7CgkJaWZhY2Ug
TUlYRVIKCQluYW1lICdydDEzMjAtMSBGVSBDYXB0dXJlIFN3aXRjaCcKCQl2YWx1ZS4wIGZh
bHNlCgkJdmFsdWUuMSBmYWxzZQoJCXZhbHVlLjIgZmFsc2UKCQl2YWx1ZS4zIGZhbHNlCgkJ
Y29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJCWNv
dW50IDQKCQl9Cgl9Cgljb250cm9sLjEyIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0MTMy
MC0xIEZVIENhcHR1cmUgVm9sdW1lJwoJCXZhbHVlLjAgMjMKCQl2YWx1ZS4xIDIzCgkJdmFs
dWUuMiAyMwoJCXZhbHVlLjMgMjMKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRl
JwoJCQl0eXBlIElOVEVHRVIKCQkJY291bnQgNAoJCQlyYW5nZSAnMCAtIDYzJwoJCQlkYm1p
biAtMTcyNQoJCQlkYm1heCAzMDAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUuMSAwCgkJ
CWRidmFsdWUuMiAwCgkJCWRidmFsdWUuMyAwCgkJfQoJfQoJY29udHJvbC4xMyB7CgkJaWZh
Y2UgTUlYRVIKCQluYW1lICdydDEzMjAtMSBSMCBDYWxpYnJhdGlvbicKCQl2YWx1ZSBmYWxz
ZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgQk9PTEVBTgoJ
CQljb3VudCAxCgkJfQoJfQoJY29udHJvbC4xNCB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdy
dDEzMjAtMSBEU1AgRlcgVXBkYXRlJwoJCXZhbHVlIGZhbHNlCgkJY29tbWVudCB7CgkJCWFj
Y2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDEKCQl9Cgl9Cglj
b250cm9sLjE1IHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0MTMyMC0xIFIwIExvYWQgTW9k
ZScKCQl2YWx1ZS4wIDAKCQl2YWx1ZS4xIDAKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFk
IHdyaXRlJwoJCQl0eXBlIElOVEVHRVIKCQkJY291bnQgMgoJCQlyYW5nZSAnMCAtIDQyOTQ5
NjcyOTUnCgkJfQoJfQoJY29udHJvbC4xNiB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdydDEz
MjAtMSBSMCBUZW1wZXJhdHVyZScKCQl2YWx1ZS4wIDAKCQl2YWx1ZS4xIDAKCQljb21tZW50
IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIElOVEVHRVIKCQkJY291bnQgMgoJ
CQlyYW5nZSAnMCAtIDI1NScKCQl9Cgl9Cgljb250cm9sLjE3IHsKCQlpZmFjZSBNSVhFUgoJ
CW5hbWUgJ3J0MTMyMC0xIFJBRSBVcGRhdGUnCgkJdmFsdWUgZmFsc2UKCQljb21tZW50IHsK
CQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIEJPT0xFQU4KCQkJY291bnQgMQoJCX0K
CX0KCWNvbnRyb2wuMTggewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAncnQxMzIwLTEgQnJvd24g
T3V0IFN3aXRjaCcKCQl2YWx1ZSB0cnVlCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3
cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDEKCQl9Cgl9Cgljb250cm9sLjE5IHsK
CQlpZmFjZSBNSVhFUgoJCW5hbWUgJ0hlYWRwaG9uZSBTd2l0Y2gnCgkJdmFsdWUgZmFsc2UK
CQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIEJPT0xFQU4KCQkJ
Y291bnQgMQoJCX0KCX0KCWNvbnRyb2wuMjAgewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnSGVh
ZHNldCBNaWMgU3dpdGNoJwoJCXZhbHVlIGZhbHNlCgkJY29tbWVudCB7CgkJCWFjY2VzcyAn
cmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDEKCQl9Cgl9Cgljb250cm9s
LjIxIHsKCQlpZmFjZSBDQVJECgkJbmFtZSAnSGVhZHBob25lIEphY2snCgkJdmFsdWUgZmFs
c2UKCQljb21tZW50IHsKCQkJYWNjZXNzIHJlYWQKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50
IDEKCQl9Cgl9Cgljb250cm9sLjIyIHsKCQlpZmFjZSBDQVJECgkJbmFtZSAnSGVhZHNldCBN
aWMgSmFjaycKCQl2YWx1ZSBmYWxzZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgcmVhZAoJCQl0
eXBlIEJPT0xFQU4KCQkJY291bnQgMQoJCX0KCX0KCWNvbnRyb2wuMjMgewoJCWlmYWNlIE1J
WEVSCgkJbmFtZSAnU3BlYWtlciBTd2l0Y2gnCgkJdmFsdWUgdHJ1ZQoJCWNvbW1lbnQgewoJ
CQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgQk9PTEVBTgoJCQljb3VudCAxCgkJfQoJ
fQoJY29udHJvbC4yNCB7CgkJaWZhY2UgQ0FSRAoJCW5hbWUgJ0hETUkvRFAscGNtPTUgSmFj
aycKCQl2YWx1ZSBmYWxzZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgcmVhZAoJCQl0eXBlIEJP
T0xFQU4KCQkJY291bnQgMQoJCX0KCX0KCWNvbnRyb2wuMjUgewoJCWlmYWNlIE1JWEVSCgkJ
bmFtZSAnSUVDOTU4IFBsYXliYWNrIENvbiBNYXNrJwoJCXZhbHVlICcwZmZmMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwJwoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgcmVhZAoJCQl0eXBlIElF
Qzk1OAoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC4yNiB7CgkJaWZhY2UgTUlYRVIKCQlu
YW1lICdJRUM5NTggUGxheWJhY2sgUHJvIE1hc2snCgkJdmFsdWUgJzBmMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAnCgkJY29tbWVudCB7CgkJCWFjY2VzcyByZWFkCgkJCXR5cGUgSUVD
OTU4CgkJCWNvdW50IDEKCQl9Cgl9Cgljb250cm9sLjI3IHsKCQlpZmFjZSBNSVhFUgoJCW5h
bWUgJ0lFQzk1OCBQbGF5YmFjayBEZWZhdWx0JwoJCXZhbHVlICcwNDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwJwoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5
cGUgSUVDOTU4CgkJCWNvdW50IDEKCQl9Cgl9Cgljb250cm9sLjI4IHsKCQlpZmFjZSBNSVhF
UgoJCW5hbWUgJ0lFQzk1OCBQbGF5YmFjayBTd2l0Y2gnCgkJdmFsdWUgZmFsc2UKCQljb21t
ZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIEJPT0xFQU4KCQkJY291bnQg
MQoJCX0KCX0KCWNvbnRyb2wuMjkgewoJCWlmYWNlIFBDTQoJCWRldmljZSA1CgkJbmFtZSBF
TEQKCQl2YWx1ZSAnJwoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgdm9sYXRpbGUnCgkJ
CXR5cGUgQllURVMKCQkJY291bnQgMAoJCX0KCX0KCWNvbnRyb2wuMzAgewoJCWlmYWNlIENB
UkQKCQluYW1lICdIRE1JL0RQLHBjbT02IEphY2snCgkJdmFsdWUgZmFsc2UKCQljb21tZW50
IHsKCQkJYWNjZXNzIHJlYWQKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDEKCQl9Cgl9Cglj
b250cm9sLjMxIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ0lFQzk1OCBQbGF5YmFjayBDb24g
TWFzaycKCQlpbmRleCAxCgkJdmFsdWUgJzBmZmYwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAn
CgkJY29tbWVudCB7CgkJCWFjY2VzcyByZWFkCgkJCXR5cGUgSUVDOTU4CgkJCWNvdW50IDEK
CQl9Cgl9Cgljb250cm9sLjMyIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ0lFQzk1OCBQbGF5
YmFjayBQcm8gTWFzaycKCQlpbmRleCAxCgkJdmFsdWUgJzBmMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAnCgkJY29tbWVudCB7CgkJCWFjY2VzcyByZWFkCgkJCXR5cGUgSUVDOTU4CgkJ
CWNvdW50IDEKCQl9Cgl9Cgljb250cm9sLjMzIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ0lF
Qzk1OCBQbGF5YmFjayBEZWZhdWx0JwoJCWluZGV4IDEKCQl2YWx1ZSAnMDQwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMCcKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJ
CQl0eXBlIElFQzk1OAoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC4zNCB7CgkJaWZhY2Ug
TUlYRVIKCQluYW1lICdJRUM5NTggUGxheWJhY2sgU3dpdGNoJwoJCWluZGV4IDEKCQl2YWx1
ZSBmYWxzZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgQk9P
TEVBTgoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC4zNSB7CgkJaWZhY2UgUENNCgkJZGV2
aWNlIDYKCQluYW1lIEVMRAoJCXZhbHVlICcnCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVh
ZCB2b2xhdGlsZScKCQkJdHlwZSBCWVRFUwoJCQljb3VudCAwCgkJfQoJfQoJY29udHJvbC4z
NiB7CgkJaWZhY2UgQ0FSRAoJCW5hbWUgJ0hETUkvRFAscGNtPTcgSmFjaycKCQl2YWx1ZSBm
YWxzZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgcmVhZAoJCQl0eXBlIEJPT0xFQU4KCQkJY291
bnQgMQoJCX0KCX0KCWNvbnRyb2wuMzcgewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnSUVDOTU4
IFBsYXliYWNrIENvbiBNYXNrJwoJCWluZGV4IDIKCQl2YWx1ZSAnMGZmZjAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMCcKCQljb21tZW50IHsKCQkJYWNjZXNzIHJlYWQKCQkJdHlwZSBJRUM5
NTgKCQkJY291bnQgMQoJCX0KCX0KCWNvbnRyb2wuMzggewoJCWlmYWNlIE1JWEVSCgkJbmFt
ZSAnSUVDOTU4IFBsYXliYWNrIFBybyBNYXNrJwoJCWluZGV4IDIKCQl2YWx1ZSAnMGYwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMCcKCQljb21tZW50IHsKCQkJYWNjZXNzIHJlYWQKCQkJ
dHlwZSBJRUM5NTgKCQkJY291bnQgMQoJCX0KCX0KCWNvbnRyb2wuMzkgewoJCWlmYWNlIE1J
WEVSCgkJbmFtZSAnSUVDOTU4IFBsYXliYWNrIERlZmF1bHQnCgkJaW5kZXggMgoJCXZhbHVl
ICcwNDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwJwoJCWNvbW1lbnQgewoJCQlhY2Nlc3Mg
J3JlYWQgd3JpdGUnCgkJCXR5cGUgSUVDOTU4CgkJCWNvdW50IDEKCQl9Cgl9Cgljb250cm9s
LjQwIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ0lFQzk1OCBQbGF5YmFjayBTd2l0Y2gnCgkJ
aW5kZXggMgoJCXZhbHVlIGZhbHNlCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0
ZScKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDEKCQl9Cgl9Cgljb250cm9sLjQxIHsKCQlp
ZmFjZSBQQ00KCQlkZXZpY2UgNwoJCW5hbWUgRUxECgkJdmFsdWUgJycKCQljb21tZW50IHsK
CQkJYWNjZXNzICdyZWFkIHZvbGF0aWxlJwoJCQl0eXBlIEJZVEVTCgkJCWNvdW50IDAKCQl9
Cgl9Cgljb250cm9sLjQyIHsKCQlpZmFjZSBQQ00KCQlkZXZpY2UgNQoJCW5hbWUgJ1BsYXli
YWNrIENoYW5uZWwgTWFwJwoJCXZhbHVlLjAgMAoJCXZhbHVlLjEgMAoJCXZhbHVlLjIgMAoJ
CXZhbHVlLjMgMAoJCXZhbHVlLjQgMAoJCXZhbHVlLjUgMAoJCXZhbHVlLjYgMAoJCXZhbHVl
LjcgMAoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUgdm9sYXRpbGUnCgkJCXR5
cGUgSU5URUdFUgoJCQljb3VudCA4CgkJCXJhbmdlICcwIC0gMzYnCgkJfQoJfQoJY29udHJv
bC40MyB7CgkJaWZhY2UgUENNCgkJZGV2aWNlIDYKCQluYW1lICdQbGF5YmFjayBDaGFubmVs
IE1hcCcKCQl2YWx1ZS4wIDAKCQl2YWx1ZS4xIDAKCQl2YWx1ZS4yIDAKCQl2YWx1ZS4zIDAK
CQl2YWx1ZS40IDAKCQl2YWx1ZS41IDAKCQl2YWx1ZS42IDAKCQl2YWx1ZS43IDAKCQljb21t
ZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlIHZvbGF0aWxlJwoJCQl0eXBlIElOVEVHRVIK
CQkJY291bnQgOAoJCQlyYW5nZSAnMCAtIDM2JwoJCX0KCX0KCWNvbnRyb2wuNDQgewoJCWlm
YWNlIFBDTQoJCWRldmljZSA3CgkJbmFtZSAnUGxheWJhY2sgQ2hhbm5lbCBNYXAnCgkJdmFs
dWUuMCAwCgkJdmFsdWUuMSAwCgkJdmFsdWUuMiAwCgkJdmFsdWUuMyAwCgkJdmFsdWUuNCAw
CgkJdmFsdWUuNSAwCgkJdmFsdWUuNiAwCgkJdmFsdWUuNyAwCgkJY29tbWVudCB7CgkJCWFj
Y2VzcyAncmVhZCB3cml0ZSB2b2xhdGlsZScKCQkJdHlwZSBJTlRFR0VSCgkJCWNvdW50IDgK
CQkJcmFuZ2UgJzAgLSAzNicKCQl9Cgl9Cgljb250cm9sLjQ1IHsKCQlpZmFjZSBNSVhFUgoJ
CW5hbWUgJ3J0NzIxIEFEQyAwOSBNdXgnCgkJdmFsdWUgTUlDMgoJCWNvbW1lbnQgewoJCQlh
Y2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgRU5VTUVSQVRFRAoJCQljb3VudCAxCgkJCWl0
ZW0uMCBNSUMyCgkJCWl0ZW0uMSBMSU5FMQoJCQlpdGVtLjIgTElORTIKCQl9Cgl9Cgljb250
cm9sLjQ2IHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0NzIxIEFEQyAwOCBSIE11eCcKCQl2
YWx1ZSAnRE1JQzEgRkUnCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJ
dHlwZSBFTlVNRVJBVEVECgkJCWNvdW50IDEKCQkJaXRlbS4wICdETUlDMSBSRScKCQkJaXRl
bS4xICdETUlDMSBGRScKCQkJaXRlbS4yICdETUlDMiBSRScKCQkJaXRlbS4zICdETUlDMiBG
RScKCQl9Cgl9Cgljb250cm9sLjQ3IHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0NzIxIEFE
QyAwOCBMIE11eCcKCQl2YWx1ZSAnRE1JQzEgUkUnCgkJY29tbWVudCB7CgkJCWFjY2VzcyAn
cmVhZCB3cml0ZScKCQkJdHlwZSBFTlVNRVJBVEVECgkJCWNvdW50IDEKCQkJaXRlbS4wICdE
TUlDMSBSRScKCQkJaXRlbS4xICdETUlDMSBGRScKCQkJaXRlbS4yICdETUlDMiBSRScKCQkJ
aXRlbS4zICdETUlDMiBGRScKCQl9Cgl9Cgljb250cm9sLjQ4IHsKCQlpZmFjZSBNSVhFUgoJ
CW5hbWUgJ3J0NzIxIEFEQyAxMCBSIE11eCcKCQl2YWx1ZSAnRE1JQzIgRkUnCgkJY29tbWVu
dCB7CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBFTlVNRVJBVEVECgkJCWNvdW50
IDEKCQkJaXRlbS4wICdETUlDMSBSRScKCQkJaXRlbS4xICdETUlDMSBGRScKCQkJaXRlbS4y
ICdETUlDMiBSRScKCQkJaXRlbS4zICdETUlDMiBGRScKCQl9Cgl9Cgljb250cm9sLjQ5IHsK
CQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0NzIxIEFEQyAxMCBMIE11eCcKCQl2YWx1ZSAnRE1J
QzIgUkUnCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBFTlVN
RVJBVEVECgkJCWNvdW50IDEKCQkJaXRlbS4wICdETUlDMSBSRScKCQkJaXRlbS4xICdETUlD
MSBGRScKCQkJaXRlbS4yICdETUlDMiBSRScKCQkJaXRlbS4zICdETUlDMiBGRScKCQl9Cgl9
Cgljb250cm9sLjUwIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0NzIxIEFEQyAwNyBSIE11
eCcKCQl2YWx1ZSAnRE1JQzEgRkUnCgkJY29tbWVudCB7CgkJCWFjY2VzcyAncmVhZCB3cml0
ZScKCQkJdHlwZSBFTlVNRVJBVEVECgkJCWNvdW50IDEKCQkJaXRlbS4wICdETUlDMSBSRScK
CQkJaXRlbS4xICdETUlDMSBGRScKCQkJaXRlbS4yICdETUlDMiBSRScKCQkJaXRlbS4zICdE
TUlDMiBGRScKCQl9Cgl9Cgljb250cm9sLjUxIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0
NzIxIEFEQyAwNyBMIE11eCcKCQl2YWx1ZSAnRE1JQzEgUkUnCgkJY29tbWVudCB7CgkJCWFj
Y2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBFTlVNRVJBVEVECgkJCWNvdW50IDEKCQkJaXRl
bS4wICdETUlDMSBSRScKCQkJaXRlbS4xICdETUlDMSBGRScKCQkJaXRlbS4yICdETUlDMiBS
RScKCQkJaXRlbS4zICdETUlDMiBGRScKCQl9Cgl9Cgljb250cm9sLjUyIHsKCQlpZmFjZSBN
SVhFUgoJCW5hbWUgJ1ByZSBNaXhlciBKYWNrIE91dCBQbGF5YmFjayBWb2x1bWUnCgkJdmFs
dWUuMCA0NQoJCXZhbHVlLjEgNDUKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRl
JwoJCQl0eXBlIElOVEVHRVIKCQkJY291bnQgMgoJCQlyYW5nZSAnMCAtIDQ1JwoJCQlkYm1p
biAtOTk5OTk5OQoJCQlkYm1heCAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUuMSAwCgkJ
fQoJfQoJY29udHJvbC41MyB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdQb3N0IE1peGVyIEph
Y2sgT3V0IFBsYXliYWNrIFZvbHVtZScKCQl2YWx1ZS4wIDQ1CgkJdmFsdWUuMSA0NQoJCWNv
bW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgSU5URUdFUgoJCQljb3Vu
dCAyCgkJCXJhbmdlICcwIC0gNDUnCgkJCWRibWluIC05OTk5OTk5CgkJCWRibWF4IDAKCQkJ
ZGJ2YWx1ZS4wIDAKCQkJZGJ2YWx1ZS4xIDAKCQl9Cgl9Cgljb250cm9sLjU1IHsKCQlpZmFj
ZSBNSVhFUgoJCW5hbWUgJ1ByZSBNaXhlciBEZWVwYnVmZmVyIEphY2sgT3V0IFZvbHVtZScK
CQl2YWx1ZS4wIDQ1CgkJdmFsdWUuMSA0NQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQg
d3JpdGUnCgkJCXR5cGUgSU5URUdFUgoJCQljb3VudCAyCgkJCXJhbmdlICcwIC0gNDUnCgkJ
CWRibWluIC05OTk5OTk5CgkJCWRibWF4IDAKCQkJZGJ2YWx1ZS4wIDAKCQkJZGJ2YWx1ZS4x
IDAKCQl9Cgl9Cgljb250cm9sLjU3IHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ01pY3JvcGhv
bmUgQ2FwdHVyZSBUREZCIGJlYW0gc3dpdGNoJwoJCXZhbHVlIHRydWUKCQljb21tZW50IHsK
CQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIEJPT0xFQU4KCQkJY291bnQgMQoJCX0K
CX0KCWNvbnRyb2wuNTggewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnTWljcm9waG9uZSBDYXB0
dXJlIFRERkIgYW5nbGUgc2V0IGVudW0nCgkJdmFsdWUgJzAnCgkJY29tbWVudCB7CgkJCWFj
Y2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBFTlVNRVJBVEVECgkJCWNvdW50IDEKCQkJaXRl
bS4wICctOTAnCgkJCWl0ZW0uMSAnLTc1JwoJCQlpdGVtLjIgJy02MCcKCQkJaXRlbS4zICct
NDUnCgkJCWl0ZW0uNCAnLTMwJwoJCQlpdGVtLjUgJy0xNScKCQkJaXRlbS42ICcwJwoJCQlp
dGVtLjcgJzE1JwoJCQlpdGVtLjggJzMwJwoJCQlpdGVtLjkgJzQ1JwoJCQlpdGVtLjEwICc2
MCcKCQkJaXRlbS4xMSAnNzUnCgkJCWl0ZW0uMTIgJzkwJwoJCX0KCX0KCWNvbnRyb2wuNjAg
ewoJCWlmYWNlIE1JWEVSCgkJbmFtZSAnTWljcm9waG9uZSBDYXB0dXJlIERSQyBzd2l0Y2gn
CgkJdmFsdWUgdHJ1ZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5
cGUgQk9PTEVBTgoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC42MiB7CgkJaWZhY2UgTUlY
RVIKCQluYW1lICdQcmUgTWl4ZXIgRGVlcGJ1ZmZlciBTcGVha2VyIFZvbHVtZScKCQl2YWx1
ZS4wIDQ1CgkJdmFsdWUuMSA0NQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUn
CgkJCXR5cGUgSU5URUdFUgoJCQljb3VudCAyCgkJCXJhbmdlICcwIC0gNDUnCgkJCWRibWlu
IC05OTk5OTk5CgkJCWRibWF4IDAKCQkJZGJ2YWx1ZS4wIDAKCQkJZGJ2YWx1ZS4xIDAKCQl9
Cgl9Cgljb250cm9sLjYzIHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ1ByZSBNaXhlciBTcGVh
a2VyIFBsYXliYWNrIFZvbHVtZScKCQl2YWx1ZS4wIDQ1CgkJdmFsdWUuMSA0NQoJCWNvbW1l
bnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUnCgkJCXR5cGUgSU5URUdFUgoJCQljb3VudCAy
CgkJCXJhbmdlICcwIC0gNDUnCgkJCWRibWluIC05OTk5OTk5CgkJCWRibWF4IDAKCQkJZGJ2
YWx1ZS4wIDAKCQkJZGJ2YWx1ZS4xIDAKCQl9Cgl9Cgljb250cm9sLjY0IHsKCQlpZmFjZSBN
SVhFUgoJCW5hbWUgJ1Bvc3QgTWl4ZXIgU3BlYWtlciBQbGF5YmFjayBWb2x1bWUnCgkJdmFs
dWUuMCA0NQoJCXZhbHVlLjEgNDUKCQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRl
JwoJCQl0eXBlIElOVEVHRVIKCQkJY291bnQgMgoJCQlyYW5nZSAnMCAtIDQ1JwoJCQlkYm1p
biAtOTk5OTk5OQoJCQlkYm1heCAwCgkJCWRidmFsdWUuMCAwCgkJCWRidmFsdWUuMSAwCgkJ
fQoJfQoJY29udHJvbC42OCB7CgkJaWZhY2UgTUlYRVIKCQluYW1lICdQb3N0IE1peGVyIFNw
ZWFrZXIgUGxheWJhY2sgRFJDIHN3aXRjaCcKCQl2YWx1ZSB0cnVlCgkJY29tbWVudCB7CgkJ
CWFjY2VzcyAncmVhZCB3cml0ZScKCQkJdHlwZSBCT09MRUFOCgkJCWNvdW50IDEKCQl9Cgl9
Cgljb250cm9sLjY5IHsKCQlpZmFjZSBNSVhFUgoJCW5hbWUgJ3J0MTMyMC0xIE9UMjMgTCBT
d2l0Y2gnCgkJdmFsdWUgdHJ1ZQoJCWNvbW1lbnQgewoJCQlhY2Nlc3MgJ3JlYWQgd3JpdGUn
CgkJCXR5cGUgQk9PTEVBTgoJCQljb3VudCAxCgkJfQoJfQoJY29udHJvbC43MCB7CgkJaWZh
Y2UgTUlYRVIKCQluYW1lICdydDEzMjAtMSBPVDIzIFIgU3dpdGNoJwoJCXZhbHVlIHRydWUK
CQljb21tZW50IHsKCQkJYWNjZXNzICdyZWFkIHdyaXRlJwoJCQl0eXBlIEJPT0xFQU4KCQkJ
Y291bnQgMQoJCX0KCX0KfQotLWVuZGNvbGxhcHNlLS0KCgohIUFsbCBMb2FkZWQgTW9kdWxl
cwohIS0tLS0tLS0tLS0tLS0tLS0tLQoKODQyX2NvbXByZXNzCjg0Ml9kZWNvbXByZXNzCmFj
OTdfYnVzCmFjcGlfY2FsbAphY3BpX3BhZAphY3BpX3RhZAphY3BpX3RoZXJtYWxfcmVsCmFl
c25pX2ludGVsCmFmX2FsZwphbGdpZl9oYXNoCmFsZ2lmX3NrY2lwaGVyCmFwcGxlX21maV9m
YXN0Y2hhcmdlCmJpdGxhbmRfbWlmc193bWkKYmx1ZXRvb3RoCmJuZXAKYnRpbnRlbApidGlu
dGVsX3BjaWUKY2NtCmNlYwpjZmc4MDIxMQpjb3JldGVtcApjcmM4CmNyeXB0b191c2VyCmRt
X21vZApkcm1fYnVkZHkKZHJtX2Rpc3BsYXlfaGVscGVyCmRybV9leGVjCmRybV9ncHVzdm1f
aGVscGVyCmRybV9ncHV2bQpkcm1fc3ViYWxsb2NfaGVscGVyCmRybV90dG1faGVscGVyCmZh
dApnZjEyOG11bApncHVfc2NoZWQKaGlkX2FwcGxlCmhpZF9sb2dpdGVjaF9kagpoaWRfbG9n
aXRlY2hfaGlkcHAKaGlkX211bHRpdG91Y2gKaTJjX2FsZ29fYml0CmkyY19kZXYKaTJjX2hp
ZAppMmNfaGlkX2FjcGkKaTJjX2k4MDEKaTJjX211eAppMmNfc21idXMKaWRtYTY0CmlnZW42
X2VkYWMKaW5ldF9kaWFnCmludDM0MDBfdGhlcm1hbAppbnQzNDAzX3RoZXJtYWwKaW50MzQw
eF90aGVybWFsX3pvbmUKaW50ZWxfY3N0YXRlCmludGVsX2lzaF9pcGMKaW50ZWxfaXNodHAK
aW50ZWxfbHBzcwppbnRlbF9scHNzX3BjaQppbnRlbF9wbWNfY29yZQppbnRlbF9wbWNfcHdy
bV90ZWxlbWV0cnkKaW50ZWxfcG1jX3NzcmFtX3RlbGVtZXRyeQppbnRlbF9wb3dlcmNsYW1w
CmludGVsX3F1aWNraTJjCmludGVsX3JhcGxfY29tbW9uCmludGVsX3JhcGxfbXNyCmludGVs
X3RoYwppbnRlbF91bmNvcmUKaW50ZWxfdW5jb3JlX2ZyZXF1ZW5jeQppbnRlbF91bmNvcmVf
ZnJlcXVlbmN5X2NvbW1vbgppbnRlbF92cHUKaW50ZWxfdnNlYwppcDZ0X1JFSkVDVAppcDZ0
X3J0CmlwdF9SRUpFQ1QKaXJxYnlwYXNzCmlzc2VpCmlzc2VpX2hlY2kKaXdsbXZtCml3bHdp
ZmkKam95ZGV2Cmt2bQprdm1faW50ZWwKbGliYXJjNApsejRoY19jb21wcmVzcwptYWM4MDIx
MQptYWNfaGlkCm1jCm1laQptZWlfZ3NjX3Byb3h5Cm1laV9tZQptb3VzZWRldgptdGQKbmZf
Y29ubnRyYWNrCm5mX2RlZnJhZ19pcHY0Cm5mX2RlZnJhZ19pcHY2Cm5mX2xvZ19zeXNsb2cK
bmZfcmVqZWN0X2lwdjQKbmZfcmVqZWN0X2lwdjYKbmZfdGFibGVzCm5mdF9jb21wYXQKbmZ0
X2xpbWl0Cm50c3luYwpudm1lCm52bWVfYXV0aApudm1lX2NvcmUKbnZtZV9rZXlyaW5nCnBj
c3BrcgpwaW5jdHJsX2ludGVsX3BsYXRmb3JtCnBrY3M4X2tleV9wYXJzZXIKcGxhdGZvcm1f
dGVtcGVyYXR1cmVfY29udHJvbApwbXRfY2xhc3MKcG10X2Rpc2NvdmVyeQpwbXRfdGVsZW1l
dHJ5CnBwc19jb3JlCnByb2Nlc3Nvcl90aGVybWFsX2RldmljZQpwcm9jZXNzb3JfdGhlcm1h
bF9kZXZpY2VfcGNpCnByb2Nlc3Nvcl90aGVybWFsX21ib3gKcHJvY2Vzc29yX3RoZXJtYWxf
cG93ZXJfZmxvb3IKcHJvY2Vzc29yX3RoZXJtYWxfcmFwbApwcm9jZXNzb3JfdGhlcm1hbF9y
ZmltCnByb2Nlc3Nvcl90aGVybWFsX3NvY19zbGlkZXIKcHJvY2Vzc29yX3RoZXJtYWxfd3Rf
aGludApwcm9jZXNzb3JfdGhlcm1hbF93dF9yZXEKcHRwCnJlZG1pX3dtaQpyZWdtYXBfc2R3
CnJlZ21hcF9zZHdfbWJxCnJmY29tbQpyZmtpbGwKcm9sZXMKc2VyaW9fcmF3CnNuZApzbmRf
Y29tcHJlc3MKc25kX2N0bF9sZWQKc25kX2hkYV9jb2RlYwpzbmRfaGRhX2NvZGVjX2hkbWkK
c25kX2hkYV9jb2RlY19pbnRlbGhkbWkKc25kX2hkYV9jb3JlCnNuZF9oZGFfZXh0X2NvcmUK
c25kX2hkYV9pbnRlbApzbmRfaHJ0aW1lcgpzbmRfaHdkZXAKc25kX2ludGVsX2RzcGNmZwpz
bmRfaW50ZWxfc2R3X2FjcGkKc25kX3BjbQpzbmRfcGNtX2RtYWVuZ2luZQpzbmRfc2VxCnNu
ZF9zZXFfZGV2aWNlCnNuZF9zZXFfZHVtbXkKc25kX3NvY19hY3BpCnNuZF9zb2NfYWNwaV9p
bnRlbF9tYXRjaApzbmRfc29jX2FjcGlfaW50ZWxfc2RjYV9xdWlya3MKc25kX3NvY19jb3Jl
CnNuZF9zb2NfZG1pYwpzbmRfc29jX2hkYWNfaGRhCnNuZF9zb2NfaW50ZWxfaGRhX2RzcF9j
b21tb24Kc25kX3NvY19ydDEzMjBfc2R3CnNuZF9zb2NfcnQ3MjFfc2RjYQpzbmRfc29jX3J0
X3Nkd19jb21tb24Kc25kX3NvY19zZGNhCnNuZF9zb2Nfc2R3X3V0aWxzCnNuZF9zb2Nfc29m
X3NkdwpzbmRfc29mCnNuZF9zb2ZfaW50ZWxfaGRhCnNuZF9zb2ZfaW50ZWxfaGRhX2NvbW1v
bgpzbmRfc29mX2ludGVsX2hkYV9nZW5lcmljCnNuZF9zb2ZfaW50ZWxfaGRhX21saW5rCnNu
ZF9zb2ZfaW50ZWxfaGRhX3Nkd19icHQKc25kX3NvZl9wY2kKc25kX3NvZl9wY2lfaW50ZWxf
bG5sCnNuZF9zb2ZfcGNpX2ludGVsX210bApzbmRfc29mX3BjaV9pbnRlbF9wdGwKc25kX3Nv
Zl9wcm9iZXMKc25kX3NvZl91dGlscwpzbmRfc29mX3h0ZW5zYV9kc3AKc25kX3RpbWVyCnNv
dW5kY29yZQpzb3VuZHdpcmVfYnVzCnNvdW5kd2lyZV9jYWRlbmNlCnNvdW5kd2lyZV9nZW5l
cmljX2FsbG9jYXRpb24Kc291bmR3aXJlX2ludGVsCnNwYXJzZV9rZXltYXAKc3BpX2ludGVs
CnNwaV9pbnRlbF9wY2kKc3BpX25vcgp0Y3BfZGlhZwp0aHVuZGVyYm9sdAp0dG0KdHVuCnR5
cGVjCnR5cGVjX3Vjc2kKdWNzaV9hY3BpCnVkcF9kaWFnCnVoaWQKdW5peF9kaWFnCnV2Ywp1
dmN2aWRlbwp2ZmF0CnZpZGVvCnZpZGVvYnVmMl9jb21tb24KdmlkZW9idWYyX21lbW9wcwp2
aWRlb2J1ZjJfdjRsMgp2aWRlb2J1ZjJfdm1hbGxvYwp2aWRlb2Rldgp3bWkKd21pX2Jtb2YK
eDg2X3BrZ190ZW1wX3RoZXJtYWwKeF90YWJsZXMKeGUKeHRfTE9HCnh0X2FkZHJ0eXBlCnh0
X2Nvbm50cmFjawp4dF9obAp4dF9saW1pdAp4dF90Y3B1ZHAKenJhbQoKCiEhU3lzZnMgRmls
ZXMKISEtLS0tLS0tLS0tLQoKL3N5cy9jbGFzcy9zb3VuZC9od0MwRDIvaW5pdF9waW5fY29u
ZmlnczoKMHgwNCAweDE4NTYwMDEwCjB4MDYgMHgxODU2MDAxMAoweDA4IDB4MTg1NjAwMTAK
MHgwYSAweDE4NTYwMDEwCjB4MGIgMHgxODU2MDAxMAoweDBjIDB4MTg1NjAwMTAKMHgwZCAw
eDE4NTYwMDEwCjB4MGUgMHgxODU2MDAxMAoweDBmIDB4MTg1NjAwMTAKCi9zeXMvY2xhc3Mv
c291bmQvaHdDMEQyL2RyaXZlcl9waW5fY29uZmlnczoKCi9zeXMvY2xhc3Mvc291bmQvaHdD
MEQyL3VzZXJfcGluX2NvbmZpZ3M6Cgovc3lzL2NsYXNzL3NvdW5kL2h3QzBEMi9pbml0X3Zl
cmJzOgoKL3N5cy9jbGFzcy9zb3VuZC9od0MwRDIvaGludHM6CgoKISFBTFNBL0hEQSBkbWVz
ZwohIS0tLS0tLS0tLS0tLS0tCgoKCg==
--------------clqANTxl0gfzoJEWvXn1dIAG
Content-Type: text/plain; charset=UTF-8; name="dmesg-audio.txt"
Content-Disposition: attachment; filename="dmesg-audio.txt"
Content-Transfer-Encoding: base64

PT09IGRtZXNnIOmfs+mikeebuOWFsyjmnKzmrKHlvIDmnLopID09PQpOb3YgMjIgMDE6Mzg6
MzggeGlhb21pIGtlcm5lbDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4z
OiBTb3VuZFdpcmUgZW5hYmxlZCBvbiBDYW5ub25MYWtlKyBwbGF0Zm9ybSwgdXNpbmcgU09G
IGRyaXZlcgpOb3YgMjIgMDE6Mzg6MzggeGlhb21pIGtlcm5lbDogc29mLWF1ZGlvLXBjaS1p
bnRlbC1wdGwgMDAwMDowMDoxZi4zOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMikK
Tm92IDIyIDAxOjM4OjM4IHhpYW9taSBrZXJuZWw6IHNvZi1hdWRpby1wY2ktaW50ZWwtcHRs
IDAwMDA6MDA6MWYuMzogRFNQIGRldGVjdGVkIHdpdGggUENJIGNsYXNzL3N1YmNsYXNzL3By
b2ctaWYgMHgwNDAxMDAKTm92IDIyIDAxOjM4OjM4IHhpYW9taSBrZXJuZWw6IHNvZi1hdWRp
by1wY2ktaW50ZWwtcHRsIDAwMDA6MDA6MWYuMzogYm91bmQgMDAwMDowMDowMi4wIChvcHMg
aW50ZWxfYXVkaW9fY29tcG9uZW50X2JpbmRfb3BzIFt4ZV0pCk5vdiAyMiAwMTozODozOCB4
aWFvbWkga2VybmVsOiBzb2YtYXVkaW8tcGNpLWludGVsLXB0bCAwMDAwOjAwOjFmLjM6IHVz
ZSBtc2kgaW50ZXJydXB0IG1vZGUKTm92IDIyIDAxOjM4OjM4IHhpYW9taSBrZXJuZWw6IHNv
Zi1hdWRpby1wY2ktaW50ZWwtcHRsIDAwMDA6MDA6MWYuMzogTm8gU291bmRXaXJlIG1hY2hp
bmUgZHJpdmVyIGZvdW5kIGZvciB0aGUgQUNQSS1yZXBvcnRlZCBjb25maWd1cmF0aW9uOgpO
b3YgMjIgMDE6Mzg6MzggeGlhb21pIGtlcm5lbDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwg
MDAwMDowMDoxZi4zOiBsaW5rIDMgbWZnX2lkIDB4MDI1ZCBwYXJ0X2lkIDB4MDcyMSB2ZXJz
aW9uIDB4MwpOb3YgMjIgMDE6Mzg6MzggeGlhb21pIGtlcm5lbDogc29mLWF1ZGlvLXBjaS1p
bnRlbC1wdGwgMDAwMDowMDoxZi4zOiBsaW5rIDMgbWZnX2lkIDB4MDI1ZCBwYXJ0X2lkIDB4
MTMyMCB2ZXJzaW9uIDB4MwpOb3YgMjIgMDE6Mzg6MzggeGlhb21pIGtlcm5lbDogc29mLWF1
ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiBVc2UgU291bmRXaXJlIGRlZmF1bHQg
bWFjaGluZSBkcml2ZXIgd2l0aCBmdW5jdGlvbiB0b3BvbG9naWVzCk5vdiAyMiAwMTozODoz
OCB4aWFvbWkga2VybmVsOiBzb2YtYXVkaW8tcGNpLWludGVsLXB0bCAwMDAwOjAwOjFmLjM6
IGhkYSBjb2RlY3MgZm91bmQsIG1hc2sgNApOb3YgMjIgMDE6Mzg6MzggeGlhb21pIGtlcm5l
bDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiBOSExUIGRldmljZSBC
VCgwKSBkZXRlY3RlZCwgc3NwX21hc2sgMHg0Ck5vdiAyMiAwMTozODozOCB4aWFvbWkga2Vy
bmVsOiBzb2YtYXVkaW8tcGNpLWludGVsLXB0bCAwMDAwOjAwOjFmLjM6IEJUIGxpbmsgZGV0
ZWN0ZWQgaW4gTkhMVCB0YWJsZXM6IDB4NApOb3YgMjIgMDE6Mzg6MzggeGlhb21pIGtlcm5l
bDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiBETUlDcyBkZXRlY3Rl
ZCBpbiBOSExUIHRhYmxlczogMApOb3YgMjIgMDE6Mzg6MzggeGlhb21pIGtlcm5lbDogc29m
LWF1ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiBGaXJtd2FyZSBwYXRocy9maWxl
cyBmb3IgaXBjIHR5cGUgMToKTm92IDIyIDAxOjM4OjM4IHhpYW9taSBrZXJuZWw6IHNvZi1h
dWRpby1wY2ktaW50ZWwtcHRsIDAwMDA6MDA6MWYuMzogIEZpcm13YXJlIGZpbGU6ICAgICBp
bnRlbC9zb2YtaXBjNC9wdGwvc29mLXB0bC5yaQpOb3YgMjIgMDE6Mzg6MzggeGlhb21pIGtl
cm5lbDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiAgRmlybXdhcmUg
bGliIHBhdGg6IGludGVsL3NvZi1pcGM0LWxpYi9wdGwKTm92IDIyIDAxOjM4OjM4IHhpYW9t
aSBrZXJuZWw6IHNvZi1hdWRpby1wY2ktaW50ZWwtcHRsIDAwMDA6MDA6MWYuMzogIFRvcG9s
b2d5IGZpbGU6ICAgICBmdW5jdGlvbiB0b3BvbG9naWVzCk5vdiAyMiAwMTozODozOCB4aWFv
bWkga2VybmVsOiBzb2YtYXVkaW8tcGNpLWludGVsLXB0bCAwMDAwOjAwOjFmLjM6IExvYWRl
ZCBmaXJtd2FyZSBsaWJyYXJ5OiBBRFNQRlcsIHZlcnNpb246IDIuMTUuMC4xCk5vdiAyMiAw
MTozODozOSB4aWFvbWkga2VybmVsOiBzb2YtYXVkaW8tcGNpLWludGVsLXB0bCAwMDAwOjAw
OjFmLjM6IExvYWRlZCBmaXJtd2FyZSBsaWJyYXJ5OiBBRFNQRlcsIHZlcnNpb246IDIuMTUu
MC4xCk5vdiAyMiAwMTozODozOSB4aWFvbWkga2VybmVsOiBzb2YtYXVkaW8tcGNpLWludGVs
LXB0bCAwMDAwOjAwOjFmLjM6IEJvb3RlZCBmaXJtd2FyZSB2ZXJzaW9uOiAyLjE1LjAuMQpO
b3YgMjIgMDE6Mzg6MzkgeGlhb21pIGtlcm5lbDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwg
MDAwMDowMDoxZi4zOiBVc2luZyBmdW5jdGlvbiB0b3BvbG9naWVzIGluc3RlYWQgaW50ZWwv
c29mLWlwYzQtdHBsZy9zb2YtcHRsLWR1bW15LnRwbGcKTm92IDIyIDAxOjM4OjM5IHhpYW9t
aSBrZXJuZWw6IHNvZi1hdWRpby1wY2ktaW50ZWwtcHRsIDAwMDA6MDA6MWYuMzogbG9hZGlu
ZyB0b3BvbG9neSAwOiBpbnRlbC9zb2YtaXBjNC10cGxnL3NvZi1zZGNhLWphY2staWQwLnRw
bGcKTm92IDIyIDAxOjM4OjM5IHhpYW9taSBrZXJuZWw6IHNvZi1hdWRpby1wY2ktaW50ZWwt
cHRsIDAwMDA6MDA6MWYuMzogVG9wb2xvZ3k6IEFCSSAzOjI5OjEgS2VybmVsIEFCSSAzOjIz
OjEKTm92IDIyIDAxOjM4OjM5IHhpYW9taSBrZXJuZWw6IHNvZl9zZHcgc29mX3NkdzogQVNv
QzogUGFyZW50IGNhcmQgbm90IHlldCBhdmFpbGFibGUsIHdpZGdldCBjYXJkIGJpbmRpbmcg
ZGVmZXJyZWQKTm92IDIyIDAxOjM4OjM5IHhpYW9taSBrZXJuZWw6IHNvZi1hdWRpby1wY2kt
aW50ZWwtcHRsIDAwMDA6MDA6MWYuMzogbG9hZGluZyB0b3BvbG9neSAxOiBpbnRlbC9zb2Yt
aXBjNC10cGxnL3NvZi1zZGNhLW1pYy1pZDQudHBsZwpOb3YgMjIgMDE6Mzg6MzkgeGlhb21p
IGtlcm5lbDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiBUb3BvbG9n
eTogQUJJIDM6Mjk6MSBLZXJuZWwgQUJJIDM6MjM6MQpOb3YgMjIgMDE6Mzg6MzkgeGlhb21p
IGtlcm5lbDogc29mX3NkdyBzb2Zfc2R3OiBBU29DOiBQYXJlbnQgY2FyZCBub3QgeWV0IGF2
YWlsYWJsZSwgd2lkZ2V0IGNhcmQgYmluZGluZyBkZWZlcnJlZApOb3YgMjIgMDE6Mzg6Mzkg
eGlhb21pIGtlcm5lbDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiBs
b2FkaW5nIHRvcG9sb2d5IDI6IGludGVsL3NvZi1pcGM0LXRwbGcvc29mLXNkY2EtMWFtcC1p
ZDIudHBsZwpOb3YgMjIgMDE6Mzg6MzkgeGlhb21pIGtlcm5lbDogc29mLWF1ZGlvLXBjaS1p
bnRlbC1wdGwgMDAwMDowMDoxZi4zOiBUb3BvbG9neTogQUJJIDM6Mjk6MSBLZXJuZWwgQUJJ
IDM6MjM6MQpOb3YgMjIgMDE6Mzg6MzkgeGlhb21pIGtlcm5lbDogc29mX3NkdyBzb2Zfc2R3
OiBBU29DOiBQYXJlbnQgY2FyZCBub3QgeWV0IGF2YWlsYWJsZSwgd2lkZ2V0IGNhcmQgYmlu
ZGluZyBkZWZlcnJlZApOb3YgMjIgMDE6Mzg6MzkgeGlhb21pIGtlcm5lbDogc29mLWF1ZGlv
LXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiBsb2FkaW5nIHRvcG9sb2d5IDM6IGludGVs
L3NvZi1pcGM0LXRwbGcvc29mLWhkbWktcGNtNS1pZDUudHBsZwpOb3YgMjIgMDE6Mzg6Mzkg
eGlhb21pIGtlcm5lbDogc29mLWF1ZGlvLXBjaS1pbnRlbC1wdGwgMDAwMDowMDoxZi4zOiBU
b3BvbG9neTogQUJJIDM6Mjk6MSBLZXJuZWwgQUJJIDM6MjM6MQpOb3YgMjIgMDE6Mzg6Mzkg
eGlhb21pIGtlcm5lbDogc29mX3NkdyBzb2Zfc2R3OiBBU29DOiBQYXJlbnQgY2FyZCBub3Qg
eWV0IGF2YWlsYWJsZSwgd2lkZ2V0IGNhcmQgYmluZGluZyBkZWZlcnJlZApOb3YgMjIgMDE6
Mzg6MzkgeGlhb21pIGtlcm5lbDogc29mX3NkdyBzb2Zfc2R3OiBoZGFfZHNwX2hkbWlfYnVp
bGRfY29udHJvbHM6IG5vIFBDTSBpbiB0b3BvbG9neSBmb3IgSERNSSBjb252ZXJ0ZXIgMwpO
b3YgMjIgMDE6Mzg6MzkgeGlhb21pIGtlcm5lbDogaW5wdXQ6IHNvZi1zb3VuZHdpcmUgSGVh
ZHNldCBKYWNrIGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDoxZi4zL3NvZl9zZHcv
c291bmQvY2FyZDAvaW5wdXQzMApOb3YgMjIgMDE6Mzg6MzkgeGlhb21pIGtlcm5lbDogaW5w
dXQ6IHNvZi1zb3VuZHdpcmUgSERNSS9EUCxwY209NSBhcyAvZGV2aWNlcy9wY2kwMDAwOjAw
LzAwMDA6MDA6MWYuMy9zb2Zfc2R3L3NvdW5kL2NhcmQwL2lucHV0MzEKTm92IDIyIDAxOjM4
OjM5IHhpYW9taSBrZXJuZWw6IGlucHV0OiBzb2Ytc291bmR3aXJlIEhETUkvRFAscGNtPTYg
YXMgL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFmLjMvc29mX3Nkdy9zb3VuZC9jYXJk
MC9pbnB1dDMyCk5vdiAyMiAwMTozODozOSB4aWFvbWkga2VybmVsOiBpbnB1dDogc29mLXNv
dW5kd2lyZSBIRE1JL0RQLHBjbT03IGFzIC9kZXZpY2VzL3BjaTAwMDA6MDAvMDAwMDowMDox
Zi4zL3NvZl9zZHcvc291bmQvY2FyZDAvaW5wdXQzMwpOb3YgMjIgMTc6NTU6NDggeGlhb21p
IGtlcm5lbDogc291bmR3aXJlX2ludGVsIHNvdW5kd2lyZV9pbnRlbC5saW5rLjM6IEJ1cyBj
bGFzaCBmb3IgY29udHJvbCB3b3JkCk5vdiAyMiAxNzo1NTo0OCB4aWFvbWkga2VybmVsOiBz
b3VuZHdpcmVfaW50ZWwgc291bmR3aXJlX2ludGVsLmxpbmsuMzogQnVzIGNsYXNoIGZvciBk
YXRhIHdvcmQKTm92IDIyIDE3OjU1OjQ4IHhpYW9taSBrZXJuZWw6IHJ0MTMyMC1zZGNhIHNk
dzowOjM6MDI1ZDoxMzIwOjAxOiBCdXMgY2xhc2ggZGV0ZWN0ZWQKTm92IDIyIDE4OjAwOjA2
IHhpYW9taSBrZXJuZWw6IHNvdW5kd2lyZV9pbnRlbCBzb3VuZHdpcmVfaW50ZWwubGluay4z
OiBCdXMgY2xhc2ggZm9yIGNvbnRyb2wgd29yZApOb3YgMjIgMTg6MDA6MDYgeGlhb21pIGtl
cm5lbDogc291bmR3aXJlX2ludGVsIHNvdW5kd2lyZV9pbnRlbC5saW5rLjM6IEJ1cyBjbGFz
aCBmb3IgZGF0YSB3b3JkCk5vdiAyMiAxODoxMToxMCB4aWFvbWkga2VybmVsOiBzb3VuZHdp
cmVfaW50ZWwgc291bmR3aXJlX2ludGVsLmxpbmsuMzogQnVzIGNsYXNoIGZvciBjb250cm9s
IHdvcmQKTm92IDIyIDE4OjExOjEwIHhpYW9taSBrZXJuZWw6IHNvdW5kd2lyZV9pbnRlbCBz
b3VuZHdpcmVfaW50ZWwubGluay4zOiBCdXMgY2xhc2ggZm9yIGRhdGEgd29yZApOb3YgMjIg
MTg6MTk6MzYgeGlhb21pIGtlcm5lbDogc291bmR3aXJlX2ludGVsIHNvdW5kd2lyZV9pbnRl
bC5saW5rLjM6IEJ1cyBjbGFzaCBmb3IgY29udHJvbCB3b3JkCk5vdiAyMiAxODoxOTozNiB4
aWFvbWkga2VybmVsOiBzb3VuZHdpcmVfaW50ZWwgc291bmR3aXJlX2ludGVsLmxpbmsuMzog
QnVzIGNsYXNoIGZvciBkYXRhIHdvcmQKTm92IDIyIDIwOjQyOjE1IHhpYW9taSBrZXJuZWw6
IHJ0NzIxLXNkY2Egc2R3OjA6MzowMjVkOjA3MjE6MDE6IEJ1cyBjbGFzaCBkZXRlY3RlZCBi
ZWZvcmUgSU5UIG1hc2sgaXMgZW5hYmxlZApOb3YgMjIgMjA6NDI6MTggeGlhb21pIGtlcm5l
bDogTW9kdWxlcyBsaW5rZWQgaW46IGJpdGxhbmRfbWlmc193bWkgdW5peF9kaWFnIGhpZF9h
cHBsZSBhcHBsZV9tZmlfZmFzdGNoYXJnZSB1ZHBfZGlhZyB0Y3BfZGlhZyBpbmV0X2RpYWcg
c25kX3NlcV9kdW1teSBzbmRfaHJ0aW1lciByZmNvbW0gc25kX3NlcSBzbmRfc2VxX2Rldmlj
ZSB0dW4gY2NtIHNuZF9jdGxfbGVkIHNuZF9zb2Nfc29mX3NkdyBzbmRfc29mX3Byb2JlcyBz
bmRfc29jX2ludGVsX2hkYV9kc3BfY29tbW9uIHNuZF9zb2NfcnQ3MjFfc2RjYSBzbmRfc29j
X3J0MTMyMF9zZHcgc25kX3NvY19ydF9zZHdfY29tbW9uIHNuZF9oZGFfY29kZWNfaW50ZWxo
ZG1pIHJlZ21hcF9zZHdfbWJxIHNuZF9oZGFfY29kZWNfaGRtaSByZWdtYXBfc2R3IHNuZF9z
b2NfZG1pYyBzbmRfaGRhX2ludGVsIHNuZF9zb2ZfcGNpX2ludGVsX3B0bCBzbmRfc29mX3Bj
aV9pbnRlbF9sbmwgc25kX3NvZl9wY2lfaW50ZWxfbXRsIHNuZF9zb2ZfaW50ZWxfaGRhX2dl
bmVyaWMgc291bmR3aXJlX2ludGVsIHNuZF9zb2ZfaW50ZWxfaGRhX3Nkd19icHQgdWhpZCBz
bmRfc29mX2ludGVsX2hkYV9jb21tb24gYWxnaWZfaGFzaCBzbmRfc29jX2hkYWNfaGRhIGFs
Z2lmX3NrY2lwaGVyIHNuZF9zb2ZfaW50ZWxfaGRhIGFmX2FsZyBzbmRfc29mX2ludGVsX2hk
YV9tbGluayBzb3VuZHdpcmVfY2FkZW5jZSBibmVwIHNuZF9zb2ZfcGNpIHNuZF9zb2ZfeHRl
bnNhX2RzcCBzbmRfc29mIHNuZF9zb2ZfdXRpbHMgaW50ZWxfcmFwbF9tc3Igc25kX2hkYV9l
eHRfY29yZSBpbnRlbF91bmNvcmVfZnJlcXVlbmN5IGludGVsX3VuY29yZV9mcmVxdWVuY3lf
Y29tbW9uIHNuZF9oZGFfY29kZWMgc25kX2hkYV9jb3JlIHNuZF9zb2NfYWNwaV9pbnRlbF9t
YXRjaCBzbmRfc29jX2FjcGlfaW50ZWxfc2RjYV9xdWlya3Mgc25kX2ludGVsX2RzcGNmZyBz
bmRfaW50ZWxfc2R3X2FjcGkgc291bmR3aXJlX2dlbmVyaWNfYWxsb2NhdGlvbiBzbmRfc29j
X3Nkd191dGlscyBzbmRfc29jX2FjcGkgc25kX2h3ZGVwIHNvdW5kd2lyZV9idXMKTm92IDIy
IDIyOjAxOjIyIHhpYW9taSBrZXJuZWw6IHNvdW5kd2lyZV9pbnRlbCBzb3VuZHdpcmVfaW50
ZWwubGluay4zOiBCdXMgY2xhc2ggZm9yIGRhdGEgd29yZApOb3YgMjIgMjI6MDU6NTAgeGlh
b21pIGtlcm5lbDogc291bmR3aXJlX2ludGVsIHNvdW5kd2lyZV9pbnRlbC5saW5rLjM6IFBh
cml0eSBlcnJvcgpOb3YgMjIgMjI6MDU6NTAgeGlhb21pIGtlcm5lbDogc291bmR3aXJlX2lu
dGVsIHNvdW5kd2lyZV9pbnRlbC5saW5rLjM6IEJ1cyBjbGFzaCBmb3IgY29udHJvbCB3b3Jk
Ck5vdiAyMiAyMjowNTo1MCB4aWFvbWkga2VybmVsOiBzb3VuZHdpcmVfaW50ZWwgc291bmR3
aXJlX2ludGVsLmxpbmsuMzogQnVzIGNsYXNoIGZvciBkYXRhIHdvcmQKTm92IDIyIDIyOjA1
OjUwIHhpYW9taSBrZXJuZWw6IHJ0NzIxLXNkY2Egc2R3OjA6MzowMjVkOjA3MjE6MDE6IFBh
cml0eSBlcnJvciBkZXRlY3RlZApOb3YgMjIgMjI6MDk6NTAgeGlhb21pIGtlcm5lbDogc291
bmR3aXJlX2ludGVsIHNvdW5kd2lyZV9pbnRlbC5saW5rLjM6IEJ1cyBjbGFzaCBmb3IgY29u
dHJvbCB3b3JkCk5vdiAyMiAyMjowOTo1MCB4aWFvbWkga2VybmVsOiBzb3VuZHdpcmVfaW50
ZWwgc291bmR3aXJlX2ludGVsLmxpbmsuMzogQnVzIGNsYXNoIGZvciBkYXRhIHdvcmQKTm92
IDIyIDIyOjEyOjM5IHhpYW9taSBrZXJuZWw6IHJ0NzIxLXNkY2Egc2R3OjA6MzowMjVkOjA3
MjE6MDE6IEFTb0MgZXJyb3IgKC02MSk6IGF0IHNuZF9zb2NfcGNtX2NvbXBvbmVudF9wbV9y
dW50aW1lX2dldCgpIG9uIHNkdzowOjM6MDI1ZDowNzIxOjAxCk5vdiAyMiAyMjoxMjozOSB4
aWFvbWkga2VybmVsOiAgU0RXMy1QbGF5YmFjay1TaW1wbGVKYWNrOiBBU29DIGVycm9yICgt
NjEpOiBhdCBfX3NvY19wY21fb3BlbigpIG9uIFNEVzMtUGxheWJhY2stU2ltcGxlSmFjawpO
b3YgMjIgMjI6MTI6MzkgeGlhb21pIGtlcm5lbDogIEphY2sgT3V0OiBBU29DIGVycm9yICgt
NjEpOiBhdCBkcGNtX2JlX2RhaV9zdGFydHVwKCkgb24gSmFjayBPdXQKTm92IDIyIDIyOjEy
OjM5IHhpYW9taSBrZXJuZWw6ICBKYWNrIE91dDogQVNvQyBlcnJvciAoLTYxKTogYXQgZHBj
bV9mZV9kYWlfc3RhcnR1cCgpIG9uIEphY2sgT3V0Ck5vdiAyMiAyMjoxMjozOSB4aWFvbWkg
a2VybmVsOiBydDcyMS1zZGNhIHNkdzowOjM6MDI1ZDowNzIxOjAxOiBBU29DIGVycm9yICgt
NjEpOiBhdCBzbmRfc29jX3BjbV9jb21wb25lbnRfcG1fcnVudGltZV9nZXQoKSBvbiBzZHc6
MDozOjAyNWQ6MDcyMTowMQpOb3YgMjIgMjI6MTI6MzkgeGlhb21pIGtlcm5lbDogIFNEVzMt
Q2FwdHVyZS1TbWFydE1pYzogQVNvQyBlcnJvciAoLTYxKTogYXQgX19zb2NfcGNtX29wZW4o
KSBvbiBTRFczLUNhcHR1cmUtU21hcnRNaWMKTm92IDIyIDIyOjEyOjM5IHhpYW9taSBrZXJu
ZWw6ICBNaWNyb3Bob25lOiBBU29DIGVycm9yICgtNjEpOiBhdCBkcGNtX2JlX2RhaV9zdGFy
dHVwKCkgb24gTWljcm9waG9uZQpOb3YgMjIgMjI6MTI6MzkgeGlhb21pIGtlcm5lbDogIE1p
Y3JvcGhvbmU6IEFTb0MgZXJyb3IgKC02MSk6IGF0IGRwY21fZmVfZGFpX3N0YXJ0dXAoKSBv
biBNaWNyb3Bob25lCk5vdiAyMiAyMjoxMjozOSB4aWFvbWkga2VybmVsOiBydDcyMS1zZGNh
IHNkdzowOjM6MDI1ZDowNzIxOjAxOiBBU29DIGVycm9yICgtNjEpOiBhdCBzbmRfc29jX3Bj
bV9jb21wb25lbnRfcG1fcnVudGltZV9nZXQoKSBvbiBzZHc6MDozOjAyNWQ6MDcyMTowMQpO
b3YgMjIgMjI6MTI6MzkgeGlhb21pIGtlcm5lbDogIFNEVzMtQ2FwdHVyZS1TaW1wbGVKYWNr
OiBBU29DIGVycm9yICgtNjEpOiBhdCBfX3NvY19wY21fb3BlbigpIG9uIFNEVzMtQ2FwdHVy
ZS1TaW1wbGVKYWNrCk5vdiAyMiAyMjoxMjozOSB4aWFvbWkga2VybmVsOiAgSmFjayBJbjog
QVNvQyBlcnJvciAoLTYxKTogYXQgZHBjbV9iZV9kYWlfc3RhcnR1cCgpIG9uIEphY2sgSW4K
Tm92IDIyIDIyOjEyOjM5IHhpYW9taSBrZXJuZWw6ICBKYWNrIEluOiBBU29DIGVycm9yICgt
NjEpOiBhdCBkcGNtX2ZlX2RhaV9zdGFydHVwKCkgb24gSmFjayBJbgpOb3YgMjIgMjI6MTQ6
MDggeGlhb21pIGtlcm5lbDogc291bmR3aXJlX2ludGVsIHNvdW5kd2lyZV9pbnRlbC5saW5r
LjM6IFBhcml0eSBlcnJvcgpOb3YgMjIgMjI6MTQ6MDggeGlhb21pIGtlcm5lbDogc291bmR3
aXJlX2ludGVsIHNvdW5kd2lyZV9pbnRlbC5saW5rLjM6IEJ1cyBjbGFzaCBmb3IgY29udHJv
bCB3b3JkCk5vdiAyMiAyMjoxNDowOCB4aWFvbWkga2VybmVsOiBzb3VuZHdpcmVfaW50ZWwg
c291bmR3aXJlX2ludGVsLmxpbmsuMzogQnVzIGNsYXNoIGZvciBkYXRhIHdvcmQK
--------------clqANTxl0gfzoJEWvXn1dIAG
Content-Type: text/plain; charset=UTF-8; name="hardware.txt"
Content-Disposition: attachment; filename="hardware.txt"
Content-Transfer-Encoding: base64

PT09IERNSSA9PT0Kc3lzX3ZlbmRvcjogWElBT01JCnByb2R1Y3RfbmFtZTogWGlhb21pIEJv
b2sgUHJvIDE0CmJvYXJkX25hbWU6IFRNMjQyNApib2FyZF92ZXJzaW9uOiBWMTRFMQpiaW9z
X3ZlcnNpb246IFhNQVBUNEIwUDBBMEEKYmlvc19kYXRlOiAwNi8xNy8yMDI2CnByb2R1Y3Rf
c2t1OiBUTTI0MjQtNzcwNzkKCj09PSBLRVJORUwgPT09CkxpbnV4IHhpYW9taSA3LjMuNS0y
LWNhY2h5b3MgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBGcmksIDIwIE5vdiAyMDI2IDE5OjM0
OjE1ICswMDAwIHg4Nl82NCBHTlUvTGludXgKCj09PSBMU1BDSSBBVURJTyA9PT0KMDA6MWYu
MyBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXIgWzA0MDFdOiBJbnRlbCBDb3Jwb3JhdGlv
biBDb3JlIFVsdHJhIFByb2Nlc3NvcnMgKFNlcmllcyAzKSBIRCBBdWRpbyBbODA4NjplNDI4
XSAocmV2IDAxKQoKPT09IEFQTEFZIC1sID09PQoqKioqIExpc3Qgb2YgUExBWUJBQ0sgSGFy
ZHdhcmUgRGV2aWNlcyAqKioqCmNhcmQgMDogc29mc291bmR3aXJlIFtzb2Ytc291bmR3aXJl
XSwgZGV2aWNlIDA6IEphY2sgT3V0ICgqKSBbXQogIFN1YmRldmljZXM6IDEvMQogIFN1YmRl
dmljZSAjMDogc3ViZGV2aWNlICMwCmNhcmQgMDogc29mc291bmR3aXJlIFtzb2Ytc291bmR3
aXJlXSwgZGV2aWNlIDI6IFNwZWFrZXIgKCopIFtdCiAgU3ViZGV2aWNlczogMS8xCiAgU3Vi
ZGV2aWNlICMwOiBzdWJkZXZpY2UgIzAKY2FyZCAwOiBzb2Zzb3VuZHdpcmUgW3NvZi1zb3Vu
ZHdpcmVdLCBkZXZpY2UgNTogSERNSTEgKCopIFtIRE1JIDFdCiAgU3ViZGV2aWNlczogMS8x
CiAgU3ViZGV2aWNlICMwOiBzdWJkZXZpY2UgIzAKY2FyZCAwOiBzb2Zzb3VuZHdpcmUgW3Nv
Zi1zb3VuZHdpcmVdLCBkZXZpY2UgNjogSERNSTIgKCopIFtIRE1JIDJdCiAgU3ViZGV2aWNl
czogMS8xCiAgU3ViZGV2aWNlICMwOiBzdWJkZXZpY2UgIzAKY2FyZCAwOiBzb2Zzb3VuZHdp
cmUgW3NvZi1zb3VuZHdpcmVdLCBkZXZpY2UgNzogSERNSTMgKCopIFtIRE1JIDNdCiAgU3Vi
ZGV2aWNlczogMS8xCiAgU3ViZGV2aWNlICMwOiBzdWJkZXZpY2UgIzAKY2FyZCAwOiBzb2Zz
b3VuZHdpcmUgW3NvZi1zb3VuZHdpcmVdLCBkZXZpY2UgMzE6IERlZXBidWZmZXIgSmFjayBP
dXQgKCopIFtdCiAgU3ViZGV2aWNlczogMS8xCiAgU3ViZGV2aWNlICMwOiBzdWJkZXZpY2Ug
IzAKY2FyZCAwOiBzb2Zzb3VuZHdpcmUgW3NvZi1zb3VuZHdpcmVdLCBkZXZpY2UgMzU6IERl
ZXBidWZmZXIgU3BlYWtlciAoKikgW10KICBTdWJkZXZpY2VzOiAxLzEKICBTdWJkZXZpY2Ug
IzA6IHN1YmRldmljZSAjMAo=
--------------clqANTxl0gfzoJEWvXn1dIAG
Content-Type: text/plain; charset=UTF-8; name="card-info.txt"
Content-Disposition: attachment; filename="card-info.txt"
Content-Transfer-Encoding: base64

LS0tIC9wcm9jL2Fzb3VuZC9jYXJkcyAtLS0KIDAgW3NvZnNvdW5kd2lyZSAgIF06IHNvZi1z
b3VuZHdpcmUgLSBzb2Ytc291bmR3aXJlCiAgICAgICAgICAgICAgICAgICAgICBYSUFPTUkt
WGlhb21pQm9va1BybzE0LVRNMjQyNAoKLS0tIGNvZGVjcyAtLS0KQ29kZWM6IEludGVsIFBh
bnRoZXIgTGFrZSBIRE1JCkFkZHJlc3M6IDIKQUZHIEZ1bmN0aW9uIElkOiAweDEgKHVuc29s
IDApClZlbmRvciBJZDogMHg4MDg2MjgyMgpTdWJzeXN0ZW0gSWQ6IDB4ODA4NjAxMDEKCi0t
LSBwY20gLS0tCg==

--------------clqANTxl0gfzoJEWvXn1dIAG--
