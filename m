From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 1/2] ASoC: hdmi-codec: Allow drivers to
 restrict sample sizes.
Date: Thu, 27 Jul 2017 13:34:30 +0300
Message-ID: <ea28ff3a-f688-fda3-908b-67fd49244b9b@ti.com>
References: <20170717140227.17312-1-srinivas.kandagatla@linaro.org>
 <20170717140227.17312-2-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fllnx209.ext.ti.com (fllnx209.ext.ti.com [198.47.19.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 623CD266A8A
 for <alsa-devel@alsa-project.org>; Thu, 27 Jul 2017 12:34:55 +0200 (CEST)
In-Reply-To: <20170717140227.17312-2-srinivas.kandagatla@linaro.org>
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
To: srinivas.kandagatla@linaro.org, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Archit Taneja <architt@codeaurora.org>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, Andrzej Hajda <a.hajda@samsung.com>
List-Id: alsa-devel@alsa-project.org

On 07/17/17 17:02, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Currently hdmi client drivers does have means to limit the
> sample sizes that it can only support. Having formats parameter
> option would solve this.
> 
> This issue was noticed on DB410c board when adv7511 hdmi codec driver
> failed to play a 32 bits audio samples, as it does not support them.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

I left this feature out because I did not need it. All the HDMI encoders
I have used are able to take all the i2s formats I am able to send.

You should probably also update the comment above I2S_FORMATS
definition. Othewise:

Reviewed-by: Jyri Sarha <jsarha@ti.com>


> ---
>  include/sound/hdmi-codec.h    | 1 +
>  sound/soc/codecs/hdmi-codec.c | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 9483c55f871b..89fc4cce5785 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -104,6 +104,7 @@ struct hdmi_codec_pdata {
>  	uint i2s:1;
>  	uint spdif:1;
>  	int max_i2s_channels;
> +	u64 formats;
>  	void *data;
>  };
>  
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index 22ed0dc88f0a..1ece73f4be92 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -780,6 +780,9 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>  		hcp->daidrv[i] = hdmi_i2s_dai;
>  		hcp->daidrv[i].playback.channels_max =
>  			hcd->max_i2s_channels;
> +
> +		if (hcd->formats)
> +			hcp->daidrv[i].playback.formats = hcd->formats;
>  		i++;
>  	}
>  
> 
