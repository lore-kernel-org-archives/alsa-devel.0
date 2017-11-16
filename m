From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/14] soundwire: Add Master registration
Date: Thu, 16 Nov 2017 17:30:24 +0000
Message-ID: <20171116173024.owiotfwriclu2won@sirena.org.uk>
References: <1510314556-13002-1-git-send-email-vinod.koul@intel.com>
 <1510314556-13002-4-git-send-email-vinod.koul@intel.com>
 <2ba56597-2178-6389-bc4d-153a17505981@linaro.org>
 <20171116164944.GC3187@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7966509454509373452=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 288A7266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 18:30:40 +0100 (CET)
In-Reply-To: <20171116164944.GC3187@localhost>
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
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============7966509454509373452==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3lfb2wtppqddt5wa"
Content-Disposition: inline


--3lfb2wtppqddt5wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 16, 2017 at 10:19:44PM +0530, Vinod Koul wrote:
> On Thu, Nov 16, 2017 at 04:05:22PM +0000, Srinivas Kandagatla wrote:

> > >+	*bus->assigned = ~GENMASK(SDW_BROADCAST_DEV_NUM, SDW_ENUM_DEV_NUM);

> > Can't we use ida for this.
> > This would also cut down code added for allocating dev_num.

> Device numbers in SoundWire are 0 thru 15 with 0 and 15 having special
> meaning so can'r be allocated. Bitmaps give me a nice way to ensure we dont
> use those by masking these and above 15... IDR uses bitmap with stuff on top
> which maynot be helpful here as I need a number 1 to 14. For a generic, give
> me a number IDRs are very useful.

Perhaps we need some comments or something explaining the constraints
here to stop people doing misguided cleanups?

--3lfb2wtppqddt5wa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloNyy4ACgkQJNaLcl1U
h9AwHgf/U1yjfTdPmXXBjMg8Hweoij7JLUFnHh5LybuiY5KIcWEOCRg3LEPwBLLF
caFGQnKe4+actb14AN8MuUXXxgZKkh3f4JpkQuRsSfrobdPHDoSPDTj2vwth0MU7
FlEqDTyzgMtFR4UoVFY7e0ZBsn7uSXjCSixvs2Kui/XYZs+FDXXwwNjVFVz0QBNX
LouqFv1qyhvYV6crUEE+5RHMN59LsjO4l/JcPR08W2Km2TmIgNPyoJZLWduWebLJ
q0wF+vqdw+u/zAiV57PHf/Y1cA4JWPPLzu0gwu43yIx2ShSzSLWc03QBHzWUsE7y
GtKtD9tWzcwd83EB63pnMnxreUzX1A==
=QZQ/
-----END PGP SIGNATURE-----

--3lfb2wtppqddt5wa--

--===============7966509454509373452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7966509454509373452==--
