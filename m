From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/4] ASoC: Intel - add Skylake HDA audio
	driver
Date: Mon, 15 Jun 2015 17:42:02 +0100
Message-ID: <20150615164202.GW18309@sirena.org.uk>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-3-git-send-email-vinod.koul@intel.com>
 <20150615155632.GU18309@sirena.org.uk>
 <s5hoakhexq3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8034854994687143537=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F10D265259
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 18:42:15 +0200 (CEST)
In-Reply-To: <s5hoakhexq3.wl-tiwai@suse.de>
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


--===============8034854994687143537==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nqu5fpgjE+BQlEdo"
Content-Disposition: inline


--nqu5fpgjE+BQlEdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2015 at 06:35:16PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Thu, Jun 11, 2015 at 10:03:56PM +0530, Vinod Koul wrote:

> > > +	for (i = 0; i < num_stream; i++) {
> > > +		struct hdac_ext_stream *stream =
> > > +				kzalloc(sizeof(*stream), GFP_KERNEL);

> > Still not sure why these are Sky Lake specific?

> Currently the allocation and the free of each HDA(-ext) stream are
> left to each controller driver.  (See the stream object is embedded.)

It looks awfully like it's dynamically allocated here...

> And, yes, the allocation (especially the assignment of the stream tag)
> *is* SKL specific.  SKL has some twists in the interpretation of
> HD-audio spec.

I can see the thing calling these functions being driver specific but as
far as I can see all these are doing is allocating structs, initialising
them with passed in parameters, putting them on a list and calling a
core function on them.  It's not the bit taking the decisions, it's just
doing mechanical things.

> > > +	snd_hdac_bus_stop_chip(bus);
> > > +	snd_hdac_bus_enter_link_reset(bus);
> > > +	if (bus->irq >= 0) {
> > > +		free_irq(bus->irq, bus);

> > Why are we freeing the interrupt over suspend?  That is very unusual
> > behaviour.

> Believe or not, a PCI controller may reassign to a different IRQ
> number after hibernation.  This really happened in the past for some
> old stuff, hence we have this in the legacy driver.

> But SKL won't need this, I suppose.

Do you mean PCI controller or BIOS here?

> > > +static const struct hdac_io_ops skl_io_ops = {
> > > +	.reg_writel = skl_pci_writel,
> > > +	.reg_readl = skl_pci_readl,
> > > +	.reg_writew = skl_pci_writew,
> > > +	.reg_readw = skl_pci_readw,
> > > +	.reg_writeb = skl_pci_writeb,
> > > +	.reg_readb = skl_pci_readb,
> > > +	.dma_alloc_pages = skl_dma_alloc_pages,
> > > +	.dma_free_pages = skl_dma_free_pages,
> > > +};

> > Still not thrilled at open coding these wrappers.

> This is not so sexy, right, but be patient until the next HDA core
> code rewrite.

Or we could add the ops to the core now and convert the drivers later?

--nqu5fpgjE+BQlEdo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfwBZAAoJECTWi3JdVIfQOfEH/3U7g7qJjWEnUxFkXF55UQSW
azS7tux/xBH1D/6J8cP0W2HnbBm3z4JZeOrJ2cJxzR53kWjzMhVNYfSgnqgS+uWj
wyQYQQ8vfY22aHj2k21MiFIjyd1YKjorgiESeD2KDRQx3BXRTm0STVJwB5BPsrsh
zkksqB7yBOzRxMIGK7FJ7LsUFmPIcjGDmA1ASeo5wVApJ8sIycvMCVX2gesmnRFG
ZTsk+9uq7tgfdeRt2snJ9wd6D45rYGex5QcnWZ9Byz5J4bHN4901IRz+TR83589p
ZiV8RfDhiwO+nb83Z1Q4KwUOqf38c/gUdit+rMfMXRxyYE6hxwBa/6g27i6zsmk=
=zOGZ
-----END PGP SIGNATURE-----

--nqu5fpgjE+BQlEdo--

--===============8034854994687143537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8034854994687143537==--
