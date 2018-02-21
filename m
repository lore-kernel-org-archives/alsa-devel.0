From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/11] ASoC: rt5651: Simplify
	set_bias_level()
Date: Wed, 21 Feb 2018 11:43:28 +0000
Message-ID: <20180221114328.GC8334@sirena.org.uk>
References: <20180220221511.22861-1-hdegoede@redhat.com>
 <20180220221511.22861-4-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6386339335440231184=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F27D9267502
 for <alsa-devel@alsa-project.org>; Wed, 21 Feb 2018 12:43:31 +0100 (CET)
In-Reply-To: <20180220221511.22861-4-hdegoede@redhat.com>
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
Cc: Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============6386339335440231184==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Content-Disposition: inline


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2018 at 11:15:04PM +0100, Hans de Goede wrote:
> There is no need to set the LDO voltage to 1.2 volt each time we enter
> standby, instead always leave it 1.2 volt on BIAS_OFF. Note we do a
> snd_soc_codec_force_bias_level(BIAS_OFF) on probe, so this will configure
> it correctly right from the start.

That force on probe sounds like a problem...  if this is being done once
at startup it should be done in the probe function, not in the bias
level configuration.

Also, are you sure this is a good fix?  If the bias voltage is being
configured all the time does that perhaps indicate that for better
performance or something it should have been being set to some other
voltage when the device is in standby?

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqNW18ACgkQJNaLcl1U
h9BNMgf/aGwJs3snk2VE8BVMyJ46vLbyZA0TyeuimVS1ctKYByTueH1Y0geJEuvK
eB3SXM7wOjvk5Qr/idW/0Gk9QtfojarKaFxLaWE75vhdRahfNGqyAksQtrXU4Usf
tDSbnA/bZlCE4FlCXRXdI7DURt5Xrw3D1yh4c+q885n7sThA0y3t0wx4JeZGoRFB
P1wGNY34AjvsTZM+Yf58YnoqTCZ+V7pwt13QV2K/0xZzTaqXpcogEIpwh3Go5+Fu
7qfIGd3HvcB+rM9kuKOg61DUp1idrOLBh9uIQ6BjM/95css18Zz/9AgU9L2vn/zi
Ef3nvaMtibhz70LXXopJe8rmgjCoOA==
=9lv/
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--

--===============6386339335440231184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6386339335440231184==--
