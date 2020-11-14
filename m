Return-Path: <SRS0=VUDG=EU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4D4C5519F
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Nov 2020 17:14:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0AA92137B
	for <alsa-devel@archiver.kernel.org>; Sat, 14 Nov 2020 17:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vv8X1TYg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AA92137B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C061E17AB;
	Sat, 14 Nov 2020 18:13:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C061E17AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605374065;
	bh=MmmM1RsI+VPUEVqFj1Fp9NGLq8bVHvB111OHI11QLWk=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Vv8X1TYgOZ4OqYDO5Ax3SEMqSum7qleqCavN8TJc4vPPrpFKwePHDVLEtpx1TSMEX
	 Neccodd3ZjYhHzp2HsqbqBUSBYmU6Z31MD7tCoVSHN7UwKO0kyqxMzYGso4vQRrH7w
	 HTb8Tp0b4OkszN1Y36mh7dhkmqR9diHewPRtK93k=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C0AAF8021C;
	Sat, 14 Nov 2020 18:13:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4130F80475; Sat, 14 Nov 2020 18:13:33 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 56808F80161
 for <alsa-devel@alsa-project.org>; Sat, 14 Nov 2020 18:13:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 56808F80161
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1605374011153587103-webhooks-bot@alsa-project.org>
References: <1605374011153587103-webhooks-bot@alsa-project.org>
Subject: [Question]: Mute all channels when starting X11
Message-Id: <20201114171333.E4130F80475@alsa1.perex.cz>
Date: Sat, 14 Nov 2020 18:13:33 +0100 (CET)
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

alsa-project/alsa-utils issue #72 was edited from atreyasha:

Hello, thank you for developing `alsa-utils`. I have a specific question pertaining to `amixer`.

## Current behaviour

When starting `X11` and `i3` (my window manager), I would like to have all audio channels (speaker, headphones, etc.) muted. At the moment, I have the following command in my `i3` configuration file:

```
amixer -q sset Master mute
```

And as expected, the Master channel is indeed muted after starting `X11`. However, when I connect or disconnect my headphones, the volume automatically reverts back to the volume that was saved during the last boot.

## Expected behaviour

I would like all volume channels to stay muted. So for example after starting `X11` and `i3`, I would like to see that both my speakers and headphones are muted, even when I plug/unplug the jack. Would you have any recommendations on how to do this?

I was considering manually muting both headphones and speakers with `amixer` and then re-using the `alsa` state file during boots. But I am unsure because this seems like a hack'ish solution.

## System specifications

OS/Kernel: Arch Linux, 5.9.8-arch1-1, x86_64 GNU/Linux
alsa-utils: 1.2.4-2 (installed via `pacman` package manager)
wm: `i3-gaps`

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/72
Repository URL: https://github.com/alsa-project/alsa-utils
