From: Mark Brown <broonie@kernel.org>
Subject: Re:
 =?utf-8?b?562U5aSNOiBbUEFUQ0hdIEFTb0M6IHBhc3Mgc25k?=
 =?utf-8?q?=5Fsoc=5Fjack=5Fgpio_to_jack=5Fstatus=5Fcheck_callback?=
Date: Sat, 22 Feb 2014 12:21:40 +0900
Message-ID: <20140222032140.GW25940@sirena.org.uk>
References: <1392528972-9440-1-git-send-email-xiaoxiang@xiaomi.com>
 <20140218011652.GP2669@sirena.org.uk>
 <C5331076FE79984AAD7207DE353CEA4E40858C60@ex-mbox1.xiaomi.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5825857972370539275=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4840F262634
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 00:36:56 +0100 (CET)
In-Reply-To: <C5331076FE79984AAD7207DE353CEA4E40858C60@ex-mbox1.xiaomi.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?utf-8?B?6IKW57+U?= <xiaoxiang@xiaomi.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5825857972370539275==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lGQpFNrcSq0Rb43w"
Content-Disposition: inline


--lGQpFNrcSq0Rb43w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2014 at 02:20:07PM +0000, =E8=82=96=E7=BF=94 wrote:
> The new parameter isn't used to get the internal field of snd_soc_jack_gp=
io.
> the usage is very like work_struct, here is the demo code:
> struct xxx_priv {
> 	truct snd_soc_jack_gpio gpio;
> };
>=20
> static int xxx_ jack_status_check(struct snd_soc_jack_gpio *gpio)
> {
> 	struct xxx_priv *xxx =3D container_of(gpio, struct xxx_priv, gpio);
> 	......
> }
> Without this parameter, codec driver has to save xxx_priv as a global var=
iable.

OK, this makes sense as a reason for passing the argument in however how
about instead of passing in the structure adding a void * to it which
gets passed as the argument instead?  The user can then assign it to
point to the data they want directly without it looking like they should
be using the private data for the core code.

--lGQpFNrcSq0Rb43w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCBfAAAoJELSic+t+oim97MUP/1OYr17CSoWtrwGbaRzUpnLU
4Lcl8TI0vlRPNGVJsB2Bl6qXsTNUvChe5nGlW6Uiu5pzj8dZza7ZbuuB56NnnQhQ
j0sdAU7lOsG259fkniDKzcYnJP9+F2m/Z6m8DcEcb+zUzTBfoeHxLnjTBOZ2g6vl
Hivq0Pp5FdEjgUqATNQ7X6ikVXumzDjhkyzqxKHSF9SlK04YO3lBZr4/m//fSnHD
RZP6oBOWxRyObk5sZb4dafH1YMPwAJ0527Bk88QBK8oJYfwrBoNhK8eB0tpjIXbH
S4ZX+bn4uoCa7otJccmMmH7qKgBRjm1TSLHgxC/4MOPmaZR75B/n3zuLRQ9XzxhZ
OTmJEa8fgn1HNdOHmp9RjCK01WkC1ioKd+TyhgF4U8eMdX13KacCTZN7+JrCFF8P
6gYDOjxaviHX8clyQMjxbh5H/icEyRLN0XYPDA7W4W0QBCD2OVzgP7RiUrTjkc5X
A7ipTxCqQmIxe3Ww8N6Srjhhh1BX+9Zl3KimtndrPTXQO7r9AfH8c4VWyBpiGYKX
HLs2XBdWjKvfhhQ9T1az7PEwYZNkWn3lwRMV+s5c6mQNKTgsu/hOOZFONEFd1NUj
Bb2A6Ow7cloNMItXaFGGLM0hbo4JJDUkyReI81Z7Qy/+6ywv5a0bjiLSXtuzLhy3
f1ogVOhA1I4s72D6fWp+
=yN05
-----END PGP SIGNATURE-----

--lGQpFNrcSq0Rb43w--

--===============5825857972370539275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5825857972370539275==--
