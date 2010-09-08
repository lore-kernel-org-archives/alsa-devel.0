From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Wed, 8 Sep 2010 10:47:19 +0100
Message-ID: <20100908094719.GD31253@rakim.wolfsonmicro.main>
References: <1282728400.2991.114.camel@odin>
	<alpine.LNX.2.00.1008251128140.10278@eeebox2.perex-int.cz>
	<1282732983.2991.161.camel@odin>
	<alpine.LNX.2.00.1008251831330.10278@eeebox2.perex-int.cz>
	<1283864698.3048.26.camel@odin>
	<alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<20100907155355.GE25830@sirena.org.uk>
	<alpine.LNX.2.00.1009072001580.10278@eeebox2.perex-int.cz>
	<20100907185358.GA1125@rakim.wolfsonmicro.main>
	<alpine.LNX.2.00.1009080934380.10278@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0B97D2444A
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Sep 2010 11:47:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1009080934380.10278@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 08, 2010 at 09:54:50AM +0200, Jaroslav Kysela wrote:
> On Tue, 7 Sep 2010, Mark Brown wrote:

> >Currently outside of the explict sequences provided to override the
> >default transitions the use case manager configurations are declarative
> >rather than ordering based.  This lets the user specify end states and
> >lets the use case manager code work out the best way to accomplish those
> >configurations which seems like a valuable property.

> I don't see any difference here. I checked the Liam's code and there
> is no intelligence regarding the ALSA controls API. The sequences

Right, just now it's not doing anything because at the minute we don't
have much option but it does mean that the control format doesn't lock
us into this and allows room for expansion.

> are just processed in the serialized way and they must be (for
> example to satisfy the time delay requirements between control
> writes).

I'd really expect the driver to be finiessing stuff.

> Note that my proposal is just extension. It's like difference
> between full desktop system and a small optimized system (for
> example for small wireless hardware platforms). There are many

See below.

> My motivation is to make UCM useable also for the desktop systems.
> In this environment might be useful to send external events to
> another layers when an app requests specific audio device. For
> example, HDMI is connected with the video link so the X11 server
> might be notified about this request.

Right, but the expectation is that the system management service which
is driving UCM will able to also drive other subsysems, and it's not
entirely obvious that the audio use case selection should drive too
much non-audio stuff directly.

This and some of your other comments make me concerned that you aren't
aware of the complexity of the audio subsystems on high end embedded
devices like smartphones.  Things like the video use case you describe
above are not at all unusual for smartphones - I actually currently have
a smartphone sitting plugged into my AV system at home and able to
deliver audio and video to it (though only with composite).

A modern smartphone can have multiple independant independantly
routeable audio streams between the CPU and primary audio CODEC, plus
separate digital audio streams between the CODEC and the cellular modem
and bluetooth.  There will be headphones, an earpiece speaker, possibly
one or more separate music/speakerphone speakers, at least one on-board
microphone and a headset microphone.  Add on to this a separate audio
CODEC for HDMI, A2DP, and accessory handling (including stuff like
muxing composite video out onto the same jack pins used for headset
microphone) and you've got a very flexible system.

When thinking about these issues it is generally safe to assume that
embedded systems can have software that's at least as complex as that on
PC class hardware.  I would be very surprised if a software model which
meets the needs of complex embedded systems is not also capable of doing
everything a desktop needs.
