From: Michael Stecklein <m-stecklein@ti.com>
Subject: Re: [PATCH v3 2/2] ASoC: add support for TAS6424
	digital amplifier
Date: Wed, 26 Jul 2017 12:44:34 -0500
Message-ID: <f94172dc-3e29-999f-ffb5-7eb955fcb1a5@ti.com>
References: <1500405604-23511-1-git-send-email-m-stecklein@ti.com>
 <1500405604-23511-3-git-send-email-m-stecklein@ti.com>
 <20170719110842.lb2f5cqawnkenhsb@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 221802673F0
 for <alsa-devel@alsa-project.org>; Wed, 26 Jul 2017 19:44:35 +0200 (CEST)
In-Reply-To: <20170719110842.lb2f5cqawnkenhsb@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org


On 07/19/2017 06:08 AM, Mark Brown wrote:
> On Tue, Jul 18, 2017 at 02:20:04PM -0500, Michael Stecklein wrote:
>
>> +	if (!tx_mask) {
>> +		dev_err(codec->dev, "tdm mask must not be 0\n");
>> +		return -EINVAL;
>> +	}
> Setting the mask to 0 is used when turning off TDM.
When turning off TDM, will the set_tdm_slot function ever get
called? (Since the TDM was turned off the slots don't need to
be set.) Also, for this device TDM mode is automatically
selected based on the presence of a TDM clock, so there is
nothing to do to switch into or out of TDM mode. Similar
parts handle this the same way, such as: tlv320aic3x.c,
tas2552.c, tas5720.c, ssm4567.c
>
>> +	if ((reg & TAS6424_WARN_VDD_UV) && !(tas6424->last_warn & TAS6424_WARN_VDD_UV))
>> +		dev_warn(dev, "experienced a VDD under voltage condition\n");
>> +
>> +	if ((reg & TAS6424_WARN_VDD_POR) && !(tas6424->last_warn & TAS6424_WARN_VDD_POR))
>> +		dev_warn(dev, "experienced a VDD POR condition\n");
> These look like they are errors rather than warnings and should be
> critical prints like the other errors.
These conditions happened on the previous shutdown/reset
of the device. We are letting the user know about them, but
they are not critical to the current device state, so I have left
them as warnings.
>
>> +	/* Store current warn value so we can detect any changes next time */
>> +	tas6424->last_warn = reg;
> It would be better to clear these at some point, perhaps after a delay.
> Especially with thermal issues they could come and go over device
> operation.
Since this function is called every 200ms, if an issue comes
and goes, last_warn will be cleared during the next function
call after the issue ends; the function regmap_read will read
in a 0 for that flag's bit, and that new reg value will be saved.
Therefore, the user will be warned only once if the issue is
persistent, but rewarned if the issues leaves and comes
back, so I do not think clearing after a delay is necessary.
>
>> +static int tas6424_codec_probe(struct snd_soc_codec *codec)
>> +{
>> +	struct tas6424_data *tas6424 = snd_soc_codec_get_drvdata(codec);
>> +	int ret;
>> +
>> +	tas6424->codec = codec;
>> +
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(tas6424->supplies),
>> +				    tas6424->supplies);
>> +	if (ret != 0) {
>> +		dev_err(codec->dev, "failed to enable supplies: %d\n", ret);
>> +		return ret;
>> +	}
> This init stuff should be in either the main I2C probe, DAPM or bias
> level management.  The CODEC probe should be very minimal.
This is a single codec device, does it make sense to leave the
device running without its codec? Other single codec devices
initialize regulators in codec probe similarly.
>
>> +	if (event & SND_SOC_DAPM_POST_PMU) {
>> +	} else if (event & SND_SOC_DAPM_PRE_PMD) {
> You're trying to write a switch statement here.
Acked.
>
>> +	switch (level) {
>> +	case SND_SOC_BIAS_ON:
>> +	case SND_SOC_BIAS_PREPARE:
>> +		msleep(500);
>> +		break;
> You need a 500ms sleep in all these cases?  That's a lot of sleeping.
Unfortunately, the device runs diagnostics at this point,
which take upwards of 480ms.
>
>> +	case SND_SOC_BIAS_STANDBY:
>> +		ret = snd_soc_update_bits(codec, TAS6424_CH_STATE_CTRL_REG,
>> +					  0xff, TAS6424_CH1_STATE_MUTE | TAS6424_CH2_STATE_MUTE |
>> +					  TAS6424_CH3_STATE_MUTE | TAS6424_CH4_STATE_MUTE);
>> +
>> +		if (ret < 0) {
>> +			dev_err(codec->dev, "error resuming device: %d\n", ret);
>> +			return ret;
>> +		}
>> +		break;
>> +	case SND_SOC_BIAS_OFF:
>> +		ret = snd_soc_update_bits(codec, TAS6424_CH_STATE_CTRL_REG,
>> +					  0xff, TAS6424_CH1_STATE_HIZ | TAS6424_CH2_STATE_HIZ |
>> +					  TAS6424_CH3_STATE_HIZ | TAS6424_CH4_STATE_HIZ);
>> +
>> +		if (ret < 0) {
>> +			dev_err(codec->dev, "error suspending device: %d\n", ret);
>> +			return ret;
>> +		}
> These mutes seem very random disassociated from anything else?
What do you mean by this comment? The control register is
set to STATE_MUTE and STATE_HIZ depending on what the
device needs for the new BIAS level.
