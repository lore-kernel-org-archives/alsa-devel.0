From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: HDA codec in embedded device
Date: Thu, 31 May 2012 18:52:23 +0200
Message-ID: <20120531165223.GA11723@avionic-0098.mockup.avionic-design.de>
References: <20120531061302.GA11605@avionic-0098.adnet.avionic-design.de>
	<4FC7960D.6000405@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8456299371744415253=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C1A3104440
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2012 18:52:26 +0200 (CEST)
In-Reply-To: <4FC7960D.6000405@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8456299371744415253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Warren wrote:
> On 05/31/2012 12:13 AM, Thierry Reding wrote:
> > Hi,
> >=20
> > I work on an Atom-based platform that uses a Realtek ALC892 codec conne=
cted
> > via HDA. The current code in patch_realtek.c seems to assume a standard
> > desktop setup and maps the ports accordingly. The setup that I have is
> > entirely different and involves, among other things, to reconfigure som=
e of
> > the ports typically used as outputs as inputs and vice versa. It'll als=
o need
> > to provide a way to pass through some inputs on the outputs without goi=
ng
> > through the DAC.
> >=20
> > All of these features are supported by the ALC982, but I don't see how =
this
> > could be implemented with the current driver. My question is how this c=
ould
> > possibly be solved in a way acceptable for mainline?
>=20
> The way I solved this was to add a machine-specific fixup rto
> alc269_fixups[] that set up the pin default registers as required by the
> HW prior to the parser interpreting those fields. I assume the same
> would work on the alc982.

I've been discussing this with some people internally and we came to the
conclusion that for embedded setups the best option might be to expose all
possible controls and use something like the ALSA UCM to configure the
codec to cover the different muxing options required by the setup.

> I think in general as Takashi mentioned, the driver assumes that the pin
> default registers are already set up to values correct for the HW.
> Typically, I believe this is done by the SBIOS or audio card BIOS prior
> to the OS starting, or perhaps by EEPROM/straps in the HW. Is there a
> way that can be made to happen?

Unfortunately we don't have access to the BIOS sources, and I believe there
are no options to set them externally. I think the BIOS doesn't even do
anything to those registers.

One other interesting option would be to encode this in the device tree. I'=
ve
been investigating to use the device tree in order to describe carrier board
differences to allow a single kernel to boot the same processor module on
different carrier boards (the processor module could be different as well, =
of
course).

This is obviously common practice on ARM but x86 is lacking a bit in this
respect. I currently have a setup where I can associated device nodes with
devices behind the PCI bus to configure I2C slaves and such. The same should
be possible with HDA and codec configuration.

Thierry

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk/HoccACgkQZ+BJyKLjJp9kugCggXezihmtmtZ4IvSEULnhjgbP
3JIAnR0+vxDi6SidTBZz5fnG7xSVAb6R
=oo+r
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--

--===============8456299371744415253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8456299371744415253==--
