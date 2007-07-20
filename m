From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: SALSA and aplay
Date: Fri, 20 Jul 2007 12:57:07 +0100
Message-ID: <200707201257.07580.gineera@aspect135.co.uk>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<200707181601.11164.gineera@aspect135.co.uk>
	<s5hzm1su4dt.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 0291010383B
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 13:34:59 +0200 (CEST)
In-Reply-To: <s5hzm1su4dt.wl%tiwai@suse.de>
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

On Thursday 19 July 2007 10:30, you wrote:
> At Wed, 18 Jul 2007 16:01:11 +0100,
>
> Alan Horstmann wrote:
> > Patching file pcm.c using Plan A...
> > Hunk #1 succeeded at 284.
> > Hunk #2 succeeded at 292.
> > Hunk #3 succeeded at 333.
> > Hunk #4 succeeded at 345.
> > patch unexpectedly ends in middle of line
> > Hunk #5 succeeded at 418.
> > done
> >
> > With patch applied, the 'hebrew' is gone!
>
> Thanks for confirmation.  The patch was included in 0.0.8 release.

OK. Salsa is performing the same as asound using "hw", except one other 
perhaps trivial thing I have noticed.  The aplay code does
	err = snd_output_stdio_attach(&log, stderr, 0);
and prints things
	snd_pcm_hw_params_dump(params, log);
finishing with
	snd_output_close(log)
In alsa-lib, the third parameter of .._attach is used to set 'close', and 
being 0, means stderr is not closed.  However, with salsa the file is always 
closed at the end.  I am using the aplay code as a function, and on the 2nd 
call, there are non of the print items.  Preventing this close in salsa or 
the aplay code does remove the problem.  Is this intended trimming of 
functionality for min size?

Ultimately though, I can live with this.

I will continue the configuration discussions with a different title (since 
not salsa-related).

Alan
