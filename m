From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs-saif: Do not store the irq
 number in the private structure
Date: Tue, 30 Dec 2014 16:45:00 +0000
Message-ID: <20141230164500.GI17800@sirena.org.uk>
References: <1419948696-18529-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8077952841176350095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E2BF26067B
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 17:45:14 +0100 (CET)
In-Reply-To: <1419948696-18529-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8077952841176350095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WhCAuH6pPk3oymB"
Content-Disposition: inline


--/WhCAuH6pPk3oymB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2014 at 12:11:36PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> The irq number is only used inside the probe function, so there is really=
 no
> need to store it in the private structure.

Applied, thanks.

--/WhCAuH6pPk3oymB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUotaLAAoJECTWi3JdVIfQjukH/R+gKpL3leLOpxROOYFhbcST
Qo/6AVvB5niWdx938O73/HU8nnQJGEHroZze+rSec07Da/C8TYu683uZ8wFz+LEz
HqLQS13WQYidfpfFYtJF72X8w3dnOpWEM8UWpJTgGn2/bAncMiE7JhwXaZPXXiR1
ZUCVZI2gBmUTg1l4eWFBLpRQxVoCw9vpUpHEIrQ1ahAOJl4qumckh6CE02jCFID7
MP9hfG++OFUiz81kbHjVsTm93CAfp0JTu2IsU9S69C7IWlsFPumSs5E8TIjOZvta
NxQP/hEHi+OJVYIFjuy6QpkYjRSHrgqlE8g9fL+AJztpHBQE5OoOT45+TssPsG8=
=kYaY
-----END PGP SIGNATURE-----

--/WhCAuH6pPk3oymB--

--===============8077952841176350095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8077952841176350095==--
