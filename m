From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-pcm: skip dpcm path checking
 with incapable/unready FE
Date: Fri, 21 Nov 2014 19:32:01 +0000
Message-ID: <20141121193201.GN3815@sirena.org.uk>
References: <1416211377-9559-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2961654393972564209=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 45258265D37
 for <alsa-devel@alsa-project.org>; Fri, 21 Nov 2014 20:33:26 +0100 (CET)
In-Reply-To: <1416211377-9559-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2961654393972564209==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="durBPhKEN0HtKOoz"
Content-Disposition: inline


--durBPhKEN0HtKOoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 04:02:57PM +0800, Qiao Zhou wrote:
> Skip dpcm path checking for playback or capture, if corresponding FE
> doesn't support playback or capture, or currently is not ready. It
> can reduce the unnecessary cost to search connected widgets.

Applied, but I did change...

> +		/* skip if FE doesn't do playback */
> +		if (!fe->cpu_dai->playback_active
> +		    || !fe->codec_dai->playback_active)

...this and the corresponding capture comment to say "isn't currently
playing" - it's not if the front end can play, it's if it is playing
right now.

--durBPhKEN0HtKOoz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUb5MwAAoJECTWi3JdVIfQrpcIAIIq/Z8ZxTxTQ9Rp0J7XS6tF
W7w+62TF6cMgSEULEL/OeGqR9wpm2XWT0pWxM+4bR0VZKJ7+xo8bHQW1q7mhxHH4
hzmnW1lODhX3dw8UdjpmpS8iJfA4v5MmCN3V520kG6Ch5C4LfT19p27+bCc70xow
LvtFDtQsCgjiP+3eJvCWGmJ74SASf9vfHUsRFawVTSK0+NhsFWu7dDcNGRcAnC77
dJpLt+LtgiJme5hTJRYduWVW5l9vc+YA08rhInEu3R6rm0o2iAMaqo4d6sjfLQbt
iTFWvkRCqeX8PzHEnzOkbasnOotOcU3RyvnY54NFQFtXD5ibVTM+tMqhvyE9IE4=
=TJ1j
-----END PGP SIGNATURE-----

--durBPhKEN0HtKOoz--

--===============2961654393972564209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2961654393972564209==--
