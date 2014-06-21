From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 09/11] ASoC: Add component level
 set_bias_level() support
Date: Sat, 21 Jun 2014 21:38:02 +0100
Message-ID: <20140621203802.GG22657@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687969321216855352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BA12B265361
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:38:36 +0200 (CEST)
In-Reply-To: <1402935191-18398-10-git-send-email-lars@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0687969321216855352==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:09PM +0200, Lars-Peter Clausen wrote:
> This patch adds a set_bias_level() callback to the snd_soc_component_driver
> struct similar to that found in the snd_soc_codec_driver struct. This will allow
> any component type and not just CODECs to implement such a callback.

So, as I said on the previous patch I'm not 100% sure about this one.
On balance I think the symmetry argument wins out so it should go in
even if people ought not to be using it but I want to think it over a
little more.

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpe0nAAoJELSic+t+oim9nG0P/0lfJknvja3qM5zTpqnP/gaW
2zN1WnM+ptrJPhccyawF2p4LPdLtITMEKE/2CtD0cVdYSZJPKjUwIqYVUMhtfwye
vwxqLrHPX6+uAwUSwEkddrzAmQI6AswyxXKpzi20vGB0pk/HZxHlmsvzXs+2zGNb
QKsXB9HKGsJ9EsNuX3PWbv1PFC8dAn6mpihMC8M2z6YJxfqvQHG1e7V2V1Ivba5i
HDo9rVIiaM5r6jLtNLL9FhJspQdHnFVy+GSP4BlhB0wpFwPlAmltCb5bdlAKOOzQ
Iy0wW1cguBl25MtOeeRYdhbRSjMhyJmZyXzk6V2JQPoFSeRMmePs09mtpvyEOI3N
mq2eAbBPXj8MIQMsx4csPbVBFL0GtbCftTqMSmEztjr/Up+HmH51B7pTvpUi2a7t
hLgrtO6uIIOXEoRn+1I2EaC+U/8q0eglMrCuy04bTzn2rQPmC3NWaeM84yz3+NMh
ZuMbDcfICwTXhXGC1z5KwWQaNpT0g0rMIn29GKa3lvyanpKAC6I6EqrV9QRR0NC6
ztYd6/uOFKLlb9vTXQ+7UBibsHAKv6s6CuNF/+gwwaVfJZV7XMp5Q9jhGUf8T8dq
md/mifSH5G6vbtl4POzQe3ieN4sEbcPno5YKG1OwflITUEb4Ft07zp/nLKG3pjbi
zXEA14KmN5w/DeMUbWIN
=o6Dw
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--

--===============0687969321216855352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0687969321216855352==--
