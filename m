From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/14] regmap: Add SoundWire bus support
Date: Thu, 16 Nov 2017 14:48:13 +0000
Message-ID: <20171116144813.qb446fhkdzok2fo7@sirena.org.uk>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-8-git-send-email-vinod.koul@intel.com>
 <20171116120437.h2ghxvwpsd6ovdhe@sirena.org.uk>
 <20171116130235.GT3187@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1070551795712851644=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 819A32676EC
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 15:48:28 +0100 (CET)
In-Reply-To: <20171116130235.GT3187@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============1070551795712851644==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3rabfvwi5xzx4spk"
Content-Disposition: inline


--3rabfvwi5xzx4spk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2017 at 06:32:35PM +0530, Vinod Koul wrote:
> On Thu, Nov 16, 2017 at 12:04:37PM +0000, Mark Brown wrote:
> > On Fri, Nov 10, 2017 at 05:19:09PM +0530, Vinod Koul wrote:

> > > +EXPORT_SYMBOL(__regmap_init_sdw);

> > We still have plain EXPORT_SYMBOL() on the regmap exports...

> I assumed after Alan's clarification that it is okay to do so. Let me know if
> you feel otherwise

No, I'm not which is why I replied to Alan's most recent mail explaining
that I felt he was missing my point.  For the bus code itself I don't
really care either way, this is just about this one file.

To repeat this is a pretty thin layer of code tying regmap and Soundwire
together, it's not as substantial as the bus code itself.  The exports
have no meaning outside of a kernel context and within that context it's
hard to see a natural use case for doing this.  It's much easier to see
cases where someone causes themselves problems by reading too much into
the use of plain EXPORT_SYMBOL(), perhaps not considering things as
carefully as they might otherwise have done.

--3rabfvwi5xzx4spk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloNpSwACgkQJNaLcl1U
h9BPnAf/e1/amYdWLpq1G3QdnVVOqGCggPM6R0MZu+RzaRYaTlQktq5XeFH1+eQn
Oa0pIo0lgaNafxbGq4Yb9meiXDjL/4AGFvBGCs9tLCkysLm0JN06deKFGLXOTHVz
uitv2uCUfpLH778ttWzkuVLS8xMPnXUuyeAvibpyj7hQQddD2hlVV/MvxtPk5x5H
QE8XOlCMew5c/YjDHaQqPk1QL43QTIQF4p+gyut8xFlXzJin+PRFy1VNfBeEHMnu
m/E5VqxynqaEYKjZ6ODyQWSiGsIV4Llb/PsoLbq87SOq+nMNfbosKR4GTsn1qmFF
l2kQkGHo2Kocp0KPfgdarCzRscEjpQ==
=GYJS
-----END PGP SIGNATURE-----

--3rabfvwi5xzx4spk--

--===============1070551795712851644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1070551795712851644==--
