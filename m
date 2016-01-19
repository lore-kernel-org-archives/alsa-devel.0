From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RFC v3 7/7] ASoC: hdmi-codec: Add ELD control
Date: Tue, 19 Jan 2016 14:00:05 +0200
Message-ID: <569E2545.9010602@ti.com>
References: <1452613096-8116-1-git-send-email-p.zabel@pengutronix.de>
 <1452613096-8116-8-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id E7070265546
 for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2016 13:00:13 +0100 (CET)
In-Reply-To: <1452613096-8116-8-git-send-email-p.zabel@pengutronix.de>
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
> Exporting the ELD bytes to userspace allows an application to select
> an appropriate audio format depending on the current capabilities of
> the connected HDMI sink device.
>

This looks good, but I was unable to test it. Obviously amixer or 
alsamixer is unable to show anything about an ELD mixer element, but 
shouldn't there be something about it shown under /proc/asound/card0/, 
or am I mistaken.

Cheers,
Jyri

> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   sound/soc/codecs/hdmi-codec.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/sound/soc/codecs/hdmi-codec.c b/sound/soc/codecs/hdmi-codec.c
> index 6b327e2..6cb7217 100644
> --- a/sound/soc/codecs/hdmi-codec.c
> +++ b/sound/soc/codecs/hdmi-codec.c
> @@ -54,6 +54,40 @@ enum {
>   	DAI_ID_SPDIF,
>   };
>
> +static int hdmi_eld_ctl_info(struct snd_kcontrol *kcontrol,
> +			     struct snd_ctl_elem_info *uinfo)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
> +
> +	uinfo->type = SNDRV_CTL_ELEM_TYPE_BYTES;
> +	uinfo->count = sizeof(hcp->eld);
> +
> +	return 0;
> +}
> +
> +static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
> +			    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
> +	struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
> +
> +	memcpy(ucontrol->value.bytes.data, hcp->eld, sizeof(hcp->eld));
> +
> +	return 0;
> +}
> +
> +static const struct snd_kcontrol_new hdmi_controls[] = {
> +	{
> +		.access = SNDRV_CTL_ELEM_ACCESS_READ |
> +			  SNDRV_CTL_ELEM_ACCESS_VOLATILE,
> +		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
> +		.name = "ELD",
> +		.info = hdmi_eld_ctl_info,
> +		.get = hdmi_eld_ctl_get,
> +	},
> +};
> +
>   static void hdmi_codec_abort(struct device *dev)
>   {
>   	struct hdmi_codec_priv *hcp = dev_get_drvdata(dev);
> @@ -327,6 +361,8 @@ static const struct snd_soc_dai_driver hdmi_spdif_dai = {
>   };
>
>   static struct snd_soc_codec_driver hdmi_codec = {
> +	.controls = hdmi_controls,
> +	.num_controls = ARRAY_SIZE(hdmi_controls),
>   	.dapm_widgets = hdmi_widgets,
>   	.num_dapm_widgets = ARRAY_SIZE(hdmi_widgets),
>   	.dapm_routes = hdmi_routes,
>
