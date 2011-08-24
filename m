From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH 1/1] ASoC: soc-core: check rate for
 symmetry only when pcm is ongoing
Date: Wed, 24 Aug 2011 10:30:50 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F772223ECB@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1314172640-26972-1-git-send-email-b29396@freescale.com>
	<20110824091902.GR9232@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by alsa0.perex.cz (Postfix) with ESMTP id 0CE8524989
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 12:30:56 +0200 (CEST)
In-Reply-To: <20110824091902.GR9232@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Wednesday, August 24, 2011 5:19 PM
> To: Dong Aisheng-B29396
> Cc: alsa-devel@alsa-project.org; linux-arm-kernel@lists.infradead.org;
> lrg@ti.com; s.hauer@pengutronix.de; w.sang@pengutronix.de
> Subject: Re: [PATCH 1/1] ASoC: soc-core: check rate for symmetry only
> when pcm is ongoing
> 
> On Wed, Aug 24, 2011 at 03:57:20PM +0800, Dong Aisheng wrote:
> 
> > Now we only check rate for symmetry when the pcm is really ongoing
> > which seems more sensible.
> 
> There's a genuine issue here due to the raciness of the ALSA APIs - we're
> not enforcing constraints and we should be.  If the two programs end up
> setting incompatible rates we need to handle that.
Yes, I also noticed that.
I did not find a proper fix since we may not imagine the execute sequence of
user level.
Anyway, this patch is for fixing the wrong warning message.

> >  	/* Symmetry data - only valid if symmetry is being enforced */
> >  	unsigned int rate;
> > +	unsigned int ongoing;
> 
> This isn't a clear name, I don't understand it.
How about change to active?

> > @@ -209,6 +212,7 @@ static int soc_pcm_open(struct snd_pcm_substream
> *substream)
> >  	cpu_dai->active++;
> >  	codec_dai->active++;
> >  	rtd->codec->active++;
> > +	rtd->ongoing = 1;
> >  	mutex_unlock(&rtd->pcm_mutex);
> >  	return 0;
> >
> > @@ -322,6 +326,7 @@ static int soc_pcm_close(struct snd_pcm_substream
> *substream)
> >  			SND_SOC_DAPM_STREAM_STOP);
> >  	}
> >
> > +	rtd->ongoing = 0;
> 
> What happens when the stream in one direction is stopped but not the
> other?  For example, capture stops but playback continues.
Yes, that's an issue which I neglected.
Thanks for the reminder.
I'm going to use a ref-counter as cpu_dai->active.
So the code could be like when open pcm, rtd->active++ and when close pcm, rtd->active--.

Regards
Dong Aisheng 
