From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: PXA: z2: Mute internal speaker
 when headphones are connected
Date: Fri, 11 Mar 2011 11:15:04 +0000
Message-ID: <1299842104.3394.11.camel@odin>
References: <1299834338-9185-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 25A5E24433
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 12:15:13 +0100 (CET)
Received: by wyj26 with SMTP id 26so2237948wyj.38
	for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2011 03:15:12 -0800 (PST)
In-Reply-To: <1299834338-9185-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-03-11 at 11:05 +0200, Vasily Khoruzhick wrote:
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/pxa/z2.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
> index 3ceaef6..b0b6c8d 100644
> --- a/sound/soc/pxa/z2.c
> +++ b/sound/soc/pxa/z2.c
> @@ -95,6 +95,11 @@ static struct snd_soc_jack_pin hs_jack_pins[] = {
>  		.pin	= "Headphone Jack",
>  		.mask	= SND_JACK_HEADPHONE,
>  	},
> +	{
> +		.pin    = "Ext Spk",
> +		.mask   = SND_JACK_HEADPHONE,
> +		.invert = 1
> +	},
>  };
>  
>  /* Headset jack detection gpios */

Both

Acked-by: Liam Girdwood <lrg@ti.com>
