From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Mon, 28 Mar 2016 12:13:04 -0700
Message-ID: <20160328191304.GF2350@sirena.org.uk>
References: <1458629605-6225-1-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4173747726217748882=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66F9226055C
 for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2016 09:45:37 +0200 (CEST)
In-Reply-To: <1458629605-6225-1-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4173747726217748882==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l+goss899txtYvYf"
Content-Disposition: inline


--l+goss899txtYvYf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 21, 2016 at 11:53:25PM -0700, anish kumar wrote:

> +static const char *const voltage_level_text[] = {
> +	"9.5dB", "10.5dB", "11.5dB", "11.5dB", "12.5dB",
> +	"13.5dB", "14.5dB", "15.5dB", "16.5dB", "17.5dB",
> +	"18.5dB", "19.5dB", "20.5dB"
> +};

These look like this control is a gain and so I'd expect it to be a
normal TLV control.  What does this control do exactly?

--l+goss899txtYvYf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+YI/AAoJECTWi3JdVIfQx1YH+wbdJSfjS0iBXyIIYT0YeLbP
Rhm7w103wOIxl3MqklbhqMVDeC7ZiUiWy91ByNA2j5xiuy7ABspbY6NlKKtyPAYS
A4sVo/6uMF1VMgcclIK3dnJLMx7gE8DIDCkv1csxsb1u/iSR4lXCdaQTymeZ+PGS
iA3yHPID8ePqU+Q6UCaE6tTsKygqsRpMcrjvrTfVooBuGj3dE9F5XSlHCEORDQI+
EDPmzjh41xOfbGwwmVwnE8iTQjlXbwUhPruJ5DtE+K0iMUy2oQAoUH+konP44YgI
n/p/7pmJtZT+y1JUEyfdigzEVe0glWhWN1IoZSQ9+UNll0IkLco+i+lgVKxx+Zk=
=I0FR
-----END PGP SIGNATURE-----

--l+goss899txtYvYf--

--===============4173747726217748882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4173747726217748882==--
