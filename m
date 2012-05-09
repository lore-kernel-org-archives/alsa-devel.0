From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Wed, 9 May 2012 14:35:12 +0100
Message-ID: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
References: <4FAA5C93.6020703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4195797343120512423=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 95BBB245AE
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 15:35:13 +0200 (CEST)
In-Reply-To: <4FAA5C93.6020703@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, "Cousson,
	Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============4195797343120512423==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0pkK7MCEo5hACTvx"
Content-Disposition: inline


--0pkK7MCEo5hACTvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 03:01:23PM +0300, Peter Ujfalusi wrote:
> On 05/08/2012 04:41 PM, Mark Brown wrote:
> > On Tue, May 08, 2012 at 03:42:41PM +0300, Peter Ujfalusi wrote:

> >> Also without a DT entry I will not have a way to use phandle to
> >> connect the codec in the machine driver.

> > Of course you do!  There's going to be a device tree entry for the
> > chip, things can point at this perfectly happily.

> That's true but what can I do with that in the ASoC machine driver?
> The chip driver is _not_ the codec driver.

This really doesn't seem like it should be at all hard to resolve...

> I can craft the pdata for the MFD child devices out from the DT
> information but then the child devices will have no dev.of_node since
> they were not probed via OF.  So I would have not phandle for the
> codec to be used to define the dai-link connection within the sound
> dts section.

> Am I missing something here?

Clearly.  This is all very circular.  Obviously if you're intent on
using a phandle specific to the MFD child then you need to have that in
the device tree but this is because you're making the child devices
externally visible...  Clearly if we're not going to use the MFD
subdevices in the DT then the links ought to reference the chip.

--0pkK7MCEo5hACTvx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqnKGAAoJEBus8iNuMP3dKpAP/iTVUgYEWWMdEu5gv8TG+cE6
l2lh7BnncjpnzzDAlCcWydaJ+wCM20XqTPPbJxv95eaXAA/o4SJDRc4HJqsJlyTE
VE/pjq/JJJ2JgE9g6sRMQNdyrgNX1FhGpE857/vB7Rx1Unu4vLPLkpwFSJ4wuPq+
Q0fZm5jQ/8ALyrf41pi5sOFl+EPWvCSP4XXKcV8tDr2HDjBT6sEsE0dg2Q+f4Mao
5FI3Yh9aq2xBkUBH68CItvv74mRtvdjX6TB002X5Lh46epNYLglcZ1Azip+OhW2t
hKfRv97s6resnyHQu1UW0cI2Uy1k3J3p/D8tGZvloi2YuhXdoLehiUQVqT/vsRMG
t5jIWNaycYpZlZmeNikdMTUYGc85vNNNVgdcLJBfDMfYp9nah7c392LSp+6ABHOh
QsvlR83lIgbSqffNcLDoaLezNKbfBZS5ja/5i0g4/m5E98rOWeNR6IvfJvvpfh60
yi1FvkLuMYtQrmoi9YywbwzR8ZPAOaQ7Y4hHMvmoUX3EgskYs8ZHGHrQzGrM0Pnv
66kXWHMd1v4edPj4gYbQ+4nLic4PcRh11imLkqT/3u9P2Z3cm4qlLtBKxjcgnATV
TG1zu+pV/chkZ6DmA0ENtC+7bCsmC6nmkJJhdw1Nb71cJpoKaeoRwDlZkOKvxesO
UdfE8K0+sAc9pmOjgA6q
=HPOw
-----END PGP SIGNATURE-----

--0pkK7MCEo5hACTvx--

--===============4195797343120512423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4195797343120512423==--
