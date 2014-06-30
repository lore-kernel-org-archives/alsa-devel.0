From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] question regarding codec DAI ops
Date: Mon, 30 Jun 2014 11:31:27 +0100
Message-ID: <20140630103127.GX23300@sirena.org.uk>
References: <53A44007.1000008@st.com> <20140621102644.GQ5099@sirena.org.uk>
 <53A7D78B.1050508@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5498259415935764705=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D67F32608E8
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:31:57 +0200 (CEST)
In-Reply-To: <53A7D78B.1050508@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5498259415935764705==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sl61CI1LVv3DiL8h"
Content-Disposition: inline


--Sl61CI1LVv3DiL8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2014 at 09:30:19AM +0200, Arnaud Pouliquen wrote:
> On 06/21/2014 12:26 PM, Mark Brown wrote:
> >On Fri, Jun 20, 2014 at 04:07:03PM +0200, Arnaud Pouliquen wrote:

> >>I have a platform with several audio IOs (DAC , HDMI...) and I2S In/out
> >>connectors.
> >>I'm using my codec driver but for this I2S output i used dummy codec dr=
iver
> >>with the snd-soc-dummy-dai dai.

> >Why are you using the dummy driver?  This is intended to stub things out
> >in some DPCM situations rather than as something that should be used in
> >normal code.

> My platform is a base for several projects and customers. In this context
> some extra I2S bus are available for extensions.
> I have  two use cases to support.
> - Possibility to test I2S bus without audio codec associated.
> - Support client that does not use ASOC for audio codec ( a.e one manage
> HDMI in his display driver...)

> To be able to support these use cases i use device tree to construct the
> alsa card.  if no asoc codec present, i connect dummy one.

No, this is is not at all sensible - don't do that.  Think about it for
a minute - if this were something we wanted to do it's going to apply
just as much to any other I2S controller so we should be doing it in the
core.  If the user really wants to look at the signals with a scope they
are probably capable of providing a suitable driver for their purposes.

> If customer want to use another codec they have just  to change device tr=
ee.
> Here is an example of my device tree declaration.

>     sound {
>         compatible =3D "st,snd-soc-sti";
>         st,card-name =3D "audio";
>         st,audio-routing =3D
>             /* Analog out route */
>             "Analog out","DAC",
>             "DAC","dac_p";
>=20
>         st,asoc-platform =3D <&sti_asoc_platform>;
>         backend-name  =3D "HDMI_out", "PCM_out",
>                     "Analog_out", "spdif",
>                     "HDMI_in", "PCM_in";
>         backend-cpu-dai =3D <&snd_uni_player0 &snd_uni_player1
>                     &snd_uni_player2 &snd_uni_player3
>                     &snd_uni_reader0 &snd_uni_reader1 >;
>         backend-codec =3D <&sti_sasg_codec 0
>                     &sti_sasg_codec &sti_sasg_codec
>                     0 0>;
>         backend-codec-dai =3D "sas-dai-hdmi-out", "snd-soc-dummy-dai",
>                     "sas-dai-dac", "sas-dai-spdif-out",
>                     "snd-soc-dummy-dai","snd-soc-dummy-dai";
>     };

This looks a lot like you're trying to reinvent simple-card.

--Sl61CI1LVv3DiL8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsTx7AAoJELSic+t+oim9FwkP/Rj5dTLeB05wnO5KXWxds/cU
/BTGAoQdH09ShjqbTWVu8gG5eiu/8DU5bf2suJrtT8Ux57kviWb2eny854gEfpxI
YABZmmPcPmfrZTQAlsaOpVJEOxoeJ0vYoygZqlBaMi0XjGN11ob1IIbZeXfAtQFV
nroMAllR60/lC6n++8GilY+8skemt5emqk8rjGEkkmCYlsKljjyGjkbQorB/UHSc
U6ds4zgxgEjUIqQzf1sXeCXnSVuMHSoV3owFhAIVow/EH5tADM566iRqoRIiMZ+f
PLIfmJFaphFiSbN+2kgc329hX+mMKNpRyIzk0UjDcCUnERVsuTuI1NBNDDwNtvvw
BQPsFgbrH6D0oQiGkTbl7gqibtuQ4hfxBBAjI2ddKf2nOzMB96WOlrGz7dtQ9Hxx
PRczjzI2E+PSikc0dkF9tMlhY9ew//4r4Dbc2xg3BKKmnvkI2YK6iOkgILoi6+2n
5FgofMoTPy7BDutOV3tIJElIEUh0J3I8F15ZjDvFMj4sU9GYRzmoFbqboI2ZD2LM
03CJHQ3vKbOa5yJZSbF5CtfxwXnnGmmwm9qV6nPCXwSnEexwmtfTK7TFCfAlu6FE
bpQu6IgadSszhR66EzHFFSohA5uagh6ghfERNmGO2jG8L6bDYp0kZH3I+y0Nmkwy
3mj7s3ZTOOXt2jVO46Sm
=wEQF
-----END PGP SIGNATURE-----

--Sl61CI1LVv3DiL8h--

--===============5498259415935764705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5498259415935764705==--
