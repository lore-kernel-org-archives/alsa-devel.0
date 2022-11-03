Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC72C433FE
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Nov 2022 08:19:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2C011657;
	Fri,  4 Nov 2022 09:18:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2C011657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667549973;
	bh=gFrR/HZJVFnrzTPsnlsBz7pKq21Q9tONjun5QAgfrBM=;
	h=Date:From:To:In-Reply-To:References:Subject:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=eWSGWF46rU4sgpX0/XskEHky9zi3jdh91obj/KH415Z9RIYzId3CaUhC28P4GcJMg
	 pXYsZzbbBQpMGCfQ91V9DXQgBM1se7LoxSfRA5U1kAKSlw3OGtI+WxiCf68Tb14/d9
	 a0J46jqs1aX1VllkDHVJHvsJXxw61Z+2WYxz8N/A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 08B72F805A8;
	Fri,  4 Nov 2022 09:16:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 625A5F801D5; Thu,  3 Nov 2022 17:37:21 +0100 (CET)
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr
 [80.12.242.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 178BBF80155
 for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2022 17:37:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 178BBF80155
Received: from opme11oxm02aub.pom.fr.intraorange ([10.110.82.2])
 by smtp.orange.fr with ESMTP
 id qdDQoMDFB94emqdDQoFLjH; Thu, 03 Nov 2022 17:37:17 +0100
X-ME-Helo: opme11oxm02aub.pom.fr.intraorange
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Thu, 03 Nov 2022 17:37:17 +0100
X-ME-IP: 92.184.110.22
Date: Thu, 3 Nov 2022 17:37:16 +0100 (CET)
From: Jarzmik Robert <jarzmik.robert@orange.fr>
To: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 robert.jarzmik@free.fr
Message-ID: <803778517.2279639.1667493436959.JavaMail.open-xchange@opme11oxm02aub.pom.fr.intraorange>
In-Reply-To: <7d9eebc8-39b6-4dc1-9ffc-f17ec584bee2@app.fastmail.com>
References: <20221019161831.3864786-1-arnd@kernel.org>
 <m2r0z3h5yr.fsf@sopl295.home>
 <7d9eebc8-39b6-4dc1-9ffc-f17ec584bee2@app.fastmail.com>
Subject: Re: [PATCH 00/30] ARM: pxa: remove all unused boards&drivers
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.6.3-Rev65
X-Originating-IP: 92.184.110.22
X-Originating-Client: open-xchange-appsuite
X-Mailman-Approved-At: Fri, 04 Nov 2022 09:16:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, alsa-devel@alsa-project.org,
 dri-devel@lists.freedesktop.org, sre@kernel.org,
 Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mtd@lists.infradead.org,
 philipp.zabel@gmail.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 kernel@wantstofly.org, linux-leds@vger.kernel.org, linux-rtc@vger.kernel.org,
 Bartosz Golaszewski <brgl@bgdev.pl>, Lee Jones <lee@kernel.org>,
 Russell King <linux@armlinux.org.uk>, marek.vasut@gmail.com,
 Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org,
 slapin@ossfans.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 lost.distance@yahoo.com, Haojian Zhuang <haojian.zhuang@gmail.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Dominik Brodowski <linux@dominikbrodowski.net>, linux-fbdev@vger.kernel.org,
 tiwai@suse.com, linux-arm-kernel@lists.infradead.org,
 Felipe Balbi <balbi@kernel.org>, mkpetch@internode.on.net,
 Sergey Shtylyov <s.shtylyov@omp.ru>, linux-ide@vger.kernel.org,
 jingoohan1@gmail.com, linux-usb@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 lgirdwood@gmail.com, Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, patches@opensource.cirrus.com,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Daniel Mack <daniel@zonque.org>
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
Reply-To: Jarzmik Robert <jarzmik.robert@orange.fr>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

   I'm sorry Arnd, my mailer messed up again, and instead of using my
   normal [1]robert.jarzmik@free.fr, it used my ISP mail ...

   This answer will most probably look horrible, probably in html with no
   way of using plain text... sorry for that.

   The reason you're not seeing the AC97_BUS_NEW used is because this
   becomes visible only in device-tree files, which were posted (for
   mioa701 for example) but never properly reviewed nor merged.

   As from memory, at least mioa701, zylonite, em_x270 are DT ported, ie.
   there is a DT file which makes them boot. For the mioa701, the DT file
   offers the same functionnality, ie. all drivers in mioa701.c legacy
   file are working as well in a DT variant (not using mioa701.c
   obviously).

   > Any idea where I went wrong here? Did I make a mistake in following
   the Kconfig dependencies, or are some parts of this
   incorrectly annotated?

   I don't think you did a mistake, I think I did. When I saw the patch of
   "deprecation" of mioa701 and all the other pxa files, I took it that
   the platform-device was deprecated, and was to be removed. This is the
   right thing to do in my opinion. I wouldn't mind if all board file go
   actually (expect the QEMU one), as this would leave only the boards
   with proper DT support, and would remove some clutter from the kernel.

   I also thought the drivers won't get touched by the purge, exception
   made of "platform similar ones", such as in the sound tree
   (sound/soc/pxa) where we have some of them, and maybe mfd tree.

   Cheers.

   --

   Robert

References

   1. mailto:robert.jarzmik@free.fr,
