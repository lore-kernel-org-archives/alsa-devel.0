From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] ASoC: atmel: compile pcm driver in
	snd-soc-atmel_ssc_dai
Date: Tue, 26 May 2015 12:53:52 +0200
Message-ID: <4338609.rFs5DCIUWR@wuerfel>
References: <1432591459-22613-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 0920126510A
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2015 12:54:23 +0200 (CEST)
In-Reply-To: <1432591459-22613-2-git-send-email-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tuesday 26 May 2015 00:04:19 Alexandre Belloni wrote:
> index b327e5cc8de3..4fa7ac91f972 100644
> --- a/sound/soc/atmel/Makefile
> +++ b/sound/soc/atmel/Makefile
> @@ -1,10 +1,8 @@
>  # AT91 Platform Support
> -snd-soc-atmel-pcm-pdc-objs := atmel-pcm-pdc.o
> -snd-soc-atmel-pcm-dma-objs := atmel-pcm-dma.o
> -snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
> +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_PDC) := atmel-pcm-pdc.o
> +snd-soc-atmel-pcm-$(CONFIG_SND_ATMEL_SOC_DMA) += atmel-pcm-dma.o
> +snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o $(snd-soc-atmel-pcm-y)

While technically correct, you could have written this (slightly)
simpler as:

snd-soc-atmel_ssc_dai-objs := atmel_ssc_dai.o
snd-soc-atmel-ssc_dai-$(CONFIG_SND_ATMEL_SOC_PDC) += atmel-pcm-pdc.o
snd-soc-atmel-ssc_dai-$(CONFIG_SND_ATMEL_SOC_DMA) += atmel-pcm-dma.o

No need to change the patch again after it's applied now.

	Arnd
