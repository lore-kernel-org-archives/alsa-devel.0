From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] sound/spi: patch for the unuseful variable
	removal
Date: Mon, 07 Jun 2010 13:52:40 +0100
Message-ID: <1275915160.3045.106.camel@odin>
References: <4C08B9A0.5000408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A9272103872
	for <alsa-devel@alsa-project.org>;
	Mon,  7 Jun 2010 15:19:28 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2420272wwf.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Jun 2010 06:19:23 -0700 (PDT)
In-Reply-To: <4C08B9A0.5000408@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-06-04 at 16:30 +0800, Wan ZongShun wrote:
> The '*bitclk' of structure 'snd_at73c213' seems no use
> ,so I make a patch to remove the unnecessary variable.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> ---
>  sound/spi/at73c213.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
> index 4c7b051..1bc56b2 100644
> --- a/sound/spi/at73c213.c
> +++ b/sound/spi/at73c213.c
> @@ -69,7 +69,6 @@ struct snd_at73c213 {
>  	int				irq;
>  	int				period;
>  	unsigned long			bitrate;
> -	struct clk			*bitclk;
>  	struct ssc_device		*ssc;
>  	struct spi_device		*spi;
>  	u8				spi_wbuffer[2];

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
