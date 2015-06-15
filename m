From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: soc-compress: add a config
 item for soc-compress
Date: Mon, 15 Jun 2015 16:05:56 +0100
Message-ID: <20150615150556.GQ18309@sirena.org.uk>
References: <1434338445-31992-1-git-send-email-yang.jie@intel.com>
 <s5hmw01gq9c.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA25@SHSMSX101.ccr.corp.intel.com>
 <s5h4mm9gi8h.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3781313690488676343=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78CDA26512B
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 17:06:10 +0200 (CEST)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A90554AA81@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: "ramesh.babu@linux.intel.com" <ramesh.babu@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, "vinod.koul@linux.intel.com" <vinod.koul@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3781313690488676343==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7a4X6VOqfbl9xMrG"
Content-Disposition: inline


--7a4X6VOqfbl9xMrG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2015 at 02:46:23PM +0000, Jie, Yang wrote:

> > > Here I used -EPERM to return and tell caller that compress operation
> > > is not permitted, does it make sense, Takashi?

> > The question is whether a runtime error is the best option.  A runtime error
> > won't be caught by build tests but only when actually running by a user.

> Unfortunately, here cpu_dai->driver->compress_dai is a runtime value,
> which means we need compress API when it is true. Seems it is not easy
> to decide it at compile stage?

The machine driver (which is presumably the thing that should be doing
the select here, it's not user visible) really ought to know if the DAI
links it is creating are for compressed audio.  This is why I'm still
surprised there's no driver updates as part of this patch.  If the Intel
drivers referencing compressed don't actually implement it then I'd
expect to see patches cleaning up the references to compressed audio.

--7a4X6VOqfbl9xMrG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfunUAAoJECTWi3JdVIfQFOsH/2vtcULekHT5XKAIur1tU0jE
+S+/pW2onlUi0L851MkefZk7Ay8eSuvcJFk/6maZpWi6MnBq0anjSlv42P/yFXj9
0MJdtYnSLZc3q1tIbgx0B7gVcOZC4Hda78gOidZxl1XIRPWaHH1Flm2037QyzvV0
vI5xNPOM2QBvIDo6Pni9yKbi8K+mESvw4XZ+86e924fBVgPAIBzSwVKGBwlBxnPB
YQiUVP5V7vRi8aSc7bzDJqVX6cSGi+lMEGXigXIQKjejRVIbX+SZj5JUtzx60M0V
fZUesedyUW6COjmz/JacRYpi9n86Ih+X3gGttpm/rVwmTG3cuLJDp0VsmYcnvaE=
=BWAO
-----END PGP SIGNATURE-----

--7a4X6VOqfbl9xMrG--

--===============3781313690488676343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3781313690488676343==--
