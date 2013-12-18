From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mmp-pcm: config pcm slave via
 generic dmaengine
Date: Wed, 18 Dec 2013 11:20:05 +0000
Message-ID: <20131218112005.GF28455@sirena.org.uk>
References: <1387268544-31222-1-git-send-email-zhouqiao@marvell.com>
 <20131217124954.GY3185@sirena.org.uk> <52B062EC.2050605@metafoo.de>
 <52B138CE.3000800@marvell.com> <52B167F4.1080806@metafoo.de>
 <20131218110318.GC28455@sirena.org.uk>
 <52B1758C.1020903@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6599641986801562255=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 239092615EC
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 12:20:08 +0100 (CET)
In-Reply-To: <52B1758C.1020903@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>, Qiao Zhou <zhouqiao@marvell.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6599641986801562255==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NQFQLHPkFLmdEfVA"
Content-Disposition: inline


--NQFQLHPkFLmdEfVA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2013 at 11:14:36AM +0100, Lars-Peter Clausen wrote:
> On 12/18/2013 12:03 PM, Mark Brown wrote:

> > I worry about what this'd do on a multiplatform kernel - it seems
> > unlikely that someone has a pool with the same name but that sounds like
> > famous last words.  Nothing in mainline does though so...

> The sram_get_gpool() function is mmp2 specific. It basically iterates a list

It is?  That's an unfortunate name then.

> of available pools. Those pools are registered by mmp2 platform code. So on
> a multiplatform kernel not booting mmp2 it will always return NULL since no
> pools have been registered.

Yes, and like I say there's no non-MMP references to the string asram
either.  It seems viable to do things this way, though we need to get
the generic interface sorted before too many other platforms get the
same idea.

--NQFQLHPkFLmdEfVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsYThAAoJELSic+t+oim9KnYP/RtUMijJP1bBRLStw3mgphej
atDqDHdlh0pvWvaomN4gPOv6z3tBqYX0ddI3o/UTNgWHW6hH6JliKg4UOSiVR8BR
mKqKElG7BEzGuOrclsYD85Cr1YN+W9ED+Tm1VAEllvT83+fdUkWHFQsIoV3RdsCD
tXmGMCqLx+4mdOjPQg4ZYcZCOzBiujnMMkUisc4wBvSnwaJroLwI+X8XY/AZEsi4
r+TLNTumKzkFAVY2HXfCKOdT32hQivndwe69V0Ud1ZVhtGsK13oc6btP4PlKuEEw
NPLbkFyzPxVy1yjA9aBpG+dW+R7GfYnqnlIsvOBo/Tou1TARbagBuAY6mEQU+Ipq
BWIyyXu/bzoeaR3TzC8iwu6BL8UOA16O4tNN80caXB5n9/scBKk/Akp6tIxOfDQ4
38h9hxzEkMClW51D3GQzRLgltCpdXwSU1cM9NaZd7q9mrgtCl1Jv3CL5FNfTxvH3
ZMLNc64viqryykGF57eCV9oTasf+a5X/O+7G/lfzKrgoeJbV69bZYzA241Yej8fv
pThzGwxTlx6Z+l0miFdvBJn1h3AG6zR90ABNngPJZrMEoxrE3iPzn2aoTqAV/RY8
6/fSqkvsvhuvLzwGUhmzjX8dPerij88GL1CZpOVldyzuZ5oTXpdDM69eCpNWMwzs
QSEuH1iA0a3bqz5T14j2
=2zCI
-----END PGP SIGNATURE-----

--NQFQLHPkFLmdEfVA--

--===============6599641986801562255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6599641986801562255==--
