From: Daniel Yek <dyek@real.com>
Subject: _test_channels() / plug:surround51 / Hardware Mixing
 And dmix / SW or HW Resampling / Volume Control
Date: Thu, 28 Sep 2006 16:44:26 -0700
Message-ID: <6.2.1.2.2.20060928125136.20c38030@mailone.real.com>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hhcys2kr2.wl%tiwai@suse.de>
References: <6.2.1.2.2.20060928013552.16a4b928@mailone.real.com>
	<s5hhcys2kr2.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>, Alsa Developement <alsa-devel@lists.sourceforge.net>
Cc: Greg Wright <gwright@real.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a few more follow-up questions inline...

At 06:17 AM 9/28/2006, Takashi Iwai wrote:
>At Thu, 28 Sep 2006 01:54:47 -0700,
>Daniel Yek wrote:
<...snip...>
> >
> > (A) Test Channels:
> >
> > I have the following sound card.
> > Card: Intel ICH7
> > Chip: Analog Devices AD1981B
> > (AD1981B is AC '97 2.3 Compliant CODEC, 2 Channels of Audio with SPDIF)
> >
> > Why the following code reports that the system supports 6 channels audio
> > when the "default" device is used?
> >   channels = 6;
> >   snd_pcm_hw_params_test_channels( PCMHandle, hwparams, channels);
> >
> > As a result, many channels were simply lost, not being heard. The same 
> happens even on
> > a 5.1 system if "default" device is used.
>
>This function returns whether the sound system _accepts_ the given
>number of channels.  It doesn't care whether it's really played or
>not.  Since "default" PCM uses plug layer, it accepts any number of
>channels.

What is the right way to figure out if the hardware associated with the 
"plug:surround51" PCM is capable of playing in 5.1 mode? I need to know 
this because in the case the hardware isn't 5.1-ready, I would like to 
fallback to 2-channel playback. On systems incapable of 5.1 playback all 
PCMs seem to drop channels; that is bad.

What is usually happening when "surround51" is aliased to "default" PCM and 
"plug:surround51" is asked to accept 6 channels (5.1) playback? Where the 
extra channels were discarded? Was it in "plug"? (Or could it be dmix? The 
hardware mixer has nothing to do with this right?)


> > (B)
> >
> > Plug:
> >
> > If opening "surround51" device failed, does it make sense for a
> > media application to try to open "plug:surround51"?
> >
> > Would "plug" play 5.1 channels content without losing any
> > channel?
>
>If _opening_ surround51 fails, it's usually a problem of device
>assignment (e.g. the device is already in use).  The surround51
>usually doesn't do softmixing unlike "default" PCM.
>
>The plug layer would be useful if you play sample formats that the
>hardware doesn't support, for example, playing 16bit format on ICE1712
>boards.  Basically, it's safe to use "plug:surround51" when you know
>you are going to play 5.1 sound.  But, this doesn't guarantee that the
>device can be opened (because of non-dmix nature).
>
> > Or would it make more sense for the application to mix the channels into
> > a 2 channels output (in software)?
>
>No.

If "no" is the answer, I would have to ask: why then doing software 
down-mixing sounds much better than playing in 5.1 mode? (That is channels 
were not lost if software down-mixing is used. See "aplay -v" output at the 
bottom of this email.) Is there anything I am missing?




> > (C)
> >
> > dmix:
> >
> > Does ALSA use dmix if the sound card supports hardware mixing?
>
>No (usually).  The configuration file for each driver is written to
>use the appropriate hw or plughw for such a hardware (e.g. emu10k1).

Glad to know that.


> > Are there different levels of hardware mixing supports? That is, if a
> > sound card has hardware mixing support, does it always has 5.1 channel
> > hardware mixing support?
>
>Not really.  Currently, surround* and iec958 (spdif) are supposed to
>be non-mixing devices unless the hardware supports.
>The setup of 5.1-dmix isn't provided in the standard configuration
>yet.
>
> > ALSA library version 1.0.9rc2 and later is using dmix by default.
> > In the case of the sound card supporting hardware mixing, should a
> > demanding media application prefers another device name because
> > "default" is now configured with dmix?
>
>A mediaplayer can/should use "default" PCM (unless wants explicitly
>5.1 sounds etc).  The default PCM skips dmix if hw-mixing is
>available.
>
>BTW, for the secondary card, you can use like the style like
>"default:1".  This will choose the default PCM of the secondary card.

Thanks!


> > If an application opens "surround51" device, would it hold the
> > device exclusively and preventing other media application from using it?
>
>Yes (in most cases).
>
> > If so, are they any standard dmix device name for surround51?
>
>Not yet.  It's one of TODOs.
>
> > (D)
> >
> > Sampling Rate:
> >
> > What is the best Sampling Rate to be produced by a media application for
> > ALSA and ALSA dmix device?
>
>48000.  In the recent version, it can be changed via a system-wide
>setup (defaults.pcm.dmix_rate), though.
>
> > The following page claimed that dmix write directly to the soundcard's
> > DMA buffer.
> > Does that implicitly referring to sound card with hardware mixer?
> >
> > http://www.alsa-project.org/alsa-doc/doc-php/asoundrc.php
>
>No.
>
> > The same page says that ALSA dmix device is default to RATE=48000.
> > With sound quality in mind, should a media application with resampling
> > capability tries to resample to 48000Hz in software or should it let dmix
> > or the hardware handle resampling?
>
>The dmix cannot use the hardware resampling because the hardware _is_
>running on 48kHz.
>
>Once ago I made an experimental patch to change dmix code to accept
>both 44.1 and 48kHz depending on the first application.  But it's
>racy, so isn't a good solution yet...
>
>
> > (E)
> >
> > Volume Control:
> >
> > How can I use ALSA's Playback controls volume level interface?
> > Is it for the application to use or more for alsa-lib?
> > Refer to
> >
> > http://www.sabi.co.uk/Notes/linuxSoundALSA.html
>
>Every ALSA-native mixer app uses the mixer API.
>Also, some media players use it, too.
>
> > Are there any per-process Volume Control interface available?
>
>Not yet.  It's on my TODO list.
>
>Currently, a player needs to pick up either "Master", "PCM" or
>whatever existing volume element.
>
>
>Takashi


Aplay verbose output (only 2 channels were heard):

aplay -v --device=default --format=S16_LE --channels=6 --file-type raw 
--rate=44100 wave.dat

Playing raw data 'wave.dat' : Signed 16 bit Little Endian, Rate 44100 Hz, 
Channels 6
Plug PCM: Route conversion PCM (sformat=S16_LE)
   Transformation table:
     0 <- 0
     1 <- 1
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 6
   rate         : 44100
   exact rate   : 44100 (44100/1)
   msbits       : 16
   buffer_size  : 15052
   period_size  : 940
   period_time  : 21333
   tick_time    : 0
   tstamp_mode  : NONE
   period_step  : 1
   sleep_min    : 0
   avail_min    : 940
   xfer_align   : 940
   start_threshold  : 15040
   stop_threshold   : 15052
   silence_threshold: 0
   silence_size : 0
   boundary     : 986447872
Slave: Rate conversion PCM (48000, sformat=S16_LE)
Its setup is:
   stream       : PLAYBACK
   access       : MMAP_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 44100
   exact rate   : 44100 (44100/1)
   msbits       : 16
   buffer_size  : 15052
   period_size  : 940
   period_time  : 21333
   tick_time    : 0
   tstamp_mode  : NONE
   period_step  : 1
   sleep_min    : 0
   avail_min    : 940
   xfer_align   : 940
   start_threshold  : 15040
   stop_threshold   : 15052
   silence_threshold: 0
   silence_size : 0
   boundary     : 986447872
Slave: Direct Stream Mixing PCM
Its setup is:
   stream       : PLAYBACK
   access       : MMAP_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 16384
   period_size  : 1024
   period_time  : 21333
   tick_time    : 0
   tstamp_mode  : NONE
   period_step  : 1
   sleep_min    : 0
   avail_min    : 1024
   xfer_align   : 1024
   start_threshold  : 16384
   stop_threshold   : 16384
   silence_threshold: 0
   silence_size : 0
   boundary     : 1073741824
Hardware PCM card 0 'Intel ICH7' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : MMAP_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 16384
   period_size  : 1024
   period_time  : 21333
   tick_time    : 4000
   tstamp_mode  : NONE
   period_step  : 1
   sleep_min    : 0
   avail_min    : 1024
   xfer_align   : 1024
   start_threshold  : 1
   stop_threshold   : 1073741824
   silence_threshold: 0
   silence_size : 1073741824
   boundary     : 1073741824

Thanks again!

-- 

Daniel Yek


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
