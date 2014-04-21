From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/7] ASoC: Move IO abstraction to the
	component level
Date: Mon, 21 Apr 2014 11:36:36 +0100
Message-ID: <20140421103636.GF12304@sirena.org.uk>
References: <1397897042-20092-1-git-send-email-lars@metafoo.de>
 <1397897042-20092-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1971510462336274675=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 953DE261730
 for <alsa-devel@alsa-project.org>; Mon, 21 Apr 2014 12:37:04 +0200 (CEST)
In-Reply-To: <1397897042-20092-4-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Sven Brandau <brandau@gmx.de>, Liam Girdwood <lgirdwood@gmail.com>, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============1971510462336274675==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BF7UVaXeqbNeiK5v"
Content-Disposition: inline


--BF7UVaXeqbNeiK5v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2014 at 10:43:58AM +0200, Lars-Peter Clausen wrote:

> +	struct regmap *regmap;
> +	int val_bytes;
> +
> +	struct mutex mutex;

Can you please rename this to something like io_mutex?  That's what the
lock is there to protect so it'll make it clearer.  We've always had
problems with the locking rules being a bit indistinct and making new
(or moved) locks clearer should hlep with that.

>  };
> =20
>  /* SoC Audio Codec device */
> @@ -696,18 +702,14 @@ struct snd_soc_codec {
>  	unsigned int ac97_registered:1; /* Codec has been AC97 registered */
>  	unsigned int ac97_created:1; /* Codec has been created by SoC */
>  	unsigned int cache_init:1; /* codec cache has been initialized */
> -	unsigned int using_regmap:1; /* using regmap access */
>  	u32 cache_only;  /* Suppress writes to hardware */
>  	u32 cache_sync; /* Cache needs to be synced to hardware */
> =20
>  	/* codec IO */
>  	void *control_data; /* codec control (i2c/3wire) data */
>  	hw_write_t hw_write;
> -	unsigned int (*read)(struct snd_soc_codec *, unsigned int);
> -	int (*write)(struct snd_soc_codec *, unsigned int, unsigned int);
>  	void *reg_cache;
>  	struct mutex cache_rw_mutex;
> -	int val_bytes;
> =20
>  	/* component */
>  	struct snd_soc_component component;
> @@ -824,7 +826,6 @@ struct snd_soc_platform {
>  	int id;
>  	struct device *dev;
>  	const struct snd_soc_platform_driver *driver;
> -	struct mutex mutex;
> =20
>  	unsigned int suspended:1; /* platform is suspended */
>  	unsigned int probed:1;
> @@ -1129,6 +1130,22 @@ unsigned int snd_soc_read(struct snd_soc_codec *co=
dec, unsigned int reg);
>  int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
>  	unsigned int val);
> =20
> +/* component IO */
> +int snd_soc_component_read(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int *val);
> +int snd_soc_component_write(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int val);
> +int snd_soc_component_update_bits(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int mask, unsigned int val);
> +int snd_soc_component_update_bits_async(struct snd_soc_component *compon=
ent,
> +	unsigned int reg, unsigned int mask, unsigned int val);
> +void snd_soc_component_async_complete(struct snd_soc_component *componen=
t);
> +int snd_soc_component_test_bits(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int mask, unsigned int value);
> +
> +int snd_soc_component_init_io(struct snd_soc_component *component,
> +	struct regmap *regmap);
> +
>  /* device driver data */
> =20
>  static inline void snd_soc_card_set_drvdata(struct snd_soc_card *card,
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index a17c047..fd3c324 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -656,8 +656,8 @@ int snd_soc_suspend(struct device *dev)
>  				codec->driver->suspend(codec);
>  				codec->suspended =3D 1;
>  				codec->cache_sync =3D 1;
> -				if (codec->using_regmap)
> -					regcache_mark_dirty(codec->control_data);
> +				if (codec->component.regmap)
> +					regcache_mark_dirty(codec->component.regmap);
>  				/* deactivate pins to sleep state */
>  				pinctrl_pm_select_sleep_state(codec->dev);
>  				break;
> @@ -3033,7 +3033,7 @@ int snd_soc_bytes_info(struct snd_kcontrol *kcontro=
l,
>  	struct soc_bytes *params =3D (void *)kcontrol->private_value;
> =20
>  	uinfo->type =3D SNDRV_CTL_ELEM_TYPE_BYTES;
> -	uinfo->count =3D params->num_regs * codec->val_bytes;
> +	uinfo->count =3D params->num_regs * codec->component.val_bytes;
> =20
>  	return 0;
>  }
> @@ -3046,16 +3046,16 @@ int snd_soc_bytes_get(struct snd_kcontrol *kcontr=
ol,
>  	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
>  	int ret;
> =20
> -	if (codec->using_regmap)
> -		ret =3D regmap_raw_read(codec->control_data, params->base,
> +	if (codec->component.regmap)
> +		ret =3D regmap_raw_read(codec->component.regmap, params->base,
>  				      ucontrol->value.bytes.data,
> -				      params->num_regs * codec->val_bytes);
> +				      params->num_regs * codec->component.val_bytes);
>  	else
>  		ret =3D -EINVAL;
> =20
>  	/* Hide any masked bytes to ensure consistent data reporting */
>  	if (ret =3D=3D 0 && params->mask) {
> -		switch (codec->val_bytes) {
> +		switch (codec->component.val_bytes) {
>  		case 1:
>  			ucontrol->value.bytes.data[0] &=3D ~params->mask;
>  			break;
> @@ -3085,10 +3085,10 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontr=
ol,
>  	unsigned int val, mask;
>  	void *data;
> =20
> -	if (!codec->using_regmap)
> +	if (!codec->component.regmap)
>  		return -EINVAL;
> =20
> -	len =3D params->num_regs * codec->val_bytes;
> +	len =3D params->num_regs * codec->component.val_bytes;
> =20
>  	data =3D kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);
>  	if (!data)
> @@ -3100,27 +3100,27 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontr=
ol,
>  	 * copy.
>  	 */
>  	if (params->mask) {
> -		ret =3D regmap_read(codec->control_data, params->base, &val);
> +		ret =3D regmap_read(codec->component.regmap, params->base, &val);
>  		if (ret !=3D 0)
>  			goto out;
> =20
>  		val &=3D params->mask;
> =20
> -		switch (codec->val_bytes) {
> +		switch (codec->component.val_bytes) {
>  		case 1:
>  			((u8 *)data)[0] &=3D ~params->mask;
>  			((u8 *)data)[0] |=3D val;
>  			break;
>  		case 2:
>  			mask =3D ~params->mask;
> -			ret =3D regmap_parse_val(codec->control_data,
> +			ret =3D regmap_parse_val(codec->component.regmap,
>  							&mask, &mask);
>  			if (ret !=3D 0)
>  				goto out;
> =20
>  			((u16 *)data)[0] &=3D mask;
> =20
> -			ret =3D regmap_parse_val(codec->control_data,
> +			ret =3D regmap_parse_val(codec->component.regmap,
>  							&val, &val);
>  			if (ret !=3D 0)
>  				goto out;
> @@ -3129,14 +3129,14 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontr=
ol,
>  			break;
>  		case 4:
>  			mask =3D ~params->mask;
> -			ret =3D regmap_parse_val(codec->control_data,
> +			ret =3D regmap_parse_val(codec->component.regmap,
>  							&mask, &mask);
>  			if (ret !=3D 0)
>  				goto out;
> =20
>  			((u32 *)data)[0] &=3D mask;
> =20
> -			ret =3D regmap_parse_val(codec->control_data,
> +			ret =3D regmap_parse_val(codec->component.regmap,
>  							&val, &val);
>  			if (ret !=3D 0)
>  				goto out;
> @@ -3149,7 +3149,7 @@ int snd_soc_bytes_put(struct snd_kcontrol *kcontrol,
>  		}
>  	}
> =20
> -	ret =3D regmap_raw_write(codec->control_data, params->base,
> +	ret =3D regmap_raw_write(codec->component.regmap, params->base,
>  			       data, len);
> =20
>  out:
> @@ -3205,7 +3205,7 @@ int snd_soc_get_xr_sx(struct snd_kcontrol *kcontrol,
>  	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
>  	unsigned int regbase =3D mc->regbase;
>  	unsigned int regcount =3D mc->regcount;
> -	unsigned int regwshift =3D codec->val_bytes * BITS_PER_BYTE;
> +	unsigned int regwshift =3D codec->component.val_bytes * BITS_PER_BYTE;
>  	unsigned int regwmask =3D (1<<regwshift)-1;
>  	unsigned int invert =3D mc->invert;
>  	unsigned long mask =3D (1UL<<mc->nbits)-1;
> @@ -3251,7 +3251,7 @@ int snd_soc_put_xr_sx(struct snd_kcontrol *kcontrol,
>  	struct snd_soc_codec *codec =3D snd_kcontrol_chip(kcontrol);
>  	unsigned int regbase =3D mc->regbase;
>  	unsigned int regcount =3D mc->regcount;
> -	unsigned int regwshift =3D codec->val_bytes * BITS_PER_BYTE;
> +	unsigned int regwshift =3D codec->component.val_bytes * BITS_PER_BYTE;
>  	unsigned int regwmask =3D (1<<regwshift)-1;
>  	unsigned int invert =3D mc->invert;
>  	unsigned long mask =3D (1UL<<mc->nbits)-1;
> @@ -3899,6 +3899,8 @@ __snd_soc_register_component(struct device *dev,
>  		return -ENOMEM;
>  	}
> =20
> +	mutex_init(&cmpnt->mutex);
> +
>  	cmpnt->name =3D fmt_single_name(dev, &cmpnt->id);
>  	if (!cmpnt->name) {
>  		dev_err(dev, "ASoC: Failed to simplifying name\n");
> @@ -3979,6 +3981,24 @@ found:
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_unregister_component);
> =20
> +static int snd_soc_platform_drv_write(struct snd_soc_component *componen=
t,
> +	unsigned int reg, unsigned int val)
> +{
> +	struct snd_soc_platform *platform =3D snd_soc_component_to_platform(com=
ponent);
> +
> +	return platform->driver->write(platform, reg, val);
> +}
> +
> +static int snd_soc_platform_drv_read(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int *val)
> +{
> +	struct snd_soc_platform *platform =3D snd_soc_component_to_platform(com=
ponent);
> +
> +	*val =3D platform->driver->read(platform, reg);
> +
> +	return 0;
> +}
> +
>  /**
>   * snd_soc_add_platform - Add a platform to the ASoC core
>   * @dev: The parent device for the platform
> @@ -3999,8 +4019,12 @@ int snd_soc_add_platform(struct device *dev, struc=
t snd_soc_platform *platform,
>  	platform->driver =3D platform_drv;
>  	platform->dapm.dev =3D dev;
>  	platform->dapm.platform =3D platform;
> +	platform->dapm.component =3D &platform->component;
>  	platform->dapm.stream_event =3D platform_drv->stream_event;
> -	mutex_init(&platform->mutex);
> +	if (platform_drv->write)
> +		platform->component.write =3D snd_soc_platform_drv_write;
> +	if (platform_drv->read)
> +		platform->component.read =3D snd_soc_platform_drv_read;
> =20
>  	/* register component */
>  	ret =3D __snd_soc_register_component(dev, &platform->component,
> @@ -4129,6 +4153,24 @@ static void fixup_codec_formats(struct snd_soc_pcm=
_stream *stream)
>  			stream->formats |=3D codec_format_map[i];
>  }
> =20
> +static int snd_soc_codec_drv_write(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int val)
> +{
> +	struct snd_soc_codec *codec =3D snd_soc_component_to_codec(component);
> +
> +	return codec->driver->write(codec, reg, val);
> +}
> +
> +static int snd_soc_codec_drv_read(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int *val)
> +{
> +	struct snd_soc_codec *codec =3D snd_soc_component_to_codec(component);
> +
> +	*val =3D codec->driver->read(codec, reg);
> +
> +	return 0;
> +}
> +
>  /**
>   * snd_soc_register_codec - Register a codec with the ASoC core
>   *
> @@ -4156,29 +4198,32 @@ int snd_soc_register_codec(struct device *dev,
>  		goto fail_codec;
>  	}
> =20
> -	codec->write =3D codec_drv->write;
> -	codec->read =3D codec_drv->read;
> +	if (codec_drv->write)
> +		codec->component.write =3D snd_soc_codec_drv_write;
> +	if (codec_drv->read)
> +		codec->component.read =3D snd_soc_codec_drv_read;
>  	codec->component.ignore_pmdown_time =3D codec_drv->ignore_pmdown_time;
>  	codec->dapm.bias_level =3D SND_SOC_BIAS_OFF;
>  	codec->dapm.dev =3D dev;
>  	codec->dapm.codec =3D codec;
> +	codec->dapm.component =3D &codec->component;
>  	codec->dapm.seq_notifier =3D codec_drv->seq_notifier;
>  	codec->dapm.stream_event =3D codec_drv->stream_event;
>  	codec->dev =3D dev;
>  	codec->driver =3D codec_drv;
>  	codec->num_dai =3D num_dai;
> -	codec->val_bytes =3D codec_drv->reg_word_size;
> +	codec->component.val_bytes =3D codec_drv->reg_word_size;
>  	mutex_init(&codec->mutex);
> =20
> -	if (!codec->write) {
> +	if (!codec->component.write) {
>  		if (codec_drv->get_regmap)
>  			regmap =3D codec_drv->get_regmap(dev);
>  		else
>  			regmap =3D dev_get_regmap(dev, NULL);
> =20
>  		if (regmap) {
> -			ret =3D snd_soc_codec_set_cache_io(codec, regmap);
> -			if (ret && ret !=3D -ENOTSUPP) {
> +			ret =3D snd_soc_component_init_io(&codec->component, regmap);
> +			if (ret) {
>  				dev_err(codec->dev,
>  						"Failed to set cache I/O:%d\n",
>  						ret);
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index cdd5115..85a594f 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -378,86 +378,24 @@ static void dapm_reset(struct snd_soc_card *card)
>  static int soc_widget_read(struct snd_soc_dapm_widget *w, int reg,
>  	unsigned int *value)
>  {
> -	if (w->codec) {
> -		*value =3D snd_soc_read(w->codec, reg);
> -		return 0;
> -	} else if (w->platform) {
> -		*value =3D snd_soc_platform_read(w->platform, reg);
> -		return 0;
> -	}
> -
> -	dev_err(w->dapm->dev, "ASoC: no valid widget read method\n");
> -	return -1;
> -}
> -
> -static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg,
> -	unsigned int val)
> -{
> -	if (w->codec)
> -		return snd_soc_write(w->codec, reg, val);
> -	else if (w->platform)
> -		return snd_soc_platform_write(w->platform, reg, val);
> -
> -	dev_err(w->dapm->dev, "ASoC: no valid widget write method\n");
> -	return -1;
> -}
> -
> -static inline void soc_widget_lock(struct snd_soc_dapm_widget *w)
> -{
> -	if (w->codec && !w->codec->using_regmap)
> -		mutex_lock(&w->codec->mutex);
> -	else if (w->platform)
> -		mutex_lock(&w->platform->mutex);
> +	if (!w->dapm->component)
> +		return -EIO;
> +	return snd_soc_component_read(w->dapm->component, reg, value);
>  }
> =20
> -static inline void soc_widget_unlock(struct snd_soc_dapm_widget *w)
> +static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
> +	int reg, unsigned int mask, unsigned int value)
>  {
> -	if (w->codec && !w->codec->using_regmap)
> -		mutex_unlock(&w->codec->mutex);
> -	else if (w->platform)
> -		mutex_unlock(&w->platform->mutex);
> +	if (!w->dapm->component)
> +		return -EIO;
> +	return snd_soc_component_update_bits_async(w->dapm->component, reg,
> +		mask, value);
>  }
> =20
>  static void soc_dapm_async_complete(struct snd_soc_dapm_context *dapm)
>  {
> -	if (dapm->codec && dapm->codec->using_regmap)
> -		regmap_async_complete(dapm->codec->control_data);
> -}
> -
> -static int soc_widget_update_bits_locked(struct snd_soc_dapm_widget *w,
> -	int reg, unsigned int mask, unsigned int value)
> -{
> -	bool change;
> -	unsigned int old, new;
> -	int ret;
> -
> -	if (w->codec && w->codec->using_regmap) {
> -		ret =3D regmap_update_bits_check_async(w->codec->control_data,
> -						     reg, mask, value,
> -						     &change);
> -		if (ret !=3D 0)
> -			return ret;
> -	} else {
> -		soc_widget_lock(w);
> -		ret =3D soc_widget_read(w, reg, &old);
> -		if (ret < 0) {
> -			soc_widget_unlock(w);
> -			return ret;
> -		}
> -
> -		new =3D (old & ~mask) | (value & mask);
> -		change =3D old !=3D new;
> -		if (change) {
> -			ret =3D soc_widget_write(w, reg, new);
> -			if (ret < 0) {
> -				soc_widget_unlock(w);
> -				return ret;
> -			}
> -		}
> -		soc_widget_unlock(w);
> -	}
> -
> -	return change;
> +	if (dapm->component)
> +		snd_soc_component_async_complete(dapm->component);
>  }
> =20
>  /**
> diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
> index dc0c09d..0fdb924 100644
> --- a/sound/soc/soc-io.c
> +++ b/sound/soc/soc-io.c
> @@ -19,24 +19,205 @@
> =20
>  #include <trace/events/asoc.h>
> =20
> -unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
> +/**
> + * snd_soc_component_read() - Read register value
> + * @component: Component to read from
> + * @reg: Register to read
> + * @val: Pointer to where the read value is stored
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +int snd_soc_component_read(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int *val)
> +{
> +	int ret;
> +
> +	if (component->regmap)
> +		ret =3D regmap_read(component->regmap, reg, val);
> +	else if (component->read)
> +		ret =3D component->read(component, reg, val);
> +	else
> +		ret =3D -EIO;
> +
> +	dev_dbg(component->dev, "read %x =3D> %x\n", reg, *val);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_component_read);
> +
> +/**
> + * snd_soc_component_write() - Write register value
> + * @component: Component to write to
> + * @reg: Register to write
> + * @val: Value to write to the register
> + *
> + * Return: 0 on success, a negative error code otherwise.
> + */
> +int snd_soc_component_write(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int val)
>  {
> -	unsigned int ret;
> +	dev_dbg(component->dev, "write %x =3D %x\n", reg, val);
> =20
> -	ret =3D codec->read(codec, reg);
> -	dev_dbg(codec->dev, "read %x =3D> %x\n", reg, ret);
> -	trace_snd_soc_reg_read(codec, reg, ret);
> +	if (component->regmap)
> +		return regmap_write(component->regmap, reg, val);
> +	else if (component->write)
> +		return component->write(component, reg, val);
> +	else
> +		return -EIO;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_component_write);
> +
> +static int snd_soc_component_update_bits_legacy(
> +	struct snd_soc_component *component, unsigned int reg,
> +	unsigned int mask, unsigned int val, bool *change)
> +{
> +	unsigned int old, new;
> +	int ret;
> +
> +	if (!component->read || !component->write)
> +		return -EIO;
> +
> +	mutex_lock(&component->mutex);
> +
> +	ret =3D component->read(component, reg, &old);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	new =3D (old & ~mask) | (val & mask);
> +	*change =3D old !=3D new;
> +	if (*change)
> +		ret =3D component->write(component, reg, new);
> +out_unlock:
> +	mutex_unlock(&component->mutex);
> =20
>  	return ret;
>  }
> +
> +/**
> + * snd_soc_component_update_bits() - Perform read/modify/write cycle
> + * @component: Component to update
> + * @reg: Register to update
> + * @mask: Mask that specifies which bits to update
> + * @val: New value for the bits specified by mask
> + *
> + * Return: 1 if the operation was successful and the value of the regist=
er
> + * changed, 0 if the operation was successful, but the value did not cha=
nge.
> + * Returns a negative error code otherwise.
> + */
> +int snd_soc_component_update_bits(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int mask, unsigned int val)
> +{
> +	bool change;
> +	int ret;
> +
> +	if (component->regmap)
> +		ret =3D regmap_update_bits_check(component->regmap, reg, mask,
> +			val, &change);
> +	else
> +		ret =3D snd_soc_component_update_bits_legacy(component, reg,
> +			mask, val, &change);
> +
> +	if (ret < 0)
> +		return ret;
> +	return change;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_component_update_bits);
> +
> +/**
> + * snd_soc_component_update_bits_async() - Perform asynchronous
> + *  read/modify/write cycle
> + * @component: Component to update
> + * @reg: Register to update
> + * @mask: Mask that specifies which bits to update
> + * @val: New value for the bits specified by mask
> + *
> + * This function is similar to snd_soc_component_update_bits(), but the =
update
> + * operation is scheduled asynchronously. This means it may not be compl=
eted
> + * when the function returns. To make sure that all scheduled updates ha=
ve been
> + * completed snd_soc_component_async_complete() must be called.
> + *
> + * Return: 1 if the operation was successful and the value of the regist=
er
> + * changed, 0 if the operation was successful, but the value did not cha=
nge.
> + * Returns a negative error code otherwise.
> + */
> +int snd_soc_component_update_bits_async(struct snd_soc_component *compon=
ent,
> +	unsigned int reg, unsigned int mask, unsigned int val)
> +{
> +	bool change;
> +	int ret;
> +
> +	if (component->regmap)
> +		ret =3D regmap_update_bits_check_async(component->regmap, reg,
> +			mask, val, &change);
> +	else
> +		ret =3D snd_soc_component_update_bits_legacy(component, reg,
> +			mask, val, &change);
> +
> +	if (ret < 0)
> +		return ret;
> +	return change;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_component_update_bits_async);
> +
> +/**
> + * snd_soc_component_async_complete() - Ensure asynchronous I/O has comp=
leted
> + * @component: Component for which to wait
> + *
> + * This function blocks until all asynchronous I/O which has previously =
been
> + * scheduled using snd_soc_component_update_bits_async() has completed.
> + */
> +void snd_soc_component_async_complete(struct snd_soc_component *componen=
t)
> +{
> +	if (component->regmap)
> +		regmap_async_complete(component->regmap);
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_component_async_complete);
> +
> +/**
> + * snd_soc_component_test_bits - Test register for change
> + * @component: component
> + * @reg: Register to test
> + * @mask: Mask that specifies which bits to test
> + * @value: Value to test against
> + *
> + * Tests a register with a new value and checks if the new value is
> + * different from the old value.
> + *
> + * Return: 1 for change, otherwise 0.
> + */
> +int snd_soc_component_test_bits(struct snd_soc_component *component,
> +	unsigned int reg, unsigned int mask, unsigned int value)
> +{
> +	unsigned int old, new;
> +	int ret;
> +
> +	ret =3D snd_soc_component_read(component, reg, &old);
> +	if (ret < 0)
> +		return ret;
> +	new =3D (old & ~mask) | value;
> +	return old !=3D new;
> +}
> +EXPORT_SYMBOL_GPL(snd_soc_component_test_bits);
> +
> +unsigned int snd_soc_read(struct snd_soc_codec *codec, unsigned int reg)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D snd_soc_component_read(&codec->component, reg, &val);
> +	if (ret < 0)
> +		return -1;
> +	trace_snd_soc_reg_read(codec, reg, val);
> +
> +	return val;
> +}
>  EXPORT_SYMBOL_GPL(snd_soc_read);
> =20
>  int snd_soc_write(struct snd_soc_codec *codec, unsigned int reg,
>  	unsigned int val)
>  {
> -	dev_dbg(codec->dev, "write %x =3D %x\n", reg, val);
>  	trace_snd_soc_reg_write(codec, reg, val);
> -	return codec->write(codec, reg, val);
> +	return snd_soc_component_write(&codec->component, reg, val);
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_write);
> =20
> @@ -54,29 +235,8 @@ EXPORT_SYMBOL_GPL(snd_soc_write);
>  int snd_soc_update_bits(struct snd_soc_codec *codec, unsigned int reg,
>  				unsigned int mask, unsigned int value)
>  {
> -	bool change;
> -	unsigned int old, new;
> -	int ret;
> -
> -	if (codec->using_regmap) {
> -		ret =3D regmap_update_bits_check(codec->control_data, reg,
> -					       mask, value, &change);
> -	} else {
> -		ret =3D snd_soc_read(codec, reg);
> -		if (ret < 0)
> -			return ret;
> -
> -		old =3D ret;
> -		new =3D (old & ~mask) | (value & mask);
> -		change =3D old !=3D new;
> -		if (change)
> -			ret =3D snd_soc_write(codec, reg, new);
> -	}
> -
> -	if (ret < 0)
> -		return ret;
> -
> -	return change;
> +	return snd_soc_component_update_bits(&codec->component, reg, mask,
> +		value);
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_update_bits);
> =20
> @@ -95,13 +255,8 @@ int snd_soc_update_bits_locked(struct snd_soc_codec *=
codec,
>  			       unsigned int reg, unsigned int mask,
>  			       unsigned int value)
>  {
> -	int change;
> -
> -	mutex_lock(&codec->mutex);
> -	change =3D snd_soc_update_bits(codec, reg, mask, value);
> -	mutex_unlock(&codec->mutex);
> -
> -	return change;
> +	return snd_soc_component_update_bits(&codec->component, reg, mask,
> +		value);
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_update_bits_locked);
> =20
> @@ -120,115 +275,58 @@ EXPORT_SYMBOL_GPL(snd_soc_update_bits_locked);
>  int snd_soc_test_bits(struct snd_soc_codec *codec, unsigned int reg,
>  				unsigned int mask, unsigned int value)
>  {
> -	int change;
> -	unsigned int old, new;
> -
> -	old =3D snd_soc_read(codec, reg);
> -	new =3D (old & ~mask) | value;
> -	change =3D old !=3D new;
> -
> -	return change;
> +	return snd_soc_component_test_bits(&codec->component, reg, mask, value);
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_test_bits);
> =20
>  int snd_soc_platform_read(struct snd_soc_platform *platform,
>  					unsigned int reg)
>  {
> -	unsigned int ret;
> +	unsigned int val;
> +	int ret;
> =20
> -	if (!platform->driver->read) {
> -		dev_err(platform->dev, "ASoC: platform has no read back\n");
> +	ret =3D snd_soc_component_read(&platform->component, reg, &val);
> +	if (ret < 0)
>  		return -1;
> -	}
> =20
> -	ret =3D platform->driver->read(platform, reg);
> -	dev_dbg(platform->dev, "read %x =3D> %x\n", reg, ret);
> -	trace_snd_soc_preg_read(platform, reg, ret);
> +	trace_snd_soc_preg_read(platform, reg, val);
> =20
> -	return ret;
> +	return val;
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_platform_read);
> =20
>  int snd_soc_platform_write(struct snd_soc_platform *platform,
>  					 unsigned int reg, unsigned int val)
>  {
> -	if (!platform->driver->write) {
> -		dev_err(platform->dev, "ASoC: platform has no write back\n");
> -		return -1;
> -	}
> -
> -	dev_dbg(platform->dev, "write %x =3D %x\n", reg, val);
>  	trace_snd_soc_preg_write(platform, reg, val);
> -	return platform->driver->write(platform, reg, val);
> +	return snd_soc_component_write(&platform->component, reg, val);
>  }
>  EXPORT_SYMBOL_GPL(snd_soc_platform_write);
> =20
> -#ifdef CONFIG_REGMAP
> -static int hw_write(struct snd_soc_codec *codec, unsigned int reg,
> -		    unsigned int value)
> -{
> -	return regmap_write(codec->control_data, reg, value);
> -}
> -
> -static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int re=
g)
> -{
> -	int ret;
> -	unsigned int val;
> -
> -	ret =3D regmap_read(codec->control_data, reg, &val);
> -	if (ret =3D=3D 0)
> -		return val;
> -	else
> -		return -1;
> -}
> -
>  /**
> - * snd_soc_codec_set_cache_io: Set up standard I/O functions.
> - *
> - * @codec: CODEC to configure.
> - * @map: Register map to write to
> + * snd_soc_component_init_io() - Initialize regmap IO
>   *
> - * Register formats are frequently shared between many I2C and SPI
> - * devices.  In order to promote code reuse the ASoC core provides
> - * some standard implementations of CODEC read and write operations
> - * which can be set up using this function.
> + * @component: component to initialize
> + * @regmap: regmap instance to use for IO operations
>   *
> - * The caller is responsible for allocating and initialising the
> - * actual cache.
> - *
> - * Note that at present this code cannot be used by CODECs with
> - * volatile registers.
> + * Return: 0 on success, a negative error code otherwise
>   */
> -int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
> -			       struct regmap *regmap)
> +int snd_soc_component_init_io(struct snd_soc_component *component,
> +	struct regmap *regmap)
>  {
>  	int ret;
> =20
>  	if (!regmap)
>  		return -EINVAL;
> =20
> -	/* Device has made its own regmap arrangements */
> -	codec->control_data =3D regmap;
> -
> -	codec->write =3D hw_write;
> -	codec->read =3D hw_read;
> -
> -	ret =3D regmap_get_val_bytes(codec->control_data);
> +	ret =3D regmap_get_val_bytes(regmap);
>  	/* Errors are legitimate for non-integer byte
>  	 * multiples */
>  	if (ret > 0)
> -		codec->val_bytes =3D ret;
> +		component->val_bytes =3D ret;
> =20
> -	codec->using_regmap =3D true;
> +	component->regmap =3D regmap;
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
> -#else
> -int snd_soc_codec_set_cache_io(struct snd_soc_codec *codec,
> -			       struct regmap *regmap)
> -{
> -	return -ENOTSUPP;
> -}
> -EXPORT_SYMBOL_GPL(snd_soc_codec_set_cache_io);
> -#endif
> +EXPORT_SYMBOL_GPL(snd_soc_component_init_io);
> --=20
> 1.8.0
>=20
>=20

--BF7UVaXeqbNeiK5v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVPSxAAoJELSic+t+oim9nU0QAI37a/Qtkkav/2t/gjRj6ZP/
pIT+sT8bz0N2odwdIwiIWO2VcaSTmA+VDxt79VtNOvkz9ezElZtxClZ7UpEt90M0
e2uLUSPiEcUuP/LH5XJYPnNxrhBwKqeMg8fAgD1TJG4nlMDo8M8iqmLDeEWVQU90
tCg4lZuDpXsFik4hMfK9lEw7m+whe6PyHoqP4YoTCA5aZOQkeO/h89yaqS3vCwRf
MCrQkjPb+ijCqAc4yDfZM6IqQhiZWpZigdH7IiXzCRlewBLIo02Cnmsq7z4lXa+B
P288LP7ovpPAQJU1WWn4cxjhR1IksJY5V2EBBQs5ygWytKQ3xCxM79p91QbH6STC
+NxSpTQWqI/wVGvoIPYZGXqQKd2FtRFsNvZkQLImKCyE2L6qDS2oHOspNVe5Fp6D
+8t4l9LnSr+k4GZoAyn8i8607LutslUM5OQDMavZObjPuNOmBYOrEMFf5l1UgPme
4+ENpj8lUdEVIpyWRPcv+WD2iiRYbM46QX88LoZC29n3oOnji7z3FvnuKwWGcpRM
D55gb+ILMmB6bt1gjlF+he8cuVFumF5uVq9aEEs4mKIn0kuZFJshKrvqsdSV8INb
7PvtzeTTcAiHczhjYvRgzmStZNCiMgq+3N/MYOGiuXA9qciImh0LRchKQMKlRPIe
yGAG/9HTL1He39E+Z600
=JP+G
-----END PGP SIGNATURE-----

--BF7UVaXeqbNeiK5v--

--===============1971510462336274675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1971510462336274675==--
