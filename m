From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/2] ASoC: samsung: Add machine driver
	for Odroid X2/U3
Date: Mon, 30 Jun 2014 19:46:58 +0100
Message-ID: <20140630184658.GE23300__47449.4250411682$1404154076$gmane$org@sirena.org.uk>
References: <1403108551-25058-1-git-send-email-s.nawrocki@samsung.com>
 <1403108551-25058-2-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1120637554900130394=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1403108551-25058-2-git-send-email-s.nawrocki@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, pawel.moll@arm.com, zhen1.chen@samsung.com, kyungmin.park@samsung.com, galak@codeaurora.org, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, m.szyprowski@samsung.com
List-Id: alsa-devel@alsa-project.org


--===============1120637554900130394==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hobqzgJMeQ3bIoso"
Content-Disposition: inline


--hobqzgJMeQ3bIoso
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 18, 2014 at 06:22:30PM +0200, Sylwester Nawrocki wrote:

> +struct odroidx2_drv_data odroidx2_drvdata = {
> +	.dapm_widgets		= odroidx2_dapm_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(odroidx2_dapm_widgets),
> +};
> +
> +struct odroidx2_drv_data odroidu3_drvdata = {
> +	.dapm_widgets		= odroidu3_dapm_widgets,
> +	.num_dapm_widgets	= ARRAY_SIZE(odroidu3_dapm_widgets),
> +};

> +	ret = snd_soc_of_parse_audio_routing(card, "samsung,audio-routing");
> +	if (ret < 0)
> +		return ret;

Given that the widgets don't have any actions defined and the routing is
all done by DT it might be easier and more flexible to just define all
the widgets all the time and let them hang there if they're not in use,
that way you don't need multiple compatible strings.  If you do that
you're then very close to being able to use simple-card...

--hobqzgJMeQ3bIoso
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsbCeAAoJELSic+t+oim9bYUP/i+ywW+Yl67NWQKW0fQIDKDW
oZFdfsjqruHE+0N0snlFM731QEZ6J9nxbHm4ltBdTwNWQZJRB+FqLUMO/tLySn3E
DT23UOCKdDNveJxLBpa8c+xKNI+Er/DyQSp1ncOcCh9Wxzbj+lAo/31whqT5k/Zo
xbWV6Uq9V/vVM+KU8lRtJKeTXEXWN85hAnOPxlGor4fEOooR7vwwow7+qPouVz3t
SXPtL+Z1rlWKiV+nfnuDaqfnK8FUn7r+4jPUA1YBbfnyODHmPlxZyyX2hwloz1P9
gV+Cz3ZPDETeAkibw3kiimL5PTs1Wh6Gh4/U+VIUCN0rP6488fXPsjfBNqIZLaKh
poDDuR1tW9s+1THPxv59JuV5yJFtpT87gh0a6bWbeTD3eYsdfEJ7UmqxOxEx8o1j
goLB5e7IP1pu2QdeVmLAWNfR0sGn+NgOfXqslZXgGAk1jmrC4q/uXinNtjdcK41d
b80Vo93KMout5k3VJHtSRQmInGPhxudkDfe4i3ziEEd9qiTrJsaGv2NGAUWJxJ9I
1mespzvc7638qYbu+pT7spHkJ87FiWRp+btfE2jCazN/t+qE2X3k2YiVrXmzN621
C6hD6GcQUIHBFFJ6eXSgPvX2lK1x+aqD9rLodWvWq5n5dZgjpgyz4ZM7pgvlL5h+
9E6paQ5aEQ5v7vtxXeuo
=oZyg
-----END PGP SIGNATURE-----

--hobqzgJMeQ3bIoso--
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


--===============1120637554900130394==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1120637554900130394==--
