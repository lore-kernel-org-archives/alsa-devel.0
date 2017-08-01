From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: adv7511: restrict audio
 sample sizes
Date: Tue, 1 Aug 2017 10:42:57 +0200
Message-ID: <7d700845-da72-5c40-31f9-c3faa7ca93a2@st.com>
References: <20170731224944.9986-1-srinivas.kandagatla@linaro.org>
 <20170731224944.9986-3-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id CA2E0266847
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 10:43:01 +0200 (CEST)
In-Reply-To: <20170731224944.9986-3-srinivas.kandagatla@linaro.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Archit Taneja <architt@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hello Srinivas,

On 08/01/2017 12:49 AM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> ADV7533 only supports audio samples word width from 16-24 bits.
> This patch restricts the audio sample sizes to the supported ones,
> so that sound card does not report wrong list of supported hwparms.
> 
> Without this patch aplay would fail when playing a 32 bit audio.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/gpu/drm/bridge/adv7511/adv7511_audio.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> index 67469c26bae8..d01d0aa0eef7 100644
> --- a/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_audio.c
> @@ -214,6 +214,8 @@ static struct hdmi_codec_pdata codec_data = {
>  	.ops = &adv7511_codec_ops,
>  	.max_i2s_channels = 2,
>  	.i2s = 1,
> +	.formats = (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_BE |
> +		    SNDRV_PCM_FMTBIT_S24_LE | SNDRV_PCM_FMTBIT_S24_BE),
>  };

I'm not sure that this limitation is needed.
I already used ADV7513 and i did not observe this limitation.

I had a look to ADV7533 data-sheet. it should support 32 and 64 bits I2S
format bus, with 16 or 24 bits precision sample. So it should support
SNDRV_PCM_FMTBIT_S32_LE and SNDRV_PCM_FMTBIT_S32_BE

As example, if you configure bus in Left justified format with 24 bits
sample length, 32 bits application samples should be truncated to 24
bits samples at ADV7533 I2S interface level (LSB dropped).

Perhaps i missed something... but look like more an I2S bus
configuration issue in your DT card description, that that a miss in the
drivers.

Regards
Arnaud
>  
>  int adv7511_audio_init(struct device *dev, struct adv7511 *adv7511)
> 
