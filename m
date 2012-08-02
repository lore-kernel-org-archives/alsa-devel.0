From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: core: Fix check before defaulting to
	regmap
Date: Thu, 02 Aug 2012 10:44:41 +0300
Message-ID: <501A2FE9.50706@ti.com>
References: <1343847985-23712-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog131.obsmtp.com (na3sys009aog131.obsmtp.com
 [74.125.149.247])
 by alsa0.perex.cz (Postfix) with ESMTP id 427A2260304
 for <alsa-devel@alsa-project.org>; Thu,  2 Aug 2012 09:43:50 +0200 (CEST)
Received: by yhjj63 with SMTP id j63so9554828yhj.37
 for <alsa-devel@alsa-project.org>; Thu, 02 Aug 2012 00:43:50 -0700 (PDT)
In-Reply-To: <1343847985-23712-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 08/01/2012 10:06 PM, Mark Brown wrote:
> Check if the chip has provided a write operation (which is mandatory for
> I/O) rather than looking for control data as some of the MFDs use a global
> for this. Also skip the attempt if there's no regmap available by device
> in case things get confused by the attempt to default.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/soc-core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index b1fd043..5359623 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1096,7 +1096,7 @@ static int soc_probe_codec(struct snd_soc_card *card,
>  	}
>  
>  	/* If the driver didn't set I/O up try regmap */
> -	if (!codec->control_data)
> +	if (!codec->write && dev_get_regmap(codec->dev, NULL))
>  		snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
>  
>  	if (driver->controls)

I have a slightly different implementation of this, but this looks better.

Boards using the following machine drivers are affected by this issue:
zoom2, overo, omap3pandora, omap3beagle, sdp3430, omap-abe-twl6040, omap3evm,
igep0020.

All boards using these machine drivers will have kernel crash at the first
time we try to write a register in the codec.

Could you send this patch (if the patch OK with you) to be included in 3.6-rc1
to avoid boards booting to kernel crash (if they restore the mixers at boot
time).

Thank you.

Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
