From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: rt5677: Add ACPI device probing
Date: Tue, 7 Oct 2014 20:12:12 +0100
Message-ID: <20141007191212.GF4609@sirena.org.uk>
References: <1412372246-10489-1-git-send-email-benzh@chromium.org>
 <1412372246-10489-2-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eqq5Le9VNi5o1NaU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412372246-10489-2-git-send-email-benzh@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Zhang <benzh@chromium.org>
Cc: alsa-devel@alsa-project.org, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--eqq5Le9VNi5o1NaU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 03, 2014 at 02:37:25PM -0700, Ben Zhang wrote:

> +#ifdef CONFIG_ACPI
> +		.acpi_match_table = ACPI_PTR(rt5677_acpi_id),
> +#endif

Why do you need this ifdef - surely the whole point of ACPI_PTR() is to
avoid needing it?

--eqq5Le9VNi5o1NaU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNDsMAAoJECTWi3JdVIfQQ/UH/1Ea+AKUABMRrUT4UuM/KqtF
6IgKFezy+hhK6sv5eAEZMADk82HFX29+hT3E9AKGgFu+Su5tiU3EBBz9+powcmIH
hpkuoOaMXAa7/fGmC5ZcQbobD6+NJljctYj5/QxH1dYRMbPbfy2vf/j4bLn82dx/
0/3shmZFvny9Emsx0JTxTNqug0xUE1Sl77/FDUwzu9b8v9yH0FYXFYglLahQ3hXt
l2WToSTegqaXB0xc06DqXKYIB4BiqreSWoOjgu0wF4rNxLHJYmtzjyuobM4AbwfT
0SvvwJzQyomTj8sWgKpzJ8Kt3xfoJCQDbdmjCZX29gRaABa88jVPEvCKbpsCC2o=
=e2bE
-----END PGP SIGNATURE-----

--eqq5Le9VNi5o1NaU--
