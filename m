From: tilt <tilt@linuxfoo.de>
Subject: snd_emu10k1 with E-MU 1616m PCIe
Date: Sun, 12 Feb 2012 23:45:18 +0100
Message-ID: <4F3840FE.9090006@linuxfoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tk-sls.de (linuxfoo.de [91.204.170.65])
	by alsa0.perex.cz (Postfix) with ESMTP id A4AC9103B27
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 23:45:31 +0100 (CET)
Received: from [192.168.2.101] (pD9FA4AC7.dip.t-dialin.net [217.250.74.199])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Tilman Kranz", Issuer "Tilman Kranz" (not verified))
	by mail.tk-sls.de (Postfix) with ESMTPS id 2955F3080D
	for <alsa-devel@alsa-project.org>; Sun, 12 Feb 2012 23:45:22 +0100 (CET)
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

I use the Creative E-MU 1616m PCIe:

   03:04.0 Multimedia audio controller: Creative Labs SB0400 Audigy2 Value
           Subsystem: Creative Labs Device 4007

I am on Linux kernel 3.2.4, -driver and -firmware from git;
-utils from 1.0.24.2-5 (Debian amd_64).

I have manually applied the patch from [1] and initialized
the device successfully:

[    3.387211] snd_emu10k1 0000:03:04.0: PCI INT A -> GSI 16 (level,
low) -> IRQ 16
[    3.387341] ALSA emu10k1_main.c:823 emu1010: Special config.
[    3.387479] ALSA emu10k1_main.c:862 emu1010: EMU_HANA_ID = 0x3f
[    3.387530] ALSA emu10k1_main.c:881 emu1010: filename emu/emu1010b.fw
testing
[    3.393206] ALSA emu10k1_main.c:686 firmware size = 0x11bdc
[    6.294376] ALSA emu10k1_main.c:898 emu1010: Hana Firmware loaded
[    6.294475] ALSA emu10k1_main.c:901 emu1010: Hana version: 1.6
[    6.294583] ALSA emu10k1_main.c:906 emu1010: Card options = 0x8
[    6.294656] ALSA emu10k1_main.c:908 emu1010: Card options = 0x8
[    6.295222] ALSA emu10k1_main.c:947 emu1010: Card options3 = 0x8
[    6.314806] ALSA emu10k1_main.c:227 Audigy2 value: Special config.
[    6.315231] ALSA emufx.c:1545 EMU outputs on
[    6.315280] ALSA emufx.c:1593 EMU2 inputs on

There are irregularities & limitations, but I do have 48kHz
capture and playback.

I have two questions:

1.: I only use Dock ports, and I notice many irregularities in
DAC and ADC assignment; so I wonder: should

   /usr/local/lib/firmware/emu/micro_dock.fw

not also be loaded?

2.: I use JACK with

   input: hw:0,2 (Mutichannel Capture/PT Playback)
   output: hw:0,3 (Multichannel Playback)

One thing that I would like to fix if at all possible: I can not assign
anything
to Dock Phones L/R; instead they always repeat Dock DAC 1L/R, no matter
what I route there.

Is this a limitation of the firmware, or are the controls misleading me?

Kind regards & thanks in advance for any suggestions,
Tilman.

[1] ALSA bugtracking system
     0005250: E-MU 1010 PCI-Express not recognized
     https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5250
