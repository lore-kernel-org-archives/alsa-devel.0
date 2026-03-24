Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BC3D58CC9
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:39:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FD73601F5;
	Tue, 24 Mar 2026 13:39:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FD73601F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1774355956;
	bh=2r1QniEWTq36w7qeA/F/9dBDbwbOtBtn8QX53zDE11E=;
	h=From:Date:Subject:To:Cc:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rXIFNy98DQLrpTCdVI/tcfIGvmriUIrhIjAK1MAb4vqZ8VJPkcJ2qu5QaEQYcsuG5
	 NUVwsHlLfM1H2es3HwfcskctzyMoeC/9Mn7sHqsThNjaJ+rhgH8mejtlLSs/fBSBjb
	 IWEeoVoWynyIcU8GcAIip/Ak3IvHw+pTKmIafVJk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F43EF805E4; Tue, 24 Mar 2026 13:38:42 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5731FF805E4;
	Tue, 24 Mar 2026 13:38:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 67F95F805BA; Tue, 24 Mar 2026 02:48:42 +0100 (CET)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9E988F800E2
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2026 02:48:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9E988F800E2
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=ozoM5Lk7
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-5a12c310e8aso3516232e87.3
        for <alsa-devel@alsa-project.org>;
 Mon, 23 Mar 2026 18:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774316918; cv=none;
        d=google.com; s=arc-20240605;
        b=LvApDe5dq6LNgkwLcL7QWsM2awkEmPB25XBVTwGQ65EQ/DfPvpe/z9JgB4qM4ctya+
         mBm6vPXuCW0p0wLeqHAvowCshAlThLXmqQ8rsO0jTjH/QgGtgromtnZS9TS4lbSMPa/X
         PCqoLO7M5ireDFL7WOE34ToD4AgUGNVH7vwa4sGoEdgwMF9rz74V9BXBpO0AEsIuf1fa
         QcTcZE4C2/HNVokZ9GumhofS+samF3FwHWhKPbacIEEhb2MDPR+cwVGDpsXJgw6WQRAX
         vcnQxzgF52x8n1fUKmzPV+fqzydGDHFcPeTigdPlVdTghVPxwGqpdg0tHDRfVpF/D4c3
         DF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5uSep2deqIOSdAomPw+sl7Wg+Qc84dTYheLgsFWuJy8=;
        fh=2yMrukEhQq5T0hiGRRM7kk9L0x50+M1UzIJSg4x1bSc=;
        b=Zlmk6+LZ7qktBspeAzByW3vQFan2jISRf0GJzcegzqBSdVX32+haWiXle2rrduPQY8
         aCd1p7NtpBFuGVRXv4PKEzqTwsBIeGYHHtRDMd5zHstyY7drTZ4s8snvQGcfAYO8A1KN
         R6MG3iNCnDh2vGxVFQjoMj2/PClzpCaD9rL4U3xOK2n0OjelQ+wiXB++WqDKPGgyjgsS
         Br0w5SI6RBNpUF/ehsGpeFxcCYhyzvRVVaavQopDpjCyd5+Dte3bt0HL11V0iB5MZwPo
         +GfwTLj8EXqgLPQnX9ySmZCVchXXMjz3As48DGUQ9D+RY6JVBO2uf2m1IMFs3Qy3L535
         Bpvw==;
        darn=alsa-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774316918; x=1774921718;
 darn=alsa-project.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5uSep2deqIOSdAomPw+sl7Wg+Qc84dTYheLgsFWuJy8=;
        b=ozoM5Lk7o5Lk/n8McUxcDKj9Nmcdp2HV/slgDmVMDq5Qh5roKrtPoUFJnvTQqxRh4y
         7TswWajT0o8/MmhMBcDjb5rnfT0pk84MnBx953nz1vrqfCC/S5r2AzPIW+3oM9O0t2Ry
         q3PcSQCxuviqsU9af7pr2IoOV8Oioq4/GHOoOWMAuY20wLxuDSu/yGc4ArfTL/Y9uIIG
         Ix5CxQaLmrnD0IPSc0si8wRxz37qJYJHMBUZRctaCgh9usGEXHquaJ/9jat/A8dCDzH2
         O8XEB6CkKMQ/sPpk97TjnnJNbbbZ7Kuz8J4j1mPsiOm0tmYDrhvqNCby5JXtJlr3Cx5x
         WyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774316918; x=1774921718;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uSep2deqIOSdAomPw+sl7Wg+Qc84dTYheLgsFWuJy8=;
        b=jgothlaSs2NT1+RgXXIl+HdvSZI6fmGOOszvPaLar5jAuigYNJwdqdxcW+LQl6mZf7
         sO5prfFukniuxXXKHaVcG79Q6w7/xXiElCXhCl4R4veGFo9NCAqttGYCI2WzElcHS0S4
         x287BUcDpHAezYZ4cDJknq920d9m83WOAapHqKdeMQit5k1uS7IuAaQRpoX3typYP/+4
         NHHyinYjbGSw+mSHntmA+n332efK9hxmqY16VpjYGQUfKxsHwl2gbe+AZKeJOPlehMNQ
         q9acgtZWP8xOuipFll7EVxYwcNuW6pK2cotUtGaJMrGgNCVsWZHd8zAXs8oXmrVOHSfR
         UcFg==
