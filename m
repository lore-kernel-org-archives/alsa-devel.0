From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: Device tree binding to dummy codec
Date: Mon, 28 Jul 2014 17:27:15 +0100
Message-ID: <20140728162715.GZ17528@sirena.org.uk>
References: <CAKON4Oynu5HE-jDETrNRBY3dYtwuh6XmOgyDOQuc4jmCzmNhNg@mail.gmail.com>
 <53D5ECA7.5090106@metafoo.de>
 <20140728112055.GM17528@sirena.org.uk>
 <CAKON4OzXfq+gDLdzs0VYh+X+4RBU=2Nds45P7+kBd+02eY+zHA@mail.gmail.com>
 <CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7218583528568422104=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A9C0265125
 for <alsa-devel@alsa-project.org>; Mon, 28 Jul 2014 18:27:36 +0200 (CEST)
In-Reply-To: <CAKON4Owhhw6WvJBvZC6KYpS+rtvbPymAqEb1+4iZ=e6OokGeng@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7218583528568422104==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C5feqNWLfuTauAvZ"
Content-Disposition: inline


--C5feqNWLfuTauAvZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 09:49:27AM -0400, jonsmirl@gmail.com wrote:

> codec: codec@01c22c00 {
>    compatible = "allwinner,sun7i-a20-codec";
>    reg = <0x01c22c00 0x40>;
>    interrupts = <0 30 4>;
>    clocks = <&pll2 0>, <&apb0_gates 0>, <&codec_clk>;
>    clock-names = "pll", "apb", "codec";
>    dmas = <&dma 0 19>, <&dma 0 19>;
>    dma-names = "rx", "tx";
>    widgets = "Mic1 Jack", "Headphone Jack";
>    external-amp = <&max9768>
>    status = "okay";
> };

> If external amp is missing I just bind to my internal dummy-codec.

No, the CODEC that's in the device should be there all the time - it's
just the same as connecting an external amp to any other device,
describe the hardware in the SoC the same way all the time and then
connect any attached devices to it.

--C5feqNWLfuTauAvZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1nngAAoJELSic+t+oim92IgP/1blDtvAUoafSTUEGkjq0RTy
0i18yzcVneHapdAF8WsdMByr5rsIc+KnIhfKoirkuY41M+0KCysIfeofLVW0M6Om
xgiRCFc7HdbhiJlig5JxblQJvBGJg1HroZ7inhACSwdzsHz6VLfFe4u98gMHQcfJ
DijwSAXJ0lZHWMO7Db5hXgqQKxQd/aT96IULlyc0j3vcFbLuQIuvP71FYk9Cv6ir
ylmI7RRVVuo0K7Z+ldh7MwHy9X4rtljCAkO+qWaUunuoOHR936mpL4G1MPvgna6V
IEtZzdapxyg5esTBiNmDDMBZ3TtcVM6SD3CVBXJCiDJvZ5EifYjBIaD8giGna17o
tGVnqVti7vpKDacCbuWUOexAefu2hQSTr7hzWLTq1dGV1TEltToKM9TzUmSwWhyg
ou5X73rD0a/4LoKcuaTP7NiUgJEMQcMWhlJ64QeR5N9pIoXQmlrhGoymTH2QYjUq
KeFRQZfvHQCbQQtTk9IqYpEk9S47TPGLS+nExXSOVMlq6c0PQWVUuJR1maxY0S0R
QYCgl0IMeklJWi3e0TDRz2ukO0xeiz7e3Z+EfFAs72/6oG86IZyDCBOIOXu4OSbK
8BsQyyX4vyVrzIaPQWpD0b1Ut4RBlf7PKOkZTw/UomPYTe0VsGTcvPqS6yXxz4Gd
9d/o4EYH3mlM9VqoYqSm
=fuvv
-----END PGP SIGNATURE-----

--C5feqNWLfuTauAvZ--

--===============7218583528568422104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7218583528568422104==--
