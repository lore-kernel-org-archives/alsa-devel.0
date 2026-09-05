Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31467C624D3
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Sep 2026 12:53:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E391D601FE;
	Sat,  5 Sep 2026 14:53:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E391D601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1788612795;
	bh=Ees54Bn48qvQ5ffodYzPu8xLm6k1VsFTKdrYsdnnybs=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=X1Q8ud7R3b7x68loUzk8IVnCt1P1I1wuxw9W1aprI3G6tT0hdLCxcZcqj/LyKe7px
	 XFKddxrcbVnJXA6RaPfq7qX6vGLg5g6qvkkNS369sF4ut5DL3/o3oqG5iTR1qU70w8
	 CbTbzSwxwSrEcGwrNMMrsW5pvawJFJQSJkxm+wIA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 111C9F805FD; Sat,  5 Sep 2026 14:52:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 810D4F805FB;
	Sat,  5 Sep 2026 14:52:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 82F76F80525; Sat,  5 Sep 2026 14:52:30 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1788612749;
	b=V2fZYTnyDHsM9L/rnJjNPEUiLKcNSRMSUriDFMSeHCWwUIBvMQO3+FUtsD5mVXbR9Uy+
	 vgIMfPWt0uYlZlc7B71hqXhCdRig4Vkrqv3lA+4l84dRBOVDu/62hVwtmMak89oNXJ2bV
	 PENgkLQY6vYT8vSm343ycgqf1Km+QQnRxKLZO0xxHVFBSB5c5EJaGuZJrAVjBoOZHKjgV
	 YQtRtBMEztGvp6JIJ0QpXTztspfyoMkbzQfLyevqj7tl3dtj3+wkf5Kvppr/A098sE5nH
	 EtaUfZzQ7Y1NrofyT0VbHJ5TAQDl4aWKZeKB/4xtwWZct8PgQ+FJCcBmkul5bNCVh1A==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1788612749;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=Ees54Bn48qvQ5ffodYzPu8xLm6k1VsFTKdrYsdnnybs=;
	b=BXw/+R4DvcOS0r9JMB3Xlyyv4M94JBEmxVYh9ZVG5ApgUAfnfzbkyBhqIWZlHu0B+nsh
	 qJXvcH3JN65kqZLYLMWETQIY5iZVVadW3zKEwTzC2fCtAeL6HRi1aqkNjNMjmH62X1IQG
	 dAOmumuJ64bjthTDJcfIE7OB56QJFoZoPfm+PJ4MaJ97eZWhikUOm4zcfBGJd2LCYiMPw
	 lmJeGpFoCwDLvTT8Do9rCgSv82ktZywt7wxZ2fuhJAljvwti6xdvwNgT9DH1sFzOutEx0
	 0Q0d7oqLnI/YXnE1se4NrR/PiRjIevbCXyDj3AzJQ6S4rwBnflnCCSSw4SejsqJRa3w==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id B352BF80075
	for <alsa-devel@alsa-project.org>; Sat,  5 Sep 2026 14:52:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B352BF80075
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18d26dd157eee200-webhooks-bot@alsa-project.org>
In-Reply-To: <18d26dd157c35a00-webhooks-bot@alsa-project.org>
References: <18d26dd157c35a00-webhooks-bot@alsa-project.org>
Subject: USB-Audio: Common/HeadphonesOnly PlaybackMixerElem "PCM" does not
 match Topping D10s mixer (152a:8750)
Date: Sat,  5 Sep 2026 14:52:30 +0200 (CEST)
Message-ID-Hash: YIVKUF76S7QGLEOQJDZ2UJRXTDP2OPXD
X-Message-ID-Hash: YIVKUF76S7QGLEOQJDZ2UJRXTDP2OPXD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/YIVKUF76S7QGLEOQJDZ2UJRXTDP2OPXD/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #850 was opened from z23:

