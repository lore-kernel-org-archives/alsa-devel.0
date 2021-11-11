Return-Path: <SRS0=P3rz=P6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1EDC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Nov 2021 19:59:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6613B61267
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Nov 2021 19:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6613B61267
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 99AE61658;
	Thu, 11 Nov 2021 20:58:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 99AE61658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636660743;
	bh=ENk/tGCxH0MLlcJOKjug9Oyq8j4ik5WphYrhWVM+JhA=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fMkwA6Kmw0/fe3MK31vgOPYvQHGRVFlWlVGzbow3GbPLoJzUxW+UhWM93YTdHu9+j
	 bOHFFIQIE/KWlbWarFiREy93QHhYOIJ6ovMXYvTuIxZEv623dcNbEmMzrW0RPulmFH
	 44KR2n9VBzIAWhXdEeNfk38eetloWLW6fB0be58Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C518F80224;
	Thu, 11 Nov 2021 20:58:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 73086F802D2; Thu, 11 Nov 2021 20:58:12 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id D2951F80086
 for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2021 20:58:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2951F80086
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1636660687527719021-webhooks-bot@alsa-project.org>
References: <1636660687527719021-webhooks-bot@alsa-project.org>
Subject: speaker-test fails with message "Unknown field hint" on Scarlett 8i6
Message-Id: <20211111195812.73086F802D2@alsa1.perex.cz>
Date: Thu, 11 Nov 2021 20:58:12 +0100 (CET)
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

alsa-project/alsa-plugins issue #40 was opened from montemedio:

I am using a Scarlett 8i6 Gen1. It used to work fine, but with the newest version of `speaker-test`, I get this error message:

```
$ speaker-test -Dusbstream:CARD=USB

speaker-test 1.2.5.1

Playback device is usbstream:CARD=USB
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
ALSA lib pcm_usb_stream.c:503:(_snd_pcm_usb_stream_open) Unknown field hint
Playback open error: -22,Invalid argument
```

```
$ cat /proc/asound/cards
 0 [PCH            ]: HDA-Intel - HDA Intel PCH
                      HDA Intel PCH at 0xd3a10000 irq 35
 1 [NVidia         ]: HDA-Intel - HDA NVidia
                      HDA NVidia at 0xd3000000 irq 17
 2 [USB            ]: USB-Audio - Scarlett 8i6 USB
                      Focusrite Scarlett 8i6 USB at usb-0000:00:1a.0-1.2, high speed
```

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/40
Repository URL: https://github.com/alsa-project/alsa-plugins
