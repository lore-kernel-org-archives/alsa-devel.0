From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Mon, 28 Jun 2004 16:44:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1088455444.16916.96.camel@mindpipe>
References: <1087416890.25102.21.camel@debian>
	 <1087704381.805.20.camel@debian> <s5h3c4oncuh.wl@alsa2.suse.de>
	 <s5h1xk8nbxu.wl@alsa2.suse.de> <1087849237.8161.38.camel@debian>
	 <s5h8yefn8vu.wl@alsa2.suse.de>
	 <Pine.LNX.4.58.0406221327270.1936@pnote.perex-int.cz>
	 <s5h7jtzn4hv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jtzn4hv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-06-22 at 08:47, Takashi Iwai wrote:
> At Tue, 22 Jun 2004 13:29:36 +0200 (CEST),
> Jaroslav wrote:
> > 
> > On Tue, 22 Jun 2004, Takashi Iwai wrote:
> > 
> > > At Mon, 21 Jun 2004 16:20:38 -0400,
> > > Lee Revell wrote:
> > > > 
> > > > The capture will be driven by the playback interrupts (I think
> > > > EFX_BUFFER(HALF)FULL).  This would look very similar to the 
> > > > interrupt handler example #2 in your ALSA driver guide, which 
> > > > uses timer interrupts to drive the capture/playback, except 
> > > > that for playback, in addition to calling snd_pcm_period_elapsed()
> > > > on the playback substream, we also maintain a pointer to the 
> > > > corresponding *capture* substream, and call snd_pcm_period_elapsed() 
> > > > on it, manually tracking the frames processed in the same way the timer
> > > > interrupt example does.
> > > 
> > > Even if we ignore the capture interrupts and use an additional
> > > interrupt source (e.g. an extra playback stream), the size of capture
> > > buffer still must follow the restriction.  That is, the minimal
> > > capture buffer size is still 384 x 2 bytes, although the period size
> > > can be set independently to smaller than 384 bytes. 
> > 
> > You can do lowlatency even with huge ring buffer, if you have a good
> > interrupt / scheduling timer, but it requires changes in application.
> 
> Yes.  At least, JACK should work well.
> 

OK, I think I have the solution.  You have to use the FX8010 PCM stream
type, snd_fx8010_pcm_t.  This PCM is implemented using the DSP, ETRAM is
used for the ringbuffers, and GPRs for the various pointers; you set the
high bit of GPR_IRQ to generate a DSP interrupt.  For each PCM you
register an interrupt handler in the trigger callback using
snd_emu10k1_fx8010_register_irq_handler(), then, when a DSP interrupt
occurs, you walk the list of registered handlers, and execute the proper
callbacks.

This technique is used by the existing ALSA driver for AC3 passthrough,
with the output going to the SPDIF port.  The kX driver must use this
method for ASIO, it just creates 16 PCMs and routes their output to the
first 16 FXBus channels.

For the time being this will only be possible to implement on EMU10K1,
because the ALSA driver does not yet support TRAM on the Audigy.

This should allow *really* low latency, down to the limits of the PCI
bus, because your timer has a resolution of one sample period. 

Lee







-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
