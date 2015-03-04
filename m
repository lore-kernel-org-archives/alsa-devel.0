From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Allow complete
 shutdown of McASP when not in use
Date: Wed, 4 Mar 2015 17:13:57 +0000
Message-ID: <20150304171357.GP21293@sirena.org.uk>
References: <1425392792-12659-1-git-send-email-peter.ujfalusi@ti.com>
 <20150303150742.GZ21293@sirena.org.uk> <54F6DA94.2000702@ti.com>
 <20150304113004.GJ21293@sirena.org.uk> <54F6ED24.9060907@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5060737375351328579=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0909B265233
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 18:14:02 +0100 (CET)
In-Reply-To: <54F6ED24.9060907@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5060737375351328579==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7+jjqyDO/r5KaLYo"
Content-Disposition: inline


--7+jjqyDO/r5KaLYo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 04, 2015 at 01:31:48PM +0200, Peter Ujfalusi wrote:
> On 03/04/2015 01:30 PM, Mark Brown wrote:

> > You can just store the state before you do the enable...

> When we come out from suspend the pm_runtime status is disabled all the time.

It's fine at the start of the suspend though, you can just record state?

--7+jjqyDO/r5KaLYo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9z1UAAoJECTWi3JdVIfQi0UH/jhfzjeAOjohV5sCPsKf5dky
NXQSevMRCbsgbxvfD0kKTZvmJmjaJCBDfGms0ppKMRHBA4RuatueYsZJMGWfM7VF
9KIovmNRj9YeYcXq6aNVW+N0LJzz79ghOezxyphiCB4RlgokSbKeWokTG7UtVHFn
gvbAXrN9sXRhU1K63O7feVDRvrZUqe4OYlYCrKZCe2b4KgfE2WlrrK4giof8ImJI
hxGoCvlYGL4r0013t35XrA7N36ROpZI7SMnSYe4myxhqPb1BGmoE2RUfwRY7AbeO
VSsuEDfgo6x0ub3A1tAwNrHoiY5N5tS5kA1v188QArgRDGD0aAuo5/W/5nwuk8U=
=Q8m5
-----END PGP SIGNATURE-----

--7+jjqyDO/r5KaLYo--

--===============5060737375351328579==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5060737375351328579==--
