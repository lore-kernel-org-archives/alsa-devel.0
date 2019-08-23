From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: Re: [PATCH 20/21] ASoC: sun4i-i2s: Add support for TDM slots
Date: Fri, 23 Aug 2019 12:09:17 +0300
Message-ID: <606f8345-827c-e6e8-7cff-221b4b592eba@orpaltech.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com>
 <c311e88a-fdd2-8a01-275e-675d98dc90ba@orpaltech.com>
 <20190821120551.r4b3h4nnet357wem@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190821120551.r4b3h4nnet357wem@flea>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <mripard@kernel.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, codekipper@gmail.com, Chen-Yu Tsai <wens@csie.org>, broonie@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi, Maxime,

On 8/21/19 3:05 PM, Maxime Ripard wrote:
> Hi,
>
> On Tue, Aug 20, 2019 at 08:46:30AM +0300, Sergey Suloev wrote:
>> Hi, Maxime,
>>
>> On 8/19/19 10:25 PM, Maxime Ripard wrote:
>>> From: Maxime Ripard <maxime.ripard@bootlin.com>
>>>
>>> The i2s controller supports TDM, for up to 8 slots. Let's support the TDM
>>> API.
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>>> ---
>>>    sound/soc/sunxi/sun4i-i2s.c | 40 ++++++++++++++++++++++++++++++++------
>>>    1 file changed, 34 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>>> index 0dac09814b65..4f76daeaaed7 100644
>>> --- a/sound/soc/sunxi/sun4i-i2s.c
>>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>>> @@ -168,6 +168,8 @@ struct sun4i_i2s {
>>>    	struct reset_control *rst;
>>>    	unsigned int	mclk_freq;
>>> +	unsigned int	slots;
>>> +	unsigned int	slot_width;
>>>    	struct snd_dmaengine_dai_dma_data	capture_dma_data;
>>>    	struct snd_dmaengine_dai_dma_data	playback_dma_data;
>>> @@ -287,7 +289,7 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
>>>    static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>>>    				  unsigned int rate,
>>> -				  unsigned int channels,
>>> +				  unsigned int slots,
>>>    				  unsigned int word_size)
>>>    {
>>>    	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>>> @@ -335,7 +337,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>>>    	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
>>>    	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
>>> -					  rate, channels, word_size);
>>> +					  rate, slots, word_size);
>>>    	if (bclk_div < 0) {
>>>    		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
>>>    		return -EINVAL;
>>> @@ -419,6 +421,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>>>    				  const struct snd_pcm_hw_params *params)
>>>    {
>>>    	unsigned int channels = params_channels(params);
>>> +	unsigned int slots = channels;
>>> +
>>> +	if (i2s->slots)
>>> +		slots = i2s->slots;
>>>    	/* Map the channels for playback and capture */
>>>    	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
>>> @@ -428,7 +434,6 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>>>    	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
>>>    			   SUN4I_I2S_CHAN_SEL_MASK,
>>>    			   SUN4I_I2S_CHAN_SEL(channels));
>>> -
>>>    	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
>>>    			   SUN4I_I2S_CHAN_SEL_MASK,
>>>    			   SUN4I_I2S_CHAN_SEL(channels));
>>> @@ -452,10 +457,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>>>    			       struct snd_soc_dai *dai)
>>>    {
>>>    	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>>> +	unsigned int word_size = params_width(params);
>>>    	unsigned int channels = params_channels(params);
>>> +	unsigned int slots = channels;
>>>    	int ret, sr, wss;
>>>    	u32 width;
>>> +	if (i2s->slots)
>>> +		slots = i2s->slots;
>>> +
>>> +	if (i2s->slot_width)
>>> +		word_size = i2s->slot_width;
>>> +
>>>    	ret = i2s->variant->set_chan_cfg(i2s, params);
>>>    	if (ret < 0) {
>>>    		dev_err(dai->dev, "Invalid channel configuration\n");
>>> @@ -477,15 +490,14 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>>>    	if (sr < 0)
>>>    		return -EINVAL;
>>> -	wss = i2s->variant->get_wss(i2s, params_width(params));
>>> +	wss = i2s->variant->get_wss(i2s, word_size);
>>>    	if (wss < 0)
>>>    		return -EINVAL;
>>>    	regmap_field_write(i2s->field_fmt_wss, wss);
>>>    	regmap_field_write(i2s->field_fmt_sr, sr);
>>> -	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
>>> -				      channels, params_width(params));
>>> +	return sun4i_i2s_set_clk_rate(dai, params_rate(params), slots, word_size);
>>>    }
>>>    static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
>>> @@ -785,10 +797,26 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>>>    	return 0;
>>>    }
>>> +static int sun4i_i2s_set_tdm_slot(struct snd_soc_dai *dai,
>>> +				  unsigned int tx_mask, unsigned int rx_mask,
>>> +				  int slots, int slot_width)
>>> +{
>>> +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>>> +
>>> +	if (slots > 8)
>>> +		return -EINVAL;
>>> +
>>> +	i2s->slots = slots;
>>> +	i2s->slot_width = slot_width;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>    static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>>>    	.hw_params	= sun4i_i2s_hw_params,
>>>    	.set_fmt	= sun4i_i2s_set_fmt,
>>>    	.set_sysclk	= sun4i_i2s_set_sysclk,
>>> +	.set_tdm_slot	= sun4i_i2s_set_tdm_slot,
>>>    	.trigger	= sun4i_i2s_trigger,
>>>    };
>> it seems like you forgot to implement sun4i_i2s_dai_ops.set_bclk_ratio
>> because, as I far as I understand, it should alter tdm slots functionality
>> indirectly.
> As far as I can see, while this indeed changes a few things on the TDM
> setup, it's optional, orthogonal and it has a single user in the tree
> (some intel platform card).
>
> So I'd say that if someone ever needs it, we can have it, but it's not
> a blocker.

"orthogonal" meaning that one can achieve the same effect with using 
"sun4i_i2s_set_tdm_slot" instead of "set_bclk_ratio" ?

For example, for WM8731 codec in "non-USB" master mode should generate 
BCLK = 64 * FS, and I had to implement "set_bclk_ratio" in order to 
setup it. Note, that this is 100% mandatory condition for the code to 
operate in this mode.

Did you mean that now the correct way would be using 
"sun4i_i2s_set_tdm_slot" instead ?


Thank you


>
> Maxime
>
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
