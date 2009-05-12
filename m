From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: [PATCH 2/4] pxa2xx-i2s: Handle SACR1_DRPL and
 SACR1_DREC separately
Date: Tue, 12 May 2009 19:43:04 +0200
Message-ID: <4A09B528.9050109@gmail.com>
References: <4A03748B.1010302@gmail.com> <20090512160229.GK29889@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f170.google.com (mail-fx0-f170.google.com
	[209.85.220.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 29BA810386F
	for <alsa-devel@alsa-project.org>;
	Tue, 12 May 2009 19:43:05 +0200 (CEST)
Received: by fxm18 with SMTP id 18so134844fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 12 May 2009 10:43:04 -0700 (PDT)
In-Reply-To: <20090512160229.GK29889@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Russell King <linux@arm.linux.org.uk>, alsa-devel@alsa-project.org, Eric Miao <eric.miao@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Matthieu Dumont <matthieu.dumont@mobile-devices.fr>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, May 08, 2009 at 01:53:47AM +0200, Karl Beldan wrote:
> 
>> - hw_params enables both RPL and REC functions each time,
>> enable the appropriate function in pxa2xx_i2s_trigger.
>> - pxa2xx_i2s_shutdown disables i2s anytime one of RPL or REC
>> function is off, turn it off only when both functions are off.
>> - do not put the clk_i2s for no reason in pxa2xx_i2s_shutdown.
> 
>> Signed-off-by: Karl Beldan <karl.beldan@mobile-devices.fr>
> 
> I'm still seeing the behaviour I was before now I've applied patch 1.
> To reproduce I'm looking at the clocks with a scope.  After startup I'm
> starting a playback (aplay and mplayer have the same effect).  Once the
> playback is finished (either normally or by killing the application) the
> clocks are still present.  Restarting playback causes the clock to stop
> immediately and the generation of a DMA error.  Subsequent iterations
> repeat the same behaviour, as does recording.
> 
>>  	case SNDRV_PCM_TRIGGER_RESUME:
>> @@ -252,13 +254,11 @@ static void pxa2xx_i2s_shutdown(struct snd_pcm_substream *substream,
>>  		SAIMR &= ~SAIMR_RFS;
>>  	}
>>  
>> -	if (SACR1 & (SACR1_DREC | SACR1_DRPL)) {
>> +	if ((SACR1 & (SACR1_DREC | SACR1_DRPL)) == (SACR1_DREC | SACR1_DRPL)) {
>>  		SACR0 &= ~SACR0_ENB;
>>  		pxa_i2s_wait();
>>  		clk_disable(clk_i2s);
>>  	}
> 
> The problem happens because this code no longer triggers - since the
> port is still being reset on startup if the DAI is inactive the first
> patch will have no effect on DREC and DRPL, they'll be reset to their
> power on default of enabled when startup() is first called.  Applying
> your third patch which removes the port reset avoids that issue.
> 
Indeed, I should have put the port reset in 2/4 or in 1/4 rather than in
3/4 !

> Unfortunately there's still the outstanding issue with the third patch
> removing the FIFO flushes - looking at the datasheet I think we do need
> to clear the FIFOs, especially in the case where the PXA is running as
> slave and might've had clocks removed.  Section 14.4.7.2 explicitly says
> there are situations where the FIFO might not be drained and I'd really
> not be surprised if there were others.
> 
> I'm out of time to look at this today - I expect that the fix is
> probably to move some version of the port reset change into this patch.
I'd go for moving port reset into 2/4 (or 1/4 ?), 3/4 would just remove
clk_disable(clk_i2s) and leave the FIFO flushes as is, and keeping 4/4.
What do you say ?

-- 
Karl
