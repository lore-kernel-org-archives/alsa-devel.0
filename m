From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Wed, 12 Jun 2013 16:31:37 +0100
Message-ID: <20130612153137.GI1403@sirena.org.uk>
References: <1370927416-12216-1-git-send-email-bardliao@realtek.com>
 <51B7615D.7040408@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8052171585269441727=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D138265007
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2013 17:31:42 +0200 (CEST)
In-Reply-To: <51B7615D.7040408@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8052171585269441727==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SR0DFWOzPg+ymaCV"
Content-Disposition: inline


--SR0DFWOzPg+ymaCV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 11:41:49AM -0600, Stephen Warren wrote:

> One question though: Don't you want to initially enable ldo1_en before
> you create the regmap? At least some regmap_init() calls end up trying
> to read from the device to populate the register cache, and that won't
> work until ldo1_en is active.

They shouldn't if a set of defaults is provided, though if a patch is
going to be applied then that'll write to the device.

--SR0DFWOzPg+ymaCV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRuJRWAAoJELSic+t+oim9BxoP/21p9yu0b0NStH86GfbN1dGO
41J1ucTuvH/MY0DIrXg2rkuYHr7bzYrTuG6HBPz1CaWrZkfMXcR3YY9Xdl/czIlY
7uP/Rr60oj0buJopiRIgf9yLNyUGw1ajaRxJAWqG3TqD3okLSiwJyasmmvucQfKF
5YQH+OoJtd/0ayv0ixUr2WiA/Jqtf8WFLiXbwoYPjKA4/K1+abSBjiJmZncaaZU7
SSvFmOell9v3/w7i+V7EwZ2WVF4ERRPO5kdPB8XgOW47eN0vse3VBuUnelQOziEX
Bo+ssrcznIyJ1cL6iJ6IKGdwi2/2ajve2ud95cBYIoCa/ixdOoaHj46PmsHU7TnV
AHM7SA1Xumy6tl1oGbdkqe0IGd+AXrxzTyIMtq5OLPnFiN7Svj3jQHXEhFVemciM
NQ06TaizLg25Pz7lu5tBKFicMSy4FfhYa/azPywfeiewaRiaW0FkGhNrtJLn1RUC
cr7Ilm2BLjl3PoqBbNjsRRpKW93vUZwHsq5110TydLRr5Jy5mtJhvmeBAnQsoFcP
Hk2S/gkebsSKa6bWorBZE0kGDrc+iRcB0pJrwWd3hipB98y/2g6gZvhpXycAt8hS
tlCMifPpvzYCkjQbDjRa0bo+6EXDwNuauONcPIkUTVizYP5gFi3em7Y1SFc1hYW1
lu2bkcssqJBo7jdGKwV1
=zTJJ
-----END PGP SIGNATURE-----

--SR0DFWOzPg+ymaCV--

--===============8052171585269441727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8052171585269441727==--
