From: Jochen Voss <voss@seehuhn.de>
Subject: Re: GPIO connections for the M-Audio Revolution 5.1
Date: Tue, 8 Aug 2006 17:52:32 +0100
Message-ID: <20060808165231.GB12347@tarte.seehuhn.de>
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
Content-Type: multipart/mixed; boundary="===============0630382242=="
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


--===============0630382242==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Tue, Aug 08, 2006 at 06:48:31PM +0200, Takashi Iwai wrote:
> OK, this implies that CS0 is for DAC and CS1 for ADC.  CS2 isn't used,
> so basically it doesn't matter to be set or not.
I agree.

> What we need next is to write up a code to communicate with ADC chip.
> It could be merged into i2c/other/ak4xxx-adda.c, but it could be a
> standlone implementation as found in aureon.c.
Yes, I am currently looking at ak4xxx-adda.c.
I will see what I can do and report the result later.

Many thanks for your help,
Jochen
--=20
http://seehuhn.de/

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2MFPf+iD8yEbECURAj8QAJ4tHUlGj4AR5hj3YcMf0zQANnEoVQCeKLUq
H8cxzQ6r1kYZ0z99XjxfL5Q=
=w2Hx
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--


--===============0630382242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0630382242==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0630382242==--
