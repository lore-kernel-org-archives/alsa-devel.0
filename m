From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: [PATCH] [RFC 1/13] Intel SST drivers documentation
Date: Tue, 7 Jul 2009 12:27:42 +0530
Message-ID: <98769532B4BB14429434178695419EAE5BBC2386@bgsmsx501.gar.corp.intel.com>
References: <1246604310-12812-1-git-send-email-vinod.koul@intel.com>
	<20090704120954.GA13988@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 02BE3246DD
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jul 2009 08:58:35 +0200 (CEST)
In-Reply-To: <20090704120954.GA13988@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
>Sent: Saturday, July 04, 2009 5:40 PM
>To: Koul, Vinod
>Cc: alsa-devel@alsa-project.org; Harsha, Priya
>Subject: Re: [alsa-devel] [PATCH] [RFC 1/13] Intel SST drivers
>documentation
>
>On Fri, Jul 03, 2009 at 12:28:30PM +0530, Vinod Koul wrote:
>
>> +There are 3 sound cards that Intel SST hardware supports and enables.
>> +Intel SST is the only hardware in the platform that can render to sound
>card.
>> +These sound cards are exposed and mapped through Intel MID driver which
>is an
>> +ALSA driver. This driver uses Intel SST driver to send data and controls
>to the
>> +hardware.
>
>Looking at the code I'm a bit confused about the way things are
>structured in hardware terms here.  Do you have any documentation (even
>fairly high level stuff) or what exactly a "vendor" is that you could
>refer to?  The reason I ask is that a lot of what's going on here sounds
>much like the typical embedded hardware supported by the ASoC framework
>in the kernel in which case I worry that these drivers may run into many
>of the issues which ASoC solves.

I shall mail in more details on how the hardware is structured soon. Since we posted the patches early in the game for comments, I would need to get the right hardware specific information that I can email here.
Vendor is basically one who is providing the sound cards for the platform. Each sound card is different and needs to handled differently. That's why we have 3 different hardware vendor abstraction files to handle them.
Can you guide on some points/issues that I need to proactively look at in my driver that is solved by ASoC?

>
>The bit that particularly jumps out at me is that what the vendor
>drivers are providing appears to be very much like an ASoC CODEC driver
>with bits of an ASoC machine driver.  They define register maps with
>register names that look very much like those I'd expect to see in audio
>CODECs, define some controls for those and do similar things in the
>various ALSA API callbacks they get.

The vendors don't provide driver. The vendor abstraction files are developed by Intel for the vendor specific sound cards.

>
>The main potential difference that I can see is that it looks like all
>the register access to the child devices is indirected via the DSP/PMIC,
>though it doesn't look like it's abstracted at all - it seems like it's
>just write through if it's anything.  Most embedded systems would have
>the CODECs hooked directly to the CPU.  It also looks like your vendor
>ID information is only 3 bits which seems very limited and makes me
>question my analysis.

The codec here is not hooked directly to the CPU and CPU cannot access the sound card directly. Only 3 vendors are supported by the platform and that is why the vendor id is 3 bits. All the sound card communication needs to be routed through DSP/PMIC.

>
>Like I say, I don't fully grasp how the hardware looks so I may be
>completely off-base here.
>
>> +To make use of the low power playback feature, the application or
>framework
>> +needs to open a Intel SST driver handle and send the encoded stream
>> +like MP3, AAC or WMA through this driver to play out. If its a PCM
>stream
>
>Just thinking back to my previous comment about the DSP possibly being
>general purpose - even if it is not possible to use this DSP for other
>things the offloaded media decode here is something that other devices
>support.  We should try to come up with a general purpose API for using
>this which isn't driver-specific so that applications are able to make
>use of the functionality without having to code up ways to talk to lots
>of different drivers.

Is the thought around adding new asound like API for encoded streams? So that the driver IOCTLs are called within the APIs? An internal effort is being taken in this lines to create a new lib file that exposes general APIs for handling encoded streams rather than application using IOCTLs directly. Please give your suggestions/ideas around this.

>
>For simplicity it may be best to arrange the patch series so that you've
>got a driver without the offloaded decode support and then build the
>offloaded decode support on top of that.  This should make it easier to
>review the more standard ALSA functionality and may help get that code
>in more quickly.

Thanks for the tip. The way the PCM streams and encoded streams are handled in DSP driver (Intel SST driver) are mostly the same. I am wondering how I could peal out the encoded interfaces alone. The intel_sst_interface.c file has the encoded interfaces exposed as well as interfaces exposed to ALSA for pcm streams. Rest of the files of intel_sst driver have the handling of the streams and they are pretty much the same for both the kinds of streams. I shall also add more explanations for every interface so that it's clear.

Thanks,
Harsha
