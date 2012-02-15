From: tilt <tilt@linuxfoo.de>
Subject: Re: snd_emu10k1 with E-MU 1616m PCIe
Date: Wed, 15 Feb 2012 01:42:03 +0100
Message-ID: <4F3AFF5B.60303@linuxfoo.de>
References: <4F3840FE.9090006@linuxfoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tk-sls.de (linuxfoo.de [91.204.170.65])
	by alsa0.perex.cz (Postfix) with ESMTP id 35B9B243ED
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 01:42:15 +0100 (CET)
Received: from [192.168.2.101] (pD9FA4E30.dip.t-dialin.net [217.250.78.48])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Tilman Kranz", Issuer "Tilman Kranz" (not verified))
	by mail.tk-sls.de (Postfix) with ESMTPS id CE095302C0
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2012 01:42:08 +0100 (CET)
In-Reply-To: <4F3840FE.9090006@linuxfoo.de>
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

Hello!

Myself wrote @ 02/12/2012 11:45 PM:
> [...]; so I wonder: should 
> /usr/local/lib/firmware/emu/micro_dock.fw not also be loaded? 
> [...]

I see there is a test in pci/emu10k1/emu10k1_main.c, line 735f:

   snd_emu1010_fpga_read(emu, EMU_HANA_OPTION_CARDS, &reg);
   if (reg & EMU_HANA_OPTION_DOCK_OFFLINE) {
      ... the following code is NOT executed on my hardware

The flag is defined in include/sound/emu10k1.h, line 1089:

   #define EMU_HANA_OPTION_DOCK_OFFLINE    0x08
      /* Audio Dock online and FPGA not configured */

However, if instead of the above I test for

   #define EMU_HANA_OPTION_DOCK_ONLINE     0x04
      /* Audio Dock online and FPGA configured */

the test succeeds.

Does this tell me that there is no need to load a dock firmware
on my hardware? After all, dock relais went online with an audible
click, dock exposes functionality, just a bit messy.

Kind regards,
Tilman.

P.S.: Will also start working with the emutrix group to get a
hold on the mixer names & routings. I hope I can get Phones L/R
configurable with existing driver
