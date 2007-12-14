From: Dave Dillow <dave@thedillows.org>
Subject: Re: speaker-test stalls
Date: Fri, 14 Dec 2007 07:48:11 -0500
Message-ID: <1197636491.3628.15.camel@obelisk.thedillows.org>
References: <1197147520.3588.38.camel@obelisk.thedillows.org>
	<s5hr6hqkg84.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 6202524538
	for <alsa-devel@alsa-project.org>; Fri, 14 Dec 2007 13:48:16 +0100 (CET)
In-Reply-To: <s5hr6hqkg84.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Fernando Papa <fpapa@adinet.com.uy>
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-12-13 at 12:04 +0100, Takashi Iwai wrote:
> At Sat, 08 Dec 2007 15:58:40 -0500,
> Dave Dillow wrote:
> > Assuming that this is desired behavior from the kernel side, then I see
> > three options to fix this in speaker-test:
> > 1) snd_pcm_sw_params_set_avail_min() to 1 sample
> > 2) snd_pcm_sw_params_set_start_threshold() to start when (nperiods - 1)
> > are ready (or be even more aggressive)
> > 3) call snd_pcm_drain() at the end of each loop to clear out the buffer.
> > This won't help if the wave file has fewer samples than the buffer size.
> > 
> > Options 1 or 2 seem to be best.
> > 
> > Thoughts?
> 
> Just to be sure:  Is it with the latest alsa-lib and alsa-utils from
> HG?

Yes, this is with the latest alsa-lib and alsa-utils -- I did an
hg-update to be sure.

Sorry for the delay, I needed to rebuild the buildroot to be sure.
