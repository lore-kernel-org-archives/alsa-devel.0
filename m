From: Joachim Foerster <mls.JOFT@gmx.de>
Subject: Re: How to enforce 32bit access?
Date: Thu, 11 Oct 2007 15:30:51 +0200
Message-ID: <1192109451.25924.50.camel@localhost>
References: <1191339247.30745.23.camel@localhost>
	<1191604193.5762.2.camel@localhost> <s5h8x6cveo5.wl%tiwai@suse.de>
	<1192022382.5545.9.camel@localhost> <s5hr6k3qf3a.wl%tiwai@suse.de>
	<1192030808.5545.23.camel@localhost>  <s5hhckyqbkh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 975F72436C
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Oct 2007 15:30:54 +0200 (CEST)
In-Reply-To: <s5hhckyqbkh.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Lorenz Kolb <lorenz.kolb@lkmail.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-10-11 at 10:50 +0200, Takashi Iwai wrote:
> > > > > Could you show the chain of plugins via aplay -v ?
> > > > > I'm not sure which plugin requires S16.  Possibly, the rate converter.
> > > > 
> > > > bash-3.00# aplay -v -M ../Absage.wav
> > > > Playing WAVE '../Absage.wav' : Signed 16 bit Little Endian, Rate 16000
> > > > Hz, Mono
> > > 
> > > Well, the sample itself is 16bit format, and your hardware *does*
> > > support 16bit format.  Why to be 32bit?
> > 
> > Well actually, we are on a embedded system here. The bus is 32bit wide
> > (Xilinx ML403, PowerPC 405, OBP). So, why waste resources with two 16bit
> > accesses?
> 
> Because you programmed in such a way :)

Ok, then I have to change the code ... but where? ;-)

> > One sample is 16bits. But we have two channels (stereo only). Thus the
> > controller expects a frame with 32bit data - two samples at the same
> > time.
> > 
> >  Joachim
> > 
> > PS: As soon as stereo .wav-files are used, there is no problem, because
> > then the "conversion framework" and the Plug PCM are not used - just a
> > plain memcpy which results in 32bit accesses.
> 
> The problem is that the driver still accepts the 16bit format mono
> stream.  That's what I pointed in my previous post.  There is no
> format conversion in alsa-lib at all.  It's only channel expansion
> >from mono to stereo.  The hardware accepts 16bit stereo.  So, there is
> nothing wrong from this viewpoint.

By "conversion framework" I actually meant the channel expansion - code
which somehow "works in the data" before sending it to the hardware.

And yes, 16 bit samples are the only sample format supported by the
hardware. But "by design of the hardware" the smallest write access has
to be 32 bit wide (2 samples, stereo only)

> Maybe it's not about plugin but a problem of mmap with your device?

Well, as I said before, as soon as I use a stereo .wav-file a simple
call to memcpy() is used by alsa-lib to transfer the data to the
hardware (snd_pcm_area_copy(), pcm.c, ca. line 2551, alsa-lib 1.0.14a).
In this case the PCM Plugin isn't used at all - the output of aplay -v
looks like:

Playing WAVE 'music.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
Plug PCM: Hardware PCM card 0 'Lorenz' AC97 Digital Controller' device 0
subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 4096
  period_size  : 1024
  period_time  : 23219
  tick_time    : 4000
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 1024
  xfer_align   : 1024
  start_threshold  : 4096
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824

So mmap on the controller's memory works - using 32 bit accesses only.
And at that place in alsa-lib, I never saw an amount of data which is
_not_ a multiple of 32 bits - or this just a coincidence?


So, do I understand you right, when I say: an ALSA driver does _not_ hav
ethe possibility to force alsa-lib to write 32 bit entities, only?

I guess, we have to change the hardware here - it's an FPGA, so that's
not a problem in principle - but it complicates the hardware, making it
accept 16bit accesses.

 Joachim
