From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA firewire kernel branch: snd_dice enhancements
Date: Wed, 02 Nov 2011 21:19:52 +0100
Message-ID: <4EB1A5E8.1070508@ladisch.de>
References: <FC670913-F529-4E9B-8BB8-151227FA463E@weiss.ch>
	<4EB19174.5030107@weiss.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id E562124474
	for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2011 21:20:03 +0100 (CET)
In-Reply-To: <4EB19174.5030107@weiss.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rolf Anderegg <rolf.anderegg@weiss.ch>
Cc: Uli Franke <uli.franke@weiss.ch>, Brian Karr <briank@tctechnologies.tc>, alsa-devel <alsa-devel@alsa-project.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, ffado-devel <ffado-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Rolf Anderegg wrote:
> I recently stumbled upon your alsa-kernel branch (firewire-kernel-streaming:
> http://git.alsa-project.org/?p=alsa-kprivate.git;a=shortlog;h=firewire-kernel-streaming)
> and have finally found the time to play around with it. First of all I was
> impressed to see that it easily worked in conjunction with our DICE-based
> devices, even in high samplerate mode (>96kHz), provided that the clockselection
> of the DICE had been done beforehand via TCAT's drivers.

This driver is intended to be used with some kind of control panel that
handles device configuration.  As long as such a tool does not exist,
one has to manage with this:
http://www.alsa-project.org/~clemens/not-the-dice-control-panel.c

> To get samplerate switching working via ALSA's driver API I have made
> a few changes, especially within the dice_hw_params callback method.
> Plus, I enhanced the rate constraints for the pcm settings.

On the DICE, the playback and capture streams must use a common rate, so
I thought I'd avoid handling this in the driver and just use whatever
was configured.

Do you have a requirement that the sample rate must be selected
automatically, instead of being configured with a control panel or with
a CLI tool like amixer?

> I hope that some of these enhancements will make it to your alsa-kernel branch,
> if not even to the 3.x kernel tree (is this being considered for the near future?).

This branch will land in the kernel when it's reasonably complete.

> I am happy to say that this solution will fit our needs for the time being,
> while we still have not given up on FFADO as a longterm alternative,

The plan is for this kernel driver to replace FFADO's streaming
component.

> I noticed that amdtp_out_stream offers support for "dualwire"
> streaming at high rates, which is applied for dice's stream. Has this
> already been considered in FFADO?

Not by anyone who understands the FFADO internals and has the time.

> 1.) wait for NOTIFY_CLOCK_ACCEPTED notification bit after writing
> GLOBAL_CLOCK_SELECT within dice_hw_params. For the time being I introduced a
> "childish" msleep(500) in order for DICE to potentially switch its ratemode
> before starting the stream. I didn't quite figure out how to wait/poll for a
> particular notification. Do you have a hint how this would be done (using hwdep)?

The hwdep thing is intended for userspace; I'd add something like
a struct completion to be triggered from dice_notification().

> 2.) support DICE capture streams

I'm working on this right now (modulo the amount of time available).

> 3.) DICE clock source (CLOCK_SOURCE_*) selectable via ALSA driver API; how could
> this be done?

If not done by a control panel, this could be done with a mixer control.
This is not yet implemented because any clock source except ARX*
requires synchronization from the capture stream.

> I have changed the default clock source to INTERNAL, since I was
> experiencing "slips" with ARX1; as far as I know ARX1/2 is reasonably applicable
> only if there is another clock sync master on the Firewire bus.

The timing of the stream from the computer to the DICE is synthesized
according to the rules in the AMDTP spec (I hope); this was originally
written for devices based on the OXFW970 chip.  (It's synchronized to
the FireWire bus clock.)  It's possible that DICE devices want to use
a different value for the transfer delay or some other timing parameter;
a stream whose timing is derived from another DICE's capture stream
would have whatever timing is required.

ARX1 appears to work fine with my DesktopKonnekt6, but I've never looked
at the error counters.


Regards,
Clemens
