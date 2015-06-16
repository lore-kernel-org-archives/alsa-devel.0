From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/4] ASoC: Intel - add Skylake HDA audio
	driver
Date: Tue, 16 Jun 2015 11:28:26 +0100
Message-ID: <20150616102826.GF18309@sirena.org.uk>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-3-git-send-email-vinod.koul@intel.com>
 <20150615155632.GU18309@sirena.org.uk>
 <20150616035247.GT28601@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1625013721353531014=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B1E32264ED5
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 12:28:46 +0200 (CEST)
In-Reply-To: <20150616035247.GT28601@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1625013721353531014==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1YtYzP3stTOlsn9I"
Content-Disposition: inline


--1YtYzP3stTOlsn9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2015 at 09:22:47AM +0530, Vinod Koul wrote:
> On Mon, Jun 15, 2015 at 04:56:33PM +0100, Mark Brown wrote:

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

> If we have this is core, I will remove the part :)

You could always send changes to add default ops to the core!

--1YtYzP3stTOlsn9I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVf/pGAAoJECTWi3JdVIfQBFQH/3yi/BnBEZpAxbqTCneqxgT0
oa4Asi5vduaNqiaNac9s2cKTUxING/+YpirVCsgGWzJMUs/OFwGkVkLgHWB65JZc
E48fhJtpe88UwQMBGR2NWKFlh6hxDVf1+sMjNzIqvCsgknzoPRwfS95Dy99ry725
t4VKcXhCJ3zLhN5ZReQ5gTb/MfTlwO9EtWOPD87P9eKkH9UUJeTqeS8GHHgLgcot
VyompijogdxPIU+p4tAEcsHA87T13n5+B+fsYHKjGj3HsJIA3qzDfWVhLjIX3UZf
Oru7DYrMt0CukaKUIonr/4njZ0AU8KLxGqIMStGRMgXAVnajw9B5/OZh2jsB96c=
=RGdT
-----END PGP SIGNATURE-----

--1YtYzP3stTOlsn9I--

--===============1625013721353531014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1625013721353531014==--
