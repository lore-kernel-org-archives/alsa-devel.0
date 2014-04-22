From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 2/5] ASoC: Move standard kcontrol
 helpers to the component level
Date: Tue, 22 Apr 2014 13:38:48 +0100
Message-ID: <20140422123848.GZ12304@sirena.org.uk>
References: <1398165797-22997-1-git-send-email-lars@metafoo.de>
 <1398165797-22997-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8726630828411314013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A3897261B2A
 for <alsa-devel@alsa-project.org>; Tue, 22 Apr 2014 14:39:04 +0200 (CEST)
In-Reply-To: <1398165797-22997-3-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8726630828411314013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pih6jE/3rXCmn1YN"
Content-Disposition: inline


--pih6jE/3rXCmn1YN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 01:23:14PM +0200, Lars-Peter Clausen wrote:
> After moving the IO layer inside ASoC to the component level we can now easily
> move the standard control helpers also to the component level. This allows to
> reuse the same standard helper control implementations for other components.

Applied, thanks.  This also depended on the multicodec changes.

--pih6jE/3rXCmn1YN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVmLVAAoJELSic+t+oim9aloQAJVHdrj+vKWGC24xYefkkiVi
lyu0toJ4YxtNEPKAHXFwk/vZVlDH5mqPmFL1xTjsfiSM/ZcCvU7pnHpaxmTe39U8
JHE5rfetWAHHqkoCkYX1keHkBoZIRD6yR6U4oON6QJkRNXBtLFTivuy47ObH7Jfd
VjOMP8oMkOTfjmg+LHlYz8z8a1sDXlHPoGYiclACQsPQgabBjB6wxRPIQNk9g1Gm
TzFq+vre43qMyjyCwoUaRAJGiQhkrTGIWa/4gNS48d/zzB+hKf2kNiqSLt5Iy9ey
JplMYUi2i1PRE4VM699TaTXYFcx4c7ncXtHMIWBj+duGTd9m32fICHNHE57OIkzO
zqm/CZwvQTsdCKbmXBWsAfX8qj4DZdTDSZ+dPAv8HlC4D+wAIqUtjqWwDtJKmjfx
I3NDC5bGmw8DX+/9tWlHyhl1RHQk1bF9C+Du3eU0MRcFyqpLX4RkUq2s9S86cA2g
6VrWE24aNz3ACzhBOM+BgW8RupdCK7nVja15gtpsncQetKdnt6lDy2wKYHzzwoBW
Q/Ufe7SH/CLLpNLFQufnNJY8mZr8x0ba1L0GYifaDu8A8sWEN4br+L4DoPHenfik
EM13ZPqEeCy0JD5A5CkKUxiQlwkicl5ENN+NNfQpgQ/iueLi4MfIuqvnnVWCr1v6
hGkih7MRMknnEtypjBQ5
=/aUz
-----END PGP SIGNATURE-----

--pih6jE/3rXCmn1YN--

--===============8726630828411314013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8726630828411314013==--
