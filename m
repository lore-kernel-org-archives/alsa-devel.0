From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/8] ASoC: da7210: Add support for line
 out and DAC
Date: Fri, 14 Oct 2011 20:14:46 +0100
Message-ID: <20111014191445.GC2931@opensource.wolfsonmicro.com>
References: <1318590245.12107.514.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7B56B24450
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 21:14:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318590245.12107.514.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 14, 2011 at 04:34:05PM +0530, Ashish Chavan wrote:

> +	/* Enable Line out amplifiers */
> +	snd_soc_write(codec, DA7210_OUT1_L, DA7210_OUT1_L_EN);
> +	snd_soc_write(codec, DA7210_OUT1_R, DA7210_OUT1_R_EN);
> +	snd_soc_write(codec, DA7210_OUT2, DA7210_OUT2_EN |
> +		     DA7210_OUT2_OUTMIX_L | DA7210_OUT2_OUTMIX_R);
> +

So, part of the reason I was complaining about you having the DAPM
conversion patch last is that in a driver using DAPM I'd really not
expect to see code like this which open codes register writes to enable
outputs, I'd expect the enables to be being done using DAPM.
