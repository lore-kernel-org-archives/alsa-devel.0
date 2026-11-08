Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB3B606A31A
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Nov 2026 01:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=nPeX9aW1
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7734C601DE;
	Sun,  8 Nov 2026 02:46:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7734C601DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1794102395;
	bh=ymPh/g60x7kaHITIExvdC3PFKJwVOdbi5g3BDCPaiYc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=nPeX9aW1uXh/byjdACWC1FP7Bn/lg6dBH/CZ/BQ8u8kdFFBAmNNnPiVRLmXRk5qGU
	 LltUAFqJmc+FB/+gNPED+1j8cG4/M9CRBYjBWfDpMlXqv3RNexRWmD8h2iWdThILRS
	 UL+w8opBZ69QCW/Auh3wV4OTpys74+pQ3g87pE0w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BD718F805F3; Sun,  8 Nov 2026 02:46:01 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DA455F80602;
	Sun,  8 Nov 2026 02:46:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 6764CF80538; Sun,  8 Nov 2026 02:45:54 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1794102350;
	b=h8Q6SGCegyz8d/GiezMEgZkWiHvgXijc7YaET5L2KYD3ndAkfN8lX1Avb4q1kW0E2NZu
	 5Axp6Xi5neflQAtdHpOV9NgLLl9ovIWd5ho/cGz+Ht5c6rOWPgzQuQDtzn/QSoWKJSyse
	 AlV/Mr6U6F/qiBuRZZjUWGn58/5MzukHlHCECc6u/ow4o4voihcnqcKhyPoihvI0XnjAf
	 1Q+fzw1BS2TekAUL0ghd+wSXhRFCsyQtfm2uLDXUwekKju549ucefdNbSVA+FKFBQroyh
	 uDQ4dVfQPg0V0/aoHiBBCxGtmxSVryc9nFuy7xQcYXgDOSCwMNpMsJlqTZp7jWxspXQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1794102350;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=ymPh/g60x7kaHITIExvdC3PFKJwVOdbi5g3BDCPaiYc=;
	b=iZOI36FqjGzvkMeWbjMZT1x4zqO8+UvW8VDOfKzFafxyF0ab8Ml7gl3Ch73aW7q/uYX3
	 WMqdHVw6TlPaGGOQAGyVSgUTvIxcqDbdT3XOXtx1Ok+oERgBFx9k2Hjl1seLL+0Jv5zhN
	 ktp/i27WG+HiOKJ1TLHz0SbjEeITLMgUO0gyNn7gHNhFKx0FIxsyCFTxX2u/d2lRX65sd
	 CehJIOrrfPl5SiQy68RZlaWboEmUs3xObc8n4YalenukO11mK66W9P9YonKMVl/k7ixVd
	 1wmnwnNOJbXMHEj0kqXrWsYjphOzaTT4uuteUt8+uZwZaG1uOLUy7XjQygBypzE431A==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 04B26F80124
	for <alsa-devel@alsa-project.org>; Sun,  8 Nov 2026 02:45:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04B26F80124
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18e5ee9490f42900-webhooks-bot@alsa-project.org>
In-Reply-To: <18e5ee9490d26400-webhooks-bot@alsa-project.org>
References: <18e5ee9490d26400-webhooks-bot@alsa-project.org>
Subject: alsactl restore fails after Generic / Generic_1 IDs swap between HDMI
 and ALC897
Date: Sun,  8 Nov 2026 02:45:54 +0100 (CET)
Message-ID-Hash: OKRZ427ALWNR2EPTE25OIALMZJBDBPHV
X-Message-ID-Hash: OKRZ427ALWNR2EPTE25OIALMZJBDBPHV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OKRZ427ALWNR2EPTE25OIALMZJBDBPHV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-utils issue #338 was opened from flowersauce:

## Summary

Two HDA controllers exchanged the ALSA IDs `Generic` and `Generic_1` between observed boots. The existing state file still associated those IDs with the previous hardware. On the later boot, `alsactl restore` returned 99 and reported missing controls; the analog card's saved `Auto-Mute Mode = Disabled` was not restored.

This has a similar symptom and hardware combination to closed issue #263. That discussion suggested checking whether the Generic IDs refer to the same hardware after reboot. Here the observed ID-to-hardware mapping did change.

