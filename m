From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: Use delay set in pointer
 function
Date: Tue, 31 Jul 2018 15:40:52 +0100
Message-ID: <20180731144052.GF5719@sirena.org.uk>
References: <7a88c7b4-d31d-b044-bb8e-a866d49d1256@amd.com>
 <s5hwotc0y6v.wl-tiwai@suse.de>
 <5b3249cb-6212-6a14-b644-7548cf0ad00c@amd.com>
 <s5ha7q721vs.wl-tiwai@suse.de>
 <20180731101943.GB5719@sirena.org.uk>
 <s5heffjr8ys.wl-tiwai@suse.de>
 <20180731131246.GC5719@sirena.org.uk>
 <s5hin4vpm80.wl-tiwai@suse.de>
 <20180731135115.GD5719@sirena.org.uk>
 <s5hd0v3pkyj.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4182362663285766251=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 21F55267763
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 16:40:55 +0200 (CEST)
In-Reply-To: <s5hd0v3pkyj.wl-tiwai@suse.de>
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


--===============4182362663285766251==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eDB11BtaWSyaBkpc"
Content-Disposition: inline


--eDB11BtaWSyaBkpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 31, 2018 at 03:56:52PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Yes.  I'm saying that if the CPU DAI thinks it can figure out the base
> > delay something is confused.

> Then basically Akshu's patch does the correct thing, I suppose.

I think so.  Could perhaps do with a little clarification though.

--eDB11BtaWSyaBkpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltgdPMACgkQJNaLcl1U
h9C+jwf/bx01Tp500sjkgbIdsaxeTZg926yRoXNkQsXYnb2f/Tl7JW3vKpEBrYUl
tYubOD9m/3XZ7tJOrfn37h03VL4R/Y7Ykx2s3cCDutdiGzaDLMktAxd1c9I9/m/Y
Sp0BS0HJM5rgLk14PObW3E4xxsuxURg6WMP1HRX6Xps1A4yDP6hakNv9fpEHQ6fb
YJuj+zMk3f8feeVIWkMl3HlCTaIRz2dMEfJEZnxfdhW82BMv7HQAlIVWg/axGlWI
gSWxMqARvCOTWGrIvJjRiD1wtI8+MnDGHAe758TC9jcoeXQ0JoxkFIyDbPH6SRZ9
RkdpuibywAcb3hmc7DSIDGJGH4dXmg==
=bkPk
-----END PGP SIGNATURE-----

--eDB11BtaWSyaBkpc--

--===============4182362663285766251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4182362663285766251==--
