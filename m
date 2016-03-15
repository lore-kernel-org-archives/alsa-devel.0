From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: fix interrupt fails and
 unstable after resume
Date: Tue, 15 Mar 2016 09:27:11 +0000
Message-ID: <20160315092711.GH2566@sirena.org.uk>
References: <1456686105-6885-1-git-send-email-KCHSU0@nuvoton.com>
 <20160301032623.GH18327@sirena.org.uk>
 <56E1105E.8010604@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1632735039325189731=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (unknown [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76D102612AD
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 10:27:41 +0100 (CET)
In-Reply-To: <56E1105E.8010604@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1632735039325189731==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Content-Disposition: inline


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2016 at 02:12:46PM +0800, John Hsu wrote:
> On 3/1/2016 11:26 AM, Mark Brown wrote:
> >On Mon, Feb 29, 2016 at 03:01:45AM +0800, John Hsu wrote:

> >>+static int nau8825_resume_setup(struct nau8825 *nau8825)
> >>+{

> >I'd expect to see this shared with initial power on?

> There is a little things different between resume and initiation.
> But I think the function could be reused.

Really?  Bear in mind the device might have lost power over suspend...

> >> 	regcache_cache_only(nau8825->regmap, false);
> >>-	regcache_sync(nau8825->regmap);
> >>-	enable_irq(client->irq);
> >>+	enable_irq(nau8825->irq);

> >We're removing the register cache sync here but I don't see us adding it
> >anywhere else.

> A part of suspend and resume action moves to set bias function,
> nau8825_set_bias_level.
> We make register cache dirty in bias off; and make register cache sync after
> resume in bias standby.

OK.

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW59VuAAoJECTWi3JdVIfQ3ogH/01PThhbXESUpBHo1gme5FVO
jRn+GOiLQzeeIDLlivbXVK0CUBjvvMcp98lD14mqT29I6dvhGKaWcgHUkuOFUT9V
soxQkxXlvLfVT4rWS5BnNb78pibgGqoVqt0p/Hsua5DyqBjRlyDUX6aMF6F9R3j+
xVHJ9PKe9g2GMGu73d4Z9ifBx0bnHQDfWQCoRDvqWvzozZRa3Z5aLh9RYLDFk85e
tqWV4uwJkLCyt3mxaNQ6Z/FqS+d4FG9IoM7/4PUPs1shXSYIlpjYjc0K1EIq7FJy
aNRjhMNeX0QOjL0JcvloVpTkrV+d8KWLWnS56BktA0dLyvUwsv1Q/Qv60vC4Piw=
=5mqc
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--

--===============1632735039325189731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1632735039325189731==--
