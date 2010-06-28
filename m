From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH] ASoC: DaVinci: Added support for cpu
	clocking I2S
Date: Mon, 28 Jun 2010 12:11:13 -0700
Message-ID: <4C28F3D1.5060806@boundarydevices.com>
References: <1277707487-3371-1-git-send-email-lamiaposta71@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth00.csee.onr.siteprotect.com
	(smtpauth00.csee.onr.siteprotect.com [64.26.60.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C36224401
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 21:11:30 +0200 (CEST)
In-Reply-To: <1277707487-3371-1-git-send-email-lamiaposta71@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, Russell King <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Davide Bonfanti <davide.bonfanti@bticino.it>, Raffaele Recalcati <raffaele.recalcati@bticino.it>, Chaithrika U S <chaithrika@ti.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Raffaele Recalcati wrote:
> +		if (dev->i2s_fast_clock) {
> +			clk_div = 256;
can you have
   f = (freq / params->rate_num) * params->rate_den;
> +			do {
> +				framesize = (freq / (--clk_div)) /
> +					    params->rate_num *
> +					    params->rate_den;
and
				framesize = f / (--clk_div);
> +			} while (((framesize < 33) || (framesize > 4095)) &&
> +				 (clk_div));
> +			clk_div--;
looks like clk_div can go negative here, should the above while say (clk_div > 1)
> +			srgr |= DAVINCI_MCBSP_SRGR_FPER(framesize - 1);
> +		} else {
> +			/* symmetric waveforms */
> +			clk_div = freq / (mcbsp_word_length * 16) /
> +				  params->rate_num * params->rate_den;
> +			srgr |= DAVINCI_MCBSP_SRGR_FPER(mcbsp_word_length *
> +							16 - 1);
> +		}
> +		clk_div &= 0xFF;
> +		srgr |= clk_div;
