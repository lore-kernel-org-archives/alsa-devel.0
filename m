From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: nau8825: provide clock divide
 for codec mater mode
Date: Mon, 9 Jan 2017 11:42:15 +0000
Message-ID: <20170109114215.uc7dtg4iintjxvyb@sirena.org.uk>
References: <1482223627-23547-1-git-send-email-KCHSU0@nuvoton.com>
 <1482223627-23547-2-git-send-email-KCHSU0@nuvoton.com>
 <20161231185701.4ebiu7zvmbldfdjd@sirena.org.uk>
 <586B14D2.5080503@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3222825179645982387=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A733266CFE
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 12:42:26 +0100 (CET)
In-Reply-To: <586B14D2.5080503@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, AC30 WTLi <WTLI@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3222825179645982387==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="52kdnk3xey3z3a3g"
Content-Disposition: inline


--52kdnk3xey3z3a3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 03, 2017 at 11:04:50AM +0800, John Hsu wrote:
> On 1/1/2017 2:57 AM, Mark Brown wrote:

> > Why is the driver not able to configure these automatically, most
> > devices manage to do that OK?  Typically systems are fine with the
> > obvious divisions down from the root clock, the driver should at least
> > offer that as a default rather than requiring all machine drivers to
> > duplicate the divisor selection code.

> The system clock of codec is always 256FS. Therefore, the driver can
> make it automatically. If the codec is as master, the driver needs to
> divide the system clock to output the BCLK and FS. But there are too
> many combinations between BCLK and FS. The BCLK maybe is 32FS, 64FS,
> 128FS, etc. The driver needs machine information to do the division.
> Thus, I think the best way is to make decision by machine driver.

This all sounds totally standard - other drivers manage to provide a
default easily enough here.  You can determine a default BCLK by looking
at the number of channels and number of bits per sample to work out how
many BCLKs are going to be needed to clock that data out.

--52kdnk3xey3z3a3g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhzdxYACgkQJNaLcl1U
h9D+wgf7BjxOH1bw1SlI3I5ubO5B2sjT14g1ucPgMQG2zz9qS7aMNqv154aI+eCQ
aYUO4Wx4zGGmD2wBrk7IPhSpeu0VNoCnClBzgiTKGrMjZS9NlAn8Ml02uzDleVDm
HAzOIvXIIAH/qq446XfGjyrj5hgxBFWyg51TuaeOFv9xUAL1ZZSIN4dV6FV3/UeY
O7l1X0WLLYgWltGkoP55mQuE8eV2NPmdHVwQHWiPFdblzfgUgT6Tw3nnuEQknjtk
8i6tCfVBfZIXR8KESquqLe8yz9/pq+qD4JkWO0h5urWPH3LcHA3Sk47b8J5VetAi
eW1g5vWaF95rsERHoSyhrIWi2XXS1w==
=pREs
-----END PGP SIGNATURE-----

--52kdnk3xey3z3a3g--

--===============3222825179645982387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3222825179645982387==--
