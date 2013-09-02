From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/14] SPDIF support
Date: Mon, 2 Sep 2013 21:44:21 +0100
Message-ID: <20130902204421.GW3084@sirena.org.uk>
References: <20130901123433.GR6617@n2100.arm.linux.org.uk>
 <20130902140632.GQ3084@sirena.org.uk>
 <20130902141631.GV6617@n2100.arm.linux.org.uk>
 <20130902162729.GT3084@sirena.org.uk>
 <20130902165932.GZ6617@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4452051087030773547=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 124CE26522E
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2013 22:44:31 +0200 (CEST)
In-Reply-To: <20130902165932.GZ6617@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Jason Cooper <jason@lakedaemon.net>, Jean-Francois Moine <moinejf@free.fr>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4452051087030773547==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JMKEfAmnQy+WzDHS"
Content-Disposition: inline


--JMKEfAmnQy+WzDHS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 02, 2013 at 05:59:33PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 02, 2013 at 05:27:29PM +0100, Mark Brown wrote:

> > That seems like overstating the difficulties.  The updates for any new
> > S/PDIF drivers will be pretty much the same as those for the existing
> > I2S drivers and should just be mechanical changes, nothing too taxing.

> Sorry, you need to explain more.

> Here's the dual-DAI version:

>                 .name =3D "S/PDIF1",
>                 .stream_name =3D "IEC958 Playback",
>                 .platform_name =3D "mvebu-audio.1",
>                 .cpu_dai_name =3D "kirkwood-spdif.1",
>                 .codec_dai_name =3D "dit-hifi",
>                 .codec_name =3D "spdif-dit",

> Here's the DPCM version:
>=20
>         {
>                 .name =3D "S/PDIF1",
>                 .stream_name =3D "Audio Playback",
>                 .platform_name =3D "mvebu-audio.1",
>                 .cpu_dai_name =3D "mvebu-audio.1",
>                 .codec_name =3D "snd-soc-dummy",
>                 .codec_dai_name =3D "snd-soc-dummy-dai",
>                 .dynamic =3D 1,
>         }, {
>                 .name =3D "Codec",
>                 .stream_name =3D "IEC958 Playback",
>                 .cpu_dai_name =3D "snd-soc-dummy-dai",
>                 .platform_name =3D "snd-soc-dummy",
>                 .no_pcm =3D 1,
>                 .codec_dai_name =3D "dit-hifi",
>                 .codec_name =3D "spdif-dit",
>         },

> The above are two completely different beasts.  Please explain how the DT
> representation for those DAI links can be the same.

If the binding is representing the differences between those two in the
DT then the DT binding is clearly not good since it is exposing Linux
implementation details - all the binding needs to say is that there's
something connected to the S/PDIF output of the audio controller.

> > > 2. When the driver is converted to DPCM, it must use DPCM for
> > >    everything, otherwise it has no way to know which of SPDIF or I2S =
to
> > >    enable.  The only way I know to work around that is to add additio=
nal
> > >    routes to link up the AIF widgets, and that's the solution you're =
all
> > >    telling me is not acceptable, as per the patch set at the start of
> > >    this thread.
> >=20
> > What we have been telling you is that if there is a DAI link present
> > (there should be one for each physical DAI link) then this should be
> > enough information for the framework to know that the two DAIs are
> > linked and if any routes are needed in DAPM these should be added
> > automatically in the same way that we add links for CODEC<->CODEC links
> > at present.

> > It's been said to you off-list that having the links manually added
> > but marking them for removal when the framework figures out how to do
> > that should be OK.

> Sorry, I just don't get this.  What you seem to be telling me here is to
> forget DPCM, and just go with the dual DAI solution.

No, it's not clear to me why you would think that.  If we are talking
about adding DAPM routes matching DAI links then we are talking about
DPCM.  To reiterate the dual DAI implementation would merely be a
 stepping stone to a DPCM based implementation.

> If I have separate CPU DAI links, then I can't do simultaneous operation,
> because both DAI links are entirely separate entities which are activated
> entirely separately.  The only way I know how to handle this is with the
> patch set I've already posted.

As you are aware DPCM supports multiple DAIs and a good DPCM
implementation for this hardware will have one front end DAI for the DMA
and two back end DAIs, one for the S/PDIF interface and one for the I2S
interface.

> We've been through this before: this is also not how Liam's example DPCM
> driver works - please go back and look at those diagrams I drew you of
> how Liam's driver is setup.  I've also said to you that from what I can
> see, the routes are still required for DPCM - those routes are in Liam's
> DPCM driver as well.

This is why in the above message I reminded you of the suggestion that
until the framework does automatically figure out that those routes
should be there the routes are manually added in the driver clearly
marked so they can easily be removed when the framework does the right
thing here.

--JMKEfAmnQy+WzDHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIbBAEBAgAGBQJSJPiiAAoJELSic+t+oim9A8kP+OallE2pVh0lg2bJpgQhXMxv
9lNobve6Lq928ZZxK21qDW6abeF4OFR4MYnZEtIzV+6zq+iMrNhBb7F0O/kdHA6u
M39Y/et2HUW0AYPhbkKLGCB3bgRWYvIBE0lOURu4+Ug2ZP4DWhI36dRNbgDtc/0X
Aq+gytgoEpSQJ+xmu7s8H+kf3CqN9LALeUD7m4oRwxOYsFRz4P0pP88hBTi26ICI
ndtfGyCQVCRB4CrC0l8yYm0zNwlfu7g50Tm7kl+obkss0kVgtuRK/K5BzavtwIHE
87q8aG/iCk9tQI3NNzGYrEVMzMcem5v1vwAsFnG9XuKvwB6OnejdeBH2z+ODvlur
XDa0V+yOF2yO+KWDyF57PfUruyQxyt7oY1DY4LkIvWHQX79hpyv7EuQOqw/by5H7
ejhTZoeWxzvB23+Q1Khbi2J+6QOQiL0i0dpb1kiSYS1Anq9fjepjema78utfXga8
q0mVSG1kflLEq87UPFiQ8kiOWC6gd/J8dJ8lxUV4gOzi4lQPKaDISGPPeL5FrdLj
lDd+H0Q4sdPMbW1UtL7xQksdhfM1q4sw+C79tIK43vUto6X9vIPcmGtpUVQAEqqx
6MNjBZJpmxwo2LpcP8jpEPrPqZfFDSYEitgNl9ylLeEGozT1rjjNxXr9KUjgl9yp
R721dxxvBtPORiR2+Qc=
=kt2Y
-----END PGP SIGNATURE-----

--JMKEfAmnQy+WzDHS--

--===============4452051087030773547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4452051087030773547==--
