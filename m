From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: emu10k1 latency / capture period
Date: Tue, 22 Jun 2004 17:15:18 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1087938917.2426.14.camel@debian>
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
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 5AAAC250
	for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2004 23:15:19 +0200 (MEST)
In-Reply-To: <s5h7jtzn4hv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, ALSA development <alsa-devel@alsa-project.org>
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

Yes, this design (i call it the FXBus driver) is mainly intended to 
support JACK.  The existing driver already supports everything you would
want to do with this card except lowlatency/multichannel anyway.

I added some printk()s to irq.c and io.c, and when running JACK in 
playback mode at the lowest latency (64), this is what is happening in 
the driver:

Jun 22 16:58:33 debian kernel: IPR_CHANNELLOOP - voice_max is 0x2
Jun 22 16:58:33 debian kernel: snd_emu10k1_ptr_read returns 0x4
Jun 22 16:58:33 debian kernel: snd_emu10k1_ptr_read returns 0x47f
Jun 22 16:58:33 debian kernel: irq - status = 0x42
Jun 22 16:58:33 debian kernel: IPR_CHANNELLOOP - voice_max is 0x2
Jun 22 16:58:33 debian kernel: snd_emu10k1_ptr_read returns 0x4
Jun 22 16:58:33 debian kernel: snd_emu10k1_ptr_read returns 0x43f
Jun 22 16:58:33 debian kernel: irq - status = 0x42
Jun 22 16:58:33 debian kernel: IPR_CHANNELLOOP - voice_max is 0x2
Jun 22 16:58:33 debian kernel: snd_emu10k1_ptr_read returns 0x4
Jun 22 16:58:33 debian kernel: snd_emu10k1_ptr_read returns 0x47f

So the IPR_CHANNELLOOP interrupts are a good timer source.

I am not exactly sure how to proceed from here, I will keep hacking at 
the driver and report anything interesting.

Lee








-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
