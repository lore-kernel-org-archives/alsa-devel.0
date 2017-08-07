From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: compress: Remove duplicated code
Date: Mon, 7 Aug 2017 16:42:53 +0100
Message-ID: <20170807154253.sfmi6mmt4lj2d44k@sirena.org.uk>
References: <1502111504-7996-1-git-send-email-pengdonglin137@163.com>
 <CAErzpmsPRYKmu_CMPPXEohjB-dbuqux4v12t5r9-E6dV3sXnMg@mail.gmail.com>
 <20170807150714.e7aecqskfelp7h5z@sirena.org.uk>
 <9bebfae0-5fd2-bb44-18dd-d7c25f59f1b1@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8540161670780482439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 853C22672A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 17:43:00 +0200 (CEST)
In-Reply-To: <9bebfae0-5fd2-bb44-18dd-d7c25f59f1b1@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Donglin Peng <dolinux.peng@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8540161670780482439==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xgn334nw5u45tofk"
Content-Disposition: inline


--xgn334nw5u45tofk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2017 at 10:28:30AM -0500, Pierre-Louis Bossart wrote:
> On 8/7/17 10:07 AM, Mark Brown wrote:

> > Are you sure that this is the assignment that should be deleted, and if
> > so why?  Note that it's both conditionally and unconditionally assigned
> > later on...  Some words in the commit log about why this copy is removed
> > would be helpful.

> Thanks for the report. Yes, the logic escapes me as well, there were two
> separate changes from Liam and Richard Fitzgerald and I can't figure out why
> the reassignments of the variable new_name are required.

I've got a feeling it was people not working and testing against
mainline independently trying to fix similar issues and ending up
colliding when things went upstream.

--xgn334nw5u45tofk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmIinwACgkQJNaLcl1U
h9DgXgf/fwz80beI8DULccaJA2UVrjrbJOMXmCQPDYFk9SdOiuJ4N22JWCXcCOme
pp/7gCfoIf+SJFaaL/l135LwHfVibXg8in4RYByex1CHGg2QB0GkeL8EauMdYCrX
K12Qjlw/FIA+KwUbhmC1YcN39SEfZUwZ2lz+xWkY3Wy3/uXeuk5qeB5RL7i6riHb
3yxaaVwWrFx8zKzwuoCXEllkg6MPDSOar3Ou+GKjb4FSZV/IXWIFhzdUUtKqkpzX
HZtKJ//IxRXRbjwPkFVQ8pZ/nAjJoxv0F/hbafF5bMgl2C2KW3fCm2f91lLgJLAl
qEkXVv3mqxWkdhK5QcasFDJHgdim8A==
=HHm4
-----END PGP SIGNATURE-----

--xgn334nw5u45tofk--

--===============8540161670780482439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8540161670780482439==--
