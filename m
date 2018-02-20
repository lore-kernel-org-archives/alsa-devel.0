From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: hdmi-codec: Fix module unloading
 caused kernel crash
Date: Tue, 20 Feb 2018 14:37:51 +0200
Message-ID: <77f562f6-5ba7-782b-0dba-a0b0e1d09325@ti.com>
References: <20180220123010.5373-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx193.ext.ti.com (lelnx193.ext.ti.com [198.47.27.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 76591266F0D
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 13:37:56 +0100 (CET)
In-Reply-To: <20180220123010.5373-1-peter.ujfalusi@ti.com>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

On 20/02/18 14:30, Peter Ujfalusi wrote:
> The hcp->chmap_info must not be freed up in the hdmi_codec_remove()
> function as it leads to kernel crash due ALSA core's
> pcm_chmap_ctl_private_free() is trying to free it up again when the card
> destroyed via snd_card_free.
> 
> Since the driver was converted to devm_snd_soc_register_component() the
> whole platform_device.remove can be removed.
> 
> Commit cd6111b26280a ("ASoC: hdmi-codec: add channel mapping control")
> should not have added the kfree(hcp->chmap_info); to the hdmi_codec_remove
> function.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks,
After this Beaglebone-black does not give "Unable to handle kernel
paging request" any more when unloading the tilcdc module.

Reviewed-by: Jyri Sarha <jsarha@ti.com>
Tested-by: Jyri Sarha <jsarha@ti.com>


> ---
>  sound/soc/codecs/hdmi-codec.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index 42df579cb507..6fa11888672d 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -798,23 +798,11 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static int hdmi_codec_remove(struct platform_device *pdev)
> -{
> -	struct device *dev = &pdev->dev;
> -	struct hdmi_codec_priv *hcp;
> -
> -	hcp = dev_get_drvdata(dev);
> -	kfree(hcp->chmap_info);
> -
> -	return 0;
> -}
> -
>  static struct platform_driver hdmi_codec_driver = {
>  	.driver = {
>  		.name = HDMI_CODEC_DRV_NAME,
>  	},
>  	.probe = hdmi_codec_probe,
> -	.remove = hdmi_codec_remove,
>  };
>  
>  module_platform_driver(hdmi_codec_driver);
> 


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
