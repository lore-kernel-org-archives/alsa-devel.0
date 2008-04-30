From: Daniel Mack <daniel@caiaq.org>
Subject: Re: [PATCH] asoc tlv320aic3x: set power bits correctly
Date: Wed, 30 Apr 2008 15:11:06 +0200
Message-ID: <80ACB17D-E7D2-4A4C-81F8-620C2D661781@caiaq.org>
References: <20080430093719.GA13740@buzzloop.caiaq.de>
	<20080430095747.GA28593@sirena.org.uk>
	<bd7b27490804300450sc6c69d1v2edf2a8dca44bda@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id F398124662
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Apr 2008 15:11:17 +0200 (CEST)
In-Reply-To: <bd7b27490804300450sc6c69d1v2edf2a8dca44bda@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Jarkko,

On 30.04.2008, at 13:50, Jarkko Nikula wrote:

> I was looking do we have possible driver bug here and answer is no.  
> Driver keeps output state powered during playback if associated  
> endpoint is enabled with snd_soc_dapm_set_endpoint and unpowered  
> otherwise.
>
> So as with Mark's comment, the patch is unnecessary.

Hmm, ok - I might have a lack of knowledge here. All I was seeing with  
an I2C hardware analyzer is that those registers in question were  
written without the power bit set which makes them remain muted.  
What's the way to power up this entity properly?

And as we're on it - aic3x_dapm_event(SNDRV_CTL_POWER_D3cold) is  
called shortly after PCM playback has finished which clears the power  
bits of many registers. This in turn also makes the current PGA mixer  
setting become unfunctional as the outputs are switched off. Is there  
a proper way of preventing the glue layer to power down the chip in  
this case?

Thanks,
Daniel
