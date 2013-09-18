From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: ifdef for ACPI module table
Date: Wed, 18 Sep 2013 10:41:58 +0100
Message-ID: <20130918094158.GL21013@sirena.org.uk>
References: <1379484624-11029-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3574197461554048318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C5AB260818
 for <alsa-devel@alsa-project.org>; Wed, 18 Sep 2013 11:42:05 +0200 (CEST)
In-Reply-To: <1379484624-11029-1-git-send-email-olof@lixom.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olof Johansson <olof@lixom.net>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3574197461554048318==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhjhOMouxCL2qD2w"
Content-Disposition: inline


--zhjhOMouxCL2qD2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 17, 2013 at 11:10:24PM -0700, Olof Johansson wrote:

Please send things to the advertised maintainer addresses.

> Commit 02b80773de37 (ASoC: rt5640: Add ACPI probing support.) causes
> a warning due to unreferenced variable on non-ACPI configs such as
> tegra_defconfig on ARM:

>   sound/soc/codecs/rt5640.c:2085:30: warning: 'rt5640_acpi_match' defined but not used [-Wunused-variable]

> +#if CONFIG_ACPI
>  static struct acpi_device_id rt5640_acpi_match[] = {
>  	{ "INT33CA", 0 },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(acpi, rt5640_acpi_match);
> +#endif

Shouldn't the fix for this be to do the same as we're doing for the OF
tables and have an acpi_match_ptr()?  It seems like we're doing the same
thing so we should be handling it in a similar fashion.

--zhjhOMouxCL2qD2w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOXVjAAoJELSic+t+oim9eksP/0GaYFRdzQd2TBnVfrtdXnle
/RNsZuOXyC/AxUfaRSqgdlYDMBM4Np2FQDyOyr0qEm07PVx4D4i9mnB97ZWwGUth
tk/wtzfbRkn9vNd6f3yTtpZr6AMPfCT52Y1FacR1jjLit1SJlwxLs9ADHSLZYnOd
zKDhnaw6GBck5H/2yXUV8i1QTOb2zUl27dzjcxQnXOTjlsfSLzrFybpF4XG0ueHC
8uLkyxmrdVReXun1eNoJVJqlw0yUq+gBaAGgsBcsCz++YM9IwA6/EbgTJnCc3B0K
URPdIawEoqaa9icbn7DK8e+He8+D07SvtPwtWmXiBdzHHKdHbaUj0ZP4qu7WogaX
5UcVZlBlqVZCV4mCSgibLQHNtTiaJPWLnAWx6z6ii+FetVMRNYKUSCmfpqAGYbv9
7nT8yUtzgTe2bJ1W0hgwAWW4oH6jhUtMAwmkQg0uy/so2+vNe4y+3cMqX/fgJI9X
QbxG0gL+UKkystDOUkLsiuMyAcipLaSh/gHSRaRlefmfdsXN5MpjhOH0Uk9UIaZs
bmHZzPTFRgFWM99zLJvzp6/IwN1Vr84tf+H5+6SJu+A269JTxIB98OXBmGXfZfHu
TT+hgj4KxBHvuWc3cCWRbMGRWXNBp1BiKcy5X3YpMmx+gPI7PdirWTlDsIrTfbcY
U68213RpCQGs7pkaR23O
=DAYW
-----END PGP SIGNATURE-----

--zhjhOMouxCL2qD2w--

--===============3574197461554048318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3574197461554048318==--
