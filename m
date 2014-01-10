From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_esai: Add ESAI CPU DAI driver
Date: Fri, 10 Jan 2014 12:04:39 +0000
Message-ID: <20140110120439.GG29039@sirena.org.uk>
References: <1389265078-16256-1-git-send-email-Guangyu.Chen@freescale.com>
 <20140109184453.GP12858@sirena.org.uk>
 <20140110023252.GA16467@MrMyself> <20140110023537.GB16467@MrMyself>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3664362037257745689=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CA49260307
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 13:04:58 +0100 (CET)
In-Reply-To: <20140110023537.GB16467@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, shawn.guo@linaro.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, tiwai@suse.de, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, timur@tabi.org, lgirdwood@gmail.com, robh+dt@kernel.org, rob@landley.net, galak@codeaurora.org, grant.likely@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============3664362037257745689==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fCcDWlUEdh43YKr8"
Content-Disposition: inline


--fCcDWlUEdh43YKr8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2014 at 10:35:39AM +0800, Nicolin Chen wrote:

> Resent this because of losing attached file.

I don't think your previous mail got sent at all, or at least it must've
been caught by spam filters here...

> On Fri, Jan 10, 2014 at 10:32:52AM +0800, Nicolin Chen wrote:
> > On Thu, Jan 09, 2014 at 06:44:53PM +0000, Mark Brown wrote:

> > > Why does the machine driver have to do this by hand, being able to
> > > override is fine but having sensible defaults is easier?  Or does it
> > > actually do that and the comment just needs updating?

> > The divider part of ESAI is pretty complicated due to caring about three
> > configure bits - ETO, ETI, HCKD. (I've attached a diagram to this mail.)
> > So setting sysclk() alone is not enough to take care all the configurations.
> > That's why I designed these two interfaces at the first place. And it should
> > be hard to find a default situation.

Why is the machine driver going to be able to come up with a sensible
configuration then?  It's OK to support overriding the configuration
where needed, my concern is about providing a default.

> > But there is one approach to omit this calling for machine driver is to do
> > the set_bclk_ratio() at this CPU DAI driver. And this might be a good idea
> > because we can then separate the settings between PLAYBACK and CAPTURE, even
> > though we might then need to check the Master or Slave state to apply the
> > settings accordingly.

This is about what I'd expect but then surely the next step is for the
driver to choose a defualt BCLK ratio - that's how most drivers work,
they try to generate the exact rate that is needed to clock the data.
Are the bit clock shared between playback and capture?

--fCcDWlUEdh43YKr8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSz+HUAAoJELSic+t+oim9oDYP/1b4VUYEQq2BGjz+hdjrx5XW
Tv90KklVlfXZBxkMbusrvB04uuZiHTUipz7tVsSxK4hE56Ye5M5DUavS8cUeoOqU
Lp4x0RbXGVLPncnX3Af7HXUg3Z7qXUrO+3lnX4nrll7pJJvggN0Uud7YYGvjxNZt
rm0Wh78h272Oyb4ECdUtQivX6csLqj40E3KIiZfJ/GUmh2ji07GXNwbcr4Be6Twf
bwE81FfgB1tJ0GZdl1emQTS/h7F8YQgEo72S0G5wY/XfXys+mECrfdtxXvVeLtVv
Uzd3VPPVKsnYE4ZO0sSsgG7DpJP3pjQWah5xOZ7Vrg/vQreB7Ucdfvs8FhZvJO9l
nSrGXKUwACAIsO/oedvJCaQ2zcFTGC9foGsuSNH/xaCKITdtA7RfwIJCiGf0vtF9
i0qO48wkMf+KABaWYbuVX5EZehWoZj9rrrb1j+LZNVKx5UhIKnscls9CmIiSPLEw
EwarmZ7AOovRTIgJWx6LyhXGiJzcfatugeKQVTkNFgruhlvNAfv49J5ZySBhvKI6
zwmk8OLkUszFzDbwAoyJYh7JsTQsA6u1KL4O2pQ2CTdp7tmrm7GaBX//4uNydgl6
NuVwIuHSrpl4thC9YpofAWo3bHF22zPZ8SGpLDbMQsYj809WwRWm2x71ItBPV7uT
EXyp1eDAIpXyx0Jepi3S
=vciL
-----END PGP SIGNATURE-----

--fCcDWlUEdh43YKr8--

--===============3664362037257745689==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3664362037257745689==--
