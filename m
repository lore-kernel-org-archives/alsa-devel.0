From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7] ASoC: TSCS42xx: Add support for Tempo
 Semiconductor's TSCS42xx audio CODEC
Date: Fri, 5 Jan 2018 12:22:42 +0000
Message-ID: <20180105122242.GC9076@sirena.org.uk>
References: <20171219205415.wlu4atv2mdy7i3gb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8348737039217910713=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CE22A267A16
 for <alsa-devel@alsa-project.org>; Fri,  5 Jan 2018 13:22:45 +0100 (CET)
In-Reply-To: <20171219205415.wlu4atv2mdy7i3gb@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steven Eckhoff <steven.eckhoff.opensource@gmail.com>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: alsa-devel@alsa-project.org


--===============8348737039217910713==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 19, 2017 at 02:54:25PM -0600, Steven Eckhoff wrote:

> +	SOC_ENUM("MBC Band1 Level Detect Switch",
> +		mbc_level_detection_enums[0]),
> +	SOC_ENUM("MBC Band2 Level Detect Switch",
> +		mbc_level_detection_enums[1]),
> +	SOC_ENUM("MBC Band3 Level Detect Switch",
> +		mbc_level_detection_enums[2]),
> +	SOC_ENUM("MBC Band1 Level Detect Win Switch",
> +		mbc_level_detection_window_enums[0]),
> +	SOC_ENUM("MBC Band2 Level Detect Win Switch",
> +		mbc_level_detection_window_enums[1]),
> +	SOC_ENUM("MBC Band3 Level Detect Win Switch",
> +		mbc_level_detection_window_enums[2]),

These are enums so they should probably not have Switch at the end of
their name, I suspect that might confuse userspace somehow.

> +	SOC_SINGLE("MBC1 Phase Invert", R_DACMBCMUG1, FB_DACMBCMUG1_PHASE,
> +		1, 0),

While this is an on/off switch (for inversion) so it ought to end in
Switch.  Otherwise this driver looks good I think, just those couple of
small things so I'll apply - please send followup patches fixing.

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpPbhEACgkQJNaLcl1U
h9D9jwgAhOKzuJAQ5ktJQ5/D4JlXaJZmTDCjYlveWl9+L5maj4nyJKfZ8Meiuyud
0NPIcOIWHuSjaGkRgp/hbw7gUv+niyoCdJFf/k7w3A5Ep7EXIQck+L2WsrlA4+IR
pPygth2gyL63l38oqcKozPF7e7TDfhlQAFAoxI/kta+jwRaIkYc9n3cGFrAQzPCP
/i5Q8mhYkEVkplrtLMQp3T+hXYIGQ+/QH5rg7W1GZxeXyQFRWGfZgS9wPzGnOLvZ
H8iBijGiejyPzP+DemnHGSZPyPvuEyXWCWGtyYWKW5YELbuEkbs5Lk7sBHEG2X+h
1yN03qbe4b79N5o8n0QCTkeciuPY1Q==
=IshR
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--

--===============8348737039217910713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8348737039217910713==--
