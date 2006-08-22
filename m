From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [PATCH] complete the AK5365 support
Date: Tue, 22 Aug 2006 19:56:59 +0100
Message-ID: <20060822185659.GA3025@tarte.seehuhn.de>
References: <20060808225908.GA22724@tarte.seehuhn.de>
	<s5h3bc6dr0t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1684566316=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Resent-Message-ID: <20060822185736.GB3025@tarte.seehuhn.de>
Resent-To: ALSA development list <alsa-devel@lists.sourceforge.net>
In-Reply-To: <s5h3bc6dr0t.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org


--===============1684566316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Aug 09, 2006 at 02:37:06PM +0200, Takashi Iwai wrote:
> One missing thing I found is that AK5365 isn't in snd_akm4xxx_init().
> When CONFIG_SND_DEBUG=3Dy, this will cause an error message (in
> default: case).  Could you add a proper init sequence there?

Ok, I am back now.  I see that in the mean time somebody added the
following:

diff -ur alsa-driver-1.0.12rc2/alsa-kernel/i2c/other/ak4xxx-adda.c alsa-dri=
ver-1.0.12rc3/alsa-kernel/i2c/other/ak4xxx-adda.c
--- alsa-driver-1.0.12rc2/alsa-kernel/i2c/other/ak4xxx-adda.c   2006-08-08 =
23:53:09.000000000 +0100
+++ alsa-driver-1.0.12rc3/alsa-kernel/i2c/other/ak4xxx-adda.c   2006-08-14 =
11:55:24.000000000 +0100
@@ -137,6 +137,8 @@
        case SND_AK4381:
                ak4381_reset(ak, state);
                break;
+       default:
+               break;
        }
 }
=20

=46rom the data sheet of the chip it seems to me that there is no way to
initialise the chip via register settings.  Should I add a procedure which
writes the default values from the data sheet to all registers instead?
Or is the current way (doing nothing) ok?

All the best,
Jochen
--=20
http://seehuhn.de/

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE61N7f+iD8yEbECURAszMAJ9AgKrceH1AmK9kskZ1wfgwsLIaZACfSDhw
8hby+6DFYg9h1Z0qr3pSqp8=
=kGyZ
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--


--===============1684566316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1684566316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1684566316==--
