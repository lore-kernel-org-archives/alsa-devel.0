From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98925 codec driver
Date: Fri, 6 Mar 2015 20:46:26 +0000
Message-ID: <20150306204626.GJ21293@sirena.org.uk>
References: <1425597344-6199-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9159385203595985328=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 590D8265FFA
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:46:35 +0100 (CET)
In-Reply-To: <1425597344-6199-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anish Kumar <yesanishhere@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9159385203595985328==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5CpfyHqbcU92Qzwd"
Content-Disposition: inline


--5CpfyHqbcU92Qzwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2015 at 03:15:44PM -0800, Anish Kumar wrote:

Looks pretty good but still a few things which are hopefully fairly easy
to address.

> changes since v1:
> 	- addressed mark brown comments regarding
> 	  open coding functions.
> 	- changed the mixer namings
> 	- added some dapm widgets

Don't put stuff like this in the changelog, put it after the --- as
covered in SubmittingPatches.

> +static const struct soc_enum max98925_enum[] = {
> +	SOC_ENUM_SINGLE(MAX98925_GAIN, 5, 4, dai_text),
> +	SOC_ENUM_SINGLE(MAX98925_FILTERS, 0, 6, hpf_text),
> +};
> +
> +static const struct snd_kcontrol_new max98925_dai_sel =
> +	SOC_DAPM_ENUM("Route", max98925_enum[0]);
> +
> +static const struct snd_kcontrol_new max98925_hpf_sel =
> +	SOC_DAPM_ENUM("Route", max98925_enum[1]);

Don't use magic number indexes into a table of arrays, this does nothing
for legibility or maintainability.  Use individual variables like other
drivers do.

