From: Ben Dooks <ben@trinity.fluff.org>
Subject: Re: [PATCH] ASoC: rsnd: fixup SSI interrupts style of
 DeviceTree
Date: Fri, 30 May 2014 11:53:21 +0100
Message-ID: <20140530105321.GD6241@trinity.fluff.org>
References: <87sinrpofv.wl%kuninori.morimoto.gx@gmail.com>
 <20140530102358.GC6241@trinity.fluff.org>
 <87k393pmvv.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from trinity.fluff.org (trinity.fluff.org [89.16.178.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B7E8261735
 for <alsa-devel@alsa-project.org>; Fri, 30 May 2014 12:53:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <87k393pmvv.wl%kuninori.morimoto.gx@renesas.com>
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

On Fri, May 30, 2014 at 03:43:50AM -0700, Kuninori Morimoto wrote:
> Hi Ben
> 
> Thank you for your feedback
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Current SSI interrupts has been set to each port.
> > > But it is too ugly style.
> > > SSI interrupts will be listed under
> > > rcar_sound,ssi node by this patch
> > > 
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> (snip)
> > This looks like a backward step, especially as we use the ssiX
> > blocks for DMA too.
> > 
> > Also, please just stop playing around with this stuff, other people
> > are trying to use this code and changing it without a good technical
> > reason is causing difficulty.
> 
> Hmm...
> This driver is still under developing.
> And it is very difficult for me to care about out-of-tree Linux.

Ok, but we really need to keep in mind that the DT should be kept as
stable as possible. We may be out of tree at the moment, but we are
trying our best to keep track and feed back our work. This is not
helped if we have to do these changes when re-basing.

In my view this change does not help the readability, as we now have
a large block of interrupts, where before we could easily work out
which interrupt was mapped to which SSI.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
