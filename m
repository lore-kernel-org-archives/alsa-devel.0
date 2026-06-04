Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3873CD6E6B
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:43:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 12D6E6024B;
	Thu,  4 Jun 2026 14:42:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 12D6E6024B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780576987;
	bh=ab3m3GdVkBGc7GfdkNo5NVQhUZvwpCb7WQ7jCPbJSTE=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=KiN3Abs/x4tycT6aFMm4bpNXX4BHnDb97p70qCaBP311hAiNqeZrEoi9Y8Ic6l5hE
	 +YplXmJwiJxbD0IKmj4SDl1oGhJak0N/0xSxh09I9pK2A19YLplhIr4Stc0/h3fuTT
	 jWYdWMFaaKzdToN1ClAtRNfeUVEC5rym28+9UDO0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B590BF80600; Thu,  4 Jun 2026 14:42:31 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2439DF805FF;
	Thu,  4 Jun 2026 14:42:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 44E3DF804CC; Thu,  4 Jun 2026 14:42:25 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780576944;
	b=Xyfxst4J1goGgslI7UXPQFZMd40UnRqS5uO7rbadO/eEdt8417ZJ2XzbYOAtu/wlnQny
	 NYubBBMIIb91Pb+eFou0dasi7e80htiyv7jQ6NJ/r3lGek1ywXIWlQDOxO2TG3dpYTULM
	 1/U8keJfTblNGUVM+60vP7LsK8z4BYfyy4qdWacsiTxB5aWpM6S6axiep5VrIPM8Iz39c
	 EsbZbaTJlK1+GvqHNLIfEK8dK40bghfgGdoIpMayt7/gq1uQkR38HmUwVQZbpxe56iBgT
	 a2nxGhosoly02ga+sgzj+bTsVLm42tt+aqj/mAxv/+AkksnlZs/+8jec7Pn+4rHvPlg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780576944;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ab3m3GdVkBGc7GfdkNo5NVQhUZvwpCb7WQ7jCPbJSTE=;
	b=SIxJSwjUcVUjSRTfZwwnsKafM8UOkhuXrCTo22SXZQWfubo1mYudTzDHf7S99HURPiJI
	 oMA2ikYQ5MOu0bgNGY5AJ4HeH9CyAareSMetimIbjDcV1pH+oKp9r13GS+x4YjYOBA8fH
	 WR0PrLDBcVLICwHZt37R0EHyYNxKkrhqhIwMeqLdXFVUsvyLEvBj2hrvm1uaY0r6Q0DeE
	 djWgjoQrwQHvQ8bWwpFwlSJjAZ2d19RMfqGBo7p7ukARGO8bBqFv6POZ60EXWNNlYbAdF
	 wCxpFUtZfaao7uNBHBI8vBmUSbEqApXG6XeU/JVR0zAGDYGOs8siFXMMKpzotr6nZkA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 5A031F8047D
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 14:42:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5A031F8047D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b5e14bb539d500-webhooks-bot@alsa-project.org>
In-Reply-To: <18b5e14bb5346700-webhooks-bot@alsa-project.org>
References: <18b5e14bb5346700-webhooks-bot@alsa-project.org>
Subject: No output or input exists after upgrading alsa-ucm-conf to 1.2.16
Date: Thu,  4 Jun 2026 14:42:25 +0200 (CEST)
Message-ID-Hash: KH6BN4TBADYIAS3CSA2M33NFZGNOBXOC
X-Message-ID-Hash: KH6BN4TBADYIAS3CSA2M33NFZGNOBXOC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KH6BN4TBADYIAS3CSA2M33NFZGNOBXOC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #774 was edited from EricLin0509:

## Summary

After upgrading the `alsa-ucm-conf` to `1.2.16`, the builtin speaker and microphone in MSI Prestige 16 Flip AI+ C3MTG has gone, and these devices previously worked fine. To make them work again I have to downgrade `alsa-ucm-conf` to `1.2.15.3` (keep `alsa-lib 1.2.16` is fine).

Similar issue #773

## Environment

- OS: Arch Linux
- Device: MSI Prestige 16 Flip AI+ C3MTG
- `alsa-ucm-conf` broken: 1.2.16-1
- `alsa-ucm-conf` working: 1.2.15.3-2
- Kernel: 7.0.11-1-cachyos
- Audio server: PipeWire 1.6.6 / WirePlumber 0.5.14

