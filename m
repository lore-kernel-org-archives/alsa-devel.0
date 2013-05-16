From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH 1/3] Link arcam-av module against
	libpthread.
Date: Thu, 16 May 2013 18:10:06 +0400
Message-ID: <20130516141006.GE19577@newmaster.mivlgu.local>
References: <1368637908-29042-1-git-send-email-jordi@debian.org>
 <1368637908-29042-2-git-send-email-jordi@debian.org>
 <s5hobcbjpi5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1410869043035285014=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.mivlgu.ru (mivlgu.ru [195.20.195.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 629B926551D
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 16:10:12 +0200 (CEST)
In-Reply-To: <s5hobcbjpi5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Steve Langasek <steve.langasek@canonical.com>, Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org


--===============1410869043035285014==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EgVrEAR5UttbsTXg"
Content-Disposition: inline


--EgVrEAR5UttbsTXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2013 at 10:30:26AM +0200, Takashi Iwai wrote:
> At Wed, 15 May 2013 19:11:46 +0200,
> Jordi Mallach wrote:
> >=20
> > From: Steve Langasek <steve.langasek@canonical.com>
> >=20
> > The arcam-av module uses libpthread, so it should pass -pthread explici=
tly
> > when building in order to avoid leaving any undefined symbols or missing
> > symbol versioning info.
> >=20
> > Signed-off-by: Jordi Mallach <jordi@debian.org>
> > ---
> >  arcam-av/Makefile.am |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arcam-av/Makefile.am b/arcam-av/Makefile.am
> > index 5c7855f..eeb2e90 100644
> > --- a/arcam-av/Makefile.am
> > +++ b/arcam-av/Makefile.am
> > @@ -3,7 +3,7 @@ asound_module_ctl_arcam_av_LTLIBRARIES =3D libasound_mo=
dule_ctl_arcam_av.la
> >  asound_module_ctl_arcam_avdir =3D @ALSA_PLUGIN_DIR@
> > =20
> >  AM_CFLAGS =3D -Wall -g @ALSA_CFLAGS@
> > -AM_LDFLAGS =3D -module -avoid-version -export-dynamic -no-undefined
> > +AM_LDFLAGS =3D -module -avoid-version -export-dynamic -no-undefined -p=
thread
>=20
> Is AM_LDFLAGS the right place to add -lXXX?

No - libname_LIBADD should be used for -lXXX, otherwise it will not work
with -Wl,--as-needed (which is the default in some distributions).
AM_LDFLAGS comes before object files on the linker command line, and all
libraries must come after object files when using -Wl,--as-needed.

But note that the option here is not -lpthread, but -pthread - this option
is handled by gcc internally, and -lpthread is added at the same place as
-lc in the actual linker command line, so -pthread will work even in
AM_LDFLAGS (at least while only C is used - libtool is known to mishandle
-pthread when linking C++ shared libraries).

Also the current pthread usage in alsa-plugins is inconsistent:

$ find -name Makefile.am -print0 | xargs -r0 grep -i PTHREAD --=20
=2E/pulse/Makefile.am:AM_CFLAGS =3D -Wall -g @ALSA_CFLAGS@ $(PTHREAD_CFLAGS=
) $(pulseaudio_CFLAGS) -D_GNU_SOURCE
=2E/pulse/Makefile.am:libasound_module_pcm_pulse_la_LIBADD =3D @ALSA_LIBS@ =
$(PTHREAD_LIBS) $(pulseaudio_LIBS)
=2E/pulse/Makefile.am:libasound_module_ctl_pulse_la_LIBADD =3D @ALSA_LIBS@ =
$(PTHREAD_LIBS) $(pulseaudio_LIBS)
=2E/pulse/Makefile.am:libasound_module_conf_pulse_la_LIBADD =3D @ALSA_LIBS@=
 $(PTHREAD_LIBS) $(pulseaudio_LIBS)
=2E/maemo/Makefile.am:libasound_module_pcm_alsa_dsp_la_LIBADD =3D @ALSA_LIB=
S@ $(DBUS_LIBS) -lpthread=20
=2E/maemo/Makefile.am:libasound_module_ctl_dsp_ctl_la_LIBADD =3D @ALSA_LIBS=
@ $(DBUS_LIBS) -lpthread=20

PTHREAD_CFLAGS and PTHREAD_LIBS do not seem to be defined anywhere.

--EgVrEAR5UttbsTXg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iD8DBQFRlOi+W82GfkQfsqIRAp2xAJ9KXEgPAXJ6EjdUgNEycOpCV2ZQ1gCfdXIz
wlUhsYALysSpuGy+v+FwVTA=
=4Yhc
-----END PGP SIGNATURE-----

--EgVrEAR5UttbsTXg--

--===============1410869043035285014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1410869043035285014==--
