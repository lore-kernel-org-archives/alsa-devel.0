From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] Question about struct snd_soc_dai() ::
 cpu_dai->codec
Date: Wed, 27 Jul 2016 19:22:33 +0100
Message-ID: <20160727182233.GV11806@sirena.org.uk>
References: <878twpj739.wl%kuninori.morimoto.gx@renesas.com>
 <20160727032111.GY9681@localhost>
 <s5hh9bb7he6.wl-tiwai@suse.de>
 <20160727172125.GF9681@localhost>
 <20160727180456.GQ11806@sirena.org.uk>
 <s5h1t2f6jdm.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dBMBt2YGaTHbdllf"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h1t2f6jdm.wl-tiwai@suse.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org


--dBMBt2YGaTHbdllf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 27, 2016 at 08:11:49PM +0200, Takashi Iwai wrote:

> I'm wondering whether it's a better option to block the unbind
> behavior, either in driver base (allowing to return an error) or in
> the sound side (waiting in remove() until the sane point).=20

That's certainly going to be a lot easier and part of the reason it's
never been looked at much is that (unlike USB) there's very little
reason why an ASoC sound card would ever be hotplugged - even in
development these days the normal development flow involves rebooting.

--dBMBt2YGaTHbdllf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXmPvoAAoJECTWi3JdVIfQ3wsH/iB4vRqAMgOyGMsSTknY9i2S
LT3t3AWBlrbkx8CyXHl8EOdG3Tuhr8A8APBDdN3Br4NJv8kQQMsUtRSNbR3G+lRK
Heg6NxuN5+wQTx6VTxWaEcL8f3FbLUuiF0o3maXd8z/LNE0KdWNqFRnZnqGXNq5F
PgFEfol4W86Ag5TUxMtwvX25GtHPNTavPTW/oSSM3U3I4N9tPCeh/SL1WBQZRFbq
dcNKEYQDA6s7YIiU8gmE1k/8V480jdvo1pGM2Srms/EYMKJnF4VZEI5sUgAajhfH
+eZ39UbjCGaAcIs/bD0BwXu4/WNyiZQYqzcF4+2XmBlwD0YRUQVUx+4YmMfypWQ=
=wcfj
-----END PGP SIGNATURE-----

--dBMBt2YGaTHbdllf--
