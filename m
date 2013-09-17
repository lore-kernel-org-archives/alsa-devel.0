From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/4] regmap: Add regmap_fields APIs
Date: Tue, 17 Sep 2013 13:48:52 +0100
Message-ID: <20130917124852.GD21013@sirena.org.uk>
References: <87sixrre8r.wl%kuninori.morimoto.gx@renesas.com>
 <87mwnvsy7a.wl%kuninori.morimoto.gx@renesas.com>
 <87k3izsxw8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1859635199190998974=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CB1A265165
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 14:49:07 +0200 (CEST)
In-Reply-To: <87k3izsxw8.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1859635199190998974==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xFHWmGwbilGjB8dh"
Content-Disposition: inline


--xFHWmGwbilGjB8dh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 01, 2013 at 08:30:50PM -0700, Kuninori Morimoto wrote:
> Current Linux kernel is supporting regmap_field method
> and it is very useful feature.
> It needs one regmap_filed for one register access.

Applied, thanks.  I did make one update:

> + * A non-zero will be returned when fields access enable,
> + * a zero will be returned in single field.
> + */
> +int regmap_fields_enable(struct regmap_field *field)
> +{
> +	return field->id_size && field->id_offset;
> +}
> +EXPORT_SYMBOL_GPL(regmap_fields_enable);

This seems like it should be something like _is_present() - the name
makes me think it will turn something on, not check that something is
there.  I removed it since it's not used by the following patches and I
didn't notice earlier when I initially looked at the patches during the
merge window.

--xFHWmGwbilGjB8dh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOE+xAAoJELSic+t+oim9whgP/ApzL9UpdSBx+dE3DN3PR+Bk
GOaq+imWynulqOg7WiQYfvBNI/sRY74ouBAx1qSTj1Z50QsLaNUhBtc1Qm5BkAr+
oS1Qart+/wOOMOkB8wYnt2f957GqdWKHesxil309v7C58iniuGNAWNcJwSsGj97l
qSyrRXb8FzSR7+fDdY2H9BLz2segJveMD42mX/tZkzIHCLhQRpgKCF7axyjcJp4n
WL9gNHHsfQOjBeon3ISv6CFNJyHhD9ZnhEXa615lbgq7gMIWQ6lbRmvgKDCFTvJh
fGXCrLyzifrzN84NXavUvqhJcSiXOhXHXew2lCL6QXtcwDRxrndL4EUrfGhe4K6J
PqcvpErCG5mQkCDFAvxtrUQr+eEnL50XMzFOH0YY9sOYaCQij/DFgCzpqftI8mae
Di+9n8w1RphZDg5XfMGuWtKzsaQDgt4sm4HIGqO1EtrSmBk4u3zlDsv0FGF8Blh/
vG8UqC1P6oqLF6RoKpO15iV92i5vcJtsxol/NPtyRrLGWL2SKiKqc2LVdrpO8jlT
WFTGtSIqWU6Zk3ESqV8lLm1xXt4C+uuUrpuZL4UUIvHXCAX+1ySFLR2vzIbO8FQK
9u5qL3PlfA4LybJ8x8ZUlhKSxE3BAC90y+Kd/tyoRrlDa1ApYUgxC0ml6r4kP++M
nG23SdmiBqaqUn3I/aAf
=WVT1
-----END PGP SIGNATURE-----

--xFHWmGwbilGjB8dh--

--===============1859635199190998974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1859635199190998974==--
