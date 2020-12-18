Return-Path: <SRS0=KNeL=FW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ED3C4361B
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 18:04:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0DE123B6C
	for <alsa-devel@archiver.kernel.org>; Fri, 18 Dec 2020 18:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0DE123B6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E5921778;
	Fri, 18 Dec 2020 19:03:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E5921778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608314665;
	bh=FkUoSS1XA/fvcfYoGeT7JpiQyIA2Fo3T+sJ2XEZSLaw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGMlmB5w/xpk/9zfhn8iMlSvsNObMoOIQ4KgqQpMERBfaaRc2c5ibrOGXwRAnvGAO
	 GTMDVmBZVkQH0wo40kHBi9rO1C7lIuvRz1Iov4KSRYpGYvJBUOwRxPP50QBY28aW8e
	 cfdBdJ9riWSU8D0OhlLrmclLQv9uTBQUk/u+1D6M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93296F80171;
	Fri, 18 Dec 2020 19:03:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 888C6F801F7; Fri, 18 Dec 2020 19:03:33 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C36C4F8014B
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2020 19:03:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C36C4F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="vBlfg0Mw"
Date: Fri, 18 Dec 2020 18:03:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608314605;
 bh=FkUoSS1XA/fvcfYoGeT7JpiQyIA2Fo3T+sJ2XEZSLaw=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=vBlfg0MwKW270LXGfrZkKmF/HDxuLBQ3qvI+ZLjeS0L/BqO/maY80b990QQIyWH3x
 GAGvZgjDLAggmWs7x9ExGnAACvu0jyphastaI5fxVpno8mdKP4wk0jHWYOTmbEjjDu
 e7L+AAfqxItRHVuyllwhleMlWSnYKJRG2zV4/Mz0ixnfVuzEIz6zGV2OWykCzsCFTc
 IyEcBvmsfCxIWuWxhR9f5z2nmFkwQakYggOhoRhNFhm1S529GZY2dfL62VeZmfe89M
 d4KuFB3bYT21V9m2KOQYGX/SPMHUwOc5cJD/fasUASfO83K+X7oaIv2bd1P38hiX06
 xl7PQzyddmU/g==
From: Mark Brown <broonie@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [resend/standalone PATCH v4] Add auxiliary bus support
Message-ID: <20201218180310.GD5333@sirena.org.uk>
References: <160695681289.505290.8978295443574440604.stgit@dwillia2-desk3.amr.corp.intel.com>
 <X8ogtmrm7tOzZo+N@kroah.com>
 <CAPcyv4iLG7V9JT34La5PYfyM9378acbLnkShx=6pOmpPK7yg3A@mail.gmail.com>
 <X8usiKhLCU3PGL9J@kroah.com> <20201217211937.GA3177478@piout.net>
 <X9xV+8Mujo4dhfU4@kroah.com> <20201218131709.GA5333@sirena.org.uk>
 <20201218140854.GW552508@nvidia.com>
 <20201218155204.GC5333@sirena.org.uk>
 <20201218162817.GX552508@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <20201218162817.GX552508@nvidia.com>
X-Cookie: Password:
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, lee.jones@linaro.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kiran Patil <kiran.patil@intel.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-rdma <linux-rdma@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
 Martin Habets <mhabets@solarflare.com>, alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Netdev <netdev@vger.kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, David Miller <davem@davemloft.net>,
 Leon Romanovsky <leonro@nvidia.com>, Parav Pandit <parav@mellanox.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 18, 2020 at 12:28:17PM -0400, Jason Gunthorpe wrote:
> On Fri, Dec 18, 2020 at 03:52:04PM +0000, Mark Brown wrote:
> > On Fri, Dec 18, 2020 at 10:08:54AM -0400, Jason Gunthorpe wrote:

> > > I thought the recent LWN article summed it up nicely, auxillary bus is
> > > for gluing to subsystems together using a driver specific software API
> > > to connect to the HW, MFD is for splitting a physical HW into disjoint
> > > regions of HW.

