From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: hard freezes with hdsp with cardbus/pci adapter
	card
Date: Tue, 11 Aug 2009 11:25:26 +0200
Message-ID: <20090811092526.GA3163@pengutronix.de>
References: <h5q3ur$13e$1@ger.gmane.org>
	<20090811050619.GA12438@pengutronix.de>
	<4A811076.6000603@klingt.org> <4A811D1B.2020709@klingt.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8623800222236402296=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id ED3C324B1E
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Aug 2009 11:25:28 +0200 (CEST)
In-Reply-To: <4A811D1B.2020709@klingt.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Blechmann <tim@klingt.org>
Cc: alsa-devel@alsa-project.org, linux-pcmcia@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8623800222236402296==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tim,

> hm, actually, i think the issue is related to the pci latency of the
> cardbus controller.

Looks like it:

http://lkml.indiana.edu/hypermail/linux/kernel/0404.1/0602.html

Do you know if the increased latency is needed for all bridges, not just EN=
E?
(I'd assume so...)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkqBOQUACgkQD27XaX1/VRuHMQCePFLTN0GrSbZOL/CenWChwAru
x1oAn2rqv+pjYQE8quQgThF+Ek3cY97R
=ukum
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--

--===============8623800222236402296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8623800222236402296==--
