From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5663: Fix error handling of
 device_property_read_u32_array
Date: Mon, 7 Jan 2019 16:04:59 +0000
Message-ID: <20190107160459.GI9570@sirena.org.uk>
References: <20190105134427.1022-1-pakki001@umn.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6320232183216622970=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 72ABC2665E5
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 17:05:10 +0100 (CET)
In-Reply-To: <20190105134427.1022-1-pakki001@umn.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aditya Pakki <pakki001@umn.edu>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kjlu@umn.edu, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6320232183216622970==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+ZmrHH5cGjskQnY1"
Content-Disposition: inline


--+ZmrHH5cGjskQnY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 05, 2019 at 07:44:27AM -0600, Aditya Pakki wrote:

>  		rt5663->imp_table = devm_kzalloc(dev, table_size, GFP_KERNEL);
> -		device_property_read_u32_array(dev,
> +		return device_property_read_u32_array(dev,
>  			"realtek,impedance_sensing_table",
>  			(u32 *)rt5663->imp_table, table_size);

This is going to silently fail without giving any indication of what's
wrong which isn't great - it's not clear that completely failing to load
the driver is the best option here, and even if it is we should probably
tell the user what went wrong.

We're also not checking the result of the memory allocation...

--+ZmrHH5cGjskQnY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwzeKoACgkQJNaLcl1U
h9BOCwf9FphVz+v+WezrJsnnKtKAX73L3q+F+LoFQ0sxXwzvHm15Q7+tUGL/75dL
NCYxGPw4LoGf/kZWUhhIX9dII37aIjsez8ss8KiLu6LP/+28oJDwqX7yT/SoIay0
ocmTlngVqm5ceU1j4lJl/8Irr7zCOJfZ63ZrfEUQ+FfX6Uoy1tdiIkHt+Cx2jsbm
erayQMF4JnKC3htgSP7eN80YuLKi6n2FXPQlETfNcQVgbpLXaOI7gFE+cGkvk6xv
+5fn5EuQJ/hmUP2NIkHEtJULV315KSc7Pg06UVNJ0DsEu0Zn6v9J4AwlXSIsT9Os
LZOkQe3w6jfF5yeejCKGFPzBIMLzlA==
=Do7P
-----END PGP SIGNATURE-----

--+ZmrHH5cGjskQnY1--

--===============6320232183216622970==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6320232183216622970==--
