From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: Adds rate and channel
 constraints for capture in Stoney rt5645
Date: Tue, 19 Dec 2017 10:01:16 +0000
Message-ID: <20171219100116.GF8563@sirena.org.uk>
References: <1513572020-7689-1-git-send-email-akshu.agrawal@amd.com>
 <20171219093138.GC8563@sirena.org.uk>
 <96b00588-76d4-7174-eddf-b00a9dc3c253@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8944877512684408081=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 63AFE266D71
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 11:01:18 +0100 (CET)
In-Reply-To: <96b00588-76d4-7174-eddf-b00a9dc3c253@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8944877512684408081==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
Content-Disposition: inline


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 19, 2017 at 03:25:16PM +0530, Agrawal, Akshu wrote:
> On 12/19/2017 3:01 PM, Mark Brown wrote:
> > On Mon, Dec 18, 2017 at 10:10:20AM +0530, Akshu Agrawal wrote:

> > > Constraints are added as we support 48Khz and dual channels.

> > Why is this platform more resticted than other platforms - what's the
> > limitation here?

> The above restrictions are for capture. In Stoney host we are supporting 8
> channels and 96Khz for playback and 2 channels and 48Khz for capture.

So this is just a different SoC not a board?  Why not just register a
DAI with the appropriate constraints rather than add extra constraints
in hw_params?

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlo442sACgkQJNaLcl1U
h9CgYQf9Gw1V5Q0hEqjhb3GV0SmrPjXfnT4rIhY84Gm66e3AUB/8xsrJFiq74F4w
gWku7WYwKPr6gzU1wvAMdrwVtDBTrusMw9yhFkGcMkHAZ/O95hT/iovcKgSWGrI0
RF/mIHzs+B1vBLq4a0EslF1BuIDrSmyc9BMbR5NdCMfBeYvgLL0bcSMkmhJ0c/5d
i1NuDWYcyCtSe5dJAtO8Bs32e2t8Dfaw6U0mTV5VLrGxI7lXMf75jEbb88UKo/ta
XDQmDL7cYzb8ky2KgEPE42GrL9j1ZWf8vF9KSwH33nA3BCcUIBypoqlfYsFjqJTr
4afcYpsa9NuFPBBGZiGBdjljpiMm3g==
=gI9g
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--

--===============8944877512684408081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8944877512684408081==--
