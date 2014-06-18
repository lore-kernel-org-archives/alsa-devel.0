From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [RFC PATCH] ASoC: tas2552: Support TI TAS2552 Amplifier
Date: Wed, 18 Jun 2014 14:05:23 -0500
Message-ID: <53A1E2F3.8070205@ti.com>
References: <1403113547-15120-1-git-send-email-dmurphy@ti.com> <20140618184440.GK5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <20140618184440.GK5099@sirena.org.uk>
Sender: linux-sound-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark
Thanks for the comments

On 06/18/2014 01:44 PM, Mark Brown wrote:
> On Wed, Jun 18, 2014 at 12:45:46PM -0500, Dan Murphy wrote:
>
>> +static int tas2552_i2c_read(struct tas2552_data *tas_data, int reg)
>> +{
>> +	int val;
>> +
>> +	if (WARN_ON(!tas_data->tas2552_client))
>> +		return -EINVAL;
>> +
>> +	/* If powered off, return the cached value */
>> +	mutex_lock(&tas_data->mutex);
>> +	if (tas_data->power_state) {
>> +		val = i2c_smbus_read_byte_data(tas_data->tas2552_client, reg);
> Don't open code your I/O, use regmap like any other CODEC driver.  This
> will remove a very large proportion of the code in the driver which
> replicates features of the regmap framework.

My initial implementation was with regmap but it gave me heart ache.
Which could have been wonky HW.

I will attempt regmap again and see if it was just a HW issue.

>
>> +static int tas2552_startup(struct snd_pcm_substream *substream,
>> +			   struct snd_soc_dai *dai)
>> +{
>> +	struct snd_soc_codec *codec = dai->codec;
>> +	struct tas2552_data *tas2552 = snd_soc_codec_get_drvdata(codec);
>> +
>> +	tas2552_sw_shutdown(tas2552, 1);
>> +	tas2552_power(tas2552, 1);
>> +	/* Turn on Class D amplifier */
>> +	tas2552_i2c_write(tas2552, TAS2552_CFG_2, 0x80);
>> +	tas2552_sw_shutdown(tas2552, 0);
> I'd expect this to be done using DAPM.

Will take a look at it for V2.

>
>> +static const struct regmap_config tas2552_regmap_config = {
>> +	.reg_bits = 8,
>> +	.val_bits = 8,
>> +
>> +	.max_register = TAS2552_MAX_REG,
>> +	.reg_defaults = NULL,
>> +	.num_reg_defaults = 0,
> No need to set things to zero or NULL in static variables, that's the
> default.

This was an artifact from my regmap implementation.  This will be
populated when I re-implement the regmap code.

>> +	dev = &client->dev;
>> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
>> +	if (data == NULL) {
>> +		dev_err(dev, "Can not allocate memory\n");
> No need to print an error, OOM messages are already quite noisy.

Will remove.

Dan

-- 
------------------
Dan Murphy

