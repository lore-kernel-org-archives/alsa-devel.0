From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 2/3] ASoC: fsl_spdif: spba clk is needed
 by spdif device
Date: Sat, 19 Sep 2015 06:50:40 -0700
Message-ID: <20150919135040.GM12027@sirena.org.uk>
References: <cover.1442469788.git.shengjiu.wang@freescale.com>
 <5fd6e6c463c2e8d141cf4b485f585f007a71442e.1442469788.git.shengjiu.wang@freescale.com>
 <20150917110154.GC12027@sirena.org.uk>
 <20150917175407.GA2544@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5076324044953533529=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 75B4D260661
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:32:13 +0200 (CEST)
In-Reply-To: <20150917175407.GA2544@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: mark.rutland@arm.com, Shengjiu Wang <shengjiu.wang@freescale.com>, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Xiubo.Lee@gmail.com, timur@tabi.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, robh+dt@kernel.org, galak@codeaurora.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org


--===============5076324044953533529==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4K4/B8dhIShZ/gwT"
Content-Disposition: inline


--4K4/B8dhIShZ/gwT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 17, 2015 at 10:54:08AM -0700, Nicolin Chen wrote:
> On Thu, Sep 17, 2015 at 12:01:54PM +0100, Mark Brown wrote:
> > On Thu, Sep 17, 2015 at 02:09:24PM +0800, Shengjiu Wang wrote:

> > > +	"dma"		  The spba clock is needed when sdma share peripheral
> > > +			  script is used.

> > It sounds like this clock is used by the DMA controller - shouldn't the
> > DMA controller driver be responsible for enabling it?

> I agree but it doesn't seems to be easy to enable and disable it
> dynamically along with ASoC open() and close() functions as the
> current clocks of SDMA get enabled when its channels are allocated
> during the system boot-up via generic DMA bindings.

Do we need to do things along with open() and close() or wouldn't doing
things along with the DMA operatiosn suffice?

> Maybe we can put in the issue_pending() and terminate_all() which
> are regularly called along with ASoC trigger(), or just open it
> permanently if the penalty of power efficiency is ignorable.

Or some kind of runtime PM usage within the DMA driver (possibly at
those points)?  It does seem like something we should solve in the DMA
code rather than in generic code.


--4K4/B8dhIShZ/gwT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/WgvAAoJECTWi3JdVIfQY5gH/A0CMTCMFWToMSn29OlqEEOt
eenuvYmbw/rgKUpqfDARMQudGyGYVSy6RwroTJXFe3ZOOxniCLUCaRLxEQgqIrob
saob9KpR3KsOoG98uFTsOCGn5uCSMwAKjvtFUt5KwzBhfzFKg+AyyhRBj417HjXD
vztUtlOYnGbe0Z7vnpRUJo4wKJqvkdUtCEtyYOKZ6AzuR1eRmYZhPpVGyyMxgmH6
4XS+fGnN/gkJ9q6ryjEUrDYHRl4AA1lucyC3tlEWZI663YhRXLos54ir9Q4Uzhqy
vUDfqTvBVTNo29TCwFNwG5essLWyMguioPvQoLsqKAtN/wRHQzmp3qm2wtm3I9U=
=pH5p
-----END PGP SIGNATURE-----

--4K4/B8dhIShZ/gwT--

--===============5076324044953533529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5076324044953533529==--
