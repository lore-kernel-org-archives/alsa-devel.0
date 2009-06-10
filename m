From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: Automatically set TDM if needed on
	pxa-ssp and allow frame width override when using TDM.
Date: Wed, 10 Jun 2009 11:39:54 -0300
Message-ID: <1244644794.27053.210.camel@brutus>
References: <1244567590.7406.100.camel@brutus>
	<20090610121844.GC14632@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0096448048=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090610121844.GC14632@sirena.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Paul Shen <boshen9@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org


--===============0096448048==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-d3t20hypHByTL6smMWZM"


--=-d3t20hypHByTL6smMWZM
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em Qua, 2009-06-10 =C3=A0s 13:18 +0100, Mark Brown escreveu:
> Please split out the API change from the use of it in the PXA SSP driver
> - just include enough to keep it building, then send a second patch
> changing the internals of the SSP driver.  At the minute there's two
> different changes in here.

Ok.

> This is wrong, the WM9081 is a DAC only part so it should be paying
> attention to the RX mask, not the TX one.  We also need to handle the
> sample size here.

Ok, but I dont know how to handle slot_width for wm9081. Is a FIXME
comment here enough for a first version? Its hard for me to get this
working correctly on wm9081 as I dont have such hardware and PCAP2 only
supports 16bits slots.

> I've not checked the SSP code yet.

--=20
Daniel Ribeiro

--=-d3t20hypHByTL6smMWZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Esta =?ISO-8859-1?Q?=E9?= uma parte de mensagem
	assinada digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkovxboACgkQw3OYl0G0liRmggCffXZmLhOXz+hYCjHdIe1CbxU/
tzcAn1QzLZBu5SwYTpP4Hfd63UivXkPP
=QluB
-----END PGP SIGNATURE-----

--=-d3t20hypHByTL6smMWZM--



--===============0096448048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--===============0096448048==--
