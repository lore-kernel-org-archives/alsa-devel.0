From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Tue, 2 Jun 2015 11:45:16 +0100
Message-ID: <20150602104516.GH14071@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
 <20150529174115.GR21577@sirena.org.uk>
 <s5h4mmv9r7m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0919468100893607679=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6509F260517
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 12:45:21 +0200 (CEST)
In-Reply-To: <s5h4mmv9r7m.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0919468100893607679==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nywXBoy70X0GaB8B"
Content-Disposition: inline


--nywXBoy70X0GaB8B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2015 at 08:25:01PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > +/* PCI register access. */
> > > +static void pci_azx_writel(u32 value, u32 __iomem *addr)
> > > +{
> > > +	writel(value, addr);
> > > +}

> > These wrappers are setting off alarm bells - why can't we just use the
> > called functions directly, and given the parameters (which have just a
> > raw pointer and value) what else could the implementation be?

> Tegra has no direct byte access but only aligned 32bit accesses.
> That's why we have the redirection.

Ugh, and the functions are macros so can't be used directly.  I'd still
expect to see these ops be defined in some central place and reused.

--nywXBoy70X0GaB8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbYk7AAoJECTWi3JdVIfQh/0H/jvBg9W/VG9hGZ9vbmNA5yPD
p7gTmKjFXQ7Tdd8KbD5iDbkHNoM5P7a7qnRkGaOadgYGiVmEU4OvLjOWezJhNMvy
rpeONW7IQO67VXpjB4ugDWZe83z9fEo+Zhx+IdOtOR5r7dl95ZIEm+lskfUt3NkM
DsCGWp88kl0A03yehRnCgjY5mf8EooMVGDWd8nx/aQx2KDbSIGWlTEwRbxuURPhH
hVlNSH3JnOoFqezutvrW/HSQrRcud4dSutxMaD4V95mdrWj+Eh/0uVtbqU0CEr8/
WhXt3wqM6ItzitUNuQ1urTxnDf4P7bMtMUjy6KeNrIcww7mHWT5qshfuuZy2UAA=
=Gux4
-----END PGP SIGNATURE-----

--nywXBoy70X0GaB8B--

--===============0919468100893607679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0919468100893607679==--
