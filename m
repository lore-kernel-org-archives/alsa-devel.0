From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: multi-comp: soc-core: Fix for
 machine given DAPM widgets
Date: Thu, 5 Aug 2010 13:13:48 +0100
Message-ID: <20100805121347.GF13146@rakim.wolfsonmicro.main>
References: <1280988470-21133-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5CAE31038C9
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 14:13:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1280988470-21133-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2010 at 09:07:50AM +0300, Peter Ujfalusi wrote:
> Move the DAPM initialization after the machine driver has
> finished it's init (dai_link driver).
> Since in machine init we can add DAPM widgets we need to
> take them into account as well.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but...

> @@ -1375,6 +1372,10 @@ static int soc_probe_dai_link(struct snd_soc_card *card, int num)
>  		}
>  	}
>  
> +	/* Make sure all DAPM widgets are instantiated */
> +	snd_soc_dapm_new_widgets(codec);
> +	snd_soc_dapm_sync(codec);
> +
>  	/* register the rtd device */
>  	rtd->dev.init_name = rtd->dai_link->stream_name;
>  	rtd->dev.release = rtd_release;

...it'd be better to find a home for this that was per card rather than
per link I guess, that way we only need to iterate through once during
instantiation.  A bit irrelevant though given that it's hardly a hot
path.
