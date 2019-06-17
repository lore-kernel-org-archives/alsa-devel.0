From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 09/11] ASoC: Intel: hdac_hdmi: Set ops
 to NULL on remove
Date: Mon, 17 Jun 2019 13:51:42 -0700
Message-ID: <75be86354032f4886cbaf7d430de2aa89eaab573.camel@linux.intel.com>
References: <20190617113644.25621-1-amadeuszx.slawinski@linux.intel.com>
         <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617113644.25621-10-amadeuszx.slawinski@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amadeusz =?UTF-8?Q?S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2019-06-17 at 13:36 +0200, Amadeusz Sławiński wrote:
> When we unload Skylake driver we may end up calling
> hdac_component_master_unbind(), it uses acomp->audio_ops, which we
> set
> in hdmi_codec_probe(), so we need to set it to NULL in
> hdmi_codec_remove(),
> otherwise we will dereference no longer existing pointer.

Hi Amadeusz,

It looks like the audio_ops should be deleted snd_hdac_acomp_exit().
Also, this doesnt seem to be the case with when the SOF driver is
removed.
Could you please give a bit more context on what error you see when
this happens?

Thanks,
Ranjani
> 
> Signed-off-by: Amadeusz Sławiński <
> amadeuszx.slawinski@linux.intel.com>
> ---
>  sound/soc/codecs/hdac_hdmi.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/codecs/hdac_hdmi.c
> b/sound/soc/codecs/hdac_hdmi.c
> index 911bb6e2a1ac..9ee1bff548d8 100644
> --- a/sound/soc/codecs/hdac_hdmi.c
> +++ b/sound/soc/codecs/hdac_hdmi.c
> @@ -1890,6 +1890,12 @@ static void hdmi_codec_remove(struct
> snd_soc_component *component)
>  {
>  	struct hdac_hdmi_priv *hdmi =
> snd_soc_component_get_drvdata(component);
>  	struct hdac_device *hdev = hdmi->hdev;
> +	int ret;
> +
> +	ret = snd_hdac_acomp_register_notifier(hdev->bus, NULL);
> +	if (ret < 0)
> +		dev_err(&hdev->dev, "notifier unregister failed: err:
> %d\n",
> +				ret);
>  
>  	pm_runtime_disable(&hdev->dev);
>  }
