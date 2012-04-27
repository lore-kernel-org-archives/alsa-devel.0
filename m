From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Required/preferred multichannel order for ALSA
Date: Fri, 27 Apr 2012 10:57:34 +0100
Message-ID: <20120427095734.GC18260@opensource.wolfsonmicro.com>
References: <4F99BF45.4020909@ti.com>
 <1335518497.4150.6.camel@odin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6069830195704363300=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 02D4110449F
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 11:57:39 +0200 (CEST)
In-Reply-To: <1335518497.4150.6.camel@odin>
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
Cc: "Castaneda Gonzalez, Axel" <x0055901@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Ricardo Neri <ricardo.neri@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "Guiriec,
	Sebastien" <s-guiriec@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6069830195704363300==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 27, 2012 at 10:21:37AM +0100, Liam Girdwood wrote:

> A lot of hardware now can remap channels to suit the use case so it
> would probably be good to have an ALSA API to get/set the mappings.

As well as being able to reorder things there's also the cases where a
multi-channel link can be assigned to send several independant streams
rather than actually be a multi-channel link.

> This seems like it would be a good subject for the BoF.

Yes.

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPmm1mAAoJEBus8iNuMP3dbBQP/2FMZbiR8UaSe3DggCq7+9cR
9YIRuLvbfDYyXutomnND4vySEzQNXbp91RJEhUtYWjCAqqdB5rVL4tIxXxGU+nQo
sue8Yv3igB0F962p2fTSxtF//X1WXUytDMbL6Xb2Ma0ET/V79sIZ4FET+VMPkIyQ
ridJbMQVPmqzCUl6SckfX5jJWiIMuzttpYhZML1Em+UZWTRQYTiusfRh524gorg3
BB8W/5U/kNrgoD9wnPvCRFssF2BBj+9oOJk0/g/WOG9mmaiATnozdvA+yMrT0BU0
t+IcXgAnbWN4gppFZontCE4ft9vjG2t8ev1AFhBGqA0xirk4vhV8LX8whG1J0bFK
rF37ZiFd0X0bQe1qzH705h28VBZblSBlDdAoA59pbzs13pN1YgG/V7CoZWR603mJ
Bq/N65/21K1Sguxb0f8WVNYo9ka5Tau9aOUOroNzEzQggMHSDBw8ZvB2P6j41fLB
E5G8lxZxXycPpzyl+tUpapI6HGpFwDatH1Z8xYevSaIG+x6CqTC77nWDNz73j0AZ
/bF5vQKveKjRZb3GBMw8hzp7hzhFTPGAKGI69fy/HgK2YWx09vL8TvFW6AcKjPiG
9zBhFXWA0Xpf+TW5mRXWPVax/l2Uj0N4Rza0ZzELG5BT8EaumhRNJRTX6Usio3D1
+qxi8RcR18iC9U/k6Ka6
=16pe
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--

--===============6069830195704363300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6069830195704363300==--
