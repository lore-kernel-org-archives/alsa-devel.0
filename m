From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: multi-comp: soc-core: Fix for
 machine given DAPM widgets
Date: Thu, 05 Aug 2010 13:46:11 +0100
Message-ID: <1281012371.3076.114.camel@odin>
References: <1280988470-21133-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100805121347.GF13146@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 67B1C1038D2
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 14:46:14 +0200 (CEST)
Received: by wyb42 with SMTP id 42so6505322wyb.38
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 05:46:14 -0700 (PDT)
In-Reply-To: <20100805121347.GF13146@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-05 at 13:13 +0100, Mark Brown wrote:
> On Thu, Aug 05, 2010 at 09:07:50AM +0300, Peter Ujfalusi wrote:
> > Move the DAPM initialization after the machine driver has
> > finished it's init (dai_link driver).
> > Since in machine init we can add DAPM widgets we need to
> > take them into account as well.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 

Applied.

> but...
> 
> > @@ -1375,6 +1372,10 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
> >  		}
> >  	}
> >  
> > +	/* Make sure all DAPM widgets are instantiated */
> > +	snd_soc_dapm_new_widgets(codec);
> > +	snd_soc_dapm_sync(codec);
> > +
> >  	/* register the rtd device */
> >  	rtd->dev.init_name = rtd->dai_link->stream_name;
> >  	rtd->dev.release = rtd_release;
> 
> ...it'd be better to find a home for this that was per card rather than
> per link I guess, that way we only need to iterate through once during
> instantiation.  A bit irrelevant though given that it's hardly a hot
> path.

Agreed, lets tackle that as an incremental patch after the merge.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
