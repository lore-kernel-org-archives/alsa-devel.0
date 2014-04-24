From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_spdif: Add core clock control
	for DMA access
Date: Thu, 24 Apr 2014 13:14:09 +0100
Message-ID: <20140424121409.GQ12304@sirena.org.uk>
References: <1398336744-4836-1-git-send-email-Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1064665511504787279=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 059D6265268
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 14:14:25 +0200 (CEST)
In-Reply-To: <1398336744-4836-1-git-send-email-Guangyu.Chen@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1064665511504787279==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LomU6SEoZG8dkhgW"
Content-Disposition: inline


--LomU6SEoZG8dkhgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 06:52:24PM +0800, Nicolin Chen wrote:
> Regmap is able to enable/disable the core clock automatically each time
> it's going to access the registers. But for DMA cases during playback or
> recording, it's totally beyong control of regmap. So we have to open the
> clock manually.

Applied, thanks.

--LomU6SEoZG8dkhgW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWQANAAoJELSic+t+oim9xaQP/jAc8MiWP/0irX4mSDcxHwuz
Q717u69OlYdxEFYaC4MKCvrHjaptyYdzToJthLhkaruCDQY1HCZBXJ7SS+vuSiWw
bmdPi+21ZNMvlkZ8bW9AHfcwhyycjHnLQaJjzhFMG9xLj8/4HX6fM6fDiJPWAtjK
fLamWaKe7d3eocAnBV4uaZM7UEoCJVa2U/P+tz3Q7unShr9oh14ogQVfUPiQy8gJ
enOzl0VSXJtQvwOpHUaQac6HEMByRCNglsmNVY6OIM8vS/z2beW2A9kZoDAuOknJ
s4OVF1BeFRh+udU0ttKpQiu2jclo58gVcVHw5wY/3zK3SNYEkpUe8WVsglRFXJot
z0ZZ4QIV17Ami8efbbf7XIucSl3r+wSK9mcC827reF0U84IXm2Yy5QfPQdBOkUii
QKLynF7arobtEgHpmdKfYvkUMC/zMS8XP/DUrlytkiVpX8BCV+bp7FMW8b03najR
Mb3XyDL3l7107tzsDP3p62W8h7wTcMLPhNessPHEzJazF92DBotQyUxT6gvvhx5R
bzs4enDCjFghMhDJvTszhXS29yGm3HBJX/sElxj1HO2xxe/Tx6ruBF2EYb/8Ua/x
sj5Un85jZ9DrbKB6Asn+H5SkYU+qmnLRtdwcRZEyrhnt2dEIQEBauwFgqhrj/k4d
SO1dOVYJJJomLNQ3T72x
=SRie
-----END PGP SIGNATURE-----

--LomU6SEoZG8dkhgW--

--===============1064665511504787279==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1064665511504787279==--
