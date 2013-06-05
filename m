From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Make device cache only
 when powered off
Date: Thu, 6 Jun 2013 00:23:30 +0100
Message-ID: <20130605232330.GI31367@sirena.org.uk>
References: <1370251350-4679-1-git-send-email-broonie@linaro.org>
 <CAOMZO5Bwe49qssZ0-kWtETgrFpA-CoCC7qnCodiWhajUq89jcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0573304455380674519=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C6B532654D6
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2013 01:23:36 +0200 (CEST)
In-Reply-To: <CAOMZO5Bwe49qssZ0-kWtETgrFpA-CoCC7qnCodiWhajUq89jcw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0573304455380674519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wLCFyzgXNT+WnbjT"
Content-Disposition: inline


--wLCFyzgXNT+WnbjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2013 at 08:04:10PM -0300, Fabio Estevam wrote:
> On Mon, Jun 3, 2013 at 6:22 AM, Mark Brown <broonie@linaro.org> wrote:

> > When the regulators have been disabled mark the device as cache only so
> > that we don't try to interact with the hardware.

> > Signed-off-by: Mark Brown <broonie@linaro.org>

> I tried to test your patch, but noticed that even without your patch
> sgtl5000 fails to probe in linux-next 20130605.

> It fails when doing a regmap_read of the sgtl5000 ID register.

> I will debug this, but in case you have any ideas about recent regmap
> changes that could lead to this, please let me know.

Isn't that the thing with not powering on the regulators before doing
the ID read?  There was some discussion about that earlier.

--wLCFyzgXNT+WnbjT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRr8hvAAoJELSic+t+oim9VKQP+gPb7RRggn776pUIFffXtxWm
ESdMBtmhuTCofqv0ie2ofCH+AQ0rTmTWtFTqz764YyXpqf0neZc4fsuYz+V2NJt2
X5jSCRkkF73Ir+s0hPlWgTTZX5V6zrP3CXsv6ULLqyq0O12zhYLgNw20Z1aSOsPl
Lz+jjasj5IKuVWT6QLd/fB1Mf2eqLj3CHzmm4kIAfRfeuxsgr2ca1qbQV1bFYYtt
KVUMYecVFcu6hIzJw4hHp4uXhqkHBrxlthJdnjlqs4c0hTCvFcJzwTd9MXFSSZiI
Wpg8FdXQ0pdmwCEgayqpXLAbWdnPKlUUBwlPT/GTUwvioYtwuuVC44PMKowbS4Pj
bAwzcNvo6vLFAxVMIQz5jWGg74CJaA+eaRY5teluBsSowAOeAGt6uvOE8e/DfPaz
WiY+DPV37z03BlXWyEqcT6VUbYlS8uCiLdFUeIcWV1yAtbFzd7eyJkc+dLwnqWNT
5rc+T91lBTbek+wduiRAIVPNajjlISihTSMdrKjgS4Zhti0Zr0gyGdUQshmY9d45
vB+t9XVUSSXEyFSwcUioQHVWnT+VzBfBESDblMaM25hLLVD8gPFWXQFrQJWaKFwf
LVDlak1500IV0yXbrVdmUmBAzAItAfUSsjvBuud640Ccreen5nwUx1Yz5t6pXBgA
TxJxhu339mFgz14xcANd
=apVw
-----END PGP SIGNATURE-----

--wLCFyzgXNT+WnbjT--

--===============0573304455380674519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0573304455380674519==--
