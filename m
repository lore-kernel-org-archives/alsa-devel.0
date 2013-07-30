From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 8/8] ASoC: sam9x5: get codec MCLK via device tree
Date: Tue, 30 Jul 2013 13:03:04 +0100
Message-ID: <20130730120304.GU9858@sirena.org.uk>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
 <1375180329-4860-9-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6839088780248459641=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1375180329-4860-9-git-send-email-richard.genoud@gmail.com>
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


--===============6839088780248459641==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oSAuG1J5f1V/btCA"
Content-Disposition: inline


--oSAuG1J5f1V/btCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2013 at 12:32:09PM +0200, Richard Genoud wrote:

> --- a/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
> +++ b/Documentation/devicetree/bindings/sound/atmel-sam9x5-wm8731-audio.txt
> @@ -8,6 +8,8 @@ Required properties:
>    - atmel,audio-routing: A list of the connections between audio components.
>      Each entry is a pair of strings, the first being the connection's sink,
>      the second being the connection's source.
> +  - clocks: Must contain an entry for the codec master clock.
> +  - clock-names : Must be "mclk" (clock that feeds the codec master clock)

This should be part of the CODEC binding, not part of the machine driver
binding.  The machine driver should currently have the code to fetch the
clock but since the clock physically goes to the CODEC it should be part
of the CODEC binding.

--oSAuG1J5f1V/btCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR96t1AAoJELSic+t+oim9jKQP/0BEIr2d0D9nnjNVePmuKLCs
KUnmG8wJYIAb/At0vcoarXsuHcLbOHEW7SA+E6swMQADljW6RVK+MLZeCkvpOJAb
u3VztUNc47CRUgdKAf3xg/fTcfgv0HH3rVgQSSin4+b0QDL7x6mOrFEZKExceFCJ
4CAMJtu6BbahXvx5x3/uRdsYUuv8j+Cws38ISkwilykdRU7eY3qTh+ExL1Kc3O9q
v1ufoIzXK3mUlakk6BQSYQmDNxflIxpT4IeSnazSjzRbi1PNRkGeCc9VHfEpJ4CE
2xl+ly5NTVndXdyDjsKwSccwIeCxgoUnqs2G4m7gXzZ8Iz3umCU0Vp5E0dW+7pkf
VgETNa5W+TgvLy+ku+nkQ7q5ZggqD/QA2P/UEcY4qbxsj7UEee+XtbdLGBw8KDyt
WMoZUM30hotGE1DUhiBsQ4d73pTqUdHSeBS6GQjvS6Z+sbO61olyXJKy4/BJgjPW
tenOKH9bUdQHx1gjTvMV90yGh2RcwHJluYBA+1eSLJ91kHXahEx4WbS1WEGYCquR
NuravohT9hzto6e/UCi9EbpKWg2X3foZcym3lUEhNKgZoEgfF+4acp2CSbeo58LQ
FjeKL/7QDZ+6CmH+apcgbRozazGgdR+76jnuJV96+VY77uiglVv5/C/QMhZeNIke
vokAfMyUeIuMZKD0gC7W
=nqXN
-----END PGP SIGNATURE-----

--oSAuG1J5f1V/btCA--


--===============6839088780248459641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6839088780248459641==--
