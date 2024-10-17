Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A4DD3C52B
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2024 18:56:57 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E272A851;
	Thu, 17 Oct 2024 20:56:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E272A851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1729191414;
	bh=jCBU9WvfuF3aktBe+r4JORXcZR6Mh8/EY+I6PWwkYWY=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=aAfL3tE2ZtHZtDEw+h/AzL8zbdmA2omiYSDyTkOu0OsZL1BqUbqEiEBggu8+hrdPk
	 7G4zakeW5KxbycN/vSoF1DtAOxZS+7gxUXbKzYnbsDIL8q6fVHLCg9lDEyENFE+fDe
	 fsgmoTfX0vhuUjvvPDA2vc9lrGkhXWTIdaCVA8BQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 97B55F805BD; Thu, 17 Oct 2024 20:56:23 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11E34F805B6;
	Thu, 17 Oct 2024 20:56:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A9341F80448; Thu, 17 Oct 2024 20:56:16 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (vmi242170.contaboserver.net
 [207.180.221.201])
	by alsa1.perex.cz (Postfix) with ESMTP id 08742F8016B
	for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2024 20:56:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08742F8016B
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1729191374372973204-webhooks-bot@alsa-project.org>
References: <1729191374372973204-webhooks-bot@alsa-project.org>
Subject: ALSA error: snd_pcm_hw_params_set_format failed: Invalid argument.
Message-Id: <20241017185616.A9341F80448@alsa1.perex.cz>
Date: Thu, 17 Oct 2024 20:56:16 +0200 (CEST)
Message-ID-Hash: LEXBBGX6EGDWMXYLUNP66ADMXIJL3HAF
X-Message-ID-Hash: LEXBBGX6EGDWMXYLUNP66ADMXIJL3HAF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LEXBBGX6EGDWMXYLUNP66ADMXIJL3HAF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

alsa-project/alsa-plugins issue #62 was opened from linuxandos2:

Playing a flac with a samplerate higer than 96000 with audacious gives: 

> _ALSA error: snd_pcm_hw_params_set_format failed: Invalid argument._

Output device for audacious is hw:1.0 - USB Audio
the device is a soudbaster blasterx G6.

output of _cat /proc/asound/card1/stream0_

> Creative Technology Ltd Sound BlasterX G6 at usb-0000:00:14.0-4.1, high speed :
> USB Audio
> 
> Playback:
>   Status: Stop
>   Interface 1
>     Altset 1
>     Format: S24_3LE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000
>     Data packet interval: 125 us
>     Bits: 24
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 1
>     Implicit Feedback Mode: No
>   Interface 1
>     Altset 2
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 0x01 (1 OUT) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000
>     Data packet interval: 125 us
>     Bits: 32
>     Channel map: FL FR
>     Sync Endpoint: 0x81 (1 IN)
>     Sync EP Interface: 1
>     Sync EP Altset: 2
>     Implicit Feedback Mode: No
> 
> Capture:
>   Status: Stop
>   Interface 2
>     Altset 1
>     Format: S24_3LE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000
>     Data packet interval: 125 us
>     Bits: 24
>     Channel map: FL FR
>   Interface 2
>     Altset 2
>     Format: S32_LE
>     Channels: 2
>     Endpoint: 0x82 (2 IN) (ASYNC)
>     Rates: 44100, 48000, 88200, 96000, 176400, 192000, 352800, 384000
>     Data packet interval: 125 us
>     Bits: 32
>     Channel map: FL FR
> 
linux: gentoo
kernel: 6.9.9-gentoo-x86_64
alsa-lib-1.2.12
alsa-topology-conf-1.2.5.1
alsa-ucm-conf-1.2.12
alsa-plugins-1.2.12
alsa-utils-1.2.12

selecting  

> pulse - PulseAudio Sound Server

 in audacious results in no sound and audacious hangs.
Pipewire and wireplumber are used.

On an old gentoo- system on another partition all samplerates play successfully.
Using the same kernel: linux-6.8.1-gentoo as in the old system on the new one does not solve the problem.
the versions of alsa are:
alsa-lib-1.2.10-r2
alsa-topology-conf-1.2.5.1
alsa-ucm-conf-1.2.10-r1
alsa-plugins-1.2.7.1-r1
alsa-utils-1.2.10-r1

Issue URL     : https://github.com/alsa-project/alsa-plugins/issues/62
Repository URL: https://github.com/alsa-project/alsa-plugins
