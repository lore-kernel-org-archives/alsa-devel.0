From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 20 Apr 2008 03:01:17 +0200
Message-ID: <20080420010116.GA22033@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<48010E62.2020404@keyaccess.nl>
	<20080414170022.GH22115@tango.0pointer.de>
	<480392F3.9030701@keyaccess.nl>
	<20080414172839.GA26513@tango.0pointer.de>
	<4803C78A.3020109@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 67E9F24334
	for <alsa-devel@alsa-project.org>;
	Sun, 20 Apr 2008 03:01:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4803C78A.3020109@superbug.co.uk>
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

On Mon, 14.04.08 22:07, James Courtier-Dutton (James@superbug.co.uk) wrote:

> 
> Lennart Poettering wrote:
> > 
> > Yes, but what I am asking for is to define the dB values of the master
> > control relative to the some ref level on this line-out. What happens
> > after the line-out doesn't matter at all.
> > 
> > Lennart
> > 
> 
> The aim of the dB values in the ALSA mixer is this.
> 
> For Playback:
> Set all the mixer controls to 0dB.
> Send a sample digital signal from the CPU to the sound card.
> The measured analog signal on the line-out should be the same for ALL 
> sound cards.
> 
> For Capture:
> Set all the mixer controls to 0dB.
> Send a sample analog signal to the line-in of the sound card.
> The captured digital signal at the CPU should be the same for ALL sound 
> cards.
> 
> The reason for using 0dB is that it should mean no gain and no 
> attenuation to the signal and so minimize distortions.

Hmm, my interpretation of the whole discussion is that while this
might be what you had in mind when designing the interface this is not
how drivers implemented it because hardware doesn't provide this
information in most cases.

The dB values exported by ALSA right now seem to be relative to zero
gain -- at least for some devices and mixer tracks. For the remaining
cases it is relative to maximum gain. There's currently no way to
figure out from the ALSA API which case it is for a local setup.

It would of course be great if each ALSA mixer control would also
export the voltage (dBu) to which 0dB refers. However this information
is probably only available in the specs of very little hardware (and
if at all only on pro hw which doesn't really matter for what I try to
do), and would require some non-trivial amount of testing with
metering hardware and stuff for the others. Also, for devices like USB
speakers voltages don't make any sense anyway since audio leaves those
speakers only acoustically. Hence, relying on dBu info exported by
ALSA is not really an option for me. It would be incomplete,
unreliable and a thing of the future if at all.

So, what does this mean for the task I initially wanted to get done,
i.e. to find some way to initialize mixers properly so that they are
not fully unmuted? Nothing good. It probably makes sense to initialize
mixer tracks that are not the "last" one in the chain to 0dB, but
initializing the last one (i.e Master) unconditionally to 0dB seems to
be a bad idea. However, under the assumption the mixer slider does not
directly control a 1000W amplifier it is probably OK to initialize it
to something like -47dB or lower. That should be good enough so that
people hear at least something on many setups and then take the fact
that it might be too low in volume as a suggestion to turn the volume
up. It's better than total silence, and way better than the tool that
Fedora currently ships which unconditionally initializes the volume of
all previously-unseen hardware to 75% of the integer scale, for
whatever that may be.

And again, what I am trying to do is not relevant at all for pro audio
people. My focus is desktop audio. So please, complains that setting
the default values of the mixers to anything that is not -inf dB might
trash your pro audio equipment are not applicable right now.

Any complaints? Or can we end this dicussion with this summary of my
plans?

If my interpretation of the status quo of what dB values are relative
to is correct, may I suggest adding this to the ALSA docs, to make
this clear for the next poor sould who wants to make sense of this?

Thanks,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
