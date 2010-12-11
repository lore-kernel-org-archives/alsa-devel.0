From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 2/3] ASoC: twl6040: Add jack support for
 headset and handset
Date: Sat, 11 Dec 2010 11:18:22 +0000
Message-ID: <20101211111821.GA9380@opensource.wolfsonmicro.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4E225CC@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FD542417E
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 12:18:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4E225CC@dlee06.ent.ti.com>
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

On Fri, Dec 10, 2010 at 08:45:17PM -0600, Olaya, Margarita wrote:
> From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> 
> This patch adds support for reporting twl6040 headset and
> handset jack events.
> 
> The machine driver retrieves and report the status  through
> twl6040_hs_jack_detect.
> 
> A workq is used to debounce of the irq.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

but...

> +void twl6040_hs_jack_detect(struct snd_soc_codec *codec,
> +				struct snd_soc_jack *jack, int report)
> +{
> +	struct twl6040_data *priv = snd_soc_codec_get_drvdata(codec);
> +	struct twl6040_jack_data *hs_jack = &priv->hs_jack;
> +
> +	hs_jack->jack = jack;
> +	hs_jack->report = report;
> +
> +	twl6040_hs_jack_report(codec, hs_jack->jack, hs_jack->report);
> +}
> +EXPORT_SYMBOL_GPL(twl6040_hs_jack_detect);

...note that this doesn't actually enable and disable jack detection so
you might find some system integration issues if the jack detection
misbehaves when not wired up as expected on the board.
