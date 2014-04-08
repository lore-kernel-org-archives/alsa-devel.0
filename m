From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add rt5639 support
Date: Tue, 8 Apr 2014 12:05:43 +0100
Message-ID: <20140408110543.GC6518@sirena.org.uk>
References: <1396927929-31775-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6741422522271833929=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C930C267581
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 13:05:55 +0200 (CEST)
In-Reply-To: <1396927929-31775-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6741422522271833929==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 08, 2014 at 11:32:09AM +0800, Oder Chiou wrote:

> -static const SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum, RT5640_DIG_INF_DATA,
> -				RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);
> +static SOC_ENUM_SINGLE_DECL(rt5640_if1_dac_enum, RT5640_DIG_INF_DATA,
> +	RT5640_IF1_DAC_SEL_SFT, rt5640_data_select);

This seems to contain a lot of changes like this which are purely coding
style changes rather than actual code changes.  As far as I can tell the
majority of this change is coding style or comment changes.  Can you
please split these out into separate commits, it is much harder to
review if it's hard to find the active changes.  There's nothing wrong
with the stylistic stuff particularly but it should be done as separate
changes.

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTQ9gDAAoJELSic+t+oim9LFwQAIC0uR9MOVh5TraobIaQn5rH
kd25J1xH7xn6n4J0ZWIwqzO4nVhjd/g1AfVD7U49zW7nlYp5R1x+8EGa3HuYACog
ExxDWsdlds0DA2PigvHgtefeyU3Mm+BFL7ZGylckCHrCv4W/6uwMk0U3Q+UIrGlh
Iv0fvMuxbypQ4ZIZFy+NYItELtB+KVEfdzPrLp1BYxbsfkl6GH6tllzQc190LqzF
GXR4hZ8k2ca849IeKXOKGkueCXlWyVeLYzuks4dBa9J0jDcQ+YIeyllMP08Wo+Pm
ZYB1IVXKMSIq7dVWu05GFcNcgdxvLI4YONNL0REirqCVFT/x6FhZPQOYxWtQKFMH
Z7lHsK7Mty+A0TJPowvczPF1GFbGe2fcqrxDrssPj1n4KpCba8W5UIJFEhtk283Q
CHDd7UHG0I4qdTvVQeHQr7m3xBFqmDwcjnW8trRUpc7bSOSh0XH4jKzObah9qHvC
dxDPDhZHEigjI4XzNes4WhXni73ZGAR9fqmtcjrB9XXQjM5LXCxwy+RSe8XROSMW
87XLwMVAwhSkGWm699zfk9MbkGl0nRKrNhpsqaY1uZ7FWd2L5vykR/jXGnhdK8gc
xL2CDR23Lyx0DgvJNO06Xzko5kNAJJ1n1yn3SddZVDIRSSPgHN+F+XgZA6JtlOmb
7pzAfb4Ztouw9OKjCPqx
=RMAW
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--

--===============6741422522271833929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6741422522271833929==--
