From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Mon, 13 Feb 2012 22:06:28 -0800
Message-ID: <20120214060627.GB13456@opensource.wolfsonmicro.com>
References: <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202085521.GB9773@S2101-09.ap.freescale.net>
 <20120202091132.GD9773@S2101-09.ap.freescale.net>
 <20120202092427.GB32403@b20223-02.ap.freescale.net>
 <20120202130901.GE9773@S2101-09.ap.freescale.net>
 <20120202135805.GB3015@richard-laptop>
 <20120203021554.GE32403@b20223-02.ap.freescale.net>
 <20120203133240.GB12915@S2101-09.ap.freescale.net>
 <a9d9bad3-edd0-4a5f-9bb3-15787430d858@email.android.com>
 <20120214013506.GA3276@b20223-02.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120214013506.GA3276@b20223-02.ap.freescale.net>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <richard.zhao@freescale.com>
Cc: Richard Zhao <richard.zhao@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org, kernel@pengutronix.de, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, eric.miao@linaro.org, eric@eukrea.com, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2012 at 09:35:07AM +0800, Richard Zhao wrote:
> On Sun, Feb 05, 2012 at 12:50:15PM +0800, Richard Zhao wrote:

> > no, it is asoc machine driver to have machine specific code.=20
> > the machine driver do not correspond to any hw device, which cause hard
> > to bind dt or create platform device.

> I'll have to keep audmux driver in arch/, till ASOC machine driver
> has a way to get platfrom parameters.

Machine drivers can easily get platform data, they're just regular
drivers of whatever type so can get platform data in the same way that
any other driver for their bus can.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPOfmkAAoJEBus8iNuMP3dnRQQAJyGTi2uSzQ/Y7Pa8drwExCx
ZdMxeS6zi+Sis0UYl5nuoqP+cBV4JaQiVa4x0xuGUyN2L6pz30q4MIPlpq5V8iUs
wsIWtP9z3LCvUJTmVKcA1eLCSmayh1uAer1l4KzMP21EzlbjlI6O6jHIekGD7/kv
8a9FEmptwyQn83Gc430FaFvIbPTtP/Et1ZEQ0/235M6EJTzNjyk+A9J+9w9vLDoe
7YbPxPGerNdTnAjfr6xoq/e9s5Nlozmrv0CzvSHAST8EWr2G1tino8HiNWIKS5N1
4chgYbquQaq6jWw4ni+PblCKTx7ly0B+GB5kScUeBzKWv8/deCk4mrHAqBAPnVKy
fZnyu7HxANPZx6qQ5JBjsF2i8kN1owLLslNTFSOsaLIEBcGrwMBjg3KODdpnXJ+m
DTHhdcnv0nUGKK9Hbzro5/W9VtIAcm4C/RE5kDHjzDRA7mTgVdtotaX6gA7rdu0O
o/X4tiKVrdJWpz0P6nS8drMOXEy3oqG7Vvl98F+kmZaTJrBK6vl/5vIH3P4DJ5/W
C4nJ/h0EW+VbD1Q34cBbsz+++mPtrpUO84/xkBwbkwtbviaZeNZtvTdhfWe5FRJu
mNAz2bNVKjt7YAnSx//akmTwo5xkv9rZZ1vbd8hVvbSYjYHOAsTaw3AvuWp8wx7x
XERBCK7GYYP9daHbre8e
=Od6n
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
