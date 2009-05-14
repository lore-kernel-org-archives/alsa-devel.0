From: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Subject: Support for USB-Audio devices with Multiple
	configurations?
Date: Thu, 14 May 2009 16:32:20 +1000
Message-ID: <4A0BBAF4.6000108@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tone.orchestra.cse.unsw.EDU.AU (tone.orchestra.cse.unsw.EDU.AU
	[129.94.242.59]) by alsa0.perex.cz (Postfix) with ESMTP id 02A38244BF
	for <alsa-devel@alsa-project.org>;
	Thu, 14 May 2009 08:32:23 +0200 (CEST)
Received: From
	[192.168.0.201] ([58.160.58.5] == CPE-58-160-58-5.vic.bigpond.net.au)
	(auth-user camerons) (cse-authentic-sender camerons)
	(for <alsa-devel@alsa-project.org>) By tone With Smtp ;
	Thu, 14 May 2009 16:32:22 +1000
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

I'm writing some firmware for a USB microphone array with multiple
configurations, and I'm wondering if it's possible to tell ALSA which
configuration to use in a module option or something (device_setup,
perhaps).

I've been looking through usbaudio.c in the kernel source
(2.6.28-11-generic from the ubuntu Jaunty package), and I can't find any
generic device configuration like that.

If this is not possible, does anyone have any recommendations on how to
implement this? I can imagine doing it using quirks for this particular
USB_ID, but this seems like a fairly generic type of capability, so I'd
like to make it general if possible.

If anyone is wondering *why* I want multiple configurations: it's for
bandwidth management. I have 8 channels, but I want to be able to sample
1 channel as fast as possible without wasting bandwidth on the other 7.
I couldn't figure out a way to do that with a single configurations.
Please let me know if you know one. ;-)

Thanks,
	Cameron.
