From: Code Kipper <codekipper@gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/3] ASoC: sun4i-i2s: Add
	set_tdm_slot functionality
Date: Mon, 29 Jan 2018 08:34:00 +0100
Message-ID: <CAEKpxBn6FNLCN22Bax1RiTdZbsHOqq6Ls5k2JYz6QJt4_77ffA@mail.gmail.com>
References: <20180124141101.12867-1-codekipper@gmail.com>
 <20180124141101.12867-2-codekipper@gmail.com>
 <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it0-f68.google.com (mail-it0-f68.google.com
 [209.85.214.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D57626718B
 for <alsa-devel@alsa-project.org>; Mon, 29 Jan 2018 08:34:01 +0100 (CET)
Received: by mail-it0-f68.google.com with SMTP id p139so7145788itb.1
 for <alsa-devel@alsa-project.org>; Sun, 28 Jan 2018 23:34:01 -0800 (PST)
In-Reply-To: <CAGb2v67eYFP1cnJ8iY9-Y-50kSbuY_Wip51q0veqx9z0_Prenw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Andrea Venturi (pers)" <be17068@iperbole.bo.it>, linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 29 January 2018 at 02:50, Chen-Yu Tsai <wens@csie.org> wrote:
> On Wed, Jan 24, 2018 at 10:10 PM,  <codekipper@gmail.com> wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Some codecs require a different amount of a bit clocks per frame than
>> what is calculated by the sample width. Use the tdm slot bindings to
>> provide this mechanism.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  sound/soc/sunxi/sun4i-i2s.c | 23 +++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index dca1143c1150..d7a9141514cf 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -96,6 +96,7 @@
>>  #define SUN8I_I2S_CTRL_BCLK_OUT                        BIT(18)
>>  #define SUN8I_I2S_CTRL_LRCK_OUT                        BIT(17)
>>
>> +#define SUN8I_I2S_FMT0_LRCK_MAX_PERIOD         (GENMASK(17, 8) >> 8)
>>  #define SUN8I_I2S_FMT0_LRCK_PERIOD_MASK                GENMASK(17, 8)
>>  #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)     ((period - 1) << 8)
>>
>> @@ -193,6 +194,9 @@ struct sun4i_i2s {
>>         struct regmap_field     *field_rxchansel;
>>
>>         const struct sun4i_i2s_quirks   *variant;
>> +
>> +       unsigned int    tdm_slots;
>> +       unsigned int    slot_width;
>>  };
>>
>>  struct sun4i_i2s_clk_div {
>> @@ -344,7 +348,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
>>         if (i2s->variant->has_fmt_set_lrck_period)
>>                 regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>>                                    SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
>> -                                  SUN8I_I2S_FMT0_LRCK_PERIOD(32));
>> +                                  SUN8I_I2S_FMT0_LRCK_PERIOD(word_size));
>>
>>         return 0;
>>  }
>> @@ -418,7 +422,8 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>>                            sr + i2s->variant->fmt_offset);
>>
>>         return sun4i_i2s_set_clk_rate(dai, params_rate(params),
>> -                                     params_width(params));
>> +                                     i2s->tdm_slots ?
>> +                                     i2s->slot_width : params_width(params));
>>  }
>>
>>  static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>> @@ -691,6 +696,19 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
>>         return 0;
>>  }
>>
>> +static int sun4i_i2s_set_dai_tdm_slot(struct snd_soc_dai *dai,
>> +       unsigned int tx_mask, unsigned int rx_mask,
>> +       int slots, int width)
>> +{
>> +       struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>> +
>> +       i2s->tdm_slots = slots;
>> +
>> +       i2s->slot_width = width;
>> +
>> +       return 0;
>> +}
>> +
>
> IIRC some of the DAI controllers actually support TDM. Would this
> change conflict with that in the future?

Hi Wens,
I'm not sure..I was looking for a clean example of being able to
override the number of bclks in the lrclk width and some other
devices(Rpi) were doing it this way.  I open to suggestions,
BR,
CK
>
> Thanks
> ChenYu
>
>>  static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>>         .hw_params      = sun4i_i2s_hw_params,
>>         .set_fmt        = sun4i_i2s_set_fmt,
>> @@ -698,6 +716,7 @@ static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
>>         .shutdown       = sun4i_i2s_shutdown,
>>         .startup        = sun4i_i2s_startup,
>>         .trigger        = sun4i_i2s_trigger,
>> +       .set_tdm_slot   = sun4i_i2s_set_dai_tdm_slot,
>>  };
>>
>>  static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
>> --
>> 2.16.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
>> For more options, visit https://groups.google.com/d/optout.
