From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dpcm: prevent error for paths
 including static links
Date: Wed, 30 Mar 2016 10:27:02 -0700
Message-ID: <20160330172702.GM2350@sirena.org.uk>
References: <1458056089-885-1-git-send-email-piotrs@opensource.wolfsonmicro.com>
 <20160329212224.GM2350@sirena.org.uk>
 <20160330085812.GE31814@localhost.localdomain>
 <20160330163650.GG2350@sirena.org.uk>
 <20160330171314.GF31814@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3453447154561103196=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95B19265CC0
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 19:27:07 +0200 (CEST)
In-Reply-To: <20160330171314.GF31814@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Piotr Stankiewicz <piotrs@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3453447154561103196==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nc/lueCMLdgjBWoP"
Content-Disposition: inline


--nc/lueCMLdgjBWoP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 30, 2016 at 06:13:14PM +0100, Charles Keepax wrote:
> On Wed, Mar 30, 2016 at 09:36:50AM -0700, Mark Brown wrote:

> > Doesn't this mean that the appropriate fix is to terminate the DPCM
> > routing at the first back end DAI so we're not trying to DPCM outside
> > the SoC?

> I think (not 100% certain) you can have multiple backends
> connected to a single front end, which makes it hard to know when
> to stop or even if it is assured that all the backends will be
> before any other spurious DAIs in the widget list.

You can have multiple backends connected but they shouldn't be chained
together, they should be connected in parallel.  We can tell if we're
walking a node that's a backend, why would we walk the graph beyond
that?

--nc/lueCMLdgjBWoP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/AxkAAoJECTWi3JdVIfQ5VEH/RTxbnRF9OnDyMGBuE6dOecs
QZDA/NM4QjfJcn8EZqpOnTi2tpOWNFIWSdY2OWGO/HWuHuPqCLFnFPpICpcVFSxa
Tk7AWJWlpDTf/cz2d06CHLfqfuvvxeTLPv0mPpqd5wr5n1RexKRFchHHJ8p/3DCb
CrDZktDi3SUp6W0kUI5PEGRbHaSO1AQdRu59LAyrrCKjQE3xBBk35Xm7OuW2Cu+2
vhOkV5E/5L/q3Ub8aUJD6zJ7eazZM52vDVvDUKD49s+5jpz4UK4jg0SpA8ybuusX
peua6jBWtLSlHyesHYMN/rrYZlAZgGEQehsmOmn/sMLbaxz1t/qeIgW9xKWbEQA=
=KNsD
-----END PGP SIGNATURE-----

--nc/lueCMLdgjBWoP--

--===============3453447154561103196==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3453447154561103196==--
