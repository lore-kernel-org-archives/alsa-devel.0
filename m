From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: FW: [PATCH v3] ASoC: Add support for TI LM49453
 Audio codec
Date: Wed, 8 Feb 2012 13:54:41 +0000
Message-ID: <20120208135440.GC5943@opensource.wolfsonmicro.com>
References: <290463D19D2E064191F1F96ECA480A89434AC4A96E@EXMAIL02.scwf.nsc.com>
	<4F323BF5.4010309@ti.com> <1328692723.3955.4.camel@odin>
	<1328693854.21099.5.camel@vkoul-udesk3>
	<1328694877.3955.9.camel@odin>
	<1328697415.21099.8.camel@vkoul-udesk3>
	<1328698650.3955.13.camel@odin>
	<20120208112059.GB3120@opensource.wolfsonmicro.com>
	<1328707650.3955.17.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6744261798746824247=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B973D24426
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 14:54:43 +0100 (CET)
In-Reply-To: <1328707650.3955.17.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, M R Swami Reddy <MR.Swami.Reddy@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6744261798746824247==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 01:27:30PM +0000, Liam Girdwood wrote:
> On Wed, 2012-02-08 at 11:20 +0000, Mark Brown wrote:

> > I'd generally expect to see new machine drivers doing this stuff in
> > set_bias_level() and possibly also having additional startup code in
> > hw_params() depending on how flexible the clocking is.

> The scope of set_bias_level() is now starting to increase to more than
> just the card bias power. It may be worthwhile at some point to rename
> it to cover all possibilities.

I'm really not sure it's worth bothering going round and changing
everything, and obviously the main candidate name is power which I'd
worry is just going to confuse people even more into thinking they don't
need to bother with DAPM when really it'd be helpful to made DAPM
mandatory.

For many of the things where it's important to have clocks for longer
the clocks are being used as part of the biasing - the main reason we
need clocks more these days is for things like the charge pumps which
are not a million miles off what VMID was on older CODECs.

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMn0pAAoJEBus8iNuMP3demAP/3O+dU6IqKnDoTvimQjqBJP4
OawY/AZ9V/HhSIQpLHH/YcxUeIzpabsybeT7vD2ISReySVGxXw0xeJKy7ecbFG0y
E+dXR+jYR4rjB6gMieBqD8jnhBYXrecykip9eTP4Wz29ip18Q+MUX3k374E1QWic
7QiQgmyCn9/HqIbfEExDAhoCU9yLU3EAT28UYbeFqBC6Irj3+AcQkqS5Gs0xeYLQ
/3whYZ6XOViIExR5DkgKwDLoLSNwqxM9MrnZMZS6gOh6J38L3qNQVV9c73hhwex4
t2Pk+WilbDRJeWy+y7hGi8Yy6d5yRmhJncImwl5Y3x1c75XqOL/ERu1/q9DhUWWE
R9JNQ1gcCj+gxDhJcr27d46DBYAw1f3XFB52DZjtgCLW/RL66lyrOD8QZtZn4Q2t
fHRprYXidN7YGdJiD3Bai4EXrWe30F0GjWuxjh3lKbonBOi3HS/4A0mys2pKscBb
VHr48ogxlaAAOL5gJF3kivtEkjGmmwayF4A0h2S12gbVZxCV6UcB/+jl5QatUuB9
C380yXiX0K051Ddk4vRJe6R3JQdQAew8tM691Qr38/auzhxp9cYIzX2YnOrLzAOm
4NcN5d50RyiKtDIxzYRHL+HcnXpal7Gq53H7HZ/T/SKiQVqTUVcJDkC6qzPtB8ry
FF/vxktzYVnk1n7bQTAF
=mM9B
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--

--===============6744261798746824247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6744261798746824247==--
