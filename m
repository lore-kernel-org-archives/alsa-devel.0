From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt286: Set cbj_en for ACPI devices
Date: Fri, 12 Sep 2014 14:55:58 +0100
Message-ID: <20140912135558.GW7960@sirena.org.uk>
References: <1410399654-10371-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6140166500705937308=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BB2D261A74
 for <alsa-devel@alsa-project.org>; Sat, 13 Sep 2014 17:39:21 +0200 (CEST)
In-Reply-To: <1410399654-10371-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, graeme.gregory@linaro.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6140166500705937308==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ngiTnHdmUEG79yp6"
Content-Disposition: inline


--ngiTnHdmUEG79yp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 11, 2014 at 09:40:54AM +0800, bardliao@realtek.com wrote:

> +/* the default platform data for acpi devices */
> +static struct rt286_platform_data rt286_acpi_data = {
> +	.cbj_en = true,
> +	.gpio2_en = false,
> +};
> +
>  static const struct acpi_device_id rt286_acpi_match[] = {
> -	{ "INT343A", 0 },
> +	{ "INT343A", (unsigned long)&rt286_acpi_data },
>  	{},
>  };

Why does this platform data apply to all boards using this ACPI ID?
Shouldn't this be _DSD data instead, or should we be doing quirks based
on DMI data?

--ngiTnHdmUEG79yp6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUEvttAAoJECTWi3JdVIfQ3aoH/jpTw+XGwUOcjeupLqaLWX9B
vSwihVEc0scyCNMSKJARrCR7aJV3BVY7C+ybD39hVxyrVRzrLSew0JISX17CDRHa
kAuKgEG605/zfd1AOR0fjBllH3OJx3OgUAQX/RnMe46hUc66qKLfIEL1Rm/xkpfN
1xEgtbFrJek8HAEUJ85IATwcTLq6LVBb7wm+22Y4Nv4Cl2iUzUXU0gtqps+u6urN
stm1oWT3ydOD9jmEbnOdzVrkPGWXuqdY9j9fCMt/OmuYenyssaN5lLUaEfENNDz5
2Y+LH6DKF/AP4maD4LJ/bDb5Nsgr647E/emq4p9LRmAWLnoLuO7J+K5fz0cRZiI=
=M5jK
-----END PGP SIGNATURE-----

--ngiTnHdmUEG79yp6--

--===============6140166500705937308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6140166500705937308==--
