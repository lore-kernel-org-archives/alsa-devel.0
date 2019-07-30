From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
	diagnostic routine
Date: Tue, 30 Jul 2019 15:19:35 +0100
Message-ID: <20190730141935.GF4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3369682559639835337=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B1BEF80482
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2019 16:19:40 +0200 (CEST)
In-Reply-To: <20190730120937.16271-4-thomas.preston@codethink.co.uk>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Cheng-Yi Chiang <cychiang@chromium.org>, Marco Felsch <m.felsch@pengutronix.de>, Takashi Iwai <tiwai@suse.com>, Annaliese McDermond <nh6z@nh6z.net>, Liam Girdwood <lgirdwood@gmail.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============3369682559639835337==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8JPrznbw0YAQ/KXy"
Content-Disposition: inline


--8JPrznbw0YAQ/KXy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 01:09:37PM +0100, Thomas Preston wrote:

> +	struct dentry *debugfs;
> +	struct mutex diagnostic_mutex;
> +};

It is unclear what this mutex usefully protects, it only gets taken when
writing to the debugfs file to trigger this diagnostic mode but doesn't
do anything to control interactions with any other code path in the
driver.

> +static int run_turn_on_diagnostic(struct tda7802_priv *tda7802, u8 *status)
> +{
> +	struct device *dev = &tda7802->i2c->dev;
> +	int err_status, err;
> +	unsigned int val;
> +	u8 state[NUM_IB];

> +	/* We must wait 20ms for device to settle, otherwise diagnostics will
> +	 * not start and regmap poll will timeout.
> +	 */
> +	msleep(DIAGNOSTIC_SETTLE_MS);

The comment and define might go out of sync...

> +	err = regmap_bulk_read(tda7802->regmap, TDA7802_DB1, status, 4);
> +	if (err < 0) {
> +		dev_err(dev, "Could not read channel status, %d\n", err);
> +		goto diagnostic_restore;
> +	}

...but here we use a magic number for the array size :(

> +static int tda7802_diagnostic_show(struct seq_file *f, void *p)
> +{
> +	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);

We neither use nor free buf?

> +static int tda7802_probe(struct snd_soc_component *component)
> +{
> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
> +	struct device *dev = &tda7802->i2c->dev;
> +	int err;

Why is this done at the component level?

--8JPrznbw0YAQ/KXy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AUfYACgkQJNaLcl1U
h9BW0wf+PaVQnb5XffJ21Ypo9xRgaGWwcL6bpKaVDfNRL94hrZz1wDnFe0ZbKzEY
hIOheUHZJdsf65s/VqhPR6hprJoLCHtcEcnGVcT0ghx2rkyYEM0DrTZIZ/BzzD8I
dCbzuqE3Zh3JjiBrLup0wTyeeEFwP9/z9mmVZCfy5jOcErgm+TObJYq/kPsu1bXv
txX1/W1cPk3+FuPxa2DZC9AFW2Lxv0VnQ0PgBeUwaOI/5ykbFyN51boKVLXFKh6H
FsEA0Y8qQ2OhufKK4pZnqip4RAgzPa+8DkV1cWaABjlgI+ECI0/sEcXD63MOx3cS
oovWVqTESFF8RhUnU/HXI7WswbziRg==
=GUqM
-----END PGP SIGNATURE-----

--8JPrznbw0YAQ/KXy--

--===============3369682559639835337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3369682559639835337==--
