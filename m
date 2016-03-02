From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: add crosstalk suppression
	feature
Date: Wed, 2 Mar 2016 13:31:30 +0900
Message-ID: <20160302043130.GB18327@sirena.org.uk>
References: <1454651566-28451-1-git-send-email-KCHSU0@nuvoton.com>
 <20160209183944.GL13270@sirena.org.uk>
 <56D380EC.6070302@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1427967465696952890=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 11F062606F5
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 05:31:33 +0100 (CET)
In-Reply-To: <56D380EC.6070302@nuvoton.com>
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
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1427967465696952890==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pgcMpfnoUMCG2omj"
Content-Disposition: inline


--pgcMpfnoUMCG2omj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 29, 2016 at 07:21:16AM +0800, John Hsu wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> On 2/10/2016 2:39 AM, Mark Brown wrote:
> >On Fri, Feb 05, 2016 at 01:52:46PM +0800, John Hsu wrote:

> >>+static u32 nau8825_intlog10_dec3(u32 value)

> >This doesn't look driver specific, it should go somewhere generic
> >(though I can't immediately see any relevant place for it...).

> Do you have any advise what we can do? It's possible to move these functions
> to other files, isn't it?

Propose a maths helper library?

> It has to enable DAC and ADC path for detection and measurement. A little
> like simple playback and record.
> Indeed, it spent some time to finish the whole sequence and the situation
> you mention will happen possibly.
> Do we can add some mutex in driver to avoid something like race condition
> happened? Could you give us suggenstion? Very thanks.

Take a look at the da7219 driver, it is doing something similar.

--pgcMpfnoUMCG2omj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1mygAAoJECTWi3JdVIfQ/HMH/jn5LF6pcfhsIcf9LmL3lU9s
Remizwd3kZrr5i7SNuyEeVJfqxRQHCdGHHc5tcyNs21yiWyMTp+2fz6zUtrVg/YC
dvd5GYMIoHPFtEoKPBcLOwH3Q0BQ1EycKZ8x3feBCjuwWSWnbMkdMvzuYiKO3fv3
VNxHX+i6kHvPeCZBVzPjVd00A05MU0dwzVoq5RSLhWEYnCkrZ17IWj2VjqQt+p2H
dXPQYmwuU1w0umbQuxxAsLd3cilTcTNShyzuQYQY90aXWw91CMXUUg1t733dVShs
NR7vAUFC4dx+8WjhjvqoXBTkNOACoR8etJwMJMlc9q0bxP8ONVzw6DcyK9qJAJU=
=4NWv
-----END PGP SIGNATURE-----

--pgcMpfnoUMCG2omj--

--===============1427967465696952890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1427967465696952890==--
