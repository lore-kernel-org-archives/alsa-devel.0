From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 3 Feb 2009 11:41:37 +0000
Message-ID: <20090203114136.GA23827@sirena.org.uk>
References: <200901271519.47119.anarsoul@gmail.com>
	<74d0deb30901271149g40ac1842wfc28828377c27794@mail.gmail.com>
	<200901272232.17752.anarsoul@gmail.com>
	<200902030146.38863.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 93EBC103822
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 12:41:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200902030146.38863.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 03, 2009 at 01:46:32AM +0200, Vasily Khoruzhick wrote:

> and later aplay). It's bug in uda1380 driver (probably, just a typo), driver 
> switches to WSPLL in uda1380_pcm_prepare even if SYSCLK was chosen 
> (uda1380_pcm_prepare modifies UDA1380_CLK register before flushing reg cache, 
> but doesn't restore its value later)

Your explanation here makes sense but...

> One more question: it seems that my rx1950 clocked in a way that I can't get 
> precise divisor for 44100 and 22050 rates, but uda1380 driver propose them 
> (look UDA1380_RATES define and struct snd_soc_dai uda1380_dai[].
> How to exclude all rates except 16000 and 48000? Should I declare my own 
> snd_soc_dai and copy necessary members from uda1380's one?

Set up additional constraints in your machine driver - see how drivers
like wm8903 enforce symmetric configurations for playback and record for
an example.

>  
>  	/* FIXME enable DAC_CLK */
> -	uda1380_write(codec, UDA1380_CLK, clk | R00_DAC_CLK);
> +	uda1380_write(codec, UDA1380_CLK, clk);

..are you sure this fix won't break existing users?  Based on your
explanation above (which should *really* go into the commit) I'd expect
this to be conditional on something.  It looks like what you really want
to do here is clean up the FIXMEs :)
