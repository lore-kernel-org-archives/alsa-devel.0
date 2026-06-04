Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CB3CD6E4A
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:35:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6B306023B;
	Thu,  4 Jun 2026 14:35:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6B306023B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780576531;
	bh=MxRhG7ndRAPdiBIE8f6KBnROFiHZalUU84CxLiDcSvo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=Hhx9/HGooO/sMTQe/lxNci/3SSpbO8DCdfm3PrgQIP+LHwMoQ6Ndke+WcPXOrCtL6
	 IO9PAk/oqxp6frf18wSNA87d9esq8PrDcnEGstQ/hbhRdBmwTOY5+6klPEfcWJfnh4
	 TnQps9AmT8iNrx6lP57rSctMAR5wRewgxJ4F5rcE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1E27CF805F1; Thu,  4 Jun 2026 14:34:58 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DB1B5F805FE;
	Thu,  4 Jun 2026 14:34:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6B77EF804CC; Thu,  4 Jun 2026 14:34:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780576491;
	b=aRoaothpx71138ehp8nlsNKvlG+UaNmvA8tIyIw04wusIT7rjZoBxvjwRBNigNkKqNp8
	 kVWdJEqmU7MEgBRVNIGqhxqGpPcJtpUvQqKZIWyo5EdVWNUleBAANTLeEcD6j2Hi0VyDQ
	 qTihZW+E6swE3NkVdwXYFnnrlzSwIX2Hdll1HtvtzHDi6CLEmrXFS7iw4SK181rtkYcgL
	 I2u3r+YXycXv2DBT8+cQVXxB8i8MYkI7gfhu0ZPEgZH7ZHHLgFFGNCTFOmV34n2GtxUAm
	 lY/6ibe+ZhazfMN7eSUNVkEfWkWrnL5VFbfBxyp9LOf7mZHZSl4tSXBnmvSijJLOlJw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780576491;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=MxRhG7ndRAPdiBIE8f6KBnROFiHZalUU84CxLiDcSvo=;
	b=UvNZl3am38+QMxDnanqNRQP0u161oyBjVaNSVgRz+oj9KxpYFRr+ETFI/tsp71ColOMz
	 H359suOiEB3qr8P/DUsTzeX2DhDP6xXIpZck3Da12XNhF5Y0pz2uEq16qFk1tiRZp7vEq
	 FSJIizx3/X6HhwK7L7daOjJHgRAO9Gu6FIHpZPMZAZyCwnbv5TgZaGJYuK3Sx1zNMZXXY
	 e1cW5SnBBK1t59jlTygkhwmgCMomFe36AbEHhmVWHG4vtk3Jj+9YVr2MdRMW60DClqVMY
	 cRNbeY1fBCmZzfpfID0v6qepOpAUOqrdnrgdBrzq6oH/zLLon2G4Dhqry/vr//h1LtA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 650BCF800B0
	for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2026 14:34:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 650BCF800B0
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b5e0e232dda300-webhooks-bot@alsa-project.org>
In-Reply-To: <18b5e0e232b41800-webhooks-bot@alsa-project.org>
References: <18b5e0e232b41800-webhooks-bot@alsa-project.org>
Subject: No output or input exists after upgrading alsa-ucm-conf to 1.2.16
Date: Thu,  4 Jun 2026 14:34:52 +0200 (CEST)
Message-ID-Hash: YNDUWUQSEAX5EFG3AGPU5ZD6EZQ76MDR
X-Message-ID-Hash: YNDUWUQSEAX5EFG3AGPU5ZD6EZQ76MDR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YNDUWUQSEAX5EFG3AGPU5ZD6EZQ76MDR/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #774 was opened from EricLin0509:

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

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/774
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
