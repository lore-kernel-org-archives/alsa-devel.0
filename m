Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1229A606A31A
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=AFzVM1GB;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gvoEw3+p
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B44760203;
	Mon, 23 Nov 2026 13:05:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B44760203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795435566;
	bh=XrjFy0RnNK1OlKeHfhVMc79i/VFdZ8uvcsGtDK2aGoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AFzVM1GBxJ3IHdq2DJ6so3zoLHExd0odQp9CAl6pqChElU3I0QUvrKNtK32iT8rKn
	 tLwLzQ8prOkjKvQvlcKuYnVZTlP9LVEKlTwSrbqMpi9lBpfTZTrDdAmU/ldNK+zljZ
	 yuE06mJ7rBlwYXB/F48Ip80vBOD89UMicTA3Ka4g=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C3235F807C3; Mon, 23 Nov 2026 13:03:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 934D9F80800;
	Mon, 23 Nov 2026 13:03:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFAF1F80552; Mon, 23 Nov 2026 10:40:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=95.215.58.236
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795426829;
	b=ABRalwJiui31KIDE1lfgLMCmL3383s9s/iBvmAJ2dtdqWDIUkasQXAPUps088LH81UP3
	 fajx9SA1UKuzqCcZAzgiHEa64OgtobO7CfUSoGrv3fFkLjEwvCse72dmn7mAWkGVcInyl
	 JHLKtmUK2TPdFfbRZqZ8EE9OQhWfgzXCCRokyfur2eaMxNrrHLn8pgtMcj4tgFzYx9jE9
	 tJHvA1WH21E885uM2/Y4/yTJmYPYM5+daW6nOg135Mo+dUZ1zdOHFKSvD3fvGLfYVmaXG
	 aKhvhFHwKK4fykrB5KDQUyZSk713X8rNquyWrE9/ngw/VuhmJa5DuhQNkdYdoBbtwrQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795426829;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From;
	bh=XrjFy0RnNK1OlKeHfhVMc79i/VFdZ8uvcsGtDK2aGoc=;
	b=Y6IBW45STnLjbyUJ7+0WNSzwWeXJa4kq1+HBpbhOb1VTIIGggiqMWAVSVz9gY4ARsjhu
	 zg4xGlFv6w5LuDX3B5PiVBuhQlSFtEJpx1VE3nv9cveR7MhPjwHhEscs45DeKMeHTXFPJ
	 1Ovr71dwx5HE8vd6XrXc+t9jD6FFdPhlDtdFDgtE7CnIfjVSnMOjnJRqAD7rDiBr8NFul
	 7tRQBBunV7aA+x4J4MTz4mQ6FvczR07w5TeHdQD45xPTHhjiRWwVT2CGTYTcSY5l2g2jF
	 00lr9thx0cFhvwKdelJtZDUqeOhPgXuzqRsegJw0QNbwGT9wMGsX8/CxwGivez9/nMg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=gvoEw3+p;
	arc=none smtp.remote-ip=95.215.58.236
Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3515DF80020
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2026 10:40:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3515DF80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256
 header.s=key1 header.b=gvoEw3+p
X-Envelope-To: alsa-devel@alsa-project.org
DKIM-Signature: a=rsa-sha256; bh=XrjFy0RnNK1OlKeHfhVMc79i/VFdZ8uvcsGtDK2aGoc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795426827; v=1; x=1796031627;
 b=gvoEw3+p/I3qkVJhDp2MZQMDs4erwexGeElsMRY8+8CXVbVReBf+6tau/BWNeNi0qQ/VIM3Y
 CkYKmVZZwvz1AW0dAXk+fBWN0/9U8ZuKAJqIgGzb1S1eOrqQS8FlACzFHcaxtnSTZosVS2w08Cv
 oL/0uzMsu3LzBEGrECJT+6nw=
X-Envelope-To: alsa-devel@alsa-project.org
Received: by smtp.migadu.com with ESMTPS id f269c79cfa28cc5b;
	Mon, 23 Nov 2026 09:40:26 +0000
X-Mizu-Trace-ID: f269c79cfa28cc5b
X-Migadu-Flow: FLOW_OUT
Message-ID: <a965bf35-5735-4ff4-90f5-9a85edf42a98@linux.dev>
Date: Mon, 23 Nov 2026 10:11:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] sof_sdw Xiaomi Book Pro 14 TM2424 speakers randomly silent
 - SoundWire link 3 rt721+rt1320 bus clash
