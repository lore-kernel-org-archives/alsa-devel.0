From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Scatter-Gather buffer allocation before running on
 HDSP-MADI ?
Date: Sun, 5 Oct 2003 21:01:58 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.53.0310052055350.13267@pnote.perex-int.cz>
References: <16254.61960.840856.972245@seneca.iemnet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <16254.61960.840856.972245@seneca.iemnet>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Winfried Ritsch <ritsch@iem.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 4 Oct 2003, Winfried Ritsch wrote:

>
> Hello !
>
> (A question from an newbie-developer to make it perfect ;-)
>
> I am writing an ALSA-lowleveldriver for the RME HDSP-MADI card.
> (which have 64Audion in and out and an 128in64(= 8192Fader) Mixer
> see http://www.rme-audio.de/hdsp/hdspmadi.htm ) Coding is quite
> complete but I have trouble with the memory management.
>
> The Card uses ScatterGather Buffer, each channel 64kB and this
> has to be asigned (to be safe) before activation, so I want
> to allocate SGbuffer (64+64)*64*1024=8388608 in 4k-blocks.
>
> I do a
>
> snd_pcm_lib_preallocate_pci_pages_for_all(hdspm->pci, pcm,8388608l,8388608l)
>
> after making the pcm_device.
>
> Here the questions:
>
> 1) How can I get the sgbuf pointer ?
>
> ... since in the streams runtime is not set and therefore (besides the
> Documentation says is (snd_pcm_sgbuf_t*)substream->dma_private which I
> couldnt find)
>
>  sgbuf = (snd_pcm_sgbuf_t*)substream->runtime->dma_private;
>
> is not assigned.
>
> but when I activate the card (for MIDI for example) there must be
> memory asigned und I think doing it in hw_params is to late.

Note that ALSA has SG routines only for PCM streams and it's lifetime is
limited only for stream lifetime. If hardware needs to allocate a big
buffer at the initialization phase, you have to do it yourself.

> 2) If it is bound to substream is always the same substream the
> capture or playback or are the assigned dynamically on calling ?

It depends on hardware parameters and on application. If your hardware
supports multiple equal streams using same i/o connector (hardware
mixing), then the substream might be allocated dynamically, but
application might still request the exact substream number.

If your hardware uses only a few totaly independent streams, create PCM
devices with one substream.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
