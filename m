From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] ASoC: Intel: Use acpi_dev_present()
Date: Wed, 27 Jan 2016 13:32:50 +0000
Message-ID: <20160127133250.GO6042@sirena.org.uk>
References: <cover.1452787340.git.lukas@wunner.de>
 <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
 <20160125154846.GV6588@sirena.org.uk>
 <20160125211358.GA10561@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3324372249314089141=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C350D26044B
 for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2016 14:32:59 +0100 (CET)
In-Reply-To: <20160125211358.GA10561@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Vinod Koul <vinod.koul@intel.com>, "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3324372249314089141==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PtLnLSExlPr13a2X"
Content-Disposition: inline


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 10:13:58PM +0100, Lukas Wunner wrote:
> On Mon, Jan 25, 2016 at 03:48:46PM +0000, Mark Brown wrote:

> > As covered in SubmittingPatches don't include inter-version changelogs
> > in the body of your commit log, put them after the ---.  They are
> > meaningless once the change is applied without the rest of the history.=
=20

> I'm used to the drm and drm-intel practice of including the changelog
> in the commit message, but will remember to move it to the git notes
> when posting to alsa-devel in the future.

drm is pretty much the only subsystem that does that.

--PtLnLSExlPr13a2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqMcBAAoJECTWi3JdVIfQnVMH/RiXCQcKsr2wqrk26QeFK411
wDKtkWlvGjs7x96ixPOT7zvaED9l4dYNSQkoB/GdEXZCNJtijCIxQB/0UJbVyFLE
q+G/xuBo4ZkpqTqzvMpu6ibnSQBnnEecfqxrtD+FX4vk4A0LPquZ8AzSGrCvAMja
5VtUWl0V/EpWSCY9sycaA15nwPTuqHMawF28wI5quyZEgh+mo9tp4e+IxRZQ6HCj
LAIxVo1cUeivnYkcHqYRt/9PUhlhtfClolveQck6L+2UCT3pYg7AOV5qseTigVw3
0vtkM3lXc6oyeJQ6mJkNxfQ/nqqPqArB0kwbZZDhCAaVRZhM/+LPJw4yK1rWmyY=
=nx1o
-----END PGP SIGNATURE-----

--PtLnLSExlPr13a2X--

--===============3324372249314089141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3324372249314089141==--
