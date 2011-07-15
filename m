From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH REPOST] sound: codec: tlv320aic3x: remove
	mono controls
Date: Sat, 16 Jul 2011 00:46:31 +0900
Message-ID: <20110715154626.GG11154@opensource.wolfsonmicro.com>
References: <20110715121933.GB10026@opensource.wolfsonmicro.com>
	<1310744454-13790-1-git-send-email-j.weitzel@phytec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9D7D124340
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Jul 2011 17:46:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1310744454-13790-1-git-send-email-j.weitzel@phytec.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jan Weitzel <j.weitzel@phytec.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 15, 2011 at 05:40:54PM +0200, Jan Weitzel wrote:
> if codec driver is used for AIC3X_MODEL_3007 the mono iout controls overwrite
> registers for class-d amplifier.
> classd amplifier controls are only used for AIC3X_MODEL_3007.

> Removing all mono snd_kcontrol_new, snd_soc_dapm_widget, snd_soc_dapm_route
> and aic3x_init stuff from common code and call only for not AIC3X_MODEL_3007
> codecs.

This is clearly not what your subject line says...

>  	if (aic3x->model == AIC3X_MODEL_3007) {
>  		aic3x_init_3007(codec);
>  		snd_soc_write(codec, CLASSD_CTRL, 0);
> +
> +		return 0;
>  	}
> +	/* Not on AIC3X_MODEL_3007 init */
> +

This is really not great legibility and it's going to get terribly
confusing if someone comes up with some other device that also needs
custom init.  A similar issue applied to some of the other stuff but
this is the most obvious example.  I'd suggest restructuring this to
have all the mono-specific code in an if statement that postively
selects for the feature.

>  	if (aic3x->model == AIC3X_MODEL_3007)
>  		snd_soc_add_controls(codec, &aic3x_classd_amp_gain_ctrl, 1);
> -
> +	else
> +		snd_soc_add_controls(codec, aic3x_mono_controls,
> +					ARRAY_SIZE(aic3x_mono_controls));

This if ... else should really be a switch.
