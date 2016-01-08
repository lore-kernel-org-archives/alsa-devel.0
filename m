From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 03/14] ASoC: hdac_hdmi: Use list to add
 pins and converters
Date: Fri, 8 Jan 2016 14:04:48 +0000
Message-ID: <20160108140448.GS6588@sirena.org.uk>
References: <1449677405-7907-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-1-git-send-email-subhransu.s.prusty@intel.com>
 <1449677781-7997-3-git-send-email-subhransu.s.prusty@intel.com>
 <20160108133251.GP6588@sirena.org.uk>
 <20160108135446.GM11778@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1411867707237083653=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 01FE626040E
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 15:04:57 +0100 (CET)
In-Reply-To: <20160108135446.GM11778@localhost>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1411867707237083653==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="APsrsY0yTFDXy1q8"
Content-Disposition: inline


--APsrsY0yTFDXy1q8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 08, 2016 at 07:24:46PM +0530, Vinod Koul wrote:
> On Fri, Jan 08, 2016 at 01:32:51PM +0000, Mark Brown wrote:
> > On Wed, Dec 09, 2015 at 09:46:10PM +0530, Subhransu S. Prusty wrote:

> > > Also it may be required to connect any converter to any pin
> > > dynamically as per different use cases (for example DP is
> > > connected to pin 6 on skylake board). So this will help in
> > > dynamically select and route.

> > This sounds like it's supposed to be supporting multiple outputs but...

....

> > ...it looks like we still only support one random pin and one random
> > convertor?  How do we know if we got the right ones?  I *think* this
> > mostly ends up doing the same thing as the previous version but if
> > that's the case why are we doing it?

> This is the start of conversion to have multiple outputs supported. This
> patch only converts to use list so that multiple pins can be used

> Actual code to add support for three skl pins is in this series as explained
> in the cover letter

This is the sort of thing that needs to be in the patch changelogs.  I
know that at some point we want to get to having multiple outputs but
right now I'm reviewing this individual patch and I need to be able to
tell if it does what it's supposed to be doing.  Please do work on the
quality of your changelogs, as I keep saying difficulty in following
what the code is supposed to be doing is a constant problem with the
Skylake patches.

> > As I've said before one of the reasons it sometimes takes a long time to
> > review these things is that there's a lot of big patch serieses getting
> > sent which aren't that well explained.

> > > -	snd_hdac_codec_write(&edev->hdac, pin_nid, 0,
> > > +	snd_hdac_codec_write(&edev->hdac, pin->nid, 0,

> > Huge portions of this patch are a simple refactoring like this, it'd be
> > good to have split those out as a separate patch so the actual content
> > is more visible.

> Yes this patch is only refactoring to use list for pins

It looks like there's some other stuff going on too.  The changelog
certainly seems to suggest there is.

--APsrsY0yTFDXy1q8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWj8H/AAoJECTWi3JdVIfQ+3AH/Rl9gauRJKznVYIvXypTXDdb
2MBo1ubN44ErurZ7C+vdZoaIQ10qAIlGnkheZZiepS4jqau6+t0hqWN0gXiS2WpP
xgDl1VIxJvvkgRmYIg8k9BzHCvdjMW6m1PQDXvom6YB63YX/7uL9Fj3uP1rYo863
yqDWong3FE2HVkFStX8DIkW9zzLXJwUA6h39iLWji6J1zNfWOr9lXk3oq/LU/Lql
Gqyp/pJoJ3drj6rlkAFGgx3qQtlSn0d5XhMk8VOcnR2SmZLV/x6kLJT+ls8LT1po
1+T6sQf4RxpJOcf/GNqjdnSIo591Yorqs6nWuEZl7aCyJ3FhRVM2xuHOOncjLpo=
=KOQr
-----END PGP SIGNATURE-----

--APsrsY0yTFDXy1q8--

--===============1411867707237083653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1411867707237083653==--
