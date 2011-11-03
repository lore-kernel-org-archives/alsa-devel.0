From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: _mmap_playback_avail() short (was: Default device
	XRUNs with perriods=2)
Date: Thu, 3 Nov 2011 10:03:09 +0000
Message-ID: <201111031003.10016.gineera@aspect135.co.uk>
References: <201110311738.52213.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip05ir2.opaltelecom.net (out1.ip05ir2.opaltelecom.net
	[62.24.128.241]) by alsa0.perex.cz (Postfix) with ESMTP id B4E7024642
	for <alsa-devel@alsa-project.org>; Thu,  3 Nov 2011 11:01:56 +0100 (CET)
In-Reply-To: <201110311738.52213.gineera@aspect135.co.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

After several days dissecting, mainly with printf's, I have tracked the events 
that cause the problem I originally posted about with Portaudio playback to 
the default device at 44100Hz.  Could you confirm that the Alsa behaviour is 
what should be expected, please?

It seems that at a period boundary event snd_pcm_mmap_playback_avail() may not 
return a full period size, but is a few bytes short.  If avail_min is set to 
one whole period (which Portaudio at present does), 
snd_pcm_direct_poll_revents() zeroes the revent due to the check of 
snd_pcm_mmap_playback_avail() against avail_min.  POLLOUT is therefore not 
indicated, and the app does not write any data, causing an Xrun.

However, if the absence of POLLOUT is ignored, calling snd_pcm_avail_update() 
at that time returns a full period size.

This only seems to happen on the default device when playing at a sample rate 
not corresponding to the dmix rate of 48000, presumably due to the 
plugins/conversions?

The solution from the Portaudio point-of-view is to set avail_min lower, but I 
wanted to check with you that the values being returned are sane.

Thanks

Alan

This is not a top-post - but here is the original posting for reference:-

On Monday 31 October 2011 17:38, I wrote:
> I am trying to debug/fix some problems with Portaudio on Linux platform,
> and would appreciate assistance from Alsa experts.
>
> The 'default' pcm on the test systems here (Suse 9 and SLED10), is standard
> for the configuration and includes dmix and plug conversion, with fixed
> period of 1024 at 48000.  Pulseaudio is not on these systems.
>
> When playing data (using a polling mechanism) at 48000 both 3 (or more) and
> 2 periods of buffer work fine; with the fixed period of 1024 the lowest
> latency is 2 * 1024 / 48000 = 42.6ms.
>
> However, at 44100, 2 periods does not run properly at all, but 3 does.  The
> periods in this case are (940, 941) due to the rate conversion.
>
> What I see (captured on another machine) from start of the stream is one
> 21.3ms period of good audio, a discontinuity followed by some variable
> amount of out-of-sync audio, and a section of silence.
>
> I believe that the discontinuity corresponds to the point at which
> snd_pcm_poll_descriptors_revents() returns POLLERR and portaudio detects
> the POLLERR and restarts the stream, so that after a certain delay there is
> another 21.3ms of audio, POLLERR, now no out-of-sync audio, just silence,
> before it all repeats.  So it stutters only outputting 21.3ms bursts of
> audio.
>
> The CPU usage during this is about 2%.  I am suspecting some
> mis-configuration, or is it wrong to expect this to work at 2 periods due
> to the rate conversion etc?
>
> Any pointers etc would be really appreciated.  This is the info dump:-
>
> ACCESS:  MMAP_INTERLEAVED
> FORMAT:  FLOAT_LE
> SUBFORMAT:  STD
> SAMPLE_BITS: 32
> FRAME_BITS: 64
> CHANNELS: 2
> RATE: 44100
> PERIOD_TIME: (21333 21334)
> PERIOD_SIZE: (940 941)
> PERIOD_BYTES: (7520 7528)
> PERIODS: 2
> BUFFER_TIME: (42653 42654)
> BUFFER_SIZE: 1881
> BUFFER_BYTES: 15048
> TICK_TIME: 0
>
> start_mode: DATA
> xrun_mode: STOP
> tstamp_mode: MMAP
> period_step: 1
> sleep_min: 0
> avail_min: 940
> xfer_align: 1
> silence_threshold: 0
> silence_size: 4235635449541951488
> boundary: 4235635449541951488
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
>   format       : FLOAT_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 44100
>   exact rate   : 44100 (44100/1)
>   msbits       : 32
>   buffer_size  : 1881
>   period_size  : 940
>   period_time  : 21333
>   tick_time    : 0
>   tstamp_mode  : MMAP
>   period_step  : 1
>   sleep_min    : 0
>   avail_min    : 940
>   xfer_align   : 1
>   start_threshold  : 940
>   stop_threshold   : 1881
>   silence_threshold: 0
>   silence_size : 4235635449541951488
>   boundary     : 4235635449541951488
