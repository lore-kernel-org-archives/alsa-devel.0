From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: ak4671: Fix control-less DAPM
	routes
Date: Thu, 5 Mar 2015 01:00:05 +0000
Message-ID: <20150305010005.GD21293@sirena.org.uk>
References: <1425042784-727-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7413570943801604724=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CA3C2652C3
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2015 02:00:23 +0100 (CET)
In-Reply-To: <1425042784-727-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============7413570943801604724==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9ADkAvBByvksSl5n"
Content-Disposition: inline


--9ADkAvBByvksSl5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 27, 2015 at 02:13:02PM +0100, Lars-Peter Clausen wrote:
> Routes without a control must use NULL for the control name. The ak4671
> driver uses "NULL" instead in a few places. Previous to commit 5fe5b767dc6f
> ("ASoC: dapm: Do not pretend to support controls for non mixer/mux widgets")
> the DAPM core silently ignored non-NULL controls on non-mixer and non-mux
> routes. But starting with that commit it will complain and not add the
> route breaking the ak4671 driver in the process.

Applied all, thanks.

--9ADkAvBByvksSl5n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU96qUAAoJECTWi3JdVIfQdzoH/1icJuA4z1fbo72bo5A/G3IT
Ztv7LKhyXVWKAYReamCIEbn1BKA5GQKd9YcTfXWAGnvZT6jb05+Ghq0Ss/LQN4yO
pro7xMxu6qhg5tvbyyjGiHYIqbJ0Z6IA16YXvAOYTpDaRW9/RmCEYQyYK5Ttj3JP
uJIsSQkpTiehtgTpCMb57JR5ECGjEO9ZgzLe6Blvf5zZLeVRcNkWojn7vqjfkubs
7JInc5CySerQYh5PYxILjNyrABsoniMgWp0ynMbUfVMGmQAAI2fWfsR8wg2JKU0P
WVlq47wUfj/tSnNAdTFoRG9DPYGJrNa1qB9RYrNJaGbROj8LpD0fyjd2vLiY70s=
=Kess
-----END PGP SIGNATURE-----

--9ADkAvBByvksSl5n--

--===============7413570943801604724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7413570943801604724==--
