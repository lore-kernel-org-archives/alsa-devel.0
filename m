From: Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH] ASoC: rsnd: fixup 6ch settings to 8ch
Date: Tue, 27 Aug 2019 09:48:17 +0200
Message-ID: <20190827074817.GA27667@vmlxhi-102.adit-jv.com>
References: <877ebi1v1e.wl-kuninori.morimoto.gx@renesas.com>
 <20190826093032.GA24143@vmlxhi-102.adit-jv.com>
 <87lfvf5to9.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2B3A7F801ED
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2019 09:48:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87lfvf5to9.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Timo Wischer <twischer@de.adit-jv.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Andrew Gabbasov <andrew_gabbasov@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>, Jiada Wang <jiada_wang@mentor.com>, Mark Brown <broonie@kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>, Joshua Frkuska <joshua_frkuska@mentor.com>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

Thanks for the prompt reply.

On Tue, Aug 27, 2019 at 09:42:49AM +0900, Kuninori Morimoto wrote:
> 
> Hi Eugeniu
> 
> > We've been reviewing this patch in the context of Renesas-Yocto-v3.21.0
> > BSP integration, where it is contained as commit [1].
> 
> OK, now, you are using BSP.
> 
> > > diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
> > > index f5afab6..44bda21 100644
> > > --- a/sound/soc/sh/rcar/ssi.c
> > > +++ b/sound/soc/sh/rcar/ssi.c
> > > @@ -303,6 +303,8 @@ static int rsnd_ssi_master_clk_start(struct rsnd_mod *mod,
> > >  	if (rsnd_runtime_is_tdm_split(io))
> > >  		chan = rsnd_io_converted_chan(io);
> > >  
> > > +	chan = rsnd_channel_normalization(chan);
> > > +
> > 
> > Since the "chan" value is already normalized by calling:
> >  => rsnd_ssi_master_clk_start()
> >   => chan = rsnd_runtime_channel_for_ssi(io)
> >    => rsnd_runtime_channel_for_ssi_with_params()
> >     => rsnd_channel_normalization()
> > 
> > I was wondering if it is really required to call
> > rsnd_channel_normalization() second time in ssi.c for fixing the issue
> > described in this patch?
> 
> Please compare BSP and upstream patch.
> 
> 	BSP
> 	https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=54721f595654
> 
> 	upstream
> 	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=66287def435315d9d8de740da4c543e37630b897
> 
> I don't know detail of BSP side, but I guess it doesn't have TDM Split support (?).
> Because of that, it doesn't have (A) code.
> 
> 	int rsnd_ssi_master_clk_start(xxx)
> 	{
> 		...
> 		int chan = rsnd_runtime_channel_for_ssi(io);
> 		...
> 		if (rsnd_runtime_is_tdm_split(io))
> (A)			chan = rsnd_io_converted_chan(io);
> 
> 		chan = rsnd_channel_normalization(chan);
> 		...
> 	}

We've made the same observation. The BSP backport seems to be a NOOP
for rsnd_ssi_master_clk_start() due to lack of TDM split support.

However, my question touched a different aspect of the patch.
The comment added by commit [1] and preserved by commit [2] both
suggest that is solely 'TDM Extend' mode which needs 6-to-8 channel
adjustment. Your comment sounds like this also applies to 'TDM Split'?

Or for 'TDM Split' we only care to sanitize the channel value
(i.e. make sure it is in the 0..8 range)?

[1] v4.5-rc1 commit 8ec85e7f7e9a2f ("ASoC: rsnd: ssi enables non-stereo sound")
        [..]
        /* TDM Extend Mode needs 8ch */ 
        if (chan == 6) 
                chan = 8; 
        [..]

[2] v5.2-rc1 commit 66287def435315 ("ASoC: rsnd: fixup 6ch settings to 8ch")

-- 
Best Regards,
Eugeniu.
