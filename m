From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [PATCH v2] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
Date: Mon, 30 Apr 2018 19:05:19 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>, "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Support Opensource <Support.Opensource@diasemi.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 30 April 2018 10:23, Akshu Agrawal wrote:

> Non-dts based systems can use ACPI DSDT to pass on the mclk
> to da7219.
> This enables da7219 mclk to be linked to system clock.
> Enable/Disable of the mclk is already handled in the codec so
> platform drivers don't have to explicitly do handling of mclk.

There is already a means via DT to specify the MCLK for a device using the
generic clock DT bindings, and this driver already uses that. Should ACPI not
have something similar to that which is generic, rather than adding device
specific bindings/properties to achieve the same? There will be other drivers
that will want to do the same.

>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---
> v2: Fixed kbuild error
>  include/sound/da7219.h    | 2 ++
>  sound/soc/codecs/da7219.c | 7 ++++++-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
> index 1bfcb16..df7ddf4 100644
> --- a/include/sound/da7219.h
> +++ b/include/sound/da7219.h
> @@ -38,6 +38,8 @@ struct da7219_pdata {
>
>  	const char *dai_clks_name;
>
> +	const char *mclk_name;
> +
>  	/* Mic */
>  	enum da7219_micbias_voltage micbias_lvl;
>  	enum da7219_mic_amp_in_sel mic_amp_in_sel;
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 980a6a8..aed68a4 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1624,6 +1624,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct
> snd_soc_component *compone
>  		dev_warn(dev, "Using default clk name: %s\n",
>  			 pdata->dai_clks_name);
>
> +	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
> +
>  	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
>  		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
>  	else
> @@ -1905,7 +1907,10 @@ static int da7219_probe(struct snd_soc_component
> *component)
>  	da7219_handle_pdata(component);
>
>  	/* Check if MCLK provided */
> -	da7219->mclk = devm_clk_get(component->dev, "mclk");
> +	if (da7219->pdata->mclk_name)
> +		da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);

By doing this you would need an associated 'clk_put()' whereas the devm call
avoids this.

> +	if (!da7219->mclk)
> +		da7219->mclk = devm_clk_get(component->dev, "mclk");
>  	if (IS_ERR(da7219->mclk)) {
>  		if (PTR_ERR(da7219->mclk) != -ENOENT) {
>  			ret = PTR_ERR(da7219->mclk);
> --
> 1.9.1
