From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] ASoC: mediatek: add btcvsd driver
Date: Thu, 24 Jan 2019 19:25:02 +0000
Message-ID: <20190124192502.GJ5641@sirena.org.uk>
References: <20190124085842.24073-1-kaichieh.chuang@mediatek.com>
 <20190124085842.24073-2-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7325617852971574957=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E9A02674A9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 20:25:05 +0100 (CET)
In-Reply-To: <20190124085842.24073-2-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============7325617852971574957==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bpVaumkpfGNUagdU"
Content-Disposition: inline


--bpVaumkpfGNUagdU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2019 at 04:58:41PM +0800, KaiChieh Chuang wrote:

> The driver function for transferring/receiving
> BT encoded data to/from BT hardware.

It's really nice to see someone submitting a driver for actual radio
hardware, this is great to see! =20

The driver looks pretty good, I've got a few quite minor comments below
but the main one is that given that this doesn't have any DAIs or DAPM
it looks like it doesn't integrate with the rest of the sound card much
so perhaps it could just be a free standing ALSA driver?  If there's
inputs that let you link it to the rest of the sound card which will be
added later then that's obviously a good reason to keep it in ASoC (I'd
not be surprised if there were) but otherwise I'm not sure what
advantage ASoC brings you.

> +static void mtk_btcvsd_snd_set_state(struct mtk_btcvsd_snd *bt,
> +				     struct mtk_btcvsd_snd_stream *bt_stream,
> +				     int state)
> +{
> +	dev_info(bt->dev, "%s(), stream %d, state %d, tx->state %d, rx->state %=
d, irq_disabled %d\n",
> +		 __func__,
> +		 bt_stream->stream, state,
> +		 bt->tx->state, bt->rx->state, bt->irq_disabled);

There's quite a few of these dev_info() calls which look like they might
be a bit noisy and could perhaps be dev_dbg() instead.

> +/* kcontrol */
> +static const char *const btsco_band_str[] =3D {"NB", "WB"};
> +static const char *const btsco_mute_str[] =3D {"Off", "On"};
> +static const char *const irq_received_str[] =3D {"No", "Yes"};
> +static const char *const rx_timeout_str[] =3D {"No", "Yes"};
> +
> +static const struct soc_enum btcvsd_enum[] =3D {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(btsco_band_str), btsco_band_str),
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(btsco_mute_str), btsco_mute_str),
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(irq_received_str), irq_received_str),
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(rx_timeout_str), rx_timeout_str),
> +};

Some of these enums (all of them except the narrow/wide band one) should
be simple number controls ending with Switch as covered in
control-names.rst, this helps UIs display them better.

> +	SND_SOC_BYTES_TLV("btcvsd_tx_timestamp",
> +			  sizeof(struct mtk_btcvsd_snd_time_buffer_info),
> +			  btcvsd_tx_timestamp_get, NULL),

There's an ALSA timestamping API - see commit 4eeaaeaea1ce (ALSA: core:
add hooks for audio timestamps) and related commits.  I don't know if
that applies here and might be a better fit or not?

--bpVaumkpfGNUagdU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxKEQ0ACgkQJNaLcl1U
h9D4bwf+PBlVu5Tsuq97XJVpADkvOOzmn6FrQUXEX+hUrYunBwHN2e+JdqkVb0WI
lxm7SVjgWdxVC+nC4RlT9pkeLm8wWEXv7GOwePJSNvkQUxZEeKqiwWNHb+obNNU7
ZCs+iW8wqE+F/N7bElqpJM2t1ym48879bdUXmU7VVOhnY99wGRpyT7p7HUmdnunx
pN5ocumMtgISL85rRrOf2B9S59qJQi40YivBkeFFso3aCO9AJEglsUXtfVX9Otm6
MIKv4c5Mfo07Qb1uUAjpr9E1brNfRbxo+jmlrwJqpyubFrf5ciA7zh7/LjxrOKdi
IRzQuTnqcb/OFLz9tB9b67P8Vo+DTQ==
=uH9J
-----END PGP SIGNATURE-----

--bpVaumkpfGNUagdU--

--===============7325617852971574957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7325617852971574957==--
