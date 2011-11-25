From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: _mmap_playback_avail() short (was: Default device
	XRUNs with perriods=2)
Date: Fri, 25 Nov 2011 15:10:27 +0000
Message-ID: <201111251510.27592.gineera@aspect135.co.uk>
References: <201110311738.52213.gineera@aspect135.co.uk>
	<201111031003.10016.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip04ir2.opaltelecom.net (out1.ip04ir2.opaltelecom.net
	[62.24.128.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 07DE1103EBC
	for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2011 16:04:31 +0100 (CET)
In-Reply-To: <201111031003.10016.gineera@aspect135.co.uk>
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

There's been no take-up on this, but I am seeing a consistent issue, with Alsa 
from 1.0.12 to 1.0.24, on 2 different machines with different audio hardware 
which will need to be worked around one way or another, and I wonder which is 
best?

The problem is with poll revents from default device when it includes SR 
conversion and dmix.

On Thursday 03 November 2011 10:03, I wrote:
> After several days dissecting, mainly with printf's, I have tracked the
> events that cause the problem I originally posted about with Portaudio
> playback to the default device at 44100Hz.  Could you confirm that the Alsa
> behaviour is what should be expected, please?
>
> It seems that at a period boundary event snd_pcm_mmap_playback_avail() may
> not return a full period size, but is a few bytes short.  If avail_min is
> set to one whole period (which Portaudio at present does),
> snd_pcm_direct_poll_revents() zeroes the revent due to the check of
> snd_pcm_mmap_playback_avail() against avail_min.  POLLOUT is therefore not
> indicated, and the app does not write any data, causing an Xrun.
>
> However, if the absence of POLLOUT is ignored, calling
> snd_pcm_avail_update() at that time returns a full period size.
>
> This only seems to happen on the default device when playing at a sample
> rate not corresponding to the dmix rate of 48000, presumably due to the
> plugins/conversions?
>
> The solution from the Portaudio point-of-view is to set avail_min lower,
> but I wanted to check with you that the values being returned are sane.

This only works with the older Alsa versions, since avail_min cannot be set to 
less than period size more rrecently.

It seems the options are:-

1. Use 3 periods and accept worse latency, always filling with avail_frames

2. Use 3 periods, but only fill partially, so there is, for example, always 
one period of space after filling, and at a poll nearly 2

3. Ignore the absence of POLLOUT or POLLIN flag, and instead treat the zero 
revent as good, check avail_frames and fill the buffer

4. I have misunderstood some detail in the use of Alsa which is causing this, 
and when corrected the issue will not occur.

Assistance to solve this would be greatly appreciated, since ultimately I 
would like to see Portaudio work well without issues on Linux/Alsa.  If more 
info would help, please ask.

Thanks

Alan
