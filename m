From: Jochen =?iso-8859-1?B?Vm/f?= <voss@maths.warwick.ac.uk>
Subject: Re: [RFC] Add dB scale information to AK4xxx codec
Date: Mon, 4 Sep 2006 12:13:06 +0100
Message-ID: <20060904111303.GA24842@localhost.localdomain>
References: <s5hlkp96qfm.wl%tiwai@suse.de>
	<20060903155357.GA10408@tarte.seehuhn.de>
	<s5hveo4kl5q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0585033378=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hveo4kl5q.wl%tiwai@suse.de>
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


--===============0585033378==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Mon, Sep 04, 2006 at 11:58:57AM +0200, Takashi Iwai wrote:
> > From table 17 (page 35) of the AK5365 specs I think that IPGA and DATT
> > are only separate units inside the chip, but should be treated as one
> > continuous scale for the purpose of the driver.  The table looks like
> > the input volume can be adjusted in steps from "mute" to +12dB.  Why
> > would we want two controls here?
>=20
> Actually they are treated independently in the chip.  IPGA works like
> a preamp, and the total volume is IPGA + DATT.  Even if you set a
> value to IPGA with MSB, say 0x82, DATT won't be changed and the old
> value is kept.  And it's vice versa - if you set 0x02 later, IPGA will
> stay as 0x82.  This is so, at least with AK4524 and AK4528.  Possibly
> this was changed on AK5365, though...
Did you have a look at table 17?  I think the old behaviour was better.

> Hm, there is no "PCM Capture Gain Capture", maybe "PCM Capture Gain
> Volume"?  It's IPGA.
I will send the amixer output this evening when I get back home.

All the best,
Jochen
--=20
http://www.maths.warwick.ac.uk/~voss/

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE/Ao/f+iD8yEbECURAol8AJ9a96ke2utvlEa046YKiMLGPJg0+wCeLmb6
ywmqZsq1yyikYPQywNwmCbc=
=WRRl
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--


--===============0585033378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0585033378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0585033378==--
