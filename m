From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Tue, 31 Jul 2018 14:12:46 +0100
Message-ID: <20180731131246.GC5719@sirena.org.uk>
References: <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de>
 <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
 <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de>
 <20180731101943.GB5719@sirena.org.uk>
 <s5heffjr8ys.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6807510715027043269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 770E22677C6
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 15:12:49 +0200 (CEST)
In-Reply-To: <s5heffjr8ys.wl-tiwai@suse.de>
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
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Alexander.Deucher@amd.com, "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============6807510715027043269==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Md/poaVZ8hnGTzuv"
Content-Disposition: inline


--Md/poaVZ8hnGTzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 12:32:59PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > However since it's not supposed to be providing any DMA a CPU DAI really
> > shouldn't be doing this...

> Well, if so, the CPU dai also cannot get the exact base delay
> corresponding to the reported position, either, no?

It can know how much delay it's adding internally between its input and
output, which feeds into the overall delay experienced by the user.

--Md/poaVZ8hnGTzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgYE4ACgkQJNaLcl1U
h9DswQf9GWUANKQgU6UT1mqpQLQHXWUl9Jckdv0IvNpbNN68xcHif4AWvvHQ3gaI
127uYUDWgwBdQZ7vr8DS2N0D33IzdkhB2jlWfLyueG512IGrSSSjAAI6BnKrRng9
/TEb39JwG9ITu7wDj2fdP/qK2cJ0V6YnCZtH6HTQfs2w+sn9PD+0bjgwE2GdhCy+
jABd2IgOUyKTC/zNnunIivL/1oU4aVRUCdfyKil7B6HEAhVVVB3PIB7Ow42j68JY
7B39V99ZNv0N083I30w/fQ3wzQu6IHs3iy3s5VcDgfkFWuEMcTbHNhE+OY5owuG/
NI74av/DHJ2qeTYd/RtTxqvPeJs2Kw==
=Zrxu
-----END PGP SIGNATURE-----

--Md/poaVZ8hnGTzuv--

--===============6807510715027043269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6807510715027043269==--
