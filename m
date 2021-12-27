Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485F6C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Dec 2021 09:14:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3D5DD1712;
	Mon, 27 Dec 2021 10:13:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3D5DD1712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1640596444;
	bh=P62tcJoApzaogjgw293GsPEATIvkOX9oXfyJ+9aiffU=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EIIUgYdfCDcXpi9c81+GObuOak9GGWAptqA8m4s3naGaDkZywaLVKhyIYlpUUQP8h
	 JlrC/AaVvqCbgQ6ugn+cyYO+Bup/A3+qnPvAUrh3kk+NMYp3S0LewkBjcbcdOSXxsL
	 tRNQJX2/f1rluCY/sMomzO4cuhnPLN1xaCSrPe2c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75E31F80161;
	Mon, 27 Dec 2021 10:13:11 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF86CF80163; Mon, 27 Dec 2021 10:13:09 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 9BD2BF800D3
 for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2021 10:13:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9BD2BF800D3
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - edited <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1640596382395229101-webhooks-bot@alsa-project.org>
References: <1640596382395229101-webhooks-bot@alsa-project.org>
Subject: After Update: No more sound. Downgrading solved it.
Message-Id: <20211227091309.EF86CF80163@alsa1.perex.cz>
Date: Mon, 27 Dec 2021 10:13:09 +0100 (CET)
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

alsa-project/alsa-ucm-conf issue #131 was edited from aljazzair:

Hello.

I am on Manjaro Linux, an Arch derivative.
Recently, after a system update, sound was gone.
After a couple of hours investigation, I narrowed it down to an update of alsa-ucm-conf.
Basically after downgrading 1.2.6.3-0 => 1.2.5.1-1, my problem is gone. 

Symptom: With 1.2.6.3-0, there was no sound.
Running aplay -l listed my hardware.
Also I was able to hear sound from my monitor using the following command:

> aplay -D plughw:0,7 /usr/share/sounds/alsa/Front_Right.wav     


But pactl list sinks came back empty. Pavucontrol showed no output devices either. Rebooting several times, editing various config files did not help.

I looked at the list of recent upgrades and saw alsa-ucm-conf in the logs. Downgrading solved my issue.

Distribution:

> Linux homelab 5.13.19-2-MANJARO #1 SMP PREEMPT Sun Sep 19 21:31:53 UTC 2021 x86_64 GNU/Linux

List of PLAYBACK Hardware Devices from aplay -l:

> card 0: PCH [HDA Intel PCH], device 0: ALC1220 Analog [ALC1220 Analog]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 1: ALC1220 Digital [ALC1220 Digital]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [HDMI 0]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 7: HDMI 1 [HDMI 1]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 8: HDMI 2 [HDMI 2]
>   Subdevices: 0/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 9: HDMI 3 [HDMI 3]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0
> card 0: PCH [HDA Intel PCH], device 10: HDMI 4 [HDMI 4]
>   Subdevices: 1/1
>   Subdevice #0: subdevice #0

Sound managed with:

>  pipewire --version
> pipewire
> Compiled with libpipewire 0.3.40
> Linked with libpipewire 0.3.40
> 

I am posting this in order to document what happened in case someone has a similar issue, and searches google for hints.
Also to inform the developer, maybe something can be done to avoid this.

Thank you.

Issue URL     : https://github.com/alsa-project/alsa-ucm-conf/issues/131
Repository URL: https://github.com/alsa-project/alsa-ucm-conf