> > This conflicts with the statements from Greg about not using the
> > platform bus for things that aren't memory mapped or "direct firmware",
> > a large proportion of MFD subfunctions are neither at least in so far as
> > I can understand what direct firmware means.

> I assume MFD will keep existing and it will somehow stop using
> platform device for the children it builds.

If it's not supposed to use platform devices so I'm assuming that the
intention is that it should use aux devices, otherwise presumably it'd
be making some new clone of the platform bus but I've not seen anyone
suggesting this.

> That doesn't mean MFD must use aux device, so I don't see what you
> mean by conflicts?

I was excluding the possibility that we have to make a third bus which
clones platform bus which nobody has been visibly suggesting.

> If someone has a PCI device and they want to split it up, they should
> choose between aux device and MFD (assuming MFD gets fixed, as Greg
> has basically blanket NAK'd adding more of them to MFD as is)

It is unclear to me how one is intended to choose between these
approaches, especially for systems that have a range of subdevices with
a range of characteristics.

> > To be honest I don't find the LWN article clarifies things particularly
> > here, the rationale appears to involve some misconceptions about what
> > MFDs look like.  It looks like it assumes that MFD functions have
> > physically separate register sets for example which is not a reliable
> > feature of MFDs, nor is the assumption that there's no shared
> > functionality which appears to be there.  It also appears to assume that

> I think the MFD cell model is probably the deciding feature. If that
> cell description scheme suites the device, and it is very HW focused,
> then MFD is probably the answer.

> The places I see aux device being used are a terrible fit for the cell
> idea. If there are MFD drivers that are awkardly crammed into that
> cell description then maybe they should be aux devices?

When you say the MFD cell model it's not clear what you mean - I *think*
you're referring to the idea of the subdevices getting all the
information they need to talk to the hardware from the device resources.
That's actually relatively uncommon with I2C/SPI MFDs, usually there's
at least some element of just knowing what's going on and the mfd_cells
are to some extent just a list of things to register rather than a model
of anything.

Look at something like wm8994 for example - the subdevices just know
which addresses in the device I2C/SPI regmap to work with but some of
them have interrupts passed through to them (and could potentially also
have separate subdevices for clocks and pinctrl).  These subdevices are
not memory mapped, not enumerated by firmware and the hardware has
indistinct separation of functions in the register map compared to how
Linux models the chips.

> > > Maybe there is some overlap, but if you want to add HW representations
> > > to the general auxillary device then I think you are using it for the
> > > wrong thing.

> > Even for the narrowest use case for auxiliary devices that I can think
> > of I think the assumption that nobody will ever design something which
> > can wire an interrupt intended to be serviced by a subfunction is a bit
> > optimistic. =20

> mlx5, for example, uses interrupts but an aux device is not assigned
> an exclusive MSI interrupt list.

> These devices have a very dynamic interrupt scheme, pre-partitioning
> the MSI vector table is completely the wrong API.

I'm not saying dynamic interrupt schemes or event queues from firmware
can't exist, I'm saying not all interrupt schemes are dynamic.

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/c7t4ACgkQJNaLcl1U
h9DZ9ggAhWS2GLzG19WitcNZFN865NLdPy+QPB5dNfJqSEWdIANmNlivsdyHbIae
pMP4f/TZReaOIA0LD4bUZuAoDdQobMvxI7Mg1Y7qg1wy5+SA2dGRJYUsYCNaGQs+
clPY3qNsHgcmbUNVbbZjSpxY3sLSpStsSeQb22JGqc9438HQ26c8xAj7/wbiUyjU
N8PozJPh+++afQFAP+hgWux0THNNrDTKlAZMZOD7AL1o/2M4Z2EHx5Lu3/XXJXaO
ihRdaMWFrQ9p7vCoZkutTw8wnoMhqxnST4EP1ZejtWNQZcXqf5wdTm/hDBTzgKmx
fe4rfElBhVvfORw9UTYh3Bjkit+xNQ==
=Im3G
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
