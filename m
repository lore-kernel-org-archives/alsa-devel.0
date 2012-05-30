From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] ASoC: Support TI Isabelle Audio
	driver
Date: Wed, 30 May 2012 17:40:09 +0100
Message-ID: <20120530164008.GO9947@opensource.wolfsonmicro.com>
References: <1338289786-2751-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6287252540508757595=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7935710438D
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 18:40:15 +0200 (CEST)
In-Reply-To: <1338289786-2751-1-git-send-email-MR.Swami.Reddy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: alsa-devel@alsa-project.org, vishwas.a.deshpande@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6287252540508757595==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2012 at 04:39:46PM +0530, MR.Swami.Reddy@ti.com wrote:

> he below patch is a basic driver code for TI Isabelle audio codec. The
> functionalities like headset detection, etc., will be included incrementally
> in the up-coming patches.

Overall this is very good, there's a few issues below but they're pretty
minor and ought to be easy to fix.

> Signed-off-by: Vishwas A Deshpande <vishwas.a.deshpande@ti.com>

You should include signoffs from both of you - it's especailly important
that whoever sends the mail signs it off from a legal point of view.

> +/* codec private data */
> +struct isabelle_priv {
> +	struct regmap *regmap;
> +};

If this is all you need then you should be able to use the newly
introduced dev_get_regmap() to get the regmap back (other drivers should
be being updated for this soon).

> +/*
> + * MICGAIN volume control:
> + * from 0 to 30 dB in 1 dB steps
> + */
> +static const DECLARE_TLV_DB_SCALE(mic_amp_tlv, 0, 100, 0);

These comments are a bit on the verbose side...

> +       case SND_SOC_BIAS_STANDBY:
> +               if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
> +                       regcache_sync(isabelle->regmap);

Nothing ever marks the cache as dirty so this'll never actually do
anything.

> +static int isabelle_resume(struct snd_soc_codec *codec)
> +{
> +	isabelle_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	isabelle_set_bias_level(codec, codec->dapm.suspend_bias_level);

As with your previous driver there's no need to use suspend_bias_level
the framework will ensure that you're in your idle state before it
suspends.  Indeed, since your driver sets idle_bias_off there's no need
for these suspend and resume functions at all except possibly to
invalidate the cache in the suspend.

> +static int isabelle_remove(struct snd_soc_codec *codec)
> +{
> +	isabelle_set_bias_level(codec, SND_SOC_BIAS_OFF);
> +	return 0;
> +}

No need for this, your driver sets idle_bias_off so it'll be powered
down before the driver is removed.

> +	isabelle->regmap = regmap_init_i2c(i2c, &isabelle_regmap_config);
> +	if (IS_ERR(isabelle->regmap)) {

devm_regmap_init_i2c().

> +static const struct i2c_device_id isabelle_i2c_id[] = {
> +	{ "isabelle", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, isabelle_i2c_id);

This should really include a list of part numbers - the general
expecation people have is that they can just register the part number.

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxk1iAAoJEBus8iNuMP3dabYP/1OsGJJ9m/ztM/1KNb/PN1Z1
XrRLjV620AeHjARaxBd8SQzN921UhN+pTn0qhEPEQKQgZSiNs2fv4wFZ+MsqZhod
7eBQ5yLMGZmfmV9FU2lL31eoJgafHhrA28sao97UtVIrHWtApjeWL3XbVtbydXk/
r3j0rJSPo5D8AvjpV2Es/CZRK29ac0okkhxQqi3NZbfxLmN7nyJNcmIjndgEk2gf
IjkO1lb2/Y91AJib1VZPrAzjucxMTbzKAvSA3xjqc4ltEEChVx5/wpVIUzcXuyZK
wOo6+iHZP5AJ9HiDrs1Hn+dHvaA8Be22qniwhTKahByGENiYpcEXo3/y6z++tqcB
y0BdFKC8sdJrZorgrkrWVjrPcurQPEWcoKyMCzEqPQHL1m8TyQ0hb4wgVENRUGpR
Q+P/TK0vtai0WD/BLFP6DPaJg04hcVYmEDkUgnl+fM2YDUpfhs6P3ZCzGOzMg+0O
zLIhx4wbk9XP1uISudbK3txQyFxsfDS4SGrh9IQQ5e9Viu2CGbkpnCpk6/3JEgxw
val2izEhF8E3nJMQT0sC2CYua0C148Y41zX+fCLVAuZZmTR5oobZ5jzJwMQH37jV
jziD07LZmLQWYAaGmwwU/yl0cIRUo4XK/qK7XbdXpcbsJXG7ymOJ6AGmFPilo8uP
2g5NSomEZ2+bzHyWNE8L
=LT2L
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--

--===============6287252540508757595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6287252540508757595==--
