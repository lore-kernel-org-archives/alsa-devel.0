From: Craig Shelley <craig@microtron.org.uk>
Subject: HP Pavilion dv5000 ATIIXP / AC97 fixes?
Date: Fri, 14 Sep 2007 22:08:47 +0100
Message-ID: <1189804127.24267.33.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6406013155584860843=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.etheus.net (prometheus.etheus.net [88.96.216.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 91371243FD
	for <alsa-devel@alsa-project.org>;
	Fri, 14 Sep 2007 23:08:49 +0200 (CEST)
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
Cc: tiwai@suse.de, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


--===============6406013155584860843==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OD36ybX5G7R+CZ2eKL9g"


--=-OD36ybX5G7R+CZ2eKL9g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I am not on this list, so please cc me on replies...

With kernel version 2.6.22.3 I found 2 issues with the audio that were
solved by applying the patches below. Please note that this is most
likely not the correct fix for these issues.



To make the mute LED work on the mute button:

diff -Nru a/sound/pci/atiixp.c b/sound/pci/atiixp.c
--- a/sound/pci/atiixp.c        2007-09-14 15:21:32.000000000 +0100
+++ b/sound/pci/atiixp.c        2007-09-14 20:56:27.000000000 +0100
@@ -1389,6 +1389,12 @@
                .name =3D "HP nx6125",
                .type =3D AC97_TUNE_MUTE_LED
        },
+       {
+               .subvendor =3D 0x103c,
+               .subdevice =3D 0x30a4,
+               .name =3D "HP Pavilion dv5000",
+               .type =3D AC97_TUNE_HP_MUTE_LED
+       },
        { } /* terminator */
};


To stop the loud pop/click sound on suspend/resume:

diff -Nru a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
--- a/sound/pci/ac97/ac97_codec.c       2007-08-15 17:25:39.000000000
+0100
+++ b/sound/pci/ac97/ac97_codec.c       2007-09-14 21:08:40.000000000
+0100
@@ -2287,7 +2287,7 @@
        power |=3D AC97_PD_PR0 | AC97_PD_PR1;     /* ADC & DAC powerdown
*/
        snd_ac97_write(ac97, AC97_POWERDOWN, power);
        udelay(100);
-       power |=3D AC97_PD_PR2 | AC97_PD_PR3;     /* Analog Mixer
powerdown */
+       power |=3D AC97_PD_PR2;   /* Analog Mixer powerdown */
        snd_ac97_write(ac97, AC97_POWERDOWN, power);
        if (ac97_is_power_save_mode(ac97)) {
                udelay(100);


The loud pop/click sound appeared after upgrading from kernel 2.6.16.2
to 2.6.22.3, and the critical difference between these versions is:

2.6.16.2: (ac97_codec.c line 2135)
power |=3D 0x0400;        /* Analog Mixer powerdown (Vref on) */

2.6.22.3: (ac97_codec.c line 2290)
power |=3D AC97_PD_PR2 | AC97_PD_PR3;     /* Analog Mixer powerdown */

Where:
#define AC97_PD_PR2 0x0400 /* Power down Mixer (Vref still on) */
#define AC97_PD_PR3 0x0800 /* Power down Mixer (Vref off) */

My guess is that this loud click may be caused by some kind of DC offset
because an equivalent noise occurs while rebooting after hibernating
using hibernate -r

regards,

--=20
Craig Shelley
EMail: craig@microtron.org.uk
Jabber: shell@jabber.earth.li

--=-OD36ybX5G7R+CZ2eKL9g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG6vhf5OI9vmOoVqERAo71AJ951r22V1cgvYPqsn1okKV+TA5L4wCgrhfr
iIWakIkeLZLwDHrHWLJvfcI=
=jkMS
-----END PGP SIGNATURE-----

--=-OD36ybX5G7R+CZ2eKL9g--


--===============6406013155584860843==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6406013155584860843==--
