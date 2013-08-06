From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 2/8] ASoC: atmel: machine driver for at91sam9x5-wm8731
 boards
Date: Tue, 6 Aug 2013 18:11:56 +0100
Message-ID: <20130806171156.GN6427@sirena.org.uk>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1120917458341433714=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1375180329-4860-3-git-send-email-richard.genoud@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, patches@opensource.wolfsonmicro.com, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1120917458341433714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lBqJz4CGKwlWe7/k"
Content-Disposition: inline


--lBqJz4CGKwlWe7/k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2013 at 12:32:03PM +0200, Richard Genoud wrote:
> From: Nicolas Ferre <nicolas.ferre@atmel.com>
>=20
> Description of the Asoc machine driver for an at91sam9x5 based board
> with a wm8731 audio DAC. Wm8731 is clocked by a crystal and used as a
> master on the SSC/I2S interface. Its connections are a headphone jack
> and an Line input jack.

Applied, thanks.  We should really be able to merge this with the
sam9g20ek driver that's here already but we can do that later.

--lBqJz4CGKwlWe7/k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAS5ZAAoJELSic+t+oim9wsoP/iymoohS2yx71cDisVCXBgS7
JOFFy5h4Teps6KexuM191oDdahBeJf+OpI0JeIwiPsph+F/2TXhzLL6yibR9mu6K
wutal63C29RyBCkf0NObc7xl3IqHY4aaNBv1IForUmvE4se9eoDEvWxy2FythqEx
aG8MET96AZgLb9Y70aoe5q3aR0SJEBa2HcR8MI7EA/qdIivFnVCdYjwhwpMXzQdz
1u6tV3I7cIWFjpbKN0WRAoFFqc1xzT9gqQ5phYVCmiFbt2b+4jyC7Ptj/hSzarlx
vUOn+SRTc9cW0YiuZWqgmafAFcdIcMMTLq4FfW0WWT+jxILDd5CfDEDwjEmoEy+V
6dR46QL2jyZRTpzZQcPmvQqE/RTzhZfEmokf5OPFsgAI618SSHUw7D2iUIZ3Bo8m
QACAPm7L9loyTceCbCVNT36M6kWtVI2iIbxdqmncYMtrEb8K7+iccO+O+f9fIj//
Xr2BcI1vewX5ovr1r4aLEFF8cSUOkL8hw1WxlP3Ym8G7aPFTDi59ITzXuWMcE2/R
muh8XEzj+x/0aWC5gpsec+YjSUgXTxSNz4pEdSk8BW10VRn1Z/5xxc3L2XtiGijx
P5IgN4uvdDMbUgX/F2pLi36HjoiFBxHJk+7c3nKgSySiFUTQuD23M8Q6ztAJ06Hi
YkKeXv59wf3YpanhWQI4
=WTVc
-----END PGP SIGNATURE-----

--lBqJz4CGKwlWe7/k--


--===============1120917458341433714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1120917458341433714==--
