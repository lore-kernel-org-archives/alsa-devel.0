From: Jochen Voss <voss@seehuhn.de>
Subject: Re: M-Audio Revolution 5.1 - new hardware information
Date: Sat, 30 Sep 2006 21:05:57 +0100
Message-ID: <20060930200557.GB4876@seehuhn.de>
References: <20060929223217.GA5624@tarte.seehuhn.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1682366496=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <20060929223217.GA5624@tarte.seehuhn.de>
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


--===============1682366496==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Sep 29, 2006 at 11:32:17PM +0100, Jochen Voss wrote:
> 1. Input channels:
>=20
>   [...]
>=20
>   It would be nice if the ALSA driver would get a control to select
>   the input channel (it just needs to allow to set the lower three
>   bits of register 0x01).  This should be easy.

The patch I sent separately solves this problem.

> 2. PT2258 Volume Controller:
>=20
>   [...]
>=20
>   So we can control this volume controller by playing with GPIO 6 and
>   7.  This project will be a bit more challenging.  One has to shift
>   the data to the chip bit by bit, we have to use pin 6 as the clock
>   (max 100kbit/s), pin 7 is only allowed to change while 6 is low and
>   the chip read the data while 6 is high.  After every byte the chips
>   sends back one acknoledge bit.  And the chip wants a 200ms delay
>   after power up.  The data sheet is at
>=20
>         http://www.princeton.com.tw/webSite/downloadprocess/downloadfile.=
asp?mydownload=3DPT2258_2.pdf
>=20
>   It would be nice if the ALSA driver would allow access to these
>   volume controls.

I will need a bit of help with this.  Is there any driver which
implements a similar serial protocol which I could look at to learn
how to do this?

Many thanks,
Jochen
--=20
http://seehuhn.de/

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFHs4lmQikLRypuYcRAq4JAKDCA816RXyDpxk+W+HSuiaQyKXtXgCgh1UZ
UJ0AIVNXKRBFWizHjUVQz/k=
=6T8P
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--


--===============1682366496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1682366496==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1682366496==--
