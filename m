From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RESEND PATCH 5/6] ASoC: cdn-dp: Add cdn DP codec driver
Date: Mon, 30 May 2016 09:03:21 +0530
Message-ID: <20160530033321.GD16910@localhost>
References: <1464345942-4795-1-git-send-email-zyw@rock-chips.com>
 <1464345942-4795-6-git-send-email-zyw@rock-chips.com>
 <20160527202312.GB29837@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160527202312.GB29837@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Chris Zhong <zyw@rock-chips.com>, dianders@chromium.org, tfiga@chromium.org, heiko@sntech.de, yzq@rock-chips.com, linux-rockchip@lists.infradead.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Michael Trimarchi <michael@amarulasolutions.com>, Bard Liao <bardliao@realtek.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, anish kumar <yesanishhere@gmail.com>, Jacob Siverskog <jacob@teenage.engineering>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, Oder Chiou <oder_chiou@realtek.com>, Jyri Sarha <jsarha@ti.com>, Caesar Wang <wxt@rock-chips.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 27, 2016 at 09:23:12PM +0100, Mark Brown wrote:
> On Fri, May 27, 2016 at 06:45:41PM +0800, Chris Zhong wrote:
> > codec driver get some interfaces from cdn-dp driver, than using those
> > to set DP audio formats, corresponding to alsa formats.
>=20
> I'm not seeing anything Rockchip specific in here...  DisplayPort is
> backwards compatible with HDMI, shouldn't this be using the existing
> hdmi-codec code?


Yup, typically only difference between the two would be programming the
info frame for DP or HDMI, otherwise it is pretty much same stuff...

They should patch hdmi-codec for that, if that is not supported.

Thanks
--=20
~Vinod

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXS7SBAAoJEHwUBw8lI4NHOxYQAINJcZyGroE9Mlpe65uX1NFn
RdHjXBZItMswel4tHS4FT1vPZajM42m5XNviCuwdu672l12bVycY59WskhsHCWh9
zXkUI1JCogWSvQRHXXTwiOdUo9oMEwJFk+A+3ighS616TrYJ1rTkrLfOh0TcABoJ
ea4Jw/e9QwLYc0ljejtX0MugDOQyAkvnP7Mv6vVhNCHCJQTh7W0mXnYjTfBp8t6B
1679tGqTGOCQoCHnDWDQ5Oagr6JTr9qz5n1Kc9mML1orZY27CGFGo5S/la4fSpqS
ZfE8Clxl3dIu8xVoaKlVTqd2lzfYu9KAnK72iAoqu6E30o4p/qTUTA3ardkeoCtq
lkIoj80E7xoxSZWNM2UWlm2FNj84PMPZXS79+LLS8vBGVWTZBWN0oocby+kettJ4
CIsajBpG4pAFSi2ubcATWlJToXMwVy1bEf27SoAB90PSpX31eISpmtPkJjdAbhSu
FIJro20qur9rmCMPPWxPqj6UK6SUSatc0ejJrNU880wtXcY3GXrkUdQYToMUk9ba
iy++UkE+2CfTHGYyWwW5N06d/PkUmqXFOJaRj/EF36Psnelbm8N3OhCjxoDMtkTE
xJxP1yj3N7ZW4xzHHAupZxfa8UtdD8qLyOSvYRyMy/K7Fjv/vzz+rte8nACFKLnw
ogOugGFQWdfUtSnfbcNM
=01+U
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