## Root cause

The configuration can't be loaded in version `1.2.16` on a board matching `rt713-sdca`

Here are the outputs of `alsaucm -c hw:0 dump text` in these two versions.

- 1.2.15.3

```
Verb.HiFi {
	Comment "Play HiFi quality Music"
	Device.Headphones {
		Comment Headphones
		Values {
			CaptureCTL "_ucm0001.hw:sofsoundwire"
			JackControl "Headphone Jack"
			PlaybackCTL "_ucm0001.hw:sofsoundwire"
			PlaybackPCM "_ucm0001.hw:sofsoundwire"
			PlaybackPriority 200
			TQ HiFi
		}
	}
	Device.Headset {
		Comment "Headset Microphone"
		Values {
			CaptureCTL "_ucm0001.hw:sofsoundwire"
			CaptureMixerElem "rt713 FU0F"
			CapturePCM "_ucm0001.hw:sofsoundwire,1"
			CapturePriority 200
			CaptureSwitch "rt713 FU0F Capture Switch"
			CaptureVolume "rt713 FU0F Capture Volume"
			JackControl "Headset Mic Jack"
			PlaybackCTL "_ucm0001.hw:sofsoundwire"
			TQ HiFi
		}
	}
	Device.Mic {
		Comment "SoundWire Microphones"
		Values {
			CaptureCTL "_ucm0001.hw:sofsoundwire"
			CaptureMixerElem "rt713 FU1E"
			CapturePCM "_ucm0001.hw:sofsoundwire,4"
			CapturePriority 100
			CaptureSwitch "rt713 FU1E Capture Switch"
			CaptureVolume "rt713 FU1E Capture Volume"
			PlaybackCTL "_ucm0001.hw:sofsoundwire"
			TQ HiFi
		}
	}
	Device.Speaker {
		Comment Speaker
		Values {
			CaptureCTL "_ucm0001.hw:sofsoundwire"
			PlaybackCTL "_ucm0001.hw:sofsoundwire"
			PlaybackPCM "_ucm0001.hw:sofsoundwire,2"
			PlaybackPriority 100
			TQ HiFi
		}
	}
	Device.HDMI1 {
		Comment "HDMI / DisplayPort 1 Output"
		Values {
			CaptureCTL "_ucm0001.hw:sofsoundwire"
			JackControl "HDMI/DP,pcm=5 Jack"
			PlaybackCTL "_ucm0001.hw:sofsoundwire"
			PlaybackPCM "_ucm0001.hw:sofsoundwire,5"
			PlaybackPriority 500
			TQ HiFi
		}
	}
	Device.HDMI2 {
		Comment "HDMI / DisplayPort 2 Output"
		Values {
			CaptureCTL "_ucm0001.hw:sofsoundwire"
			JackControl "HDMI/DP,pcm=6 Jack"
			PlaybackCTL "_ucm0001.hw:sofsoundwire"
			PlaybackPCM "_ucm0001.hw:sofsoundwire,6"
			PlaybackPriority 600
			TQ HiFi
		}
	}
	Device.HDMI3 {
		Comment "HDMI / DisplayPort 3 Output"
		Values {
			CaptureCTL "_ucm0001.hw:sofsoundwire"
			JackControl "HDMI/DP,pcm=7 Jack"
			PlaybackCTL "_ucm0001.hw:sofsoundwire"
			PlaybackPCM "_ucm0001.hw:sofsoundwire,7"
			PlaybackPriority 700
			TQ HiFi
		}
	}
}
```

- 1.2.16

```
ALSA lib utils.c:372:(uc_mgr_config_load_into) [error.ucm] could not open configuration file /usr/share/alsa/ucm2/codecs/rt713-sdca/init.conf
ALSA lib parser.c:79:(uc_mgr_config_load_file) [error.ucm] failed to open file /usr/share/alsa/ucm2/codecs/rt713-sdca/init.conf: -2
ALSA lib main.c:1805:(snd_use_case_mgr_open) [error.ucm] failed to import hw:0 use case configuration -2
alsaucm: error failed to open sound card hw:0: No such file or directory
```

- dmesg

