From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 2/4] ASoC: Intel - add Skylake HDA audio
	driver
Date: Mon, 15 Jun 2015 16:56:33 +0100
Message-ID: <20150615155632.GU18309@sirena.org.uk>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6533127184953211662=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2575926513F
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 17:56:46 +0200 (CEST)
In-Reply-To: <1434040438-14535-3-git-send-email-vinod.koul@intel.com>
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


--===============6533127184953211662==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qpPEP5KwiTnADq8L"
Content-Disposition: inline


--qpPEP5KwiTnADq8L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2015 at 10:03:56PM +0530, Vinod Koul wrote:

> +/* initialize SD streams, use seprate streeam tag for PB and CP */
> +static int skl_init_stream(struct hdac_ext_bus *ebus, int start_idx,
> +				int num_stream, int dir)
> +{
> +	int stream_tag = 0;
> +	int i, tag, idx = start_idx;
> +
> +	for (i = 0; i < num_stream; i++) {
> +		struct hdac_ext_stream *stream =
> +				kzalloc(sizeof(*stream), GFP_KERNEL);
> +		if (!stream)
> +			return -ENOMEM;
> +		tag = ++stream_tag;
> +		snd_hdac_ext_stream_init(ebus, stream, idx, dir, tag);
> +		idx++;
> +	}
> +
> +	return 0;
> +}
> +
> +static void skl_free_streams(struct hdac_ext_bus *ebus)
> +{
> +	struct hdac_stream *s;
> +	struct hdac_ext_stream *stream;
> +	struct hdac_bus *bus = ebus_to_hbus(ebus);
> +
> +	while (!list_empty(&bus->stream_list)) {
> +		s = list_first_entry(&bus->stream_list, struct hdac_stream, list);
> +		stream = stream_to_hdac_ext_stream(s);
> +		list_del(&s->list);
> +		kfree(stream);
> +	}
> +}

Still not sure why these are Sky Lake specific?

> +static void skl_free_hda_links(struct hdac_ext_bus *ebus)
> +{
> +	struct hdac_ext_link *l;
> +
> +	while (!list_empty(&ebus->hlink_list)) {
> +		l = list_first_entry(&ebus->hlink_list, struct hdac_ext_link, list);
> +		list_del(&l->list);
> +		kfree(l);
> +	}
> +}

Or this?

> +static int skl_suspend(struct device *dev)
> +{
> +	struct pci_dev *pci = to_pci_dev(dev);
> +	struct hdac_ext_bus *ebus = pci_get_drvdata(pci);
> +	struct hdac_bus *bus = ebus_to_hbus(ebus);
> +
> +	snd_hdac_bus_stop_chip(bus);
> +	snd_hdac_bus_enter_link_reset(bus);
> +	if (bus->irq >= 0) {
> +		free_irq(bus->irq, bus);


Why are we freeing the interrupt over suspend?  That is very unusual
behaviour.

> +static int skl_dmic_device_register(struct skl *skl)
> +{
> +	struct hdac_bus *bus = ebus_to_hbus(&skl->ebus);
> +	struct platform_device *pdev;
> +	int ret;
> +
> +	pdev = platform_device_alloc("dmic-codec", -1);
> +	if (!pdev) {
> +		dev_err(bus->dev, "failed to allocate dmic device\n");
> +		return -1;
> +	}
> +
> +	ret = platform_device_add(pdev);
> +	if (ret) {
> +		dev_err(bus->dev, "failed to add hda codec device\n");
> +		platform_device_put(pdev);
> +		return -1;
> +	}

Don't squash the error codes you get, return them - and if you must
return a fixed error code I'm pretty sure you don't mean -EPERM.

> +	skl->dmic_dev = pdev;

There can only ever be one DMIC?

> +
> +static const struct hdac_io_ops skl_io_ops = {
> +	.reg_writel = skl_pci_writel,
> +	.reg_readl = skl_pci_readl,
> +	.reg_writew = skl_pci_writew,
> +	.reg_readw = skl_pci_readw,
> +	.reg_writeb = skl_pci_writeb,
> +	.reg_readb = skl_pci_readb,
> +	.dma_alloc_pages = skl_dma_alloc_pages,
> +	.dma_free_pages = skl_dma_free_pages,
> +};

Still not thrilled at open coding these wrappers.

--qpPEP5KwiTnADq8L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfvWwAAoJECTWi3JdVIfQm2MH/2nm4Xyw+GTB8RjhHQ5qPVL1
Pcq3H805ZtqH60RuUG2zY1jXP0Q4Auje+QkcOdH0DhZq3bsfGLDBuUF3A/9JfAws
Fc68JellCgQUlr+CjAq45OakgtrHyI8Lnq3ffsYamSWU4I4EYFyKHzjnZUUuxRnR
oa4hQ/bjv4I8UXKlXrxuPMQE+1HB0fUxICVbWiPg/Ou38l96/4X8ezC0FfkW0mTA
YUpkyIiLdo5rb76p7E+1yS3ZiQbh+H7BhyNh0UTKcICKKhFY2frj21+uK/GTf6J9
g76Z98AIXA5ph3RMRsHp6iA8bDufhtP93khbHImwP/Cp/s6REX4I6Q8zrcO2wZI=
=UXLq
-----END PGP SIGNATURE-----

--qpPEP5KwiTnADq8L--

--===============6533127184953211662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6533127184953211662==--