X-Gm-Message-State: AOJu0YzgKlK34FS0qAxnmtD2qdRGfG9YzsqunusQ8fVB8iKEQOR+FQ3r
	eCw7o2/xVNM8k3uvfVWtonoraQ6Ft3KI7smDw+X601NwXlc58OTIDDyTOoP24R4AY0q0MJaeUkm
	B4pgXEi1uubNWqm/ra4at/LB0BU3vSjUc0KdZJug=
X-Gm-Gg: ATEYQzwoXjo8xaf7XampJ8xTrNt7DHZItb/DbKbTxeYlPn6E3VH0gS+5ZUxiopEEKs0
	Q34+3ndllxMWt906drWrWK2o9w9+BBJqsU6svzGIaO1pZiiTvNJ4a1unId+ZlZfF9bRAomR4vPG
	eLhSMX1jEYl/Lkz9CdmKoPRLwy3QOcEecDohkIn/kqxHNzxyN/BMFRa8k4UdR3XLqy0hhPP8hM4
	Ztgz0MCaUuQalYrWdQFR9vhtlEGuZKzPTC9lPXpikSOlx7+WAnDCWR4z2cgEa+hLKvWEefwi/Fq
	HxUG2A==
X-Received: by 2002:a05:6512:3e15:b0:5a1:4497:88e7 with SMTP id
 2adb3069b0e04-5a285b5f227mr5951210e87.41.1774316917496; Mon, 23 Mar 2026
 18:48:37 -0700 (PDT)
MIME-Version: 1.0
From: Robert Viren <robviren@gmail.com>
Date: Mon, 23 Mar 2026 20:48:25 -0500
X-Gm-Features: AQROBzDWSrGca_ytNYskaJH8ha-XW6yP13LqR8zFhxz_l5zfFwUORtT7XXsvk-A
Message-ID: 
 <CAC5iJJZCHm8a_jP+7nQpp4aqn_EE7JmMdPJBbu83QSBjgqZ49g@mail.gmail.com>
Subject: 
 =?UTF-8?Q?Regression_6=2E8=E2=86=926=2E17=3A_snd=5Fsoc=5Favs_claims_HDA_device?=
	=?UTF-8?Q?_instead_of_snd=5Fhda=5Fintel=2C_fails_on_missing_topology_firmwar?=
	=?UTF-8?Q?e?=
To: alsa-devel@alsa-project.org
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@linux.intel.com,
	pierre-louis.bossart@linux.intel.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-MailFrom: robviren@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: UGOIMWKMQHI4AEJ4734HHL7XQCEVZIOZ
