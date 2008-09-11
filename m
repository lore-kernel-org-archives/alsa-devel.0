From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/4] Separate common pxa2xx-pcm code
Date: Thu, 11 Sep 2008 15:34:42 +0100
Message-ID: <20080911143441.GB12311@sirena.org.uk>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
	<1221008480-13377-2-git-send-email-dbaryshkov@gmail.com>
	<1221008480-13377-3-git-send-email-dbaryshkov@gmail.com>
	<1221008480-13377-4-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id B1495243BC
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Sep 2008 16:34:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221008480-13377-4-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 10, 2008 at 05:01:20AM +0400, Dmitry Baryshkov wrote:

>  config SND_PXA2XX_LIB
>  	tristate
> -	select SND_AC97_CODEC
> +	select SND_AC97_CODEC if SND_PXA2XX_LIB_AC97
> +
> +config SND_PXA2XX_LIB_AC97
> +	bool
>  
>  config SND_PXA2XX_AC97
>  	tristate "AC97 driver for the Intel PXA2xx chip"
>  	depends on ARCH_PXA
>  	select SND_PXA2XX_PCM
> -	select SND_PXA2XX_LIB
> +	select SND_PXA2XX_LIB_AC97

The select on SND_PXA2XX_LIB needs to stay since SND_PXA2XX_LIB_AC97
only does anything if SND_PXA2XX_LIB is selected.  Again, I'll fix this
up locally.
