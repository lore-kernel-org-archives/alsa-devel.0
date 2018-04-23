From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: codecs: msm8916-wcd: use threaded
	IRQ handlers
Date: Mon, 23 Apr 2018 15:49:01 +0100
Message-ID: <20180423144901.GE19834@sirena.org.uk>
References: <20180420120750.356-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2377819889557661591=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 366B2266CA1
 for <alsa-devel@alsa-project.org>; Mon, 23 Apr 2018 16:49:02 +0200 (CEST)
In-Reply-To: <20180420120750.356-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2377819889557661591==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
Content-Disposition: inline


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 20, 2018 at 02:07:50PM +0200, Daniel Mack wrote:
> The handler for the mbhc switch irq calls into snd_soc_jack_report() which
> in turn triggers a notifier chain that is blocking, which means it allows
> its callbacks to sleep. This leads to a "scheduling while atomic" Ooops
> when the jack notifier callback uses snd_soc_dapm_sync(), for instance.

Someone already submitted a fix for this which is in -next already?

--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrd8lwACgkQJNaLcl1U
h9BaDQf/TgHu/+0gmIXyUHhskXOr/7UHEEwnRN3iVarEuaY/WR+OaDQ+kOCTkJnS
9ZEIffuatBurCIYfHYxajG1wmYspuuUW/KEmjZgfurQRcS/FMpwew5gZ0dGEEGS5
DdujTEjhm5cvQo/TDr0rJx0Dh5kSgReDKI6fWAE9//vfeSowh1pJZeRI/cRGN5sl
5WNoxcbla3f+CAAag7lNecSusyQHMyySV4druS+ZGFdyk+ymeZTOlspPEpezuFJd
t/II/1Kj7b8D9gmVhK+Y60QyFEVsvJT916l2Ld/78KB20Z+gUXvQ2OqUFIBGTUXa
+o9ngrTsBoT/7jLqkyBNkTY9wbDacw==
=IK3E
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--

--===============2377819889557661591==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2377819889557661591==--
