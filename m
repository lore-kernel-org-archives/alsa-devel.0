From: Jochen Voss <voss@seehuhn.de>
Subject: Re: GPIO connections for the M-Audio Revolution 5.1
Date: Tue, 8 Aug 2006 12:40:33 +0100
Message-ID: <20060808114033.GA3784@tarte.seehuhn.de>
References: <20060807203113.GA5305@tarte.seehuhn.de>
	<s5hbqqvr0i6.wl%tiwai@suse.de> <20060808104015.GA20149@seehuhn.de>
	<s5h4pwnqydd.wl%tiwai@suse.de>
	<20060808111850.GB2922@localhost.localdomain>
	<s5hzmefpj2o.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1058611975=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzmefpj2o.wl%tiwai@suse.de>
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


--===============1058611975==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Tue, Aug 08, 2006 at 01:23:27PM +0200, Takashi Iwai wrote:
> > AK5365, according to the spec (page 21) this one has volume control.
> > Maybe recording is just a matter of putting the volume up on this
> > chip?
>=20
> Ah, then 0x80 makes sense.  It's possibly a chip-select for that ADC
> chip.

I took out the card and had another look.  I don't have any measuring
equipment, so I am limited to staring at the board.  It might be, that
GPIO pin 0x80 is connected to pin 33 (CSN/CAD1) of the AK5365.  Would
this make sense?

Do you know whether the card uses 3-wire control or I2C?

Many thanks,
Jochen
--=20
http://seehuhn.de/

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2Hgxf+iD8yEbECURAtbeAJwMTHoG6yGFlip05E9dKT7FcGpkzACeP8Ip
08IQ4xtG5IPgCYmBBoFtjxQ=
=B2Va
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--


--===============1058611975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1058611975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1058611975==--
