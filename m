From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
Date: Wed, 7 Nov 2012 15:44:51 +0100
Message-ID: <20121107144450.GF20844@opensource.wolfsonmicro.com>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107084932.GE20063@game.jcrosoft.org>
 <20121107092124.GE12323@opensource.wolfsonmicro.com>
 <20121107104121.GG20063@game.jcrosoft.org>
 <20121107140535.GA28954@opensource.wolfsonmicro.com>
 <20121107143046.GA4576@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6875580585930736670=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20121107143046.GA4576-RQcB7r2h9QmfDR2tN2SG5Ni2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-sound-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============6875580585930736670==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2012 at 03:30:46PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

> the one via ASoC for the driver with the pinctrl for now but MUST add it later

> the arch/arm related via AT91 tree where the pinctrl is mandatory in the dtsi

> I'm no going to spend hours to do the pinctrl to test Bo patch that he is
> supposed to have deon to test this code

> As basically today on DT none of the board will work if BO does no provide the
> pinctrl so for me he MUST put in the dtsi

> is it ok with you?

Or add the pinmux bindings for other IPs over in the pinmux branch and
the pinmux binding for SSC here (which will help with bisection as the
DT bindings for the audio will then always exist in conjunction with the
.dtsi changes for them).  Either way is fine with me; I'll leave things
as they are until I see some new patches.

Though I have to say now that I look in -next it's a bit surprising that
there are so many IPs in the file that have no pinmix configuration,
based on what you're saying it seems like the entire board will be
falling over with the pinmux code anyway - in the case of the sam9g20ek
we'd at least need I2C pinmux settings.  I may be misunderstanding.

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmnPZAAoJELSic+t+oim9eGwP/iH9fYnKQxAs2Po/qXM84Hcp
1TP27jtE5eD1HESVj4WS5H/JULBtm3dSLNPB80MALVTo68s1w52NHfNzjDRV/m3o
g54sPFCA5KJdzG4y6rFjcRXr58aDe55n87U+TD5VbJjhbafKso2t50pPZwmuq54n
zjd2x7xjZf4LhpU5T3SIkcbwTLoYH6nlJZFgGmsa7a5aETkZkRk4kKw48VKeDVbH
VlJsQJEvEykLrZ5soHswlEtm/m209yeBweKij4pnI8vFdM1f6rlfeTlqekd52pNA
4t25fOSUgruRgEJBdbOVTeyTv0yWRPsaq2df60PdTdUySJzV79JqAB1m5PuKTTJT
qkTpqb8dKEYoPvElvfVAK2kJToGzyM1K5743/UJItFXmC8GUOtfEPwpUaE6d27uD
yyQWeH6+BysfZPuKv7T1DWNo4q9KLxwn/fFK1faNbpIaGsGmbU3TPf0nTrTCihOI
dcn3WjnEbvmZBJEsrjACIdMKqnXOVXrTaOlaq2jTafVssYw9XNhB2bP2/aE8zqfK
kNgjm7ofQxPCXgI+2D3fkJu0+Vp0HbsikCA+CzVJm8Zcbf+4J2/sEIDqBOyb5aDJ
c0ok61pQnOy2cUyY1L0/tWFxtOHIkj4x+J3fABGVK69wOrUAHJl/J6XYoS5O7Z+H
lDb3nu9eYluWN7fi2Aeb
=CclD
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--

--===============6875580585930736670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============6875580585930736670==--
