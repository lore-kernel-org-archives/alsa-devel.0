From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/4] ASoC: core: Adds support for cpu
 loopback dai_link
Date: Wed, 2 Dec 2015 10:53:30 +0530
Message-ID: <20151202052330.GE1854@localhost>
References: <1447091401-24298-1-git-send-email-vinod.koul@intel.com>
 <1447091401-24298-3-git-send-email-vinod.koul@intel.com>
 <20151118131757.GI31303@sirena.org.uk>
 <20151118134843.GU25173@localhost>
 <20151130162548.GZ1929@sirena.org.uk>
 <20151201025654.GJ3901@localhost>
 <20151201122747.GG1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0614653361229113839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7675C264F03
 for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2015 06:20:32 +0100 (CET)
In-Reply-To: <20151201122747.GG1929@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0614653361229113839==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 01, 2015 at 12:27:47PM +0000, Mark Brown wrote:
> On Tue, Dec 01, 2015 at 08:26:54AM +0530, Vinod Koul wrote:
> > On Mon, Nov 30, 2015 at 04:25:48PM +0000, Mark Brown wrote:
>=20
> > > Can we make the temporary hack be to check if there's a CODEC defined
> > > in the DAI?  It's nasty and fragile but it keeps the hack much better
> > > isolated.
>=20
> > The flag added here, cpu_loopback would do that and keep this isolated =
=66rom
> > the rest. The problem with checking if codec is defined will be for dsp
>=20
> No, it means that the drivers need to set the flag to work around the
> core which is what I want to avoid.

ok fine then

>=20
> > based loops which terminate in codec. It will not work as we will find =
codec
> > in the dailink for the voice call (modem-dsp-codec) loop
>=20
> I'm confused about the situation you're describing here.  The
> connections are DAI to DAI so why would any CODEC behind the CPU DAI
> have an impact?

let me try again,

So I would like to for example do a voice call. So I need to DAIlinks for
this. First one is modem-SSP-A and second SSP-B to codec.

I am taking example of SSP-B to codec for configuration

Currently the code envisions that loop is connected as modem-codec, so DAI
links are linked per this assumption

     Modem Tx (Pb)  ----------> Rx Codec (Cap)
     Modem Rx (Cap) <---------- Tx Codec (Pb)

So we link pb-cap and cap-pb connected

But if we do wrt from CPU the situation is different

     CPU Tx (Pb)  -----------> Codec Tx (Pb)
     CPU Rx (Cap) <----------- Codec Rx (Cap)

Since this follows normal playback kind of scenario, we need to link pb-pb
and cap-cap

Now we cannot change this unilaterally so added a flag to signify we want
second mapping for dailink rather then first one

Am okay to change this to something different way, which results in second
mapping from CPU based loops, pls do suggest :)

Thanks
--=20
~Vinod

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXoBSAAoJEHwUBw8lI4NHNbQP/1oTRaqKXTZiLr8LlXWR+ZuB
xlLaxqjUEtFYR1NogGJKEQ8oL+ywiGyn5cQe1fQvqd79Ac2oSUAqiBAiyY+De7y8
dnGWM3Ind668zsnkdCDBWUcz1bttMyNz6VrvPvx/DZAMMBRFZG3lpn59lmdS8rXw
fCibFGeSG7ETk+tUxvh3hHippmkvjPJWzc9LFeWZHp3qb0ItSJfIjpug+WS2ArPB
vMewpfF6vfPsx9dc0/cVT8OIUzi8q2cKlIF1yieZqO4Mi0wa6xuhzytcR9J2cjSk
Q1MHgxTjfos7Whg0honNk6dFaGBpnZhDFrrjyKApWO6UToWmz7PaWNYyEKldXIYR
fgBQCBcuX3HGdllsTqEW2WSkm2suhCPnot0+n/QayP9dgdYh2DXL9hatVKg3ETDt
WxrN2mjisz72sV7BelzUDpTBgvgJ1urctZSlIxJqlSIIrRhaFa88gC+JqT3V4BQ2
dBJG4I8uezzQmMS7qmHLlTfPziSBv2uyJOVPb3246VhgnMKl3bijNP9TdB1Dnw2N
Ww2+19vitA++3aJ86yjN/H7b/etV6kl627xtUnFApWODglNUcvF6+I83S3dQghj3
i/D5Ih9OwJEfQmooAwP6b96F87Ewh6QTibCJ9HDwR2jftYJE/wgheJy4hZHgV8R3
ehiUAydRZWQlKcXnZ7kG
=sfOf
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--

--===============0614653361229113839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0614653361229113839==--
