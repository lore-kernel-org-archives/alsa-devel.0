From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Remove regulator
 notification handling
Date: Tue, 4 Sep 2018 16:49:05 +0100
Message-ID: <20180904154905.GH12993@sirena.org.uk>
References: <20180831181737.29516-1-afd@ti.com>
 <20180903113038.GG10302@sirena.org.uk>
 <b35860d4-70ec-a23f-41d4-7edc87869ccb@ti.com>
 <20180904145740.GE12993@sirena.org.uk>
 <f6c7df62-a98f-009a-2169-0e5564f4b675@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3978913476965130789=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 78D7F2676C6
 for <alsa-devel@alsa-project.org>; Tue,  4 Sep 2018 17:49:06 +0200 (CEST)
In-Reply-To: <f6c7df62-a98f-009a-2169-0e5564f4b675@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3978913476965130789==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aF3LVLvitz/VQU3c"
Content-Disposition: inline


--aF3LVLvitz/VQU3c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 10:03:40AM -0500, Andrew F. Davis wrote:
> On 09/04/2018 09:57 AM, Mark Brown wrote:

> > It's there to save us having to rewrite the register cache if we asked
> > for the device to be powered down but that didn't actually happen due to
> > other constraints, we know all the registers are still as we left them.

> I don't see that happening for any other user of this, we will still
> have to re-write the cache when the device goes from OFF->STANDBY, and

You will?  All the power_off() code seems to do is mark the regmap as
cache only and turn off the regulators.

> if it stays in standby and never went off, then we are still broken as
> we switched to using the register cache only, but never turned on real
> writes again.

regmap can remember which registers were written to while in cache only
mode and only sync the ones that are actually dirty, or you can
invalidate the entire cache.

--aF3LVLvitz/VQU3c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOqXAACgkQJNaLcl1U
h9C86Qf/VEcpg19JspKkljuF1/FCg29JFROV6OQUtf/6HaeuG7hewgbSgCKqHH7r
1h50yfxMwwkXqRBNVr4cSY6ArCYRSCPowM+DL9pOON8dc5B3UVSf+cMa38cm6byJ
4gmOhyqsvnBhz9eNSHV8OZCryegnTr9+05JEQu0i3vuDnHSYcmDkynMLgtzv6Ugi
UsDgX/q49B4Giu+qgDU8erqhFEawnKFiz5sIes5V2gVXJf8KfSYaA13rXks2b2qh
b8iMTRCqki1nq6eRguNcO4tCskBk1IAF+2uSpqPx214HnCCoC18M1JhVZHp0tpgs
upvSuKVMnGskkgkp+E5BsWUMEDSEUQ==
=fEj5
-----END PGP SIGNATURE-----

--aF3LVLvitz/VQU3c--

--===============3978913476965130789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3978913476965130789==--
