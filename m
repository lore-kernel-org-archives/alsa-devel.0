From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V5 3/3] ASoC: AMD: add AMD ASoC ACP-I2S
 driver
Date: Tue, 25 Aug 2015 07:06:48 +0100
Message-ID: <20150825060648.GA27431@sirena.org.uk>
References: <1440106594-29564-1-git-send-email-alexander.deucher@amd.com>
 <20150820231848.GX12027@sirena.org.uk>
 <CANv6ZMb9f-kaAUfcUka9T-0XLdG_0eNMVD8YvJNbN=fHEGMRPw@mail.gmail.com>
 <20150821161716.GD12027@sirena.org.uk>
 <CADnq5_PofEuygdfJ7W6=kMCUAxZw=8eft0W7F_dEj-8eTw-Ngw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2323040973524387732=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CD58264F0D
 for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2015 08:06:57 +0200 (CEST)
In-Reply-To: <CADnq5_PofEuygdfJ7W6=kMCUAxZw=8eft0W7F_dEj-8eTw-Ngw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Bayyavarapu,
 Maruthi" <maruthi.bayyavarapu@amd.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, maruthi srinivas <maruthi.srinivas.b@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2323040973524387732==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 24, 2015 at 04:08:31PM -0400, Alex Deucher wrote:
> On Fri, Aug 21, 2015 at 12:17 PM, Mark Brown <broonie@kernel.org> wrote:

> > What I'm looking for is actual code sharing where we use the same code
> > for the I2S controller block or a clear and documented understanding of
> > why it is not possible to share things.

> Maruthi can clarify further, but it's not possible to use the
> designware driver directly because:
> 1. The i2s registers are within the same MMIO aperture as our other
> GPU registers.  Our GPU driver is designed in such a way that the
> specific IP modules don't have direct access to the MMIO aperture.
> They use functions provided by the core driver to access registers.
> Thus the ACP IP module within the GPU driver does not have direct
> access to the mmio base pointer in order to pass it on.

Please explain this in more detail, shared register ranges are very
common and are the sort of things MFDs are supposed to help with.

> 2. The designware driver depends on the CLKDEV framework which we
> don't currently support.

You need to support the clock API, it's very easy to do so so there is
no excuse for doing something custom here.

> 3. Our hardware does not support S16_LE

If you have modified the designware IP to remove this support (why would
anyone do that?) it's a trivial quirk, if the restriction comes from
some other part of the system like the DMA driver then the constraint
will come from that part of the system.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3AX4AAoJECTWi3JdVIfQn88H/j6yEdJHtZBBdVcQm5E5lwUK
pkIP3Wt34dbVCSEtYx3h41XBPwFxqdAF9zUcFXkS9RRnNrlFKET9Hpndiqxz4yy1
NAoqgnHEul6ul0HnLptnwjFAcyqWz31lLIjZMNZjBr0dkrja4enMQbOOud0wiZFK
RLzuEelfZcBISnOudwWRgy0LwcObRdEkSGR7S/potOK2GriY9v58ytgSdHaQ0Jbc
ACOFRKS8GpOWEU55lnO5MkZb+j1AE2dnlt9UnDb77BOCCTaDdAP4/KhWTvbSdest
/O5t3k1BB5x9D5E15YPDXCcoIna8QgolGg18UgA+Gj7QU24TDmGj8ffzVTG5rHk=
=mD3p
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--

--===============2323040973524387732==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2323040973524387732==--
