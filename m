From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: [PATCH] ALSA: hda - fix up typos in Kconfig help for
 default buffer size introduced in acfa634f
Date: Tue, 12 Jul 2011 20:00:47 +0200
Message-ID: <1310493647.4294.118.camel@mattotaupa>
References: <s5hliw3h455.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7865861415781312895=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 968802438C
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jul 2011 20:00:51 +0200 (CEST)
In-Reply-To: <s5hliw3h455.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============7865861415781312895==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-aUG7sMNXymUrNG0L5FyS"


--=-aUG7sMNXymUrNG0L5FyS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Date: Tue, 12 Jul 2011 19:53:56 +0200

This commit is a fix up for commit acfa634f.

	commit acfa634f7e199193ec28282e82a5a6dd8edebcb7
	Author: Takashi Iwai <tiwai@suse.de>
	Date:   Tue Jul 12 17:27:46 2011 +0200

		  ALSA: hda - Add Kconfig for the default buffer size

Signed-off-by: Paul Menzel <paulepanter@users.sourceforge.net>
---
I am not sure about the singular and plural wording for =C2=BBdriver=C2=AB =
and =C2=BBreasons=C2=AB.
---
 sound/pci/hda/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 1f1a4ae..7489b46 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -19,10 +19,10 @@ config SND_HDA_PREALLOC_SIZE
 	range 0 32768
 	default 64
 	help
-	  Speficies the default pre-allocated buffer-size in kB for
+	  Specifies the default pre-allocated buffer-size in kB for the
 	  HD-audio driver.  A larger buffer (e.g. 2048) is preferred
-	  for systems with PulseAudio.  The default 64 is chosen just
-	  from the compatibility reason.
+	  for systems using PulseAudio.  The default 64 is chosen just
+	  for compatibility reasons.
=20
 	  Note that the pre-allocation size can be changed dynamically
 	  via a proc file (/proc/asound/card*/pcm*/sub*/prealloc), too.
--=20
1.7.5.4

--=-aUG7sMNXymUrNG0L5FyS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk4ci84ACgkQPX1aK2wOHVgrqACfWCT/5b9mvuybygHEJ5h4f6ln
4XwAn2j1mHT+qoXQg109MjrZUjq0pn7t
=dNLH
-----END PGP SIGNATURE-----

--=-aUG7sMNXymUrNG0L5FyS--


--===============7865861415781312895==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7865861415781312895==--
