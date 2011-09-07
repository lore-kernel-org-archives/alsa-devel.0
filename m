From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 60/62] sound: irq: Remove IRQF_DISABLED
Date: Wed, 07 Sep 2011 11:36:33 +0300
Message-ID: <4946313.Ptpr0aqkpm@barack>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-61-git-send-email-yong.zhang0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog114.obsmtp.com (na3sys009aog114.obsmtp.com
	[74.125.149.211])
	by alsa0.perex.cz (Postfix) with ESMTP id 92ABB103833
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 10:36:40 +0200 (CEST)
Received: by bkbc12 with SMTP id c12so182936bkb.3
	for <alsa-devel@alsa-project.org>; Wed, 07 Sep 2011 01:36:37 -0700 (PDT)
In-Reply-To: <1315383059-3673-61-git-send-email-yong.zhang0@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yong Zhang <yong.zhang0@gmail.com>
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Jassi Brar <jassisinghbrar@gmail.com>, Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>, Axel Lin <axel.lin@gmail.com>, Liam Girdwood <lrg@ti.com>, cbe-oss-dev@lists.ozlabs.org, Wan ZongShun <mcuos.com@gmail.com>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, tglx@linutronix.de, Jarkko Nikula <jhnikula@retiisi.org.uk>, mingo@elte.hu, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Sangbeom Kim <sbkim73@samsung.com>, Jiri Kosina <jkosina@suse.cz>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Geoff Levand <geoff@infradead.org>, Paul Mundt <lethal@linux-sh.org>, Simon Horman <simon@horms.net>, Joe
List-Id: alsa-devel@alsa-project.org

On Wednesday 07 September 2011 16:10:57 Yong Zhang wrote:
> This flag is a NOOP and can be removed now.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

...

>  sound/soc/codecs/tlv320dac33.c     |    2 +-

..

> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index faa5e9f..243d177 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -1431,7 +1431,7 @@ static int dac33_soc_probe(struct snd_soc_codec
> *codec) /* Check if the IRQ number is valid and request it */
>  	if (dac33->irq >= 0) {
>  		ret = request_irq(dac33->irq, dac33_interrupt_handler,
> -				  IRQF_TRIGGER_RISING | IRQF_DISABLED,
> +				  IRQF_TRIGGER_RISING,
>  				  codec->name, codec);
>  		if (ret < 0) {
>  			dev_err(codec->dev, "Could not request IRQ%d (%d)\n",

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
