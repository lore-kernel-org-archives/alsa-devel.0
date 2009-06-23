From: Steve Sakoman <steve@sakoman.com>
Subject: Re: [PATCH 3/3] ASoC: TWL4030: Fix voice interface
 clock masters
Date: Tue, 23 Jun 2009 06:10:16 -0700
Message-ID: <1245762616.10335.16.camel@tera>
References: <67059DBF19D7214F9C66BB0EA91BA90E3543F31E@dlee04.ent.ti.com>
	<200906220935.27903.peter.ujfalusi@nokia.com>
	<20090622102505.GA4730@sirena.org.uk>
	<200906231010.38207.peter.ujfalusi@nokia.com>
Reply-To: steve@sakoman.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx09.roch.ny.frontiernet.net (mx09.roch.ny.frontiernet.net
	[66.133.183.226])
	by alsa0.perex.cz (Postfix) with ESMTP id A95A124716
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 15:10:06 +0200 (CEST)
In-Reply-To: <200906231010.38207.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, ext Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2009-06-23 at 10:10 +0300, Peter Ujfalusi wrote:
> Hello Mark,
> 
> On Monday 22 June 2009 13:25:07 ext Mark Brown wrote:
> > On Mon, Jun 22, 2009 at 09:35:27AM +0300, Peter Ujfalusi wrote:
> > > On Friday 19 June 2009 11:23:42 ext Lopez Cruz, Misael wrote:
> > > > Voice interface of twl4030 codec supports: CBM_CFM and
> > > > CBS_CFS. It doesn't support CBS_CFM.
> > >
> > > Acked-By: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> >
> > Applied, thanks.
> >
> > Peter, you might want to submit a MAINTAINERS entry for TWL4030 - you're
> > doing a lot of good review there.
> 
> Do you mean something like this:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1ae5a81..1c04143 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5523,6 +5523,13 @@ M:       dsaxena@plexity.net
>  S:     Maintained
>  F:     drivers/char/hw_random/omap-rng.c
> 
> +TI TWL4030 SERIES SOC CODEC DRIVER
> +P:     Peter Ujflausi
> +M:     peter.ujfalusi@nokia.com
> +L:     alsa-devel@alsa-project.org
> +S:     Maintained
> +F:     sound/soc/codecs/twl4030*
> +
>  TIPC NETWORK LAYER
>  P:     Per Liden
>  M:     per.liden@ericsson.com
> 
> It would be a honor...
> But before sending such a patch, I guess Steve Sakoman should give his 
> blessing to it (he is the original author of the twl4030 codec driver). Or 
> perhaps someone else also?

You definitely have my blessing!  You've done great work :-)

Steve