To: wqy <qianywu@gmail.com>, linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org, Bard Liao <yung-chuan.liao@linux.intel.com>
References: <59a8eaf5-d406-4996-8834-e45a8c45516f@gmail.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <59a8eaf5-d406-4996-8834-e45a8c45516f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MailFrom: pierre-louis.bossart@linux.dev
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: MIMFW2P7XDK5GX7NIYSPOFIBJEZVLL2K
X-Message-ID-Hash: MIMFW2P7XDK5GX7NIYSPOFIBJEZVLL2K
X-Mailman-Approved-At: Mon, 23 Nov 2026 12:02:18 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MIMFW2P7XDK5GX7NIYSPOFIBJEZVLL2K/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

On 11/23/26 07:37, wqy wrote:
> [BUG] sof_sdw: Xiaomi Book Pro 14 (TM2424, PTL) internal speakers randomly
>  go silent; SoundWire link 3 rt721+rt1320 reports bus clash / parity error
> 
> TL;DR
> -----
> Internal speakers on the Xiaomi Book Pro 14 2026 (TM2424, Panther Lake)
> randomly stop producing sound while PipeWire still reports RUNNING and
> the mixer state is untouched. dmesg shows Bus clash / Parity error on
> SoundWire link 3 (RT721 + RT1320). A card profile toggle (bus reset)
> restores audio without a reboot. No board match entry or DMI quirk
> exists for this machine, so the generic machine driver with function
> topologies is used.
> 
> Environment
> -----------
>   Machine   : XIAOMI Xiaomi Book Pro 14, board TM2424 V14E1,
>               SKU TM2424-77079
>   BIOS      : XMAPT4B0P0A0A (2026-06-17)
>   CPU       : Intel Core Ultra X7 358H (Panther Lake)
>   Audio PCI : 8086:e428
>   Kernel    : 7.3.5-2-cachyos (distro build, no external audio patches)
>   Userspace : PipeWire 1.6.11, WirePlumber, alsa-ucm-conf
>   Codecs link 3: 025d:0721:01 RT721, 025d:1320:01 RT1320
> 
> Boot log:
> 
>   sof-audio-pci-intel-ptl 0000:00:1f.3: No SoundWire machine driver found
>     for the ACPI-reported configuration:
>   sof-audio-pci-intel-ptl 0000:00:1f.3: link 3 mfg_id 0x025d part_id 0x0721
>     version 0x3
>   sof-audio-pci-intel-ptl 0000:00:1f.3: link 3 mfg_id 0x025d part_id 0x1320
>     version 0x3
>   sof-audio-pci-intel-ptl 0000:00:1f.3: Use SoundWire default machine driver
>     with function topologies
> 
> Loaded topologies: sof-sdca-jack-id0.tplg, sof-sdca-mic-id4.tplg,
> sof-sdca-1amp-id2.tplg.
> 
> Symptom
> -------
> Playback to the internal speakers works after boot, then at some point
> stops producing sound. Userspace sees nothing wrong:
> 
>   pactl:  State: RUNNING, Mute: no, volume 70%
>   amixer: 'Speaker' [on], 'rt1320-1 FU21' 87/87 (100%)
> 
> aplay / speaker-test also open the PCM and "play" without error.
> 
> Recovery (no reboot)
> --------------------
>   pactl set-card-profile alsa_card.pci-0000_00_1f.3-platform-sof_sdw off
>   sleep 1
>   pactl set-card-profile alsa_card.pci-0000_00_1f.3-platform-sof_sdw HiFi
> 
> Sound comes back immediately and no further link errors are logged. This
> is consistent with the bus reset described in
> Documentation/driver-api/soundwire/error_handling.rst ("after a number
> of such errors are detected the bus might be reset").
> 
> dmesg around the failure
> ------------------------
> Suspend/resume in the same boot: 01:46, 01:48, 01:50, 01:51, 10:28,
> 15:35, 20:27, 20:42.
> 
>   Nov 22 17:55:48 soundwire_intel.link.3: Bus clash for control word
>   Nov 22 17:55:48 soundwire_intel.link.3: Bus clash for data word
>   Nov 22 17:55:48 rt1320-sdca sdw:0:3:025d:1320:01: Bus clash detected
>   Nov 22 18:00:06 soundwire_intel.link.3: Bus clash for control word
>   Nov 22 18:00:06 soundwire_intel.link.3: Bus clash for data word
>   Nov 22 18:11:10 soundwire_intel.link.3: Bus clash for control word
>   Nov 22 18:11:10 soundwire_intel.link.3: Bus clash for data word
>   Nov 22 18:19:36 soundwire_intel.link.3: Bus clash for control word
>   Nov 22 18:19:36 soundwire_intel.link.3: Bus clash for data word
>   Nov 22 20:42:15 rt721-sdca sdw:0:3:025d:0721:01: Bus clash detected before
>     INT mask is enabled
>   Nov 22 22:01:22 soundwire_intel.link.3: Bus clash for data word
>   Nov 22 22:05:50 soundwire_intel.link.3: Parity error
>   Nov 22 22:05:50 soundwire_intel.link.3: Bus clash for control word
>   Nov 22 22:05:50 soundwire_intel.link.3: Bus clash for data word
>   Nov 22 22:05:50 rt721-sdca sdw:0:3:025d:0721:01: Parity error detected
>   Nov 22 22:09:50 soundwire_intel.link.3: Bus clash for control word
>   Nov 22 22:09:50 soundwire_intel.link.3: Bus clash for data word

best to file an issue here: https://github.com/thesofproject/linux/issues

This bus clash is a low-level electrical issue, so either the hardware
timings are borderline or the initialization sequence isn't done right.

> Notes:
> - The clashes at 17:55-18:19 have no suspend nearby, so this is not only
>   a resume path problem.
> - 20:42:15 is the resume instant; that one matches the known spurious
>   "clash before INT mask is enabled" pattern.
> - At 22:05 / 22:09 both master and slave report errors, i.e. actual data
>   word corruption on the wire.
> 
> Extra observation: -61 on the RT721 endpoints after the bus reset
> ----------------------------------------------------------------
> Right after re-initialising the card, the speaker path comes back but
> the jack/mic endpoints fail with -ENODEV:
> 
>   rt721-sdca sdw:0:3:025d:0721:01: ASoC error (-61): at
>     snd_soc_pcm_component_pm_runtime_get() on sdw:0:3:025d:0721:01
>    SDW3-Playback-SimpleJack: ASoC error (-61): at __soc_pcm_open()
>    Jack Out: ASoC error (-61): at dpcm_be_dai_startup()
>    SDW3-Capture-SmartMic: ASoC error (-61): at __soc_pcm_open()
> 
> Runtime PM state of link 3
> --------------------------
>   sdw:0:3:025d:0721:01: control=auto status=suspended
>   sdw:0:3:025d:1320:01: control=auto status=suspended
> 
> Both peripherals autosuspend (SoundWire clock stop) when idle; the
> silence occurs on the idle -> streaming transition.
> 
> Why I think it is not a hardware fault
> --------------------------------------
> - The same RT1320 plays fine right after a bus reset, no reboot, same
>   mixer values.
> - Both peripherals stay Attached; their controls remain readable.
> - No error is surfaced to userspace, which is the main annoyance.
> 
> Related reports on other PTL machines (same codec family, generic fallback)
> --------------------------------------------------------------------------
> - Lenovo Yoga Slim 7i 14IPH11 (83QM): rt721 + rt1320 on link 3, a ghost
>   RT722 in ACPI makes the default machine driver misbuild the card, -61
>   and silence; DMI quirk proposed (ptl_sdw_rt721_l3_rt1320_l3, and the
>   ghost must be dropped).
> - MSI Prestige 16 AI+ C3MG: RT1320 + RT713, silent internal speakers with
>   the generic fallback.
> - Surface Pro 11 (Intel): DMI quirk for a ghost RT1320.
> 
> On TM2424 there is no ghost RT722 - only 0721 and 1320 are enumerated on
> link 3 - so the Lenovo quirk does not directly apply.
> 
> Questions
> ---------
> 1. Is this a known SoundWire clock-stop/restart race on PTL with
>    RT721 + RT1320, or should TM2424 get its own soc-acpi match entry /
>    DMI quirk so the machine driver knows the two-peripheral layout?
> 2. Is -61 from snd_soc_pcm_component_pm_runtime_get() on the RT721
>    endpoints after a bus reset expected, or a second issue?
> 3. Would setting power/control = on for the link 3 peripherals be a
>    valid way to confirm the clock-stop theory? I am happy to test
>    patches, module parameters, or debugfs changes on this hardware.
> 
> Attachments
> -----------
> - alsa-info.txt     full alsa-info.sh dump
> - dmesg-audio.txt   filtered sof/sdw/rt1320/rt721 log
> - hardware.txt      DMI, kernel, lspci, aplay -l
> - card-info.txt     /proc/asound cards and pcm
> 
> Thanks,
> wqy <qianywu@gmail.com>

