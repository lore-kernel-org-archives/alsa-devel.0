From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RFC v3 6/7] ASoC: hdmi-codec: Use HDMI
 notifications to add jack support
Date: Mon, 18 Jan 2016 23:08:10 +0200
Message-ID: <569D543A.5010207@ti.com>
References: <1452613096-8116-1-git-send-email-p.zabel@pengutronix.de>
 <1452613096-8116-7-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 0327C261A5A
 for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2016 22:08:17 +0100 (CET)
In-Reply-To: <1452613096-8116-7-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>, alsa-devel@alsa-project.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Kurtz <djkurtz@chromium.org>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 01/12/16 17:38, Philipp Zabel wrote:
> Use HDMI connection / disconnection notifications to update an ALSA
> jack object. Also make a copy of the ELD block after every change.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
> Changes since v2:
>   - Don't call get_eld, copy the ELD contained in the notification instead.
> ---
>   include/sound/hdmi-codec.h    |  6 ++++
>   sound/soc/codecs/hdmi-codec.c | 69 ++++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 74 insertions(+), 1 deletion(-)
>
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 15fe70f..8b6219d 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -99,6 +99,12 @@ struct hdmi_codec_pdata {
>   	int max_i2s_channels;
>   };
>
> +struct snd_soc_codec;
> +struct snd_soc_jack;
> +
> +int hdmi_codec_set_jack_detect(struct snd_soc_codec *codec,
> +			       struct snd_soc_jack *jack);
> +
>   #define HDMI_CODEC_DRV_NAME "hdmi-audio-codec"
>
>   #endif /* __HDMI_CODEC_H__ */
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index 687332d..6b327e2 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -12,9 +12,12 @@
>    * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
>    * General Public License for more details.
>    */
> +#include <linux/hdmi-not.h>
>   #include <linux/module.h>
> +#include <linux/notifier.h>
>   #include <linux/string.h>
>   #include <sound/core.h>
> +#include <sound/jack.h>
>   #include <sound/pcm.h>
>   #include <sound/pcm_params.h>
>   #include <sound/soc.h>
> @@ -27,11 +30,15 @@
>   struct hdmi_codec_priv {
>   	struct hdmi_codec_pdata hcd;
>   	struct snd_soc_dai_driver *daidrv;
> +	struct snd_soc_jack *jack;
>   	struct hdmi_codec_daifmt daifmt[2];
>   	struct mutex current_stream_lock;
>   	struct snd_pcm_substream *current_stream;
>   	struct snd_pcm_hw_constraint_list ratec;
>   	uint8_t eld[MAX_ELD_BYTES];
> +	struct device *dev;
> +	struct notifier_block nb;
> +	unsigned int jack_status;
>   };
>
>   static const struct snd_soc_dapm_widget hdmi_widgets[] = {
> @@ -326,6 +333,60 @@ static struct snd_soc_codec_driver hdmi_codec = {
>   	.num_dapm_routes = ARRAY_SIZE(hdmi_routes),
>   };
>
> +static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
> +				   unsigned int jack_status)
> +{
> +	if (!hcp->jack)
> +		return;
> +
> +	if (jack_status != hcp->jack_status) {
> +		snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
> +		hcp->jack_status = jack_status;
> +	}
> +}
> +
> +static int hdmi_codec_notify(struct notifier_block *nb, unsigned long event,
> +			     void *data)
> +{
> +	struct hdmi_codec_priv *hcp = container_of(nb, struct hdmi_codec_priv,
> +						   nb);
> +	union hdmi_event *event_block = data;
> +
> +	if (hcp->dev->parent != event_block->base.source)
> +		return NOTIFY_OK;
> +
> +	if (!hcp->jack)
> +		return NOTIFY_OK;
> +
> +	switch (event) {
> +	case HDMI_CONNECTED:
> +		hdmi_codec_jack_report(hcp, SND_JACK_LINEOUT);
> +		break;
> +	case HDMI_DISCONNECTED:
> +		hdmi_codec_jack_report(hcp, 0);
> +		break;
> +	case HDMI_NEW_ELD:
> +		memcpy(hcp->eld, event_block->eld.eld, sizeof(hcp->eld));

The access to eld should be protected my a mutex. There should be no 
disaster even without a protection, just a weird error if playback is 
started right in the middle when ELD is being updated, still it is 
better to be safe.

> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +int hdmi_codec_set_jack_detect(struct snd_soc_codec *codec,
> +			       struct snd_soc_jack *jack)
> +{
> +	struct hdmi_codec_priv *hcp = snd_soc_codec_get_drvdata(codec);
> +
> +	hcp->jack = jack;
> +	hcp->nb.notifier_call = hdmi_codec_notify;
> +
> +	hdmi_register_notifier(&hcp->nb);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);
> +
>   static int hdmi_codec_probe(struct platform_device *pdev)
>   {
>   	struct hdmi_codec_pdata *hcd = pdev->dev.platform_data;
> @@ -370,6 +431,8 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>   	if (hcd->spdif)
>   		hcp->daidrv[i] = hdmi_spdif_dai;
>
> +	dev_set_drvdata(dev, hcp);
> +
>   	ret = snd_soc_register_codec(dev, &hdmi_codec, hcp->daidrv,
>   				     dai_count);
>   	if (ret) {
> @@ -378,12 +441,16 @@ static int hdmi_codec_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>
> -	dev_set_drvdata(dev, hcp);
> +	hcp->dev = dev;
> +
>   	return 0;
>   }
>
>   static int hdmi_codec_remove(struct platform_device *pdev)
>   {
> +	struct hdmi_codec_priv *hcp = platform_get_drvdata(pdev);
> +
> +	hdmi_unregister_notifier(&hcp->nb);
>   	snd_soc_unregister_codec(&pdev->dev);
>   	return 0;
>   }
>


Apart from above comment this looks good to me.

Cheers,
Jyri
