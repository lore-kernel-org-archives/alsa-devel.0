From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Tue, 2 Jun 2015 11:42:33 +0100
Message-ID: <20150602104233.GG14071@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
 <20150529174115.GR21577@sirena.org.uk>
 <20150601051358.GI3140@localhost> <s5hy4k46lk1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3923644412540551382=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D301126059E
 for <alsa-devel@alsa-project.org>; Tue,  2 Jun 2015 12:42:37 +0200 (CEST)
In-Reply-To: <s5hy4k46lk1.wl-tiwai@suse.de>
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


--===============3923644412540551382==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Content-Disposition: inline


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 07:32:14AM +0200, Takashi Iwai wrote:
> Vinod Koul wrote:

> > > > +	ret = request_threaded_irq(hda->pci->irq, azx_interrupt,
> > > > +			azx_threaded_handler,
> > > > +			hda->msi ? 0 : IRQF_SHARED,
> > > > +			KBUILD_MODNAME, sbus);

> > > Why not just always request the interrupt as shared - we don't seem to
> > > care in the interrupt handling code?

> > I think we can move this to shared only

> MSI is the exclusive irq, thus shouldn't be shared.

Why does the driver care though?  IRQF_SHARED is advertising the
capabilities of the hander, not a requirement on the hardware - if the
interrupt physically can't be shared then the ability to share it will
never get used but that shouldn't matter.

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbYiYAAoJECTWi3JdVIfQ3EUH/jUoHLI+X9eUWIwpiNkuPtVJ
euwZPXMppN0Xae7ocirpdBW4nfQrCXR3Td3j2AuCYfuS4DOGWFV/fazYrRYacieP
2hF7S9bfEd4CCieaEckj5p1rqm/h73o60sehUOB6IdXVZbrZVXkwCWRJ+WpG4p2A
aBo8OwUFFwO9y9p5DfE849Ns8NpDQ+xDAEBLec6obYcsnQPAg8KjaXxuc1YfakFO
ukZUVBZRETOIf8v/le0cqlEOicp3TmwRaZyMQyAOQUbrT7lL/w5dlk6FPSCA1/aU
Kd4F4FyUPAzNg3u7Ety8kMOW4D5m4QcrtQPiLg4oSDeLTNnwSL7tQFdOGy6W108=
=q8Ym
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--

--===============3923644412540551382==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3923644412540551382==--
