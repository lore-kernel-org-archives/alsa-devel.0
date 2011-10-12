From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/9] ASoC: da7210: Add support for line out
 and DAC
Date: Wed, 12 Oct 2011 15:49:40 +0100
Message-ID: <20111012144940.GN3647@opensource.wolfsonmicro.com>
References: <1318431375.12107.398.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 163C6103983
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Oct 2011 16:49:42 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1318431375.12107.398.camel@matrix>
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
Cc: linux-kernel@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, lrg@ti.com, kuninori.morimoto.gx@renesas.com, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 12, 2011 at 08:26:15PM +0530, Ashish Chavan wrote:

> +	SOC_DOUBLE_R_TLV("DAC Playback Volume",
> +			 DA7210_DAC_L, DA7210_DAC_R,
> +			 0, 0x77, 1, dac_gain_tlv),

Digital Playback Volume.

> +	/* Set default DAC gain */
> +	snd_soc_write(codec, DA7210_DAC_L, DA7210_DFLT_DAC_GAIN);
> +	snd_soc_write(codec, DA7210_DAC_R, DA7210_DFLT_DAC_GAIN);

No, use chip defaults.