```
[    8.529154] sof-audio-pci-intel-ptl 0000:00:1f.3: SoundWire enabled on CannonLake+ platform, using SOF driver
[    8.529161] sof-audio-pci-intel-ptl 0000:00:1f.3: enabling device (0000 -> 0002)
[    8.529288] sof-audio-pci-intel-ptl 0000:00:1f.3: DSP detected with PCI class/subclass/prog-if 0x040100
[    8.529331] sof-audio-pci-intel-ptl 0000:00:1f.3: bound 0000:00:02.0 (ops intel_audio_component_bind_ops [xe])
[    8.536233] sof-audio-pci-intel-ptl 0000:00:1f.3: use msi interrupt mode

[    8.563262] sof-audio-pci-intel-ptl 0000:00:1f.3: No SoundWire machine driver found for the ACPI-reported configuration:
[    8.563265] sof-audio-pci-intel-ptl 0000:00:1f.3: link 2 mfg_id 0x025d part_id 0x1320 version 0x3
[    8.563267] sof-audio-pci-intel-ptl 0000:00:1f.3: link 2 mfg_id 0x025d part_id 0x1320 version 0x3
[    8.563269] sof-audio-pci-intel-ptl 0000:00:1f.3: link 3 mfg_id 0x025d part_id 0x0713 version 0x3
[    8.563274] sof-audio-pci-intel-ptl 0000:00:1f.3: Use SoundWire default machine driver with function topologies
[    8.563275] sof-audio-pci-intel-ptl 0000:00:1f.3: hda codecs found, mask 4
[    8.563278] sof-audio-pci-intel-ptl 0000:00:1f.3: NHLT device BT(0) detected, ssp_mask 0x4
[    8.563279] sof-audio-pci-intel-ptl 0000:00:1f.3: BT link detected in NHLT tables: 0x4
[    8.563281] sof-audio-pci-intel-ptl 0000:00:1f.3: DMICs detected in NHLT tables: 0
[    8.566261] sof-audio-pci-intel-ptl 0000:00:1f.3: Firmware paths/files for ipc type 1:
[    8.566264] sof-audio-pci-intel-ptl 0000:00:1f.3:  Firmware file:     intel/sof-ipc4/ptl/sof-ptl.ri
[    8.566266] sof-audio-pci-intel-ptl 0000:00:1f.3:  Firmware lib path: intel/sof-ipc4-lib/ptl
[    8.566267] sof-audio-pci-intel-ptl 0000:00:1f.3:  Topology file:     function topologies
[    8.566729] sof-audio-pci-intel-ptl 0000:00:1f.3: Loaded firmware library: ADSPFW, version: 2.14.1.1
[    8.731633] sof-audio-pci-intel-ptl 0000:00:1f.3: Loaded firmware library: ADSPFW, version: 2.14.1.1

[    8.832360] sof-audio-pci-intel-ptl 0000:00:1f.3: Booted firmware version: 2.14.1.1
[    8.859002] sof-audio-pci-intel-ptl 0000:00:1f.3: Using function topologies instead intel/sof-ipc4-tplg/sof-ptl-dummy.tplg
[    8.859012] sof-audio-pci-intel-ptl 0000:00:1f.3: loading topology 0: intel/sof-ipc4-tplg/sof-sdca-1amp-id2.tplg
[    8.859067] sof-audio-pci-intel-ptl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
[    8.859326] sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
[    8.859332] sof-audio-pci-intel-ptl 0000:00:1f.3: loading topology 1: intel/sof-ipc4-tplg/sof-sdca-jack-id0.tplg
[    8.859397] sof-audio-pci-intel-ptl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
[    8.859693] sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
[    8.859698] sof-audio-pci-intel-ptl 0000:00:1f.3: loading topology 2: intel/sof-ipc4-tplg/sof-sdca-mic-id4.tplg
[    8.859735] sof-audio-pci-intel-ptl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
[    8.859847] sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
[    8.859851] sof-audio-pci-intel-ptl 0000:00:1f.3: loading topology 3: intel/sof-ipc4-tplg/sof-hdmi-pcm5-id5.tplg
[    8.859894] sof-audio-pci-intel-ptl 0000:00:1f.3: Topology: ABI 3:29:1 Kernel ABI 3:23:1
[    8.860065] sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
[    8.867374] sof_sdw sof_sdw: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
[    8.882670] input: sof-soundwire Headset Jack as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input33
[    8.882760] input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input34
[    8.882827] input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input35
[    8.882881] input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input36
```

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/774
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
