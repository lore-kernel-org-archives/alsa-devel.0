From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: ALSA mixing capability
Date: Thu, 11 Dec 2003 11:01:59 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312111056270.20863@pnote.perex-int.cz>
References: <3FD83DC2.6090502@pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3FD83DC2.6090502@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 11 Dec 2003, Adam Tla/lka wrote:

> Welcome
> 
> I'm using ALSA 1.0.0rc2 on snd_intel8x0 and .asoundrc:
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> pcm.mix {
>         type dmix
>         ipc_key 321456  # any unique value
>         ipc_key_add_uid true
>         slave {
>                 pcm "hw:0,0"
>                 periods 0
>                 period_time 0
>                 period_size 1024  # must be power of 2
>                 buffer_size 4096  # ditto
>         }
>         bindings {
>                 0 0
>                 1 1
>         }
> }
> ctl.mix { type hw card 0 }
> pcm.dsp0 { type plug slave.pcm "mix" }
> ctl.mixer0 { type hw card 0 }
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> My problem:
> 
> when using wavplay with OSS ALSA emulation playing 22050 and 11025 Hz 
> .wav files works OK
> but with AOSS lib using pcm.dsp0 defined above I can't play 11025 Hz 
> .wav file:
> 
> $ aoss wavplay lburn2.wav
> Pathname:       lburn2.wav
> Device:         /dev/dsp
> Sampling Rate:  11025 Hz
> Mode:           Mono
> Samples:        5999
> Bits:           8
> 
> Unable to set audio sampling rate
> 
> but 22050 HZ .wav is played correctly.
> 
> So my question is how properly compose .asoundrc file so we could mix 
> all sound sources which use ALSA natively
> through -Dmix virtual device and OSS apps routed through AOSS lib? Is 
> this possible? Is this explained somewhere?

If you use mostly 44.1kHz material (or multiple of this rate), then 
explicitly set the 44.1kHz rate in pcm.dmix section (rate 44100). Note
that your hardware must support this rate.

Anyway, it seems like a bug.

> Next case is a possibility to create a  virtual mixer so ctl.mix 
> virtually sets level of particular source before mixing
> it with others sources so playind applications could set volumen of only 
> his source. Is that possible?

I know about this problem and it will be fixed one day.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
