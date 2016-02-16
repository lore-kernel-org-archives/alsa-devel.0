From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 03/15] ASoC: hdac_hdmi: Enable DP1.2 and
 all converters/pins
Date: Tue, 16 Feb 2016 02:00:26 +0000
Message-ID: <20160216020026.GI18327@sirena.org.uk>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
 <1455243375-16067-4-git-send-email-subhransu.s.prusty@intel.com>
 <20160215201049.GD18327@sirena.org.uk>
 <s5htwl98v1n.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8567911476569036835=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C9CDD261501
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2016 03:00:44 +0100 (CET)
In-Reply-To: <s5htwl98v1n.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8567911476569036835==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 15, 2016 at 11:31:48PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Fri, Feb 12, 2016 at 07:46:03AM +0530, Subhransu S. Prusty wrote:

> > > +	vendor_param |= INTEL_EN_ALL_PIN_CVTS;
> > > +	vendor_param = snd_hdac_codec_read(hdac, INTEL_VENDOR_NID, 0,
> > > +				INTEL_SET_VENDOR_VERB, vendor_param);
> > > +	if (vendor_param == -1)
> > > +		return;
> > > +}

> > So to enable the pins we do a read?  That seems...  innovative.  :/

> It's a weird nature of HD-audio verb handling.  While *_write() just
> sends the verb asynchronously, *_read() sends the verb, does sync and
> read-back the return value.  But both read and write may handle the
> same verb.

The above one seems especially odd, we do the read and then essentially
ignore the value (the difference in handling is nonexistant).

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwoK3AAoJECTWi3JdVIfQ5lIH/Aqugv2MfOJ0bYD4zbx5wFhD
oNK2XXx/9xVYbAYdkfluNSVRqB6KKix+uEtAEH5xeG6s94IOu5miI7dr0HSP1SP1
ZW28lT3HgCczhsYQPiltYQIPzxHUyOZ8hHhk6I02cMMgnFdA8LZ3HhdL1d8Izvqi
mhocG7QO48eGq7whSGqfJo5NAzkP0EPiUclDBNzLCqqntrJbED/RqCYGvV+dsWYb
GfhmbVxqh+IFawnAwcd0fCtupxWoCc6Fif0Allvi307AvbFjNEEO7zz36KBlVDF2
FB8JYdKEl3SYXdk5alKZTbqdfioZsHkDWOn6GdJ/4aB23jgSUuokxq5VY4kXeVQ=
=6Kzu
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--

--===============8567911476569036835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8567911476569036835==--
