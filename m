From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Use codec mutex in dapm_set_pga()
Date: Thu, 1 Oct 2009 13:45:14 +0100
Message-ID: <20091001124514.GB21973@rakim.wolfsonmicro.main>
References: <1254377856-5588-1-git-send-email-ext-eero.nurkkala@nokia.com>
	<20091001103714.GB14417@sirena.org.uk>
	<1254394869.2472.25.camel@eenurkka-desktop>
	<1254398184.2472.45.camel@eenurkka-desktop>
	<20091001120931.GF19998@rakim.wolfsonmicro.main>
	<1254400486.2472.50.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A87E10393F
	for <alsa-devel@alsa-project.org>;
	Thu,  1 Oct 2009 14:45:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1254400486.2472.50.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 01, 2009 at 03:34:46PM +0300, Eero Nurkkala wrote:

> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2071,9 +2071,9 @@ int snd_soc_dapm_stream_event(struct snd_soc_codec
> *codec,
>  			}
>  		}
>  	}
> -	mutex_unlock(&codec->mutex);
>  
>  	dapm_power_widgets(codec, event);
> +	mutex_unlock(&codec->mutex);
>  	dump_dapm(codec, __func__);
>  	return 0;
>  }
> 

> Does that make any sense?

Looks plausible, I'd need to check properly for gotchas but it's not
like we're not taking the mutex in that path already and
dapm_power_widgets() certainly ought to have the lock.  Looks like this
has been there since DAPM was originally merged.
