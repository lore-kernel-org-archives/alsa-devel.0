From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH v2] sound/pci/ice1712: replace strcpy() with strlcpy()
Date: Thu, 1 Mar 2018 04:17:07 -1000
Message-ID: <20180301141707.cp5dc6zbh6bur4xw@gmail.com>
References: <20180301114535.bf3ibzcpvohyjweu@gmail.com>
 <CAHp75Vf6kfPE_sRPj_mLMvLQfn9Fe9B_MeXqnGAHGAdzR7HX+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5nv5xths47pkr5ye"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vf6kfPE_sRPj_mLMvLQfn9Fe9B_MeXqnGAHGAdzR7HX+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Joey Pabalinas <joeypabalinas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--5nv5xths47pkr5ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace unsafe usages of strcpy() to copy the name
argument into the sid.name buffer with strlcpy()
to guard against possible buffer overflows.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>

 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index 0dbaccf61f33270608..21806bab4757241a9e 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -27,6 +27,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
=20
@@ -425,10 +426,9 @@ DECLARE_TLV_DB_SCALE(juli_master_db_scale, -6350, 50, =
1);
 static struct snd_kcontrol *ctl_find(struct snd_card *card,
 				     const char *name)
 {
-	struct snd_ctl_elem_id sid;
-	memset(&sid, 0, sizeof(sid));
-	/* FIXME: strcpy is bad. */
-	strcpy(sid.name, name);
+	struct snd_ctl_elem_id sid =3D {0};
+
+	strlcpy(sid.name, name, sizeof(sid.name));
 	sid.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
 	return snd_ctl_find_id(card, &sid);
 }
diff --git a/sound/pci/ice1712/quartet.c b/sound/pci/ice1712/quartet.c
index d145b5eb7ff86d978d..5bc836241c977feb51 100644
--- a/sound/pci/ice1712/quartet.c
+++ b/sound/pci/ice1712/quartet.c
@@ -26,6 +26,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
 #include <sound/info.h>
@@ -785,10 +786,9 @@ DECLARE_TLV_DB_SCALE(qtet_master_db_scale, -6350, 50, =
1);
 static struct snd_kcontrol *ctl_find(struct snd_card *card,
 				     const char *name)
 {
-	struct snd_ctl_elem_id sid;
-	memset(&sid, 0, sizeof(sid));
-	/* FIXME: strcpy is bad. */
-	strcpy(sid.name, name);
+	struct snd_ctl_elem_id sid =3D {0};
+
+	strlcpy(sid.name, name, sizeof(sid.name));
 	sid.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER;
 	return snd_ctl_find_id(card, &sid);
 }
--=20
2.16.2

--5nv5xths47pkr5ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEKlZXrihdNOcUPZTNruvLfWhyVBkFAlqYC2MACgkQruvLfWhy
VBnS6A/9Hvtn6RWzEjUFO9rAVKI8bodYigHidWTkmrZ/9/v9AWhoF9n2/SZWtzPa
1nz4ycET3qvGvHCWAwkPdUm5MfN7oBlIi1DxV6pacpEOVeor9yNOhnrBcTe8a9Vn
wmXCWaNyhvco0zSQ1tHWQQojtB6WnQU0MDi0RzaNRqMu7cqWvHCvFPuCvdzYn3jK
1u+WbXSqvSCUdew+tXRdcnKZ5ZIomsmymsbUivFUH/Lg38GUC9otmt1ZWVNr2dOl
TyiAsnVCLziT+Vvn1XsiEDYCn+mNQ7F6RipXgY2URZkRjIIuhAZdBwpavNhBCMvl
cbujtepxg3nib/v7dgeH7CfvszODSwM8mu/b348elhsLtBMsKc5KOHK3G4Z6R1LI
+BuTh/CaSpW7kOWK3ApmsPsYBnYeBheM2YmqRtH19pz/UVjkf01XBrireddUUjC/
1muSK3Yrg0Ww5Ja25mkgI8nPg0gDMBHf3cVd9Fb9iJLt3NmsJS2oEvC2MsPy6Fs7
/T0MO9PHWoVuK2E+rDuKXiphQRNB5+j+LDxgEVgr9/cfO8qPu/gaRwUb81DVCPXL
g0n+FHvoX0mPgU0iBPrFbJ1zl6J5iapUMRO4ZxBMZ6EvHFxAqbhCpGNGixbs6+hR
nBRhoqVz+klW406GWAmiv+Y7Vy/Ia1elgQG8/eY/grby/0Srjpk=
=gZ4i
-----END PGP SIGNATURE-----

--5nv5xths47pkr5ye--
