From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH 1/4] ASoC: wm8960: codec mclk should be
 enabled early to avoid jack detect error
Date: Fri, 12 Jun 2015 11:33:49 +0100
Message-ID: <20150612103349.GE1921@sirena.org.uk>
References: <cover.1434020423.git.zidan.wang@freescale.com>
 <880838f666b591f5ffb0de1e39df5e3734846246.1434020423.git.zidan.wang@freescale.com>
 <20150611162028.GT14071@sirena.org.uk>
 <20150612063231.GA23608@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+JUInw4efm7IfTNU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150612063231.GA23608@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, lars@metafoo.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--+JUInw4efm7IfTNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 02:32:33PM +0800, Zidan Wang wrote:

> I have done some test today, and found that after mclk enable, we should delay
> at least 150ms to prepare the jack detect function. So no need to move mclk
> enable to startup.

No, this makes no sense - jack detection is not related to playback at
all.  The system should be able to detect if something is connected at
any time.  What this says is that you need to keep MCLK enabled while
jack detection is available.

--+JUInw4efm7IfTNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVerWMAAoJECTWi3JdVIfQ884IAIDHwOTPor+QtQieXlLBo5QH
LNBhHsPE5Oq0wym3T7kTkFmrMT3ZLCti3fx+u8VXAUOjxw1ZGF7oupIe3luabGJL
bcNzB8hZXGejfMOkMEc4/kRhPN2T26DvLzULrXwqnuPg1bxn6TRqDCZhoC3WDHXz
HMtJlBsTb5AYYWNgFyctWm54VjsytRLZ5vi8Ko/EpW2IaIP9akTkN2TknAZoNR9M
2f3wOo87xRERUtRgYoxabt2ESlsB/o6Xn/Ihi5WuMmWcIWgbj6WhwZfl2PehAdz0
JCPtfSgBMcVybJjZsGUpqtsgM+FwrwswnrWsTPm3pa3wT08r0uHycsBq9QusKbs=
=HTiV
-----END PGP SIGNATURE-----

--+JUInw4efm7IfTNU--
