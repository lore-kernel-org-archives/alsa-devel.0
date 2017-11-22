From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/7] Fix Intel audio Kconfig issues
Date: Wed, 22 Nov 2017 11:54:38 +0000
Message-ID: <20171122115438.47ffg7tlfxnjczvv@sirena.org.uk>
References: <20171118000202.22302-1-pierre-louis.bossart@linux.intel.com>
 <s5ho9o07xbr.wl-tiwai@suse.de> <s5hwp2jtv4z.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5215364906421863438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E6EBA26702F
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 12:54:45 +0100 (CET)
In-Reply-To: <s5hwp2jtv4z.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, vinod.koul@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com, torvalds@linux-foundation.org
List-Id: alsa-devel@alsa-project.org


--===============5215364906421863438==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="torrh2y66yvysifd"
Content-Disposition: inline


--torrh2y66yvysifd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2017 at 06:10:52PM +0100, Takashi Iwai wrote:
> Takashi Iwai wrote:

> > FYI, I've put these to a test branch, test/asoc-intel-kconfig, so that
> > 0day bot can catch issues.  Let's see.

> No news is a good news, it seems that your patchset doesn't break
> builds, at least.  Let's go ahead!

OTOH there's a bunch of "I'll fix that in the next version" stuff in the
thread and the immediate issue got fixed already - I'd been expecting a
new version.

--torrh2y66yvysifd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloVZX0ACgkQJNaLcl1U
h9CiIgf/YG4Eqge+GMfz30/kBkkXxZe1924GvlDHuUO0HZZlK97q8Vmf6qHrlaXU
nIMt3PM0zcQMnVp3jhZ0TRI8Efqi32LQmJ25GYp4W5iaB8nUhNMrLWiDW9Vh8Zls
Z0Sx8c7OGToiXYi05Qu3T9BvItFNsF2hjJnBcCW4WNlPner5x4/C8hmf/Zz/31Di
hBuE0sQbUatRdrBF6CrlKaahqZCNkJv+bSkV1ABDQcAISgZVFNL1sW01ZvxyY+XA
25a+DZRaOKHJuJhUmvgX/QiSU29dUUxW2l1Ywgry+zXBSxOAIU9GblTn70yzwtVc
s9tUQSZq+Ik9CuawQxXPEYMItwtwqg==
=f8mO
-----END PGP SIGNATURE-----

--torrh2y66yvysifd--

--===============5215364906421863438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5215364906421863438==--
