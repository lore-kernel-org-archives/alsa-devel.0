From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs42l73: Don't mix
 SNDRV_PCM_RATE_KNOT with specific rates
Date: Wed, 5 Feb 2014 15:52:28 +0000
Message-ID: <20140205155228.GC32298@sirena.org.uk>
References: <1391543731-9085-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1797523796195700038=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D8B3265007
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 16:52:41 +0100 (CET)
In-Reply-To: <1391543731-9085-1-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1797523796195700038==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qjNfmADvan18RZcF"
Content-Disposition: inline


--qjNfmADvan18RZcF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2014 at 08:55:31PM +0100, Lars-Peter Clausen wrote:
> SNDRV_PCM_RATE_KNOT means that the device can support rates that can not be
> expressed using the rate bits. The driver will provide a list of those rates
> specified through constraints. Any rate bits that are set in the rates mask will
> be ignored. So setting other rate bits besides SNDRV_PCM_RATE_KNOT wont have any
> effect, but might be confusing to the casual reader, so remove them.

Applied, thanks.

--qjNfmADvan18RZcF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS8l45AAoJELSic+t+oim9LzgP/01BY/wo+QMIh3LvmS/rzbkO
7JG4kIphcNyHW4hmLFw43tAztkTQDj9TSul4hfxI/enEabl8WXNSVnpAOmBgD2t8
/EeFzwXb3HKiecl2RcvJzpT/oUaEFyBJ7Ba46YElgyVhFiW55t7tfgrpOvtTq5k6
x9GaktW1fQNx5/T7YIF2EsezG+Z/Bo+d3wP64BTxEOEG9hVAsCMcb0vdu63saMiG
lX6vsi9vrNuu8+0z58Yi+SQ59B4z+ah+JpbWpZT9T6lKWiLXXo/aTS+D+2ill/pR
MrnH7eBw/PyfDCfDuNf2fMibkwI8+Ep9eoyxj9IjKVaJZMJsnGcBNN7gY/+eHGYj
+3ExoWZ/9ABhxzlG4/rlOt7eMtCsqzjxC3HTrm5AhkUC63PmtP/fJ9cToRyMwTVW
oXHVvcBJiebuQruNkriu0C23mHfuQRNUWdSiMKgSDRvFi2KjvuBVdd7mTIjNDfrE
ST30Q+Mz7nT7RBe88d3JbG0o0xTqkyWjsnsA/CudllCOnSGBTayAAwe0CMQvjIMH
kl2DpOmXdhQMpWi36B2TVTp2NcJNiCPUivVmi43WetZaVYrbmzug5LSFmCc1q7mA
7lYfLTS82uAI8NrEKIH2zcDjSQORn4MZUet+/mkyeq1rkbPWS01EcYsn1WvbSbeh
weRc2RigjPeiFyb9hQOe
=bc5p
-----END PGP SIGNATURE-----

--qjNfmADvan18RZcF--

--===============1797523796195700038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1797523796195700038==--