X-Message-ID-Hash: UGOIMWKMQHI4AEJ4734HHL7XQCEVZIOZ
X-Mailman-Approved-At: Tue, 24 Mar 2026 12:38:35 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UGOIMWKMQHI4AEJ4734HHL7XQCEVZIOZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Hardware: HP laptop (Bang & Olufsen), Conexant CX20724, Intel PCH HDA
(0000:00:1f.3), 13th gen Intel, linux-firmware 20240318

Audio works fine with 6.8 kernel. 6.17 with the same modules loading
and identical firmware my audio fails. Result is dummy output and an
audible whine which drives me nuts. See logs below.

# Fresh Mint Install 22.3

uname -r
6.8.0-106-generic

cat /proc/asound/cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xdc344000 irq 148

lsmod | grep -E 'snd_hda_intel|snd_soc_avs'
snd_soc_avs_hdaudio    12288  0
snd_soc_avs_probe      12288  0
snd_hda_intel          61440  0
snd_soc_avs           217088  0
snd_soc_hda_codec      24576  2 snd_soc_avs,snd_soc_avs_hdaudio
snd_hda_ext_core       32768  2 snd_soc_avs,snd_soc_hda_codec
snd_hda_codec         204800  7
snd_hda_codec_generic,snd_hda_codec_conexant,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_codec_intelhdmi
snd_hda_core          143360  9
snd_hda_codec_generic,snd_hda_codec_conexant,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_ext_core,snd_hda_codec,snd_hda_codec_intelhdmi
snd_intel_dspcfg       45056  2 snd_soc_avs,snd_hda_intel
snd_soc_core          413696  4
snd_soc_avs,snd_soc_hda_codec,snd_soc_avs_probe,snd_soc_avs_hdaudio
snd_compress           36864  2 snd_soc_avs,snd_soc_core
snd_pcm               200704  8
snd_soc_avs,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_compress,snd_soc_core,snd_hda_core,snd_pcm_dmaengine
snd                   143360  15
snd_hda_codec_generic,snd_seq,snd_hda_codec_conexant,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_hda_codec,snd_timer,snd_compress,snd_soc_core,snd_pcm,snd_rawmidi

sudo dmesg
...
[    8.809059] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops
i915_audio_component_bind_ops [i915])
[    8.839309] snd_hda_codec_conexant hdaudioC0D0: CX20724: BIOS auto-probing.
[    8.840117] snd_hda_codec_conexant hdaudioC0D0: autoconfig for
CX20724: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    8.840127] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    8.840132] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1
(0x16/0x0/0x0/0x0/0x0)
[    8.840137] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[    8.840140] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[    8.840143] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[    8.840147] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
...


# Reboot and switch kernels
uname -r
6.17.0-19-generic

lsmod | grep -E 'snd_hda_intel|snd_soc_avs'
snd_soc_avs_hdaudio    12288  0
snd_soc_avs_probe      12288  0
snd_hda_intel          61440  0
snd_soc_avs           217088  0
snd_soc_hda_codec      24576  2 snd_soc_avs,snd_soc_avs_hdaudio
snd_hda_ext_core       32768  2 snd_soc_avs,snd_soc_hda_codec
snd_hda_codec         204800  7
snd_hda_codec_generic,snd_hda_codec_conexant,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_codec_intelhdmi
snd_hda_core          143360  9
snd_hda_codec_generic,snd_hda_codec_conexant,snd_soc_avs,snd_hda_codec_hdmi,snd_soc_hda_codec,snd_hda_intel,snd_hda_ext_core,snd_hda_codec,snd_hda_codec_intelhdmi
snd_intel_dspcfg       45056  2 snd_soc_avs,snd_hda_intel
snd_soc_core          413696  4
snd_soc_avs,snd_soc_hda_codec,snd_soc_avs_probe,snd_soc_avs_hdaudio
snd_compress           36864  2 snd_soc_avs,snd_soc_core
snd_pcm               200704  8
snd_soc_avs,snd_hda_codec_hdmi,snd_hda_intel,snd_hda_codec,snd_compress,snd_soc_core,snd_hda_core,snd_pcm_dmaengine
snd                   143360  15
snd_hda_codec_generic,snd_seq,snd_hda_codec_conexant,snd_seq_device,snd_hda_codec_hdmi,snd_hwdep,snd_hda_intel,snd_hda_codec,snd_timer,snd_compress,snd_soc_core,snd_pcm,snd_rawmidi


