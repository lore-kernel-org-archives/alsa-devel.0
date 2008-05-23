From: Charles Eidsness <charles.eidsness@ieee.org>
Subject: USB Data Dropping
Date: Fri, 23 May 2008 11:42:53 -0400
Message-ID: <4836E5FD.1080507@ieee.org>
References: <48353DEE.1020502@atmel.com> <48355305.1090808@ladisch.de>
	<4836D447.5030903@atmel.com>
Reply-To: charles.eidsness@ieee.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp118.rog.mail.re2.yahoo.com (smtp118.rog.mail.re2.yahoo.com
	[68.142.225.234]) by alsa0.perex.cz (Postfix) with SMTP id 97A8124668
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 17:43:14 +0200 (CEST)
In-Reply-To: <4836D447.5030903@atmel.com>
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

Hi All,

I'm developing a USB DAC and I've ran into an issue that has me scratching my 
head. Every once in a while (30 seconds or so) my USB DAC gets sent a USB frame 
that's missing a few samples, unless I'm also streaming audio through my 
laptop's built-in audio interface, i.e. playing audio through my USB DAC alone 
and I get dropped data, playing audio through my USB DAC and the built-in audio 
device at the same time (unique streams to each device) and I get no dropped 
data to my USB DAC. Once I stop playing audio on the built-in device I start 
getting dropped data to my USB DAC again.

The USB DAC is using the standard USB Audio drivers, and the built-in device is 
an RealTek ALC880 HDA device connected through an Intel 82801. I'm guessing that 
the hda driver is configuring some global parameter when it's in active playback 
mode that the USB driver should maybe also be setting. Any ideas? I've already 
played around with lspci (the USB interface on my laptop is PCI based) but can't 
see any differences in PCI configuration between when I'm playing audio on the 
biult-in device and when I'm not.

Thanks!
Charles
