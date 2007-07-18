From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: SALSA and aplay
Date: Wed, 18 Jul 2007 16:01:11 +0100
Message-ID: <200707181601.11164.gineera@aspect135.co.uk>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<200707171538.00695.gineera@aspect135.co.uk>
	<s5hr6n7ukwf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 95445103822
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jul 2007 16:39:34 +0200 (CEST)
In-Reply-To: <s5hr6n7ukwf.wl%tiwai@suse.de>
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
To: ALSA devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Tuesday 17 July 2007 16:09, you wrote:
> At Tue, 17 Jul 2007 15:38:00 +0100,
>
> Alan Horstmann wrote:
> > On Tuesday 17 July 2007 12:58, you wrote:
> > > At Tue, 17 Jul 2007 12:33:36 +0100,
> > >
> > > Alan Horstmann wrote:
> > > > On Monday 16 July 2007 13:30, you wrote:
> > > >
> > > > I have very crudely hacked the aplay code and included it as a
> > > > function in code to make a simple key-press play a set file.  Linking
> > > > -lasound this seems to work fine.  However, linking -lsalsa results
> > > > in the file playing too fast, but not as much as double.
> > >
> > > Probably you are playing the samples with the hardware parameters that
> > > the hardware doesn't support.  alsa-lib has plugin layer which can
> > > convert appropriatley on the fly.
> > >
> > > > As my experimental system has ice1712 card, I am having to use a 10
> > > > track WAV file S32_LE as I think that is the only format supported,
> > > > the card working with 24-bits loose fitted in 32-bits.
> >
> > Are you refering to parameters other than rate, format, channels?  I
> > think those are correct now.  I have logged
> > 	snd_pcm_hw_params_dump(params, log);
> > 	snd_pcm_hw_params_dump(swparams, log);
> > In salsa:-
> > ACCESS:  RW_INTERLEAVED
> > FORMAT:  S32_LE hebrew
> > SUBFORMAT:  STD
> > SAMPLE_BITS: 32
> > FRAME_BITS: 320
> > CHANNELS: 10
> > RATE: 44100
> > PERIOD_TIME: (37142 37143)
> > PERIOD_SIZE: 1638
> > PERIOD_BYTES: 65520
> > PERIODS: (4 5)
> > BUFFER_TIME: (148594 148595)
> > BUFFER_SIZE: 6553
> > BUFFER_BYTES: 262120
> > TICK_TIME: 1000
> > tstamp_mode: NONE
> > period_step: 1
> > sleep_min: 0
> > avail_min: 1638
> > xfer_align: 1638
> > silence_threshold: 0
> > silence_size: 0
> > boundary: 1717829632
> >
> > In alsa:-
> > ACCESS:  RW_INTERLEAVED
> > FORMAT:  S32_LE
> > SUBFORMAT:  STD
> > SAMPLE_BITS: 32
> > FRAME_BITS: 320
> > CHANNELS: 10
> > RATE: 44100
> > PERIOD_TIME: (21333 21334)
> > PERIOD_SIZE: (940 941)
> > PERIOD_BYTES: (37600 37640)
> > PERIODS: (5 7)
> > BUFFER_TIME: (127981 127982)
> > BUFFER_SIZE: 5644
> > BUFFER_BYTES: 225760
> > TICK_TIME: 0
> > start_mode: DATA
> > xrun_mode: STOP
> > tstamp_mode: NONE
> > period_step: 1
> > sleep_min: 0
> > avail_min: 940
> > xfer_align: 940
> > silence_threshold: 0
> > silence_size: 0
> > boundary: 1479540736
> >
> > Is there significance to 'hebrew' on the format line?  The other numbers
> > mean little to me.  Sorry to trouble you.
>
> The string looks strange.  Could you try the patch below?

Patching file pcm.c using Plan A...
Hunk #1 succeeded at 284.
Hunk #2 succeeded at 292.
Hunk #3 succeeded at 333.
Hunk #4 succeeded at 345.
patch unexpectedly ends in middle of line
Hunk #5 succeeded at 418.
done

With patch applied, the 'hebrew' is gone!

> Anyway, I still don't think it's a bug of salsa-lib.
> Looking the prameters above, it seems you're using "default" PCM,
> right?  If so, try to use "hw" instead.  This should make the
> parameters identical.

Yes and yes.  Using "hw" gives the same wrong speed with -lasound, and 
standard command-line aplay does also.  Evidently I understand even less than 
I thought.  I had expected that with the card hardware set to 44100Hz and 
locked, that playing a 44100Hz file would be straightforward.  Maybe the file 
is not right.  I may have to pause testing for a few days now.

Thanks again

Alan
