From: Petr Baudis <pasky@ucw.cz>
Subject: Re: hda-intel: azx_get_response timeout, switching to polling mode:
 last cmd=0x01db0000
Date: Mon, 23 Jan 2012 11:23:28 +0100
Message-ID: <20120123102327.GP30898@machine.or.cz>
References: <20111229025953.15211.24880.reportbug@machine.or.cz>
 <20111229062105.GB28780@elie.Belkin>
 <20120121091602.GF30898@machine.or.cz>
 <s5hhazm6alb.wl%tiwai@suse.de>
 <20120123094629.GO30898@machine.or.cz>
 <s5h7h0i691s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h7h0i691s.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan Nieder <jrnieder@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 23, 2012 at 10:51:43AM +0100, Takashi Iwai wrote:
> At Mon, 23 Jan 2012 10:46:30 +0100,
> Petr Baudis wrote:
> > 
> > On Mon, Jan 23, 2012 at 10:18:24AM +0100, Takashi Iwai wrote:
> > > Thanks.  Switching to the polling mode is really harmless.
> > > So, basically you can ignore these messages.  I can change it only as a
> > > debug message.
> > > 
> > > OTOH, if the switching to single_cmd mode happens, this is a serious
> > > problem.  But, as far as I see in alsa-info.sh output, it didn't
> > > happen.
> > 
> > Ok, then the bug is in handling of polling mode in this particular chip.
> > After such switch to polling mode, applications will get stuck on
> > releasing the soundcard.
> 
> What do you mean "releasing the soundcard"?  Closing the PCM stream,
> or unloading the module, or at shutdown?

  Closing the PCM stream - see strace snippet in the original post.

> > Another symptom I forgot to describe is that
> > the last ~100ms of output will keep repeating when I pause/stop
> > playback, one has to mute the volume to get rid of this. Again, this
> > starts happenning only sometimes after the switch to polling mode,
> > but then keeps happenning fairly consistently.
> 
> Hm, this sounds like some interrupt issue, then.  After all, switching
> to the polling-mode happens because the expected interrupt didn't
> arrive in time.  If a similar problem happens in the PCM stream, too,
> it might be some other generic interrupt problem.

  The soundcard used to work on much older kernel versions. The only
issue I had with this chipset were general (sound, network, ...) DMA
problems from 4GiB+ memory areas after I upgraded my memory, but that
got fixed in newer kernel version. The soundcard uses unique IRQs:

	           CPU0       CPU1
	 43:         24       7290   PCI-MSI-edge      snd_hda_intel
	 44:          1         60   PCI-MSI-edge      snd_hda_intel

  Any clues on how I can debug this?

-- 
				Petr "Pasky" Baudis
	The goal of Computer Science is to build something that will
	last at least until we've finished building it.
