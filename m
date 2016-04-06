From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5514: add rt5514 SPI driver
Date: Wed, 6 Apr 2016 10:05:58 -0700
Message-ID: <20160406170558.GQ1924@sirena.org.uk>
References: <1457953101-19348-1-git-send-email-oder_chiou@realtek.com>
 <20160329215121.GP2350@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FCEA41@RTITMBSV03.realtek.com.tw>
 <20160331165048.GE2350@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FCF18D@RTITMBSV03.realtek.com.tw>
 <20160401141740.GY2350@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694FD0CE7@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4055374171363610983=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B7F226070F
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 19:06:08 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694FD0CE7@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "koro.chen@mediatek.com" <koro.chen@mediatek.com>, "pc.liao@mediatek.com" <pc.liao@mediatek.com>, Bard Liao <bardliao@realtek.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============4055374171363610983==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FRaepaAnLTQkJ4tS"
Content-Disposition: inline


--FRaepaAnLTQkJ4tS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 06, 2016 at 11:30:25AM +0000, Oder Chiou wrote:

> > So if they do that the driver will not be compatible with their
> > reconfigured firmware...  this needs to work on all systems, including
> > end user ones with different system integrations.

> The DSP of ALC5514 is a programmable DSP, and it also can control the all
> setting domain including routing path. So they can modify the different
> setting on the same register address in DSP firmware. The default settings
> also can be reference for the development of user's DSP firmware.

That doesn't address the issue at all.  You've got a large set of
register writes in the driver which will be the same for all users.

--FRaepaAnLTQkJ4tS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXBUH1AAoJECTWi3JdVIfQRmAH/1tWkuoNwb1Ik/gwElbMeAj8
fnaDPt2tN1PEzQxid0X9G6Vhxh30mDEiHxMYnyvcZz5qFuINxaGXaXuUF8jfmJy4
k8TR64g/QWF8cCc/IBM/OcJiyi9DotV9hvZDZfM0DpV5ty9DnrLhN4+ZtxFwSJfW
pvOHyMxpVDPy7k+5LZLaGs+IoKut6RNuS4XlSRxl2jpEs4bNrSZAdRgYfmIU4VDg
P4NDDOQ8j9tHfd5jsJK6Qg1uKrPLjaE2vaOP0dL8I8kjAmgm5rCobxEPFKZQUU4G
tYSziESRpmvtL+i/Bdd9/IkwRJAXbX8UQ1fFBHRt7lY4ZeHqWCIf6ZACzUnU9JA=
=dXi1
-----END PGP SIGNATURE-----

--FRaepaAnLTQkJ4tS--

--===============4055374171363610983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4055374171363610983==--
