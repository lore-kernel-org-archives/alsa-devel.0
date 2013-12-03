From: Mark Brown <broonie@kernel.org>
Subject: Re: How should SGTL5000 codec driver adapt to dummy
	regulator change?
Date: Tue, 3 Dec 2013 11:56:45 +0000
Message-ID: <20131203115645.GR27568@sirena.org.uk>
References: <20131203065320.GB10840@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8512939950050736924=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 900D6265151
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 12:56:48 +0100 (CET)
In-Reply-To: <20131203065320.GB10840@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Li Xiubo <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8512939950050736924==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="K90HjsLT/gE7/naG"
Content-Disposition: inline


--K90HjsLT/gE7/naG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2013 at 02:53:21PM +0800, Shawn Guo wrote:

> The sgtl5000_enable_regulators() function in SGTL5000 codec driver makes
> the decision whether an external VDDD supply is available by checking
> the return of regulator_bulk_get() call.  It used to work because dummy
> regulator did not play in there, and if regulator_bulk_get() fails, most
> likely it's only because there is no external VDDD supply.  But with
> commit 4ddfebd (regulator: core: Provide a dummy regulator with full
> constraints) merged, the regulator_bulk_get() will always succeed.  It
> breaks the driver's assumption.  What's your suggestion to the problem?

It should be using regulator_get_optional() to look for the regulator,
the current code isn't good anyway in the way it is handling this since
it's trying to get this regulator that needs special handling as part of
the bulk request which makes everything more confused.  Li Xiubo was
working on trying to improve this this week - check the list archives
for mails from him.

--K90HjsLT/gE7/naG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSncb6AAoJELSic+t+oim9Fo0P/RsFOjWxQ10qvMfOjVpQFicF
h+zeYID3ofKYI6CTwxLqSF0nNfJSYaxT98vkHWdCbwpDlsOkCM3KJZMR2McFGJq4
r2cOHUVTOjMZxZcCqRUNkFmQxyjWVhfJJp8kg/IbLcg8n1l7ihbPddnBpx69y3Ti
r3mZHAVcxsNYEgA+UoQORao7A9h9VnlOaAT2uUNSwEtZmAtiG51lnCCA7JG2Yz6a
0VnmL7f7eH4+qvxGW1qWufG6dhbhmy8e/rvBZznVvGVfVRoTRq+7tHjo6WpbDUM2
HkWGm9dqkvp1sB/AkPzvam09pMkBN77UJg4csU8m4ZaKC5eML3ssBaaMakxCalGj
Ol7EIe9Fl1GHzK8lHwG3BAmpCz7S6YS/KQ7fL0K8WVAZuWBmQ999qJh4v+8S87sE
ivM8IXXnWas+bz04cAccKl/g7pVqpOqovtow/VVG20nehaADvGbzgNQB3P0D/pl5
kB5JDqj8VZJU+UDN0nhNQ1qu/VbT6dO0ClborPzEOyNZk5A7l1Bb3YYN7y2E6Mq+
PVhauysT6YKJK+EdumLK02DWdHSl5N/pLEeh3EMfYWkNsKOJaJI2MXF/4GH3RIDo
2YFPzZAeYhadLO6Rhf2lTK2Y7G6AXvIWnPQkU81lWcTzU/ZXZKQkBsK4IOXHVZrR
Aoc0atWd751LA/FEMMON
=mGuQ
-----END PGP SIGNATURE-----

--K90HjsLT/gE7/naG--

--===============8512939950050736924==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8512939950050736924==--
