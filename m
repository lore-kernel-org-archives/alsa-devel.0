From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Tue, 31 Jul 2018 11:03:15 +0100
Message-ID: <20180731100315.GA5719@sirena.org.uk>
References: <1532686422-1790-1-git-send-email-akshu.agrawal@amd.com>
 <66c8b8c4-bdd0-0129-5e5b-850890cfdb8d@linux.intel.com>
 <e0990b62-897c-6dc7-8ac9-296932c505b7@amd.com>
 <dd4d3dc6-88f3-d53f-cd5c-5035c80be3da@linux.intel.com>
 <s5hy3dsviwq.wl-tiwai@suse.de>
 <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1299647483254563051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4021C267365
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 12:03:23 +0200 (CEST)
In-Reply-To: <s5hwotc0y6v.wl-tiwai@suse.de>
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


--===============1299647483254563051==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 07:30:16AM +0200, Takashi Iwai wrote:

> OTOH, if the CPU dai can really provide a dynamic value that is
> strictly tied with pointer, CPU dai itself should provide the pointer
> callback that covers both the pointer and the base delay, and it
> should be used instead of component pointer callback.

Probably anything in the SoC would be potentially able to get a dynamic
value out - the main issue for off SoC devices is the cost of getting to
the data but that's not an issue when you're memory mapped.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgM+AACgkQJNaLcl1U
h9DIFAf+Iq4OJr53hDh+Gkgyws3gyviprKD6tvTQmBGujYIymIGGdQ0MxxRG2rGN
eKs9uHn/8fUVsQbwBIKa6oOgvRpaNLcVZ7KCD9RbHAv6nmcsOOdNXFgnP/Wki2lP
xB0g+TCwZwOt2NC6kPyDInk7CP4Pt1pNJbD9efRnJl2XvlaCTSFCWgXdUnQ9VRT7
6SkIYTMbj4ZwKZn3WhV5AS65JIF+JRc3T+d+nX/WLOztXurwqIeMjLdiIkXei7cn
yNxFgB5TZ8kpXPgrLdAHZjz3NUruixK6iscFbJxuXiw/FSyl5iysbeK5zM7plHuP
7gIPXBgphQhcYA80WBDOZ0QArh6jlw==
=fPkA
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--

--===============1299647483254563051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1299647483254563051==--
