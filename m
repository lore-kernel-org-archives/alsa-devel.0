From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: _mmap_playback_avail() short
Date: Tue, 29 Nov 2011 14:07:50 +0000
Message-ID: <201111291407.50367.gineera@aspect135.co.uk>
References: <201110311738.52213.gineera@aspect135.co.uk>
	<201111251510.27592.gineera@aspect135.co.uk>
	<4ED3F955.4090904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip02ir2.opaltelecom.net (out1.ip02ir2.opaltelecom.net
	[62.24.128.238])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E1C1103ACE
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 15:01:04 +0100 (CET)
In-Reply-To: <4ED3F955.4090904@ladisch.de>
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday 28 November 2011 21:12, Clemens Ladisch wrote:
> Alan Horstmann wrote:
> >> It seems that at a period boundary event snd_pcm_mmap_playback_avail()
> >> may not return a full period size, but is a few bytes short.  If
> >> avail_min is set to one whole period (which Portaudio at present does),
> >> snd_pcm_direct_poll_revents() zeroes the revent due to the check of
> >> snd_pcm_mmap_playback_avail() against avail_min.  POLLOUT is therefore
> >> not indicated, and the app does not write any data, causing an Xrun.
>
> This sounds like a bug in the rate plugin.  snd_pcm_rate_sync_hwptr()
> tries to properly align pointer values at period boundaries, but its
> algorithm doesn't work when a period does not start at the buffer start
> (i.e., when the number of periods is not an integer), and this
> restriction is not actually enforced by snd_pcm_rate_hw_refine_cchange().
>
> As a workaround, try snd_pcm_hw_params_set_periods_integer().

Thanks Clemens.  Integer period for the pcm is actually already being set.  
Since the Alsa docs are unclear, can you confirm that this refers to integer 
number_of_periods, not integer frames_per_period?

I have experimented removing that setting.  Then the hw_params shows 

PERIODS:[2 3)   (with square bracket!)

whereas with integer periods this was just 2.  However, there seems no change 
in the problematic behaviour.  Also the buffer size is 1881 in both cases.

Can you also explain how the non-integer period *size* is handled?  In the 
test case, dmix is set to 48000 with period 1024.  So at 44100 the rate 
conversion means the corresponding period size is 940.8.  I am not sure how 
that gets handled.  From the params dump giving period as (940 941) I had 
anticipated that a mixture of 4 * 941 and one 940 period would occur.  
However, what I see is that at a period boundary there is always just 940 
avail_frames - is that correct?  How does that get converted to the 1024 
frames at 48000?  Will there be irregular timing?

I had also tried not quite filling the buffer completely - eg deducting 10 
from avail_frames.  This is effective in ensuring the POLLOUTs are mostly not 
cancelled out, since the avail_frames is 950 not 940 each period, and this 
seems to be enough that snd_pcm_mmap_playback_avail() is larger than the 
period size.  However at start-up this on it's own did not avoid xruns.


Regards

Alan
