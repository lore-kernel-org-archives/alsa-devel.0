From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/4] pxa2xx-i2s: Cleaner use of the FIFOs
Date: Fri, 8 May 2009 11:57:10 +0100
Message-ID: <20090508105709.GE5654@sirena.org.uk>
References: <4A037493.5080008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 368EF2492E
	for <alsa-devel@alsa-project.org>;
	Fri,  8 May 2009 12:57:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A037493.5080008@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Karl Beldan <karl.beldan@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

On Fri, May 08, 2009 at 01:53:55AM +0200, Karl Beldan wrote:

> The FIFO logic and the registers are reset at stream startup with
> SACR0_RST => the sibling function might suffer and the FIFOs might
> unpleasantly fill up whence the calls to pxa_i2s_wait all over the place.
> This gets rid of it.

The change to stream startup makes sense but...

> @@ -256,7 +242,6 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream,
>  
>  	if ((SACR1 & (SACR1_DREC | SACR1_DRPL)) == (SACR1_DREC | SACR1_DRPL)) {
>  		SACR0 &= ~SACR0_ENB;
> -		pxa_i2s_wait();
>  		clk_disable(clk_i2s);
>  	}
>  }
> @@ -275,7 +260,6 @@ static int pxa2xx_i2s_suspend(struct snd_soc_dai *dai)
>  
>  	/* deactivate link */
>  	SACR0 &= ~SACR0_ENB;
> -	pxa_i2s_wait();
>  	return 0;
>  }

...there's also changes to the suspend and resume paths here which seem
like they'd be as well not to do simply for robustness.  Is there any
great reason for doing this or are you just doing it for neatness, the
changelog isn't entirely clear?