> +static int max98925_spk_gain_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
> +	unsigned int sel = ucontrol->value.integer.value[0];
> +
> +	if (sel < ((1 << M98925_SPK_GAIN_WIDTH) - 1)) {
> +		regmap_update_bits(max98925->regmap, MAX98925_GAIN,
> +			M98925_SPK_GAIN_MASK, sel << M98925_SPK_GAIN_SHIFT);
> +		max98925->spk_gain = sel;

My previous comment about this not being used anywere and this being
suitable for a normal control still seem to apply here.

> +static int max98925_boost_voltage_get(struct snd_kcontrol *kcontrol,
> +		struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_kcontrol_chip(kcontrol);
> +	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
> +	int data;
> +
> +	regmap_read(max98925->regmap, MAX98925_CONFIGURATION, &data);
> +	ucontrol->value.integer.value[0] =
> +		(data & M98925_BST_VOUT_MASK) >> M98925_BST_VOUT_SHIFT;
> +	return 0;
> +}

Similarly for this control, why is this open coded?

> +static const struct snd_kcontrol_new max98925_snd_controls[] = {
> +	SOC_SINGLE_EXT_TLV("Speaker Gain", MAX98925_GAIN,
> +		M98925_SPK_GAIN_SHIFT, (1<<M98925_SPK_GAIN_WIDTH)-1, 0,
> +		max98925_spk_gain_get, max98925_spk_gain_put, max98925_spk_tlv),

All volume controls should be called ...Volume, see ControlNames.txt.

> +	SOC_SINGLE("Speaker Ramp", MAX98925_GAIN_RAMPING,
> +				M98925_SPK_RMP_EN_SHIFT, 1, 0),

Similarly on/off switches should be called ...Switch.

> +	pr_debug("%s: sample rate is %d, returning %d\n",
> +				__func__, rate_table[i].rate, *value);

Use dev_ print functions rather than pr_ where you have a device.

> +	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +	case SND_SOC_DAIFMT_CBS_CFS:
> +		max98925_set_slave(max98925);
> +		break;
> +	case SND_SOC_DAIFMT_CBM_CFM:
> +		max98925_set_master(max98925);
> +		break;

I don't really understand why we have these functions - they're small
enough just to have the code inline here aren't they?

> +	switch (params_format(params)) {
> +	case SNDRV_PCM_FORMAT_S16_LE:

Use params_width() rather than relying on the specific memory format.

> +
> +	dev_dbg(codec->dev, "%s: mute %d\n", __func__, mute);
> +	if (mute) {
> +		regmap_update_bits(max98925->regmap, MAX98925_GAIN,
> +			M98925_SPK_GAIN_MASK, 0x00);

This will collide with the volume control exposed to users, don't do
this - if you don't have a suitable mute control in the hardware just
don't implement this function.

> +static int max98925_probe(struct snd_soc_codec *codec)
> +{
> +	struct max98925_priv *max98925 = snd_soc_codec_get_drvdata(codec);
> +	int ret = 0;
> +	int reg = 0;
> +
> +	dev_info(codec->dev, "build number %s\n", MAX98925_REVISION);

Don't print noise like this, it's not adding anything - the kernel
already displays it's own version.

> +
> +	max98925->codec = codec;
> +	codec->control_data = max98925->regmap;
> +	ret = regmap_read(max98925->regmap,
> +			MAX98925_REV_VERSION, &reg);
> +	if ((ret < 0) ||
> +		((reg != MAX98925_VERSION) &&
> +		(reg != MAX98925_VERSION1))) {
> +		dev_err(codec->dev,
> +			"device initialization error (%d 0x%02X)\n",
> +			ret, reg);
> +		goto err_access;
> +	}

Move all this basic I2C setup and version display stuff to the I2C level
probe, no need to defer it and it means that we confirm we can talk to
the CODEC before we start the sound card.

> +	if (!of_property_read_u32(i2c->dev.of_node, "vmon-slot-no", &value)) {
> +		if (value > M98925_DAI_VMON_SLOT_1E_1F) {
> +			dev_err(&i2c->dev, "vmon slot number is wrong:\n");
> +			return -EINVAL;
> +		}
> +		max98925->v_slot = value;
> +	}

All DT bindings need to be documented but there is no binding document
for this CODEC.

> +static int max98925_i2c_remove(struct i2c_client *client)
> +{
> +	snd_soc_unregister_codec(&client->dev);
> +	kfree(i2c_get_clientdata(client));

Use devm_kzalloc().

> +static const struct i2c_device_id max98925_i2c_id[] = {
> +	{ "max98925", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, max98925_i2c_id);
> +
> +static struct i2c_driver max98925_i2c_driver = {
> +	.driver = {
> +		.name = "max98925",
> +		.owner = THIS_MODULE,
> +		.pm = NULL,
> +	},
> +	.probe  = max98925_i2c_probe,
> +	.remove = max98925_i2c_remove,
> +	.id_table = max98925_i2c_id,
> +};

You have DT bindings but no of_match_table.

> +#define MAX98925_REVISION	"0.00.0333"

Remove this, for in-tree code the kernel is already well enough
versioned and nobody working in tree is going to care to update this.

--5CpfyHqbcU92Qzwd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+hIhAAoJECTWi3JdVIfQyqMH/RGPJmrvUfDtmMJHVETCRcFP
inTo+4HA11Mrb/CGdqcKkozPZiiWn5rJbtINztutPjwVLdJV9bFerm0hwL4IFJLY
0D2Yk9O2pHsr62UlCWfKRa2fwYQaCI25hnzhMk454XQRCX4UlhFuzLO2avCuyqRA
p6ko6Wgde5rOuGYMZSl+39yrfME8S88755axBcoKJQpqSJgXxdhu8PLIl+NqToGz
Nu2tmbdsLESD3IcMmsUeaibe0ERgX5RhRXN8fei7VWiihea4NmTaHrsPz7zLN0Y0
XUihWqN2p9RMCiJz1yiSouBJ0M/faGb0TAFhbBhaKAwsDp/PVWEtBjoaVjihYtM=
=7cwt
-----END PGP SIGNATURE-----

--5CpfyHqbcU92Qzwd--

--===============9159385203595985328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9159385203595985328==--
