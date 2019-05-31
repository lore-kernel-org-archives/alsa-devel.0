From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ASoC: hdac_hda: Fix unbalanced bus link
 refcount at probe error
Date: Fri, 31 May 2019 08:31:10 -0700
Message-ID: <c62fb44c59b2a417a8ec721af542f584519dee49.camel@linux.intel.com>
References: <20190531143820.10142-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D558F80757
 for <alsa-devel@alsa-project.org>; Fri, 31 May 2019 17:31:15 +0200 (CEST)
In-Reply-To: <20190531143820.10142-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2019-05-31 at 16:38 +0200, Takashi Iwai wrote:
> The error paths in hdac_hda_codec_probe() don't take care of the bus
> link refcount properly, which leave the refcount still high.
> This patch addresses them.
Hi Takashi,

Thanks for this. But I looked into hdac_hdmi probe and we have a
similar problem there as well. 

Thanks,
Ranjani


> Fixes: 6bae5ea94989 ("ASoC: hdac_hda: add asoc extension for legacy
> HDA codec drivers")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
> A bug I found while digging for another problem :)
> 
>  sound/soc/codecs/hdac_hda.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/hdac_hda.c
> b/sound/soc/codecs/hdac_hda.c
> index 7d4940256914..b55deaeb1ebf 100644
> --- a/sound/soc/codecs/hdac_hda.c
> +++ b/sound/soc/codecs/hdac_hda.c
> @@ -475,8 +475,10 @@ static int hdac_hda_dev_probe(struct hdac_device
> *hdev)
>  	snd_hdac_ext_bus_link_get(hdev->bus, hlink);
>  
>  	hda_pvt = hdac_to_hda_priv(hdev);
> -	if (!hda_pvt)
> -		return -ENOMEM;
> +	if (!hda_pvt) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
>  
>  	/* ASoC specific initialization */
>  	ret = devm_snd_soc_register_component(&hdev->dev,
> @@ -484,12 +486,13 @@ static int hdac_hda_dev_probe(struct
> hdac_device *hdev)
>  					 ARRAY_SIZE(hdac_hda_dais));
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "failed to register HDA codec
> %d\n", ret);
> -		return ret;
> +		goto error;
>  	}
>  
>  	dev_set_drvdata(&hdev->dev, hda_pvt);
> -	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
>  
> + error:
> +	snd_hdac_ext_bus_link_put(hdev->bus, hlink);
>  	return ret;
>  }
>  
