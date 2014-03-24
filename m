From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 08/13] ASoC: Track which components have
 been registered with snd_soc_register_component()
Date: Mon, 24 Mar 2014 12:26:18 +0000
Message-ID: <20140324122618.GK2269@sirena.org.uk>
References: <1395129736-11938-1-git-send-email-lars@metafoo.de>
 <1395129736-11938-9-git-send-email-lars@metafoo.de>
 <20140324111805.GI1665@opensource.wolfsonmicro.com>
 <533019C1.6090402@metafoo.de> <20140324114837.GJ2269@sirena.org.uk>
 <53301FEC.6090507@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6929842875770249228=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 608D12616B4
 for <alsa-devel@alsa-project.org>; Mon, 24 Mar 2014 13:26:42 +0100 (CET)
In-Reply-To: <53301FEC.6090507@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============6929842875770249228==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 24, 2014 at 01:07:08PM +0100, Lars-Peter Clausen wrote:
> On 03/24/2014 12:48 PM, Mark Brown wrote:

> >The question there is why you'd ever want to only unregister a single
> >thing that the device registered.  devm_ does make this a bit more
> >academic but still.

> I you probably wouldn't, but I think it makes the interface cleaner and devm
> doesn't really care whether we store a pointer to the parent device or a
> pointer to the component in the devm data.

Yes, of course the other bit is not wanting to register multiple
components in the first place (partly for this reason).

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTMCRmAAoJELSic+t+oim917UP/RoQuW5l4cVi19xcLQ9qf2I0
R6WjG/Fcf3GL843P70PidiabidHY+lr6DM9W4TWBWGCArihwmrVHcoQeE4F7eBvf
8g90oHWmk5+kJNTNRDKJIaB8mPhI1szsbWlKU9MfdB00UkXvqOuGK2zUziYejm3d
jwmBA6c51JFM0h0runoIJ+3UBpGvTMgE0Vf6aluq9wt4wDoJAmclJaRxRsYCkUa8
6agaORSOE4pAvMK98KjDvwYl3F3yZVkyRt5+YUpvgBQjbHjV7FOIW6fxc30axkf0
P+bT9vRbAJOy5iRz79Q9I/Coeyens10Aod5SPd+mjBhQJKkb1sOZWSY+wCfw+Q0J
g+zGfHyX3GTXjZ6YJdev0sFhWxv6bfMxUngT3QeGLp56zdry78jA0diqrMzS8rR9
kq4qdiUjik822g8P83hNcF7U4VO5PiOQLvnFQM5GtVHiuSjUau0MysB2q/qAnW4w
mY9PkQ5gZJ1nhFLP6DiOO4T1xhZbf52grnhTZgttCpNCTHIxI+7kytB3pU73iNv5
yG7I3NvMLZINPiO+avzYYWIfiel/3uiDR3JO43T4NdDHfaW0th514+4VgiTeVH+Y
ZGKV0Y3udZgtgrdoSqlK5Qt4gH3BMFdyhlZrRgX9mmNl5ZrLfffNRORcqOMmo6yu
z7gKZ+beW4l25dkjZ3ft
=tUmG
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--

--===============6929842875770249228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6929842875770249228==--
