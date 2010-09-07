From: Frank Becker <fb@alien8.de>
Subject: Re: commit 7b2bfdb broke sound card detection on my
	Lenovo T400s
Date: Tue, 7 Sep 2010 11:40:41 +0200
Message-ID: <20100907094041.GA2815__46147.4166637801$1283934087$gmane$org@alien8.de>
References: <20100906170421.GA2957@alien8.de>
	<20100906224548.GA27279@taprogge.org>
	<s5hlj7ew0ph.wl%tiwai@suse.de> <20100907090220.GA3204@alien8.de>
	<s5h7hixap1c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0084443503968146334=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h7hixap1c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: bp@alien8.de, Jens Taprogge <jens.taprogge@taprogge.org>, linux-kernel@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============0084443503968146334==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Takashi Iwai [2010-09-07, 11:20 +0200]:
> At Tue, 7 Sep 2010 11:02:20 +0200,
> Frank Becker wrote:
> >=20
> > Takashi Iwai [2010-09-07, 08:17 +0200]:
> > > At Tue, 7 Sep 2010 00:45:48 +0200,
> > > Jens Taprogge wrote:
> > > >=20
> > > > On Mon, Sep 06, 2010 at 07:04:21PM +0200, Frank Becker wrote:

Hi,

[...]
> machine.  Anyway, I don't see why Jens' patch breaks your machine.
> The PCI SSID (not codec SSID) of his machine is 17aa:215e while yours
> is 17aa:20f2.  The breakage can be a coincidence.
>=20
> Could you check whether model=3Dthinkpad works better?
Works as model=3Dideapad IOW, yes that works perfectly well.

> If yes, we can simply add the new entry for your device.
Great. Thank you.

Bye,

    Frank

--=20
Frank Becker <fb@alien8.de> (jabber|mail) | http://twitter.com/41i3n8
GnuPG: 0xADC29ECD | F01B 5E9C 1D09 981B 5B40 50D3 C80F 7459 ADC2 9ECD
SILC-Net: a8 | Home: http://www.alien8.de | <<</>> http://www.c3d2.de
"> Freedom is just chaos, with better lighting. <"  Alan Dean  Foster

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEARECAAYFAkyGCJYACgkQyA90Wa3Cns3nOQCeOiksdBiYlO2kUYZ2bXcOiU1c
4U4AmLAgQbtUl968OArVy9j8wQaowUc=
=aywi
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============0084443503968146334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============0084443503968146334==--
