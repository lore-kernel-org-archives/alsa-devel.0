From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: simple-card: Add a NULL pointer
 check in asoc_simple_card_dai_link_of
Date: Tue, 3 Mar 2015 14:25:24 +0000
Message-ID: <20150303142524.GV21293@sirena.org.uk>
References: <20150303132900.GA22246@vishal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4523137036881647893=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 56962261543
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2015 15:45:22 +0100 (CET)
In-Reply-To: <20150303132900.GA22246@vishal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vishal Thanki <vishalthanki@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4523137036881647893==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pqrHuw837mIruWQK"
Content-Disposition: inline


--pqrHuw837mIruWQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2015 at 06:59:00PM +0530, Vishal Thanki wrote:
> Make sure devm_kzalloc() succeeds.

Applied, thanks.

--pqrHuw837mIruWQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9cRUAAoJECTWi3JdVIfQ8DgIAINIxTvlScvsXoh4fBTq+T0K
M1exlFgBuaGfTyCiFsMjPuZMQHRnh5qcQuDZmjPVJHKF5T3Va8xz2NbAsN2utvWN
PuizRrSs3zp/P7BuZruQhgWpcqbnEOd2xG2v8XonXCLKM7/TbsCb+wFQZuvVNMIr
CJV12zT1plQMyzOWDqRGze+ma8LDqbCd0iR6sRszIwpd7k5o+j1XQqdZbx2yTTXX
OJKKEKa8w4SAFMDPEHXMPeXxhAyLcO/Jhr5ZUmWYPx6YhhI5qR9GqVGDGvz0ajOK
cRRL3xec+kIPrhQ3cnUsBrXwW6ePt1cVtq0wliGq5oQEp6Pf41Gl5QTcJmEO1js=
=mIHY
-----END PGP SIGNATURE-----

--pqrHuw837mIruWQK--

--===============4523137036881647893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4523137036881647893==--
