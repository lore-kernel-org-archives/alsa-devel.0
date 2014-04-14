From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: jack: export gpio detect
Date: Mon, 14 Apr 2014 20:55:01 +0100
Message-ID: <20140414195501.GQ25182@sirena.org.uk>
References: <20140403220715.GG14763@sirena.org.uk>
 <CF69AC38.3C92E%cfreeman@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8007579216574684051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A2AC9265357
 for <alsa-devel@alsa-project.org>; Mon, 14 Apr 2014 21:55:14 +0200 (CEST)
In-Reply-To: <CF69AC38.3C92E%cfreeman@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christopher Freeman <cfreeman@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8007579216574684051==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RCJLo13VlymhPcEi"
Content-Disposition: inline


--RCJLo13VlymhPcEi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2014 at 01:40:10PM -0700, Christopher Freeman wrote:
> On 4/3/14 3:07 PM, "Mark Brown" <broonie@kernel.org> wrote:

> >It seems better to have explicit callbacks for this doesn't it, ideally
> >ones that get triggered by the core without the machine driver having to
> >do anything?  This is a common need so having to open code it would be a
> >bit depressing.

> Mark, do you have a suggestion on how to plumb this up?  The way I see it,
> the machine drivers own the context for the gpios and soc-jack acts as a
> helper library.  I don't see a way to do this from the core.

Both the ALSA core and ASoC know that the jacks exist and at least ASoC
already gets callbacks from the machine drivers during suspend (usually
just through providing default PM operations for them).  We'd need to
add code to actually keep track of them but if that's done then the core
can walk the list of jacks at resume time and give them a callback.

--RCJLo13VlymhPcEi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTD0SAAoJELSic+t+oim9mJMP/07tBlyTnjFVUS2Yypi3OEiX
Cau1XWwrafVLh/8pyd23NK0UgXXXK+CVq6TL15O8CBLA848WWuzzZJq1Hiubr6BI
M+9WIXlT84iwhbaGYvkPVBMwVCsvT/oGZdE+5WFGUsnrdqlf31NjLzuPKlgLrAH8
Io6vBETIpeVLkNl9c3EB7nkgVm8BUgR7K9Jve1KUtEmCypZi7mzzzGt3AEsk4A6/
c2f8oLkNUU5Wfja+VtjV73FacFisLnrOsBJWLg9wrlZaqeFIK86uVDnZfw8x7KBk
tpD6R4VHnP2R+sEirdlVVZFK18YXH44MExwhFNFtkiu/Zswqn1hEX43Kry2efLVl
BEb6FFzL354KXflIvQ/eSMZg4+w7uOE0qnUgRvsIJ4dhGDOOn1q9gMnqKfUlRuJj
JGasEE1EaHJxDQU8kv5Sp/hpgRbLG/SikIx4uVKfd6nHIssszZh7kM0JfegHH1Wq
LBgnfkr6TskfL19xtYwiKLbLK6m6Vd00VUcmC3VEpWjc/49JCUYdr6XIvu4gejfp
H19qpe93BXtL+dGF1Uax3HvDg8dUJC3yZkoOXlaTEo7E3v7Zhlfu0By3NKaED+QG
EoqPYTlSvAGRjtLcAh1yJyPy3dTLPeahu63NpyN6Jk2tKfjhuVscaiJThLcQgfMx
Fvf6bMpEYDdwoL3trMT2
=O2XY
-----END PGP SIGNATURE-----

--RCJLo13VlymhPcEi--

--===============8007579216574684051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8007579216574684051==--
