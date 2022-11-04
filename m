Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10554C433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Nov 2022 17:21:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4988C1FA;
	Fri,  4 Nov 2022 18:20:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4988C1FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667582458;
	bh=BJsIfGWnBP0acNXoCGv4/3DAeqoaM+YRsYr8LxXcO3Q=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MW3z5pBHdjgd7qZRYF7fpMbbse4WyLzhTHpWVUsBxNWA4073XnjLODRC1/LPc1cvK
	 xg1LUPVf+2a3BYZhXNHmCRrzDmh4q/dBjqJZq/CHPQI9TMX/GWjL2h4+YAeZCENWdJ
	 M4Dz1DwFl/FlmWhdngT5b30NfuEZC9gAQqEtMkGk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D8D78F80155;
	Fri,  4 Nov 2022 18:20:07 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 304C6F80448; Fri,  4 Nov 2022 18:20:06 +0100 (CET)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 84FAFF80155
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2022 18:19:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84FAFF80155
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1667582398754319906-webhooks-bot@alsa-project.org>
References: <1667582398754319906-webhooks-bot@alsa-project.org>
Subject: Missing quirk for JBL Quantum 810 (?)
Message-Id: <20221104172006.304C6F80448@alsa1.perex.cz>
Date: Fri,  4 Nov 2022 18:20:06 +0100 (CET)
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

alsa-project/alsa-lib issue #279 was opened from Xenorio:

Hi there!

Recently, I received a JBL Quantum 810 headset as a replacement for my Quantum 800 (which worked totally fine until a hardware issue). When I connected my new headset via the provided 2.4Ghz dongle, all I got was microphone input, but no sound output. Taking a look at pavucontrol (I use PipeWire on Fedora), it only has 2 configuration options (other than "off"), which are "Pro Audio" and "Mono Input". With the old one I had a lot more, including "Analog Stereo Duplex", which is what I always used. With "Pro Audio" selected, it registers one input device and 2 output devices (from what I could gather, there are 2 because of the hardware slider used for mixing game and voice chat audio). No matter which of the output devices I use, no sound is coming out, and they don't even have a volume slider.

After some research, my suspicion is that all that needs to be done is assigning an already existing quirk for JBL headsets like what has been done [here](https://lore.kernel.org/alsa-devel/s5h4kb4m3ht.wl-tiwai@suse.de/T/). Although I'm in no way an expert in kernel or driver related matters, so take this with a grain of salt. I have tried tinkering with aliases in ``/etc/modprobe.d/alsa-base.conf`` but I seem to be too inexperienced to get it to do anything at all.

I am able to connect the headset via bluetooth, which works fine, but this results in noticeable quality loss and missing features (for example, the hardware volume slider can't be used on bluetooth connections). For now, I'm connecting it via bluetooth **and** the dongle, setting the bluetooth connection to output only via blueman, then assigning input streams to the mic from the dongle connection and output streams to the bluetooth connection (this way, I'm at least getting full audio quality on the mic). This is definitely not a viable long-term solution though.

And now, all the data:

**Relevant output from lsusb**
```
Bus 001 Device 007: ID 0ecb:2069 Harman International Inc JBL Quantum810 Wireless
```

**uname -r**
```
6.0.5-200.fc36.x86_64
```

**alsa-info.sh** (headset only connected via dongle here)
http://alsa-project.org/db/?f=db549be4f37c3c8617f567b1aaf26fd77c25e030

P.S.: I have done a full system update, tons of reboots, and the firmware on the headset is on the most recent version (installed Windows on a separate machine to get into the Quantum Engine software). In my desperation, I have even installed "alsa-*" via dnf.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/279
Repository URL: https://github.com/alsa-project/alsa-lib
