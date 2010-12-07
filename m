From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 07/15] ASoC: twl6040: Support other sample
	rates
Date: Tue, 7 Dec 2010 13:26:38 +0000
Message-ID: <20101207132637.GN4698@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCCD@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 06E4B103A6C
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:26:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCCD@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Olaya, Margarita" <magi.olaya@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 06, 2010 at 06:18:02PM -0600, Olaya, Margarita wrote:
> The twl6040 can support more sample rates other than 88.2 and 96k.
> 
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

>  	rate = params_rate(params);
>  	switch (rate) {
> +	case 11250:
> +	case 22500:
> +	case 44100:
>  	case 88200:
>  		lppllctl |= TWL6040_LPLLFIN;
>  		priv->sysclk = 17640000;
>  		break;
> +	case 8000:
> +	case 16000:
> +	case 32000:
> +	case 48000:
>  	case 96000:
>  		lppllctl &= ~TWL6040_LPLLFIN;
>  		priv->sysclk = 19200000;

I'd expect to see more code for this unless the CODEC is always running
as clock slave?
