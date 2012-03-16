From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6] sound/soc/lapis: add machine driver for
 ML7213 Carrier Board
Date: Fri, 16 Mar 2012 19:06:56 +0000
Message-ID: <20120316190654.GF3158@opensource.wolfsonmicro.com>
References: <CANKRQngTNWMGswq3weD1s8O4irVEz+DCr1vzi2gnWaQcoq5SEw@mail.gmail.com>
	<1331275091-31700-1-git-send-email-tomoya.rohm@gmail.com>
	<20120314144524.GT3133@opensource.wolfsonmicro.com>
	<CANKRQni-8w+2p6=ZisQ+GXhGpNmYhesKfTHfOjWGGrQrhvTFGA@mail.gmail.com>
	<20120315105048.GF3138@opensource.wolfsonmicro.com>
	<CANKRQnhg21hjKjSOtDwbfK9shNsdcEu-aiSs1zVGNtAdaHdMHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6573503669449344786=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CF1B52412D
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 20:07:01 +0100 (CET)
In-Reply-To: <CANKRQnhg21hjKjSOtDwbfK9shNsdcEu-aiSs1zVGNtAdaHdMHw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: alsa-devel@alsa-project.org, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6573503669449344786==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ADF8FXzFeE7X4jE"
Content-Disposition: inline


--9ADF8FXzFeE7X4jE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 01:07:03PM +0900, Tomoya MORINAGA wrote:
> On Thu, Mar 15, 2012 at 7:50 PM, Mark Brown

> > That means "Codec bit clock master frame clock slave". =A0Are you sure
> > that's what you want?

> Let me clarify the above.
> Does the above "frame clock" mean "data line" of I2S?
> If yes, I should have used 'SND_SOC_DAIFMT_CBS_CFS'.

No, it means the clock which runs at sample rate (usually called the
frame clock or LRCLK).

--9ADF8FXzFeE7X4jE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPY48dAAoJEBus8iNuMP3d9n8P/34cYlobXtbmis18gU/qEomo
u6wcyrAERpY1dDAHRxN9Sr+aAyxD2UGiETLYIucSpWXYXj1AX3UPT0c5zNyxSgRn
VGO6Dso4bfGe6K26OHTk9WisXD0q/lyprlxYAT8j8HyIfm3cuvt4pqdBHw5WP41b
I7R9ZQqv0mgjolt75WT3b8vzWCBWOo5/SG66fUePPDYswInh7USNMotdFLx7Iouh
TlthySeg1CtrqiDRXN0TVlAuZW7ERuThicOlmqh5V8/euALt3WX1LCuuHKuvWavM
fWxfcM0Y+719BxwdgE0W1bTaV+dIrm50G0hXaC9KveBandKycjIqlFV0GJsSfgLm
AGEy4TbzYTsh7b92ZfN8cXx99yvw2dLe309jfwBtOZRfpRGC5NL1Q7+huPm8XqPs
9LyjBPHtDiCiPg0S0joX4/OUAbSLuBM4SuWdvBfBd0lZwH05KYc7hQ6Mk1o+yjpN
2p9d63CgzQ2NAl9dZLK8GHSp9QqhihKX8bDfxgh3twUNo2d/3NpeOZA9c9bf4ole
Jt5AZF6aGf0yL5qCbwH77gEzWasqWQGw/jF4oNHSDjtFp6c3sRy9Kj4t8OcokLoB
PdcLOInvuXelo8BusNP/7ihTNhfkIijO5mNwOjCX1gwQLuER6KkyU2D74h0c6z5H
PMzIL3W8d+SdT9b3CUCn
=JnYb
-----END PGP SIGNATURE-----

--9ADF8FXzFeE7X4jE--

--===============6573503669449344786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6573503669449344786==--
