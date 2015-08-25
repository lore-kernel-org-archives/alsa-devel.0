From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V5 3/3] ASoC: AMD: add AMD ASoC ACP-I2S
 driver
Date: Tue, 25 Aug 2015 19:32:58 +0100
Message-ID: <20150825183258.GL12878@sirena.org.uk>
References: <1440106594-29564-1-git-send-email-alexander.deucher@amd.com>
 <20150820231848.GX12027@sirena.org.uk>
 <CANv6ZMb9f-kaAUfcUka9T-0XLdG_0eNMVD8YvJNbN=fHEGMRPw@mail.gmail.com>
 <20150821161716.GD12027@sirena.org.uk>
 <CADnq5_PofEuygdfJ7W6=kMCUAxZw=8eft0W7F_dEj-8eTw-Ngw@mail.gmail.com>
 <20150825060648.GA27431@sirena.org.uk>
 <CANv6ZMaQV5XK3RG28ayeX-QsC2F3x+sK8ouegFgT=_xM+GUSFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8250181628788644790=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F77126516A
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 20:33:06 +0200 (CEST)
In-Reply-To: <CANv6ZMaQV5XK3RG28ayeX-QsC2F3x+sK8ouegFgT=_xM+GUSFg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: maruthi srinivas <maruthi.srinivas.b@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8250181628788644790==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kkRamCq5m5VQq0L6"
Content-Disposition: inline


--kkRamCq5m5VQq0L6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2015 at 03:26:54PM +0530, maruthi srinivas wrote:
> On Tue, Aug 25, 2015 at 11:36 AM, Mark Brown <broonie@kernel.org> wrote:

> > Please explain this in more detail, shared register ranges are very
> > common and are the sort of things MFDs are supposed to help with.

> In our case, ACP I2S driver need not do a  'devm_ioremap_resource' to
> get mmio base.

That sounds like a MFD type problem...

> ACP audio IP (DMA + I2S+ Others) registers can be accessed, using
> GPU's MMIO base.
> During GPU driver design, it was decided that all the register access
> for entire GPU MMIO
> aperture (includes ACP and others) to be done in GPU module only.
> This is implemented in another patch in this patch series using a
> abstraction layer.

That sounds like converting the Designware driver to use regmap and
providing a regmap would enable code sharing (you can provide a regmap
for accessors if you don't use it in the main driver).

> >> 2. The designware driver depends on the CLKDEV framework which we
> >> don't currently support.

> > You need to support the clock API, it's very easy to do so so there is
> > no excuse for doing something custom here.

> Codec acts as master in our case to provide clock to i2s controller and
> there wasn't a need to use clock APIs unlike in existing designware i2s driver.
> There is no custom implementation.

So you just need to add slave mode support to the driver.  Again not a
reason to just copy the code.

> >> 3. Our hardware does not support S16_LE

> > If you have modified the designware IP to remove this support (why would
> > anyone do that?) it's a trivial quirk, if the restriction comes from
> > some other part of the system like the DMA driver then the constraint
> > will come from that part of the system.

> There is a bug in ACP SoC implementation (which combines internal DMA,
> designware I2S
> and other blocks) for 16bit and lower resolution. I felt , it would be
> better to limit functionality
> in I2S DAI capabilities. I will put  this limitation in DMA driver
> capabilities, to represent overall
> sound card capabilities, if you suggest.

A quirk would also do the job.

--kkRamCq5m5VQq0L6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAEBCAAGBQJV3LTZAAoJECTWi3JdVIfQB18H+J727bLD75CUG7szDdXD0TTV
PU8g7sPcaGfgdW0q88sxOTSwIqmZBenzxmRFWncO7k3C4cIwNTKcYmOv+RSBfDa7
NkNbcOUhq5hvtQEhq+IAArQtlm9Q/5EsdmVAvRJzIZNa++g2x3tsu+vqdYI1/nYP
viT0qV4PE2TtEGSRMa+1hqOagtyeARXOxAn9dvyhDb8RCMNqw7c66CqIZBUM1u9d
akMfHa6B/Aeq7oApQmTptSC3Hr/HJmIarhIDIT8fkPiZ+zapO9hQLaBTsZnqNl9n
SD56OwdzBV4erretp2V0nyPtoHg57oFyd0zNbPpvgOCtCw/3IzMCZ4YOfdJ0ZQ==
=6SZI
-----END PGP SIGNATURE-----

--kkRamCq5m5VQq0L6--

--===============8250181628788644790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8250181628788644790==--
