From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm8741: Fix setting BCLK and LRCLK
 polarity
Date: Fri, 3 Nov 2017 18:02:51 +0000
Message-ID: <20171103180251.wa2pup4teyl67ml5@sirena.co.uk>
References: <1509628982-9767-1-git-send-email-sergej@taudac.com>
 <20171103114526.hjjmkkmkbxmotkpo@sirena.org.uk>
 <403c4e22-7caf-0a31-90b8-46586f8f53a1@taudac.com>
 <20171103172049.d5o3qy54b5ci5jhe@sirena.co.uk>
 <fe9f4e8d-12cc-7d50-0a9f-01b39961c3f4@taudac.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0210019221778284539=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 05FA8266CFB
 for <alsa-devel@alsa-project.org>; Fri,  3 Nov 2017 19:02:55 +0100 (CET)
In-Reply-To: <fe9f4e8d-12cc-7d50-0a9f-01b39961c3f4@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: ce3a@gmx.de, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0210019221778284539==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="acwn2jjct6qnvyvq"
Content-Disposition: inline


--acwn2jjct6qnvyvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 03, 2017 at 06:38:26PM +0100, Sergej Sawazki wrote:
> Am 03.11.2017 um 18:20 schrieb Mark Brown:

> > > It applies against "for-next" (e67852427fb). Is it the wrong branch?

> > It didn't apply against my current for-next branch when I tried, are
> > you sure you were working with something up to date?  I don't even have
> > a copy of that commit locally, even in the reflog...

> > In general I apply things against any existing topic branch for the
> > part, or against any fixes branch, or against Linus' tags.  Exactly what
> > depends on what kind of change it is and if there's a branch already
> > there.

> That commit is the head of my current for-next branch:

> commit e67852427fb5e3ea794302f2d0b2939e07aca8cf (origin/for-next)
> Merge: 16632a3 a10953f eaf8abc 6bd25aa b614583
> Author: Mark Brown <broonie@kernel.org>
> Date:   Fri Nov 3 12:49:29 2017 +0100

Hrm, so that's newer than what you sent against...  I did try for-next
at whatever point I was building things up and it didn't apply cleanly.
In any case, like I say you need to resend.

--acwn2jjct6qnvyvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln8r0oACgkQJNaLcl1U
h9BV6Af9FRmymSFY/fd7h9B64HqNDb0uw3BMkQLJ5ygjDhYaE3CTdP4tpoltAqYB
u1CuMHfZ1vPJ0r/19lbfrg2d2PNCr4AFnQe3Xt0iWK3XBOD1D+KniWGvF5/o4jth
017RhAyxKtuHLZ90svfbwacB/sN7stAkHM1JKNzrjuXH43RLI1/i/pr7fYVTstsu
P37IsEvOfUVReDC/u9E2IMuuG+9T+QJrMeOGqUHhKC5EuYdDbprOQlL94R9V8jaY
i2TSTrdfgVLdvSUSTKByU+9TZvR8cZgH3aXoCq3tDTt9hAejBFaGPGLWCssg9D4d
DnkPDLoLw8hCjp/rCch8B3O1KoW/hg==
=KvHI
-----END PGP SIGNATURE-----

--acwn2jjct6qnvyvq--

--===============0210019221778284539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0210019221778284539==--
