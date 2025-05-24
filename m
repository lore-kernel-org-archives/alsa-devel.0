Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5946DC54F30
	for <alsa-devel@archiver.kernel.org>; Sat, 24 May 2025 10:14:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E073B601EF;
	Sat, 24 May 2025 12:13:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E073B601EF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1748081639;
	bh=3LYzinSD5GGXhf4u3fUt0es6jfbw6AvapG/Ry2wc9HI=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sjDiMJMC13XoUn6Bqdt5wQVIYXtrwCuRxP9/WM3zlSqEGC9RVL186MFcZQJjckXIv
	 TLo5M8sBqGLRZEnauCup+1JfAeQYFWpYYw+ENp+JLGcX9PbWr5llBHryP+FnVvDyHM
	 9PlTkd/DQCmIgTbgzEKXwN+wSLtOFgKYlhDR2PeI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 400F9F805BF; Sat, 24 May 2025 12:13:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1657AF805C0;
	Sat, 24 May 2025 12:13:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5C72F8026D; Sat, 24 May 2025 12:13:19 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi2259423.contaboserver.net
 [45.14.194.44])
	by alsa1.perex.cz (Postfix) with ESMTP id EF26BF80246
	for <alsa-devel@alsa-project.org>; Sat, 24 May 2025 12:13:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EF26BF80246
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub pull_request - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
Message-Id: <18426ef36da44f00-webhooks-bot@alsa-project.org>
In-Reply-To: <alsa-project/alsa-ucm-conf/pr/566@alsa-project.org>
References: <alsa-project/alsa-ucm-conf/pr/566@alsa-project.org>
Subject: USB-Audio: Solid State Labs SSL 2 - fix capture channels
Date: Sat, 24 May 2025 12:13:19 +0200 (CEST)
Message-ID-Hash: V3XLKCS7LJKKWT5DPZVAYLAGYWF6HSZO
X-Message-ID-Hash: V3XLKCS7LJKKWT5DPZVAYLAGYWF6HSZO
X-MailFrom: github@alsa-project.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/V3XLKCS7LJKKWT5DPZVAYLAGYWF6HSZO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-ucm-conf pull request #566 was opened from olfx:

Same fix as for SSL+, commit fc17ed4.
Capture configuration is the same, with 4 channels.

-- alsa-info --

Solid State Logic SSL 2 at usb-0000:00:14.0-1, high speed : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S32_LE
    Channels: 2
    Endpoint: 0x01 (1 OUT) (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
    Channel map: FL FR
    Sync Endpoint: 0x81 (1 IN)
    Sync EP Interface: 2
    Sync EP Altset: 1
    Implicit Feedback Mode: Yes

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S32_LE
    Channels: 4
    Endpoint: 0x81 (1 IN) (ASYNC)
    Rates: 44100, 48000, 88200, 96000, 176400, 192000
    Data packet interval: 125 us
    Bits: 24
    Channel map: FL FR FC LFE

Request URL   : https://github.com/alsa-project/alsa-ucm-conf/pull/566
Patch URL     : https://github.com/alsa-project/alsa-ucm-conf/pull/566.patch
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
