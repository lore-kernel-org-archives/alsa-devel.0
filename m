Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E64CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:09:46 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9C15C602DA;
	Tue, 29 Sep 2026 21:09:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9C15C602DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790708984;
	bh=BgyQ5r5j+sk+bLNtrLrGRi6ecWYHRRome3Bk8uNOZb4=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=FmlleNCpzPbcsr2Glk9qem0rJ9UAnk8sxEuYxGK6aLJS1YT5wSus9QKRhMY3Tuwm6
	 BnMulyYLFfWG+WdIdDCOZxWBbFzLdJ/reqImeFfmjArwIGfrqtzFkYwRpZNewzhw4Z
	 u7NnalKsqpnOsHTCv0vqQjnjCxu8rtqBQEFuAylQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6D1E0F806BE; Tue, 29 Sep 2026 21:07:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 996C8F806BE;
	Tue, 29 Sep 2026 21:07:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5710DF80525; Mon, 28 Sep 2026 08:10:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz;
 arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.169
ARC-Seal: i=2; d=alsa-project.org; s=arc; a=rsa-sha256; cv=pass; t=1790575852;
	b=Cx4M2AKaGEG87ZSAoGEnii3cuTD3SsORs08izi02yz9F8h6i7ihyoQehZVm0QHLLJHyS
	 LyQbmdmVvztx+85K00Zu8yzsb85tQdJYv4XwdtByDgRjE2v6X1JhwB6aUtbVHdgEPulmb
	 VvlTlGdRBD0nRg2gqOs6JWs0zDj7dsv2cZPobS+IYvovM6F8rsg9/LQs2TBc3VLC90R5G
	 kRz1spKUuS0MyTK/2XH3kOoav9ECEbRXa0k1v0lVmEtpCt+gGaHgMLTQ+6jgen8dKMRka
	 gu2NaMVRWx0Ci30muGV9N/7PtXkByRc0MIjVC2HPpMiZM9dq1GDR4w0JgZsiLzaU8ww==
ARC-Message-Signature: i=2; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790575852;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To;
	bh=0FjmVZsP29MPR81fb/XFfU7eUHxSH+LRgqJzVslxpSE=;
	b=XZe3n0Qb5EChdvBmEY+JXCPfVsB7vnBl+BGk+v4K1Ylq19cry7MzE0Ci1YsyOwLUPXfx
	 eO08Dcda5etlSR7mznqjQwPBw1K3CkkJMDqyiJKfmv8GVIi8onpugEtlyE5DJRX1AAoOJ
	 KHgSTIMAK/zCC/JAnThF4LCTr/6KDYpy5sesIV7pcaGH79CM4UU/fB8o/PD1T6k9d1Wqn
	 +I83FUC/kmDKP+9vTiyzlJGC9LmVDBl8qmkBAuJy3VXyt6egbCWNSuCS+r/Sm8oCjhTN6
	 JXLclQSNnh0bii12FhyWp2sJc3HbIrhn3iafs16IVrogYdHxI2p9gPEK93AG3d+CPzg==
