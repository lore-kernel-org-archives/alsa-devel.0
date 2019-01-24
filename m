From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Thu, 24 Jan 2019 18:44:12 +0000
Message-ID: <20190124184412.GH5641@sirena.org.uk>
References: <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
 <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
 <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7525625489379300076=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 97F792674A9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 19:44:17 +0100 (CET)
In-Reply-To: <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
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
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, lgirdwood@gmail.com, Curtis Malainey <cujomalainey@google.com>, plai@codeaurora.org, linux-kernel@vger.kernel.org, Ajit Pandey <ajitp@codeaurora.org>, tiwai@suse.com, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Matthias Reichl <hias@horus.com>, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, srinivas.kandagatla@linaro.org, Curtis Malainey <cujomalainey@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


--===============7525625489379300076==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 22, 2019 at 08:01:15PM -0600, Pierre-Louis Bossart wrote:

> changes are legitimate. To move forward, maybe it's not worth spending too
> much time on a grand unification of string theory, there are simpler
> solutions: the Intel machine drivers already do get the platform driver name
> as an platform_data argument, so we could modify the dailinks platform names
> before even registering the card. I tested with the attached

Yes, that would be much better - it's vastly more idiomatic.  The
general idea is that a machine driver should know what it's expecting to
find before it starts probing.

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxKB3wACgkQJNaLcl1U
h9DWzAf+NtlimN/EneqIJgAU2m4qsSGsS9Mz520HmFrDdz20VvslFLxGcyQylwnY
dytQj5u6mMW5FjRr1ZtxO/ILOPpuYU23IfhLmNkBdnCcPKNVZwO5YfoBA4tCnLS9
fh4A7gAXXxxPvwv22dQUzoj2O78yRGtNwmPl4r2Fz8cgUqqklLxpG1D/crEg3e0Y
P6ghAMtQh0w72+9Op3rf9Cjhwuj7bXnvS+l4g9B9SkhAvUQX+9KCB3M/+bkSDuf6
m/ke2DVbmvi/w3VB2nscnAYt7XdnlzhG2siJl8Mj1CEIclBUte7s3qneDIPeSHvQ
ojflN99K6KhrRzn6L0mH3ntAPU5h4w==
=MyTR
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--

--===============7525625489379300076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7525625489379300076==--