...
[    8.075861] snd_soc_avs 0000:00:1f.3: bound 0000:00:02.0 (ops
intel_audio_component_bind_ops [i915])
[    8.134343] snd_hda_codec_conexant hdaudioB0D0: CX20724: BIOS auto-probing.
[    8.135270] snd_hda_codec_conexant hdaudioB0D0: autoconfig for
CX20724: line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:speaker
[    8.135275] snd_hda_codec_conexant hdaudioB0D0:    speaker_outs=0
(0x0/0x0/0x0/0x0/0x0)
[    8.135278] snd_hda_codec_conexant hdaudioB0D0:    hp_outs=1
(0x16/0x0/0x0/0x0/0x0)
[    8.135280] snd_hda_codec_conexant hdaudioB0D0:    mono: mono_out=0x0
[    8.135282] snd_hda_codec_conexant hdaudioB0D0:    inputs:
[    8.135284] snd_hda_codec_conexant hdaudioB0D0:      Mic=0x19
[    8.135285] snd_hda_codec_conexant hdaudioB0D0:      Internal Mic=0x1a
[    8.137088] snd_hda_codec_conexant hdaudioB0D0: creating for CX20724 Analog 0
[    8.140371] snd_soc_avs 0000:00:1f.3: Direct firmware load for
intel/avs/hda-14f150f4-tplg.bin failed with error -2
[    8.140377] snd_soc_avs 0000:00:1f.3: request topology
"intel/avs/hda-14f150f4-tplg.bin" failed: -2
[    8.140384] avs_hdaudio avs_hdaudio.0: trying to load fallback
topology hda-generic-tplg.bin
[    8.140426] snd_soc_avs 0000:00:1f.3: Direct firmware load for
intel/avs/hda-generic-tplg.bin failed with error -2
[    8.140429] snd_soc_avs 0000:00:1f.3: request topology
"intel/avs/hda-generic-tplg.bin" failed: -2
[    8.140436] snd_soc_avs 0000:00:1f.3: ASoC error (-2): at
snd_soc_component_probe() on hdaudioB0D0-platform
[    8.140448] avs_hdaudio avs_hdaudio.0: ASoC: failed to instantiate card -2
[    8.140827] avs_hdaudio avs_hdaudio.0: probe with driver
avs_hdaudio failed with error -2
[    8.149634] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 0 0
[    8.149638] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture
dai for HDMI 0
[    8.149640] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 1 1
[    8.149642] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture
dai for HDMI 1
[    8.149643] snd_hda_codec_intelhdmi hdaudioB0D2: creating for HDMI 2 2
[    8.149645] snd_hda_codec_intelhdmi hdaudioB0D2: skipping capture
dai for HDMI 2
[    8.149695] snd_soc_avs 0000:00:1f.3: Direct firmware load for
intel/avs/hda-80862809-tplg.bin failed with error -2
[    8.149698] snd_soc_avs 0000:00:1f.3: request topology
"intel/avs/hda-80862809-tplg.bin" failed: -2
[    8.149704] avs_hdaudio avs_hdaudio.2: trying to load fallback
topology hda-8086-generic-tplg.bin
[    8.149733] snd_soc_avs 0000:00:1f.3: Direct firmware load for
intel/avs/hda-8086-generic-tplg.bin failed with error -2
[    8.149735] snd_soc_avs 0000:00:1f.3: request topology
"intel/avs/hda-8086-generic-tplg.bin" failed: -2
[    8.149740] snd_soc_avs 0000:00:1f.3: ASoC error (-2): at
snd_soc_component_probe() on hdaudioB0D2-platform
[    8.149748] avs_hdaudio avs_hdaudio.2: ASoC: failed to instantiate card -2
[    8.149861] avs_hdaudio avs_hdaudio.2: probe with driver
avs_hdaudio failed with error -2
...


Thanks,
Rob
