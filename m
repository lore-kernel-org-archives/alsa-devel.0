From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: atmel-classd: select correct Kconfig
	symbol
Date: Tue, 5 Dec 2017 14:28:28 +0100
Message-ID: <CAK8P3a2R+jLw3T6G_bPFeJrEQwOJu2Mu5DGXPZHRMr4LECFSsA@mail.gmail.com>
References: <20171205101000.968887-1-arnd@arndb.de>
 <20171205105750.GI21780@piout.net>
 <CAK8P3a29G4T1DbkjwhEqa6cSVQL77z0jW0znMX47tqd5vM-P9Q@mail.gmail.com>
 <20171205124707.GJ21780@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id EED8E266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 14:28:30 +0100 (CET)
Received: by mail-qt0-f194.google.com with SMTP id w10so555501qtb.10
 for <alsa-devel@alsa-project.org>; Tue, 05 Dec 2017 05:28:30 -0800 (PST)
In-Reply-To: <20171205124707.GJ21780@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 5, 2017 at 1:47 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 05/12/2017 at 12:13:41 +0100, Arnd Bergmann wrote:
>
> Ok, does that solve both randconfigs?
>
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index 4a56f3dfba51..dcee145dd179 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -64,7 +64,7 @@ config SND_AT91_SOC_SAM9X5_WM8731
>  config SND_ATMEL_SOC_CLASSD
>         tristate "Atmel ASoC driver for boards using CLASSD"
>         depends on ARCH_AT91 || COMPILE_TEST
> -       select SND_ATMEL_SOC_DMA
> +       select SND_SOC_GENERIC_DMAENGINE_PCM
>         select REGMAP_MMIO
>         help
>           Say Y if you want to add support for Atmel ASoC driver for boards using

Yes, that works as well and looks reliable. I've sent another
follow-up now, working on the
assumption that we actually need SND_ATMEL_SOC_DMA.

Both patches make it build, but obviously only one of the two is
actually correct. I assume you know what you are doing, so if
you want to send your patch with a proper changelog, please add
my

Tested-by: Arnd Bergmann <arnd@arndb.de>

     Arnd
