From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC:Question rate constraint between the dais
Date: Sat, 17 Mar 2012 11:48:57 +0000
Message-ID: <20120317114856.GN3158@opensource.wolfsonmicro.com>
References: <64362.10.252.27.21.1331805184.squirrel@linux.intel.com>
	<20120315175310.GR3138@opensource.wolfsonmicro.com>
	<9DF50024A2F6A5439EBFE2E74F4E9198055254@BGSMSX101.gar.corp.intel.com>
	<4F63105E.3080705@linux.intel.com>
	<20120316192231.GI3158@opensource.wolfsonmicro.com>
	<CA+7tXigaxPdkBGfciWgJx2PnZHPKftgWdXxYREOBYUiXW7aA=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6460477809539600349=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D1E45243D8
	for <alsa-devel@alsa-project.org>; Sat, 17 Mar 2012 12:48:59 +0100 (CET)
In-Reply-To: <CA+7tXigaxPdkBGfciWgJx2PnZHPKftgWdXxYREOBYUiXW7aA=g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org, Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>, Ramesh Babu <ramesh.babu@intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============6460477809539600349==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vdqwC0msT4ilQ2it"
Content-Disposition: inline


--vdqwC0msT4ilQ2it
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 16, 2012 at 06:01:44PM -0400, Trent Piepho wrote:
> On Fri, Mar 16, 2012 at 3:22 PM, Mark Brown

> > There's a way to do this, and it's the way that the WM8988 driver is
> > doing it - obviously you'll have different criteria for choosing
> > constraints but the actual application of the constraints is going to be
> > done in the same way.

> Since the constraint is based on the current configuration of another
> DAI, the two DAIs need some way to query each other's parameters.  The

Since they're both provided by the same driver this is trivial.

> And as I said before, ALSA doesn't handle this 100%.  There is a race
> if both streams are initialized at the same time.  If you open one

Yes, I did reply to your previous mail about that pointing out that this
is impossible...

> I think what's necessary is for ALSA to let hw_params return an error
> code that means lets the driver say, "Sorry, the constraints have
> changed and the hw_params you have chosen are no longer valid.  Here
> are new constraints, please try again."

Thinking about this slightly further than in my reply to Lars-Peter a
few minutes ago...

I think just returning -EINVAL on bad parameters (which is pretty much
what we do) is sufficient for this if the driver is good about keeping
the constraints up to date.  Applications should already be able to take
the hint, though I imagine most of them wouldn't trust the drivers to
provide accurate constraints and aren't as widely deployed as PulseAudio
(which forced fixing the DMA stuff by virtue of everyone using it).
Though just spinning a small number of times will probably deal with
lying drivers well enough.

We could still generate an event but I'm now even less sure it's worth
drivers doing anything special about this.

--vdqwC0msT4ilQ2it
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZHoiAAoJEBus8iNuMP3dP4gP/R05ST351n50KepE6HkRVS0W
ewKeMKIt/LXzIrvo4vgY7r+8tiaqKaxVNwQCPCtL54QvsBmI8jjMFMLDPueb2QSr
EMZOUQP/MYYNZz/gRfOmZlQKt8maCUJw5mTGpo4IGevX94/m7b9fAM8vB6I41c1k
cf4k20MmJPfACq+9GYHRNtQa7OjceuLxR761xwlfqf9tdAejxJKcf5DbF8MO3of/
4BLcj5I4tOcEGYN+69RPbSL9emHpETmWoUwRLlNe7McoTbeGhOj9ii3Si+hT4QAl
MsqNEqGd9l8bsDMr//+MmeDlAn7bMSZBNl6QT/hSITxpHwPgnTp0HOLzZgwhXYs7
vNvG6jIcLwZ6dBfMGm1oviMNS4iu5G9DYbSHAHnU6+iK2o35DPcJE24kEs3DZTbO
lCQRaZFtqc367F0h3OVpOGKyMly4PFS8SQlDh9aRm6K+UPG/EZKP3pqoVNRFq0ud
DEfp/KdqTjFTF5mdjY1Oqh9JgC+M6jHuU9awhL5+Q/v7CYyNG5THvfc/+SbyzzBS
sHXtwHPsvhVXLRjKQxmXxJSRMhBy9yGpEyjbQRhIdZWgazq/lWk958IGdQqKRpft
mylM0SLiSl0IgAGfO/woV39bLPL0DYV9+nOj9lxS2v5CxtVGud7W0BkdtIT2Ge+a
CEz1ffT+D4B5xXSBFZmM
=cIYL
-----END PGP SIGNATURE-----

--vdqwC0msT4ilQ2it--

--===============6460477809539600349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6460477809539600349==--
