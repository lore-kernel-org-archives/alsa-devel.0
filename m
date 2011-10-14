From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: busy loop in snd_pcm_plugin_status()
Date: Fri, 14 Oct 2011 13:17:20 +0200
Message-ID: <20111014111720.GA16341@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5375059284267042464=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187])
	by alsa0.perex.cz (Postfix) with ESMTP id D14C6103819
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Oct 2011 13:17:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5375059284267042464==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'm seeing a strange issue when using linphone (3.4.3) with alsa-lib
(1.0.24.1) on an Atom-based platform. I was able to trace the problem down to
the snd_pcm_plugin_status() function. The problem is that the call to the
snd_atomic_read_ok() function fails because snd_pcm_plugin_avail_update() has
already called snd_atomic_write_{begin,end}() in the meantime. The result is
that I'm seeing calls to snd_pcm_plugin_status() where the code jumps back to
the _again between 200 and 1800 times before succeeding. This in turn leads
to delays in the linphone of 20 to 180 milliseconds, which results in rather
absurdly high CPU usage (usually 100%) and correspondingly bad audio playback
and side-effects (choppiness, linphone no longer terminates calls properly,
...).

I'm using the attached patch as a workaround, but I'm pretty sure it's not a
proper fix. The strange thing is that I see that behaviour only on the Atom
platform (Intel HDA, Sigmatel 92HD83 codec). Another ARM-based platform does
not exhibit the same issue.

Can anybody shed some light on the situation?

Cheers,
Thierry

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="busy-loop-fix.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/src/pcm/pcm_plugin.c b/src/pcm/pcm_plugin.c
index d88e117..8a865a2 100644
--- a/src/pcm/pcm_plugin.c
+++ b/src/pcm/pcm_plugin.c
@@ -523,9 +523,9 @@ static int snd_pcm_plugin_status(snd_pcm_t *pcm, snd_pc=
m_status_t * status)
 	snd_atomic_read_t ratom;
 	snd_atomic_read_init(&ratom, &plugin->watom);
  _again:
-	snd_atomic_read_begin(&ratom);
 	/* sync with the latest hw and appl ptrs */
 	snd_pcm_plugin_avail_update(pcm);
+	snd_atomic_read_begin(&ratom);
=20
 	err =3D snd_pcm_status(plugin->gen.slave, status);
 	if (err < 0) {

--UlVJffcvxoiEqYs2--

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6YGkAACgkQZ+BJyKLjJp8bWQCfb9uRShLgbOdUy+42RN+T6503
lSYAoKjApIi1kHgFo8nti3C5d3cJ9a8d
=E2lb
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--

--===============5375059284267042464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5375059284267042464==--
