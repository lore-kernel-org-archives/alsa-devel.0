From: "Lu, Guanqun" <guanqun.lu@intel.com>
Subject: Re: [PATCH] ASoC: sound:soc:soc-core fix one
	small	indentation issue
Date: Mon, 7 Mar 2011 23:18:06 +0800
Message-ID: <5D8008F58939784290FAB48F5497519835EF1C5638@shsmsx502.ccr.corp.intel.com>
References: <1299510885-3133-1-git-send-email-guanqun.lu@intel.com>
	<20110307151622.GH1829@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D07A2447F
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 16:19:38 +0100 (CET)
In-Reply-To: <20110307151622.GH1829@sirena.org.uk>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com]
> Sent: Monday, March 07, 2011 11:16 PM
> To: Lu, Guanqun
> Cc: alsa-devel@alsa-project.org; lrg@slimlogic.co.uk
> Subject: Re: [alsa-devel] [PATCH] ASoC: sound:soc:soc-core fix one small
> indentation issue
> 
> On Mon, Mar 07, 2011 at 11:14:45PM +0800, Lu Guanqun wrote:
> > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> 
> Please remember to CC maintainers on patches - in general please follow
> the approach in Documentation/SubmittingPatches.

Sorry about that.
Adding maintainers here.

--guanqun

> 
> > ---
> >  sound/soc/soc-core.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> > index 64befac..f6ba502 100644
> > --- a/sound/soc/soc-core.c
> > +++ b/sound/soc/soc-core.c
> > @@ -3438,7 +3438,7 @@ int snd_soc_register_platform(struct device *dev,
> >
> >  	platform = kzalloc(sizeof(struct snd_soc_platform), GFP_KERNEL);
> >  	if (platform == NULL)
> > -			return -ENOMEM;
> > +		return -ENOMEM;
> >
> >  	/* create platform component name */
> >  	platform->name = fmt_single_name(dev, &platform->id);
> > --
> > 1.7.2.3
> >
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> 
> --
> "You grabbed my hand and we fell into it, like a daydream - or a fever."
