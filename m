From: Mark Brown <broonie@kernel.org>
Subject: Re: [asoc:topic/max9867 2/4]
 sound/soc/codecs/max9867.c:294:11: error: 'component' undeclared;
 did you mean 'complete'?
Date: Thu, 1 Mar 2018 20:04:30 +0000
Message-ID: <20180301200430.GA23704@sirena.org.uk>
References: <201803020314.sOjeazAH%fengguang.wu@intel.com>
 <20180301200155.GA2304@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4395220254469870484=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 643F1267C0C
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 21:04:38 +0100 (CET)
In-Reply-To: <20180301200155.GA2304@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============4395220254469870484==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 09:01:56PM +0100, Ladislav Michl wrote:
> On Fri, Mar 02, 2018 at 03:45:16AM +0800, kbuild test robot wrote:

> >    sound/soc/codecs/max9867.c:294:11: note: each undeclared identifier is reported only once for each function it appears in

> your topic/max9867 seems to be 4.16-rc1 based, while patch was tested
> in today's -next. Fixing it for 4.16-rc1 would mean it fails to compile
> once you merge topic branches.

> What am I supposed to do here?

Which other commits in my tree does this depend on?

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYXM0ACgkQJNaLcl1U
h9CMQgf/Qv/R7eHfMYuOMJ5NLpMtrQESDclA83alyao6YWFsXnGEolRZvKzfA5Ig
H3sl6vwzA04qOzAefPNgqfHVGsXXgcppcpJ+UzdKKmlu/TP6Uv2F+T6NWLTwgNil
hrYhl+9ydDSehwGxJhzWF0SN2R/Qd6h5ZkbYn3Sjb6b1hAHjEGfbWJD06Et4h9Tj
l0FLM/moY6ju63jl8RqM/NcDqO7kzu5Jgjb+VdOzH6wFwRD1S/j0aaZAroONgeOt
A+ZU0IAyZkktWvja64g5o1RNUdQyYDS2I29KLY5eb+jkV/FNBnWnHqLhtoQMUVSn
4DOhUTGXlgKEwwjh+MVY6xAgmbQbPg==
=zo+O
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--

--===============4395220254469870484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4395220254469870484==--
