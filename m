From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: add Component level struct
 snd_compr_ops
Date: Wed, 21 Dec 2016 09:29:22 +0000
Message-ID: <20161221092922.GQ1867@localhost.localdomain>
References: <87a8bs74t5.wl%kuninori.morimoto.gx@renesas.com>
 <8737hk74l7.wl%kuninori.morimoto.gx@renesas.com>
 <20161219111235.GO1867@localhost.localdomain>
 <87inqffjkn.wl%kuninori.morimoto.gx@renesas.com>
 <20161220100250.GP1867@localhost.localdomain>
 <87fulixgfu.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 39ED0266639
 for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2016 10:28:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87fulixgfu.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 21, 2016 at 12:42:21AM +0000, Kuninori Morimoto wrote:
> 
> Hi Charles
> 
> Thank you for your feedback
> 
> > > 	for_each_component(component, rtd->card) {
> > > 		const struct snd_compr_ops *compr_ops = component->compr_ops;
> > > 
> > > 		/* FIXME: 1st compr_ops only at this point */
> > > 		if (compr_ops && compr_ops->open) {
> > 
> > But how do you know this is the correct compressed open here? The
> > system could have multiple platforms providing compressed ops and
> > you have just picked the first one in the card list. I think you
> > are making the assumption that there is only one platform
> > providing compressed ops and that seems like a very dangerous
> > assumption to me. Our CODECs provide some compressed features as
> > do many applications processors, which would easily give you at
> > two platforms. But I could even imagine APs registering multiple
> > compressed platforms for different DSPs or some such.
> 
> I agree your opinion, and yes it can be issue in the future.
> But, this is the reason why it has /* FIXME */ comment here
> (will has in v2, not yet in v1).
> I don't know which one should be solved first, but this
> patch is focusing to part of platform -> component conversion now.
> No existing code/card get damage at this point, I think ?
> 
> So, how about this in v2 ?
> In comment and git log indicates
> "It is still assumeing that system has 1 compressed,
> same as current situation. Multi-compress is TBD."

Admittedly there are no machines currently in mainline that do
this but it will basically break on every single one of our
customer integrations, as most AP systems are supporting some
sort of compressed stream stuff now and our CODEC does as well.

I would really rather see this issue fixed before these patches
are merged, as if it gets merged I basically have to fix it
straight away anyway, or face some very painful integrations in
the future. I will try to find some time to look at this and see
if I can come up with a better solution for these parts of the
code but given the current time frame it is likely to push into
the new year.

Thanks,
Charles
