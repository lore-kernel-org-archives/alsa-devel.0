From: Susan Cragin <susancragin@earthlink.net>
Subject: possible regression in creative x-fi expresscard
Date: Sun, 15 Nov 2009 07:56:47 -0500 (GMT-05:00)
Message-ID: <21729889.1258289807110.JavaMail.root@mswamui-bichon.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-spurfowl.atl.sa.earthlink.net
	(elasmtp-spurfowl.atl.sa.earthlink.net [209.86.89.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 9468824385
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 13:56:48 +0100 (CET)
Received: from [209.86.224.26] (helo=mswamui-bichon.atl.sa.earthlink.net)
	by elasmtp-spurfowl.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <susancragin@earthlink.net>) id 1N9eet-0006RU-2P
	for alsa-devel@alsa-project.org; Sun, 15 Nov 2009 07:56:47 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Recently my Creative X-fi expresscard has stopped working properly. It may be an alsa problem but it may also be some sort of bus problem, and I thought I'd let you decide. 

I filed Ubuntu bug 462843, which describes it in detail, but basically here's what happens. 

Sound usually works when I start the computer. But when I close and re-open my application, sound has gone. 
At the same time, alsamixer shows the card properly. The settings are fine. Asoundconf shows that the card is still there and registered as the default.
sudo modprobe snd-hda-codec
sudo modprobe snd-hda-codec-ca0110
shows that either the modules are loaded correctly or are able to be re-loaded, but still no sound. 

I fix by removing and re-inserting the card, and then re-booting the computer.

This is for incoming (recorded) sound. I haven't checked the outgoing sound.

I have the current Ubuntu version of the drivers, and have not tinkered with them at all. I re-installed the whole system recently. I updated to Lucid hoping to get better updates but that did not help.

Here's everything interesting from dmesg|tail. 

[ 4.088837] sdhci-pci 0000:09:01.1: SDHCI controller found [1180:0822]
(rev 22)
[ 4.088853] sdhci-pci 0000:09:01.1: PCI INT B -> GSI 17 (level, low) ->
IRQ 17
[ 4.099720] mmc0: SDHCI controller on PCI [0000:09:01.1] using PIO
[ 4.233046] HDA Intel 0000:00:1b.0: PCI INT A -> GSI 22 (level, low) ->
IRQ 22
[ 4.235589] HDA Intel 0000:00:1b.0: setting latency timer to 64
[ 4.352945] HDA Intel 0000:05:00.0: PCI INT A -> GSI 18 (level, low) ->
IRQ 18
[ 4.500172] hda-intel: spurious response 0x0:0x0, last cmd=0x000000
[ 5.503012] hda-intel: azx_get_response timeout, switching to polling
mode: last cmd=0x101f0012
[ 6.505012] hda_intel: azx_get_response timeout, switching to single_cmd
mode: last cmd=0x101f0012
