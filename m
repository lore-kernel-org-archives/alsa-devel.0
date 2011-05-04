From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 08/19] ASoC: upd9976: add DMIC support
Date: Wed, 4 May 2011 16:03:39 +0100
Message-ID: <20110504150339.GC7366@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134534.32443.79243.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CB98024460
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 17:03:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504134534.32443.79243.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wang Xingchao <xingchao.wang@intel.com>, Koul Vinod <vinod.koul@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 09:45:34PM +0800, Lu Guanqun wrote:
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
  
> +	SND_SOC_DAPM_MIXER("PCM2 IN Mix", SND_SOC_NOPM, 0, 0, NULL, 0),
> +	SND_SOC_DAPM_MIXER("PCM2 IN No Mix", SND_SOC_NOPM, 0, 0, NULL, 0),

Mixer instead of Mix?

> +	/* Mux */
> +	SND_SOC_DAPM_MUX("PCM2 Left", SND_SOC_NOPM, 0, 0,
> +			 &upd9976_pcm2_left_mux_control),
> +	SND_SOC_DAPM_MUX("PCM2 Right", SND_SOC_NOPM, 0, 0,
> +			 &upd9976_pcm2_right_mux_control),

Append Mux.

>  	/* PGA */
>  	SND_SOC_DAPM_PGA("HP Playback Left", UPD9976_DRVPOWERCTRL,
>  			 2, 0, NULL, 0),
>  	SND_SOC_DAPM_PGA("HP Playback Right", UPD9976_DRVPOWERCTRL,
>  			 1, 0, NULL, 0),
>  
> +	SND_SOC_DAPM_PGA("AADC Left", SND_SOC_NOPM, 0, 0, NULL, 0),
> +	SND_SOC_DAPM_PGA("AADC Right", SND_SOC_NOPM, 0, 0, NULL, 0),
> +
> +	SND_SOC_DAPM_PGA("DMIC Gain", UPD9976_DMICCTRL1, 7, 0, NULL, 0),

Append PGA.

Thanks,
Dimitris
