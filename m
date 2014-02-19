From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: cs4271: free reset gpio in
	cs4271_remove()
Date: Wed, 19 Feb 2014 20:15:29 +0900
Message-ID: <20140219111529.GI2669@sirena.org.uk>
References: <1392808032-25756-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5575866343607407061=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id DFB7F2652E7
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 12:15:43 +0100 (CET)
In-Reply-To: <1392808032-25756-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: brian.austin@cirrus.com, subaparts@yandex.ru, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============5575866343607407061==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MG8i8fjnGZSaPbFl"
Content-Disposition: inline


--MG8i8fjnGZSaPbFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2014 at 12:07:12PM +0100, Daniel Mack wrote:

> +	if (gpio_is_valid(cs4271->gpio_nreset)) {
>  		/* Set codec to the reset state */
>  		gpio_set_value(cs4271->gpio_nreset, 0);
> +		devm_gpio_free(codec->dev, cs4271->gpio_nreset);
> +	}

If it's being requested as a managed resource shouldn't it be being
freed automatically?

--MG8i8fjnGZSaPbFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBJJJAAoJELSic+t+oim9MVkP/0TCgKfsTCPwpHBDe1akmDWC
yu1beiIyboQi9lKde8VVdWV2lMlkQ3IxcMtjCFwBNL2bP7bzIijxq0VS4k0NJltv
ufvOh+nmsn3IYoERbSLph5Up4drIkZ/DH1jD0qYlLi4opJ9f30fcnK7MZWvsOYzt
4wckXs6IdHPtzmhFBoSVjIvpLXemxl4CKEIK/fwyRR2QXSZ3zW7qp3VeYJO3vYXt
U9wTmDaGDoB+pO7HdbCat5DAbUc7jeItrJSwVR6t5uGnUzV0t+G5lZPsCoMvXBQI
+1rMbpt2Pfu/CIOCUojJkwKz4hUenfk4lzkTIlEvYPFZ1+qE6y4SxyY00nzq2VCz
6AM4zoIaCuedmeSPoeGVric1FCfV+YF1JGOWxwissiGZ5F+5xOCxnmYze+0wvDfi
91G8AeBWr2GvUwERPLNGAUezMNpP3b7XCx2Ef7hBDNVvwXm7g+m9T8rEnBxh+dqu
rkpLZKSiY2ALYLWtLYfG+9iPWGZftM4WeH5oTdhwkEVR1h4c9U5XEZuTyU92wA36
oQenSSAUjRx10tphDU0Qf+4YS6hZY3JR16at1gBFRcLMTdE7PO51FJ9F34ShYbuP
AUlfcpgq5+4sT+R8j8w0ntvDMbShwGecsQlCy7yOoBg0XIa5Rj9EwnPwPioNv/YO
8pLSgqQmVU8Xy8AGP+5p
=iNPV
-----END PGP SIGNATURE-----

--MG8i8fjnGZSaPbFl--

--===============5575866343607407061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5575866343607407061==--
