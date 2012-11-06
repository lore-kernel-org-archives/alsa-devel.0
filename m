From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patch v2 3/4] ASoC: atmel-ssc-dai: register platform from DAIs
Date: Tue, 6 Nov 2012 09:53:09 +0100
Message-ID: <20121106085309.GD5044@opensource.wolfsonmicro.com>
References: <1351668420-18447-1-git-send-email-voice.shen@atmel.com>
 <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
 <20121101144315.GM4413@opensource.wolfsonmicro.com>
 <5093312D.4070408@atmel.com>
 <20121102142444.GY4413@opensource.wolfsonmicro.com>
 <50974DE6.50506@atmel.com>
 <5098A280.7070301@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5098A280.7070301@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 06, 2012 at 01:39:12PM +0800, Bo Shen wrote:
> On 11/5/2012 13:25, Bo Shen wrote:

Note that there's less than 24 hours between these two mails...

> >Sorry for misunderstand. I split your e-mail into two parts. May be you
> >miss some parts of my e-mail. You can check the last mail from me. Or
> >check the following fully quote.

> Anyway, I will sent out a RFC patch series (which will be v3) which
> register dai and platform directly in Linux.

> > > This seems to be a purely virtual device which remaps the SSC onto the
> > > Linux audio subsystem?  If that is the case then it shouldn't appear in
> > > the device tree,

> >Yes. This is a purely virtual device. I add this as to the following
> >reason.

> >In our case, the ssc can connect to audio codec, DAC and other devices.
> >In order to avoid duplicate the code, so keep ssc as a library, register
> >it directly in Linux and use remap method to let it work onto other
> >different subsystem.

The whole point here is that this remapping shouldn't appear in the
device tree since it's a purely Linux internal issue, the code that uses
the SSC should have a reference to the SSC and then do whatever
remapping is required.

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmM/rAAoJELSic+t+oim9T0cP/Ayv4z7ZsHLLNRsafNdSE2WB
QjXifXeKJe8mgBlNbQnVy5rS4i5DxD6hfwJ50H+2/fYCyzolLTALslyyWxLwW2BO
uPkOLnPm7n9nRI3kG1MlhefaQPbop8n5mAFA4ReLl3rS2hUPA8pVSFnHIA0ySdFk
LH/m7lYVWB+rttj0u6SXNRui3gNj2seBaNy6qC6XqmSB8ESpqVlfnMoX0+dvpnhN
ye7CCEWFLWXiw65qo+GaKjhqVdhoKDVxbzI06tdK0YOSgK0IZINE4IIBPv2dZIHM
G1DewoHrPvCXvh/CicUf9pDYz4u2TjBPv2SgW4IaIN2Bkx+2WxPpU9/NN6PE2BQu
t74xbrAZxcdZPjPS6j+TYeyq+KXaMr2HEXCg78QkS5KhcxDMHYpIT6Da9MMvxV2S
ki4UUheIuA5D6j9OQjycpSSBdkLh1y4+fQkWc/Uo1+8Qh2eVp1kGyF8q5FaZE/DT
HJTDuac3qxJYphrojbgS6SjDTPPgVisBIs41QDrVZ2ts1Is0V3tvJn0f4+m4LPHz
l5eBmxM9Xi4v/VIU52lgy/zybtrHd9jwAt0jspyrLw1Z2Q0e3fw+9Yqb1PX8w1Lm
h0Au4BQ9QIMO8CBrqum06AsCHYpt0dma0IH4aPYGkzR+5ChTFtD4MLl1p+sHvtfJ
y44NJC9ZTE9VF3gI10Tm
=QC9W
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--
