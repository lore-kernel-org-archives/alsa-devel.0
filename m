From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] [ALSA] ASoC: Add max98925 codec driver
Date: Fri, 16 Jan 2015 18:11:59 +0100
Message-ID: <54B9465F.2060603@metafoo.de>
References: <1421356633-30617-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-013.synserver.de (smtp-out-013.synserver.de
 [212.40.185.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B9C226040E
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 18:11:58 +0100 (CET)
In-Reply-To: <1421356633-30617-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anish Kumar <yesanishhere@gmail.com>, alsa-devel@alsa-project.org
Cc: Anish Kumar <anish.kumar@maximintegrated.com>, nitin.mittal@maximintegrated.com
List-Id: alsa-devel@alsa-project.org

On 01/15/2015 10:17 PM, Anish Kumar wrote:
> From: Anish Kumar <anish.kumar@maximintegrated.com>
>
> This patch adds the max98925 codec driver.
>
> Signed-off-by: Anish Kumar <anish.kumar@maximintegrated.com>

Please make sure to submit drivers against the latest development version of 
the ASoC tree 
(http://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/log/?h=for-next). 
This has a couple of outdated things and won't even compile.

> +
> +static const unsigned int max98925_spk_tlv[] = {
> +	TLV_DB_RANGE_HEAD(1),
> +	1, 31, TLV_DB_SCALE_ITEM(-600, 100, 0),
> +};

DECLARE_TLV_DB_SCALE(...)

> +static int max98925_add_widgets(struct snd_soc_codec *codec)
> +{
> +	int ret;
> +
> +	ret = snd_soc_add_codec_controls(codec, max98925_snd_controls,
> +		ARRAY_SIZE(max98925_snd_controls));


Assign this to the controls and num_controls fields of the CODEC driver 
instead of manually calling add_codec_controls.

[...]
> +static int max98925_set_tdm_slot(struct snd_soc_dai *codec_dai,
> +	unsigned int tx_mask, unsigned int rx_mask, int slots, int slot_width)
> +{
> +	pr_info("%s: tx_mask 0x%X, rx_mask 0x%X, slots %d, slot width %d\n",
> +			__func__, tx_mask, rx_mask, slots, slot_width);
> +	return 0;
> +}
> +
[...]
> +static int max98925_set_bias_level(struct snd_soc_codec *codec,
> +				   enum snd_soc_bias_level level)
> +{
> +	codec->dapm.bias_level = level;
> +	return 0;
> +}
> +

Drop all those all empty callbacks


> +static struct snd_soc_dai_ops max98925_dai_ops = {

const

> +	.set_sysclk = max98925_dai_set_sysclk,
> +	.set_fmt = max98925_dai_set_fmt,
> +	.set_tdm_slot = max98925_set_tdm_slot,
> +	.hw_params = max98925_dai_hw_params,
> +	.digital_mute = max98925_dai_digital_mute,
> +};
> +
[...]
> +static struct snd_soc_codec_driver soc_codec_dev_max98925 = {

const

> +	.probe            = max98925_probe,
> +	.set_bias_level   = max98925_set_bias_level,

You'll need at least some kind of DAPM, otherwise you CODEC won't do anything.

> +};
> +
[...]
> +/* There should be a second MAX98925 on the board */
> +static struct i2c_board_info max98925_i2c_second[] = {
> +	{
> +		I2C_BOARD_INFO("max98925R", 0x32),
> +	}
> +};
> +
> +struct i2c_client *add_second_device(int busnum)
> +{
> +	struct i2c_client *i2c = NULL;
> +	struct i2c_adapter *adapter;
> +
> +	adapter = i2c_get_adapter(busnum);
> +	if (adapter != NULL)
> +		i2c = i2c_new_device(adapter, max98925_i2c_second);
> +
> +	return i2c;
> +}
[...]
> +	/* Check for second MAX98925 */
> +	i2c_r = add_second_device(2);

If there are two devices instantiate them properly and create two CODEC 
devices, not some kind of hackery like this.


[...]
