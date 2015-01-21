From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about codec which is supporting TDM /
	5.1ch
Date: Wed, 21 Jan 2015 11:33:35 +0000
Message-ID: <20150121113335.GE21293@sirena.org.uk>
References: <HKXPR06MB34170B809052DD484A1B62DA9460@HKXPR06MB341.apcprd06.prod.outlook.com>
 <SIXPR06MB0463BD85668E6D68EEC9A5E3C1460@SIXPR06MB0463.apcprd06.prod.outlook.com>
 <SIXPR06MB333851D089CC87404B679C1B5460@SIXPR06MB333.apcprd06.prod.outlook.com>
 <54ACD3BF.9060107@renesas.com>
 <HKXPR06MB0615ABF482506554FD9A7191D7460@HKXPR06MB0615.apcprd06.prod.outlook.com>
 <54BE1BC0.6090408@renesas.com>
 <HKXPR06MB0615D0AA32CC1219B1E5E95DD74B0@HKXPR06MB0615.apcprd06.prod.outlook.com>
 <HKXPR06MB341C8969D2788FE21F887E2A94B0@HKXPR06MB341.apcprd06.prod.outlook.com>
 <87ppa8mvqh.wl%kuninori.morimoto.gx@renesas.com>
 <87oapsmvav.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0313823143913275777=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACBD62605CE
 for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2015 12:33:43 +0100 (CET)
In-Reply-To: <87oapsmvav.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: TOMOHARU FUKAWA <tomoharu.fukawa.eb@renesas.com>, Linux-ALSA <alsa-devel@alsa-project.org>, shiiba <naoya.shiiba.nx@renesas.com>, YOSHIFUMI HOSOYA <yoshifumi.hosoya.wj@renesas.com>, shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus <magnus.damm@gmail.com>, komatsu <toshiaki.komatsu.ud@renesas.com>, tanaka <hiroo.tanaka.sx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============0313823143913275777==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/QKKmeG/X/bPShih"
Content-Disposition: inline


--/QKKmeG/X/bPShih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2015 at 07:44:17AM +0000, Kuninori Morimoto wrote:

> Now, we want to create new board, and then, we want to use below codec if=
 exist.
> Can you show it to us if it was exist ?
> (I researched it on upstream Linux source tree, but couldn't find....)

>  - upstream Linux supports its driver
>  - it supports TDM format
>  - it supports 5.1ch sound
>  - it supports DT bindings (if possible)=20

Some of the Wolfson/Cirrus mobile CODECs can do that with some fiddling
and mixing of output types but they're not really a good fit.  Most of
the things doing 5.1 are like the WM8580 - they use separate data lines
rather than TDM, as far as I can tell a lot of 5.1 systems out there do
this by hooking up multiple stereo CODECs in parallel as slaves rather
than by using a single 5.1 CODEC.

--/QKKmeG/X/bPShih
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUv46OAAoJECTWi3JdVIfQL5kH/3Lro2Nlc7Mll2+Fr2TX1lLj
DRBueBhvDHQEuzRs9KBhCXkmUsKhHDCOTRrbz+Eh/bXYtcXEygpAalXWmDfkMW+5
RZ20y5VSVuW2dK4ZVEOa6DnJUeURkZQenQuMFt6ENmWgfF9kgJDMbNbv/75b/UX/
iiTDxCS+G23p5BvGnIrsqby3Ke/DwBU2W/6eZMtX2d1MfdKP4tZOJgj7u7+tFWc+
BOrtpKgYqohpSCD9lHb6k3KN719rcPoLkcv8EqpcaZWs91tC0g7AffSeR0xnePkE
UtEWGiecz3XdCzHi7/lvTU5Ef7A04lw3r0OiLpN9mCRUqi/ZbQDqdPYkzXe5dUI=
=p/Tt
-----END PGP SIGNATURE-----

--/QKKmeG/X/bPShih--

--===============0313823143913275777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0313823143913275777==--
