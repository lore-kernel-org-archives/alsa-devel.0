From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: sgtl5000: Enable VAG when DAC/ADC up
Date: Thu, 29 Mar 2012 11:58:32 +0100
Message-ID: <20120329105831.GC3668@opensource.wolfsonmicro.com>
References: <1333000305-27280-1-git-send-email-shawn.guo@linaro.org>
	<20120329071700.GA18127@zzm-ubuntu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3593698460334706638=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E3F291043C6
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 12:58:33 +0200 (CEST)
In-Reply-To: <20120329071700.GA18127@zzm-ubuntu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zeng Zhaoming <zengzm.kernel@gmail.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3593698460334706638==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 29, 2012 at 03:17:00PM +0800, Zeng Zhaoming wrote:

> So the code should be:
> +      {"MIC_IN", NULL, "Mic Bias},	       /* mic bias --> mic_in */
>        {"Capture Mux", "MIC_IN", "MIC_IN"},    /* mic_in --> adc_mux */
> -+     {"Mic Bias", NULL, "MIC_IN"},           /* mic_in --> mic bias */
> -+     {"Capture Mux", "MIC_IN", "Mic Bias"},  /* mic bias --> adc_mux */

> and platform code
> +      {"Mic Bias", NULL, "MIC"},
> -      {"MIC_IN", NULL, "MIC"},

No, the bias should be a supply for the microphone - ensuring that this
happens is the whole point of the patch I sent the other day.

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPdEBRAAoJEBus8iNuMP3dK4wQAITb/o4Q2AoWQ6FkgUgiiGmG
x1SONV8SDRpAb/TNMU2BdDFYCGCkLITQ8zNQgdc5Zmgxn0KMoxSJ+mjjlhyeicjm
zW1XmF+JxPRtIjysBxXVnTbQA5dIqdeU762dKLiwFsygJeuu11H2pAgjdiQWtWEw
HIHjR0Nd1sThB5z+zIBnSu36v0SqtkfVB35xQFsjAMXOSHcypUzs6aZIZEDC5JNC
fbreAdhM61awsJgc0wfYeljcVkUFSll5m3WZ3tUOLkQpx8d48ope9BGcwtkElIuU
0lBeQyXMt9dYQJl+aQMHyyyhpoZ4CVDtlfcA9YTK4XErFyV8AoDoRY5a7UDAErHq
iBGp+hwuu/kVaDxbiNnZnnwTT8trUJdr58Bame3pcaDbIXIghIYyNyLzvToXAkdv
zlRWvt0icjOLZHQu6nfPOwltnpv43YtjxFEhw76WPXx02LOj7gZ9ktKNn2sG7Ixt
RLu0LKqdG7JeF7+YuA5yVzFi2QmUx/4Cql2rlNJ3j3i/gS+rGWBIcxGEU6MHwPBY
vUb/ZHTAQbEEa4DwHcbP3x4n0i26x2tQHbYhoHKX6QMfPcneIKRzfkKFXIE0r4Rk
65zazr6d0e707F4UMkGvCPUtNFXHPDUhnQ6U4jmAARwHEfWZ9lVcFHd8ULd2WkrV
oG75QKZlETBPx9TgbtnR
=6O5i
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--

--===============3593698460334706638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3593698460334706638==--
