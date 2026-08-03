Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E38C55196
	for <alsa-devel@archiver.kernel.org>; Mon,  3 Aug 2026 20:02:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCBF1601F2;
	Mon,  3 Aug 2026 22:02:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCBF1601F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785787363;
	bh=9yYqztY8SEVsWIEcPOQMctlfQcNMAaw1feBHQoPMaqw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=vCdeNnZL77L2n2Z0LXMZBp1NI1LyT2oTj9ZfSkjN/QvALxrVP4Uvy77XWbeMN8D2U
	 5qTtvPZywgqUo2hJq5oXUfgwl35h4wytyBk+vkzL215mOs3EUlnZbg9fZx3D3rkVe4
	 Vkn/oyl5kbGSLPQQ+kTaIXUwUqbxXHyXmMtB/HaA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6FCA9F805EF; Mon,  3 Aug 2026 22:02:08 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E1BC0F805EB;
	Mon,  3 Aug 2026 22:02:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2035BF805BF; Mon,  3 Aug 2026 22:01:59 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785787317;
	b=XMM8NrMVZgLh1re7KfxzGkKFP0P5krm4rGThiaGE24pmnQxTNFuG61Ayw+Q0yPZWzfeS
	 aWmdoBKZu2xTlXKGO2AU3V/KpGCT5G+KGL3FQVLurLqRSD8StxF+uh6AzvTRaBa++1Gtc
	 poJg5a/4J0ocgTAy9Pu5WiaFeXXK+05+DnxT2UfBCL7hbR8aK1nAvB8RSpjce4DBFyNzQ
	 ZUiwW20KXEsBIfNvCyaGJPuervjnK9voXbS2s1HaViFlW3UWDV34DpbQHPHammJ+E7/Bm
	 uifBBTJY3yCS80JdtwvpzAN+1KwoAnKfxieHOEkYIPyrxTmN0gMlTHPIKjmia7o7f4Q==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785787317;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=9yYqztY8SEVsWIEcPOQMctlfQcNMAaw1feBHQoPMaqw=;
	b=aPdaEwjcypK2TFoUl1vqYPalyHukR5VAowGWE1B2z/sMHYgDNSmztSRGSGWyIOHmma2C
	 11DClDgTPyNUGAXeZOBTqyKnunxs1ayzJH3HNiI6CeS9XeQUHJPe1FH823zsvchCGkQ+Y
	 1mzpKGWdSglveBT9qd7PZevecZDqZFR/qNxYFN2q6diWTQDu38ETg7nQOOP6IwftYBHxQ
	 KOpThARKLapcQJxubKdzbNViWfC+lh2XCSq14H57SKcpKIuqOUXLPaMV8IC2EShSVxfRM
	 /uF13S6/iOBTBVEAV2kmwSi09NEnKxAL0FaRKZFKQjMZsxV+TLqnetCFO8Z9wLQh5QA==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 8F67FF802BE
	for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2026 22:01:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8F67FF802BE
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18c8641a3b192200-webhooks-bot@alsa-project.org>
In-Reply-To: <18c8641a3af71800-webhooks-bot@alsa-project.org>
References: <18c8641a3af71800-webhooks-bot@alsa-project.org>
Subject: Locale-dependent POSIX regex in sof-soundwire UCM fails under
 tr_TR.UTF-8 and prevents HiFi profile detection
Date: Mon,  3 Aug 2026 22:01:59 +0200 (CEST)
Message-ID-Hash: MGJ5EUMK3WSVD5K4RV2YMITJBNKEGXHH
X-Message-ID-Hash: MGJ5EUMK3WSVD5K4RV2YMITJBNKEGXHH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/MGJ5EUMK3WSVD5K4RV2YMITJBNKEGXHH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #824 was opened from radiatez:

## Summary

This issue is fully reproducible and the root cause has been isolated.

The problem is caused by a locale-dependent POSIX regular expression in the SOF SoundWire UCM configuration. Under `tr_TR.UTF-8`, ALSA fails to import the UCM profile, preventing PipeWire/WirePlumber from exposing the normal HiFi profile.

This report includes:

- a minimal reproducer
- the root cause
- the diagnostic evidence
- a tested fix

---

## Hardware

- Laptop: Acer Swift SFG14-72
- Audio controller: Intel Meteor Lake-P HD Audio (`8086:7e28`)
- Driver: `sof-audio-pci-intel-mtl`

### Packages

- `alsa-ucm-conf 1.2.16.1-1`
- `pipewire 1.6.8`
- `wireplumber 0.5.15`

---

## Symptoms

With `LANG=tr_TR.UTF-8`:

PipeWire exposes only:

- Off
- HDMI
- Pro Audio

No **HiFi** profile appears.

WirePlumber therefore selects `off`, resulting in:

- Dummy Output
- No speaker
- No microphone

The exact same hardware works correctly from the CachyOS Live ISO.

---

## Root cause

The following regex in `sof-soundwire.conf`:

```text
mic:([a-z0-9]+(-dmic)?+(-sdca)?)
```

depends on locale-sensitive POSIX character ranges.

This behavior is independent of PipeWire and WirePlumber.

Both components correctly report the ALSA UCM import failure. The parsing error originates inside the ALSA UCM configuration/parser under the Turkish locale.

Under `tr_TR.UTF-8`, the expression matches:

```text
dmic
```

as

```text
dm
```

instead of

```text
dmic
```

ALSA then attempts to load:

```text
/usr/share/alsa/ucm2/sof-soundwire/dm.conf
```

which does not exist.

The failed include aborts the UCM import, causing PipeWire to expose only legacy ACP profiles.

---

## Reproducer

A small test using `setlocale()` and POSIX regex demonstrates the issue:

```text
C             -> dmic
C.UTF-8       -> dmic
en_US.UTF-8   -> dmic
tr_TR.UTF-8   -> dm
```

---

## Proposed fix

Replace

```text
[a-z0-9]
```

with

```text
[[:alnum:]]
```

because POSIX character classes are locale-safe while `[a-z]` is locale-dependent.

This change preserves the intended matching semantics while eliminating locale-specific behavior.

---

## Additional information

I performed a full investigation eliminating:

- kernel regression
- SOF firmware
- topology loading
- PipeWire
- WirePlumber
- device permissions
- package corruption

The attached report contains the complete diagnostic process, evidence, commands executed, and validation.

Please let me know if you would like the minimal reproducer or a patch.

[AUDIO_ROOT_CAUSE.md](https://github.com/user-attachments/files/30677297/AUDIO_ROOT_CAUSE.md)

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/824
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
