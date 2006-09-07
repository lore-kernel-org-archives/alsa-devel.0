From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Thu, 7 Sep 2006 12:00:30 +0100
Message-ID: <20060907110027.GA3030@tarte.seehuhn.de>
References: <s5hveo4kl5q.wl%tiwai@suse.de>
	<20060904111303.GA24842@localhost.localdomain>
	<20060904174121.GA4736@quiche.seehuhn.de>
	<s5hpsebjxkf.wl%tiwai@suse.de>
	<20060904192738.GA16291@tarte.seehuhn.de>
	<s5h8xkyk631.wl%tiwai@suse.de>
	<20060905192453.GA2537@tarte.seehuhn.de>
	<s5hr6yokmym.wl%tiwai@suse.de>
	<20060907102954.GA17846@localhost.localdomain>
	<s5hirk0klu9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1556705200=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hirk0klu9.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1556705200==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

On Thu, Sep 07, 2006 at 12:33:18PM +0200, Takashi Iwai wrote:
> Yes.  Then we need to take the controls back to a single one.
> Will do later.
Ok.

> I still wonder whether this is also true for AK4524...
No idea about this, I do not have an AK4524 so I cannot test.

> > > Also, it's possible that I did make a silly mistake.  Put a debug
> > > printk around ak->ops.write() in snd_akm4xxx_write() to check what
> > > values are written to register 4 and 5.
> >=20
> > I will try this in the evening.

This sounded more fun than the simulation I am supposed to do for work,
so I sneaked away and did this first ;-)

I used the following printk:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- ak4xxx-adda.c~      2006-08-31 01:00:11.000000000 +0100
+++ ak4xxx-adda.c       2006-09-07 11:49:57.394999424 +0100
@@ -40,6 +40,9 @@
                       unsigned char val)
 {
        ak->ops.lock(ak, chip);
+       if (ak->type =3D=3D SND_AK5365 && (reg=3D=3D4 || reg=3D=3D5)) {
+         printk (KERN_INFO "reg%d <- %02x\n", reg, val);
+       }
        ak->ops.write(ak, chip, reg, val);
=20
        /* save the data */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Results from my second test (s2.sh vs s3.sh):

s2.sh: The commands

    amixer set "PCM Capture Gain" 0
    amixer set "PCM Capture Gain" 20
    amixer set "PCM" 0
    amixer set "PCM" 80%

translate into

    reg4 <- 80
    reg5 <- 80
    reg4 <- 94
    reg5 <- 94
    reg4 <- 00
    reg5 <- 00
    reg4 <- 5e
    reg5 <- 5e

s3.sh: The commands

    amixer set "PCM" 0
    amixer set "PCM" 80%
    amixer set "PCM Capture Gain" 0
    amixer set "PCM Capture Gain" 20

translate into

    reg4 <- 00
    reg5 <- 00
    reg4 <- 5e
    reg5 <- 5e
    reg4 <- 80
    reg5 <- 80
    reg4 <- 94
    reg5 <- 94

This seems to be the expected register assignments.  As stated before,
these settings lead to different recording volume.

All the best,
Jochen
--=20
http://seehuhn.de/

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE//vLf+iD8yEbECURAs8wAKCOZdVzW96hM5LDLjgIjYkLxcKkEACfcAWe
CsUt9SGOWIyXmBq/VVPija4=
=zwt4
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--


--===============1556705200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1556705200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1556705200==--
