From: Reilly Grant <reillyeon@qotw.net>
Subject: [PATCH] plug: Move fast_ops copy after slave
	configuration.
Date: Sun, 11 Dec 2011 11:42:52 -0800
Message-ID: <4EE507BC.7050603@qotw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3612659484274416522=="
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3612659484274416522==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigFB17D529DDDD135DEA97C137"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB17D529DDDD135DEA97C137
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

The plug plugin copies the fast_ops structure and fast_op_arg from its
slave PCM on initialization and after inserting a new plugin. This works
unless the slave PCM is also an instance of the plug plugin because plug
can change its fast_ops structure during _snd_pcm_hw_params.

Instead of copying fast_ops in snd_pcm_plug_insert_plugins wait until
the end of snd_pcm_plug_hw_params when the slave has been fully
initialized.

This fixes a crash when two instances of plug are instantiated back to
back and the format conversion plugin inserted by the second is skipped
by the first because the fast_ops pointer is not properly updated. This
is the case for applications requesting plug:default on Intel HDA chips.
---
 src/pcm/pcm_plug.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_plug.c b/src/pcm/pcm_plug.c
index e9d2923..72456d5 100644
--- a/src/pcm/pcm_plug.c
+++ b/src/pcm/pcm_plug.c
@@ -659,8 +659,6 @@ static int snd_pcm_plug_insert_plugins(snd_pcm_t *pcm=
,
 		}
 		if (err) {
 			plug->gen.slave =3D new;
-			pcm->fast_ops =3D new->fast_ops;
-			pcm->fast_op_arg =3D new->fast_op_arg;
 		}
 		k++;
 	}
@@ -1049,6 +1047,9 @@ static int snd_pcm_plug_hw_params(snd_pcm_t *pcm,
snd_pcm_hw_params_t *params)
 	}
 	snd_pcm_unlink_hw_ptr(pcm, plug->req_slave);
 	snd_pcm_unlink_appl_ptr(pcm, plug->req_slave);
+
+	pcm->fast_ops =3D slave->fast_ops;
+	pcm->fast_op_arg =3D slave->fast_op_arg;
 	snd_pcm_link_hw_ptr(pcm, slave);
 	snd_pcm_link_appl_ptr(pcm, slave);
 	return 0;
--=20
1.7.3.4



--------------enigFB17D529DDDD135DEA97C137
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBCAAGBQJO5QfHAAoJEOXiGGAVSFKDP0oP/2Neuy1VDqSRQLfSrENxB6Xd
fTaCghUksUZjILq86nqepeIVS811PTxi1Lnmrj9mxFkGtO47CbLJ9kFmV7Xl0WIA
Jr8AmPw1xFwH9FTl52TnUdEW8eWGeNbVx6E/V1CvKuQ0Gen9cAMSZwj0S9lZwmQC
AjwqMf7vAdmxguRKIKte31El3Of5y7WfUMlJPRL67KPO2koyVhfgF7OrngC8unuY
sB0I1aaOYP1ny14JsJ8acP6UVLTTa2QsD9y7Nzyg8j+wMytwrfVBxW8DYuM2gQQr
8OtcZOkxL5+y8og/2HHZGxpL1z19jaWO+8VBZo3h/bm7Ip0HdPLCMYaqKwAKKOvE
RkWk3QcpurvyhyOodgQhPSzklVEikjF+bmhqbURwpcTlau3iSAH6bZCvlnjldE2f
FxblcBkixb49hqsf5VGsRO4IJj9RtbgkshJI5/tzalZpvNjFMxHIl9QNr7QW7eBx
9YII+LlKlxVf/LW1M/g3+dN4UkaYGzm0JRIZaOFvAEOb1KOS9w0FAnHqW+d8THst
Y/l2nrKM3r7SpbY72COq7LP/fYAppNpCsmEQSyoOcdglLpIM630aJlaBAdIZQPpM
AVLMrg1JE0BrS862Kt8roTOZqadagQ73+TRSO+omo1z0GMILw5tmPOpKFKMLYxqR
dgokU5cLcD8l912G6Owv
=tT9v
-----END PGP SIGNATURE-----

--------------enigFB17D529DDDD135DEA97C137--

--===============3612659484274416522==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3612659484274416522==--
