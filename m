From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 02/15] ASoC: twl6040: Modify the IRQ handler
Date: Tue, 7 Dec 2010 13:15:20 +0000
Message-ID: <20101207131520.GI4698@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCC8@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 027AC10381B
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 14:15:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4CFBCC8@dlee06.ent.ti.com>
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

On Mon, Dec 06, 2010 at 06:17:44PM -0600, Olaya, Margarita wrote:

> +	if (intid & TWL6040_PLUGINT)
> +		dev_alert(codec->dev, "headset plug detection\n");
> +
> +	if (intid & TWL6040_UNPLUGINT)
> +		dev_alert(codec->dev, "headset unplug detection\n");

This is where I'd expect to see the jack detection patch adding handling
of the IRQ.

dev_alert() seems too much also - it would usually mean that something
went seriously wrong (like the over current warnings).

>  	return IRQ_HANDLED;
>  }

I'd expect this only if we actually detected (and therefore handled) an
event?
