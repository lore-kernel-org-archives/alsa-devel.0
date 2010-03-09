From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: da7210: Add
 11025/22050/44100/88200 rate support
Date: Tue, 9 Mar 2010 13:38:04 +0000
Message-ID: <20100309133803.GB1940@rakim.wolfsonmicro.main>
References: <ufx4amigj.wl%morimoto.kuninori@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3796924533
	for <alsa-devel@alsa-project.org>; Tue,  9 Mar 2010 14:38:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ufx4amigj.wl%morimoto.kuninori@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Phil Edworthy <Phil.Edworthy@renesas.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 02, 2010 at 05:13:50PM +0900, Kuninori Morimoto wrote:

> +	/* Disable active mode */
> +	snd_soc_update_bits(codec, DA7210_STARTUP1, DA7210_SC_MST_EN, 0);
> +
>  	snd_soc_update_bits(codec, hpf_reg, hpf_mask, hpf_value);
>  	snd_soc_update_bits(codec, DA7210_PLL, DA7210_PLL_FS_MASK, fs);
> +	snd_soc_update_bits(codec, DA7210_PLL_DIV3, DA7210_PLL_BYP, bypass);

This will take effect for both playback and capture - what happens if
one mode wants bypass and another doesn't?  Does the device actually
support asymmetric sample rates?

> +	/* As suggested by Dialog */
> +	da7210_write(codec, DA7210_A_HID_UNLOCK,	0x8B);
> +	da7210_write(codec, DA7210_A_TEST_UNLOCK,	0xB4);
> +	da7210_write(codec, DA7210_A_PLL1,		0x01);
> +	da7210_write(codec, DA7210_A_CP_MODE,		0x7C);

I suspect you want to disable the HID and test keys when you're done
fiddling with the configuration here...
