From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Mon, 21 Jun 2004 16:20:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087849237.8161.38.camel@debian>
References: <1087416890.25102.21.camel@debian>
	 <1087704381.805.20.camel@debian> <s5h3c4oncuh.wl@alsa2.suse.de>
	 <s5h1xk8nbxu.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xk8nbxu.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-06-21 at 11:54, Takashi Iwai wrote:
> > > On Wed, 2004-06-16 at 16:14, Lee Revell wrote:
> > > > Hey,
> > > > 
> > > > I am having a problem with the emu10k1 driver where I am unable to set
> > > > the capture period lower than 512.  The result is that the lowest
> > > > achievable input to output latency is in the neighborhood of 40ms.
> > > > 
> > > 
> > > I think I may have solved this problem.  Here is a patch against
> > > alsa-driver-1.0.5a.
> > > 
> > > --- alsa-driver-1.0.5a/alsa-kernel/pci/emu10k1/emupcm.c.orig   
> > > 2004-06-19 23:21:09.000000000 -0400
> > > +++ alsa-driver-1.0.5a/alsa-kernel/pci/emu10k1/emupcm.c 2004-06-19
> > > 23:21:12.000000000 -0400
> > > @@ -932,7 +932,7 @@
> > >         spin_unlock_irqrestore(&emu->reg_lock, flags);
> > >         emu->capture_efx_interrupt = snd_emu10k1_pcm_efx_interrupt;
> > >         emu->pcm_capture_efx_substream = substream;
> > > -       snd_pcm_hw_constraint_list(runtime, 0,
> > > SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
> > > +       // snd_pcm_hw_constraint_list(runtime, 0,
> > > SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
> > >         return 0;
> > >  }
> > > 
> > > I do not think that the FX8010 capture device is constrained by the 
> > > period size limitations on the standard emu10k1 capture device.
> > 
> > Right, this constraint is invalid.
> 
> Well, after checking the code again, I'm not convinced any more...
> Are you sure that it works without this constraint on half-duplex
> capture?

You are correct, it does not work.  I should have fully tested this 
before posting.

I think I have figured out how the FXBus driver needs to work.

The FXBus device (lets say hw:0,3) has 16 (for SBLive) or 32 
(for Audigy) capture and playback channels, one for each hardware 
FXBus channel.

The capture will be driven by the playback interrupts (I think
EFX_BUFFER(HALF)FULL).  This would look very similar to the 
interrupt handler example #2 in your ALSA driver guide, which 
uses timer interrupts to drive the capture/playback, except 
that for playback, in addition to calling snd_pcm_period_elapsed()
on the playback substream, we also maintain a pointer to the 
corresponding *capture* substream, and call snd_pcm_period_elapsed() 
on it, manually tracking the frames processed in the same way the timer
interrupt example does.

We would ignore interrupts from the the standard capture device
ADC_BUFFER(HALF)FULL.  In order to capture the FXBus channels 
you would have to use ld10k1 to connect inputs and outputs to 
FXBus channels.

I think that one result of this design is that if an FXBus channel 
is opened for capture, and none are open for playback, then  
snd_pcm_period_elapsed() will never get called.  One way to solve 
this would be to open a fake playback substream in the open callback for
the capture.

Also, I think that this design requires all processes opening the FXBus 
device to use the same period size.  I am not sure about this.  
The kX ASIO driver works this way, but that may be a requirement of
ASIO.

Do you see any problems with this design?

Lee




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
