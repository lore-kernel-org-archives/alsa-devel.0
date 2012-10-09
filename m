From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/5] ALSA: ASoC: McASP: add support for 24
	bit samples
Date: Tue, 9 Oct 2012 16:17:57 +0900
Message-ID: <20121009071755.GX8237@opensource.wolfsonmicro.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
 <1349356122-14794-4-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0C30E26525B
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 09:18:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1349356122-14794-4-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Matt Porter <mporter@ti.com>, alsa-devel@alsa-project.org, lrg@ti.com, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 04, 2012 at 03:08:40PM +0200, Daniel Mack wrote:

> +	case SNDRV_PCM_FORMAT_U24_3LE:
> +	case SNDRV_PCM_FORMAT_S24_3LE:
> +	case SNDRV_PCM_FORMAT_U24_LE:
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		dma_params->data_type = 3;
> +		word_length = DAVINCI_AUDIO_WORD_24;
> +		break;
> +

This is fine but should be adding the format to the set of supported
formats in the DAI as well, otherwise userspace should never select 24
bits.
