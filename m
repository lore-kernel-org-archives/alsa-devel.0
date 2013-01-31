From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic3x: Convert mic bias to
 a supply widget
Date: Thu, 31 Jan 2013 10:32:25 +0800
Message-ID: <20130131023221.GA6027@opensource.wolfsonmicro.com>
References: <1359552155-17426-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4397238554561808038=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC249265115
 for <alsa-devel@alsa-project.org>; Thu, 31 Jan 2013 03:32:32 +0100 (CET)
In-Reply-To: <1359552155-17426-1-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hebbar Gururaja <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, lgirdwood@gmail.com, alsa-user@lists.sourceforge.net, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4397238554561808038==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 30, 2013 at 06:52:35PM +0530, Hebbar Gururaja wrote:

> Convert MicBias widgets to supply widget.

> On tlv320aic3x, Mic bias power on/off shares the same register bits
> with output mic bias voltage.  So, when power on mic bias, we need
> reclaim it to voltage value.

This should update machine drivers that use the CODEC too.

> +- ai3x-micbias-vg - MicBias Voltage required.
> +	1 - MICBIAS output is powered to 2.0V,
> +	2 - MICBIAS output is powered to 2.5V,
> +	3 - MICBIAS output is connected to AVDD,
> +	If this node is not mentioned or if the value is incorrect, then MicBias
> +	is powered down.

Would 2.0V not be a more sensible default (it is the lowest voltage so
is unlikely to cause hardware damage if it's wrong)?

Otherwise this looks good.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRCdefAAoJELSic+t+oim9tTcQAIaTFkHf6i1Sl4bl8wTp0yzW
GhkpZstZv5ZfWcHSClQlfw1AKbTQHiceBtE8Nyi/aBZuVxwg1Jvs9mG1szoG7xs2
qJrfjFmir3+5rDawjbmm1+DuZeDm0rL9evoHuQ+pNjc/YC3GUnMdvDAcAA5Z7q1F
FgmPzBfycxuPaWyDP9s2PssEYwDha2tn1hZROQcccpIfE39dGq93NdX6mY+ZV07S
Ov5t8wMjXjjkqPxFbFzIY9+mTSeQpFGuCbSXRjZL3vBKPKEaCUFIluq8imFPxVzY
EL2XlLFyglcghvviX0s4TOWeeG5eDgJCoerWfJ3obfecaX+WLiM+ENYPbTz7i32m
5WPyyzoCNumBQxl7NF1rv8jJLRtzPPERGZ+DXL48I8+9iXrAL0r4VWv3Stj+Qj9R
U3LBHhPYKGr92Nic7jOyQ2sTI44ugb8L/gFqjzx02d2YHTHLSBlcHkZ3I4gujbZ+
gx4niax6jB6OMNdEx6sGpza/og8OOoEQ1Jv6dMxeJZa5nwlbopfYw7AWavllxD+5
vD/3NQiaVhBgtC5ixz9ayz+VZDg66YlQp0Q+Yy2DPfb2NDECbUAozXI+StrmEpb9
S/Q85jLhxw5Yr1Afi3uX82xStE8+n4QLt89rJ6Bv5L89SI4WFIs+YD8WaBLWPnwO
OQlS6rCjIYIw6aRJTkvG
=SP/7
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

--===============4397238554561808038==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4397238554561808038==--
