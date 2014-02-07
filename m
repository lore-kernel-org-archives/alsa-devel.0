From: Rashika Kheria <rashika.kheria@gmail.com>
Subject: [PATCH 2/3] sound: Remove unused function in pci/lx6464es/lx_core.c
Date: Fri, 7 Feb 2014 22:14:03 +0530
Message-ID: <099f48122fb7ac04f0224f76ed1a9d6e6ef8652d.1391791103.git.rashika.kheria@gmail.com>
References: <512472c7d96cf1c239ba3d0bc517891a7c2f9da1.1391791103.git.rashika.kheria@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <512472c7d96cf1c239ba3d0bc517891a7c2f9da1.1391791103.git.rashika.kheria@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rashika Kheria <rashika.kheria@gmail.com>, alsa-devel@alsa-project.org, josh@joshtriplett.org
List-Id: alsa-devel@alsa-project.org

Remove unused function in pci/lx6464es/lx_core.c.

This eliminates the following warning in pci/lx6464es/lx_core.c:
sound/pci/lx6464es/lx_core.c:144:5: warning: no previous prototype for =
=E2=80=98lx_plx_mbox_read=E2=80=99 [-Wmissing-prototypes]
sound/pci/lx6464es/lx_core.c:172:5: warning: no previous prototype for =
=E2=80=98lx_plx_mbox_write=E2=80=99 [-Wmissing-prototypes]
sound/pci/lx6464es/lx_core.c:494:5: warning: no previous prototype for =
=E2=80=98lx_dsp_es_check_pipeline=E2=80=99 [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 sound/pci/lx6464es/lx_core.c |   84 ----------------------------------=
--------
 1 file changed, 84 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.=
c
index 626ecad..df4044d 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -141,63 +141,6 @@ void lx_plx_reg_write(struct lx6464es *chip, int p=
ort, u32 data)
 	iowrite32(data, address);
 }
=20
-u32 lx_plx_mbox_read(struct lx6464es *chip, int mbox_nr)
-{
-	int index;
-
-	switch (mbox_nr) {
-	case 1:
-		index =3D ePLX_MBOX1;    break;
-	case 2:
-		index =3D ePLX_MBOX2;    break;
-	case 3:
-		index =3D ePLX_MBOX3;    break;
-	case 4:
-		index =3D ePLX_MBOX4;    break;
-	case 5:
-		index =3D ePLX_MBOX5;    break;
-	case 6:
-		index =3D ePLX_MBOX6;    break;
-	case 7:
-		index =3D ePLX_MBOX7;    break;
-	case 0:			/* reserved for HF flags */
-		snd_BUG();
-	default:
-		return 0xdeadbeef;
-	}
-
-	return lx_plx_reg_read(chip, index);
-}
-
-int lx_plx_mbox_write(struct lx6464es *chip, int mbox_nr, u32 value)
-{
-	int index =3D -1;
-
-	switch (mbox_nr) {
-	case 1:
-		index =3D ePLX_MBOX1;    break;
-	case 3:
-		index =3D ePLX_MBOX3;    break;
-	case 4:
-		index =3D ePLX_MBOX4;    break;
-	case 5:
-		index =3D ePLX_MBOX5;    break;
-	case 6:
-		index =3D ePLX_MBOX6;    break;
-	case 7:
-		index =3D ePLX_MBOX7;    break;
-	case 0:			/* reserved for HF flags */
-	case 2:			/* reserved for Pipe States
-				 * the DSP keeps an image of it */
-		snd_BUG();
-		return -EBADRQC;
-	}
-
-	lx_plx_reg_write(chip, index, value);
-	return 0;
-}
-
-
 /* rmh */
=20
 #ifdef CONFIG_SND_DEBUG
@@ -491,33 +434,6 @@ int lx_dsp_read_async_events(struct lx6464es *chip=
, u32 *data)
 #define CSES_BROADCAST      0x0002
 #define CSES_UPDATE_LDSV    0x0004
=20
-int lx_dsp_es_check_pipeline(struct lx6464es *chip)
-{
-	int i;
-
-	for (i =3D 0; i !=3D CSES_TIMEOUT; ++i) {
-		/*
-		 * le bit CSES_UPDATE_LDSV est =C3=83=C2=A0 1 d=C3=83=C2=A9s que le =
macprog
-		 * est pret. il re-passe =C3=83=C2=A0 0 lorsque le premier read a
-		 * =C3=83=C2=A9t=C3=83=C2=A9 fait. pour l'instant on retire le test =
car ce bit
-		 * passe a 1 environ 200 =C3=83=C2=A0 400 ms apr=C3=83=C2=A9s que le=
 registre
-		 * confES =C3=83=C2=A0 =C3=83=C2=A9t=C3=83=C2=A9 =C3=83=C2=A9crit (k=
ick du xilinx ES).
-		 *
-		 * On ne teste que le bit CE.
-		 * */
-
-		u32 cses =3D lx_dsp_reg_read(chip, eReg_CSES);
-
-		if ((cses & CSES_CE) =3D=3D 0)
-			return 0;
-
-		udelay(1);
-	}
-
-	return -ETIMEDOUT;
-}
-
-
 #define PIPE_INFO_TO_CMD(capture, pipe)					\
 	((u32)((u32)(pipe) | ((capture) ? ID_IS_CAPTURE : 0L)) << ID_OFFSET)
=20
--=20
1.7.9.5
