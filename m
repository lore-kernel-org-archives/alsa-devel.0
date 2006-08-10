From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [PATCH] complete the AK5365 support
Date: Thu, 10 Aug 2006 22:00:39 +0100
Message-ID: <20060810210016.GA23475@localhost.localdomain>
References: <20060808225908.GA22724@tarte.seehuhn.de>
	<s5h3bc6dr0t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1425230576=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1425230576==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Aug 09, 2006 at 02:37:06PM +0200, Takashi Iwai wrote:
> One missing thing I found is that AK5365 isn't in snd_akm4xxx_init().
> When CONFIG_SND_DEBUG=3Dy, this will cause an error message (in
> default: case).  Could you add a proper init sequence there?

Currently I am travelling, with no good internet connection and no
access to the machine in question.  I will prepare something in
once I am back (in two weeks or so).

All the best and sorry about the delay,
Jochen
--=20
http://seehuhn.de/

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE255gf+iD8yEbECURAsQlAJsEW479Mss5t3P0sGHlFMlese3r9QCgiPdk
HlwmipIvbXXvz1NjJ7B9+ts=
=Hq3X
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--


--===============1425230576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1425230576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1425230576==--
