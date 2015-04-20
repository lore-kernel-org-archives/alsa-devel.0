From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/4] ASoC DSP topology
Date: Mon, 20 Apr 2015 22:40:32 +0100
Message-ID: <20150420214032.GV14892@sirena.org.uk>
References: <1429217285.7100.18.camel@loki>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8591117207868106753=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CF0CF2654FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 23:40:36 +0200 (CEST)
In-Reply-To: <1429217285.7100.18.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8591117207868106753==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qgEfXXHyyarqcYJd"
Content-Disposition: inline


--qgEfXXHyyarqcYJd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 16, 2015 at 09:48:05PM +0100, Liam Girdwood wrote:
> It's been about 2 years since posting V1 of the ASoC dynamic firmware patches
> and a lot has changed since then ...

:)

> Kernel. The kernel core reads in the topology data and builds the driver
> capabilities and audio topology based on this data. This includes building
> the DAPM graph, setting PCM and DAI capabilities, registering kcontrols and
> registering DAPM widgets.

I think the topology code itself looks good, I'll take another pass over
it though since there's a lot to get through.  The main thing is to make
sure the ABI makes sense though - we can fix up the kernel later.

--qgEfXXHyyarqcYJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNXJPAAoJECTWi3JdVIfQkcUH/iMgtSGQR5GVtspyIG01QY9j
kFue8j5+6w6G8lJHb/hZZSKagagqVVOVwNLd+X8qcMnesc4HeY3NtxHbauNGdKoZ
W/J4y0xnDNAt45/4Xjj4xSPTHbytKnXWD9XK3VYQlazcXPiZkPF2NX1S66DuMALN
GxpclxTAq131Grq+TIuRCpeR71QKJ44RZp2hOionQRQdaBqyH/GCMim4M43c25gd
b3ZgE+/TnlSw44GIHlTfwVO3uW8vnrmxOGa1NIgi/KIX1LMboXR19KDeq1U/CzEs
TZ1CD2ZFkaYXEKX7XlT8vS+K3kpRTPdoK0Ov0j8e1iOQDwoOonPzxekqjP1SYoo=
=Jksf
-----END PGP SIGNATURE-----

--qgEfXXHyyarqcYJd--

--===============8591117207868106753==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8591117207868106753==--
