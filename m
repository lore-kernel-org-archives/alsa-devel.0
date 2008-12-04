From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 Pandora
Date: Thu, 4 Dec 2008 15:07:15 +0000
Message-ID: <20081204150713.GE8019@sirena.org.uk>
References: <1228402355-10970-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F3BC81037F6
	for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2008 16:07:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228402355-10970-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 04, 2008 at 04:52:35PM +0200, Grazvydas Ignotas wrote:

> I'm not sure if splitting DAPM and widgets was good idea, I can adjust
> if needed.

That's a bit odd but fine - since the init is done per-DAI it makes some
sense, especially given that the output path is going via this external
DAC so is almost a separate device.

> The map is also not quite right, it says headphone jack is connected
> to TWL4030 codec OUTL and OUTR, but that is not really the case. It is
> connected to external DAC, and DAC is connected to OMAP. However DAC uses
> clock from TWL4030, so TWL needs to be active. I've basically done that
> connection to get event callback, where I can switch DAC and headphone
> amp on/off.

Hrm, interesting configuration.  It'd be good to put this in the driver
as comments somewhere so that someone picking up the driver knows what's
going on.  It'd be a bit nicer to handle this by adding widgets for the
DAC and amplifier but we don't have GPIO based DAPM widgets currently.

Also, I suspect that you'll get better pop/click performance if you
power the amp off before the DAC on teardown - as things stand you'll
amplify any artefacts you get when disabling the DAC.

> +/* Audio subsystem */
> +static struct snd_soc_device omap3pandora_snd_data = {
> +       .card = &snd_soc_card_omap3pandora,
> +       .platform = &omap_soc_platform,
> +       .codec_dev = &soc_codec_dev_twl4030,
> +};

Current git moves platform to the card structure.
