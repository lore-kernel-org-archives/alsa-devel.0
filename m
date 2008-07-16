From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Requiring the same sample rate for playback
	and	record?
Date: Wed, 16 Jul 2008 16:17:48 +0100
Message-ID: <1216221468.6734.5.camel@odin>
References: <485C0042.4050008@freescale.com>	<s5h7icg4dsd.wl%tiwai@suse.de>
	<487BC430.8040109@freescale.com> <s5hmyki14d5.wl%tiwai@suse.de>
	<487E0F9F.1060401@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 64D3524469
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 17:17:49 +0200 (CEST)
In-Reply-To: <487E0F9F.1060401@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2008-07-16 at 10:11 -0500, Timur Tabi wrote:
> Takashi Iwai wrote:
> 
> > In a simple case, you don't need hw_constraint functions.  Just
> > override the corresponding fields of runtime->hw in open callback.
> > 
> > For example, pci/via82xx.c sets the current rate value to
> > runtime->hw.rate_min/max if there is another stream.
> 
> Are you talking about this code:
> 
> 	} else {
> 		/* a fixed rate */
> 		runtime->hw.rates = SNDRV_PCM_RATE_KNOT;
> 		runtime->hw.rate_max = runtime->hw.rate_min = ratep->rate;
> 	}
> 
> Last I heard, ASoC doesn't work with SNDRV_PCM_RATE_KNOT.  But I think I can
> still use this method.  I'll just need to use a real SNDRV_PCM_RATE_xxx value.
> 

Supporting KNOT in the core is probably the best solution. It shouldn't
be too hard at add ....

Liam
