From: Axel Thimm <Axel.Thimm@ATrpms.net>
Subject: Re: 1.0.7 build errors
Date: Sat, 20 Nov 2004 14:45:59 +0100
Message-ID: <20041120134559.GG9815@neu.nirvana>
References: <419CCEF0.4070005@att.net> <s5hd5ybcba8.wl@alsa2.suse.de>
Reply-To: alsa-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1758830443845247125=="
Return-path: <atrpms-devel-bounces@atrpms.net>
In-Reply-To: <s5hd5ybcba8.wl@alsa2.suse.de>
List-Unsubscribe: <http://lists.atrpms.net/mailman/listinfo/atrpms-devel>,
	<mailto:atrpms-devel-request@atrpms.net?subject=unsubscribe>
List-Archive: <http://lists.atrpms.net/pipermail/atrpms-devel>
List-Post: <mailto:atrpms-devel@atrpms.net>
List-Help: <mailto:atrpms-devel-request@atrpms.net?subject=help>
List-Subscribe: <http://lists.atrpms.net/mailman/listinfo/atrpms-devel>,
	<mailto:atrpms-devel-request@atrpms.net?subject=subscribe>
Sender: atrpms-devel-bounces@atrpms.net
Errors-To: atrpms-devel-bounces@atrpms.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ATrpms development list <atrpms-devel@ATrpms.net>, alsa-devel@lists.sourceforge.net, psantoro@att.net
List-Id: alsa-devel@alsa-project.org


--===============1758830443845247125==
Content-Disposition: inline
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2004 at 06:33:19PM +0100, Takashi Iwai wrote:
> At Thu, 18 Nov 2004 11:33:52 -0500,
> Peter Santoro wrote:
> > I've been using 1.05a and recently tried upgrading to 1.0.7.
> > Unfortunately, I get build errors (patching fails).  I tried
> > 1.0.6a and it works fine.  I'm using slackware 9.1/10.0 and kernel
> > 2.4.28.  Let me know if you would like more information.
>=20
> This should have been fixed on the CVS version.
> Could you try CVS?

I had similar errors with FC1 and RH9,8.0 and 7.3. I just upgraded to
today's CVS and the errors are still there for Red Hat's 2.4.22:

copying file alsa-kernel/core/sound.c
patching file sound.c
Hunk #5 succeeded at 502 (offset -1 lines).
copying file alsa-kernel/core/init.c
patching file init.c
Hunk #4 FAILED at 823.
Hunk #5 succeeded at 836 (offset -3 lines).
1 out of 5 hunks FAILED -- saving rejects to file init.c.rej
make[2]: *** [init.c] Error 1

Thanks!
--=20
Axel.Thimm at ATrpms.net

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFBn0qXQBVS1GOamfERAogMAJ0T+b7bRHXwPE44gwKON5zy8MkbhwCdF1wy
hV4KnxOEYz6oePh2WALYK5s=
=9+I9
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--


--===============1758830443845247125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1758830443845247125==--
