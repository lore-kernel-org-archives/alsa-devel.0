From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/4] ASoC: omap-abe-twl6040: Keep only one
 snd_soc_dai_link structure
Date: Tue, 8 May 2012 16:52:55 +0100
Message-ID: <20120508155255.GB15893@opensource.wolfsonmicro.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
	<1336479314-27766-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4998253075074874457=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2C568104589
	for <alsa-devel@alsa-project.org>;
	Tue,  8 May 2012 17:53:02 +0200 (CEST)
In-Reply-To: <1336479314-27766-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4998253075074874457==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sKosZo66cxuwvnFI"
Content-Disposition: inline


--sKosZo66cxuwvnFI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 08, 2012 at 03:15:11PM +0300, Peter Ujfalusi wrote:
> There is no need to have two snd_soc_dai_link structure for the two setup
> the machine driver supports.
> We can just tell core to register only the first link if the DMIC link is
> not in use on the device.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--sKosZo66cxuwvnFI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqUElAAoJEBus8iNuMP3d1DsP/iFgKKEBDEFMHBYWjmEG9FtJ
nyvJyEEsukmYxijubREuW2F0EYufOi9UCgpVYhfj9vIjcRsJamiGHuZPMBVeKxTV
CdSi9v98KDBIHvjCr5wwlHqqkX0jeOZenBwU/29BVnrTrshk2E58VPcIm0FWWWgT
JyuunKqNRbnRu0LL6kffZoAKbcHjs9V30EsNSp9H7oNlwNGHDaBX6ql5GLwOqo+L
Zjc1+2bXz52BzK9vIxNYDmLWJ1Dm2ns1ZfuLCICsy5njynuAE3Bn6BaHWEoGgk81
ySXkG5MT41j/1Uo5IlHqRrhZn3zlDKRsCBMGfFjr3hIgddOrIrqtZBmeHZ5xBM8G
+qL3yvpECMiGwUHA1R/2Zc3SaAINNZtb6OHT61Su+Dzq0gD+23oFQ1L/JIdPQpNI
wr0gyHCk+mDdqHpqj+0+KoiLby1SBvXGgV6ICCt/hFCgfpZwVqTdQcL4W1bGKzX6
jeo18VwM44p9oeWRTtUiGeAgft1rM+Ewti8XU2vc7cd/fVUOyX6zdJC88hI34cc8
OhfzAA38Pq3FMq27hxuC95liPLWJ/dPcHTcoJLUTnwiTbvid0Zr/hPBzK4vv6ByP
xiSKtONvPU6RgQpoVfhXPRScJIB6b7GqhMkuUiLD32rubdyPaRpdUbRoZmXP5QLu
KsLa2TRbgLpAsFR/X2Fl
=KHn5
-----END PGP SIGNATURE-----

--sKosZo66cxuwvnFI--

--===============4998253075074874457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4998253075074874457==--
