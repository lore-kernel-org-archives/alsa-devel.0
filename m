From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: soc-pcm: Allow to specify
 unidirectional dai_link
Date: Sun, 1 Sep 2013 16:29:58 +0100
Message-ID: <20130901152958.GH3084@sirena.org.uk>
References: <1377783134-23528-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9185778725388108611=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BDD1260863
 for <alsa-devel@alsa-project.org>; Sun,  1 Sep 2013 17:30:04 +0200 (CEST)
In-Reply-To: <1377783134-23528-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============9185778725388108611==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EdRE1UL8d3mMOE6m"
Content-Disposition: inline


--EdRE1UL8d3mMOE6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 29, 2013 at 10:32:13AM -0300, Fabio Estevam wrote:
> Add 'playback_only' and 'capture_only' fields that can be used for specifying
> that a dai_link has a unidirectional capability.

Applied both, thanks.

--EdRE1UL8d3mMOE6m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSI11zAAoJELSic+t+oim9OasP/2JN/tNciV5mS73BGo2fl/Hf
tFgLUYJ2fvkrq9Yox7zT0kEGZtuGD6UzFNElI5NvoYuADjFQZ75xbgetxERo+O6m
PVGV9prhWs1Rd0Tp1g0KEQSijRu1YntYeBzNxmibGAbbLsnJW2ls28sISjOJ7QUD
kKAmtEiCsB5f0Z8Sk6wS1PjSwCMTfVn5KzTw4q9baIYYNzuKqSGC/DGZkP/GdmaE
kPcW0ywIN9eGhOGoy+L4mHnRB5GmyIMJFRMjEO+BoRwqWDTZq+F4LydcMXoWPiBQ
1/pwT8jh7cPFs0R84yGJwKyWc9m6w//gUnoK5snq6S/xDOItVFRkmlp4vjo9FRhU
sGQDULJE4Tm/+8pBPvLldT0flUuWecIwu2EQO3wzPTSuLjMFOqN/4rPVSPCjeRuI
TZCu7rSKlMO/etEroTmEoKxPOshMb37BjLggWWjyuIWBFcOOxuMxMRMiRNPO71C+
4KLu45kKajtmzvvRWAm8MwrohIzEp9MRu3KVH5wC8rIs2qazye+ZdPDjcZEvJbcb
3D333nA62OmMf1/aAyVx2RAz0Y9IdmMpE+J/2oKGHbsNlNBm/WmLUUieAi57gyyR
eJS7Hq8cgBvdoos7fuORodxWYMPHPk+9erlEkkke4NwQAtRlSEGvLzNP7NF+Ukkf
h6qVwqPNdhE8Fa9oX/fv
=6Wjr
-----END PGP SIGNATURE-----

--EdRE1UL8d3mMOE6m--

--===============9185778725388108611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9185778725388108611==--
