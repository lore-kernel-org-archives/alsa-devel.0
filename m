From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/13] Enable HDA Codec support on Intel
 Platforms
Date: Mon, 4 Jun 2018 14:33:18 +0100
Message-ID: <20180604133318.GG7536@sirena.org.uk>
References: <20180602035401.26934-1-pierre-louis.bossart@linux.intel.com>
 <s5h603136ni.wl-tiwai@suse.de>
 <1c445079-c5c6-8c70-ebcf-f1eabb7616e8@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2771301022671786087=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BB8B267A13
 for <alsa-devel@alsa-project.org>; Mon,  4 Jun 2018 15:33:26 +0200 (CEST)
In-Reply-To: <1c445079-c5c6-8c70-ebcf-f1eabb7616e8@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, rakesh.a.ughreja@intel.com, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2771301022671786087==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Content-Disposition: inline


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 04, 2018 at 08:27:18AM -0500, Pierre-Louis Bossart wrote:
> On 6/2/18 4:00 AM, Takashi Iwai wrote:

> > - The new hdac_hdmi codec support and the new board codes

> > These are the new stuff, and applied after the preparations above.

> I can split the code, but as you highlighted the series is pretty much
> organized as
> - cleanups
> - code split
> - addition of new functionaliy
> - fixes
> ...

It's generally better to put fixes first - that way there's less chance
of them getting held up on earlier bits of the series and they can be
more easily sent to Linus and stable if required.  Like Takashi says if
they're not dependent on the rest of the series sending them completely
separately is often even better.

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsVP50ACgkQJNaLcl1U
h9BCVgf9HKfndulbMOzxs+U77vbrmVTeG2Ql0hev6up+KyRVCsSeLGD2+pXKGhVa
uktiSOTvhPwsBIfefXXxF0QGisYfDEyomKhuypc3EuJiYxoM8dCAkf4C94gJiZgh
BTXFnmoEVTSCb/StSEk6rLFG26YRx1PcHTzBavHDm5L5I2lSYOq9NB7PaXXGL2sh
JQeu6C+4KElGKLlwu/3BJX9gHp+aV1x++m+PG/1TptaFWpL4yHQZSas5sYD8hac7
MwLj/5IsVuLfD3ZWCXj4yspLElBMmWCangaoNVIdfIfxoiGML61RlSf8z4On40/j
/IGkx/qaL2243faJs+yEHdDpKmpMKg==
=+Lxt
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--

--===============2771301022671786087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2771301022671786087==--
