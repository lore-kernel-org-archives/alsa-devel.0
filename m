From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5651: Add support for external
 amplifier enable GPIO
Date: Mon, 25 Jun 2018 13:40:59 +0100
Message-ID: <20180625124059.GK9413@sirena.org.uk>
References: <20180624130247.18150-1-hdegoede@redhat.com>
 <20180625104503.GA9413@sirena.org.uk>
 <7cc86f0e-7bdd-2456-f0b8-4e869c228793@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6158090429840323424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 330EE26720C
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 14:41:06 +0200 (CEST)
In-Reply-To: <7cc86f0e-7bdd-2456-f0b8-4e869c228793@redhat.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============6158090429840323424==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AYsPlKobQGgtCvjI"
Content-Disposition: inline


--AYsPlKobQGgtCvjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 25, 2018 at 02:19:02PM +0200, Hans de Goede wrote:

> Hmm, that seems like a complicated solution to use for non DT platforms

It should be fine for board file systems as well.  I think it's just
ACPI that's painful here :(

> I already need to deal with this in the sound/soc/intel/boards/bytcr_rt5651.c
> machine driver (call devm_acpi_dev_add_driver_gpios), so I'm tempted to
> model this a supply for the speaker (which it in essence is) inside the
> machine driver and make that supply directly control the GPIO, would
> that be acceptable?

Sure.

--AYsPlKobQGgtCvjI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsw4toACgkQJNaLcl1U
h9CfSgf+KaEfDRMPqVF+JL3YFOBLWnYmSKMH2E4L4AEVR7NoA/cD+AbT5TWZXAdd
ZVtcDJWUcLTi7T/w/du8eGs7EBVGHAaBBUCDc3Qi+HjgbK2Uj7gJ7JzDJMyPIDzy
5gq1x5y1pZwRFaZismhdlF+8pWrPZb92ekufXnQcblHm7rSrO37YE2lz5RZvVBw3
owVhmC2tuqRxhcClrd1nDIMU3fGaG/vzBDa8Kz9nW1kuTMExJSSeDQZKIfLaHU+z
/0Ej1fNR6zbqoyJVfYtIqUrkXoGkUvk+AV/AL0PZhzVqFG5ykMcvZmOc98nt4vd3
mMKaXZCcY5MwkqGi6P6+HuYZrBYnxA==
=WVME
-----END PGP SIGNATURE-----

--AYsPlKobQGgtCvjI--

--===============6158090429840323424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6158090429840323424==--
