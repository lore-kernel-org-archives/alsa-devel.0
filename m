From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH alsa-kernel] snd-hda-codec-realtek: Add
 quirk for Jetway NF92
Date: Tue, 29 Mar 2011 09:36:07 -0400
Message-ID: <20110329133607.GL29800@alittletooquiet.net>
References: <20110328184307.GJ29800@alittletooquiet.net>
	<1301389809.15348.3.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6568207319197897011=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id A8498103937
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 15:36:10 +0200 (CEST)
In-Reply-To: <1301389809.15348.3.camel@mattotaupa>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6568207319197897011==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUk9VBj82R8Xhb8H"
Content-Disposition: inline


--SUk9VBj82R8Xhb8H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Paul,

Thanks for your reply.

On Tue, Mar 29, 2011 at 11:10:09AM +0200, Paul Menzel wrote:
> Am Montag, den 28.03.2011, 14:43 -0400 schrieb Forest Bond:
> > The Jetway NF92 mainboard works with model=3D3stack-6ch-dig.
>=20
> what did not work before?

My testing notes say that the S/PDIF output did not work and the analog aud=
io
was too quiet, but I'm no longer able to replicate.  Maybe I made a mistake
during testing.

Please disregard the patch.  Everything seems to be working fine without it.

> > Add a quirk to automatically configure the codec accordingly.
> >=20
> > Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
>=20
> Please make sure that your From line and Signed-of-by line match.

Okay.  I generated the patch on my work machine but my list membership is w=
ith
my personal address.  I think I can fix this by putting a From: line in the
message body (that's what some experimentation with git send-email suggests=
).

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--SUk9VBj82R8Xhb8H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2R4EcACgkQRO4fQQdv5AzJLQCgiAQDHOXFAaBxpCithXUNkUTt
QQIAmgItiILENhY8J/4a+cYLazvlcpm/
=W8aO
-----END PGP SIGNATURE-----

--SUk9VBj82R8Xhb8H--

--===============6568207319197897011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6568207319197897011==--
