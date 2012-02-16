From: tilt <tilt@linuxfoo.de>
Subject: Re: snd_emu10k1 with E-MU 1616m PCIe
Date: Thu, 16 Feb 2012 20:52:29 +0100
Message-ID: <4F3D5E7D.6000701@linuxfoo.de>
References: <4F3840FE.9090006@linuxfoo.de> <4F3AFF5B.60303@linuxfoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tk-sls.de (linuxfoo.de [91.204.170.65])
	by alsa0.perex.cz (Postfix) with ESMTP id 1595E103F9A
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 20:52:33 +0100 (CET)
Received: from [192.168.2.101] (pD9FA5636.dip.t-dialin.net [217.250.86.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Tilman Kranz", Issuer "Tilman Kranz" (not verified))
	by mail.tk-sls.de (Postfix) with ESMTPS id A51C5302C0
	for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2012 20:52:32 +0100 (CET)
In-Reply-To: <4F3AFF5B.60303@linuxfoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Myself wrote on 02/15/2012 01:42 AM:
> [...] Does this tell me that there is no need to load a dock
> firmware on my hardware? After all, dock relais went online with an
> audible click, dock exposes functionality, just a bit messy.

I stand corrected, the firmware loads:

   ALSA emu10k1_main.c:739 emu1010: Loading Audio Dock Firmware
   ALSA emu10k1_main.c:686 firmware size = 0xd67c
   ALSA emu10k1_main.c:760 emu1010: EMU_HANA+DOCK_IRQ_STATUS = 0x18
   ALSA emu10k1_main.c:763 emu1010: EMU_HANA+DOCK_ID = 0x15
   ALSA emu10k1_main.c:769 emu1010: Audio Dock Firmware loaded
   ALSA emu10k1_main.c:773 Audio Dock ver: 4.2

Kind regards,
Tilman.
