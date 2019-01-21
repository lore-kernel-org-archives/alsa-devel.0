From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Mon, 21 Jan 2019 18:30:54 +0000
Message-ID: <20190121183054.GF12679@sirena.org.uk>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2FkSFaIQeDFoAt0B"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Curtis Malainey <cujomalainey@google.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Matthias Reichl <hias@horus.com>, rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com, plai@codeaurora.org, linux-kernel@vger.kernel.org, tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>, Curtis Malainey <cujomalainey@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


--2FkSFaIQeDFoAt0B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 05:15:32PM -0800, Curtis Malainey wrote:

> of_node was never getting set but the pointer was becoming populated
> (outside of the probe call) which traced to soc_init_platform function
> which was not reallocating memory on a EPROBE_DEFER even though it was
> getting freed by devm. I am not very familiar with devm but my local
> maintainers say that it should be freeing the memory even on a
> PROBE_DEFER.

Probe deferral is just like any other error from probe, any managed
resources will be unwound.

--2FkSFaIQeDFoAt0B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxGD90ACgkQJNaLcl1U
h9CQEQgAgXbxteN3z6JWdvRNOR7LQ1qLbzwzKj6Q5fr9jXKIZaQLPq+1djnb/KFr
v4sITiJopyN0eDbQlmQUis5b0wT1jmOzpNsZfr5te78rYSLZmbd7Icf5/TmIhfMf
6zW4+BLvdFAzTC1ZZoqoX9XvEGfPZVgIS1tJNBQTyx4r4+L76FRis9aWKYnU3FqT
3JvCmZUNg8lhwH5uKN2FOhU1AcTRKFJl5v7YqyzXHOAe6bVRDi/yZYxcETeasUxM
EccYffjtpjxHl3cflJHgT8ZCpYvkNl4Ieg6Gs6In9+quP/FUM9dk4wubsS0gzVeK
yz5IV2nrxgQUkecgJoxR2iESaMBHyw==
=thEi
-----END PGP SIGNATURE-----

--2FkSFaIQeDFoAt0B--
