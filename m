From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] alsactl: Make homedir configurable
Date: Tue, 27 Dec 2016 17:15:27 +0100
Message-ID: <1482855327.3916.204.camel@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1474395061614260137=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
 by alsa0.perex.cz (Postfix) with ESMTP id E4AE526665B
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 17:15:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jordi Mallach <jordi@debian.org>
List-Id: alsa-devel@alsa-project.org


--===============1474395061614260137==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-BZvUlNgLJKzSPG/m3j+i"


--=-BZvUlNgLJKzSPG/m3j+i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Date: Sat, 19 Oct 2013 10:12:19 +0000

Add new configure switch to set alsactl's homedir. This is used to avoid
that a directory `.pulse` is created by the init script, when PulseAudio
is installed [1].

[1] https://bugs.debian.org/712980
    "alsa-utils startup script creates /.pulse files ("Failed to create
     secure directory") when pulseaudio is installed"

CC: Jordi Mallach <jordi@debian.org>
Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
Please apply with `git am saved-messages.mbox`.

 alsactl/90-alsa-restore.rules.in | 4 ++--
 alsactl/Makefile.am              | 1 +
 alsactl/alsa-restore.service.in  | 4 ++--
 alsactl/alsa-state.service.in    | 4 ++--
 configure.ac                     | 6 ++++++
 5 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/alsactl/90-alsa-restore.rules.in b/alsactl/90-alsa-restore.rul=
es.in
index c0c1b23..95b26c4 100644
--- a/alsactl/90-alsa-restore.rules.in
+++ b/alsactl/90-alsa-restore.rules.in
@@ -2,7 +2,7 @@ ACTION=3D=3D"add", SUBSYSTEM=3D=3D"sound", KERNEL=3D=3D"con=
trolC*", KERNELS!=3D"card*", TEST=3D=3D
 GOTO=3D"alsa_restore_end"
=20
 LABEL=3D"alsa_restore_go"
-TEST!=3D"@daemonswitch@", RUN+=3D"@sbindir@/alsactl restore $attr{device/n=
umber}"
-TEST=3D=3D"@daemonswitch@", RUN+=3D"@sbindir@/alsactl nrestore $attr{devic=
e/number}"
+TEST!=3D"@daemonswitch@", RUN+=3D"@sbindir@/alsactl -E HOME=3D@alsactlhome=
@ restore $attr{device/number}"
+TEST=3D=3D"@daemonswitch@", RUN+=3D"@sbindir@/alsactl -E HOME=3D@alsactlho=
me@ nrestore $attr{device/number}"
=20
 LABEL=3D"alsa_restore_end"
diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index cac8094..d03137b 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -40,6 +40,7 @@ endif
 edit =3D \
 	$(SED) -r -e 's,@sbindir\@,$(sbindir),g' \
 		  -e 's,@mydatadir\@,$(mydatadir),g' \
+		  -e 's,@alsactlhome\@,$(ALSACTL_HOME_DIR),g' \
 		  -e 's,@daemonswitch\@,$(ALSACTL_DAEMONSWITCH),g' \
 							< $< > $@ || rm $@
=20
diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service=
.in
index 2884098..23dece8 100644
--- a/alsactl/alsa-restore.service.in
+++ b/alsactl/alsa-restore.service.in
@@ -12,6 +12,6 @@ After=3Dalsa-state.service
 [Service]
 Type=3Doneshot
 RemainAfterExit=3Dtrue
-ExecStart=3D-@sbindir@/alsactl restore
-ExecStop=3D-@sbindir@/alsactl store
+ExecStart=3D-@sbindir@/alsactl -E HOME=3D@alsactlhome@ restore
+ExecStop=3D-@sbindir@/alsactl -E HOME=3D@alsactlhome@ store
 StandardOutput=3Dsyslog
diff --git a/alsactl/alsa-state.service.in b/alsactl/alsa-state.service.in
index f1321d6..28e3043 100644
--- a/alsactl/alsa-state.service.in
+++ b/alsactl/alsa-state.service.in
@@ -10,5 +10,5 @@ After=3Dsysinit.target
=20
 [Service]
 Type=3Dsimple
-ExecStart=3D-@sbindir@/alsactl -s -n 19 -c rdaemon
-ExecStop=3D-@sbindir@/alsactl -s kill save_and_quit
+ExecStart=3D-@sbindir@/alsactl -E HOME=3D@alsactlhome@ -s -n 19 -c rdaemon
+ExecStop=3D-@sbindir@/alsactl -E HOME=3D@alsactlhome@ -s kill save_and_qui=
t
diff --git a/configure.ac b/configure.ac
index 69ff2ab..8cbf798 100644
--- a/configure.ac
+++ b/configure.ac
@@ -409,6 +409,12 @@ AC_ARG_WITH([alsactl-pidfile-dir],
         [ALSACTL_PIDFILE_DIR=3D"/var/run"])
 AC_SUBST(ALSACTL_PIDFILE_DIR)
=20
+AC_ARG_WITH([alsactl-home-dir],
+        AS_HELP_STRING([--with-alsactl-home-dir=3DDIR], [Directory to use =
as homedir for alsactl]),
+        [ALSACTL_HOME_DIR=3D"$withval"],
+        [ALSACTL_HOME_DIR=3D"/var/run/alsa"])
+AC_SUBST(ALSACTL_HOME_DIR)
+
 AC_ARG_WITH([alsactl-daemonswitch],
         AS_HELP_STRING([--with-alsactl-daemonswitch=3DFILE], [File to test=
 for the daemon mode]),
         [ALSACTL_DAEMONSWITCH=3D"$withval"],
--=20
2.11.0
--=-BZvUlNgLJKzSPG/m3j+i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWGKToAAKCRA9fVorbA4d
WKB9AJ0XSwaRU9q/7rhEOXICXuLt3q9DKQCcDLHO2sgC49CNK0EY//TAz3beT34=
=yhSu
-----END PGP SIGNATURE-----

--=-BZvUlNgLJKzSPG/m3j+i--


--===============1474395061614260137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1474395061614260137==--
