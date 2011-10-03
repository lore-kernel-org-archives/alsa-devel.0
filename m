From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH] ASoC: Staticise ep93xx_ac97_dai
Date: Mon, 3 Oct 2011 08:53:53 +0300
Message-ID: <20111003055353.GA2673@mwesterb-mobl.ger.corp.intel.com>
References: <1317612785.5065.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7D90C243B3
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Oct 2011 07:54:03 +0200 (CEST)
Received: by bkbzu17 with SMTP id zu17so4866333bkb.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Oct 2011 22:54:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1317612785.5065.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 03, 2011 at 11:33:05AM +0800, Axel Lin wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Mika Westerberg <mika.westerberg@iki.fi>

> ---
>  sound/soc/ep93xx/ep93xx-ac97.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/ep93xx/ep93xx-ac97.c b/sound/soc/ep93xx/ep93xx-ac97.c
> index c7417c7..3cd6158 100644
> --- a/sound/soc/ep93xx/ep93xx-ac97.c
> +++ b/sound/soc/ep93xx/ep93xx-ac97.c
> @@ -335,7 +335,7 @@ static struct snd_soc_dai_ops ep93xx_ac97_dai_ops = {
>  	.trigger	= ep93xx_ac97_trigger,
>  };
>  
> -struct snd_soc_dai_driver ep93xx_ac97_dai = {
> +static struct snd_soc_dai_driver ep93xx_ac97_dai = {
>  	.name		= "ep93xx-ac97",
>  	.id		= 0,
>  	.ac97_control	= 1,
> -- 
> 1.7.4.1
> 
> 
