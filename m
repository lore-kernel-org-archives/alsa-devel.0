From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] alsactl: Check for state file existence in
	systemd unit
Date: Tue, 27 Dec 2016 17:41:46 +0100
Message-ID: <1482856906.3916.208.camel@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7139807147642979656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
 by alsa0.perex.cz (Postfix) with ESMTP id 3700426665B
 for <alsa-devel@alsa-project.org>; Tue, 27 Dec 2016 17:41:56 +0100 (CET)
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


--===============7139807147642979656==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Su8zJ6J6Yrv/xYXJhXyA"


--=-Su8zJ6J6Yrv/xYXJhXyA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Date: Sat, 19 Oct 2013 10:12:19 +0000

Check for the existence of the state file, by default
`/var/lib/alsa/asound.state`, before doing anything in the systemd
service unit `alsa-restore.service`.

If the state file is not present, `alsactl` will fail with exit code
99.

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
CC: Jordi Mallach <jordi@debian.org>
---
Please apply with `git am saved-messages.mbox`.

 alsactl/Makefile.am             | 1 +
 alsactl/alsa-restore.service.in | 1 +
 2 files changed, 2 insertions(+)

diff --git a/alsactl/Makefile.am b/alsactl/Makefile.am
index cac8094..b691dfa 100644
--- a/alsactl/Makefile.am
+++ b/alsactl/Makefile.am
@@ -40,6 +40,7 @@ endif
 edit =3D \
 	$(SED) -r -e 's,@sbindir\@,$(sbindir),g' \
 		  -e 's,@mydatadir\@,$(mydatadir),g' \
+			-e 's,@asoundstatedir\@,$(ASOUND_STATE_DIR),g' \
 		  -e 's,@daemonswitch\@,$(ALSACTL_DAEMONSWITCH),g' \
 							< $< > $@ || rm $@
=20
diff --git a/alsactl/alsa-restore.service.in b/alsactl/alsa-restore.service=
.in
index 2884098..f3cd86b 100644
--- a/alsactl/alsa-restore.service.in
+++ b/alsactl/alsa-restore.service.in
@@ -7,6 +7,7 @@
 Description=3DSave/Restore Sound Card State
 ConditionPathExists=3D!@daemonswitch@
 ConditionPathExistsGlob=3D/dev/snd/control*
+ConditionPathExists=3D@asoundstatedir@/asound.state
 After=3Dalsa-state.service
=20
 [Service]
--=20
2.11.0
--=-Su8zJ6J6Yrv/xYXJhXyA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQ8+w9d414FAVARIpk9fVorbA4dWAUCWGKZygAKCRA9fVorbA4d
WMnNAJ9jIJa3Gmov+xlPI4o0QmsjgTSqEwCeKANn2IrYF97WWk26LmbTcJtCCUY=
=/GvM
-----END PGP SIGNATURE-----

--=-Su8zJ6J6Yrv/xYXJhXyA--


--===============7139807147642979656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7139807147642979656==--
