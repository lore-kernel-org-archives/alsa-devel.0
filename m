From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL
	and	SACR1_DREC separately
Date: Tue, 12 May 2009 17:02:30 +0100
Message-ID: <20090512160229.GK29889@sirena.org.uk>
References: <4A03748B.1010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 03D31103849
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 18:02:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A03748B.1010302@gmail.com>
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

On Fri, May 08, 2009 at 01:53:47AM +0200, Karl Beldan wrote:

> - hw_params enables both RPL and REC functions each time,
> enable the appropriate function in pxa2xx_i2s_trigger.
> - pxa2xx_i2s_shutdown disables i2s anytime one of RPL or REC
> function is off, turn it off only when both functions are off.
> - do not put the clk_i2s for no reason in pxa2xx_i2s_shutdown.

> Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>

I'm still seeing the behaviour I was before now I've applied patch 1.
To reproduce I'm looking at the clocks with a scope.  After startup I'm
starting a playback (aplay and mplayer have the same effect).  Once the
playback is finished (either normally or by killing the application) the
clocks are still present.  Restarting playback causes the clock to stop
immediately and the generation of a DMA error.  Subsequent iterations
repeat the same behaviour, as does recording.

>  	case SNDRV_PCM_TRIGGER_RESUME:
> @@ -252,13 +254,11 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream,
>  		SAIMR &= ~SAIMR_RFS;
>  	}
>  
> -	if (SACR1 & (SACR1_DREC | SACR1_DRPL)) {
> +	if ((SACR1 & (SACR1_DREC | SACR1_DRPL)) == (SACR1_DREC | SACR1_DRPL)) {
>  		SACR0 &= ~SACR0_ENB;
>  		pxa_i2s_wait();
>  		clk_disable(clk_i2s);
>  	}

The problem happens because this code no longer triggers - since the
port is still being reset on startup if the DAI is inactive the first
patch will have no effect on DREC and DRPL, they'll be reset to their
power on default of enabled when startup() is first called.  Applying
your third patch which removes the port reset avoids that issue.

Unfortunately there's still the outstanding issue with the third patch
removing the FIFO flushes - looking at the datasheet I think we do need
to clear the FIFOs, especially in the case where the PXA is running as
slave and might've had clocks removed.  Section 14.4.7.2 explicitly says
there are situations where the FIFO might not be drained and I'd really
not be surprised if there were others.

I'm out of time to look at this today - I expect that the fix is
probably to move some version of the port reset change into this patch.
