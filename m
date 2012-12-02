From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/6] ASoC: Samsung-dma: Fix potential NULL
 pointer dereference
Date: Sun, 2 Dec 2012 13:12:55 +0900
Message-ID: <20121202041254.GS17981@opensource.wolfsonmicro.com>
References: <1353488819-13902-1-git-send-email-sachin.kamat@linaro.org>
 <1353488819-13902-3-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4076563916023227602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 71B75264F02
 for <alsa-devel@alsa-project.org>; Sun,  2 Dec 2012 05:12:59 +0100 (CET)
In-Reply-To: <1353488819-13902-3-git-send-email-sachin.kamat@linaro.org>
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
Cc: alsa-devel@alsa-project.org, patches@linaro.org, tiwai@suse.de, Sangbeom Kim <sbkim73@samsung.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============4076563916023227602==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RpDyejMaDGJhP2PU"
Content-Disposition: inline


--RpDyejMaDGJhP2PU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 21, 2012 at 02:36:56PM +0530, Sachin Kamat wrote:

>  static void audio_buffdone(void *data)
>  {
>  	struct snd_pcm_substream *substream = data;
> -	struct runtime_data *prtd = substream->runtime->private_data;
> +	struct runtime_data *prtd;

This should be a BUG_ON() or something rather than just a simple warning
- the checks here are redundant, there's no way we should ever end up
completing a buffer without an associated runtime.

--RpDyejMaDGJhP2PU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQutUUAAoJELSic+t+oim9xyIP/jzMdH9wdlChQIxEd2/5S1nH
IOa26IXaPWadXws4hQz29ruMFYxrzK9Hk8z6Sf4ngCFYADxmZoOVe6HWAMdaNVi0
DVCwgxvryZICcjJRdiEOqjU6a3HoQ8Ww+qqpPb/nAY+TujPXRBiNWLfU6z6XtuCy
xgyeWjiNXOG8gv/DpVCu8nOV0/y0xhEqLI4JDMIHgcz5djazDXUri+1d3u0N1LXd
Jk2KUoq6ZJa+A/PhG9sELklw6mdgsnyMFo5/RC/o84obXLdYeXv2KxRwe0oz9ple
8nJG++kQw7KRfPSuWuGB8Hf1yozyteqMEYuqId29yLYg/MkPWILVuA355TJDdMqp
X8DIbbmy2ZC/J0A7RN4Vs7Uf/IYLM4TuCt8AJUknCavcQ3OXbNu59yPnVZ7Yse/R
l5Z/1L2IzcbWOEDQM8kNAtN9yi7QzMSkn3RTBbU5HWmg8+EO8DIx5ClkatxFHo1f
zVGzTKR/Y2Z2zxkqL2F5c6tcZVw8OlNs0k/NOJfA1xZ422rdn+CpCl+TOywB64Lq
SVLA4p7iUfp728Qhujz4VjFKGIfutmEj6QUk8WfYlKiyInEnmaL83yR4dDwYfiu5
YEGIuJKW4gQ8KHj8C7JJ5wzlGfHVRcoFEidDIj8Znhi1JV4lgMdXaLIJ8Sru6Ppo
yR0jCXxL2xQP/70iEO0A
=fz3y
-----END PGP SIGNATURE-----

--RpDyejMaDGJhP2PU--

--===============4076563916023227602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4076563916023227602==--
