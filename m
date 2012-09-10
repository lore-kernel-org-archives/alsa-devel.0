From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH 2/2] ASoC: sta32x: Convert to regmap
Date: Mon, 10 Sep 2012 11:10:18 +0200
Message-ID: <20120910091018.GC31081@sig21.net>
References: <1347246103-10010-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1347246103-10010-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
 by alsa0.perex.cz (Postfix) with ESMTP id 92527264FE8
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 11:10:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1347246103-10010-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Sven Neumann <s.neumann@raumfeld.com>, Liam Girdwood <lrg@ti.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

(added some Cc:)

On Mon, Sep 10, 2012 at 11:01:43AM +0800, Mark Brown wrote:
> Long term all drivers should be using regmap directly. This is more
> idiomatic and moves us towards the removal of the ASoC level cache
> code.
> 
> The initialiasation of reserved register bits in probe() is slightly odd
> as the defaults being written don't appear to match the silicon defaults
> but the new code should have the same effect as the old code.
> 
> The watchdog code will now unconditionally do a mute and unmute when
> resyncing but since we only sync when we are very sure there is something
> to sync this should have no impact.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Looks good to me, but I wouldn't have spotted the missing
".cache_type = REGCACHE_RBTREE" that you noticed yourself
thus my Acked-by doesn't mean that much.  You can add it
anyway if you want: Acked-by: Johannes Stezenbach <js@sig21.net>

Thanks,
Johannes


