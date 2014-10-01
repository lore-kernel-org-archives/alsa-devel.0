From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5640: Add function for
 enabling DMIC from ACPI probed machine
Date: Wed, 1 Oct 2014 17:04:44 +0100
Message-ID: <20141001160444.GD4273@sirena.org.uk>
References: <1412165295-24229-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5643385725399946575=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C3D26260518
 for <alsa-devel@alsa-project.org>; Wed,  1 Oct 2014 18:04:48 +0200 (CEST)
In-Reply-To: <1412165295-24229-1-git-send-email-jarkko.nikula@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5643385725399946575==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zokm/imjT5TjLIDZ"
Content-Disposition: inline


--zokm/imjT5TjLIDZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 01, 2014 at 03:08:14PM +0300, Jarkko Nikula wrote:
> There is no code enabling DMIC clock in systems that don't provide platform
> data for rt5640 after commit 71d97a794301 ("ASoC: rt5640: Use the platform
> data for DMIC settings").

Applied, thanks.

--zokm/imjT5TjLIDZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULCYbAAoJECTWi3JdVIfQgkwIAIRU5g3253LKMdGSl60lDMKz
ngbCc3O27Qi/0YncvAQ8opo2TDsMORs+yu9c2QvtDiVOQGpu6w5m2cGV89sRyZR/
HrfU+92nEyVawEnD/4Ny4r6/PRNGIf6OCgZdWTSOgY7035yq+8ZwfhlCBVKSQTW8
/zJ0akLrkn61pLudH/mU4iMSOTBfOwBA1F5nqm2jwBlPFZmgNo8tRBC3EBIolPm7
yWEo4mPwOQ1qg6dA7JDd6XxcJBS6FvdNf5pkJxyR5kpDBpsDrfva5mlgUxVbfp1l
KUEw6m7ISHUETJJYZZMgToMdeOtCH2rjEqxlPVG1jzZ9P89x6iJUoei8uUhNN4I=
=xjZ2
-----END PGP SIGNATURE-----

--zokm/imjT5TjLIDZ--

--===============5643385725399946575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5643385725399946575==--
