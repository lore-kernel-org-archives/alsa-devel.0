From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 09/19] ASoC: tlv320aic31xx: Remove platform data
Date: Wed, 6 Dec 2017 19:11:12 +0000
Message-ID: <20171206191112.ip47bylnvyfc2irt@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-10-afd@ti.com>
 <20171201132606.vyw7wthmql5trkwq@sirena.org.uk>
 <4fee76ef-e518-69b6-3bcc-f65b0a31cacc@ti.com>
 <20171206124540.GC1827@finisterre>
 <10f1b19b-4a0a-e336-b757-933d46b5c8e9@ti.com>
 <20171206173059.qw4tt7nizmyo6xbl@sirena.org.uk>
 <b6f581be-6d3a-6fc3-036f-9efc1bfc2429@ti.com>
 <20171206181534.7t23ljja6fgle4ar@sirena.org.uk>
 <86e13e26-e8d5-35ed-6bd0-d91d9323d5e6@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yt5swpqm4kzhqwy4"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <86e13e26-e8d5-35ed-6bd0-d91d9323d5e6-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--yt5swpqm4kzhqwy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 06, 2017 at 12:40:45PM -0600, Andrew F. Davis wrote:

> For some userspace feature sure, but this is kernel code, there is no
> guarantee for a sable API, in fact some would probably argue even
> further that there is a guarantee that stuff *will* change and this is a
> good thing as it kinda serves to punish for those you don't try to upstre=
am.

> So the helpfulness bar should be zero for changes that break out-of-tree
> stuff.

There is no need to actively get in people's way or put up barriers to
people who do in future decide to upstream things, that doesn't help
anyone.

> Even more so this patch isn't a zero gain, the cleaner, better looking,
> and easier to maintain code *is* the benefit in itself. Plus we gain the
> ability to set mic-gain voltage with ACPI, something you couldn't do
> before this patch.

If this patch adds ACPI support then the patch description was clearly
not great (I don't think I read the patch itself since the description
just said that it was removing platform data without giving a reason,
that's the main review comment here).=20

If you want to use the device property stuff that's fine but there's no
need to remove platform data to do that, it's a smaller change.  I find
it hard to see the platform data as a particularly big blight on the
code here, looking at the driver it's just going to remove the "pdata."
=66rom a few variable accesses which isn't exactly transformational.

--yt5swpqm4kzhqwy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooQNAACgkQJNaLcl1U
h9CgUQf+OfU8ycYyHa+CYnGn6Htt1oye9dJUuOyY3jFAhDXOy4x9KtZq32YdXHQl
hv+Sdm0VIlh++nSEqarNFnPW/OklMjCtjxHUzAO1TbrkCWk1NZUO83iSeDQ8bUk4
giKnACOSoB5RWExsRwo+8LEezAWaxp/6m5thiM94iNJmY1Du3p0xHpYZyBPnn/WV
74b0dxwBwzPU8VVbkGFNq6j36zaf5c8pewwzLqb2rPjTlzfBSNIukc0DowIp0i/k
8gYAOSXvM9xLzAz3NoOiGihBtNlhDbpNK0PX7Inhfm9LDQzsET57k/5/T8Gh2y82
9aGaIzEB/lgnT7v07QRQE7kj6FlrIA==
=ACWY
-----END PGP SIGNATURE-----

--yt5swpqm4kzhqwy4--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
