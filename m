From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: improve RT5514 dependencies
Date: Tue, 1 Aug 2017 15:21:17 +0100
Message-ID: <20170801142117.oc3owynj74g5bmyi@sirena.org.uk>
References: <20170731083217.4142512-1-arnd@arndb.de>
 <s5hh8xt0xwy.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0020928494787619397=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <s5hh8xt0xwy.wl-tiwai@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Ryder Lee <ryder.lee@mediatek.com>, Hsin-yu Chao <hychao@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-rockchip@lists.infradead.org, Harsha Priya N <harshapriya.n@intel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Sugar Zhang <sugar.zhang@rock-chips.com>, Vinod Koul <vinod.koul@intel.com>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, Naveen M <naveen.m@intel.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Xing Zheng <zhengxing@rock-chips.com>, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>
List-Id: alsa-devel@alsa-project.org


--===============0020928494787619397==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c5orlciowmjagxeg"
Content-Disposition: inline


--c5orlciowmjagxeg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2017 at 11:15:57AM +0200, Takashi Iwai wrote:

> IMO, flipping the dependency looks saner to me.  The SPI function call
> is a kind of add-on, after all.

Yes, that's definitely the intention of the code.

--c5orlciowmjagxeg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmAjlwACgkQJNaLcl1U
h9A9MAf9EC43e7zsFHFItYPZoEpdPK9Sqp6Bx+EP4UGXrWc4Yzd37dNWLCPIIuar
C5M53ZYp0Em2W1EtkxVYe3rRx2rKcjOgdMit/52DjNOrP5JwFZH8IMSpk0CNtQ5F
G0PyPnDvBqbP4+bwIl4REu/JQE7DHJroD9VP+gB0A2nyg/MjWghEI+B9xn2mHDhr
lLligmaL+pJ4n9/lyYL1xdtB+gqNVENNC5xpnwx1+N+18dhgtxjR6GPeEIBS0DSA
p6geFBBQ2WDIvPp8uTZlXhvW9k8AnGXNvOfR95Nh+hMfwb9oeklW2LPNOuzTqPhf
cdz9fsVLZh/t5GXfKdOJ4y5rKvOqgA==
=xD2N
-----END PGP SIGNATURE-----

--c5orlciowmjagxeg--


--===============0020928494787619397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0020928494787619397==--
