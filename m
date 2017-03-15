From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8960: Use physical width for
	bclk
Date: Wed, 15 Mar 2017 13:33:18 +0000
Message-ID: <20170315133318.qo7fpoffmyh2chmz@sirena.org.uk>
References: <1489510622-30981-1-git-send-email-daniel.baluta@nxp.com>
 <20170315091901.GF6986@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2371939474319376859=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ED41266861
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 14:33:36 +0100 (CET)
In-Reply-To: <20170315091901.GF6986@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, viorel.suman@nxp.com, mihai.serban@nxp.com, tiwai@suse.com, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org


--===============2371939474319376859==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c5756h73xogkajuw"
Content-Disposition: inline


--c5756h73xogkajuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 15, 2017 at 09:19:01AM +0000, Charles Keepax wrote:
> On Tue, Mar 14, 2017 at 06:57:02PM +0200, Daniel Baluta wrote:

> > -	wm8960->bclk = snd_soc_params_to_bclk(params);
> > +	wm8960->bclk = params_physical_width(params) *
> > +		params_channels(params) * params_rate(params);
> >  	if (params_channels(params) == 1)
> >  		wm8960->bclk *= 2;

> Would quite like to see Mark's thoughts on this. Feels a bit to
> me (although I am not certain) like we are solving the problem in
> the wrong place, isn't this really setting the desired BCLK and
> then in wm8960_configure_clocking we should set the lowest BCLK
> we can that is greater than or equal to the desired.

Exactly, this is the wrong fix in the wrong place - if this is something
we want to do we should be doing it in the shared functions so all
CODECs get the same behaviour but really I think Charles' suggestion
makes more sense.

--c5756h73xogkajuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljJQp0ACgkQJNaLcl1U
h9Cv0gf/a8ShsGPV26/iBsJOD1gVi7D/XkPV6qoqKhaq3KeM9F8QlaJfGFCevfcz
A/YdOJgxRI/kW6bq/9zpebXKUeVY3/t2YfuKeNY5YIfwwhSuQPjaxPWsStTbiMO7
Eb0fppv6E1cAWC7+5WWP6IZPaAtRMbJQqyGqrGXszbqxWESkBtrC/EwakZnXZJwM
JpjxCNybVxCCybMCLO7kxz8O8EFKHg4DFIhBuwvLMYD8Hqc9JaAGd/2q8O9RK4ZU
h1f0/ZsZIZTiK2yyfgImYRLX+pGF3YaSo5YWd7iM/wIVXDo/wgRiPwWeWPd3DHRt
z1pkDItSFMHFmx6vnrNHMXrEZ5zAKw==
=wX7S
-----END PGP SIGNATURE-----

--c5756h73xogkajuw--

--===============2371939474319376859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2371939474319376859==--
