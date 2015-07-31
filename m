From: Mark Brown <broonie@kernel.org>
Subject: Re: Using regmap_multi_reg_write() with regcache_sync()
Date: Fri, 31 Jul 2015 17:36:32 +0100
Message-ID: <20150731163632.GH20873@sirena.org.uk>
References: <007801d0cb3d$25ec4870$71c4d950$@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7218695613944618593=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F1FD5265DE4
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 18:37:10 +0200 (CEST)
In-Reply-To: <007801d0cb3d$25ec4870$71c4d950$@codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudheer <spapothi@codeaurora.org>
Cc: plai@codeaurora.org, bgoswami@codeaurora.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7218695613944618593==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+G3HLlWI7eRTl+h"
Content-Disposition: inline


--k+G3HLlWI7eRTl+h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2015 at 08:01:07PM -0700, Sudheer wrote:

> We are trying to measure cold start output latency for audio playback
> usecase on our platform and observing that the latency is high. As a part of
> optimization, we have profiled regcache_sync() API when the codec is out of
> reset and observed that regcache_sync() takes little long time for synching
> all of the codec registers (around 100 registers). But, the bus connecting
> the codec has the capability to send multiple register writes at once. It
> seems regmap_multi_reg_write() can be used for triggering multiple register
> writes at once. So, we would like to know, if it is possible to use
> regmap_multi_reg_write() or a similar function with regcache_sync that
> intern calls bus driver's multi_reg_write API to sync to the HW, that will
> help in reducing the latency.

We already coalesce register writes using _raw_write() in the cache code
where appropriate, if your device isn't able to use that for some reason
then falling back to multi write sounds sensible, though it'd be a bit
surprising to see a device that uses that.

In general please post proposed changes as patches rather than vague
design questions (it's easier to answer and avoids disappointment later
if there's some hidden issues which present problems), and please
remember to send mails to the relevant lists - linux-kernel for regmap.

--k+G3HLlWI7eRTl+h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVu6QLAAoJECTWi3JdVIfQlG0H/A+nMqd/ob7sqwmySry9McKB
UCrrPug2lwFbi3L11e/Tc/54cUcZRHgVrltVmx3Qo+NPZ64Qc4RIkhw/5Glp7Wik
cP8SwwbxL5hXrOVQg+A0kyusuvuG00DMQC3xaLS6kwHlUpn3lHSl5mKfYDssB3X5
zBSHjXr+kE7qx2Xf4zI0RuPtZbxp3gNg8IIncUd4EIS4qEXC74YcO/yBXl4LNPNy
JAnAUsFpwpSVUffxC1mu9sHNwMY025HA0iEY8/rvU3wBzQtiBzvUPTVlp+6tro+j
TL3jnZqtfLx4Xq+lq+Tk17EALcAY/tGpROCtohmfj7FXWAu9XZuEx1HcBUKJu4I=
=Ye0T
-----END PGP SIGNATURE-----

--k+G3HLlWI7eRTl+h--

--===============7218695613944618593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7218695613944618593==--
