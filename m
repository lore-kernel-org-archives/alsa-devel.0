From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: Fixes for identifying VT1617 codec and MSI-7142 mobo
Date: Sun, 7 Aug 2005 23:27:32 +0400
Message-ID: <20050807192732.GA3079@procyon.home>
References: <42F655E2.5040504@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ns1.murom.ru (mail.murom.net [213.177.124.17])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 019EB1DB
	for <alsa-devel@alsa-project.org>; Sun,  7 Aug 2005 21:28:20 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <42F655E2.5040504@redfish-solutions.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 07, 2005 at 12:41:38PM -0600, Philip Prindeville wrote:
> Can we please commit this minor fixes to the tree?  I've been
> using them and they seem to work fine.
>=20
> Thanks,
>=20
> -Philip
>=20

> *** alsa-kernel/pci/via82xx.c.bak	2005-05-27 04:10:18.000000000 -0600
> --- alsa-kernel/pci/via82xx.c	2005-07-25 20:33:51.000000000 -0600
> ***************
> *** 2174,2179 ****
> --- 2174,2180 ----
>   		{ .vendor =3D 0x1462, .device =3D 0x5901, .action =3D VIA_DXS_NO_VRA =
}, /* MSI KT6 Delta-SR */
>   		{ .vendor =3D 0x1462, .device =3D 0x7023, .action =3D VIA_DXS_NO_VRA =
}, /* MSI K8T Neo2-FI */
>   		{ .vendor =3D 0x1462, .device =3D 0x7120, .action =3D VIA_DXS_ENABLE =
}, /* MSI KT4V */
> + 		{ .vendor =3D 0x1462, .device =3D 0x7142, .action =3D VIA_DXS_ENABLE =
}, /* MSI K8MM-V */

Did you try VIA_DXS_SRC instead?  If it works, it gives more
capabilities (any sample rate - not discrete values, and separate
sample rates for all 4 DXS channels).

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC9mCkW82GfkQfsqIRAjpDAJoD+67R+TvGfBzGG7jnfQ5JOpiSawCbBrW6
dCreUSch0UiGF07HEgBkkSE=
=hNLo
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
