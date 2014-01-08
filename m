From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: utils: Add internal call to
 determine if DAI is dummy.
Date: Wed, 08 Jan 2014 11:49:15 +0000
Message-ID: <1389181755.2346.12.camel@loki>
References: <1389177619-2760-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hvbxu215f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A51CF261A1F
 for <alsa-devel@alsa-project.org>; Wed,  8 Jan 2014 12:49:18 +0100 (CET)
In-Reply-To: <s5hvbxu215f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-01-08 at 11:55 +0100, Takashi Iwai wrote:
> At Wed,  8 Jan 2014 10:40:18 +0000,
> Liam Girdwood wrote:
> > +
> >  struct snd_soc_dai_ops {
> >  	/*
> >  	 * DAI clocking configuration, all optional.
> > diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
> > index 6ebdfd9..7f22ca3 100644
> > --- a/sound/soc/soc-utils.c
> > +++ b/sound/soc/soc-utils.c
> > @@ -119,6 +119,13 @@ static struct snd_soc_dai_driver dummy_dai = {
> >  	 },
> >  };
> >  
> > +int snd_soc_dai_is_dummy(struct snd_soc_dai *dai)
> > +{
> > +	if (dai->driver == &dummy_dai)
> > +		return 1;
> > +	return 0;
> > +}
> 
> No need for EXPORT_SYMBOL since it's for internal use only, or just
> forgotten?

No need for the EXPORT_SYMBOL as the core soc-*.c files are linked into
the same module and it's for internal use only.

Liam 
