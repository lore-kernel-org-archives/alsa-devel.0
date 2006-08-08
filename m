From: Jochen Voss <voss@seehuhn.de>
Subject: Re: GPIO connections for the M-Audio Revolution 5.1
Date: Tue, 8 Aug 2006 18:20:37 +0100
Message-ID: <20060808172037.GC12347@tarte.seehuhn.de>
References: <20060807203113.GA5305@tarte.seehuhn.de>
	<s5hbqqvr0i6.wl%tiwai@suse.de> <20060808104015.GA20149@seehuhn.de>
	<s5h4pwnqydd.wl%tiwai@suse.de>
	<20060808111850.GB2922@localhost.localdomain>
	<s5hzmefpj2o.wl%tiwai@suse.de>
	<20060808114033.GA3784@tarte.seehuhn.de>
	<s5hpsfbpe9t.wl%tiwai@suse.de>
	<20060808163025.GA12347@tarte.seehuhn.de>
	<s5hr6zrfa1s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0351230312=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hr6zrfa1s.wl%tiwai@suse.de>
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
Cc: ALSA development list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--===============0351230312==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OBd5C1Lgu00Gd/Tn"
Content-Disposition: inline


--OBd5C1Lgu00Gd/Tn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Tue, Aug 08, 2006 at 06:48:31PM +0200, Takashi Iwai wrote:
> What we need next is to write up a code to communicate with ADC chip.
> It could be merged into i2c/other/ak4xxx-adda.c, but it could be a
> standlone implementation as found in aureon.c.

Is the last argument (mask) for AK_COMPOSE the maximum allowed mixer
value?  Is it ok if this is not a power of two?

Many thanks,
Jochen
--=20
http://seehuhn.de/

--OBd5C1Lgu00Gd/Tn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2Mflf+iD8yEbECURAjuXAJ41LcOhfbldJMhrX/9gjE719ogeIQCgmEwM
wRhdYGhZhFIfhbx0q7f+fFU=
=WsUy
-----END PGP SIGNATURE-----

--OBd5C1Lgu00Gd/Tn--


--===============0351230312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0351230312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0351230312==--
