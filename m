From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: Remove 'const' from the device_node pointers
Date: Mon, 10 Nov 2014 19:03:32 +0000
Message-ID: <20141110190332.GG3815@sirena.org.uk>
References: <cover.1415562021.git.moinejf@free.fr>
 <d5d74f6993e9f2392008a27a2938c58d47dc8062.1415562021.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zzcyysZ8YhDsnlP5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d5d74f6993e9f2392008a27a2938c58d47dc8062.1415562021.git.moinejf@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Russell King <linux@arm.linux.org.uk>, Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--zzcyysZ8YhDsnlP5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 09, 2014 at 08:33:45PM +0100, Jean-Francois Moine wrote:
> From Russell King:
> of_node_put() modifies the struct device_node contents.  Therefore,
> of_node_put() definitely not treating the data pointed to as read-only,
> and therefore it is completely inappropriate for it to be marked "const".

Did Russell write this patch (in which case it's missing a signoff and
his e-mail address above) or are you trying to say "Russell King
said..."?

--zzcyysZ8YhDsnlP5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYQwDAAoJECTWi3JdVIfQG/cH/i1k6Zg0+Alez03elr0X9A5O
4Ce4AODbyTt0+wgPwAezQqDcZGtqoPRL0BIN/8ngiDPkhrAh43xueGDywmzt5c26
GfbxyH7ptbYvSEYWm9yXQvQ989MukJiZS5EN8CU9eRn2j9JfdCiEqK71RY6VKln5
AeRXFZfQ5jVPsV5sNUFDC6khAfzVao3cVkHugp236kjiyu+/V+rjp5r4brm+6GpH
KBhfe4hJPxNl1rn28z8ffyDLFIx5bC2F34R9jrnEKD3I74VXnnqy3B8AquLTsMEs
8c1rBim/BquDbM0TcZ9nR+7mmBkEAsHGUWXnSMI8n+UL095b6q/+wNcvvewRBOk=
=F4XH
-----END PGP SIGNATURE-----

--zzcyysZ8YhDsnlP5--
