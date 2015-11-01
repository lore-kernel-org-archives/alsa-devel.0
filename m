From: Mark Brown <broonie@kernel.org>
Subject: Re: Splitting out controls
Date: Sun, 1 Nov 2015 11:45:00 +0900
Message-ID: <20151101024500.GG28319@sirena.org.uk>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org>
 <561CADA8.3040903@canonical.com>
 <20151030023618.GR28319@sirena.org.uk>
 <56332C17.4010303@canonical.com>
 <20151030085302.GE7311@us.netrek.org>
 <5633329E.8040003@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5651055454279985745=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D4AEC2606D4
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 09:53:55 +0100 (CET)
In-Reply-To: <5633329E.8040003@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>
List-Id: alsa-devel@alsa-project.org


--===============5651055454279985745==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dGMqxDINbOsorC0c"
Content-Disposition: inline


--dGMqxDINbOsorC0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 30, 2015 at 10:04:30AM +0100, David Henningsson wrote:
> On 2015-10-30 09:53, James Cameron wrote:
> >On Fri, Oct 30, 2015 at 09:36:39AM +0100, David Henningsson wrote:

> >>The BIOS can poke the hardware, set registers in such ways that
> >>volumes are limited. Registers that the kernel never touches.

> >I'm not sure how that would work.  The BIOS developers and the kernel
> >developers would have to agree on what registers are to be touched by
> >the BIOS only.  In my case, with the rt5631, the registers could not
> >be easily isolated in that fashion.  And if the kernel hit the reset
> >bit in one of the registers, whatever the BIOS had set would be lost.

> >Oh, and power management.  The codec can be powered down by suspend,
> >with the BIOS uninvolved in resume.

> The way it has come to work on HDA is that the codec vendor has a number of
> "secret" registers, which they only tell the BIOS developers about, and (to
> our frustration) are quite reluctant to tell us about.

> And certainly the BIOS is involved in setting these registers on S3 resume,
> too.

This is all extremely specific to how HDA works on x86 systems with
UEFI and ACPI, it's not at all applicable generally.

> One could imagine having ACPI calls for putting a codec in suspend/resume,
> but as I said, in many cases (such as yours) this just makes things more
> complicated. It's better dealt with in the kernel codec driver instead.

This then gets us back into the problem of having to have very system
specific tuning in drivers somehow which is challenging to deploy.

--dGMqxDINbOsorC0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWNXysAAoJECTWi3JdVIfQ1XYH/R27Xz6keD7xb6K0wZFekRpl
VnNpkEXAi5Lfs0hVgBkclASZFSPXc+vXQDAI6L2sfex0R7p/U8AzOzCvxj7UAKDQ
J8+U3XVp2mznFNh9mQUAMCZQfR+e3tJ1Clkl/2jY6XTeOIIQR5w1L/vF4qOfiOJJ
2qGiBmp1osCvDl+/52nGdEeDBeTTdJ7nJrWP6mnyH90bCacxmpaBVX0QFqz9QX/9
WGxDaEI2l6hOxneqcmrtWU3bkzy7T6qYe7hkXF1kDiqoWMRM+GpMWmVE/utiY6ea
RhcFg1Jhg8PU7+k5MdLs95ySZ7ZEDV3SbDpKfeGtteG8vDCgB0caSblytvM0ci4=
=Y2DU
-----END PGP SIGNATURE-----

--dGMqxDINbOsorC0c--

--===============5651055454279985745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5651055454279985745==--
