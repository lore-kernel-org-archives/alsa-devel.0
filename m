From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 1/4] Separate common pxa2xx-ac97 code
Date: Thu, 11 Sep 2008 15:30:07 +0100
Message-ID: <20080911143005.GA12311@sirena.org.uk>
References: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FE8C243BC
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Sep 2008 16:30:08 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221008480-13377-1-git-send-email-dbaryshkov@gmail.com>
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

On Wed, Sep 10, 2008 at 05:01:17AM +0400, Dmitry Baryshkov wrote:

> +config SND_PXA2XX_LIB
> +	tristate
> +	select SND_AC97_CODEC
> +
>  config SND_PXA2XX_AC97
>  	tristate "AC97 driver for the Intel PXA2xx chip"
>  	depends on ARCH_PXA
>  	select SND_PXA2XX_PCM
> -	select SND_AC97_CODEC
> +	select SND_PXA2XX_LIB
>  	help

Since select ignores dependency information in the selected thing the
select for SND_AC97_CODEC needs to stay in SND_PXA2XX_AC97.  I'll fix
this up locally.
