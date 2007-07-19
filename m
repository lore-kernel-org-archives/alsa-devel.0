From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: SALSA and aplay
Date: Thu, 19 Jul 2007 15:24:40 +0100
Message-ID: <20070719142440.GA2467@localhost>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<s5hr6n7ukwf.wl%tiwai@suse.de>
	<200707181601.11164.gineera@aspect135.co.uk>
	<200707181720.29171.gineera@aspect135.co.uk>
	<s5hy7hcu49f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 77A7B103840
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jul 2007 16:21:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hy7hcu49f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 19, 2007 at 11:33:32AM +0200, Takashi Iwai wrote:
> At Wed, 18 Jul 2007 17:20:29 +0100,
> Alan Horstmann wrote:
> > 
> > On Wednesday 18 July 2007 16:01, Alan Horstmann wrote:
> > > Yes and yes.  Using "hw" gives the same wrong speed with -lasound, and
> > > standard command-line aplay does also.  Evidently I understand even less
> > > than I thought.  I had expected that with the card hardware set to 44100Hz
> > > and locked, that playing a 44100Hz file would be straightforward.  Maybe
> > > the file is not right.  I may have to pause testing for a few days now.
> > 
> > Actually, I think I have an idea what is happening, but not why.
> > 
> > aplay -v TMP/try3.wav
> > 
> > Playing WAVE 'TMP/try3.wav' : Signed 32 bit Little Endian, Rate 44100 Hz, 
> > Channels 10
> > Plug PCM: Rate conversion PCM (48000, sformat=S32_LE)
> > Its setup is:
> >   stream       : PLAYBACK
> >   access       : RW_INTERLEAVED
> >   format       : S32_LE
> >   subformat    : STD
> >   channels     : 10
> >   rate         : 44100
> >   exact rate   : 44100 (44100/1)
> >   msbits       : 32
> >   buffer_size  : 5644
> >   period_size  : 940
> >   period_time  : 21333
> >   tick_time    : 0
> >   tstamp_mode  : NONE
> >   period_step  : 1
> >   sleep_min    : 0
> >   avail_min    : 940
> >   xfer_align   : 940
> >   start_threshold  : 5640
> >   stop_threshold   : 5644
> >   silence_threshold: 0
> >   silence_size : 0
> >   boundary     : 1479540736
> > Slave: Direct Stream Mixing PCM
> > Its setup is:
> >   stream       : PLAYBACK
> >   access       : MMAP_INTERLEAVED
> >   format       : S32_LE
> >   subformat    : STD
> >   channels     : 10
> >   rate         : 48000
> >   exact rate   : 48000 (48000/1)
> >   msbits       : 24
> >   buffer_size  : 6144
> >   period_size  : 1024
> >   period_time  : 21333
> >   tick_time    : 0
> >   tstamp_mode  : NONE
> >   period_step  : 1
> >   sleep_min    : 0
> >   avail_min    : 1024
> >   xfer_align   : 1024
> >   start_threshold  : 6144
> >   stop_threshold   : 6144
> >   silence_threshold: 0
> >   silence_size : 0
> >   boundary     : 1610612736
> > Hardware PCM card 0 'TerraTec DMX6Fire' device 0 subdevice 0
> > Its setup is:
> >   stream       : PLAYBACK
> >   access       : MMAP_INTERLEAVED
> >   format       : S32_LE
> >   subformat    : STD
> >   channels     : 10
> >   rate         : 48000
> >   exact rate   : 48000 (48000/1)
> >   msbits       : 24
> >   buffer_size  : 6553
> >   period_size  : 1024
> >   period_time  : 21333
> >   tick_time    : 1000
> >   tstamp_mode  : NONE
> >   period_step  : 1
> >   sleep_min    : 0
> >   avail_min    : 1024
> >   xfer_align   : 1024
> >   start_threshold  : 1
> >   stop_threshold   : 1717829632
> >   silence_threshold: 0
> >   silence_size : 1717829632
> >   boundary     : 1717829632
> > 
> > It attempts to set the card to 48000, which fails since I have it locked!  
> > When I recorded the file the same was true, so from "default" the file plays 
> > back correct although it is in fact wrong, and plays wrong when imported into 
> > Audacity.  The set-up listed above suggests to me that Alsa is rate 
> > converting to 48000 and Mmap'ing to the card.  If correct, is that really 
> > necessary?  I dislike any rate conversions on a serious recording system, and 
> > especially hidden ones.  Is this a configuration issue that might have 
> > changed since, say, 1.0.10 or 1.0.12?
> 
> The 48k-fixed rate is due to dmix plugin.  It requires a fixed sample
> rate for all apps.  In theory, it may accept multiple rates, but the
> feature is not implemented yet.
> 
> You can change the default rate by overriding defaults.pcm.dmix.rate
> config item, e.g. define the below in ~/.asoundrc:
> 
> 	defaults.pcm.dmix.rate 44100

Wouldn't it be better to specify hw:0 (or whatever card you are using)
in this case? With this type of hardware I'd rather make sure that dmix
isn't used at all (I assume that dmix is now the default instead of
hw:0).

John
