From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: add master clock handling for
 rt5640
Date: Sat, 27 Feb 2016 10:51:43 +0900
Message-ID: <20160227015143.GV18327@sirena.org.uk>
References: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com>
 <56CC719C.1090901@linux.intel.com>
 <2199435.lA9iTvxnKV@phil>
 <20160224033259.GL18327@sirena.org.uk>
 <56CDD5DD.6040006@linux.intel.com>
 <20160226010818.GZ18327@sirena.org.uk>
 <56D07293.902@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fyFqtIrDrUc8SGBF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56D07293.902@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Sugar Zhang <sugar.zhang@rock-chips.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org


--fyFqtIrDrUc8SGBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 26, 2016 at 09:43:15AM -0600, Pierre-Louis Bossart wrote:

> Yes there are documentation and helpers I looked into, but to the best of my
> limited knowledge not for the gate + dual-rate case. Then you jump to
> complicated configurations combining multiple base clocks that don't really
> make sense here. After one frustrating day of trying to wrap 100 lines of
> code into the clock framework I gave up and kept the simple custom driver.
> There is a single client for this clock so I don't quite see the
> benefits/ROI of mapping a simple piece of hardware with a complex model.

If the helpers aren't fitting your needs then surely just writing a
simple driver with set rate and enable callbacks isn't going to be too
hard?  The wm831x driver was pretty trivial to write and seems to be on
a similar order of complexity to this.

--fyFqtIrDrUc8SGBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW0QEsAAoJECTWi3JdVIfQRQUH+wWufcVgRXjkOgaFnVY07VAC
Cy1icjgUb+Soj9uNg8ndpozN80mkqnPAsbH5IjjEU4gVu5kxyG0wwd9ei3NjP/YE
GsoFtEITrZc04Rg3GSJzpMCtV4v4unEt5KCyb6kH0Qoxlk+OamyUWNYnguyTv0fT
x6VjRZydGSE8blzY8BjODnqpC78254Yad8aPLJiw2CvafTU5tzvhDNxYS0TPdijX
X8wm68UG/q7QjI/uhR5UYH7O2PZyp2cY/RPt2A7ZPzy///1vSo5JRfj3JP/rHFSw
LXSevfaUAbne5PFXJ+v3t8WokmNTNf4+DfUkoSnPGUEO+8aqMQFjbrIpVKBVt6s=
=HNHK
-----END PGP SIGNATURE-----

--fyFqtIrDrUc8SGBF--
