From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Tue, 31 Jul 2018 14:51:15 +0100
Message-ID: <20180731135115.GD5719@sirena.org.uk>
References: <s5hy3dsviwq.wl-tiwai@suse.de>
 <20180730155030.GP5789@sirena.org.uk>
 <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
 <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de>
 <20180731101943.GB5719@sirena.org.uk>
 <s5heffjr8ys.wl-tiwai@suse.de>
 <20180731131246.GC5719@sirena.org.uk>
 <s5hin4vpm80.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0601005173396765139=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5CFDC267365
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 15:51:17 +0200 (CEST)
In-Reply-To: <s5hin4vpm80.wl-tiwai@suse.de>
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


--===============0601005173396765139==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 03:29:35PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > > > However since it's not supposed to be providing any DMA a CPU DAI really
> > > > shouldn't be doing this...

> > > Well, if so, the CPU dai also cannot get the exact base delay
> > > corresponding to the reported position, either, no?

> > It can know how much delay it's adding internally between its input and
> > output, which feeds into the overall delay experienced by the user.

> But isn't it merely the additional delay that should be applied on top
> of the existing runtime->delay?

Yes.  I'm saying that if the CPU DAI thinks it can figure out the base
delay something is confused.

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgaVIACgkQJNaLcl1U
h9Dc/gf8DM00LYsmfSfREWDEZOQ1LLvo4bi8nuYkoSUTGC/fkCvSgUj732kSvkAY
aPaZqrlhMZf+aedlU2+8TCRu/MMUszefetX6N8/gYBAmHWS2Bo2mEnljNZD+zrP/
oisktLeeIK0W5HX7Rafoij3KM79QqD2VZusExUGH+GIVKuj6bWmIx2kBjULSsuft
XCJWmWiYx9KlM2WQR0djpW+5NPKbymLVmcYgPRcR21reY8umeG2z9noMrtIcaNYy
mdH7ioFzJ5aqdgK90AMoFgj+apDhcdhC8D8gkxQhV6EmiwxrelanrTSnQ7N6EtMh
LcM8hvc1692eypMzlAYeCRBrEbF+OQ==
=baWl
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--

--===============0601005173396765139==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0601005173396765139==--
