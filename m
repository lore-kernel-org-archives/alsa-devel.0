From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Thoughts on ASOC v2 driver architecture
Date: Sun, 15 Jun 2008 14:10:39 -0400
Message-ID: <9e4733910806151110y13f171dct3948a1555608c0ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 981F02438B
	for <alsa-devel@alsa-project.org>;
	Sun, 15 Jun 2008 20:10:41 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so2513176ywk.2
	for <alsa-devel@alsa-project.org>; Sun, 15 Jun 2008 11:10:40 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm trying to sort out an architecture that will let all of the code
used in my ASOC drivers to be automatically loaded by the kernel.  So
if I'm confused and have some of this wrong please explain where I've
gone astray.

First, what are the physical hardware devices present? From the device
tree it says I have two i2s controllers each with an i2c controlled
codec. It also says I have a system wide DMA controller. And finally
there is the "fabric" which represent the specific pcb (populated
jacks, etc) used by the system (the root of the device tree).

Upon booting the kernel it will find the five open firmware devices
(two i2s, two codecs, one DMA) and load the appropriate of drivers for
them. Note that this is the system wide DMA driver, not the ASOC one.
Three drivers will be loaded and five devices will be created.

The codec devices will each register one codec and multiple codec
DAIs. Each i2c channel will register a platform_dai.

The next part, the platform device,  is where I'm having trouble. Why
is the DMA subsystem in it's own ASOC device? I already have a
separate system wide device for my DMA hardware.  Looking at the
implementations of a couple of the ASOC DMA drivers, there is nothing
global about the driver, everything is done with per channel
instances.

Should the DMA code instead simply be a library that is linked to by
the i2s drivers? And then move the entry points registered by the DMA
driver up into the platform_dai? It seems to me like implementation of
the DMA code should be a private matter for the platform_dai/i2s
driver. Note that I'm not saying that there shouldn't be modularized
ASOC DMA code, instead, why should ASOC be aware of this shared code?
To see if this model would work I tried to visualize a system where
one i2s controller is using DMA and the second is doing programmed IO.

So if the DMA API is pushed into the platform_dai that would free up
the platform device. It could then be used to support the fabric code
(fabric is the motherboard specific bits of code). It should probably
be renamed to the machine device instead of platform device. To handle
the case of HDA not needing a fabric driver,  ASOC would have a
default internal machine driver that a fabric driver could override.
This also implies that the fabric driver can't be the last driver
registered with ASOC.

There would be one global fabric driver, but it would get called on a
per instance basis. You could implement (made up scenarios)  two amps
on the motherboard and only enough power to turn one of them on. Or
maybe a front panel switch that switches which channel the front panel
controls act on.

I'd end up with this object model

generic machine (optional machine specific fabric override)
    platform i2s (platform_dai, soc_snd_card)
        generic codec (choice of codec dai)
    platform i2s (platform_dai, soc_snd_card)
        generic codec (choice of codec dai)

The platform specific i2s drivers are linked to a shared library of
platform DMA code.

-- 
Jon Smirl
jonsmirl@gmail.com
