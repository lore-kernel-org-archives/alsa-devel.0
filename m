From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/7] Fix year 2038 issue for sound
	subsystem
Date: Fri, 22 Sep 2017 10:15:05 +0100
Message-ID: <20170922091505.pkpe73cphjfm55mf@sirena.org.uk>
References: <cover.1505973912.git.baolin.wang@linaro.org>
 <b0390c03-ed0e-b9c1-ba34-5b55df5fabbb@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7182954030950876502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D7CB526764C
 for <alsa-devel@alsa-project.org>; Fri, 22 Sep 2017 11:15:12 +0200 (CEST)
In-Reply-To: <b0390c03-ed0e-b9c1-ba34-5b55df5fabbb@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, fabf@skynet.be, arvind.yadav.cs@gmail.com, dharageswari.r@intel.com, linux-kernel@vger.kernel.org, arnd@arndb.de, Baolin Wang <baolin.wang@linaro.org>, vinod.koul@intel.com, hardik.t.shah@intel.com, tiwai@suse.com, guneshwor.o.singh@intel.com, lgirdwood@gmail.com, elfring@users.sourceforge.net, gudishax.kranthikumar@intel.com, bhumirks@gmail.com, naveen.m@intel.com, jeeja.kp@intel.com, mingo@kernel.org, dan.carpenter@oracle.com, deepa.kernel@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7182954030950876502==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a6yc2ov6s73s4vmq"
Content-Disposition: inline


--a6yc2ov6s73s4vmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 22, 2017 at 01:07:37PM +0900, Takashi Sakamoto wrote:

> I note that at a development period for v4.5 kernel, ALSA developers
> (mainly Iwai-san) fixed x32 ABI compatibility bugs. Then I prepared for
> a rough set of test for ioctl command[3] to check his work. The set will
> partly help your work, I think (but it's really rough).

Might it be worth trying to get these added to kselftest?  Seems like
the sort of thing that fits well there and it'd make it more
discoverable.

--a6yc2ov6s73s4vmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnE1JUACgkQJNaLcl1U
h9Dh1Qf/c9lrJ6jKhqmOsRcf6ZKo8gXUaYI8LU1h8JiSPF2jWEQSmuL9sCbcHsJi
DhzYbqQzn6haLeHY7/5PsAJShXcgNc99Lf/C8yR+W5hLpZ31+ACGVTXfe+PdkoZn
3w09KmMJm1wptDKPfbAwJafMD03kBxH0J92Nvf/6ygH8yj3rUObEI0Qa7mDXjyNO
NXvR0JgcAInacDf94d/UL7X6OjYZax5J+skSQJ3as8OrEOIwx7ekFA5vEoJ4m9EW
genY1JDvB8qMZW0T98thQkEPPL3R//qpkH8omtCdvAZ7R8LzVsqfd9es9ga+PvQN
EGLBzsezM7OQtHOPfp7VYF26oIGsiA==
=EqKT
-----END PGP SIGNATURE-----

--a6yc2ov6s73s4vmq--

--===============7182954030950876502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7182954030950876502==--
