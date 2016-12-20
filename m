From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: add Component level struct
 snd_compr_ops
Date: Tue, 20 Dec 2016 10:02:50 +0000
Message-ID: <20161220100250.GP1867@localhost.localdomain>
References: <87a8bs74t5.wl%kuninori.morimoto.gx@renesas.com>
 <8737hk74l7.wl%kuninori.morimoto.gx@renesas.com>
 <20161219111235.GO1867@localhost.localdomain>
 <87inqffjkn.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id EFBDF266EC1
 for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2016 11:01:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87inqffjkn.wl%kuninori.morimoto.gx@renesas.com>
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

On Tue, Dec 20, 2016 at 01:59:43AM +0000, Kuninori Morimoto wrote:
> > > +	for_each_component(component, rtd->card) {
> > > +		const struct snd_compr_ops *compr_ops = component->compr_ops;
> > > +
> > > +		if (compr_ops && compr_ops->open) {
> > > +			int _ret = compr_ops->open(cstream);
> > > +
> > > +			if (_ret < 0) {
> > > +				pr_err("compress asoc: can't open component %s\n",
> > > +				       component->name);
> > > +				ret |= _ret;
> > > +			}
> > 
> > Apologies if I am missing something but this really doesn't look
> > like equivalent code? The old code calls the ops for the platform
> > associated with the stream, the new code looks like it will call
> > the ops for every single component in the system that has
> > compressed ops, which would definitely cause issue. Am I missing
> > something here?
> 
> Basically in *current* existing code, platform only has compr_ops.
> So, converting existing code to new code should be OK.
> 
> Current ALSA SoC clearly separating CPU/Codec/Platform, but in these days,
> new sound device has many features. Thus, it becaming difficult to
> say "it is XXX" today. For example, some Codec has CPU feature,
> some CPU has Platform feature etc.
> So, our (= Me/Lars) plan is that remove current CPU/Codec/Platform separation,
> and all will be Component connection.
> 
> Above code will call every component's compr_ops,
> currently, it should be platform now.
> But in the future device, Codec and/or CPU can have compr_ops.
> 
> If you want, currently, it can call 1st found compr_ops (= should be platform)
> only with FIXME comment at this point.
> 
> Does this clear answer for you ?
> 
> 	for_each_component(component, rtd->card) {
> 		const struct snd_compr_ops *compr_ops = component->compr_ops;
> 
> 		/* FIXME: 1st compr_ops only at this point */
> 		if (compr_ops && compr_ops->open) {

But how do you know this is the correct compressed open here? The
system could have multiple platforms providing compressed ops and
you have just picked the first one in the card list. I think you
are making the assumption that there is only one platform
providing compressed ops and that seems like a very dangerous
assumption to me. Our CODECs provide some compressed features as
do many applications processors, which would easily give you at
two platforms. But I could even imagine APs registering multiple
compressed platforms for different DSPs or some such.

Thanks,
Charles

> 			ret = compr_ops->open(cstream);
> 			if (ret < 0) {
> 				pr_err("compress asoc: can't open component %s\n",
> 				       component->name);
> 			}
> 			break;
> 		}
> 	}
