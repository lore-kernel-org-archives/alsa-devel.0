From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dmic: Enable ACPI device entry
Date: Tue, 2 Oct 2018 16:00:57 +0100
Message-ID: <20181002150057.GC6338@sirena.org.uk>
References: <1538459851-17066-1-git-send-email-jenny.tc@intel.com>
 <1538459851-17066-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9061645756716991915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A9BDD267889
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 17:01:04 +0200 (CEST)
In-Reply-To: <1538459851-17066-2-git-send-email-jenny.tc@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jenny TC <jenny.tc@intel.com>
Cc: alsa-devel@alsa-project.org, Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harsha Priya <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9061645756716991915==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0vzXIDBeUiKkjNJl"
Content-Disposition: inline


--0vzXIDBeUiKkjNJl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 02, 2018 at 11:27:30AM +0530, Jenny TC wrote:

> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id dmic_acpi_match[] = {
> +	{ "DMIC", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, dmic_acpi_match);
> +#endif

This doesn't look like a standards conforming ACPI identifier, I thought
they were all 8 characters?

--0vzXIDBeUiKkjNJl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluziCgACgkQJNaLcl1U
h9Ar+Af/Qk9viwUTQItpEOs0gp6Pg/n7+Q5m9BS6ftCaoaesdPi876ZFBPGana6e
kawFQX9i4sIh+zosIhd5YW/s9y80aafg+432npJkSLOtQcQR6QNpDSqDgWfKLxzA
ViVqW7yMOatKS6Rzkr1L+wNiOy1Hg1oAgWbgRX5NpvXyU/DlegzcaNL098nNSljT
RUspqoIIrSMqXg718iNYQhS7kI3sNMGQzpSkiHW+KOMKjouvJdqK8qrU1zqt1mom
AiSehp2YD5GopgVbG3JETzGDuqln3FmlyJZt1PRRZ47YH6vyjNz9AVYzeGnzyJkV
DL3Bu1VokOTqE8HVsGzTHRzJcnF9yA==
=6bfK
-----END PGP SIGNATURE-----

--0vzXIDBeUiKkjNJl--

--===============9061645756716991915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9061645756716991915==--
