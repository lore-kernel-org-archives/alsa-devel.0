From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm_adsp: Add basic debugfs entries
Date: Tue, 9 Jun 2015 16:49:36 +0100
Message-ID: <20150609154936.GC14071@sirena.org.uk>
References: <1433774222-25103-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150608174041.GK14071@sirena.org.uk>
 <20150609120641.GA9887@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wyYQCv9VYpiQX0rh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150609120641.GA9887@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--wyYQCv9VYpiQX0rh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 01:06:41PM +0100, Richard Fitzgerald wrote:
> On Mon, Jun 08, 2015 at 06:40:41PM +0100, Mark Brown wrote:

> > Why are we adding this init to every individual CODEC rather than doing
> > it when we initialize the DSP (which there are calls for already)?

> Because we call the existing wm_adsp_init() early in probe and at that point we
> haven't registered the codec yet.

Can you not either hang it off the device or move the registration
later?

--wyYQCv9VYpiQX0rh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdwsQAAoJECTWi3JdVIfQAZQH/3oG297I1WqwEePg4l030Go9
P7gLXaUs6MH+OrJSGB9D7n/s/BQmBLCZaH6x/f5JiPSXvJE0wt+P2OWJLBrTDgAb
gl7j5cGyz+nc+K4uLCzDaCsnEBqLqJVHxjj2B4rTTtw0olaRTSVswhydNFsKUV1w
GxQaIOeNeErqiX14rvHBVPD26ErPQfWjiER/gUoGwXSuAJ+hoX7oe9FTMK8efoXi
Cqh7QWAc3tp8TIBFQa3qz9J/oD9jOFO8/Lm9LIj+Tp9gukv+m4q6583gOnh4ONK0
QUOUBx4C4EVPDjK5SkCv3UK/wsBzCm8F3/JV/smOWOQb1y55f1WloTtm6AUlcpo=
=lMan
-----END PGP SIGNATURE-----

--wyYQCv9VYpiQX0rh--
