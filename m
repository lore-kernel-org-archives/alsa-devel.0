From: Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: [PATCH 1/6] ASoC: jz4740: Remove Makefile entry for removed file
Date: Fri, 27 Mar 2015 10:51:43 +0000
Message-ID: <5515363F.1050209@imgtec.com>
References: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1398199596-23649-1-git-send-email-lars@metafoo.de>
Sender: stable-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 04/22/2014 09:46 PM, Lars-Peter Clausen wrote:
> Commit 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
> jz4740-pcm.c file, but neglected to remove the Makefile entries.
> 
> Fixes: 0406a40a0 ("ASoC: jz4740: Use the generic dmaengine PCM driver")
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Reported-by: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  sound/soc/jz4740/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/sound/soc/jz4740/Makefile b/sound/soc/jz4740/Makefile
> index be873c1..d32c540 100644
> --- a/sound/soc/jz4740/Makefile
> +++ b/sound/soc/jz4740/Makefile
> @@ -1,10 +1,8 @@
>  #
>  # Jz4740 Platform Support
>  #
> -snd-soc-jz4740-objs := jz4740-pcm.o
>  snd-soc-jz4740-i2s-objs := jz4740-i2s.o
>  
> -obj-$(CONFIG_SND_JZ4740_SOC) += snd-soc-jz4740.o
>  obj-$(CONFIG_SND_JZ4740_SOC_I2S) += snd-soc-jz4740-i2s.o
>  
>  # Jz4740 Machine Support
> 
Hi,

This patch (eebdec044e82) is present in 3.15-rc1 but the build failure
that was introduced by 0406a40a0 ("ASoC: jz4740: Use the generic
dmaengine PCM driver") is present in 3.14-rc1 so 3.14 is still broken.

Greg, would it be possible to cherry pick eebdec044e82 ("ASoC: jz4740:
Remove Makefile entry for removed file") to 3.14 stable branch? It seems
to apply without conflicts.

Thank you

-- 
markos
