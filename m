From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 116/146] ASoC: sof: use modern dai_link
 style
Date: Fri, 28 Jun 2019 11:52:29 +0100
Message-ID: <20190628105229.GF5379@sirena.org.uk>
References: <87h893mkvi.wl-kuninori.morimoto.gx@renesas.com>
 <87sgsnfjge.wl-kuninori.morimoto.gx@renesas.com>
 <CAEnQRZBnvfuZDbnvbmqAavh9DAbA_EeRc6OuH6OOiR1WB4zUrg@mail.gmail.com>
 <8761d853-2b3f-7b26-0073-05d0c3ce1362@linux.intel.com>
 <87d0iytqi8.wl-kuninori.morimoto.gx@renesas.com>
 <288441e7-eaa7-8005-4026-97c31125375b@linux.intel.com>
 <87blyirz3j.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6233075968095917821=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 90957F80768
 for <alsa-devel@alsa-project.org>; Fri, 28 Jun 2019 18:28:16 +0200 (CEST)
In-Reply-To: <87blyirz3j.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, "Sridharan,
 Ranjani" <ranjani.sridharan@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, paul.olaru@nxp.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============6233075968095917821==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R6sEYoIZpp9JErk7"
Content-Disposition: inline


--R6sEYoIZpp9JErk7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 28, 2019 at 03:43:47PM +0900, Kuninori Morimoto wrote:

> Originally "Platform" component is for "DMA" transfer
> (But I'm not sure detail. It had been exist when I started to work for ALSA SoC...)
> But in many SoC, "CPU" component is doing it.
> Some SoC needs special "Platform" in my understanding.

Right, most systems needed a separate driver for DMA historically - they
still do but for a lot of them it's now done less visibly by the
dmaengine integration.

--R6sEYoIZpp9JErk7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0V8WsACgkQJNaLcl1U
h9Cd0gf/T04+KAAwA25BjlRZzu/+apWZ1sB1mUsOgy4LpiuX4E60Z5RNhh1xMZvD
ax/GTp7n8ZwU0ERND3jTtkyaFhCc1pNNFBdr0MU+2Er3hymrlXnrTK9DcELm05mW
+WXta28oyebItyy5WfI410ym9InuD2P+pkBX3gc+wMOxIYOyQy/c1QJoZWZre0uR
CbrFpfOr47XXwKGhlDi7RK0tg7rm40NbUbvPEIpXf0STA+zhkYRUeyuMVZIa6fQ0
KeAFrszGLbgPJM/KY8BbcN19CqZkMcErrg7erJhnmFsLqwQKxDSuKgRUsKybJZWh
sCV8qMgwLKB2/AefBhX5O2857fEg+w==
=HwUX
-----END PGP SIGNATURE-----

--R6sEYoIZpp9JErk7--

--===============6233075968095917821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6233075968095917821==--
