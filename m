Return-Path: <SRS0=OBLK=FQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3ECC433FE
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Dec 2020 16:40:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F7F22262
	for <alsa-devel@archiver.kernel.org>; Sat, 12 Dec 2020 16:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F7F22262
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=alsa-project.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7742C16C9;
	Sat, 12 Dec 2020 17:39:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7742C16C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607791215;
	bh=eV3u+cmS7HsaBA804qvnkj9ugdxxWTbR4yxeHyqViRc=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mxXWZHTxcv77IazjPS7UJsg6B9Qr6emhEdmb+cUXHdBISTdJ4VQDViNHElK5msIWP
	 R2CvG3vo2Ib7+prKWhoyT43tG80u4lqtFBEOW+3kHdG/PyXB9ejVjr1MzoGKBZqCcF
	 8jjKRWyhabNQGGJ+WeQnww/kxGJVwwkkTIeo1BQs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D38D1F80164;
	Sat, 12 Dec 2020 17:39:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6599F80129; Sat, 12 Dec 2020 17:39:22 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 7A6C3F80129
 for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2020 17:39:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7A6C3F80129
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1607791154221813917-webhooks-bot@alsa-project.org>
References: <1607791154221813917-webhooks-bot@alsa-project.org>
Subject: Bug in the ALSA driver 'snd_usb_audio'
Message-Id: <20201212163922.D6599F80129@alsa1.perex.cz>
Date: Sat, 12 Dec 2020 17:39:22 +0100 (CET)
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

alsa-project/alsa-lib issue #105 was opened from rombru:

Hello,
I'm not an expert in linux systems.
I will try to give a maximum of information.

I've bought Bowers & Wilkins PX7 headphones. They doesn't work using USB on Ubuntu.
Using Ubuntu and bluetooth, or audio jack, the headphones work well. 
Using Windows 10 and USB, the headphones work well.

I d'like too use them with USB on Ubuntu because that recharge them in parallel.

Problems while the headphons are connected :
On Chrome : The videos are played too fast and there's no sound (Youtube & Twitch).
On Firefox : The videos are played too fast and there's a crackling sound (Youtube & Twitch).
On VLC : No sound

I've tried with Ubuntu 20.04 & 18.04.
They are set as default audio device
I've played with PulseAudio and alsamixer (reinstall, mute/unmute, ...)
The headphones are set as fallback in PulseAudio.

Trying to find the issue, i've make some test found on Google :
I've added pcie_aspm=off in GRUB_CMDLINE_LINUX_DEFAULT
Setting devices as default in /etc/asound.conf

--- The ALSA part

I think the problem come from ALSA, i've found the errors :
`Failed to load module "module-alsa-card`
followed few lines later by
`Most likely this is a bug in the ALSA driver 'snd_usb_audio'. Please report this issue to the ALSA developers.`

Output of `journalctl --user -u pulseaudio` is [here](https://gist.githubusercontent.com/rombru/eb4ca14168494e95c62a961f92e91a90/raw/52c93f01b9c617f823308183d32d07f8e9033bc1/journalctl.txt)
Output of `pulseaudio -vvvvv` is [here](https://gist.githubusercontent.com/rombru/eb4ca14168494e95c62a961f92e91a90/raw/52c93f01b9c617f823308183d32d07f8e9033bc1/pulseaudio.txt)
Output of `pacmd ls` is [here](https://gist.githubusercontent.com/rombru/eb4ca14168494e95c62a961f92e91a90/raw/52c93f01b9c617f823308183d32d07f8e9033bc1/pacmd.txt)

Please, tell me if you need something more to analyse the problem.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/105
Repository URL: https://github.com/alsa-project/alsa-lib
