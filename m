From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 02/16] ASoC: twl6040: Modify the IRQ
	handler
Date: Sat, 11 Dec 2010 11:20:30 +0000
Message-ID: <20101211112029.GB9380@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4E225D1@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DE10C2439F
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 12:20:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4E225D1@dlee06.ent.ti.com>
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

On Fri, Dec 10, 2010 at 09:05:30PM -0600, Olaya, Margarita wrote:
> Multiples interrupts can be received. The irq handler is modified
> to attend all of them.
> 
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> -	case TWL6040_PLUGINT:
> -	case TWL6040_UNPLUGINT:
> +
> +	if ((intid & TWL6040_PLUGINT) || (intid & TWL6040_UNPLUGINT))
>  		queue_delayed_work(priv->workqueue, &priv->delayed_work,
>  							msecs_to_jiffies(200));
> -		break;

This is going to collide with your previous patch series to enable jack
detection.

> +	if (intid & TWL6040_HOOKINT)
> +		dev_info(codec->dev, "hook detection\n");
> +

This should be reported via the jack detection API - this would
generally be shown as a button to userspace.

>  
>  	return IRQ_HANDLED;
>  }

I'd still expect to see this only flagged if at least one of the
interrupt sources fired.
