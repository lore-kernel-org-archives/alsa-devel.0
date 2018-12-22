From: Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 1/9] ASoC: sun4i-i2s: Adjust regmap
 settings
Date: Sat, 22 Dec 2018 22:12:08 +0000
Message-ID: <DB7PR03MB46813005FFDFC8609F67F111ACB90@DB7PR03MB4681.eurprd03.prod.outlook.com>
References: <20181221152110.17982-1-codekipper@gmail.com>
 <20181221152110.17982-2-codekipper@gmail.com>
 <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-oln040092067089.outbound.protection.outlook.com [40.92.67.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 2240F26798A
 for <alsa-devel@alsa-project.org>; Sat, 22 Dec 2018 23:12:10 +0100 (CET)
In-Reply-To: <CAGb2v66-JmONW9AYqoSmifrEj+nstREdsbkcy9ECwnJ47zxARA@mail.gmail.com>
Content-Language: en-US
Content-ID: <F307A1F0ECBB5B4EB50C38F5BE1EB0D6@eurprd03.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>, Code Kipper <codekipper@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Andrea
 Venturi (pers)" <be17068@iperbole.bo.it>, linux-sunxi <linux-sunxi@googlegroups.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 2018-12-21 17:44, Chen-Yu Tsai wrote:
> On Fri, Dec 21, 2018 at 11:21 PM <codekipper@gmail.com> wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Bypass the regmap cache when flushing the i2s FIFOs and modify the tables
>> to reflect this.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  sound/soc/sunxi/sun4i-i2s.c | 29 +++++++++--------------------
>>  1 file changed, 9 insertions(+), 20 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index d5ec1a20499d..64d073cb2aee 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -548,9 +548,11 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
>>  static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>>  {
>>         /* Flush RX FIFO */
>> +       regcache_cache_bypass(i2s->regmap, true);
>>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX,
>>                            SUN4I_I2S_FIFO_CTRL_FLUSH_RX);
>> +       regcache_cache_bypass(i2s->regmap, false);
> IIRC the flush cache bit is self-clearing. So you likely want to mark
> this register as volatile. If it is marked as volatile, then all access
> to that register bypasses the cache, so the regcache_cache_bypass calls
> are unneeded.

I helped test this together with Marcus and when I tested with this
register marked
as volatile audio started to stutter, still unclear why audio starts to
stutter.

Without this cache bypass the flush TX/RX bits gets cached and flush
happens unexpectedly
resulting in multi channel audio getting mapped to wrong speaker.
Other ASoC codecs and fsl_spdif.c seems to use similar cache bypass for
reset/flush.

>
> However, looking at the code, the write would seem to be ignored if the
> regmap is in the cache_only state. We only set this when the bus clock
> is disabled. Under such a condition, bypassing the cache and forcing a
> write would be unwise, as the system either drops the write, or stalls
> altogether.
>
>>         /* Clear RX counter */
>>         regmap_write(i2s->regmap, SUN4I_I2S_RX_CNT_REG, 0);
>> @@ -569,9 +571,11 @@ static void sun4i_i2s_start_capture(struct sun4i_i2s *i2s)
>>  static void sun4i_i2s_start_playback(struct sun4i_i2s *i2s)
>>  {
>>         /* Flush TX FIFO */
>> +       regcache_cache_bypass(i2s->regmap, true);
>>         regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
>>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX,
>>                            SUN4I_I2S_FIFO_CTRL_FLUSH_TX);
>> +       regcache_cache_bypass(i2s->regmap, false);
>>
>>         /* Clear TX counter */
>>         regmap_write(i2s->regmap, SUN4I_I2S_TX_CNT_REG, 0);
>> @@ -703,13 +707,7 @@ static const struct snd_soc_component_driver sun4i_i2s_component = {
>>
>>  static bool sun4i_i2s_rd_reg(struct device *dev, unsigned int reg)
>>  {
>> -       switch (reg) {
>> -       case SUN4I_I2S_FIFO_TX_REG:
>> -               return false;
>> -
>> -       default:
>> -               return true;
>> -       }
>> +       return true;
> I don't understand why this is relevant. Do you need to read back from the TX
> FIFO?

This change was inspired by c66234cfedfc "ASoC: rockchip: i2s: fix
playback after runtime resume" [1]
On resume a cached sample would be written to FIFO_TX_REG unless it is
marked volatile,
the rockchip commit indicated that read is needed for volatile regs.

[1]
https://github.com/torvalds/linux/commit/c66234cfedfc3e6e3b62563a5f2c1562be09a35d

>
> If so, just drop the call-back altogether. If no callback is provided and no
> rd_table is provided either, it defaults to all registers under max_register
> (if max_register < 0) are readable.
>
> However this seems like it deserves to be a separate patch (where you explain
> in the commit log why it's needed).
>
> Regards
> ChenYu
>
>>  }
>>
>>  static bool sun4i_i2s_wr_reg(struct device *dev, unsigned int reg)
>> @@ -728,6 +726,8 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>  {
>>         switch (reg) {
>>         case SUN4I_I2S_FIFO_RX_REG:
>> +       case SUN4I_I2S_FIFO_TX_REG:
>> +       case SUN4I_I2S_FIFO_STA_REG:
>>         case SUN4I_I2S_INT_STA_REG:
>>         case SUN4I_I2S_RX_CNT_REG:
>>         case SUN4I_I2S_TX_CNT_REG:
>> @@ -738,23 +738,12 @@ static bool sun4i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>         }
>>  }
>>
>> -static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
>> -{
>> -       switch (reg) {
>> -       case SUN8I_I2S_FIFO_TX_REG:
>> -               return false;
>> -
>> -       default:
>> -               return true;
>> -       }
>> -}
>> -
>>  static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
>>  {
>>         if (reg == SUN8I_I2S_INT_STA_REG)
>>                 return true;
>>         if (reg == SUN8I_I2S_FIFO_TX_REG)
>> -               return false;
>> +               return true;
>>
>>         return sun4i_i2s_volatile_reg(dev, reg);
>>  }
>> @@ -809,7 +798,7 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
>>         .reg_defaults   = sun8i_i2s_reg_defaults,
>>         .num_reg_defaults       = ARRAY_SIZE(sun8i_i2s_reg_defaults),
>>         .writeable_reg  = sun4i_i2s_wr_reg,
>> -       .readable_reg   = sun8i_i2s_rd_reg,
>> +       .readable_reg   = sun4i_i2s_rd_reg,
>>         .volatile_reg   = sun8i_i2s_volatile_reg,
>>  };
>>
>> --
>> 2.20.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
>
