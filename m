From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: [PATCH 1/3] ASoC: Add WM8510 driver
Date: Thu, 5 Jun 2008 09:17:23 -0500
Message-ID: <200806050917.23252.geoffrey@pager.net>
References: <1212670174-19810-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 6381B245FE
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jun 2008 16:16:49 +0200 (CEST)
In-Reply-To: <1212670174-19810-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Brett Saunders <breton.saunders@ntlworld.com>
List-Id: alsa-devel@alsa-project.org

On Thursday 05 June 2008 07:49:32 am Mark Brown wrote:

> +	/* bit size */
> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:
> +		break;
> +	case SNDRV_PCM_FORMAT_S20_3LE:
> +		iface |= 0x0020;
> +		break;
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		iface |= 0x0040;
> +		break;
> +	case SNDRV_PCM_FORMAT_S32_LE:
> +		iface |= 0x0060;
> +		break;
> +	}

This should either be changed to use SNDRV_PCM_FORMAT_S16 and friends, which I 
think will automagically use the correct endian for the selected 
architecture, or explicitly list both _LE and _BE formats.  Not an issue, 
unless you're using a correct endian, I mean big endian, processor like I 
am :)  I would think this would need to be propagated to other CODEC drivers.



> +#define WM8510_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE
> |\ +	SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S32_LE)

Same thing with big endian here.


Mark, were able to verify that the default value SPKMIX differs from the 
datasheet?  Is this a datasheet mistake, or an issue in the WM8510 part I 
have?  The full markings on the part are "WM8510G / 63AETV9", and the 
datasheet is "February 2008, Rev 4.4".

---
Geoffrey
