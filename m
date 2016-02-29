From: Steven Newbury <steve@snewbury.org.uk>
Subject: Re: [PATCH v2 0/6] ALSA core X32 ABI fixes
Date: Mon, 29 Feb 2016 16:45:44 +0000
Message-ID: <1456764344.3408.1.camel@snewbury.org.uk>
References: <1456762605-2451-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6965985422531235907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from know-smtprelay-omc-10.server.virginmedia.net
 (know-smtprelay-omc-10.server.virginmedia.net [80.0.253.74])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EFFA260535
 for <alsa-devel@alsa-project.org>; Mon, 29 Feb 2016 17:45:49 +0100 (CET)
In-Reply-To: <1456762605-2451-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6965985422531235907==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-fQdRB3faNyCFK+yohcES"


--=-fQdRB3faNyCFK+yohcES
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2016-02-29 at 17:16 +0100, Takashi Iwai wrote:
> Hi,
>=20
> this is the revised patchset for fixing the incompatible ioctls in
> ALSA core with X32 ABI.=C2=A0=C2=A0Too bad that we have to deal in this w=
ay,
> but
> it's life...
>=20
These have been successfully tested by GreatEmerald on #gentoo
(freenode). =C2=A0I haven't had the chance yet.

>=20
> Takashi
>=20
> =3D=3D=3D
>=20
> Takashi Iwai (6):
> =C2=A0 ALSA: ctl: Fix ioctls for X32 ABI
> =C2=A0 ALSA: pcm: Fix ioctls for X32 ABI
> =C2=A0 ALSA: rawmidi: Use comapt_put_timespec()
> =C2=A0 ALSA: rawmidi: Fix ioctls X32 ABI
> =C2=A0 ALSA: timer: Fix broken compat timer user status ioctl
> =C2=A0 ALSA: timer: Fix ioctls for X32 ABI
>=20
> =C2=A0sound/core/control_compat.c |=C2=A0=C2=A090 ++++++++++++++++++----
> =C2=A0sound/core/pcm_compat.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 177
> +++++++++++++++++++++++++++++++++++++++++++-
> =C2=A0sound/core/rawmidi_compat.c |=C2=A0=C2=A056 +++++++++++++-
> =C2=A0sound/core/timer_compat.c=C2=A0=C2=A0=C2=A0|=C2=A0=C2=A018 ++++-
> =C2=A04 files changed, 320 insertions(+), 21 deletions(-)
>=20
--=-fQdRB3faNyCFK+yohcES
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEUEABECAAYFAlbUdbkACgkQGcb56gMuC60zJACdFcBF/LC706kpjLXsh7H/Ndt8
bkYAmKw/OXJA589s2NYXPqo3Z/Iew+I=
=ScQb
-----END PGP SIGNATURE-----

--=-fQdRB3faNyCFK+yohcES--


--===============6965985422531235907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6965985422531235907==--
