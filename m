From: Mark Brown <broonie@kernel.org>
Subject: Re: Question about struct snd_soc_dai() :: cpu_dai->codec
Date: Fri, 29 Jul 2016 23:08:54 +0100
Message-ID: <20160729220854.GN10376@sirena.org.uk>
References: <s5h1t2f6jdm.wl-tiwai@suse.de>
 <20160727182233.GV11806@sirena.org.uk>
 <s5hpopy6dbi.wl-tiwai@suse.de>
 <20160728034643.GH9681@localhost>
 <579A6C1B.2060904@metafoo.de>
 <579AA39B.5030100@sakamocchi.jp>
 <884bd15f-da5e-49f5-73ee-d8173dc0720a@metafoo.de>
 <20160729160702.GK9681@localhost>
 <s5hy44k41oa.wl-tiwai@suse.de>
 <ab6b5a69-9d36-b4a5-0b8f-10a7dcf1ea40@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vy1A5eXR7jld12ZH"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ab6b5a69-9d36-b4a5-0b8f-10a7dcf1ea40@sakamocchi.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-renesas-soc@vger.kernel.org, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--Vy1A5eXR7jld12ZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jul 30, 2016 at 06:45:04AM +0900, Takashi Sakamoto wrote:

> In a point of 'reuse of codes', I cannot imagine what Lars said for USB
> devices, then post the questions.

Someone might make a fancy device connected via USB which doesn't
conform to the USB specs.

> But I think it's logically difficult to manage state of sound card; e.g.
> disconnect. When one sound card instance consists of instances of
> several 'DAI', 'Codecs' and 'Components' (this 'component' is not in
> ALSA core contexts[1]) and we try to unload one of them, then which
> state the card should be assigned to? Or no 'Codecs' drivers are loaded,
> then which state should be assigned to the card?

The card only instantiates when all the components of the card are
present, until then it defers probe.

> Additionally, when old Codec driver is unloaded and new Codec driver is
> loaded, then what should we do for corresponding PCM character devices
> are? Currently, once snd_card_regsiter() is called, we cannot
> insert/delete ALSA components such like PCM.

The card should be deinstantiated and reinstantiated whenever a
component driver unbinds and rebinds (respectively).  You'd need to
completely deregister the card to change the list of things it's
expecting currently.

--Vy1A5eXR7jld12ZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXm9P1AAoJECTWi3JdVIfQpfwH/ig7EKEHB9aglBF4K3l9fIhQ
usqUgcIiEANCJtA21mGEtWnLzYMkkkg9qN8h1eWI8I+Sdz48ZbBk5frqpsZ7Y4Er
5PaeIll6glBQgHXXRdHaKYPcVtCpNcR7VOU1oB5KcDEMej8CJzW48bPcNcVcG/NZ
vWBKuSFjnOcuq0T6ZJD0/UP70WfAzwUOyLpfJQU6g34WZWqHq0C+VMfwyX6Y8qnL
WkyBONGO30YKeI+mNrHhgdLscuqPH11u0t5SmfAwLhVXUvRgQSKbEvN5G7dVfwQ0
QRgYTWb+sU0jRbEZGX56Tr3nGLyvOJrADZ/F01hcrBji+hDyHMzMaSRDrX2lpp4=
=Zvqr
-----END PGP SIGNATURE-----

--Vy1A5eXR7jld12ZH--
