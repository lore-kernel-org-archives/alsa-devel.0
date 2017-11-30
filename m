From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH v4 2/2] ASoC: fsl_ssi: add 20-bit sample
 format for AC'97 and use it for capture
Date: Wed, 29 Nov 2017 23:23:58 -0800
Message-ID: <20171130072357.GA992@Asurada>
References: <5dfa7813-385e-d9c7-84e0-12cf1f7d3a5f@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f179.google.com (mail-pf0-f179.google.com
 [209.85.192.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 597EB266A74
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 08:24:09 +0100 (CET)
Received: by mail-pf0-f179.google.com with SMTP id m26so2747620pfj.11
 for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2017 23:24:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5dfa7813-385e-d9c7-84e0-12cf1f7d3a5f@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

Hi Maciej,

On Mon, Nov 27, 2017 at 11:34:44PM +0100, Maciej S. Szmigiero wrote:
> There is no problem in using different bit widths in playback and capture
> in AC'97 mode so allow this, too.

> @@ -1557,11 +1558,12 @@ static int fsl_ssi_probe(struct platform_device *pdev)
>  
>  	/* Are the RX and the TX clocks locked? */
>  	if (!of_find_property(np, "fsl,ssi-asynchronous", NULL)) {
> -		if (!fsl_ssi_is_ac97(ssi_private))
> +		if (!fsl_ssi_is_ac97(ssi_private)) {
>  			ssi_private->cpu_dai_drv.symmetric_rates = 1;
> +			ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
> +		}
>  
>  		ssi_private->cpu_dai_drv.symmetric_channels = 1;
> -		ssi_private->cpu_dai_drv.symmetric_samplebits = 1;
>  	}

I was actually wondering how the AC97 works in the synchronous mode
while being able to handle different bit widths. Then I found that
the drivers does corresponding configurations for synchronous mode
only if symmetric_rates is set -- which is unset for AC97 cases. So
in fact AC97 case (symmetric_rates unset) is probably being treated
as asynchronous mode by the driver -- it'd be better if you confirm
this for me.

And I am not so sure about the physical pin connections in an AC97
situation, but I started to think that, instead of having a change
above, AC97 cases might be supposed to have "fsl,ssi-asynchronous"
property in DT since it's working when the driver sets both TX and
RX control registers (i.e. asynchronous mode), not like synchronous
mode that only sets TX's registers.

Thanks
Nicolin
