From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND v3 2/2] ALSA: replace CONFIG_PROC_FS with
 CONFIG_SND_PROC_FS
Date: Wed, 27 May 2015 17:32:04 +0100
Message-ID: <20150527163204.GF21577@sirena.org.uk>
References: <1432727145-6504-1-git-send-email-yang.jie@intel.com>
 <1432727145-6504-3-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5psUoSEXadgnVfkT"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432727145-6504-3-git-send-email-yang.jie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jie Yang <yang.jie@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com, vivian.zhang@intel.com
List-Id: alsa-devel@alsa-project.org


--5psUoSEXadgnVfkT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2015 at 07:45:45PM +0800, Jie Yang wrote:
> We may disable proc fs only for sound part, to reduce ALSA
> memory footprint. So add CONFIG_SND_PROC_FS and replace the
> old CONFIG_PROC_FSs in alsa code.

Reviwed-by: Mark Brown <broonie@kernel.org>

--5psUoSEXadgnVfkT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZfGEAAoJECTWi3JdVIfQd3cH/38Mo91LiU04iXrmx9/+qTCL
/LtQe4EOy/AAsGK3aOv+m/QAUE/L/FEUMwg0FKwiV23uAtcu98sFhbVkFiR2jK2N
AV5+q/PTYeK1g4B6vp0vzrWS/VCC6uk8kLIe1hr1ZD2zK9nxHDLRtAcvJ+ImXraz
yNPSCl8nxOQ+lo/tWjFT8JnfmHaB6jlMY9SfwsY52LNM/EUEY/DmO0K7TkYm2XLV
ZIRzaQ6UpPHYaKvPsIIb/oX4H4gVynj+0Lv/x0sZ6pb2ZX6FupAO8GWEBQzKnYdy
H5qXVSPF9nDjaNQxYFrEOANumiHOK66RsN9fUg03jY2D4gKdB1sd5KBOJmN41zc=
=yb7x
-----END PGP SIGNATURE-----

--5psUoSEXadgnVfkT--
