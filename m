Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5C7CD6E7B
	for <alsa-devel@archiver.kernel.org>; Sat,  6 Jun 2026 00:08:15 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 185256025D;
	Sat,  6 Jun 2026 02:08:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 185256025D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780704493;
	bh=aUBlA5E2TVhaSwThi/fXtbiStlyP8zK0X7xxCjFsmOo=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=UlBlxsHk1+PuhFK1h3Gqf/pbqdZVPtxhP+3AxGRtV83crAnLTftRdKGiKsBFT9nZC
	 WEjfq/O411MQ6WpMsmon06/RwhhGTEa4H0Re/RMI4A3LR4OWqKFD46JurlZxWdJ6nz
	 s94cx6sryXRlbe4tPHPY93xt/GSFq0CpbptBwTyo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 18CE4F805F4; Sat,  6 Jun 2026 02:07:38 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id F1542F805F4;
	Sat,  6 Jun 2026 02:07:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4F138F804FF; Sat,  6 Jun 2026 02:07:31 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780704449;
	b=dlliy9frTBlW/d9R7cg3f4vK15iVFrYVPX1/pdt2lr3sLJuAd/tAIiw0fUsi/s1j+MtT
	 vP5dDnwyemHWwBtNlpSSQQj2N+tKyXbjUtvdfsdTRvwJuVYT6VTVx1iej3A3MVPRNOqxb
	 0zP/jFlUNQTknS7U+01K8Zgh6lpFEHPeRxJLmXmWiXaq1ILyeA1qvafi1ix9O+97cgHwK
	 nWKhAoyvfOo6PHEHhM5gqna+sv+RsY6rg+Yz7cguCAjso/L34/xXVuQGfXEq/FmQQnNN9
	 MS5lBppRzl8wXXWTI11dSEyM2LOyJnT/VKbxR0psOy9sTc4UDOWazmGm1VRTDRoJNfQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780704449;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=aUBlA5E2TVhaSwThi/fXtbiStlyP8zK0X7xxCjFsmOo=;
	b=EJTBxJrCw9yUyNFaoQSUVlB628CLabWzilcX0jou5s4LR9gdF6Ywbh2bYOXkZqXtJm+5
	 74ns59U5oUM447L8GBUG+Cjtm0ID5fLwaJk0bkyzGL0oK1okL3Gh41ldy0kc2b9B0I3vc
	 NrrW1y4jItm1GMfOsTtQ06fSsNb8IDFOYMSR28A/UHRuQNOqGArmpUqc9SsD1Tyy8yOD3
	 JeNlY6y459JBS7UQKev0RB/qUEOc3YrsHdBolia8h9x9/jCA08FdNexIPvepfJJUrUpa+
	 81WVxLfhZ7Z5u+IzEm9oZQ52iWo9PWXvIYJ6faRe00B8GCnzCaAvLnVdgHujGYP/ncA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8247DF80185
	for <alsa-devel@alsa-project.org>; Sat,  6 Jun 2026 02:07:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8247DF80185
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b6554265823e00-webhooks-bot@alsa-project.org>
In-Reply-To: <18b65542655dcd00-webhooks-bot@alsa-project.org>
References: <18b65542655dcd00-webhooks-bot@alsa-project.org>
Subject: ALC4080: S/PDIF disabled because `spdif_nodev` checks PCM `subname`
 instead of `name`
Date: Sat,  6 Jun 2026 02:07:31 +0200 (CEST)
Message-ID-Hash: Q7GNWWM2EHC2GBSIKBBAPG5Y3OSXY3JP
X-Message-ID-Hash: Q7GNWWM2EHC2GBSIKBBAPG5Y3OSXY3JP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q7GNWWM2EHC2GBSIKBBAPG5Y3OSXY3JP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #779 was opened from djglxxii:

On an MSI MAG X870 Tomahawk WiFi motherboard with Realtek ALC4080 USB audio (`0db0:cd0e`), optical S/PDIF output disappears with `alsa-ucm-conf` 1.2.16.

The kernel/driver side appears to expose the hardware correctly: direct ALSA playback to the raw PCM device works and is audible over optical. The regression appears to be in `ucm2/USB-Audio/Realtek/ALC4080-HiFi.conf`, where the S/PDIF device is disabled because `find-device` searches `field=subname` for `Audio #3`, but this device exposes `Audio #3` in the PCM `name` field instead.

## Affected Hardware

- Motherboard: MSI MAG X870 Tomahawk WiFi
- Codec: Realtek ALC4080 USB audio
- USB ID: `0db0:cd0e`
- Driver: `snd_usb_audio`
- `CardComponents`: `USB0db0:cd0e`

## Regression

- Working: `alsa-ucm-conf` 1.2.15.3
- Broken: `alsa-ucm-conf` 1.2.16

After upgrading `alsa-ucm-conf`, PipeWire/WirePlumber no longer exposes an S/PDIF sink. Since the analog outputs are jack-gated and unplugged on this setup, the card ends up with no usable output profile.

## Evidence That The Kernel/Hardware Path Works

Raw ALSA playback works:

```sh
speaker-test -D hw:0,3 -c2 -t wav
speaker-test -D hw:0,2 -c2 -t wav
```

Both are audible through the optical speakers.

The relevant PCM exists:

```text
$ cat /proc/asound/card0/pcm3p/info
id:      USB Audio
name:    USB Audio #3
subname: subdevice #0
```

`aplay -l` shows the same:

```text
card 0: Audio [USB Audio], device 3: USB Audio [USB Audio #3]
  Subdevice #0: subdevice #0
```

## Suspected Root Cause

`ALC4080-HiFi.conf` contains this logic:

```conf
If.spdif_dev2 {
    Condition {
        Type RegexMatch
        String "${CardComponents}"
        Regex "USB(0b05:(1996|1a5[23c])|0db0:1feb)"
    }
    True.Define {
        SpdifName "S/PDIF Output"
        SpdifPCM "2"
    }
    False.If.spdif_nodev {
        Condition {
            Type String
            Empty "$${find-device:type=pcm,stream=playback,field=subname,regex='Audio #3'}"
        }
        True.Define.SpdifName ""
    }
}
```

On this board, the regex `Audio #3` matches the PCM `name`, not the `subname`:

```text
name:    USB Audio #3
subname: subdevice #0
```

So this lookup returns empty:

```conf
field=subname,regex='Audio #3'
```

That causes:

```conf
True.Define.SpdifName ""
```

which removes the S/PDIF `SectionDevice` from the HiFi verb even though the PCM exists and works.

## Suggested Fix

Search the PCM `name` field instead:

```diff
- Empty "$${find-device:type=pcm,stream=playback,field=subname,regex='Audio #3'}"
+ Empty "$${find-device:type=pcm,stream=playback,field=name,regex='Audio #3'}"
```

Alternatively, detect the fourth playback PCM by index/device number rather than matching this string in `subname`.

## Workaround

Downgrading `alsa-ucm-conf` to 1.2.15.3 restores S/PDIF output. Applying the `field=name` change locally also restores the optical sink.

## Environment

- Distribution: CachyOS
- Upgrade command that exposed the regression: `sudo pacman -Syu`
- `alsa-ucm-conf`: 1.2.16 broken, 1.2.15.3 working
- `alsa-lib`: 1.2.16
- Kernel: 7.0.11-1-cachyos
- ALSA driver string: `k7.0.11-1-cachyos`
- Audio server: PipeWire/WirePlumber
- S/PDIF output terminal present in USB descriptors: `bTerminalID 24`, `wTerminalType 0x0605` / S/PDIF interface

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/779
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
