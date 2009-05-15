From: Cameron Stone <camerons.lists@cse.unsw.edu.au>
Subject: Re: Support for USB-Audio devices with Multiple
	configurations?
Date: Fri, 15 May 2009 18:50:15 +1000
Message-ID: <4A0D2CC7.7000408@cse.unsw.edu.au>
References: <4A0BBAF4.6000108@cse.unsw.edu.au> <4A0D14BD.1050002@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU
	[129.94.242.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DDE8C103976
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 10:50:26 +0200 (CEST)
In-Reply-To: <4A0D14BD.1050002@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Cameron Stone wrote:
>> I'm writing some firmware for a USB microphone array with multiple
>> configurations, and I'm wondering if it's possible to tell ALSA which
>> configuration to use in a module option or something (device_setup,
>> perhaps).
>>
>> I've been looking through usbaudio.c in the kernel source
>> (2.6.28-11-generic from the ubuntu Jaunty package), and I can't find any
>> generic device configuration like that.
>>
>> If this is not possible, does anyone have any recommendations on how to
>> implement this? I can imagine doing it using quirks for this particular
>> USB_ID, but this seems like a fairly generic type of capability, so I'd
>> like to make it general if possible.
> 
> While the USB specifications define configurations, there is no generic
> way how a driver could automatically determine which configuration to
> use.

I was thinking in terms of a module parameter that would be set if a
configuration other than the default (first) configuration was desired.
Could that work?

>> If anyone is wondering *why* I want multiple configurations: it's for
>> bandwidth management. I have 8 channels, but I want to be able to sample
>> 1 channel as fast as possible without wasting bandwidth on the other 7.
>> I couldn't figure out a way to do that with a single configurations.
> 
> Bandwidth management is implemented by having multiple alternate
> settings for the audio streaming interface.  (This is why alternate
> setting zero must have no endpoint or a zero-sized endpoint, so that
> in the default case, the interface does not use any bandwidth.)

Is it possible to have alternate settings with different numbers of
channels? I can see how I could easily en/disable the channels in the
firmware, but I can't see how to inform the driver that the number of
channels has changed.

Thanks,
	Cameron.