ARC-Authentication-Results: i=2; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E+zkKf5h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.169
Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com
 [74.125.224.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id CB477F80020
	for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2026 08:10:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CB477F80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=E+zkKf5h
Received: by mail-yx2-f41.google.com with SMTP id
 00721157ae682-8a8496fd8c3so25416327b3.0
        for <alsa-devel@alsa-project.org>;
 Sun, 27 Sep 2026 23:10:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790575850; cv=none;
        d=google.com; s=arc-20260327;
        b=PL9AjSphxVT+1ukwqA2RjN8dfrgfdYlbRbR9YKCD+TDLcXm5ET126nx98GJYXNV08X
         ejXYgMgPgiuwSsajcsTWGLunXjGXy0wtq5w1RpZYmIlJFPreyksscE2wFlk3hVGH80xO
         fgsVFAiz9HyplAMU2Q85KjxisEOkMdJdIsBh/xQxiQekVakcWntBUGGwhC33PMPjZJkh
         pydSd8sdm7weql6XxZPOQTdHkJTyL7SQmgi32qZFapNKbL+/aPYBEpqEhj6xOouu5ri6
         HRojCVeeeemLZj3NDcCi0bMDOJ+xd7vo6XMsbwwqAC1/jG04IXoelh6lDW9wyJKMdIlS
         ONiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=pUxxtGsBMsVGh8VIcW5gRO7TXlpHsPBLHBpoNfaT+yM=;
        fh=Ocpafz32Em8yCoJejLm6AOgxXplQQ4vmZqMErS726JE=;
        b=m2tJJcXxMxwBy0nM/SNeUM6u4k4LNpp6kYn4/dFWPXN4atuQoiBqvTkANg+b0OLopc
         bbwT3H/9IoGqqr8/dsLQ6CAeLwsevhICpaevyUUWS2gLLfGYpnVQzkHF+IgZgZIDEMCy
         1eX7jKpCPIDpNStTkiYzVZorgbN+5FRe144jbr1RwzDT719MZU/IH0jOeJdMV1LSLSqQ
         VZpDjE0Bg28NtjnU8Rj2M8ZuIsWls0q1/FTguZnMjBcO7QBY34j/KhysJVTjyT493qC7
         Jj8m7X6EY33t4f/G7Sw5oRlxHtjh7Ru9BJiE28s+gTSzwjiU1dp5g5AoCPyI7fulqa2c
         r2HQ==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790575850; x=1791180650;
 darn=alsa-project.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pUxxtGsBMsVGh8VIcW5gRO7TXlpHsPBLHBpoNfaT+yM=;
        b=E+zkKf5hr1egGOMLo0EHP+CIai4Ij/8oG63vp/cPcXUfQFraoTYluJD/+HGjG0Nbdp
         2L58Xqh4s+Dul2MQtrD48M7hrVVSQ9QQ7E8qSvOt67+0nZs/E/s/2+utKrRoxIqYOp6o
         7GR3UIJSBBOnEhNxfyxit1CzDTS1HY4J7kzDLFO6/Pd713W7a1keh5MdXn7tGSD9ZMUR
         dk8u8Yl5lEG0SKtHZy5gUO74xge8EVLwwBqyUgFxPE1c8r9BsuqEnVJDuT4aNCZ7ih9F
         OqU5lQLjaL+YLnpFQsV8wutUBjbA5Wk3uTQMckRIMzKlBnFwGjx7HfEknFglD4maoE0K
         WaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790575850; x=1791180650;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pUxxtGsBMsVGh8VIcW5gRO7TXlpHsPBLHBpoNfaT+yM=;
        b=27KZM0m6EHkkLD8Lv4+jjXaGoez7YMiPWS8XcNZuce5OsGFqvlr7sHuhNTn4RcAvL2
         Oga0JeiTA4p0a/Uxs7Lq+E2KDa8GA8pa2Y6tCcFw6GGwIdalq15QBM5wPh2LfD4CVXVU
         3ZbES2DEBa76ZQM79hf4M0cUHuxrI5Vgj5xxA1BivDVeeFpJjABo1Sl5EWSONAZ6eaBZ
         Hl5aChfe9isHEIUXGwPn7d+78yY52HJmV4CldyOiKpdRPXvEFRxn3IOqa9/BEp7+OkEt
         6RZTI0ADMVShMB+63YYkFeOO8eNwsUV8EweUei08vDV8CVWgN/KzIFzSwAGB6Sok0nEB
         g4aQ==
X-Gm-Message-State: AFq9FYKDdtc7umQybvDJPEYFiGkCCyoQ311QSK7VcbbRqXhVTQdazqBf
	2dPK+2cq/RAo/iFFqpIYs4E/AVzHfRW8kDW8hhR/q+OJwVY191HVLgV3e5PBtKtRwHRkV545Gzh
	5yOCxwBHawgBGZa5e+elGX8VOYFmN7qaZAhyZONs=
X-Gm-Gg: AYBFou2QPqWWLzAzmwVo6Wheg53YL0UhR7sLOSxWp7NYS3yHriFdBsoGSAiUxjvowOA
	wDmNht5YDhuawp8LdBlW5WdlTXMhREU9WT57xc7Ajg9hJwA3VPnflusxxSaMhuCk576LaBwi5gq
	gcDqxKPNOLY4taHhDnNJU6fT8Y6o+NYMJP00tcQkqb4fmXv/RmfgPgTgDt+i8VBEDO0omauxN2j
	Mmb9yiuZVvNqPWB20E4KYmRYIJPi/SfCzxjeCzFd/H9H6RXBsY1W+gfUfjuy2xTBF662B1jbI2L
	ehbI6kCbdFWGvmCMB9DAn2p78phPoa6BD6KRQlOwFENeRIb0i1ighc3jtDVm1N5Mz14=
X-Received: by 2002:a05:690c:498f:b0:8aa:3a3a:1fcb with SMTP id
 00721157ae682-8aa3a3a206emr9952367b3.67.1790575849598; Sun, 27 Sep 2026
 23:10:49 -0700 (PDT)
MIME-Version: 1.0
From: Vishranth Arunkumar <vishranth.ak@gmail.com>
Date: Mon, 28 Sep 2026 02:10:38 -0400
X-Gm-Features: AclHuK8j5f6kO9UyoZNKPZFt2Z6_tbzQCzTAsnSxaoY9CjfeGUefW5s8vxs_AWA
Message-ID: 
 <CAL-UiWg5=ouP=GLGsoZov1WtuEmTMhHNpccUE9A2mu=QNVwJFA@mail.gmail.com>
Subject: 
 =?UTF-8?Q?=5BBUG=5D_sof=5Fsdw=3A_MSI_Stealth_16_AI=2B_B3WH_=E2=80=94_missing_S?=
	=?UTF-8?Q?DCA_board_match_causes_1amp_topology_selection_and_silent_in?=
	=?UTF-8?Q?ternal_speakers?=
To: alsa-devel@alsa-project.org
Cc: linux-sound@vger.kernel.org, broonie@kernel.org,
	pierre-louis.bossart@linux.dev, yung-chuan.liao@linux.intel.com
Content-Type: multipart/mixed; boundary="00000000000075b001065c84ed51"
X-MailFrom: vishranth.ak@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: WJY27GD7HIHMCLE3APWMANL2OQH3HUN3
X-Message-ID-Hash: WJY27GD7HIHMCLE3APWMANL2OQH3HUN3
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:06:57 +0000
X-Content-Filtered-By: Mailman/MimeDel 3.3.10
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/WJY27GD7HIHMCLE3APWMANL2OQH3HUN3/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

--00000000000075b001065c84ed51
Content-Type: text/plain; charset="UTF-8"

Hi all,

I am reporting a SoundWire/SOF issue on a recent Panther Lake laptop.

I should note up front that I am relatively new to Linux and have relied
on an LLM (DeepSeek) to assist with the investigation and diagnostic
collection. I have verified each command output reproduced below against
my running system, and I am happy to run any additional diagnostics or
provide further detail if needed. I understand that effective bug
resolution depends on accurate reports from users, and I want to make
sure this one is as useful as possible.

Summary
----------------
Internal speakers are silent on an MSI Stealth 16 AI+ B3WH (Panther Lake)
because sof_sdw has no board match for this DMI. The generic SDCA fallback
is therefore selected, which loads the single-amp function topology despite
two RT1320 SmartAmp devices being present and bound on SoundWire link 2.

Hardware
----------------
DMI:
  sys_vendor      = Micro-Star International Co., Ltd.
  product_name = Stealth 16 AI+ B3WH
  board_name    = MS-2631

SoundWire enumeration (confirmed via sysfs and kernel log):

  link 2:
    sdw:0:2:025d:1320:01:0   status: Attached   driver: rt1320-sdca
    sdw:0:2:025d:1320:01:1   status: Attached   driver: rt1320-sdca
  link 3:
    sdw:0:3:025d:0713:01     status: Attached   driver: rt712-sdca

Both RT1320 devices probe successfully and expose complete mixer control
sets (rt1320-1 and rt1320-2). All OT23 output switches report [on].

Observed behaviour
----------------
  $ sudo journalctl -k -b | grep -iE "sof|sdca|topology"

  acpi device:3a: SDCA function SmartAmp (type 1) at 0x4
  acpi device:3c: SDCA function SmartAmp (type 1) at 0x4
  acpi device:37: SDCA function UAJ (type 6) at 0x1
  acpi device:38: SDCA function SmartMic (type 3) at 0x2

  sof-audio-pci-intel-ptl 0000:00:1f.3: No SoundWire machine driver found
      for the ACPI-reported configuration:
  sof-audio-pci-intel-ptl 0000:00:1f.3: link 2 mfg_id 0x025d part_id 0x1320
version 0x3
  sof-audio-pci-intel-ptl 0000:00:1f.3: link 2 mfg_id 0x025d part_id 0x1320
version 0x3
  sof-audio-pci-intel-ptl 0000:00:1f.3: link 3 mfg_id 0x025d part_id 0x0713
version 0x3
  sof-audio-pci-intel-ptl 0000:00:1f.3: Use SoundWire default machine driver
      with function topologies

  ...
  loading topology 0: intel/sof-ipc4-tplg/sof-sdca-1amp-id2.tplg
  loading topology 1: intel/sof-ipc4-tplg/sof-sdca-jack-id0.tplg
  loading topology 2: intel/sof-ipc4-tplg/sof-sdca-mic-id4.tplg

Result
----------------
  - The 1amp SDCA function topology is loaded instead of a 2amp variant.
  - Both RT1320 codecs probe successfully and expose full control sets;
    all output switches are enabled.
  - PipeWire exposes a Speaker sink (default) but playback is silent.
  - The headphone jack (RT712) path works correctly.

The firmware provides a matching legacy topology file
(sof-ptl-rt712-l3-rt1320-l2.tplg) that is not selected, since the generic
SDCA path is active and the machine driver is absent. The 2amp SDCA
function topology (sof-sdca-2amp-id2.tplg) is also present but not chosen.

Userspace workarounds attempted
----------------
Both of the following were tried and rejected:

  - snd_soc_sof_sdw quirk=<value>
    The quirk bit definitions reside in
    sound/soc/intel/boards/sof_sdw_common.h, which is not shipped with
    kernel-devel. The available header
    (include/sound/soc_sdw_utils.h) documents no 2-amp bit for SDCA.
    amp_num is a const field in the codec-info table and cannot be
    overridden from userspace.

  - snd_sof.disable_function_topology=1
    On SOF firmware 2.14.1.1 the function topology path is mandatory.
    Forcing it off produces:

        Function topology is required, please upgrade sof-firmware
        error: failed to load DSP topology -22
        ASoC error (-22): at snd_soc_component_probe()

    The entire SOF card fails to instantiate; PipeWire falls back to
    Dummy Output, losing even the working headphone path.

Test environment
----------------
  Kernel:       7.2.4-ogc3.1.fc44.x86_64 (OGC custom, Bazzite)
  SOF firmware: 2.14.1.1

alsa-info.sh --no-upload output is attached (gzipped).

Reported-by:

Vishranth Arun Kumar
vishranth.ak@gmail.com

--00000000000075b001065c84ed51
Content-Type: application/gzip; name="alsa-info.txt.sIsqx0ZgeR.gz"
Content-Disposition: attachment; filename="alsa-info.txt.sIsqx0ZgeR.gz"
Content-Transfer-Encoding: base64
Content-ID: <f_mukuht1b0>
X-Attachment-Id: f_mukuht1b0

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
ywAA
--00000000000075b001065c84ed51--
