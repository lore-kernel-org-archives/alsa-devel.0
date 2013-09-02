From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Mon, 2 Sep 2013 17:27:29 +0100
Message-ID: <20130902162729.GT3084@sirena.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8171419376326087647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 556B72651C6
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 18:27:35 +0200 (CEST)
In-Reply-To: <20130902141631.GV6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8171419376326087647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sx3M3By4KbPIrykT"
Content-Disposition: inline


--Sx3M3By4KbPIrykT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 02, 2013 at 03:16:31PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 02, 2013 at 03:06:32PM +0100, Mark Brown wrote:

> > Yes, and this is one of the reasons for suggesting getting either/or
> > support merged - it will help things like the binding definition
> > progress (as well as being useful for any users with a S/PDIF only
> > system).

> Sorry, but I believe the exact opposite:

> 1. The DAI link binding created for a dual-DAI driver is completely
>    different from the DAI link binding for a DPCM driver.  The dual
>    DAI link binding will have to be completely rewritten when the
>    driver is converted to DPCM.

That seems like overstating the difficulties.  The updates for any new
S/PDIF drivers will be pretty much the same as those for the existing
I2S drivers and should just be mechanical changes, nothing too taxing.

> 2. When the driver is converted to DPCM, it must use DPCM for
>    everything, otherwise it has no way to know which of SPDIF or I2S to
>    enable.  The only way I know to work around that is to add additional
>    routes to link up the AIF widgets, and that's the solution you're all
>    telling me is not acceptable, as per the patch set at the start of
>    this thread.

What we have been telling you is that if there is a DAI link present
(there should be one for each physical DAI link) then this should be
enough information for the framework to know that the two DAIs are
linked and if any routes are needed in DAPM these should be added
automatically in the same way that we add links for CODEC<->CODEC links
at present.

It's been said to you off-list that having the links manually added
but marking them for removal when the framework figures out how to do
that should be OK.

--Sx3M3By4KbPIrykT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSJLxuAAoJELSic+t+oim9RKoP/ieCfFBT7JdColZNdpDevioz
5umvhRKpv8+SIqGQmEHrUvutXN7bPu7S3RxqottNYVY8t8KgXds2Wyg12wMesMvM
Qe5NQ4BJaBi4UqO76/4aWbXxvUSwSRVs5UQ5zptVivkpQ6VxRIB9nuvBcU1x5Y4Q
3GBTt69SoW3rDAIfGprEiqm67ZoNhic8f8T1C78kOW1t1P11v714P0/SKMgD11sY
WckQrTWqauejYtZ+q2dgJjWBaxnYVOzplsmS4bQ7lI978sW3qiuFUDM/e3RHXQWZ
h3xuItYhme55S0TsrT7crqIHmUTfOKA2Nyq1UHHoS0pf9yfF6O53PhlKTJwYBH6q
ec+6TaHGeUpyQPM7xCCTNzLx3glvlELICgHDoa6wVti0dwiCx0xI1w1J8mLbvU67
hMioGHAxeob+XxZjoUDw1j6XWjNk1yLwAOncS/z4+C2OW/LnPkdXB0RN45jJ3qIl
yRmMLGnIX6eN/BpeqS9Nb77xUXg3ITcAuZ/qcTNXJdxboUpaz/HDiFekv6WsjkFH
Xo+M/6BfCPa1pS5iXdYhK5/e63uvXI4rY/W10kwyDD79hXkumrLvSMnEm26m/dxg
5bsugRDkYWHEKpWb0kSD7fPiU2rcKyN9H+6z+dk0fTB2LgWVQ989VNxENUEylE5F
BzunVsrTznfT9leGQGFj
=Qpb4
-----END PGP SIGNATURE-----

--Sx3M3By4KbPIrykT--

--===============8171419376326087647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8171419376326087647==--
