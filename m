From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 08/11] ASoC: nuc900: Don't set unused
 struct snd_pcm_hardware fields
Date: Thu, 9 Jan 2014 14:29:17 +0000
Message-ID: <20140109142917.GZ31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7962151947172538299=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA35C26548D
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:29:21 +0100 (CET)
In-Reply-To: <1389014356-7014-8-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Wan ZongShun <mcuos.com@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7962151947172538299==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CJG0Al7R/g7M/Cz3"
Content-Disposition: inline


--CJG0Al7R/g7M/Cz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:13PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--CJG0Al7R/g7M/Cz3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzrI6AAoJELSic+t+oim9wowQAIf6riMN5KgHA6ksBMWfyyeV
53Y3WSr7vy/+EeYMiw2nPQ+yQqTcUJYE+3RDZJsZSqIhScvXTMTPW5X89I1qBWD6
HEcBPiH9LSVAcm4svzvEL97Ob6pOorO+JeISNqKTy6IFeXt86eQN8L8yPsonwO6g
HSfZV650And+/UrYmiHtAOOzGFCbTqQ7dTmnAMb0gCy9inFKuXoQparmN9J8MYMN
AX0taQ5OVdNFV3nIut3UZcltgKCCNeUlU37gAPnD/CaMssJP796/5HqXLnm6oOdY
FrV3wMjJAmaMUMn5oGUcdC8Ia0ogdekfZR0/bAmP0ZuJtz7j8Lrm/Ke49CyKai2G
PSSbVSlnQqYYLLZUEsthTonsyM8S5QpicTZVzwmrOsLiE7P2HqdHLVFpcUCU7hob
Tb69XEF2ahUw3Bq6pyvx9Z1htHOrtv1EjN4sLhb33GLdBq2ebjv7HQYTO8+/voCi
aBaxE6JJW49C0Pv6heTovDvpbW1DWDSZt7F/qo9j8UmZVZbrnFwrlSnxhcJUYg5l
+W8fMFGuUvOURLVejMRv47O4pYrCsq/nF1Ua9ljQnY6o4rK4gjXklCUGk65+zJmx
DtzU3kTsUm3/IP0s5jQJCPL6OIWfGGn+ABL6B80YVuieANV8s6W0L7qWAOWxDboT
eg1vYQAcIjpMm1I17NXG
=ypzD
-----END PGP SIGNATURE-----

--CJG0Al7R/g7M/Cz3--

--===============7962151947172538299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7962151947172538299==--
