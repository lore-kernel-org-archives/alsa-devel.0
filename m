From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] alsactl: Check existence of `alsactl` in
 udev	rule
Date: Fri, 30 Dec 2016 11:04:54 +0100
Message-ID: <1483092294.3846.46.camel@users.sourceforge.net>
References: <1482964275.11185.34.camel@users.sourceforge.net>
 <s5h8tqy27ac.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8886246420768349283=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
 by alsa0.perex.cz (Postfix) with ESMTP id DF4D1267029
 for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2016 11:05:04 +0100 (CET)
In-Reply-To: <s5h8tqy27ac.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org


--===============8886246420768349283==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-6Akq7rI1gHOFS7uKPad2"


--=-6Akq7rI1gHOFS7uKPad2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Donnerstag, den 29.12.2016, 14:28 +0100 schrieb Takashi Iwai:
> On Wed, 28 Dec 2016 23:31:15 +0100,
> Paul Menzel wrote:
> >=20
> > From: Jordi Mallach <jordi@debian.org>
> > Date: Thu, 10 Jan 2013 00:17:58 +0000
> >=20
> > Include the line `TEST=3D=3D"/usr/sbin/alsactl"` in the udev rule, to
> > properly fix the state restoring for users with split `/usr`
> > filesystems
> > [1].
>=20
> This doesn't sound like a real "fix".  It means that the whole
> save/restore mechanism will be silently lost, right?

Well, if the binary `alsactl` is not available, it shouldn=E2=80=99t be run=
.

But you are right, it depends on the system setup, what happens.

See the description of commit de7c3eff (alsactl: systemd and udev
hookup).

>     - At boot the asound.state file might not be readable, since it resid=
es
>       on a different file system. That means exclusively restoring sound =
card
>       settings from udev rules will no suffice, since if the rule is
>       executed at early boot (for example within udev settle) then the fi=
le
>       will no be readable and cannot be restored.


Thanks,

Paul


> > Upstream the patch from the Debian package [2].
> >=20
> > [1] https://bugs.debian.org/670490
> > =C2=A0=C2=A0=C2=A0=C2=A0"Debian Bug report logs - #670490 alsa-utils: R=
estore sound volume
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0in udev"
> > [2] https://sources.debian.net/src/alsa-utils/1.1.2-1/debian/patches/ud=
ev_test_alsactl.patch/
> >=20
> > Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
> > CC: Jordi Mallach <jordi@debian.org>
> > ---
> > Please apply with `git am saved-messages.mbox`.
> >=20
> > =C2=A0alsactl/90-alsa-restore.rules.in | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore=
.rules.in
> > index c0c1b23..f190b85 100644
> > --- a/alsactl/90-alsa-restore.rules.in
> > +++ b/alsactl/90-alsa-restore.rules.in
> > @@ -2,7 +2,7 @@ ACTION=3D=3D"add", SUBSYSTEM=3D=3D"sound", KERNEL=3D=3D=
"controlC*", KERNELS!=3D"card*", TEST=3D=3D
> > =C2=A0GOTO=3D"alsa_restore_end"
> > =C2=A0
> > =C2=A0LABEL=3D"alsa_restore_go"
> > -TEST!=3D"@daemonswitch@", RUN+=3D"@sbindir@/alsactl restore $attr{devi=
ce/number}"
> > -TEST=3D=3D"@daemonswitch@", RUN+=3D"@sbindir@/alsactl nrestore $attr{d=
evice/number}"
> > +TEST!=3D"@daemonswitch@", TEST=3D=3D"@sbindir@/alsactl", RUN+=3D"@sbin=
dir@/alsactl restore $attr{device/number}"
> > +TEST=3D=3D"@daemonswitch@", TEST=3D=3D"@sbindir@/alsactl", RUN+=3D"@sb=
indir@/alsactl nrestore $attr{device/number}"
> > =C2=A0
> > =C2=A0LABEL=3D"alsa_restore_end"
> > --=C2=A0
> > 2.11.0
--=-6Akq7rI1gHOFS7uKPad2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWGYxRwAKCRA9fVorbA4d
WGoDAJ9lOeQyBt86nbgPNMNS6XUEqSo4/QCfSEu6L87Zi1a055m7c0rtJBa+LdI=
=FD5X
-----END PGP SIGNATURE-----

--=-6Akq7rI1gHOFS7uKPad2--


--===============8886246420768349283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8886246420768349283==--
