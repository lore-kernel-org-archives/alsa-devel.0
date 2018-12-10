From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/7] ASoC: hdac_hdmi: Add missing display
 power-off at driver removal
Date: Mon, 10 Dec 2018 14:33:44 +0000
Message-ID: <20181210143344.GC6307@sirena.org.uk>
References: <20181209093318.27829-1-tiwai@suse.de>
 <20181209093318.27829-7-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5250052990846835437=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C3AB2267AF7
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 15:33:46 +0100 (CET)
In-Reply-To: <20181209093318.27829-7-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5250052990846835437==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 09, 2018 at 10:33:17AM +0100, Takashi Iwai wrote:
> The display power is in unbalance at removing the driver since it
> misses the snd_hdac_display_power(OFF) call.

Acked-by: Mark Brown <broonie@kernel.org>

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwOeUcACgkQJNaLcl1U
h9D//Qf/YuGls+ioxezRfR5x6B7yT6njjG4UWLofL96VqmhAvHXkL0YxYKMPhq1P
PbwXzkztyyu9AEUlKjKnx9SNOPf++v66BwjifYIDjaKNaFFZaj1VigH7KRsJqjw+
Ms9de8j+MVfONhbfefRNa2o3dc0qpHx2Xw/AQyY4cTZTNw1VutWC0WPeSpfIjTjf
hJTHlKIBHcKT7ZI0VmXULI5DkN6lIbn+KouHsWm6TtWWzZW3aiEDKsFoyWFdDv1v
hn9LDZph9IJKQvkzvXUot39/EIs1QqeKtlVrRC4JXTooNn5HmtFpk55E2stxyg8/
X94WCHiAadNeIIY1nivGp45zfjqFJw==
=+ART
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--

--===============5250052990846835437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5250052990846835437==--
