From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Fix null pointer
 dereference in soc_find_component
Date: Thu, 24 Jan 2019 19:26:52 +0000
Message-ID: <20190124192652.GK5641@sirena.org.uk>
References: <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
 <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
 <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
 <20190124184412.GH5641@sirena.org.uk>
 <976ec85a-7b21-6c58-90cc-a3d104f9505a@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2361844958264114983=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 20B412674A9
 for <alsa-devel@alsa-project.org>; Thu, 24 Jan 2019 20:26:55 +0100 (CET)
In-Reply-To: <976ec85a-7b21-6c58-90cc-a3d104f9505a@linux.intel.com>
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
Cc: rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, vinod.koul@linaro.org, Curtis Malainey <cujomalainey@google.com>, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Matthias Reichl <hias@horus.com>, srinivas.kandagatla@linaro.org, Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org, Ajit Pandey <ajitp@codeaurora.org>, Curtis Malainey <cujomalainey@chromium.org>, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


--===============2361844958264114983==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GBuTPvBEOL0MYPgd"
Content-Disposition: inline


--GBuTPvBEOL0MYPgd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 24, 2019 at 01:07:17PM -0600, Pierre-Louis Bossart wrote:

> Thanks for the feedback, will send a formal patch with the helper and
> machine driver changes after I test more with the legacy drivers. Do you
> have a preference for one patch that deals with multiple machines drivers in
> one shot, or individual patches? The latter are nicer for backports (e.g.
> for Chrome), the former nicer for maintainers...

More patches is good, it doesn't make a huge difference if I get one big
patch or a series of repetitive patches - big serieses are more of an
issue if they're all different patches needing individual review.

--GBuTPvBEOL0MYPgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxKEXsACgkQJNaLcl1U
h9CrfQf/TSuAQrVpDDveUkj5OeoR6tRyUeCAIhi4RM9+BZ8fprgWPxiunRRqnpAe
vloJEfPPN0XMdFa1j25HnHn90yYETGwdbE/y/iGozfk6XF1g1lMxCaAfR2cVqssV
nx+/im9LCh3w5nvq2GBnjaMLG87aBLv8ODnQGNDD5rGElTXKxkueajgJi4xo2VFf
25JBaw1KU8m/eLJdfDb4WGZ4o0ZEdO7p15AqSQ6Y9kvB3rlo+8UAFjHxqyIfIBMy
J9URK3nojNdRlRY6T1vpqHqzvgl4+H460mCxAOviYDsnLlUSM80mmvHrFfBsXolt
zWVfUkU18RAHavnsxQe1elLZSTjebw==
=C+CS
-----END PGP SIGNATURE-----

--GBuTPvBEOL0MYPgd--

--===============2361844958264114983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2361844958264114983==--
