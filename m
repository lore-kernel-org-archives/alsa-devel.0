From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: SALSA and aplay
Date: Fri, 20 Jul 2007 16:20:49 +0100
Message-ID: <200707201620.49675.gineera@aspect135.co.uk>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<200707201257.07580.gineera@aspect135.co.uk>
	<s5hbqe7s2b6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (unknown [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id BBB3610386D
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jul 2007 16:58:38 +0200 (CEST)
In-Reply-To: <s5hbqe7s2b6.wl%tiwai@suse.de>
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

On Friday 20 July 2007 13:10, you wrote:
> At Fri, 20 Jul 2007 12:57:07 +0100,
>
> Alan Horstmann wrote:

> > OK. Salsa is performing the same as asound using "hw", except one other
> > perhaps trivial thing I have noticed.  The aplay code does
> > 	err = snd_output_stdio_attach(&log, stderr, 0);
> > and prints things
> > 	snd_pcm_hw_params_dump(params, log);
> > finishing with
> > 	snd_output_close(log)
> > In alsa-lib, the third parameter of .._attach is used to set 'close', and
> > being 0, means stderr is not closed.  However, with salsa the file is
> > always closed at the end.  I am using the aplay code as a function, and
> > on the 2nd call, there are non of the print items.  Preventing this close
> > in salsa or the aplay code does remove the problem.  Is this intended
> > trimming of functionality for min size?
>
> Ah, that stupid wrapper for FILE I/O.  I don't understand why such a
> thing was introduced...
>
> Not sure whether I'll fix it or leave it yet.

Actually, if my reading of the code is right (which it may not be), in 
alsa-lib all that snd_output_close(..) does is close(file) if 'close'=1.

So if the aplay code does .._attach with 'close'=0, is there any reason to 
call snd_output_close(..)?  Or just omit that?  So probably no fix needed?

Alan
