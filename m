From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/13] ASoC: Move IO abstraction to the
	component level
Date: Wed, 2 Apr 2014 19:23:23 +0100
Message-ID: <20140402182323.GB14763@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-11-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4195896500818679543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 632A02654FD
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 20:23:48 +0200 (CEST)
In-Reply-To: <1395129736-11938-11-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============4195896500818679543==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 18, 2014 at 09:02:13AM +0100, Lars-Peter Clausen wrote:
> We currently have two very similar IO abstractions in ASoC, one for CODECs, the
> other for platforms. Moving this to the component level will allow us to unify
> those two. It will also enable us to move the standard kcontrol helpers as well
> as DAPM support to the component level.

I've applied everything up to here on a branch topic/component but got
conflicts here - can you please check and resend?

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPFWXAAoJELSic+t+oim9vUoQAIcMgUwJf01EDl4biQmLdRI9
5EEKK9rJABFeHUyrOA41br82CdLrLatYOzZlKVbj3JxyLbjQ+0F4uthF6+Xa6ZUd
6mR+sPLDQxXQ95rw+qku3er8TwhH/OJBW5SjOcb1Ieqo9SP1Ee+ixS/bdvZ4icbs
jr3z6AzR/8/yRJtH9rh1xu5uPEw7VbEj6pABLM5AoDhd5ZkjE3U5L21bYNPVn4fz
LtIkwjMHQTqvNRaQoMWuXgjvKb7cBwD+PMoCmmXzJfm8GZ4u3E0BdjWAyDoWLkj7
4/OvMmSYPk29TWTaTVbI0QcoujMht8KiBImHbgxwrENPkfokQGmlcvpnb9vuT789
MBDwKnLTh98aEPtIVBLMzb4DPtmNm9C+pZGOFzWINvRuvhut5fpsaDdi5sJhvPkq
TGmdjS2ga20Icx3Kbl9bp+T35ufDM32jliscLi6s7O9KV+fdprOjJoQN73WVfzTw
PTuEQRgU5qUnLQWsFoqlYokXG6jDZTcO2c4QdbaKyL+RejPeGK6eO8mxcsHhCuFw
C0YQsdBz+xC1pYoF1aUioDzv8Fx3XS9Oqbf5JZBC8mquS7x5McHdVJfIdm6c0rVT
pxYzJ6T5AbtqZ5/nfu3rSfNEKTj245+QgZ1ekjaLAHCsNUiPvFNhVwV6S3K0qL6j
ys7Hu+TNkKMMCwxSsnau
=SXgL
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--

--===============4195896500818679543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4195896500818679543==--
