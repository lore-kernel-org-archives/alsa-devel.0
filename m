From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/2] ASoC: PXA: Fix jack detection on Zipit
	Z2
Date: Tue, 18 Jan 2011 15:09:30 +0000
Message-ID: <1295363370.3299.41.camel@odin>
References: <1295362465-21794-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 6BDD124623
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 16:09:37 +0100 (CET)
Received: by wyi11 with SMTP id 11so6283598wyi.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 07:09:37 -0800 (PST)
In-Reply-To: <1295362465-21794-1-git-send-email-anarsoul@gmail.com>
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

On Tue, 2011-01-18 at 16:54 +0200, Vasily Khoruzhick wrote:
> Fix jack detection on Zipit Z2, otherwise it
> disables headphones output when jack is connected
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  sound/soc/pxa/z2.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
> index 4cc841b..0da889d 100644
> --- a/sound/soc/pxa/z2.c
> +++ b/sound/soc/pxa/z2.c
> @@ -105,6 +105,7 @@ static struct snd_soc_jack_gpio hs_jack_gpios[] = {
>  		.name		= "hsdet-gpio",
>  		.report		= SND_JACK_HEADSET,
>  		.debounce_time	= 200,
> +		.invert		= 1,
>  	},
>  };

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
