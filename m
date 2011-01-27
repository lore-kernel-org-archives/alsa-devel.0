From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: omap: rx51: Add earphone support
Date: Thu, 27 Jan 2011 15:27:18 +0000
Message-ID: <20110127152718.GB9774@opensource.wolfsonmicro.com>
References: <1296139632-17457-1-git-send-email-jhnikula@gmail.com>
	<1296139632-17457-2-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E331246A8
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 16:27:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296139632-17457-2-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 27, 2011 at 04:47:12PM +0200, Jarkko Nikula wrote:

> +	rx51_ear_func = ucontrol->value.integer.value[0];
> +	if (rx51_ear_func)
> +		snd_soc_dapm_enable_pin(dapm, "Earphone");
> +	else
> +		snd_soc_dapm_disable_pin(dapm, "Earphone");
> +

This looks like a PIN_SWITCH() DAPM control?
