From: Freddy Spierenburg <freddy@dusktilldawn.nl>
Subject: [PATCH] Fixed broken sound/mips/au1x00.c
Date: Fri, 31 Mar 2006 15:52:54 +0200
Message-ID: <20060331135253.GG4781@dusktilldawn.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v6ieFHm5OYqyo94Y"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tool.snarl.nl (tool.snarl.nl [213.84.251.124])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9972615E
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 15:53:00 +0200 (MEST)
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--v6ieFHm5OYqyo94Y
Content-Type: multipart/mixed; boundary="3Shs6nLsUBL77Lfu"
Content-Disposition: inline


--3Shs6nLsUBL77Lfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jaroslav,

Since kernel version 2.6.16 sound/mips/au1x00.c gives me compile
time errors.

The enclosed patch fixes the compile time errors and the kernel
panic that was also hidden in the code. Now things are working
smoothly again.

Signed-off-by: Freddy Spierenburg <freddy@dusktilldawn.nl>

--=20
$ cat ~/.signature
Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/
GnuPG: 0x7941D1E1=3DC948 5851 26D2 FA5C 39F1  E588 6F17 FD5D 7941 D1E1
$ # Please read http://www.ietf.org/rfc/rfc2015.txt before complain!

--3Shs6nLsUBL77Lfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="au1x00.patch"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.16/sound/mips/au1x00.c	2006-03-20 11:35:39.000000000 +0000
+++ linux-2.6.16-patched/sound/mips/au1x00.c	2006-03-31 12:57:18.000000000 =
+0000
@@ -43,6 +43,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/ac97_codec.h>
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1000_dma.h>
@@ -153,6 +154,7 @@
 {
 	struct snd_pcm_substream *substream =3D stream->substream;
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
+	struct au1000_period *pointer;
 	unsigned long dma_start;
 	int i;
=20
@@ -638,8 +640,6 @@
 	au1000 =3D card->private_data;
 	/* so that snd_au1000_free will work as intended */
 	au1000->card =3D card;
-	au1000->stream[PLAYBACK]->dma =3D -1;
-	au1000->stream[CAPTURE]->dma =3D -1;
  	au1000->ac97_res_port =3D NULL;
 	au1000->stream[PLAYBACK] =3D kmalloc(sizeof(struct audio_stream), GFP_KER=
NEL);
 	au1000->stream[CAPTURE] =3D kmalloc(sizeof(struct audio_stream), GFP_KERN=
EL);
@@ -648,6 +648,8 @@
 		snd_card_free(card);
 		return -ENOMEM;
 	}
+	au1000->stream[PLAYBACK]->dma =3D -1;
+	au1000->stream[CAPTURE]->dma =3D -1;
=20
 	if ((err =3D snd_au1000_ac97_new(au1000)) < 0 ) {
 		snd_card_free(card);

--3Shs6nLsUBL77Lfu--

--v6ieFHm5OYqyo94Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFELTQ1bxf9XXlB0eERAp5jAJ4mArI56n5m5tolaxoRoRNOIgcIIwCg7rD6
6zPXEtNJCvPHnj+RgmbYsbY=
=Zr3d
-----END PGP SIGNATURE-----

--v6ieFHm5OYqyo94Y--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
