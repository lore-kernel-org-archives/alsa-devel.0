From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] ASoC: rsnd: add missing src/dst_addr_width
	for DMAEngine
Date: Tue, 22 Jul 2014 03:11:52 +0200
Message-ID: <3713363.Y2xICgEKrb@avalon>
References: <87sim0ece5.wl%kuninori.morimoto.gx@gmail.com>
 <7811387.1D8yB9HfiA@avalon> <87wqb6i7wn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [95.142.166.194])
 by alsa0.perex.cz (Postfix) with ESMTP id C64622654B6
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 03:11:41 +0200 (CEST)
In-Reply-To: <87wqb6i7wn.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

On Monday 21 July 2014 16:55:41 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Renesas new DMAEngine driver requests src/dst_addr_width
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> > > 
> > > >> Laurent
> > > 
> > > Could you please check and give your Ack to this patch?
> > 
> > What tree is the patch based on ? It doesn't apply on Takashi's latest
> > master branch. I need a bit of context to review it.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git ::
> topic/rcar
> 
> or Gerrt's driver tree

Of course :-)

I've tried to understand the driver and couldn't even find out which DMA 
controller was used :-/ I suspect it's the audio peri-peri DMAC, but I haven't 
been able to confirm that from the source code. If the assumption is true the 
patch looks OK to me, but if you need a formal Acked-by then I'll need you to 
guide me through the driver I'm afraid.

-- 
Regards,

Laurent Pinchart
