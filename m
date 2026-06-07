Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B24CD8C88
	for <alsa-devel@archiver.kernel.org>; Sun,  7 Jun 2026 15:25:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 103CF601CF;
	Sun,  7 Jun 2026 17:25:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 103CF601CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1780845935;
	bh=GHr+M94LlaUhx6sEGTP0oTNrfcxSVJMp44mtKUX0d6E=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ulxMUvzyOhkPHYijcG+zslDDPGE5+vqBew6iXyA01WSwTPu8ALZ4juBU1vn8MnWKY
	 xAjkbWM4yv5gUcoX5IfLDyN2PJ8Lrftaf/6QOvRAjjvcHJzhif5BbkVrBKo+aDh101
	 vlDCjo4DVe0XHXTnNDz8oYlFrIG2FdHrnd7a+5jM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3E023F805EC; Sun,  7 Jun 2026 17:25:00 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C501CF805FE;
	Sun,  7 Jun 2026 17:24:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 263B6F8055B; Sun,  7 Jun 2026 17:24:54 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=45.14.194.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1780845893;
	b=cqOkY66GvYnwLp3NrWahh5Wyo4CVm4OVvPJcbbkQ3DNggqi81KVhBicZ/JmtkyZTTvXD
	 Q6OhodUNndWHqH1cWQDBgDMC/BBXPpI6iVv8IPa+piqBFi59KZmLmjC3fs41mny6MYkhL
	 QI64fJIMNKlNcGn1s2A6z49tx8WCUHnEuuzXOVP1HlMy/VqfFtqvoUMlpm7tASlb9HUyw
	 geZZg8i0VFy4i9+BJSAnvpBsidGrq2SnWLbfP8CHviyLnd/dEWKVtfrcOzN+dLZZjGVuJ
	 hSaJzIYdy7dtmmIC0CRIGxhDQ29yMZa+rCh2gRrT7UloddDAlG1vLHiWnZbLR8aQQVw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1780845893;
	h=MIME-Version:From:To:Message-Id:Subject;
	bh=GHr+M94LlaUhx6sEGTP0oTNrfcxSVJMp44mtKUX0d6E=;
	b=SP3q2IUYrccyiMnPgXo+3V409k+IaZLxvCuAzJ9Xh7C1SJYcZvO3CE8LHOV5Tnh6q07L
	 bDbDEU9FhjSKIRC1SMrw4uJeL85NGTl5p7ssRWgbNccjLa62b/28qSRR3xOGZ8UCG4wLJ
	 hNF+wv+Ey/9hW1hyYxOllJG0NI8wVQkL03y1scUGtnsps6QiczvL4sMtOmyqPzWvXGqzW
	 QtpOk/AIQcIedu5vS1W8S6rmsqJQbAPj4l6U8IKpwpEjP476OltbSv4/1VcXzaoj42+C5
	 mp1xYklnErOQFS8EmOE+nFf71tiyD9k5p5WGZC7zrZAiC0FJumqG4cFdCkewfbqDfdQ==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 arc=none smtp.remote-ip=45.14.194.44
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id 80200F8051D
	for <alsa-devel@alsa-project.org>; Sun,  7 Jun 2026 17:24:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80200F8051D
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18b6d5e7496e0100-webhooks-bot@alsa-project.org>
In-Reply-To: <18b6d5e749451d00-webhooks-bot@alsa-project.org>
References: <18b6d5e749451d00-webhooks-bot@alsa-project.org>
Subject: ASUS ROG STRIX X870-F GAMING WIFI (ALC4080,
 USB ID 0b05:1b9b): Rear Mic-In detected as Line Input under Linux
Date: Sun,  7 Jun 2026 17:24:54 +0200 (CEST)
Message-ID-Hash: ITPYGJ45EG7OTFRT5ROE3L5CGVBPYGMU
X-Message-ID-Hash: ITPYGJ45EG7OTFRT5ROE3L5CGVBPYGMU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ITPYGJ45EG7OTFRT5ROE3L5CGVBPYGMU/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf issue #780 was opened from PoMpls:

Hardware:

* Motherboard: ASUS ROG STRIX X870-F GAMING WIFI
* Audio Codec: Realtek ALC4080 (USB Audio)
* USB Audio ID: 0b05:1b9b

Software:

* Debian 13 (Trixie)
* Kernel: 6.12.90-amd64
* alsa-ucm-conf: 1.2.14
* PipeWire: 1.4.2

Issue:

The rear microphone input (Mic-In) does not work under Linux, while it works correctly under Windows using the same hardware and cable.

The motherboard rear audio panel only provides:

* Mic In
* Line Out
* Optical S/PDIF Out

There is no physical rear Line-In connector.

However, ALSA reports:

Mic - Input Jack  : off
Line - Input Jack : on

when a microphone is connected to the rear Mic-In port.

Observed behavior:

* Rear Mic-In does not capture any audio.
* arecord receives no signal.
* Discord cannot receive audio from the rear microphone.
* Front panel microphone works correctly.
* When the microphone is connected to the front panel header, ALSA reports:

Mic - Input Jack : on

and audio capture works normally.

Diagnostic information:

amixer reports:

Analog In - Input Jack : on
Line - Input Jack      : on
Mic - Input Jack       : off

The USB mixer exposes:

Unit 9  -> Analog In - Input Jack
Unit 11 -> Line - Input Jack
Unit 12 -> Mic - Input Jack

Current UCM profile:

ProfileName "Realtek/ALC4080"

TThe board is currently matched by the generic ALC4080 profile.

USB ID 0b05:1b9b is documented in USB-Audio.conf as:

"ASUS ROG STRIX X870E-E GAMING WIFI"

However the affected system is:

ASUS ROG STRIX X870-F GAMING WIFI

from:

/usr/share/alsa/ucm2/USB-Audio/USB-Audio.conf

Possible issue:

The motherboard appears to be using the generic ALC4080 profile. The rear Mic-In connector may be incorrectly mapped or detected as Line Input. Since the X870-F rear panel does not provide a Line-In connector, the reported "Line - Input Jack : on" state seems incorrect.

Could a board-specific quirk/profile be required for USB ID 0b05:1b9b or for the ASUS ROG STRIX X870-F GAMING WIFI?

Additional observation:

When a microphone is connected to the rear Mic-In connector:

Mic - Input Jack : off
Line - Input Jack : on

When the same microphone is connected to the front panel header:

Mic - Input Jack : on

and audio capture works correctly.

This suggests that the rear microphone jack detection may be incorrectly reported or mapped.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/780
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
