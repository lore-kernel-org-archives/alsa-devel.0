From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: dmic: introduce mode switch delay
Date: Wed, 21 Nov 2018 13:21:37 +0000
Message-ID: <20181121132137.GD8059@sirena.org.uk>
References: <1542646386-9225-1-git-send-email-jenny.tc@intel.com>
 <1542646386-9225-2-git-send-email-jenny.tc@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4197756987939451888=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E473026770D
 for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2018 14:21:46 +0100 (CET)
In-Reply-To: <1542646386-9225-2-git-send-email-jenny.tc@intel.com>
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
Cc: alsa-devel@alsa-project.org, Jairaj Arava <jairaj.arava@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Harshapriya N <harshapriya.n@intel.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4197756987939451888==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mJm6k4Vb/yFcL9ZU"
Content-Disposition: inline


--mJm6k4Vb/yFcL9ZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 19, 2018 at 10:23:05PM +0530, Jenny TC wrote:

> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		if (dmic->modeswitch_delay)
> +			mdelay(dmic->modeswitch_delay);

Given that this is a busy waiting delay in atomic context it would be
better to have some validation when we parse the property to make sure
the value is half way sensible.

--mJm6k4Vb/yFcL9ZU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv1W+AACgkQJNaLcl1U
h9BF/gf7BBN5KII5233ICA1T+yAR5qrcflGG4BtbpAQn2oyGcfV/w3jdddmh/txE
a0TEBn3FDEKTxtih2rJIuJO0DW1mO+r6s6Dun8KtwlhdEsH362Ny4v6UCgHV3QVx
mu085kRbgqtJA9ca6014A8A9epvJyzg+kCt4rAjmntTKsjjXwHz1pyRmSSCysXym
714JO30Us5eBrWONeiRGu9zfqDvnT3a0ReuQO8RO6ubd8SEgw6QGZh28oAPbpcvN
RtWdTMKxOop4HWc23uFyL63+zo9OdB57nxKciJMvrrqg8ewNTsiY+xwYcmZ3Yk0N
xjE/ynfZQlDOpDLwPDcoNhg4E286XQ==
=wwU+
-----END PGP SIGNATURE-----

--mJm6k4Vb/yFcL9ZU--

--===============4197756987939451888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4197756987939451888==--
