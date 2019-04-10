From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: cs43130: fix a NULL pointer dereference
Date: Wed, 10 Apr 2019 12:42:56 +0100
Message-ID: <20190410114256.GN6106@sirena.org.uk>
References: <20190315035120.25913-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v541l457l4DThMFo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190315035120.25913-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Kangjie Lu <kjlu@umn.edu>
Cc: pakki001@umn.edu, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--v541l457l4DThMFo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 14, 2019 at 10:51:20PM -0500, Kangjie Lu wrote:
> In case create_singlethread_workqueue fails, the fix returns
> -ENOMEM to avoid potential NULL pointer dereference.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--v541l457l4DThMFo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt1r8ACgkQJNaLcl1U
h9CeYQf/aYGE0HNsqPGPQ626dW6VPCc+lT4dA/WjxpXpnG2IV9DWJOPw5UC8fdzP
AlsOdyaxtt7oJkDqAl+mLfkfE9/dniCEmIqGJgfxTN7p0ztIxW1tYuFNwtb+0ULv
QyQMA9b43cFGiMjunrgW8pEir9wiANgDm6fCl0ezP56R//V91I9EFOXKHEBrOo/z
Jr8CmKv/Y8u7i1dJbdzXQAS07oqGhiUKePUmv5Pns8LcogNa0GrK/ztYFokU41gr
oywnMium81E5XmVf5ug4cE/Y4f1aGXQJZpdDTXw71jnlTVSwE9MU8vubsaKReNbT
1MpGpkmLJtIQz8AE3pHwtivrOqypJQ==
=8xzx
-----END PGP SIGNATURE-----

--v541l457l4DThMFo--
