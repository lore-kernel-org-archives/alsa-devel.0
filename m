From: Daniel Mack <daniel@zonque.org>
Subject: Re: usb-usx2y: playback fails with Tascam US122 on
 kernel 3.14
Date: Wed, 06 Aug 2014 19:19:22 +0200
Message-ID: <53E2639A.4070506@zonque.org>
References: <4546801.Z4WD7yaEHq@arial> <1799623.GgHbzoqWFu@arial>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 57E3D261691
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 19:19:26 +0200 (CEST)
In-Reply-To: <1799623.GgHbzoqWFu@arial>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dr Nicholas J Bailey <nicholas.bailey@glasgow.ac.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/06/2014 06:43 PM, Dr Nicholas J Bailey wrote:
> On Thursday 26 June 2014 15:51:54 Dr Nicholas J Bailey wrote:
>> I am having trouble with the US122 in playback and duplex mode. In capture
>> mode, it is working.
>>
>> This problem occurs on (at least)
>> Linux arial 3.14-1-686-pae #1 SMP Debian 3.14.7-1 (2014-06-16) i686
>> GNU/Linux
>>
> Further information:
> 
> Using this kernel:
> 
> Linux arial 3.14-2-686-pae #1 SMP Debian 3.14.13-2 (2014-07-24) i686 GNU/Linux
> 
> trying to use the US-122 Tascam box results in the following showing up in 
> dmesg. I have unplugged and reconnected the box twice to get the LEDs to light 
> up. This has been the normal behaviour for as long as I can remember. You can 
> only use the Tascam as capture device on this kernel.
> 
> Using this kernel:
> 
> Linux arial 3.10.11 #1 SMP Wed Oct 2 19:26:59 BST 2013 i686 GNU/Linux
> 
> the US-122 works fine for simultaneous capture and playback.
> 
> I've looked at the difference in the source code between 3.10 and 4.14 and 
> there is very little in the usb-usx2y alsa module. Is there some midi-related 
> change I should know about?

This driver is unfortunately poorly supported by the community. Very few
people have such a device, the driver has ample areas it needs cleanups
in, and the original author is unfortunately unresponsive.

The best thing you can do is probably bisect the issue:

  https://wiki.ubuntu.com/Kernel/KernelBisection

> I understand that the US-122 is a usb-1.1 device and I have the ehci module 
> loaded, but it was there too with the older kernel and that worked fine.

Yes, that shouldn't be an issue. Let us know what the bisection tells you.


Daniel
