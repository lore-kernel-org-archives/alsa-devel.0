From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v7 1/1] ASoC: TI WL1273 FM Radio Codec.
Date: Thu, 19 Aug 2010 15:32:32 +0100
Message-ID: <1282228352.3074.471.camel@odin>
References: <1282226421-23202-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1282226421-23202-2-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9227E24405
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Aug 2010 16:32:32 +0200 (CEST)
Received: by wwi18 with SMTP id 18so2205678wwi.20
	for <alsa-devel@alsa-project.org>; Thu, 19 Aug 2010 07:32:32 -0700 (PDT)
In-Reply-To: <1282226421-23202-2-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, peter.ujfalusi@nokia.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-08-19 at 17:00 +0300, Matti J. Aaltonen wrote:
> This is an ALSA codec for the Texas Instruments WL1273 FM Radio.
> 
> Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>
> ---
>  sound/soc/codecs/wl1273.c |  533 +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wl1273.h |  101 +++++++++
>  2 files changed, 634 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/codecs/wl1273.c
>  create mode 100644 sound/soc/codecs/wl1273.h
> 
> diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
> new file mode 100644
> index 0000000..a179303
> --- /dev/null
> +++ b/sound/soc/codecs/wl1273.c
> @@ -0,0 +1,533 @@

snip

> +
> +static int wl1273_probe(struct snd_soc_codec *codec)
> +{
> +	struct wl1273_core **core = codec->dev->platform_data;

Just curious, why is your platform data here not just a pointer to a
struct wl1273 ?

> +	struct wl1273_priv *wl1273;
> +	int r;
> +
> +	dev_dbg(codec->dev, "%s.\n", __func__);
> +
> +	if (!core) {
> +		dev_err(codec->dev, "Platform data is missing.\n");
> +		return -EINVAL;
> +	}
> +
> +	wl1273 = kzalloc(sizeof(struct wl1273_priv), GFP_KERNEL);
> +	if (wl1273 == NULL) {
> +		dev_err(codec->dev, "Cannot allocate memory.\n");
> +		return -ENOMEM;
> +	}
> +
> +	wl1273->mode = WL1273_MODE_BT;
> +	wl1273->core = *core;
> +
> +	snd_soc_codec_set_drvdata(codec, wl1273);
> +
> +	mutex_init(&codec->mutex);
> +	INIT_LIST_HEAD(&codec->dapm_widgets);
> +	INIT_LIST_HEAD(&codec->dapm_paths);
> +
> +	codec->name = "wl1273";
> +	codec->num_dai = 1;
> +	codec->bias_level = SND_SOC_BIAS_OFF;

Above 6 lines now done by core, so not needed now (I mentioned that for
V5, but maybe not explicitly)

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
