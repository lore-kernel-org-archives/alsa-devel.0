From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 11/11] ASoC: amd: enable acp3x drivers build
Date: Tue, 13 Nov 2018 11:45:17 -0800
Message-ID: <20181113194517.GM2089@sirena.org.uk>
References: <1542000903-19020-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1542000903-19020-12-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8192111937084438420=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BED4C267A61
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 20:45:25 +0100 (CET)
In-Reply-To: <1542000903-19020-12-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vishnuvardhanrao.Ravulapati@amd.com, Alexander.Deucher@amd.com, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============8192111937084438420==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vTfKKTivj/mQoluA"
Content-Disposition: inline


--vTfKKTivj/mQoluA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2018 at 11:05:02AM +0530, Vijendar Mukunda wrote:
> ACP3x drivers can be built by selecting necessary kernel config option.
> The patch enables build support of the same.

Apart from the SPDX headers this all looks fine so I've applied it,
please send followup patches converting everything to SPDX headers.

--vTfKKTivj/mQoluA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvrKcwACgkQJNaLcl1U
h9Bragf/VRhhS03dy0CO8cJ4szZu8pDQNzib4mOabLCFqlvyZcEEJLHf/dwPsljS
avYm1xO/PwI5pa/stGeliZUzkanQjZOPNhDcW9dZ6fXG2Q6KmR7ZsQaVY1UIdBxb
fHYz9lQjueakYg0Cb6LFxmVA6ooXtiJkC0xekqh4GUEzCLXLPugK/x9HVPE9S7HK
CicfPuvGJqyK+LO0bXdUQU1/h3UorOyClbZRhLlBCtLy2G/N+Vsp9PV+aaA9OtLI
y2si+8Ms14Nb4X7WhMixinUTF2ggdASem3vb/VfIlT8pPSraMwm+5makHS1UgF9h
JKg/9K8usJr8rSKjgAmBrWZqA5SPjA==
=XiPi
-----END PGP SIGNATURE-----

--vTfKKTivj/mQoluA--

--===============8192111937084438420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8192111937084438420==--
