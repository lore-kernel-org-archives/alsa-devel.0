From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: _mmap_playback_avail() short
Date: Tue, 29 Nov 2011 22:07:25 +0000
Message-ID: <201111292207.26092.gineera@aspect135.co.uk>
References: <201110311738.52213.gineera@aspect135.co.uk>
	<201111291407.50367.gineera@aspect135.co.uk>
	<4ED4F88F.1080504@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.ip09ir2.opaltelecom.net (out1.ip09ir2.opaltelecom.net
	[62.24.128.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DC6310399B
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 23:07:25 +0100 (CET)
In-Reply-To: <4ED4F88F.1080504@ladisch.de>
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

On Tuesday 29 November 2011 15:21, Clemens Ladisch wrote:
> Alan Horstmann wrote:
> > On Monday 28 November 2011 21:12, Clemens Ladisch wrote:
> > > As a workaround, try snd_pcm_hw_params_set_periods_integer().
> >
> > Integer period for the pcm is actually already being set.
>
> Strange; there's a bug somewhere ...

Is there any useful debug I can do?

> > Can you also explain how the non-integer period *size* is handled?
>
> There are no non-integer period sizes.

That is very enlightening.

> > How does that get converted to the 1024 frames at 48000?  Will there be
> > irregular timing?
>
> The rate plugin uses the proportion of the two period sizes for rate
> conversion.  In your example, 940 samples are always converted into 1024
> samples; the actual sample rate is 48000/1024*940 = 44062.5.

So when snd_pcm_hw_params_get_rate_numden() gives a rate of 44100 it is not 
being completely accurate?  Is there a better way to discover what the exact 
effective rate will be (ideally after configuring but before starting the 
stream)?  In this case, it looks like period size 941 would give closer 
(44109)?

On the matter of work-arounds (for the missing POLLOUT), does it seem safe to 
just check the revents (after poll() returns) for POLLERR and POLLHUP, and if 
neither occurred then continue as if POLLIN or POLLOUT were present, checking 
avail_frames and mmapping data?  Or is that likely to cause other issues on 
some occasions?

Regards

Alan
