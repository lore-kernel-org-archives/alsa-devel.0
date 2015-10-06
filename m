From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: topology: ABI - Add name
 element to snd_soc_tplg_stream
Date: Tue, 6 Oct 2015 17:25:20 +0100
Message-ID: <20151006162520.GB30592@sirena.org.uk>
References: <cover.1443605139.git.mengdong.lin@intel.com>
 <08b095d38f59c43690daaa45e1d201f367812228.1443605139.git.mengdong.lin@intel.com>
 <20151002165907.GU12635@sirena.org.uk>
 <1443809055.10986.10.camel@loki>
 <F46914AEC2663F4A9BB62374E5EEF8F84B84FF3F@shsmsx102.ccr.corp.intel.com>
 <20151006103403.GH12635@sirena.org.uk>
 <1444144590.25504.27.camel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2033264471433167707=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A45F265716
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 18:26:10 +0200 (CEST)
In-Reply-To: <1444144590.25504.27.camel@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "Lin, Mengdong" <mengdong.lin@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Kp,
 Jeeja" <jeeja.kp@intel.com>, "Prusty,
 Subhransu S" <subhransu.s.prusty@intel.com>, "Patel,
 Vedang" <vedang.patel@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2033264471433167707==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 06, 2015 at 03:16:30PM +0000, Koul, Vinod wrote:
> On Tue, 2015-10-06 at 11:34 +0100, Mark Brown wrote:

> > No, I mean that if someone changes a name it'll invalidate topology
> > files that reference that name.

> Shouldn't this sort be checked in the alsa-lib while building the topology. It should
> validate the names, graph and complete only when stuff is right.

The problem isn't detecting the error, the point is that if someone
upgrades their kernel and someone changed the DAI link name then their
existing userspace will break.  We don't want that error to be there to
be detected in the first place.

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWE/XwAAoJECTWi3JdVIfQNpsH/jM+XYRJzezZ3ElO2mVNleMj
sw8KsIGOYuava7QdZipHUw9CU3GYB0GmqVNNmSeRmusi1kcUWHIUN3m0Hxskwe8s
5N4VsSy/J0GNntT5bXPZH0Y5RhF9+ArnaiyjFpBiQRg7KURMkeNU9HMSFIPdFDnZ
iGbHQvw1TAcfESGUi53cG7MdeYtKoiFAPePZuPcSDg+eMMGI2LXzdqJ8T6eeZgkt
HR80v4DNlSTvtInKKNAVfKjYi+OmCcjSwqdvi73gO/OMJR6TNDt+UgsnfRZiZm7r
b+OU6rTKqDDvH0IHFofdAu8fRxBAd+wVmro9tnjOk9tl4TWKe2bAomQXfUM2g8Q=
=6VVK
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--

--===============2033264471433167707==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2033264471433167707==--
