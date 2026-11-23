Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC27606A321
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alsa-project.org header.i=@alsa-project.org header.a=rsa-sha256 header.s=default header.b=iZRRxYQl
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08FFD60208;
	Mon, 23 Nov 2026 16:24:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08FFD60208
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1795447499;
	bh=J8W4CQ9ZrDF+GK6iDq0+nehmc2FLUqS33IHXDVUyF0s=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=iZRRxYQlpWoeMoAHQKKvuBthuzIIeUrC5r8EeI8NPFAz8hkrPquLQbq9SJuJSuD7G
	 G/xuMtAQrmlrQxgAAvvMa82VKfobJmDWu6Ilm5aP1slbZxwzzp34wlfqB/aM5tcjIJ
	 5EJE/PwNq6ccDFv0fwtomLSTevbo1CaBElBnBjOM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37A16F8057E; Mon, 23 Nov 2026 16:24:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AE084F805FE;
	Mon, 23 Nov 2026 16:24:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D95AF80020; Mon, 23 Nov 2026 16:24:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1795447459;
	b=B6929nHvEZKRStaD7usr85k2S18/ydFzY/MpH7WcG0q5TUKJwWA3sk3uj0NZhsfU2PAE
	 lcHyj7VElNm9/HmHkFL7pUXUy2Wp9k5UV0ZLoDhIWkK/K5Zi2bBEYN24bW65LQDUKnDA8
	 4c6pXXKJpZLm1Sjja/8JE5H8rEUeOhvRNcXy4KOW8EtRYT9GrgGck6Y/4YK4xJZRO5irs
	 OCaK37abQlOXoDUIqkIf4XVAZwGLbpI0wIkuoQjO4m2gMZyLCb9aCL4w/uhkrn/59z8Pb
	 fDbVlOzQHzIIxBnYiaI2OLdxPJ7JN2Uunsrr2xeCLsHorI3zGLGml+OuUZbYawe91vA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1795447459;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=J8W4CQ9ZrDF+GK6iDq0+nehmc2FLUqS33IHXDVUyF0s=;
	b=Ywz6yPcuj/EbTzBtcv8g+ubaUvTPz2ooxdYT6zruMmqQYcL66YhmmdKBYMaCzkBJvb3d
	 kLGrNNjaVBV3xjfzzTC6junGQkr5MPjGGuuFqYDNAyPyQCK4GsOmFpbJnTPEARAgULLv3
	 m7QP6JwbeE6SdCUokxu/PnrxrgDREMLaACgd7F3fFMH6bYGUYfKRA53RWN9Mm6lmaZ8KS
	 LlrsO3e6T0jVPOG+Hk46n/qtQkt2IDUzsDilwaaAQAY7WnPHj5mp2H/JZH0UYllv7Ebbi
	 6Qi8wbNYrfL1E1MpKegs+doxysbeCoZOUfY7aWWbsrvR0/tzynGaQDTQZIXVmFfWU3g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
	arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 01949F800B5
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2026 16:24:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01949F800B5
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18eab5f32f3ca400-webhooks-bot@alsa-project.org>
In-Reply-To: <18eab5f32f370a00-webhooks-bot@alsa-project.org>
References: <18eab5f32f370a00-webhooks-bot@alsa-project.org>
Subject: USB-Audio: EDIFIER R19BT (2d99:a021) muted by default / wrong IEC958
 profile in PipeWire
Date: Mon, 23 Nov 2026 16:24:20 +0100 (CET)
Message-ID-Hash: 63WQ3CBDUQZBTQOGUVY3RF6DJLIR5BKP
X-Message-ID-Hash: 63WQ3CBDUQZBTQOGUVY3RF6DJLIR5BKP
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/63WQ3CBDUQZBTQOGUVY3RF6DJLIR5BKP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>

alsa-project/alsa-ucm-conf issue #925 was opened from marcin73j-hash:

Hello,

When connecting **EDIFIER R19BT** USB speakers (`2d99:a021`) on a system using PipeWire + WirePlumber (tested on TUXEDO OS / KDE Plasma 6.7 / Kernel 7.3.4), the device is detected, and WirePlumber defaults to the `IEC958` (Digital Stereo) profile or leaves the hardware ALSA mixer control (`PCM Playback Switch` / `PCM Playback Volume`) muted/at 0%, resulting in no audio output out of the box.

*(Note: On older PulseAudio systems, the speakers unmute and play automatically without any manual intervention).*

### Workaround that fixes the issue:
1. Setting `device.profile = "pro-audio"` for `alsa_card.usb-.*R19BT.*` in WirePlumber configuration.
2. Unmuting and setting `PCM` to 100% via `amixer -c R19BT sset PCM 100% unmute`.

### Hardware details:
**`lsusb`:**
```text
Bus 001 Device 008: ID 2d99:a021 EDIFIER EDIFIER R19BT

card 0: R19BT [EDIFIER R19BT], device 0: USB Audio [USB Audio]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

numid=2,iface=MIXER,name='PCM Playback Switch'
  ; type=BOOLEAN,access=rw------,values=1
  : values=on
numid=3,iface=MIXER,name='PCM Playback Volume'
  ; type=INTEGER,access=rw---R--,values=2,min=0,max=147,step=0
  : values=147,147
  | dBminmax-min=-28.37dB,max=-0.94dB
numid=1,iface=PCM,name='Playback Channel Map'
  ; type=INTEGER,access=r--v-R--,values=2,min=0,max=36,step=0
  : values=0,0
  | container
    | chmap-fixed=FL,FR

[edifier-debug.txt](https://github.com/user-attachments/files/35283385/edifier-debug.txt)

Could you please add a UCM profile / quirk for USB ID 2d99:a021 so that PCM Playback Switch is unmuted and the proper analog output profile is selected out of the box?
Thank you!

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/925
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