> ---
>  sound/soc/codecs/sta32x.c |  106 +++++++++++++++++++++++++++++++++------------
>  1 file changed, 79 insertions(+), 27 deletions(-)
> 
> diff --git a/sound/soc/codecs/sta32x.c b/sound/soc/codecs/sta32x.c
> index 039597e..744ec7a 100644
> --- a/sound/soc/codecs/sta32x.c
> +++ b/sound/soc/codecs/sta32x.c
> @@ -24,6 +24,7 @@
>  #include <linux/delay.h>
>  #include <linux/pm.h>
>  #include <linux/i2c.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/workqueue.h>
> @@ -55,12 +56,50 @@
>  	 SNDRV_PCM_FMTBIT_S32_LE  | SNDRV_PCM_FMTBIT_S32_BE)
>  
>  /* Power-up register defaults */
> -static const u8 sta32x_regs[STA32X_REGISTER_COUNT] = {
> -	0x63, 0x80, 0xc2, 0x40, 0xc2, 0x5c, 0x10, 0xff, 0x60, 0x60,
> -	0x60, 0x80, 0x00, 0x00, 0x00, 0x40, 0x80, 0x77, 0x6a, 0x69,
> -	0x6a, 0x69, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> -	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2d,
> -	0xc0, 0xf3, 0x33, 0x00, 0x0c,
> +static const struct reg_default sta32x_regs[] = {
> +	{  0x0, 0x63 },
> +	{  0x1, 0x80 },
> +	{  0x2, 0xc2 },
> +	{  0x3, 0x40 },
> +	{  0x4, 0xc2 },
> +	{  0x5, 0x5c },
> +	{  0x6, 0x10 },
> +	{  0x7, 0xff },
> +	{  0x8, 0x60 },
> +	{  0x9, 0x60 },
> +	{  0xa, 0x60 },
> +	{  0xb, 0x80 },
> +	{  0xc, 0x00 },
> +	{  0xd, 0x00 },
> +	{  0xe, 0x00 },
> +	{  0xf, 0x40 },
> +	{ 0x10, 0x80 },
> +	{ 0x11, 0x77 },
> +	{ 0x12, 0x6a },
> +	{ 0x13, 0x69 },
> +	{ 0x14, 0x6a },
> +	{ 0x15, 0x69 },
> +	{ 0x16, 0x00 },
> +	{ 0x17, 0x00 },
> +	{ 0x18, 0x00 },
> +	{ 0x19, 0x00 },
> +	{ 0x1a, 0x00 },
> +	{ 0x1b, 0x00 },
> +	{ 0x1c, 0x00 },
> +	{ 0x1d, 0x00 },
> +	{ 0x1e, 0x00 },
> +	{ 0x1f, 0x00 },
> +	{ 0x20, 0x00 },
> +	{ 0x21, 0x00 },
> +	{ 0x22, 0x00 },
> +	{ 0x23, 0x00 },
> +	{ 0x24, 0x00 },
> +	{ 0x25, 0x00 },
> +	{ 0x26, 0x00 },
> +	{ 0x27, 0x2d },
> +	{ 0x28, 0xc0 },
> +	{ 0x2b, 0x00 },
> +	{ 0x2c, 0x0c },
>  };
>  
>  /* regulator power supply names */
> @@ -72,6 +111,7 @@ static const char *sta32x_supply_names[] = {
>  
>  /* codec private data */
>  struct sta32x_priv {
> +	struct regmap *regmap;
>  	struct regulator_bulk_data supplies[ARRAY_SIZE(sta32x_supply_names)];
>  	struct snd_soc_codec *codec;
>  	struct sta32x_platform_data *pdata;
> @@ -291,17 +331,15 @@ static int sta32x_sync_coef_shadow(struct snd_soc_codec *codec)
>  
>  static int sta32x_cache_sync(struct snd_soc_codec *codec)
>  {
> +	struct sta32x_priv *sta32x = codec->control_data;
>  	unsigned int mute;
>  	int rc;
>  
> -	if (!codec->cache_sync)
> -		return 0;
> -
>  	/* mute during register sync */
>  	mute = snd_soc_read(codec, STA32X_MMUTE);
>  	snd_soc_write(codec, STA32X_MMUTE, mute | STA32X_MMUTE_MMUTE);
>  	sta32x_sync_coef_shadow(codec);
> -	rc = snd_soc_cache_sync(codec);
> +	rc = regcache_sync(sta32x->regmap);
>  	snd_soc_write(codec, STA32X_MMUTE, mute);
>  	return rc;
>  }
> @@ -316,11 +354,11 @@ static void sta32x_watchdog(struct work_struct *work)
>  
>  	/* check if sta32x has reset itself */
>  	confa_cached = snd_soc_read(codec, STA32X_CONFA);
> -	codec->cache_bypass = 1;
> +	regcache_cache_bypass(sta32x->regmap, true);
>  	confa = snd_soc_read(codec, STA32X_CONFA);
> -	codec->cache_bypass = 0;
> +	regcache_cache_bypass(sta32x->regmap, false);
>  	if (confa != confa_cached) {
> -		codec->cache_sync = 1;
> +		regcache_mark_dirty(sta32x->regmap);
>  		sta32x_cache_sync(codec);
>  	}
>  
> @@ -835,7 +873,8 @@ static int sta32x_probe(struct snd_soc_codec *codec)
>  	/* Tell ASoC what kind of I/O to use to read the registers.  ASoC will
>  	 * then do the I2C transactions itself.
>  	 */
> -	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);
> +	codec->control_data = sta32x->regmap;
> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_REGMAP);
>  	if (ret < 0) {
>  		dev_err(codec->dev, "failed to set cache I/O (ret=%i)\n", ret);
>  		goto err;
> @@ -847,13 +886,15 @@ static int sta32x_probe(struct snd_soc_codec *codec)
>  	 * so the write to the these registers are suppressed by the cache
>  	 * restore code when it skips writes of default registers.
>  	 */
> -	snd_soc_cache_write(codec, STA32X_CONFC, 0xc2);
> -	snd_soc_cache_write(codec, STA32X_CONFE, 0xc2);
> -	snd_soc_cache_write(codec, STA32X_CONFF, 0x5c);
> -	snd_soc_cache_write(codec, STA32X_MMUTE, 0x10);
> -	snd_soc_cache_write(codec, STA32X_AUTO1, 0x60);
> -	snd_soc_cache_write(codec, STA32X_AUTO3, 0x00);
> -	snd_soc_cache_write(codec, STA32X_C3CFG, 0x40);
> +	regcache_cache_only(sta32x->regmap, true);
> +	snd_soc_write(codec, STA32X_CONFC, 0xc2);
> +	snd_soc_write(codec, STA32X_CONFE, 0xc2);
> +	snd_soc_write(codec, STA32X_CONFF, 0x5c);
> +	snd_soc_write(codec, STA32X_MMUTE, 0x10);
> +	snd_soc_write(codec, STA32X_AUTO1, 0x60);
> +	snd_soc_write(codec, STA32X_AUTO3, 0x00);
> +	snd_soc_write(codec, STA32X_C3CFG, 0x40);
> +	regcache_cache_only(sta32x->regmap, false);
>  
>  	/* set thermal warning adjustment and recovery */
>  	if (!(sta32x->pdata->thermal_conf & STA32X_THERMAL_ADJUSTMENT_ENABLE))
> @@ -920,8 +961,7 @@ static int sta32x_remove(struct snd_soc_codec *codec)
>  	return 0;
>  }
>  
> -static int sta32x_reg_is_volatile(struct snd_soc_codec *codec,
> -				  unsigned int reg)
> +static bool sta32x_reg_is_volatile(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
>  	case STA32X_CONFA ... STA32X_L2ATRT:
> @@ -936,10 +976,6 @@ static const struct snd_soc_codec_driver sta32x_codec = {
>  	.remove =		sta32x_remove,
>  	.suspend =		sta32x_suspend,
>  	.resume =		sta32x_resume,
> -	.reg_cache_size =	STA32X_REGISTER_COUNT,
> -	.reg_word_size =	sizeof(u8),
> -	.reg_cache_default =	sta32x_regs,
> -	.volatile_register =	sta32x_reg_is_volatile,
>  	.set_bias_level =	sta32x_set_bias_level,
>  	.controls =		sta32x_snd_controls,
>  	.num_controls =		ARRAY_SIZE(sta32x_snd_controls),
> @@ -949,6 +985,15 @@ static const struct snd_soc_codec_driver sta32x_codec = {
>  	.num_dapm_routes =	ARRAY_SIZE(sta32x_dapm_routes),
>  };
>  
> +static const struct regmap_config sta32x_regmap = {
> +	.reg_bits =		8,
> +	.val_bits =		8,
> +	.max_register =		STA32X_FDRC2,
> +	.reg_defaults =		sta32x_regs,
> +	.num_reg_defaults =	ARRAY_SIZE(sta32x_regs),
> +	.volatile_reg =		sta32x_reg_is_volatile,
> +};
> +
>  static __devinit int sta32x_i2c_probe(struct i2c_client *i2c,
>  				      const struct i2c_device_id *id)
>  {
> @@ -971,6 +1016,13 @@ static __devinit int sta32x_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> +	sta32x->regmap = devm_regmap_init_i2c(i2c, &sta32x_regmap);
> +	if (IS_ERR(sta32x->regmap)) {
> +		ret = PTR_ERR(sta32x->regmap);
> +		dev_err(&i2c->dev, "Failed to init regmap: %d\n", ret);
> +		return ret;
> +	}
> +
>  	i2c_set_clientdata(i2c, sta32x);
>  
>  	ret = snd_soc_register_codec(&i2c->dev, &sta32x_codec, &sta32x_dai, 1);
> -- 
> 1.7.10.4
> 
> 
