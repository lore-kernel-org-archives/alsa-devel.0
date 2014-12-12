From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5670: set platform data by dmi
Date: Fri, 12 Dec 2014 19:35:58 +0000
Message-ID: <20141212193558.GU11764@sirena.org.uk>
References: <1418371567-1206-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5455585286929910045=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 183E4260688
 for <alsa-devel@alsa-project.org>; Fri, 12 Dec 2014 20:36:05 +0100 (CET)
In-Reply-To: <1418371567-1206-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, yao.jin@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5455585286929910045==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BLHJ+CpGSNuhLkFz"
Content-Disposition: inline


--BLHJ+CpGSNuhLkFz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 12, 2014 at 04:06:07PM +0800, Bard Liao wrote:

> +static const struct dmi_system_id dmi_platform_data[] __initconst = {
> +	{
> +		.ident = "Intel Braswell",

> +	if (dmi_check_system(dmi_platform_data)) {
> +		rt5670->pdata.dmic_en = true;
> +		rt5670->pdata.dmic1_data_pin = RT5670_DMIC_DATA_IN2P;
> +		rt5670->pdata.jd_mode = 1;
> +	}

This table is called dmi_platform_data but really it seems to be a list
of machine IDs to use for this Braswell reference design so it should
have a name refelecting that.

--BLHJ+CpGSNuhLkFz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUi0OdAAoJECTWi3JdVIfQNIIH/j8UtoFXRAnK7HVLsk7xp7ZV
+VPuHtLycZM63d3FR0XpDHEc2ya70Y7505QfeGyVDm0gC7KU3WSH5KRogDXf0FYM
IhShfwv+cDa0HyribYEWeF7Fiq6yid0qKyKrFOI8lfyB/u1Kx6l1cC1s2WOOPxQA
o5brlSswAN2Aj4F+SMbfXy/wJuDJMxoNenhso77SsglZCBykg2hglUsmOrl9v3dH
61vmVinkq39vtXtKCCoZQwt7QU0knuwAYFeS6w8MD4ti9/e4pBOOdM1cXq0Hd/vY
9NqfqolL76Zi0lVBp6JLf4X1KH9ODlLrTbC0avET/78zBK6cIH2f2+UWsoj8b/w=
=o8Fw
-----END PGP SIGNATURE-----

--BLHJ+CpGSNuhLkFz--

--===============5455585286929910045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5455585286929910045==--
