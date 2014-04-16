From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: Using simple-card to replace kirkwood-t5325.c
Date: Wed, 16 Apr 2014 13:17:04 +0200
Message-ID: <20140416111704.GB11310@lunn.ch>
References: <20140415161302.GC1871@lunn.ch> <534D7D31.6040802@metafoo.de>
 <20140415222902.GI12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps0.lunn.ch (vps0.lunn.ch [178.209.37.122])
 by alsa0.perex.cz (Postfix) with ESMTP id C4B33265232
 for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2014 13:19:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140415222902.GI12304@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Xiubo Li <Li.Xiubo@freescale.com>, Jean Delvare <khali@linux-fr.org>
List-Id: alsa-devel@alsa-project.org

> > >static int t5325_hw_params(struct snd_pcm_substream *substream,
> > >        	   struct snd_pcm_hw_params *params)
> > >{
> 
> > >This seems a lot less common requirements. All the Marvell SoCs need
> > >it, but not many others. So i don't think it makes sense to add it
> > >directly to simple-card, otherwise simple-card quickly becomes
> > >complex-card as everybody else wants there quirks adding.
> 
> > Maybe the drivers can be reworked to not require this anymore. The CODEC
> > driver may be able to figure this out on its own.
> 
> I don't think it can, that looks like the CODEC MCLK being supplied by
> the SoC (it's nothing to do with a requirement from the SoC really).
> Ideally this would be handled through the clock API but that's a bit
> fail at the minute for architecture neutral code.  It's a bit of a hack
> but specifying the ratio in the DT (which I thought we supported in
> simple-card already but don't seem to) would sidestep the issue.

I can go the hack route and add the ratio as a DT property. I just
thought i would ask now, rather than get a NACK later when i submit
the patch.

    Thanks
	Andrew
