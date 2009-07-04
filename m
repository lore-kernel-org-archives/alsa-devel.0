From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC 1/13] Intel SST drivers documentation
Date: Sat, 4 Jul 2009 13:09:54 +0100
Message-ID: <20090704120954.GA13988@sirena.org.uk>
References: <1246604310-12812-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A5216103802
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Jul 2009 14:09:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1246604310-12812-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Harsha Priya <priya.harsha@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 03, 2009 at 12:28:30PM +0530, Vinod Koul wrote:

> +There are 3 sound cards that Intel SST hardware supports and enables.
> +Intel SST is the only hardware in the platform that can render to sound card.
> +These sound cards are exposed and mapped through Intel MID driver which is an
> +ALSA driver. This driver uses Intel SST driver to send data and controls to the
> +hardware.

Looking at the code I'm a bit confused about the way things are
structured in hardware terms here.  Do you have any documentation (even
fairly high level stuff) or what exactly a "vendor" is that you could
refer to?  The reason I ask is that a lot of what's going on here sounds
much like the typical embedded hardware supported by the ASoC framework
in the kernel in which case I worry that these drivers may run into many
of the issues which ASoC solves.

The bit that particularly jumps out at me is that what the vendor
drivers are providing appears to be very much like an ASoC CODEC driver
with bits of an ASoC machine driver.  They define register maps with
register names that look very much like those I'd expect to see in audio
CODECs, define some controls for those and do similar things in the
various ALSA API callbacks they get.

The main potential difference that I can see is that it looks like all
the register access to the child devices is indirected via the DSP/PMIC,
though it doesn't look like it's abstracted at all - it seems like it's
just write through if it's anything.  Most embedded systems would have
the CODECs hooked directly to the CPU.  It also looks like your vendor
ID information is only 3 bits which seems very limited and makes me
question my analysis.

Like I say, I don't fully grasp how the hardware looks so I may be
completely off-base here.

> +To make use of the low power playback feature, the application or framework
> +needs to open a Intel SST driver handle and send the encoded stream
> +like MP3, AAC or WMA through this driver to play out. If its a PCM stream

Just thinking back to my previous comment about the DSP possibly being
general purpose - even if it is not possible to use this DSP for other
things the offloaded media decode here is something that other devices
support.  We should try to come up with a general purpose API for using
this which isn't driver-specific so that applications are able to make
use of the functionality without having to code up ways to talk to lots
of different drivers.

For simplicity it may be best to arrange the patch series so that you've
got a driver without the offloaded decode support and then build the
offloaded decode support on top of that.  This should make it easier to
review the more standard ALSA functionality and may help get that code
in more quickly.
