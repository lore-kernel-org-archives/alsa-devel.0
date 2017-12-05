From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] ASoC: uniphier: add support for
	UniPhier AIO driver
Date: Tue, 5 Dec 2017 12:14:40 +0000
Message-ID: <20171205121440.GC11658@finisterre>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
 <20171122114321.29196-6-suzuki.katsuhiro@socionext.com>
 <20171204183934.rd4vin22ktukwpip@sirena.org.uk>
 <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7212106249773398634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 06F39266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:40:00 +0100 (CET)
In-Reply-To: <002b01d36d84$51d80aa0$f5881fe0$@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, =?utf-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7212106249773398634==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 01:48:39PM +0900, Katsuhiro Suzuki wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > Is there a mux in the SoC here?

> Sorry for confusing, It's not mux.

> uniphier_srcport_reset() resets HW SRC (sampling rate converter) block.
> Audio data out ports of UniPhier audio system have HW SRC.

Is the SRC just a single block sitting between the DMA and the external
audio port or is there more going on?  Some of the other code made me
think the hardware was more flexible than this (all the writing to
registers with names like RXSEL for example).

> > > +#endif /* CONFIG_SND_SOC_UNIPHIER_LD11 */

> > Why is there an ifdef here?  There's no other conditional code in here,
> > it seems pointless.

> This config is used to support or not LD11 SoC.
> aio-ld11.c is not build and 'uniphier_aio_ldxx_spec' is undefined if this=
 config is disabled.
>=20
> aio-ld11.c defines SoC dependent resources (port, HW ring buffer, DMA ch,=
 etc.)
> and fixed settings.
> I know it's better to move such information into device-tree, but registe=
r areas of
> UniPhier's audio system is very strange and interleaved. It's hard to spl=
it each nodes...

I'd expect this code to be structured more like a library - have a
driver that handles the specific IPs then have it call into a shared
block of code that does the generic bits.  Though in this case the
device specific bit looks like a couple of tiny data tables so I'm not
sure it's worth making it conditional or separate at all.

> > This looks awfully like compressed audio support...  should there be
> > integration with the compressed audio API/

> Thanks, I'll try it. Is there Documentation in sound/designes/compress-of=
fload.rst?
> And best sample is... Intel's driver?

Yes.

> (Summary)
> I think I should fix as follows:

>   - Split DMA, DAI patches from large one
>   - Validate parameters in hw_params
>   - Add description about HW SRC (or fix bad name 'srcport')
>   - Add comments about uniphier_aiodma_irq()
>   - Expose clocking and audio routing to userspace, or at the very
>     least machine driver configuration
>   - Support compress-audio API for S/PDIF

> and post V2.

At least.  I do think we need to get to the bottom of how flexible the
hardware is first though.

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlomjbAACgkQJNaLcl1U
h9BFiAf+IRA7T3TCrKUXbnaZCZQS/tTyylp04bjSR6BzEl9m4O0kDG2WM4ZQS1RE
hjoD9fQlTMicA5hBMLarR1ojjpIzbVGjxeRIkcMzsVOpIZVBN9t36pc0WFeem5Ff
IdKFIusosePgfTnW3PeamVdyJ1xK/s+C2wBAA7AaWLwRQef+VHZdJ2XKOyei438d
D0VTLpoZvh7O/TpvWnCEIpv3rU3j2Qso3MtV7fRFazg2yanRt7kQm7nvmgx8/wT4
HJk/w9zpk5/mJwu5o3D/HeoyLYcpxDM5bocxYHrLmJVRqZFvf84HlYXP9eB1u/4y
vxCaVjPYtA6bCSEDq3DLXi9Ok595Ag==
=gUoc
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--

--===============7212106249773398634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7212106249773398634==--
