From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/7] ASoC:davinci-mcasp: bc polarity fix
 and proper format support
Date: Mon, 14 Apr 2014 17:24:47 +0100
Message-ID: <20140414162447.GA25182@sirena.org.uk>
References: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8241593584087586353=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B9E6C2656D9
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 18:25:01 +0200 (CEST)
In-Reply-To: <1396611107-30765-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8241593584087586353==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2014 at 02:31:40PM +0300, Peter Ujfalusi wrote:
> Hi,
>=20
> The bit clock polarity has been configured incorrectly in the McASP drive=
r for a
> long time. IB_NF, NB_IF and IB_IF was not correct on the receive side sin=
ce they
> were selecting the same edge as we used for the tx.

Applied the rest, thanks.

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTAvMAAoJELSic+t+oim9U9sP/2NED3ua2bj6GOJdPRHlthOp
lCtycutgnjA/vsSEJSdkwJfBvCg/HFqi08m6JWQT7us24A+p1Krg1oGT6+CukLCf
NHz8DoyckwOg/hI0bKC+h+4qcDYfzvBzEZzVS3xOxFvFEMlY7iet7TsB8DgcAXEw
b0wCjlDTfh2rDeAqX7BgWgXLGsVWecK1N8GArRBrplxKvhzncvzqmCSTOs/9ZUzL
LsksJE0Ojm9KD04CSWpbGa4VntW60bN+nc4RwcYivNaoMDLJhzDrSj+Fyh8egYPh
LBfJhWwxKLntH1qzWasOxIoVQRoIwb2eCnwF+UPm/5oAAFQIYgBwKD8q3e6TaJF7
22NwZaqByGWJg9h0lCSMbArg84zJZ+e4NDX8c61XSeDGXxXgMMS2VnoOC4aaSOvZ
Q9V+qWjs0ztlikWs8/kIx/G2iRm7ur2JyIlf61XdYJnevTqyshCkEHzoLsGo2tvz
08H6eJbRUqTyUTfzlN0DaA0Tenc1hxePD9PS1KQ6/ud8f2gKh/wTPDe3vZjeoWTg
XrOVrCTNbHoiex03PD6aHMt6J//ZbIQC91g8TK7RCkMgaEf5jHB56D+I1Knr36qa
QujeY2eWXfurWduTN1U4T4XMkJIpY6OuCQSlcMZG22v+Vhr/dt6vuRBUI+vrJASa
yTzW0FMdqlJe2k2nDW71
=ec7l
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

--===============8241593584087586353==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8241593584087586353==--
