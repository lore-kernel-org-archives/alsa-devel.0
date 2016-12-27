From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] alsactl: Fix spelling mistakes
Date: Tue, 27 Dec 2016 17:04:43 +0100
Message-ID: <1482854683.3916.202.camel@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4151739282127284316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 866A3266653
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 17:04:55 +0100 (CET)
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
Cc: Elimar Riesebieter <riesebie@lxtec.de>
List-Id: alsa-devel@alsa-project.org


--===============4151739282127284316==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wLBzCilchlcBuhvuRt0H"


--=-wLBzCilchlcBuhvuRt0H
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Date: Sun, 8 May 2016 16:50:23 +0000

Upstream the patch from the Debian package [1].

[1] https://sources.debian.net/src/alsa-utils/1.1.2-1/debian/patches/spellf=
ixes.patch/

CC: Elimar Riesebieter <riesebie@lxtec.de>
Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
The renaming from `ressize` to `resize` might not be correct, if it=E2=80=
=99s
the size of the variable *res*. Please tell me, if I should remove
that.

=C2=A0alsactl/alsactl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|=C2=
=A0=C2=A02 +-
=C2=A0alsactl/init_parse.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 10 +++++-----
=C2=A0alsactl/init_utils_run.c | 14 +++++++-------
=C2=A0alsactl/state.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0|=C2=A0=C2=A02 +-
=C2=A04 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/alsactl/alsactl.c b/alsactl/alsactl.c
index bcbc187..f0060e9 100644
--- a/alsactl/alsactl.c
+++ b/alsactl/alsactl.c
@@ -90,7 +90,7 @@ static struct arg args[] =3D {
=C2=A0{ FILEARG | 'e', "pid-file", "pathname for the process id (daemon mod=
e)" },
=C2=A0{ HEADER, NULL, "Available init options:" },
=C2=A0{ ENVARG | 'E', "env", "set environment variable for init phase (NAME=
=3DVALUE)" },
-{ FILEARG | 'i', "initfile", "main configuation file for init phase" },
+{ FILEARG | 'i', "initfile", "main configuration file for init phase" },
=C2=A0{ 0, NULL, "=C2=A0=C2=A0(default " DATADIR "/init/00main)" },
=C2=A0{ 'b', "background", "run daemon in background" },
=C2=A0{ 's', "syslog", "use syslog for messages" },
diff --git a/alsactl/init_parse.c b/alsactl/init_parse.c
index e81174f..f2a598c 100644
--- a/alsactl/init_parse.c
+++ b/alsactl/init_parse.c
@@ -939,7 +939,7 @@ static int get_key(char **line, char **key, enum key_op=
 *op, char **value)
=C2=A0}
=C2=A0
=C2=A0/* extract possible KEY{attr} */
-static char *get_key_attribute(struct space *space, char *str, char *res, =
size_t ressize)
+static char *get_key_attribute(struct space *space, char *str, char *res, =
size_t resize)
=C2=A0{
=C2=A0	char *pos;
=C2=A0	char *attr;
@@ -953,7 +953,7 @@ static char *get_key_attribute(struct space *space, cha=
r *str, char *res, size_t
=C2=A0			return NULL;
=C2=A0		}
=C2=A0		pos[0] =3D '\0';
-		strlcpy(res, attr, ressize);
+		strlcpy(res, attr, resize);
=C2=A0		pos[0] =3D '}';
=C2=A0		dbg("attribute=3D'%s'", res);
=C2=A0		return res;
@@ -1209,7 +1209,7 @@ found:
=C2=A0		/* possibly truncate to format-char specified length */
=C2=A0		if (len !=3D -1) {
=C2=A0			head[len] =3D '\0';
-			dbg("truncate to %i chars, subtitution string becomes '%s'", len, head)=
;
+			dbg("truncate to %i chars, substitution string becomes '%s'", len, head=
);
=C2=A0		}
=C2=A0		strlcat(string, temp, maxsize);
=C2=A0	}
@@ -1242,7 +1242,7 @@ found:
=C2=A0static
=C2=A0int run_program1(struct space *space,
=C2=A0		=C2=A0const char *command0, char *result,
-		=C2=A0size_t ressize, size_t *reslen, int log)
+		=C2=A0size_t resize, size_t *reslen, int log)
=C2=A0{
=C2=A0	if (strncmp(command0, "__ctl_search", 12) =3D=3D 0) {
=C2=A0		const char *res =3D elemid_get(space, "do_search");
@@ -1254,7 +1254,7 @@ int run_program1(struct space *space,
=C2=A0		const char *res =3D elemid_get(space, "do_count");
=C2=A0		if (res =3D=3D NULL || strcmp(res, "0") =3D=3D 0)
=C2=A0			return EXIT_FAILURE;
-		strlcpy(result, res, ressize);
+		strlcpy(result, res, resize);
=C2=A0		return EXIT_SUCCESS;
=C2=A0	}
=C2=A0	Perror(space, "unknown buildin command '%s'", command0);
diff --git a/alsactl/init_utils_run.c b/alsactl/init_utils_run.c
index dde490b..ffa0e23 100644
--- a/alsactl/init_utils_run.c
+++ b/alsactl/init_utils_run.c
@@ -24,12 +24,12 @@
=C2=A0static
=C2=A0int run_program1(struct space *space,
=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *co=
mmand0, char *result,
-		=C2=A0size_t ressize, size_t *reslen, int log);
+		=C2=A0size_t resize, size_t *reslen, int log);
=C2=A0
=C2=A0static
=C2=A0int run_program0(struct space *space,
=C2=A0	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *co=
mmand0, char *result,
-		=C2=A0size_t ressize, size_t *reslen, int log)
+		=C2=A0size_t resize, size_t *reslen, int log)
=C2=A0{
=C2=A0	int retval =3D 0;
=C2=A0	int status;
@@ -175,11 +175,11 @@ int run_program0(struct space *space,
=C2=A0
=C2=A0					/* store result for rule processing */
=C2=A0					if (result) {
-						if (respos + count < ressize) {
+						if (respos + count < resize) {
=C2=A0							memcpy(&result[respos], inbuf, count);
=C2=A0							respos +=3D count;
=C2=A0						} else {
-							Perror(space, "ressize %ld too short", (long)ressize);
+							Perror(space, "resize %ld too short", (long)resize);
=C2=A0							retval =3D -1;
=C2=A0						}
=C2=A0					}
@@ -239,9 +239,9 @@ int run_program0(struct space *space,
=C2=A0
=C2=A0static
=C2=A0int run_program(struct space *space, const char *command0, char *resu=
lt,
-		size_t ressize, size_t *reslen, int log)
+		size_t resize, size_t *reslen, int log)
=C2=A0{
=C2=A0	if (command0[0] =3D=3D '_' && command0[1] =3D=3D '_')
-		return run_program1(space, command0, result, ressize, reslen, log);
-	return run_program0(space, command0, result, ressize, reslen, log);
+		return run_program1(space, command0, result, resize, reslen, log);
+	return run_program0(space, command0, result, resize, reslen, log);
=C2=A0}
diff --git a/alsactl/state.c b/alsactl/state.c
index 3908ec4..d2d6dac 100644
--- a/alsactl/state.c
+++ b/alsactl/state.c
@@ -1160,7 +1160,7 @@ static int restore_config_value(snd_ctl_t *handle, sn=
d_ctl_elem_info_t *info,
=C2=A0	case SND_CTL_ELEM_TYPE_IEC958:
=C2=A0		break;
=C2=A0	default:
-		cerror(doit, "Unknow control type: %d", type);
+		cerror(doit, "Unknown control type: %d", type);
=C2=A0		return -EINVAL;
=C2=A0	}
=C2=A0	return 0;
--=C2=A0
2.11.0
--=-wLBzCilchlcBuhvuRt0H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWGKRHAAKCRA9fVorbA4d
WPW4AJ0Q1rHrdM7jZymfT543DziXa3JnsgCgiJdpWQkJqLSEe0Hz9uILvYaK5Vs=
=MnHi
-----END PGP SIGNATURE-----

--=-wLBzCilchlcBuhvuRt0H--


--===============4151739282127284316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4151739282127284316==--
