From: Daniel Mack <daniel@caiaq.de>
Subject: Re: Problem with USB Class 2 Audio Driver
Date: Sat, 21 Aug 2010 11:27:00 +0200
Message-ID: <20100821092700.GS17833@buzzloop.caiaq.de>
References: <054801cb40c9$70349710$509dc530$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A10A1037EC
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Aug 2010 11:27:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <054801cb40c9$70349710$509dc530$@com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Demian Martin <demianm_1@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 20, 2010 at 05:40:22PM -0700, Demian Martin wrote:
> I'm testing an early sample of the Wavelength Wavelink, a USB to S/PDIF
> adapter that supports 44.1-192 KHz sample rates and uses async usb to talk
> to ALSA. It works and plays all of the sample rates correctly with the git
> version of Alsa from 7/30/2010 whenthe files are sourced from the network.

What do you mean by "from the network"? How does your test setup look
like?

> However if I try to play from a usb source to the usb dac it doesn't work
> and the whole system gets unstable. 

You could also be more precise here :) What doesn't work, how are you
testing, and in which regard does the system get unstable?

> The platforms I have tested it on seem
> to have a single USB host interface but with USB 2 there should be enough
> bandwidth to pass the data from a USB stick to the cpu and back. If I use an
> older 96 only usb dac on the same system it works (unless the down
> conversion isn't a direct divide, which overloads the CPU, but that is a
> different issue). The problem seems to be sample rate independent and hits
> the moment I try to access the file. This is using MPD as a player.

Ah, so your data file is stored on a media which is also connected to
USB? Did you connect the two devices to different USB ports or do they
share one uplink with a hub?

> What additional info do you need to troubleshoot this? Is it an intrinsic
> limitation to the interface? What additional tests should I do? It's
> possible it's a hardware issue but how do I divide them so I can go back to
> the hardware guy if it's his issue? 

I'm not aware of any limitation, but there could be such issues as
exceeded bandwith on the bus and the like. How many audio channels are
we talking about?

You could measure the speed of your USB media by using something like
this:

	$ time dd if=/path/to/192khz.file of=/dev/null

This should take significantly less time than - let's say - half the
real-time audio playback time of the file, so there's enough headroom to
transport the audio data back to the USB DAC.

What kind of system is this, after all? Did you try other OS on the same
hardware for comparsion?


Daniel
