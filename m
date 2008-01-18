From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Problems with ALC882
Date: Fri, 18 Jan 2008 09:21:47 -0800
Message-ID: <1200676907.5011.206.camel@razman.gruemaster.com>
References: <b6251a620801160920q327049ffifa72f77b17738f75@mail.gmail.com>
	<s5hzlv5r7yx.wl%tiwai@suse.de>
	<b6251a620801180810y6628debcxf9ff36de35514848@mail.gmail.com>
	<s5hve5rayvr.wl%tiwai@suse.de>
	<b6251a620801180850w492acd01v26a6648a710f5f0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F6F7245B8
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 18:21:49 +0100 (CET)
In-Reply-To: <b6251a620801180850w492acd01v26a6648a710f5f0d@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Christophe Osuna <christophe.osuna@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2008-01-18 at 17:50 +0100, Christophe Osuna wrote:

> 2008/1/18, Takashi Iwai <tiwai@suse.de>:
> > At Fri, 18 Jan 2008 17:10:06 +0100,
> > Christophe Osuna wrote:
> > >
> > > I have tried alsa-driver-hg20080117; it shows two additional mixer
> > > options (Mic Boost and Front Mic Boost) but in the end it's the
> same:
> > > I am unable to access the 3rd ADC.
> >
> > Looks like your board disables the third ADC.  The driver probes it
> > and the codec returns it's no audio-input widget.  Check codec#*
> proc
> > output.
> >
> 
> I have copied the contents of /proc/asound/card0/codec#2 at the end of
> this message. Notice that there are three nodes (0x07, 0x08 and 0x09)
> which claim to support PCM input.

Each of these three ADC's connect to their own selector nodes (22, 23,
24):

        Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
          Amp-In caps: ofs=0x08, nsteps=0x1f, stepsize=0x05, mute=1
          Amp-In vals:  [0x0f 0x0f]
          PCM:
            rates [0x160]: 44100 48000 96000  <-- these are the sample
        rates that the hardware can be set to
            bits [0x6]: 16 20
            formats [0x1]: PCM
          Connection: 1
             0x22  <-- this is the node that it connects to.
        

 These selector nodes are connected to all of the pins and one
connection to the mixer.  They are controlled by unmuting the individual
pin node connection:

        Node 0x22 [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
          Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
          Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x00 0x00] [0x80 0x80]
        [0x80
        0x80] [0x80 0x80] [0x80 0]
          Amp-Out caps: N/A
          Amp-Out vals:  [0x00 0x00]
          Connection: 11
             0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b

This is from your codec output.  Based on this, I can see that ADC Node
9 is connected to Audio Mixer Node 22, and that Node 22 is allowing
input from Pin Node 1A (Line In at Ext Rear).  Note that these aren't
volume controls, just mute/unmute (based on the Amp-In caps:

Now, the root of the problem is that the driver is currently not
configured to allow full range of the codec capabilities.  If it were,
you would have a mute button for each amp val on each node, and a big
mess trying to figure it out (at least without the codecgraph utility
from a different email thread).

I'm currently swamped with other projects at the moment, otherwise I
would try to implement a test model for that codec that would allow more
control capability.  It should be fairly easy to add an input selector
to control each of the adc mixers.


> 
> > > The ALC882 datasheet states that "3 stereo ADCs support 16/20-bit
> PCM
> > > format, two for microphone array, one for legacy mixer recording".
> > > This is the only place that suggests there could be a difference,
> but
> > > I do not understand this sentence as "only 2 ADC can be used at a
> > > time" (English is not my native language). The block diagram in
> the
> > > following page does not suggest such a limit either.
> >
> > The reality bites sometimes :)
> 
> I really want to believe this codec can do three things at a time.

Yes, it "should".  But it also depends on the physical wiring of your
system.  If you have a system with only 3 audio jacks in the back, it is
very difficult to have surround sound & 3 inputs at the same time.


> 
> > > Besides that I have read in the same datasheet that "rates in
> > > sub-multiples (1/n) of 48kHz are interleaving n frames containing
> no
> > > sample blocks" and so we can have 8 kHz by setting one sample
> block
> > > every six frames. Still, I can't set the device to 8 kHz.
> >
> > How did you test it?  The driver itself supports 8kHz, as long as
> the
> > codec chip really returns the capability.
> 
> The same nodes I mentionned above (0x07, 0x08 and 0x09 in
> /proc/asound/card0/codec#2) show no support for 8 kHz sample rate.
> This is confirmed by the failing calls to
> snd_pcm_hw_params_set_rate().
> 

The rate can only be set to what the codec supports.  The rest is
handled via software. (see above comment on Node 9)


> > Using two ALC882 codecs on the same HD-audio bus isn't supported
> right
> > now.  The second codec would conflict.  Dual audio codecs are not
> > impossible but it makes things complicated.
> 
> This is interesting information, thanks.
> 

Actually, what this is describing is two (or more) physical codec chips
on the same motherboard.  This is definitely possible (I have this setup
at home for development).  The biggest difficulty is getting the added
card configured for a different sdio port on the HDA bus.  Some of the
reference boards I have can be configured via jumpers, but some need a 0
ohm resister pulled and moved to a different pad (not an easy task for
me).

I have an Intel desktop motherboard with an HDA header on the main board
specifically for this purpose.  As long as the added codec is configured
for a different sdio, I'm good.  It is configured via the probe_mask
setting.

-- 
Tobin Davis  


"Why can't we ever attempt to solve a problem in this country without having
a 'War' on it?" -- Rich Thomson, talk.politics.misc
