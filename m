From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 10/15] ASoC: hdac_hdmi: Fix possible
 memory leak in hw_params
Date: Mon, 15 Feb 2016 20:57:26 +0000
Message-ID: <20160215205726.GF18327@sirena.org.uk>
References: <1455243375-16067-1-git-send-email-subhransu.s.prusty@intel.com>
 <1455243375-16067-11-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4166869362651515599=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8937C265593
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 21:57:35 +0100 (CET)
In-Reply-To: <1455243375-16067-11-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, Vinod Koul <vinod.koul@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4166869362651515599==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 12, 2016 at 07:46:10AM +0530, Subhransu S. Prusty wrote:
> It's possible for hw_params to be called two times. So add NULL
> check to prevent memory leak.

Another fix?

> -	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
> -	if (!dd)
> -		return -ENOMEM;
> +	dd = (struct hdac_ext_dma_params *)
> +		snd_soc_dai_get_dma_data(dai, substream);

If you need to cast away from void * that suggests a problem and it'd
look a lot neater too.

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwju1AAoJECTWi3JdVIfQhMgH/R1osux12uQUAqyeXWyT3wM3
KLv5DsY07kOv+ZvslbRxY6NZCzgKDN3AiMIuxw3KRB5GYnRWvnoYuZWjwEX0WKWg
O6k0TmcUFdAfAu6A4XFOTwG/KuOY2ALRC4c+7fygBckpWL0alJ+UxCbnD8wWccsN
Mz0oXw0QbHKNljax8dAzqyjD3lCvwFLAHLtMkGzI2M5xaVeOnIgsLHRrLEjtDUi2
1b01+iafbwzOLdMXx6lXNFeYUQhLYhcHAPVTAVL97CmAhOQIvoIG8ItTOio80OfW
cyCGepvrVJGDnwO7R8Mhglj5uDo41kzlue1DiN7TcpMs5aLN5DfQQBlD+noSBas=
=wA2d
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--

--===============4166869362651515599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4166869362651515599==--
