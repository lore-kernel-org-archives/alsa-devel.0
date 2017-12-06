From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/6] ASoC: Intel: Skylake: Skylake
	driver updates
Date: Wed, 6 Dec 2017 17:43:44 +0000
Message-ID: <20171206174344.kimjlfmy6frjibxz@sirena.org.uk>
References: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4877813393729660916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F6742679FF
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:43:50 +0100 (CET)
In-Reply-To: <20171206110406.11400-1-guneshwor.o.singh@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Guneshwor Singh <guneshwor.o.singh@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, ALSA <alsa-devel@alsa-project.org>, Vinod Koul <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4877813393729660916==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sbttzj6h3zegz7y3"
Content-Disposition: inline


--sbttzj6h3zegz7y3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 04:34:00PM +0530, Guneshwor Singh wrote:
> This series includes fixes for HDMI widgets sysfs not updating, shim
> read optimization, fixes for dmic dev_type check and feature to
> configure DSP clock source.

Please don't throw together a bunch of unrelated things into a patch
series, if a patch is a standalone thing that isn't really related to
and doesn't depend on the rest of the series just send it separately.
This makes it much easier to follow what's going on and avoids changes
getting held up by other, unrelated, changes.  For example here the DSP
clock scaling stuff is a three patch series, if there were problems with
this probably the rest of the series would take longer to get looked at.

--sbttzj6h3zegz7y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooLE8ACgkQJNaLcl1U
h9DDHgf/WMqMwZgstqrUdngcAgsy3/PM77lkIVgOSIe+QsMYUpyjFSL+HOF2P76C
YA1Wh9mE8qfGlg0KPgbS7rkcq5Xhp2uNREMpSqXB3PJq4fUj/8v5FSaFEECNtQLA
brC8XbVylNqfXgbaTmiKEAnv4CICqO8veqIJWhVVAXvNmNnwQXZ8OdqP7kzHxKGF
A+7jLClPNIEj5hmLppkdvDtLjrSTWqEzTDoDEV5E5uYcQC8wt893VkOQTlsJ2vbd
BWuUKFYXTwIkn442KMzdFmQ9iR1IMF3n7mBh0Q38DFBqWV0COsdZTSybb8ZCqh9V
MqUJmlXHwGvZ9o8p62EtS2WdMl++dw==
=oPnV
-----END PGP SIGNATURE-----

--sbttzj6h3zegz7y3--

--===============4877813393729660916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4877813393729660916==--
