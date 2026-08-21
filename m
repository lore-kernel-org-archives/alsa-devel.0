Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0145C5DF89
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:47:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27F61602A6;
	Fri, 21 Aug 2026 13:47:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27F61602A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787312833;
	bh=6TKtfsLItJPWwuIBY4570mLTAB7zU/esBopv2gFAGT8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Aoq6CmLgBZNgZa5fUIijZkmJPUJN/jYcf6ivWQVRjOEioBU7CDkJZ9SZ1rA0NIsBp
	 uW2GuDtoQko+6Lz/N8MvIxTMfjYoersD6k6xZ5s+z8A/obPzcdittNyaHY3NR3WkFW
	 8iEgF+nyc/9onxtauueUNdc7eYXSZxH4Up5qXous=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 759FDF80601; Fri, 21 Aug 2026 13:46:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A252F805F6;
	Fri, 21 Aug 2026 13:46:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C0D6FF8051D; Fri, 21 Aug 2026 13:46:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787312788;
	b=VB0sBt5J0y3IEoZDF4iksBMSz+IZgjTOfWLtJAn2V0IgrfuzN1XaIHBap6kXrrv/QS81
	 N2U7W+RS5Hy8FgvA+9a+sTgbkzLMbmCzEwAkzCmlHfBlHIa8+t8PuBBBwpBRd5sVm1ePP
	 Mk3gZdgKm9OR+Cq9pIzmELpBc3u90f0apHeX8iL46HAEPVR3UYlbndJZFLX0LQq7/s58/
	 KQvqBVMFITGWX3V8b89n0CHlgogavFrHeCgmRLbiQ9i3wQqH42dLLEUKXhdHrExJfMK6O
	 21FNEa94yXpLmsKUjkR0+EHKCcNVBVeR0X0NrWAbrbHn8zEFSir/fBcmYmyWKUkocDA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787312788;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=6TKtfsLItJPWwuIBY4570mLTAB7zU/esBopv2gFAGT8=;
	b=Y0cxj+HO05OOlwWgDMeB6uTDxolug7dN+YSVJFLC+YroZWYLoBW5Qp+Ok/nOfDYw9L9t
	 c5uyGfjVNw+GuXYyL67VZqev2tIdtibGEJhk788flZ7RNF4MhFITMlssDh6iq37UwayER
	 Moo6FNvyJ/1pRaMZirMOS7tVYDKf6uGNOr6uVCIy9W1j8bng1J4S/C85l9IN0r6Gt7ezj
	 qOMkEtrSl5UC1z5THCZHoOhVTBFriadR/IAvZT0ZIWZkzLUGu7+5rXHHaV/zBBFWj9p78
	 TRFWgpHq98TG6rS/U8d0HTijJT4z6fVXW/dRLv7u2oVPVdrMA5MXPWmfMejdtIZSZtQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 50308F800BA
	for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2026 13:46:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 50308F800BA
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18cdcf8290614700-webhooks-bot@alsa-project.org>
In-Reply-To: <18cdcf829053a400-webhooks-bot@alsa-project.org>
References: <18cdcf829053a400-webhooks-bot@alsa-project.org>
Subject: sof-soundwire: missing acp-dmic.conf makes UCM fail to load on AMD
 ACP SoundWire cards reporting "mic:acp-dmic"
Date: Fri, 21 Aug 2026 13:46:31 +0200 (CEST)
Message-ID-Hash: SOG3QC6K2YDA66LYKR5TAB5YUGCGWOAM
X-Message-ID-Hash: SOG3QC6K2YDA66LYKR5TAB5YUGCGWOAM
X-MailFrom: github@alsa-project.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/SOG3QC6K2YDA66LYKR5TAB5YUGCGWOAM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #834 was opened from ikaroschanbc:

## Summary

On AMD ACP SoundWire machines driven by `snd_acp_sdw_legacy_mach`, the card reports `mic:acp-dmic` in its components string. `sof-soundwire/HiFi.conf` then tries to include `/sof-soundwire/${var:MicCodec1}.conf`, i.e. `/sof-soundwire/acp-dmic.conf`, but no such file is shipped. UCM parsing aborts with `-2` and **the entire UCM configuration for the card fails to load**, not just the microphone device.

## Environment

| Item | Value |
|---|---|
| alsa-ucm-conf | 1.2.10-1ubuntu5.9 (Ubuntu 24.04.4 LTS) |
| Machine | ASUS ProArt PX13 HN7306EA |
| SoC | AMD Ryzen AI MAX+ 395 w/ Radeon 8060S ("Strix Halo") |
| Kernel | 7.0.0-28-generic |
| Machine driver | `snd_acp_sdw_legacy_mach` |
| Card name | `amd-soundwire` |
| Codecs | RT721 SDCA (jack + DMIC) + 2x TAS2783 (SmartAmp) over SoundWire |

Card components string:

```
 cfg-amp:2 mic:acp-dmic cfg-mics:1 hs:rt721
```

PCM devices on the card:

```
pcm0p  PLAYBACK  SDW1-PIN0-PLAYBACK-SimpleJack rt721-sdca-aif1-0
pcm1c  CAPTURE   SDW1-PIN3-CAPTURE-SimpleJack rt721-sdca-aif1-1
pcm2p  PLAYBACK  SDW1-PIN1-PLAYBACK-SmartAmp multicodec-2
pcm3c  CAPTURE   SDW1-PIN4-CAPTURE-SmartAmp multicodec-3
pcm4c  CAPTURE   acp-dmic-codec dmic-hifi-4
```