USB ID `152a:8750` is mapped to `Common/HeadphonesOnly`, which hard-codes `PlaybackMixerElem "PCM"`. A Topping D10s using that same Thesycon ID has no `PCM` mixer control. PipeWire/WirePlumber then falls back to software volume and leaves the DAC Feature Unit volume untouched, so desktop volume (e.g. 70%) stacks on top of a quiet hardware fader (here 84/127 = -43 dB).

## Hardware

- Device: Topping D10s (USB DAC)
- `lsusb`: `152a:8750 Thesycon Systemsoftware & Consulting GmbH D10s`
- iManufacturer: Topping; iProduct: D10s
- Distro: Arch Linux (`alsa-ucm-conf 1.2.16.1-1`, `alsa-lib 1.2.16.1-1`)
- Kernel: `7.2.3-arch1-2`
- Session: PipeWire 1.6.8 + WirePlumber 0.5.17

## Actual mixer controls

There is no control named `PCM`. The playback volume is named after the product string (note the trailing space):

```
numid=2,iface=MIXER,name='D10s  Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=3,iface=MIXER,name='D10s  Playback Volume'
  ; type=INTEGER,access=rw---R--,values=1,min=0,max=127,step=0
  : values=84
  | dBminmax-min=-127.00dB,max=0.00dB
```

(`values=84` was the live hardware volume when the mismatch was noticed: 66% / -43.00 dB.)

## What UCM applies

`alsaucm -c D10s dump text`:

```
Verb.HiFi {
Comment Default
Device.Headphones {
Comment Headphones
Values {
CaptureCTL "_ucm0001.hw:D10s"
PlaybackCTL "_ucm0001.hw:D10s"
PlaybackMixerElem PCM
PlaybackPCM "_ucm0001.hw:D10s,0"
}
}
}
```

This comes from:

- `ucm2/USB-Audio/USB-Audio.conf`: `Macro.hp-only.StringMatch "Id='152a:8750' Profile='Common/HeadphonesOnly'"`
- `ucm2/USB-Audio/Common/HeadphonesOnly-HiFi.conf`: `PlaybackMixerElem "PCM"`

## Session manager effect

WirePlumber logs this on every start:

```
spa.alsa: Path PCM is not a volume or mute control
```

The PipeWire sink is created (`HiFi: Headphones`) but **without** `HW_VOLUME_CTRL`. Flags were `HARDWARE DECIBEL_VOLUME LATENCY`. Desktop volume therefore only applies software gain. The USB Feature Unit stays at whatever the DAC last stored (class-compliant volume is in the device), which made output far quieter than the UI suggested.

## History

`152a:8750` was originally added for a Topping DX3 Pro+ ([03fed99](https://github.com/alsa-project/alsa-ucm-conf/commit/03fed99a96da3effebbef1f2830a5ac19834c102)). That profile only set `PlaybackPCM` and did **not** name a mixer element.

When it was generalized to `Common/HeadphonesOnly` ([93d015d](https://github.com/alsa-project/alsa-ucm-conf/commit/93d015d12c68a0516d181a5c2682037f1ec256a7)), `PlaybackMixerElem "PCM"` was added. Several Thesycon-based Topping devices share `152a:8750` (DX3 Pro+ and D10s at least), and the D10s mixer is `D10s `, not `PCM`.

## Suggested fix

`Common/HeadphonesOnly` should not assume a mixer named `PCM`.

Preferred: drop `PlaybackMixerElem "PCM"` (back to the original DX3 Pro+ snippet) so ACP/PipeWire can bind the card's real playback volume control.

Alternative: only set it when the control exists:

```
If.pcm {
	Condition {
		Type ControlExists
		Control "name='PCM Playback Volume'"
	}
	True.Value.PlaybackMixerElem "PCM"
}
```

Hard-coding `PlaybackMixerElem "D10s "` would fix this one unit but is fragile (trailing space, and the USB ID is shared).

## Workaround

```
amixer -c D10s sset 'D10s ' 100%
alsactl store
```

That puts the Feature Unit at 0 dB so the desktop software volume is the only attenuation.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/850
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
