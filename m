From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/35] ASoC: Intel: Clenaup SST
 initialization
Date: Tue, 27 Aug 2019 20:20:36 +0100
Message-ID: <20190827192036.GM23391@sirena.co.uk>
References: <330b6be6-21c2-2eb8-9959-7d494841b3d6@linux.intel.com>
 <15484165-d751-b60e-f703-de7c1fa1ad17@linux.intel.com>
 <a95ac4d7-1c6a-ac19-59b3-cfb9ab058520@intel.com>
 <47683473-c177-055b-03fe-2f01feeb4016@linux.intel.com>
 <92ddf26a-f0ca-469d-2ccd-68a3e9cb2e6a@linux.intel.com>
 <49d056e3-e1f6-039b-5265-82a4052af577@linux.intel.com>
 <e91d8bf1-e832-7a4d-f056-a5105648a056@intel.com>
 <c67909a4-aae4-64f2-6e55-d513030fe085@linux.intel.com>
 <d3474fdb-9479-b6f7-07fb-9f7c2d4ccbe3@intel.com>
 <85f46beb-1218-4159-2abd-3ab804247a31@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3413793217593020614=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 14E6BF80610
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2019 21:20:42 +0200 (CEST)
In-Reply-To: <85f46beb-1218-4159-2abd-3ab804247a31@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org, "Kaczmarski, Filip" <filip.kaczmarski@intel.com>, lgirdwood@gmail.com, tiwai@suse.com, "Wasko, Michal" <michal.wasko@linux.intel.com>, "Wasko,
 Michal" <michal.wasko@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3413793217593020614==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ze9Y2znYQNnn3X7a"
Content-Disposition: inline


--ze9Y2znYQNnn3X7a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2019 at 12:18:12PM -0500, Pierre-Louis Bossart wrote:

> Mark suggested:
> "We could have a wrapper which tries to load the newer firmware and uses
> the fixed driver code if that's there, otherwise tries the old driver
> with the existing firmware paths."

> Maybe that's too complicated, I had in mind some sort of opt-in Kconfig
> where you only use the new firmware/topology when the user/distro gives a
> clear hint than it's fine to use newer stuff.

To be clear I don't think this is a *good* idea, but I'm not sure
that there are any options that are good ideas.

> I also wonder how you are going to deal with all these topology files with a
> name derived from the OEM/NHLT. There's just so many of them...For upstream
> you probably want to provide ONE per platform variant, which limits you to
> the number of machine drivers supported.

Unless the way they're generated is consistent (or often
consistent) in which case you can just derive it?

--ze9Y2znYQNnn3X7a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lgoQACgkQJNaLcl1U
h9AQUAf/WF79J5PutYyTq69omnKk2K+0WC4++54rupZ8YKxbduuw/9L1WMVjIWC4
QusQXEqu29kX9rsXaeuC4nsfzh6Sbk9xIWWgUfC2DRhvi5dlmVzXuCXq4wpFVfO1
N+CTV645sGBVJ3gqJCm3Xfs/qZ7enVV9/F4x3cPiq9jnREQdeVHZ/X++4+OJ7MAr
2CpBNKKjmgyXhhh7HBtzr04G0CfHyfSHQlZMk3+/pqY3rhnOO3Ec9R24vaWKU3jG
XBU7Hj8X1YHJCzI6w0rpqgO0TpS4rKAoETAFOtmaethfPahYopyyLQjis6TGgwoz
40bxGpKabIXDqMlEFvPIgFaZPGj/Ag==
=vSyg
-----END PGP SIGNATURE-----

--ze9Y2znYQNnn3X7a--

--===============3413793217593020614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3413793217593020614==--