Note that `conf.d/amd-soundwire/amd-soundwire.conf` is a symlink to `../sof-soundwire/sof-soundwire.conf`, so AMD ACP SoundWire cards go through the generic sof-soundwire configuration.

## Reproduction

```console
$ alsaucm -c amd-soundwire list _verbs
ALSA lib utils.c:364:(uc_mgr_config_load_into) could not open configuration file /usr/share/alsa/ucm2/sof-soundwire/acp-dmic.conf
ALSA lib parser.c:78:(uc_mgr_config_load_file) error: failed to open file /usr/share/alsa/ucm2/sof-soundwire/acp-dmic.conf: -2
ALSA lib main.c:1554:(snd_use_case_mgr_open) error: failed to import amd-soundwire use case configuration -2
alsaucm: error failed to open sound card amd-soundwire: No such file or directory
```

## Analysis

`sof-soundwire/sof-soundwire.conf` extracts the mic codec with:

```
MicCodec {
        Regex " mic:([a-z0-9]+(-dmic)?+(-sdca)?)"
        String "${CardComponents}"
}
```

which yields `MicCodec1 = "acp-dmic"`. `HiFi.conf` then does:

```
False.Include.micdev.File "/sof-soundwire/${var:MicCodec1}.conf"
```

`sof-soundwire/` ships `dmic.conf`, `cs42l43-dmic.conf`, `rt712-dmic.conf`, `rt713-dmic.conf`, `rt715*.conf`, but **not** `acp-dmic.conf`, so the include fails and parsing stops.

The existing generic `dmic.conf` cannot be reused as-is: it locates the PCM with `regex='DMIC '`, while the ACP DMIC PCM id is `acp-dmic-codec dmic-hifi-4`. It also references `Dmic0 Capture Volume` / `Dmic0 Capture Switch` mixer controls, which do not exist on this card (its only capture controls are `rt721 FU0F ...` and `rt721 FU1E ...`).

## Impact

This is more than a missing microphone. When UCM fails to load, PulseAudio's ALSA card profile code (also used by PipeWire) falls back to probing every PCM on the card. On this hardware `pcm3c` (`SDW1-PIN4-CAPTURE-SmartAmp`, the TAS2783 IV-sense feedback path) fails with `-EINVAL` and leaves the SoundWire stream state machine in an inconsistent state:

```
soundwire sdw-master-0-1: Program transport params failed: -22
soundwire sdw-master-0-1: Program params failed: -22
 SDW1-PIN4-CAPTURE-SmartAmp: ASoC error (-22): at snd_soc_link_prepare() on SDW1-PIN4-CAPTURE-SmartAmp
sdw_deprepare_stream: subdevice #0-Capture: inconsistent state state 1
```

The result is that **the card produces no sinks or sources at all** and the sound server falls back to a dummy `auto_null` sink -- speakers, headphones and all microphones disappear together. (The `pcm3c` failure itself is a kernel driver issue and is being reported separately; the point here is that a working UCM profile avoids touching that PCM entirely.)

## Proposed fix

Adding the following file as `sof-soundwire/acp-dmic.conf` makes UCM load and the card work correctly. It has been verified on the hardware above: all four user-facing devices are created, jack detection and automatic port switching work, and `pcm3c` is never opened.

```
SectionDevice."Mic" {
	Comment "Internal Digital Microphone"

	Value {
		CapturePriority 100
		CapturePCM "hw:${CardId},${find-device:type=pcm,stream=capture,field=id,regex='acp-dmic-codec'}"
	}
}

SectionDevice."Speaker" {
	Comment "Internal Speakers"

	EnableSequence [
		cset "name='Left Spk Switch' on"
		cset "name='Right Spk Switch' on"
		cset "name='Left Spk2 Switch' on"
		cset "name='Right Spk2 Switch' on"
	]

	DisableSequence [
		cset "name='Left Spk Switch' off"
		cset "name='Right Spk Switch' off"
		cset "name='Left Spk2 Switch' off"
		cset "name='Right Spk2 Switch' off"
	]

	Value {
		PlaybackPriority 100
		PlaybackPCM "hw:${CardId},${find-device:type=pcm,stream=playback,field=id,regex='SmartAmp'}"
	}
}
```

Headphones and headset mic are already covered by the existing `rt721.conf` (with `JackControl`), so priorities 100 vs. its 200 give the expected automatic switching.

## Note on the Speaker section

Including a `Speaker` device in `acp-dmic.conf` is arguably the wrong layer, and I would understand if maintainers prefer a different placement. The reason it is needed here is that `snd_acp_sdw_legacy_mach` reports `cfg-amp:2` but **no `spk:` token**, so `sof-soundwire.conf`'s

```
SpeakerCodec {
        Regex " spk:([a-z0-9]+((-sdca)|(-spk)|(-bridge))?)"
        String "${CardComponents}"
}
```

leaves `SpeakerCodec1` empty and no Speaker device is ever created -- even once UCM loads successfully. That may be better fixed on the kernel side by having the AMD machine driver emit a `spk:tas2783` (or similar) component, in which case only the `Mic` section would belong in `acp-dmic.conf`. Happy to test whichever approach maintainers prefer, and to send this as a PR if the shape looks right.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/834
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
