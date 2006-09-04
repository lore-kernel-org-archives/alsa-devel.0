From: Jochen Voss <voss@seehuhn.de>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Mon, 4 Sep 2006 18:41:24 +0100
Message-ID: <20060904174121.GA4736@quiche.seehuhn.de>
References: <s5hlkp96qfm.wl%tiwai@suse.de>
	<20060903155357.GA10408@tarte.seehuhn.de>
	<s5hveo4kl5q.wl%tiwai@suse.de>
	<20060904111303.GA24842@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1411787019=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060904111303.GA24842@localhost.localdomain>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============1411787019==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Mon, Sep 04, 2006 at 12:13:06PM +0100, Jochen Vo=DF wrote:
> > Hm, there is no "PCM Capture Gain Capture", maybe "PCM Capture Gain
> > Volume"?  It's IPGA.
> I will send the amixer output this evening when I get back home.

Ok, it seems to be a problem with alsamixer (maybe caused by the fact
that I still used v1.0.11).  The amixer output looks better and does
not have the strange "PCM Capture Gain Capture".  My apologies for the
confusion caused.

All the best,
Jochen
--=20
http://seehuhn.de/

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/GVBf+iD8yEbECURAnOrAJ9RJKzBK7bwwMs7G9SA+NKe9to0bACePSH/
P6Y5w5toywgMUSEgQ43GWko=
=S9Hk
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--


--===============1411787019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1411787019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1411787019==--
