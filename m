From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH] cs4232: fix crash during chip PNP detection
Date: Wed, 23 Jul 2008 12:04:38 +0200
Message-ID: <48870236.1010506@keyaccess.nl>
References: <20080723074849.7c280237.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 9F2732434B
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 12:02:23 +0200 (CEST)
In-Reply-To: <20080723074849.7c280237.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 23-07-08 07:48, Krzysztof Helt wrote:

Jaroslav or Takashi: would like to be in .27. Not a regression, but very 
minimal fix.

> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> The acard->wss pointer is uninitialized in this function
> which leads to crash during chip PNP detection.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> ---
> This bug was found in the 2.6.26-git9 kernel.

ACK.

Looking back, it seems this was broken at least as far back as 2.6.20 
which would nicely show how much testing that code path gets. Do I 
understand correctly from the backtrace that you have the PNPBIOS 
hardware? If so, good...

> --- linux-2.6.26/sound/isa/cs423x/cs4236.c~	2008-07-23 07:40:16.129637645 +0200
> +++ linux-2.6.26/sound/isa/cs423x/cs4236.c	2008-07-23 07:40:32.905641806 +0200
> @@ -325,6 +325,7 @@ static int __devinit snd_cs423x_pnp_init
>  static int __devinit snd_card_cs4232_pnp(int dev, struct snd_card_cs4236 *acard,
>  					 struct pnp_dev *pdev)
>  {
> +	acard->wss = pdev;
>  	if (snd_cs423x_pnp_init_wss(dev, acard->wss) < 0)
>  		return -EBUSY;
>  	cport[dev] = -1;
> 

Acked-by: Rene Herman <rene.herman@gmail.com>

(I believe I noticed earlier that struct snd_cs4236->wss, ctrl and mpu 
really needn't/shouldn't be kept around in the first place and you could 
just pass pdev directly as well but that's for another cleanup; this has 
it look most similar to the card variant)

Rene.
