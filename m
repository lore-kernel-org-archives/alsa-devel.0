From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: Make soc_dpcm_debugfs_add()
	non-fatal
Date: Thu, 9 Apr 2015 11:44:09 +0100
Message-ID: <20150409104409.GT6023@sirena.org.uk>
References: <1428569558-15883-1-git-send-email-lars@metafoo.de>
 <1428569558-15883-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6414987816871045495=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66F4A2657BE
 for <alsa-devel@alsa-project.org>; Thu,  9 Apr 2015 12:44:20 +0200 (CEST)
In-Reply-To: <1428569558-15883-2-git-send-email-lars@metafoo.de>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============6414987816871045495==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rhFcA3qSmEuZzUxm"
Content-Disposition: inline


--rhFcA3qSmEuZzUxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 09, 2015 at 10:52:37AM +0200, Lars-Peter Clausen wrote:
> Failing to register the debugfs entries is not fatal and will not affect
> normal operation of the sound card. Don't abort the card registration if
> soc_dpcm_debugfs_add() fails.

Applied, thanks.

--rhFcA3qSmEuZzUxm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJlf4AAoJECTWi3JdVIfQiGAH/1w7Tf2aR1BpsKPFwZ0j8bBn
GgbtTqYn3UOYN0euoXYfiTPCNKzcxBhmswLXpbQ04d/S/MHTiYKvubkQM1lNx9jo
Z31fwPAkGhjXLPwIJAg4hro6JKmTKtVIYo8blQWDgBFprgm5a9wWDY2eo6Zo65h6
HNvuKz8TcwwXNAeBchg3OAseebS1CyoYj9eZE57Bw1hUbyTriwDUXZbxG1MBjaP9
ygLa0VmtFhy6L3K3ak73WQwP7GRsK1R0F17WGDj74IOTLyG6mheX8xzrMTI02oc5
3RaExt3H5If4Z8k0OJ90OHdsUxQshBPdHaElOc879L7Jp91qfAiwSbgPRWUb0pE=
=ZSFk
-----END PGP SIGNATURE-----

--rhFcA3qSmEuZzUxm--

--===============6414987816871045495==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6414987816871045495==--
