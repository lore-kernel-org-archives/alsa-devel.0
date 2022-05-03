Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61FD2C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  3 May 2022 20:30:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B340210E;
	Tue,  3 May 2022 22:29:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B340210E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651609827;
	bh=vWzGAOYGDkprpmK5bHByNIBdBK2MEJVkayTYkMqbGt4=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uGG0s9L0xALgr4HgfwTxLfx6YH10uMccgwxweQ3Pnsr/C2JSbykdm6VeWT6XFxGLq
	 rp0a679mVneXgVKFPGVxggtIps6oK1IF51WiM1VLMZSltG5H60y51qGa/5+H21i+MH
	 jkPeitb2nFegPN5Ggk1tlRbWU/cpuHlmJJO1ec9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 59909F80158;
	Tue,  3 May 2022 22:29:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34247F80236; Tue,  3 May 2022 22:29:35 +0200 (CEST)
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 48477F80129
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2022 22:29:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48477F80129
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
From: GitHub issues - opened <github@alsa-project.org>
To: alsa-devel@alsa-project.org
In-Reply-To: <1651609767364916086-webhooks-bot@alsa-project.org>
References: <1651609767364916086-webhooks-bot@alsa-project.org>
Subject: Arch Linux Alsa Driver mic misconfigured 0000:00:1f.3
Message-Id: <20220503202935.34247F80236@alsa1.perex.cz>
Date: Tue,  3 May 2022 22:29:35 +0200 (CEST)
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

alsa-project/alsa-firmware issue #6 was opened from WalterSmuts:

Hi,

I have a `Xiaomi Mi Laptop Pro X 15` running arch linux and the `pulseaudio-alsa` package seems to make sound work out of the box. Unfortunately it doesn't configure the mic properly. Attempting on a ubuntu live-usb I found the mic working. I ran the info script for both OS's (see below). My interpretation of the info dumped by the script is that ubuntu loads the `sof-audio-pci` drivers and arch linux seems to load some other intel drivers. Looking through the [arch wiki](https://wiki.archlinux.org/title/Advanced_Linux_Sound_Architecture#ALSA_firmware) I see reference to some newer laptops requiring the sof drivers:

> [sof-firmware](https://archlinux.org/packages/?name=sof-firmware) and/or [alsa-ucm-conf](https://archlinux.org/packages/?name=alsa-ucm-conf) are required for some newer laptop models (mainly since 2019) because they implement their drivers with firmware provided by the [Sound Open Firmware](https://www.sofproject.org/) project.

So installing the `sof-firmware` package and restarting the laptop unfortunately still does not fix my issue. Looks to me like the old drivers are still taking preference.

Can someone guide me in the right direction here?

* [Working Ubuntu Info](http://alsa-project.org/db/?f=e66f34b60915348fa835bdde9e849119e1031651)
* [Non-working Arch Info](http://alsa-project.org/db/?f=1a4c03f9abd116c5a0b149e51e436f004fa20228)

Issue URL     : https://github.com/alsa-project/alsa-firmware/issues/6
Repository URL: https://github.com/alsa-project/alsa-firmware