## Environment

- Arch Linux; Gigabyte X870 GAMING X WIFI7 motherboard
- linux-zen package: 7.2.14.zen1-1
- alsa-utils: 1.2.16-1; alsa-lib: 1.2.16.1-1
- PipeWire: 1.6.10; WirePlumber: 0.5.18
- Both affected controllers use `snd_hda_intel`
- PCI `0000:77:00.1`: AMD HDMI controller, ATI R6xx HDMI codec
- PCI `0000:77:00.6`: AMD analog controller, Realtek ALC897 codec
- A separate discrete GPU HDMI controller has the ID `HDMI`
- Rear line-out speakers and front-panel headphones both connected

## Observations

The following mappings were recorded from `/proc/asound/cards` in two sessions:

| Controller / codec | ALSA index | November 2 | November 8 |
| --- | --- | --- | --- |
| 0000:77:00.1 / ATI R6xx HDMI | 2 | Generic | Generic_1 |
| 0000:77:00.6 / Realtek ALC897 | 3 | Generic_1 | Generic |

The indexes stayed the same, while the IDs swapped.

Before the local mitigation, `/var/lib/alsa/asound.state` still contained:
- HDMI controls under `state.Generic`
- Analog controls under `state.Generic_1`, including `Auto-Mute Mode = Disabled`

On the November 8 boot, the stock `alsa-restore.service` ran `/usr/bin/alsactl restore`. Its process result was `status=99`, with many messages such as:

```text
/usr/bin/alsactl: set_control:1373: failed to obtain info for control #20 (No such file or directory)
```

The actual Auto-Mute setting on the analog card was `Enabled`.

The user-visible effect was that rear speakers stayed silent when front headphones were plugged in, even after selecting the line-out port in the desktop sound settings. Unplugging headphones allowed the speakers to play.

The PipeWire sink was already on `analog-output-lineout`, with both jack ports reported as available. Codec pin 0x14 (rear line-out) had `Pin-ctls: 0x00`. After disabling Auto-Mute, it changed to `Pin-ctls: 0x40: OUT`.

## Expected behavior / question

Is there a supported way for restoration to detect or avoid applying a saved card section to different hardware when discovery-dependent IDs change? Or does the underlying default-ID assignment need to be addressed in the kernel sound subsystem?

The observed mapping change and mismatched saved state strongly suggest an explanation for the restore failure, but the original failure has not been reproduced under controlled boot conditions. There is no evidence identifying a particular package update as the cause.

## Local mitigation and tests

Used the documented [udev card ID method](https://www.alsa-project.org/wiki/Changing_card_IDs_with_udev) to give each affected controller a unique ID:

```udev
ACTION=="add", SUBSYSTEM=="sound", KERNEL=="card[0-9]*", KERNELS=="0000:77:00.6", ATTR{id}="Mainboard"
ACTION=="add", SUBSYSTEM=="sound", KERNEL=="card[0-9]*", KERNELS=="0000:77:00.1", ATTR{id}="RadeonHDMI"
```

Installed as `/etc/udev/rules.d/60-stable-hda-ids.rules`, before the stock `90-alsa-restore.rules`. For live testing, the IDs were also assigned through sysfs without reloading the active driver. Set Auto-Mute to Disabled and generated a clean state file using `alsactl store`.

Tests performed:
- Temporarily enabled Auto-Mute, then ran `alsactl --no-init-fallback restore Mainboard`: exit 0 and Auto-Mute returned to Disabled.
- Ran `alsactl --no-init-fallback restore` for all cards: exit 0.
- Selected headphones: Headphone switch on, Front switch off.
- Selected line-out: Front switch on, Headphone switch off.
- Auto-Mute remained Disabled during both port changes.

A temporary user service that forced Auto-Mute off at login was removed after these tests, so it is not needed for the live restore test.

**Limitations:** The complete boot path with the new udev rules has not yet been tested by rebooting. Physical audibility after the final configuration change has not yet been confirmed by the user. Pre-mitigation state and the boot restore log have been preserved locally.

Please let me know which additional targeted diagnostics would help, or whether this report should be directed to the kernel tracker.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/338
Repository URL: https://github.com/alsa-project/alsa-utils
