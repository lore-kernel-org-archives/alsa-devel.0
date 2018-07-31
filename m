From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Tue, 31 Jul 2018 11:19:43 +0100
Message-ID: <20180731101943.GB5719@sirena.org.uk>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de>
 <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
 <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0778855904880507317=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FEBB267365
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 12:19:46 +0200 (CEST)
In-Reply-To: <s5ha7q721vs.wl-tiwai@suse.de>
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


--===============0778855904880507317==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 11:25:11AM +0200, Takashi Iwai wrote:

> It's not necessary that all CPU dais provide the pointer callback.
> My suggestion is that, if CPU dai *wants* to provide the base delay,
> it must be tied with the position value, hence it should provide the
> pointer callback.  If CPU dai has a pointer callback,
> snd_soc_pcm_pointer() skips the component pointer callback but uses
> CPU dai pointer callback instead.

However since it's not supposed to be providing any DMA a CPU DAI really
shouldn't be doing this...

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgN74ACgkQJNaLcl1U
h9CQ4gf/RXoOOGmwEbj68LmfJRHuo044hHK6wY62bwec5FoeGWMy9Pk3rvq7tvHc
f/7DFEYQRTB/d4cyEDUQiqm1eHIFhI8sohOWaRWJr28k8eQYkM1uA8KxJ5b11OF3
LQKCNqhLjVYpi+MgVJAe4OqE4t3B5tCwVzXfBZsI2zFeFBJztMYw9gcly/dpIhVt
3PVTpXzPcQckxgu/e9Edc5lOmEEL9uid+xEH0jpgq8I1OI1gBu/pJqME3+N/iGwF
SetGm1Z53pPTbn1+Kxy5PLnrSuxbKEB3pPxnIJOHCIlGnwaTzbzg0iTPg545fh35
fK6d90zXpQBsJr6i4clAskVJAoZEOA==
=S/fZ
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

--===============0778855904880507317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0778855904880507317==--
