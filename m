From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] codecs: mc13783: add spi errata fix
Date: Tue, 10 Sep 2013 13:35:04 +0100
Message-ID: <20130910123504.GL29403@sirena.org.uk>
References: <1378742952-9840-1-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5040092833656443592=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A30E261A15
 for <alsa-devel@alsa-project.org>; Tue, 10 Sep 2013 14:35:09 +0200 (CEST)
In-Reply-To: <1378742952-9840-1-git-send-email-s.trumtrar@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: stable@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============5040092833656443592==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VGZP6qjTfO2IGr39"
Content-Disposition: inline


--VGZP6qjTfO2IGr39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2013 at 06:09:12PM +0200, Steffen Trumtrar wrote:
> The MC13783 Chip Errata, Rev. 4 says, that depending on SPI clock
> and main audio clock speed, the Audio Codec or Stereo DAC do sometimes
> not start when programmed to do so. This is due to an internal clock
> timing issue related to the loading of the SPI bits into the audio block.

Applied, thanks.

--VGZP6qjTfO2IGr39
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLxH0AAoJELSic+t+oim9RPQP/R01F0SKlQw9LV+eISPeqqna
C7rWUG2H/dGw78ojNhSNAx9lzRUg1M40Z/vX+SjRprss9DgW6/MPYwwfl5Y6unQT
CImszGrH2Rphvmbma0Cs4LDsvO1VVQlrclseBFUwZcWhrGupTbN+xgVT5oyITzuY
KfNCZjdvS6RnOGhFDyXMce0zO1FhxF5ChjWrjyLCOYOKFhiyi4PbAui5LWh3oGk0
XJI/3KUts5OCNrXfPy+VKbSmhlm1OmH0V1CM7Le6845dfee/uocIAOG6M8lMIEnC
l1vdpeONr4EoyVzoIAu3PUra5O7gOePFXTcp73iC8jSmw6kBVDz8LHrWMcmXDAnX
MVIbXUiLTbX0fp/Fk5iJmSeI+IHU/TZ5pHOt1WXM+U5Wp1GcCeflgd0+0XtA33F9
4y6/tJMuxsxRjdEkDvi9yWptL0JNWRPrr/lX7ql/jbY/rckeBryKVVyNsWsX24H1
PG9y7GGEF8ZtF4kO1UotWneO9sdFkR1q6/yqHEX/41HKdPqIgSSTc/g8xCgLXfwg
CEhr9SM0wNMIsckkFw3ED68baY0fuR598sfpntuKMRStcm+T6O15IqXg7DSR1XT9
9BC9u8OKSdnQ4sb+JAVp7BBGXR3548AlRCdIX56vGJR+ZbQxLTXk0eN4PUKcBjNM
JVJggrq1YULX3iAMg3CS
=91WJ
-----END PGP SIGNATURE-----

--VGZP6qjTfO2IGr39--

--===============5040092833656443592==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5040092833656443592==--
