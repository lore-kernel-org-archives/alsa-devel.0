From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 5/7] ASoC: intel - add Skylake HDA audio
	driver
Date: Fri, 29 May 2015 18:41:15 +0100
Message-ID: <20150529174115.GR21577@sirena.org.uk>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
 <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6692771911347057399=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0D0D260714
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 19:41:20 +0200 (CEST)
In-Reply-To: <1431341645-2457-6-git-send-email-vinod.koul@intel.com>
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


--===============6692771911347057399==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZRuRcbQpTG2MazvN"
Content-Disposition: inline


--ZRuRcbQpTG2MazvN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 04:24:03PM +0530, Vinod Koul wrote:

> +static void azx_free_streams(struct soc_hdac_bus *sbus)
> +{
> +	struct hdac_stream *s;
> +	struct soc_hdac_stream *stream;
> +	struct hdac_bus *bus = hdac_bus(sbus);
> +
> +	while (!list_empty(&bus->stream_list)) {
> +		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
> +		stream = stream_to_soc_hdac_stream(s);
> +		list_del(&s->list);
> +		kfree(stream);
> +	}
> +}

Why is this (and the equivalent link function) device specific code?
They look very generic...

> +static int azx_acquire_irq(struct soc_hdac_bus *sbus, int do_disconnect)
> +{
> +	struct hda_skl *hda = to_hda_skl(sbus);
> +	struct hdac_bus *bus = hdac_bus(sbus);
> +	int ret = 0;
> +
> +	ret = request_threaded_irq(hda->pci->irq, azx_interrupt,
> +			azx_threaded_handler,
> +			hda->msi ? 0 : IRQF_SHARED,
> +			KBUILD_MODNAME, sbus);

Why not just always request the interrupt as shared - we don't seem to
care in the interrupt handling code?

> +/* PCI register access. */
> +static void pci_azx_writel(u32 value, u32 __iomem *addr)
> +{
> +	writel(value, addr);
> +}

These wrappers are setting off alarm bells - why can't we just use the
called functions directly, and given the parameters (which have just a
raw pointer and value) what else could the implementation be?

--ZRuRcbQpTG2MazvN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVaKS6AAoJECTWi3JdVIfQZCcH/1iXYyRn3/g2hUO8jCUR4d2H
R/+HsLFCihUm/KbqoXflAbO0TvuPOtfvi69DUFBV9xQU5GU/exz6riVjfWzk41na
4TtFFf3Hy1hdj7t1Rx7aDWmRUkBkC2btQkIztQJsu94TL3lkWtlsYTTfMCFquzb5
k6++TyAZYdQ/xZU/bUCGi+qhHawYC5KmXivG00lCv3reCYGOtlh6FOkphluY52x5
4pmdoAfDSTTGFGSso4SwBL0IktZ3KkYhQRETaNPbAynK0jO8uNl6+AzDHgBph5VO
GZYmN1oqYaLl/cphiuJgR+nmH8WmZBmc7nzY0fFZ4GoyEIKMu8mqJv9h5AX+90E=
=2u9C
-----END PGP SIGNATURE-----

--ZRuRcbQpTG2MazvN--

--===============6692771911347057399==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6692771911347057399==--
