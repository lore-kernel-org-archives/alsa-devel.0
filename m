From: Joshua Haberman <joshua@haberman.com>
Subject: Re: PCM API questions
Date: Tue, 25 Jun 2002 00:11:20 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020625071119.GC15056@reverberate.org>
References: <20020623034119.GE26642@reverberate.org> <s5hr8iw97h0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hr8iw97h0.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

* Takashi Iwai (tiwai@suse.de) wrote:
> > Hello all!
> > 
> > I am writing a PortAudio implementation for ALSA.  PortAudio is designed
> > to present a single API that cross-platform applications can use on many
> > different platforms.
> > 
> > I have some questions I hope you can answer for me.
> > 
> > 1.  Is there any reason to choose anything other than mmap mode for
> > transfer?  Are there some cards that don't support it?
>  
> yes.  some devices don't support.
> however you can specify the mmap-emulation mode on asoundrc, hence
> mmap mode will be able to work on every device.

Hmm, is there any way to request mmap emulation without touching
~/.asoundrc?  Ideally PortAudio will be able to use any device
transparently (without requiring special configuration).  Also ideally I
will only have to implement one transfer mode. :-)

> > 2.  How is device selection designed to work with ALSA?  My experience
> > with ALSA has been very confusing in this regard.  I recall reading at
> > least once that ALSA is not designed to have applications enumerate all
> > the devices; that the correct way is to use ~/.asoundrc to define a
> > hardware device and then supply that name to applications.  But is there
> > anything more sophisticated an application can do than to just present
> > the user with a text box?
> 
> the pcm name really depends on the driver implementation.
> usually, device #0 is provided for general use.  but, for example, the
> implementation of 4-channel sound is driver speicific.
> some driver implements using a control switch and other combines
> multiple pcm streams, etc.

Why such non-uniformity?  Isn't part of the goal of an audio API to
abstract the difference between specific sound cards so that different
cards with similar features can be treated identically?

> however, there are standard names, too:
> default, front, rear, center_lfe, surround40, surround51, spdif and
> iec958 (identical with spdif).

How are these configured?  Do they automatically use the first card?

> > 3.  I'm not sure how to approach the latency-related software and
> > hardware parameters.  PortAudio will soon be able to run in either
> > callback mode or blocking mode, and it is intended that the user be able
> > to provide hints to the implementation about what kind of latency it
> > wants.
> > 
> > The mechanism for setting latency in PortAudio is in a state of flux, but
> > at the moment the PortAudio implementation is provided with these
> > parameters:
> > 
> >     framesPerCallback -- max number of frames to pass to the user callback,
> >         when running in callback mode
> >     numberOfBuffers
> >     latencyInFrames
> > 
> > These are only guidelines to the driver, not commands, but I'd still like
> > to do the best possible approximation.  I'm thinking of doing something
> > like this:
> > 
> >     snd_pcm_hw_params_set_period_time( MIN(latencyInFrames, framesPerCallback) )
> >     snd_pcm_hw_params_set_periods( numberOfBuffers )
> >     /* buffer size is implicit from the above two */
> 
> this should work, although snd_pcm_hw_params_set_period_time_near()
> would be better to ensure the driver works.  the available
> period/buffer size is dependent on the chip.  *_near() function probes
> the nearest possibility.  you then need to reconfirm the approved
> period/buffer sizes.  the similar thing will be necessary for sample
> rates.

I see, thanks for the tip.

> just a question - is it necessary to provide both latencyInFrames and
> framesPerCallback?

As I understand it, framesPerCallback is just that, a number affecting
only how the callback is invoked.  If it is less than latencyInFrames,
the callback is called multiple times for each buffer sent to the
hardware.

Like I said, the latency-configuration mechanism is being redesigned at
the moment.  If you have an idea for a more precise and/or useful way to
specify latency, please let me know and I'll pass it on!

> >     snd_pcm_sw_params_set_avail_min( MIN(latencyInFrames, framesPerCallback) )
> > 
> > As you can probably tell, I'm murky on the interaction between the
> > avail_min software parameter and the period_time hardware parameter.
> > Clarifications welcome.  :-)
> 
> the value you set is the default.  so you don't have to set it
> explicitly.

What I am unsure about is this: how does ALSA behave if avail_min and
period_time are not equal?  As I understand it, the hardware is
configured to produce an interrupt every period_time frames.  How does
the software use this information (the incoming interrupts and the
avail_min parameter) to decide when to wake up the client?

Thanks for your answers!

Josh


-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
