From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 2/2] ASoC: da7219: Convert driver to use generic
 device/fwnode functions
Date: Tue, 14 Jun 2016 17:14:20 +0300
Message-ID: <1465913660.30123.56.camel@linux.intel.com>
References: <cover.1465908072.git.Adam.Thomson.Opensource@diasemi.com>
	 <1a6494cb18b83123e6ff2995124083cca6646ccf.1465908072.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1a6494cb18b83123e6ff2995124083cca6646ccf.1465908072.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2016-06-14 at 14:56 +0100, Adam Thomson wrote:
> This change converts the driver from using the of_* functions to usin=
g
> the device_* and fwnode_* functions for accssing FW related data.
>=20
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

=46WIW:
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> ---
>=20
> Changes in v3:
> =C2=A0- Rebase to v4.7-rc1
> =C2=A0- Remove unnecesary brackets in if statement for AAD pdata chec=
king.
> =C2=A0- Move assignment of add_np to be immediately prior to NULL che=
ck,
> for ease of
> =C2=A0=C2=A0=C2=A0reading.
>=20
> Changes in v2:
> =C2=A0- Rename functions to use _fw_ instead of _of_, to align with g=
eneric
> access.
> =C2=A0- Use new device property function to find named child, rather =
than
> local
> =C2=A0=C2=A0=C2=A0function.
> =C2=A0- Remove checking for DT/ACPI fwnode types, and perform FW read=
ing if
> platform
> =C2=A0=C2=A0=C2=A0data not already provided.
> =C2=A0- Remove ACPI and OF includes for AAD code, as no longer needed=
=2E
> =C2=A0- Restore accidentally removed blank line.
>=20
> =C2=A0sound/soc/codecs/da7219-aad.c | 103 +++++++++++++++++++++------=
----
> -----------
> =C2=A0sound/soc/codecs/da7219.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=A0=C2=
=A034 +++++++-------
> =C2=A02 files changed, 68 insertions(+), 69 deletions(-)
>=20
> diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-
> aad.c
> index 9459593..f0057cd 100644
> --- a/sound/soc/codecs/da7219-aad.c
> +++ b/sound/soc/codecs/da7219-aad.c
> @@ -13,8 +13,8 @@
>=20
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/platform_device.h>
> -#include <linux/of_device.h>
> -#include <linux/of_irq.h>
> +#include <linux/i2c.h>
> +#include <linux/property.h>
> =C2=A0#include <linux/pm_wakeirq.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/delay.h>
> @@ -382,11 +382,11 @@ static irqreturn_t da7219_aad_irq_thread(int
> irq, void *data)
> =C2=A0}
>=20
> =C2=A0/*
> - * DT to pdata conversion
> + * DT/ACPI to pdata conversion
> =C2=A0 */
>=20
> =C2=A0static enum da7219_aad_micbias_pulse_lvl
> -	da7219_aad_of_micbias_pulse_lvl(struct snd_soc_codec *codec,
> u32 val)
> +	da7219_aad_fw_micbias_pulse_lvl(struct snd_soc_codec *codec,
> u32 val)
> =C2=A0{
> =C2=A0	switch (val) {
> =C2=A0	case 2800:
> @@ -400,7 +400,7 @@ static enum da7219_aad_micbias_pulse_lvl
> =C2=A0}
>=20
> =C2=A0static enum da7219_aad_btn_cfg
> -	da7219_aad_of_btn_cfg(struct snd_soc_codec *codec, u32 val)
> +	da7219_aad_fw_btn_cfg(struct snd_soc_codec *codec, u32 val)
> =C2=A0{
> =C2=A0	switch (val) {
> =C2=A0	case 2:
> @@ -424,7 +424,7 @@ static enum da7219_aad_btn_cfg
> =C2=A0}
>=20
> =C2=A0static enum da7219_aad_mic_det_thr
> -	da7219_aad_of_mic_det_thr(struct snd_soc_codec *codec, u32
> val)
> +	da7219_aad_fw_mic_det_thr(struct snd_soc_codec *codec, u32
> val)
> =C2=A0{
> =C2=A0	switch (val) {
> =C2=A0	case 200:
> @@ -442,7 +442,7 @@ static enum da7219_aad_mic_det_thr
> =C2=A0}
>=20
> =C2=A0static enum da7219_aad_jack_ins_deb
> -	da7219_aad_of_jack_ins_deb(struct snd_soc_codec *codec, u32
> val)
> +	da7219_aad_fw_jack_ins_deb(struct snd_soc_codec *codec, u32
> val)
> =C2=A0{
> =C2=A0	switch (val) {
> =C2=A0	case 5:
> @@ -468,7 +468,7 @@ static enum da7219_aad_jack_ins_deb
> =C2=A0}
>=20
> =C2=A0static enum da7219_aad_jack_det_rate
> -	da7219_aad_of_jack_det_rate(struct snd_soc_codec *codec,
> const char *str)
> +	da7219_aad_fw_jack_det_rate(struct snd_soc_codec *codec,
> const char *str)
> =C2=A0{
> =C2=A0	if (!strcmp(str, "32ms_64ms")) {
> =C2=A0		return DA7219_AAD_JACK_DET_RATE_32_64MS;
> @@ -485,7 +485,7 @@ static enum da7219_aad_jack_det_rate
> =C2=A0}
>=20
> =C2=A0static enum da7219_aad_jack_rem_deb
> -	da7219_aad_of_jack_rem_deb(struct snd_soc_codec *codec, u32
> val)
> +	da7219_aad_fw_jack_rem_deb(struct snd_soc_codec *codec, u32
> val)
> =C2=A0{
> =C2=A0	switch (val) {
> =C2=A0	case 1:
> @@ -503,7 +503,7 @@ static enum da7219_aad_jack_rem_deb
> =C2=A0}
>=20
> =C2=A0static enum da7219_aad_btn_avg
> -	da7219_aad_of_btn_avg(struct snd_soc_codec *codec, u32 val)
> +	da7219_aad_fw_btn_avg(struct snd_soc_codec *codec, u32 val)
> =C2=A0{
> =C2=A0	switch (val) {
> =C2=A0	case 1:
> @@ -521,7 +521,7 @@ static enum da7219_aad_btn_avg
> =C2=A0}
>=20
> =C2=A0static enum da7219_aad_adc_1bit_rpt
> -	da7219_aad_of_adc_1bit_rpt(struct snd_soc_codec *codec, u32
> val)
> +	da7219_aad_fw_adc_1bit_rpt(struct snd_soc_codec *codec, u32
> val)
> =C2=A0{
> =C2=A0	switch (val) {
> =C2=A0	case 1:
> @@ -538,97 +538,96 @@ static enum da7219_aad_adc_1bit_rpt
> =C2=A0	}
> =C2=A0}
>=20
> -static struct da7219_aad_pdata *da7219_aad_of_to_pdata(struct
> snd_soc_codec *codec)
> +static struct da7219_aad_pdata *da7219_aad_fw_to_pdata(struct
> snd_soc_codec *codec)
> =C2=A0{
> -	struct device_node *np =3D codec->dev->of_node;
> -	struct device_node *aad_np =3D of_find_node_by_name(np,
> "da7219_aad");
> +	struct device *dev =3D codec->dev;
> +	struct i2c_client *i2c =3D to_i2c_client(dev);
> +	struct fwnode_handle *aad_np;
> =C2=A0	struct da7219_aad_pdata *aad_pdata;
> -	const char *of_str;
> -	u32 of_val32;
> +	const char *fw_str;
> +	u32 fw_val32;
>=20
> +	aad_np =3D device_get_named_child_node(dev, "da7219_aad");
> =C2=A0	if (!aad_np)
> =C2=A0		return NULL;
>=20
> =C2=A0	aad_pdata =3D devm_kzalloc(codec->dev, sizeof(*aad_pdata),
> GFP_KERNEL);
> =C2=A0	if (!aad_pdata)
> -		goto out;
> +		return NULL;
>=20
> -	aad_pdata->irq =3D irq_of_parse_and_map(np, 0);
> +	aad_pdata->irq =3D i2c->irq;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,micbias-pulse-lvl",
> -				=C2=A0&of_val32) >=3D 0)
> +	if (fwnode_property_read_u32(aad_np, "dlg,micbias-pulse-lvl",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&fw_val32) >=3D 0)
> =C2=A0		aad_pdata->micbias_pulse_lvl =3D
> -			da7219_aad_of_micbias_pulse_lvl(codec,
> of_val32);
> +			da7219_aad_fw_micbias_pulse_lvl(codec,
> fw_val32);
> =C2=A0	else
> =C2=A0		aad_pdata->micbias_pulse_lvl =3D
> DA7219_AAD_MICBIAS_PULSE_LVL_OFF;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,micbias-pulse-time",
> -				=C2=A0&of_val32) >=3D 0)
> -		aad_pdata->micbias_pulse_time =3D of_val32;
> +	if (fwnode_property_read_u32(aad_np, "dlg,micbias-pulse-
> time",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0&fw_val32) >=3D 0)
> +		aad_pdata->micbias_pulse_time =3D fw_val32;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,btn-cfg", &of_val32) >=3D
> 0)
> -		aad_pdata->btn_cfg =3D da7219_aad_of_btn_cfg(codec,
> of_val32);
> +	if (fwnode_property_read_u32(aad_np, "dlg,btn-cfg",
> &fw_val32) >=3D 0)
> +		aad_pdata->btn_cfg =3D da7219_aad_fw_btn_cfg(codec,
> fw_val32);
> =C2=A0	else
> =C2=A0		aad_pdata->btn_cfg =3D DA7219_AAD_BTN_CFG_10MS;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,mic-det-thr",
> &of_val32) >=3D 0)
> +	if (fwnode_property_read_u32(aad_np, "dlg,mic-det-thr",
> &fw_val32) >=3D 0)
> =C2=A0		aad_pdata->mic_det_thr =3D
> -			da7219_aad_of_mic_det_thr(codec, of_val32);
> +			da7219_aad_fw_mic_det_thr(codec, fw_val32);
> =C2=A0	else
> =C2=A0		aad_pdata->mic_det_thr =3D
> DA7219_AAD_MIC_DET_THR_500_OHMS;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,jack-ins-deb",
> &of_val32) >=3D 0)
> +	if (fwnode_property_read_u32(aad_np, "dlg,jack-ins-deb",
> &fw_val32) >=3D 0)
> =C2=A0		aad_pdata->jack_ins_deb =3D
> -			da7219_aad_of_jack_ins_deb(codec, of_val32);
> +			da7219_aad_fw_jack_ins_deb(codec, fw_val32);
> =C2=A0	else
> =C2=A0		aad_pdata->jack_ins_deb =3D
> DA7219_AAD_JACK_INS_DEB_20MS;
>=20
> -	if (!of_property_read_string(aad_np, "dlg,jack-det-rate",
> &of_str))
> +	if (!fwnode_property_read_string(aad_np, "dlg,jack-det-rate",=20
> &fw_str))
> =C2=A0		aad_pdata->jack_det_rate =3D
> -			da7219_aad_of_jack_det_rate(codec, of_str);
> +			da7219_aad_fw_jack_det_rate(codec, fw_str);
> =C2=A0	else
> =C2=A0		aad_pdata->jack_det_rate =3D
> DA7219_AAD_JACK_DET_RATE_256_512MS;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,jack-rem-deb",
> &of_val32) >=3D 0)
> +	if (fwnode_property_read_u32(aad_np, "dlg,jack-rem-deb",
> &fw_val32) >=3D 0)
> =C2=A0		aad_pdata->jack_rem_deb =3D
> -			da7219_aad_of_jack_rem_deb(codec, of_val32);
> +			da7219_aad_fw_jack_rem_deb(codec, fw_val32);
> =C2=A0	else
> =C2=A0		aad_pdata->jack_rem_deb =3D
> DA7219_AAD_JACK_REM_DEB_1MS;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,a-d-btn-thr",
> &of_val32) >=3D 0)
> -		aad_pdata->a_d_btn_thr =3D (u8) of_val32;
> +	if (fwnode_property_read_u32(aad_np, "dlg,a-d-btn-thr",
> &fw_val32) >=3D 0)
> +		aad_pdata->a_d_btn_thr =3D (u8) fw_val32;
> =C2=A0	else
> =C2=A0		aad_pdata->a_d_btn_thr =3D 0xA;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,d-b-btn-thr",
> &of_val32) >=3D 0)
> -		aad_pdata->d_b_btn_thr =3D (u8) of_val32;
> +	if (fwnode_property_read_u32(aad_np, "dlg,d-b-btn-thr",
> &fw_val32) >=3D 0)
> +		aad_pdata->d_b_btn_thr =3D (u8) fw_val32;
> =C2=A0	else
> =C2=A0		aad_pdata->d_b_btn_thr =3D 0x16;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,b-c-btn-thr",
> &of_val32) >=3D 0)
> -		aad_pdata->b_c_btn_thr =3D (u8) of_val32;
> +	if (fwnode_property_read_u32(aad_np, "dlg,b-c-btn-thr",
> &fw_val32) >=3D 0)
> +		aad_pdata->b_c_btn_thr =3D (u8) fw_val32;
> =C2=A0	else
> =C2=A0		aad_pdata->b_c_btn_thr =3D 0x21;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,c-mic-btn-thr",
> &of_val32) >=3D 0)
> -		aad_pdata->c_mic_btn_thr =3D (u8) of_val32;
> +	if (fwnode_property_read_u32(aad_np, "dlg,c-mic-btn-thr",
> &fw_val32) >=3D 0)
> +		aad_pdata->c_mic_btn_thr =3D (u8) fw_val32;
> =C2=A0	else
> =C2=A0		aad_pdata->c_mic_btn_thr =3D 0x3E;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,btn-avg", &of_val32) >=3D
> 0)
> -		aad_pdata->btn_avg =3D da7219_aad_of_btn_avg(codec,
> of_val32);
> +	if (fwnode_property_read_u32(aad_np, "dlg,btn-avg",
> &fw_val32) >=3D 0)
> +		aad_pdata->btn_avg =3D da7219_aad_fw_btn_avg(codec,
> fw_val32);
> =C2=A0	else
> =C2=A0		aad_pdata->btn_avg =3D DA7219_AAD_BTN_AVG_2;
>=20
> -	if (of_property_read_u32(aad_np, "dlg,adc-1bit-rpt",
> &of_val32) >=3D 0)
> +	if (fwnode_property_read_u32(aad_np, "dlg,adc-1bit-rpt",
> &fw_val32) >=3D 0)
> =C2=A0		aad_pdata->adc_1bit_rpt =3D
> -			da7219_aad_of_adc_1bit_rpt(codec, of_val32);
> +			da7219_aad_fw_adc_1bit_rpt(codec, fw_val32);
> =C2=A0	else
> =C2=A0		aad_pdata->adc_1bit_rpt =3D DA7219_AAD_ADC_1BIT_RPT_1;
>=20
> -out:
> -	of_node_put(aad_np);
> -
> =C2=A0	return aad_pdata;
> =C2=A0}
>=20
> @@ -769,9 +768,9 @@ int da7219_aad_init(struct snd_soc_codec *codec)
> =C2=A0	da7219->aad =3D da7219_aad;
> =C2=A0	da7219_aad->codec =3D codec;
>=20
> -	/* Handle any DT/platform data */
> -	if ((codec->dev->of_node) && (da7219->pdata))
> -		da7219->pdata->aad_pdata =3D
> da7219_aad_of_to_pdata(codec);
> +	/* Handle any DT/ACPI/platform data */
> +	if (da7219->pdata && !da7219->pdata->aad_pdata)
> +		da7219->pdata->aad_pdata =3D
> da7219_aad_fw_to_pdata(codec);
>=20
> =C2=A0	da7219_aad_handle_pdata(codec);
>=20
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index 5c93899..50ea943 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -15,6 +15,7 @@
> =C2=A0#include <linux/clk.h>
> =C2=A0#include <linux/i2c.h>
> =C2=A0#include <linux/of_device.h>
> +#include <linux/property.h>
> =C2=A0#include <linux/regmap.h>
> =C2=A0#include <linux/slab.h>
> =C2=A0#include <linux/pm.h>
> @@ -1418,7 +1419,7 @@ static struct snd_soc_dai_driver da7219_dai =3D=
 {
>=20
>=20
> =C2=A0/*
> - * DT
> + * DT/ACPI
> =C2=A0 */
>=20
> =C2=A0static const struct of_device_id da7219_of_match[] =3D {
> @@ -1434,7 +1435,7 @@ static const struct acpi_device_id
> da7219_acpi_match[] =3D {
> =C2=A0MODULE_DEVICE_TABLE(acpi, da7219_acpi_match);
>=20
> =C2=A0static enum da7219_micbias_voltage
> -	da7219_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
> +	da7219_fw_micbias_lvl(struct device *dev, u32 val)
> =C2=A0{
> =C2=A0	switch (val) {
> =C2=A0	case 1600:
> @@ -1450,13 +1451,13 @@ static enum da7219_micbias_voltage
> =C2=A0	case 2600:
> =C2=A0		return DA7219_MICBIAS_2_6V;
> =C2=A0	default:
> -		dev_warn(codec->dev, "Invalid micbias level");
> +		dev_warn(dev, "Invalid micbias level");
> =C2=A0		return DA7219_MICBIAS_2_2V;
> =C2=A0	}
> =C2=A0}
>=20
> =C2=A0static enum da7219_mic_amp_in_sel
> -	da7219_of_mic_amp_in_sel(struct snd_soc_codec *codec, const
> char *str)
> +	da7219_fw_mic_amp_in_sel(struct device *dev, const char *str)
> =C2=A0{
> =C2=A0	if (!strcmp(str, "diff")) {
> =C2=A0		return DA7219_MIC_AMP_IN_SEL_DIFF;
> @@ -1465,29 +1466,29 @@ static enum da7219_mic_amp_in_sel
> =C2=A0	} else if (!strcmp(str, "se_n")) {
> =C2=A0		return DA7219_MIC_AMP_IN_SEL_SE_N;
> =C2=A0	} else {
> -		dev_warn(codec->dev, "Invalid mic input type
> selection");
> +		dev_warn(dev, "Invalid mic input type selection");
> =C2=A0		return DA7219_MIC_AMP_IN_SEL_DIFF;
> =C2=A0	}
> =C2=A0}
>=20
> -static struct da7219_pdata *da7219_of_to_pdata(struct snd_soc_codec
> *codec)
> +static struct da7219_pdata *da7219_fw_to_pdata(struct snd_soc_codec
> *codec)
> =C2=A0{
> -	struct device_node *np =3D codec->dev->of_node;
> +	struct device *dev =3D codec->dev;
> =C2=A0	struct da7219_pdata *pdata;
> =C2=A0	const char *of_str;
> =C2=A0	u32 of_val32;
>=20
> -	pdata =3D devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
> +	pdata =3D devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> =C2=A0	if (!pdata)
> =C2=A0		return NULL;
>=20
> -	if (of_property_read_u32(np, "dlg,micbias-lvl", &of_val32) >=3D
> 0)
> -		pdata->micbias_lvl =3D da7219_of_micbias_lvl(codec,
> of_val32);
> +	if (device_property_read_u32(dev, "dlg,micbias-lvl",
> &of_val32) >=3D 0)
> +		pdata->micbias_lvl =3D da7219_fw_micbias_lvl(dev,
> of_val32);
> =C2=A0	else
> =C2=A0		pdata->micbias_lvl =3D DA7219_MICBIAS_2_2V;
>=20
> -	if (!of_property_read_string(np, "dlg,mic-amp-in-sel",
> &of_str))
> -		pdata->mic_amp_in_sel =3D
> da7219_of_mic_amp_in_sel(codec, of_str);
> +	if (!device_property_read_string(dev, "dlg,mic-amp-in-sel",
> &of_str))
> +		pdata->mic_amp_in_sel =3D da7219_fw_mic_amp_in_sel(dev,
> of_str);
> =C2=A0	else
> =C2=A0		pdata->mic_amp_in_sel =3D DA7219_MIC_AMP_IN_SEL_DIFF;
>=20
> @@ -1662,11 +1663,10 @@ static int da7219_probe(struct snd_soc_codec
> *codec)
> =C2=A0		break;
> =C2=A0	}
>=20
> -	/* Handle DT/Platform data */
> -	if (codec->dev->of_node)
> -		da7219->pdata =3D da7219_of_to_pdata(codec);
> -	else
> -		da7219->pdata =3D dev_get_platdata(codec->dev);
> +	/* Handle DT/ACPI/Platform data */
> +	da7219->pdata =3D dev_get_platdata(codec->dev);
> +	if (!da7219->pdata)
> +		da7219->pdata =3D da7219_fw_to_pdata(codec);
>=20
> =C2=A0	da7219_handle_pdata(codec);
>=20
> --
> 1.9.3
>=20

--=20

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
