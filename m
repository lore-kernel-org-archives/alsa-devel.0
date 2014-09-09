From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 03/12] ALSA: control: Add init callback
	for kcontrol
Date: Tue, 9 Sep 2014 12:44:25 +0100
Message-ID: <20140909114425.GU2601@sirena.org.uk>
References: <1409661367-19047-1-git-send-email-subhransu.s.prusty@intel.com>
 <1409661367-19047-4-git-send-email-subhransu.s.prusty@intel.com>
 <20140906142124.GG2601@sirena.org.uk>
 <s5hppf8g2ul.wl-tiwai@suse.de> <20140908041421.GI1610@intel.com>
 <s5hppf6a679.wl-tiwai@suse.de> <20140908080807.GJ1610@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4231360893564156367=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 38313265065
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 13:44:41 +0200 (CEST)
In-Reply-To: <20140908080807.GJ1610@intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4231360893564156367==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1YSLKY9nNiKnepPi"
Content-Disposition: inline


--1YSLKY9nNiKnepPi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 08, 2014 at 01:38:07PM +0530, Vinod Koul wrote:

Please (as I'm sure has been pointed out before) fix your mailer to word
wrap within paragraphs.

> On Mon, Sep 08, 2014 at 10:04:42AM +0200, Takashi Iwai wrote:

> > For example, you can embed an init flag into your record and call the
> > initializer in get/put callback if not called yet.

> Yes but that would involve open coding in all control hanlers for the driver :

> if (!initialized)
> 	allocate_control_mem();

> This approach was done earlier (checking in info) and flaged off by Mark. It make better to
> have these handled in the framework.

No, that's not the problem I identified.  The bug you had was that the
driver was initialising the data in only the info callback and would
just fail if someone decided to call another callback first.

--1YSLKY9nNiKnepPi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUDugZAAoJECTWi3JdVIfQ7uEH/1JH9YcNTSzRoMBnJp4AHkK1
3Cpexyic/kPDZc3a8NIrZUOEzsEw+mDgqqaC3/lqWB9s3jnUcfLgIopVQ7eVoF6y
nSCjsUwOgkJT8ZyJT7TnfIuLZU9OacP80RoOFuFUVuRHdlmTEPbPyC8z/NuS9wK8
+P1BPNzhPk1eC/RfiF+pHRYG0kyqXAvp0cG3T34RsN9nOXS1LxOmHy1pR/oqviQd
RNlEK0smKrc4aWCq3JvZM7JZueHjw02/+2tNrXg2DN1qRkr5KCSGf6xaGXDzzsId
F3uJpFyAGdmbpSkwRgrX7m25o4fS3gCPL9Hn18mKddpzPu9XIIPS+Lr1KN6kNWs=
=ENur
-----END PGP SIGNATURE-----

--1YSLKY9nNiKnepPi--

--===============4231360893564156367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4231360893564156367==--
