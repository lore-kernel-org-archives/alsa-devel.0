From: Daniel Mack <daniel@caiaq.de>
Subject: Re: [RFC PATCH 4/5] ASoC: remove those
	unnecessary	#ifdef CONFIG_PXA3xx .. #endif
Date: Thu, 23 Apr 2009 09:08:15 +0200
Message-ID: <20090423070815.GB23901@buzzloop.caiaq.de>
References: <f17812d70904222206h27c58e40t5c8383133df1a7d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 951CA103820
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Apr 2009 09:08:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70904222206h27c58e40t5c8383133df1a7d0@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

Hi Eric,

On Thu, Apr 23, 2009 at 01:06:55PM +0800, Eric Miao wrote:
> @@ -652,10 +643,8 @@ static int pxa_ssp_hw_params(struct
> snd_pcm_substream *substream,
>  	sscr0 = ssp_read_reg(ssp, SSCR0);
>  	switch (params_format(params)) {
>  	case SNDRV_PCM_FORMAT_S16_LE:
> -#ifdef CONFIG_PXA3xx
>  		if (cpu_is_pxa3xx())
>  			sscr0 |= SSCR0_FPCKE;
> -#endif
>  		sscr0 |= SSCR0_DataSize(16);
>  		break;
>  	case SNDRV_PCM_FORMAT_S24_LE:
> @@ -682,7 +671,6 @@ static int pxa_ssp_hw_params(struct
> snd_pcm_substream *substream,
>  			* needed for that mode are only available on PXA3xx.
>  			*/
> 
> -#ifdef CONFIG_PXA3xx
>  			if (!cpu_is_pxa3xx())
>  				return -EINVAL;
> 
> @@ -691,9 +679,6 @@ static int pxa_ssp_hw_params(struct
> snd_pcm_substream *substream,
>  			sspsp |= SSPSP_EDMYSTOP(3);
>  			sspsp |= SSPSP_DMYSTOP(3);
>  			sspsp |= SSPSP_DMYSTRT(1);

These macros are only defined for PXA3xx since the register bits are not
used on other PXAs. Hence, the usage of these macros must be conditional
as well. Was this ever compiled for PXA2xx?

Daniel
