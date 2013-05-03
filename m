From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: ep93xx: Remove redundant
	platform_set_drvdata()
Date: Fri, 3 May 2013 10:38:02 +0100
Message-ID: <20130503093802.GL4945@sirena.org.uk>
References: <1367572164-19523-1-git-send-email-sachin.kamat@linaro.org>
 <1367572164-19523-4-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1286069220025149533=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 46CF2265313
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 11:38:17 +0200 (CEST)
In-Reply-To: <1367572164-19523-4-git-send-email-sachin.kamat@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Mika Westerberg <mika.westerberg@iki.fi>, patches@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============1286069220025149533==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I4VOKWutKNZEOIPu"
Content-Disposition: inline


--I4VOKWutKNZEOIPu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2013 at 02:39:22PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.

Applied, thanks.

--I4VOKWutKNZEOIPu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg4V3AAoJELSic+t+oim9XlUP/jPVMQDtwXkOtxryaMymi8oB
U3G50ayjLd+oHjNRihpZEcUebbFKwPU/htwVV+DrDQycVVKlk0w7kMsPBzjzq7rp
YZS3G5bozBYOTBJfoKysO5Bwo0V5y6gYndwDO9GKrRpsE9PHC3oioBdpTJv5UKuw
NZ5rtUgvbuv3ecGnZAstUA16u+e/T+3u9hTMMfJ1tvFAcI51TAH9BruIu7i2oKc3
Itbe2ulWbgWYdrASoLa5khb+DFF+5G+7M9WmShzV7lnxABkh+/8AXWBR2Ynf0rT2
RdfSQ0USZ9AIowK98U/8CTPHQVD8nb8T5tx9IYWMr0QSJZN2eD+C47FOK65JmsHE
UDpcy5AKZu5rA0n+ro2eSWti0rw+mL55wrwcdEl/Irw7f07ninuQGcAbQ+ayNOnZ
rre+BRAxYMWKcFVAxAJqQJVFEW9RkZTMkSO0U1pIqxPbNWoRuIKQaYbVBxTICm7h
VRrgRoxcIlEbUaJVko9aUYIS84qOsU2PBrW3oGiyfepSjGMqtzn2qpszTQoyJDIp
vlfRw0wbS/k0E3Z6SZIS9LupDObJD9LzGSjJyyVVFGZ+pGp/ww8yVV9pz2yWQ1X6
Itz5Mrq2Wl5X6zUG+pZc+112jLh/cS31Wtr2gNAx0lyOmUJHywYah6n1g33SYtKW
s21KxfukMSPAeseQzxKi
=nXya
-----END PGP SIGNATURE-----

--I4VOKWutKNZEOIPu--

--===============1286069220025149533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1286069220025149533==--
