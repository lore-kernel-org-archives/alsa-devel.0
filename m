From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Wed, 30 Dec 2015 18:03:44 +0000
Message-ID: <20151230180344.GB16023@sirena.org.uk>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
 <20151130162548.GZ1929@sirena.org.uk>
 <20151201025654.GJ3901@localhost>
 <20151201122747.GG1929@sirena.org.uk>
 <20151202052330.GE1854@localhost>
 <20151202103241.GC1929@sirena.org.uk>
 <20151216144806.GO1854@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3742827239783407037=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 636462659D7
 for <alsa-devel@alsa-project.org>; Wed, 30 Dec 2015 19:03:51 +0100 (CET)
In-Reply-To: <20151216144806.GO1854@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3742827239783407037==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C311HLcnHV2CzHlo"
Content-Disposition: inline


--C311HLcnHV2CzHlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 16, 2015 at 08:18:06PM +0530, Vinod Koul wrote:
> On Wed, Dec 02, 2015 at 10:32:41AM +0000, Mark Brown wrote:

> > But neither of these is a CODEC so why would the CODEC flag be set in
> > the DAI?  Unless your "Codec" here is genuinely the CODEC rather than
> > the CPU DAI connected to the CODEC in which case surely this is just a
> > normal DAI link?

> Sorry Mark for late reply..

> You are right this is like a normal link, and yes that is _exactly_ we need,
> but we also need parameters to be specified for this as this is hostless.

> The moment I add 'params" core will do different connections which do not
> work for us.

> I am okay if you have something else in mind which solves our problem :)

Isn't this what the DPCM fixup() is supposed to handle?  As I keep
saying I really think these systems would work a lot better if they were
representing the DSP as a CODEC, that makes everything much more
consistent and less riddled with special cases.

--C311HLcnHV2CzHlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWhBx/AAoJECTWi3JdVIfQyIEH/3mY8jJGFEvHqazluNPSB6Lk
p9q/t76sNuWYglB07yoxQMEA040kM1uSJ48zCX5HiXdPAiMUSHd+SlAiQ1ehimdV
sj2Bdr+xz93XKvHpA83fVZa7ve7zbFSPnOCa/d7NJ5AcR2bsFfgQHdXkDlPeuISJ
nhZWAV/j/+BL+Wb0dpJsqrrSdEyJ4E/Co+8zsccCDrjuco2+YCxj7CG0TdFHP4CO
OB2f9zj4sNhuLQ253RIh95gwRwDLTJ6MkbTFxK2h2xhdaCJ53afh1Mr0fleXPBGE
JSu9BwG/Rt0GOaUlNiSgxsTazS8hVbhc+m4ouD8Ex6VwvmDWgW7hkblE2zIIiZQ=
=RTM+
-----END PGP SIGNATURE-----

--C311HLcnHV2CzHlo--

--===============3742827239783407037==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3742827239783407037==--
