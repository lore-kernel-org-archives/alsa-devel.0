From: Eduardo Pereira Habkost <ehabkost@raisama.net>
Subject: Re: Question on hda mixer structures
Date: Wed, 7 Mar 2007 20:50:50 -0300
Message-ID: <20070307235049.GA4622@silverbrick.ctb.virtua.com.br>
References: <5FD5754DDBA0B1499B5A0B4BB5419485B0CC81@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0096352714=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <5FD5754DDBA0B1499B5A0B4BB5419485B0CC81@fmsmsx411.amr.corp.intel.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Allyn, Mark A" <mark.a.allyn@intel.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============0096352714==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 07, 2007 at 08:34:48AM -0800, Allyn, Mark A wrote:
> Folks:
> =20
> I am trying to figure out how the mixer control structurs are done for
> each of the
> codecs in the patch_sigmatel file for the Sigmatel codecs.
>=20
> A sample of one is as follows:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> static struct snd_kcontrol_new stac925x_mixer[] =3D {
>         HDA_CODEC_VOLUME("Master Playback Volume", 0xe, 0, HDA_OUTPUT),
>         HDA_CODEC_MUTE("Master Playback Switch", 0xe, 0, HDA_OUTPUT),
>         {
>                 .iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>                 .name =3D "Input Source",
>                 .count =3D 1,
>                 .info =3D stac92xx_mux_enum_info,
>                 .get =3D stac92xx_mux_enum_get,
>                 .put =3D stac92xx_mux_enum_put,
>         },
>         HDA_CODEC_VOLUME("Capture Volume", 0x09, 0, HDA_OUTPUT),
>         HDA_CODEC_MUTE("Capture Switch", 0x09, 0, HDA_OUTPUT),
>         HDA_CODEC_VOLUME("Capture Mux Volume", 0x0f, 0, HDA_OUTPUT),
>         { } /* end */
> };
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I am having a hard time seeing the connection between the widgets that
> have a volume
> control and the entries in the stac mixer structure above. Where are the
> NID's for each
> entry of this structure?=20

The NIDs are the second parameter to HDA_CODEC_VOLUME and
HDA_CODEC_MUTE. In the example above, they are 0x0e, 0x09, 0x0f.

>=20
> Also, the value HAD_OUTPUT is used apparently for both a capture node as
> well as an
> output node. Where would HDA_INPUT be used?

HDA_OUTPUT means that the output amplifier of the widget will be
controlled by the mixer control. Some widgets may have only input
amplifiers, others only output amplifiers, some may have both. Having
amplifiers on its input and/or output doesn't mean it is used for audio
capture or playback. It just means that it has amplifier(s) connected
at its input or output.

In short, the macro parameters are all the information necessary to
"address" an amplifier:

- Widget NID
- Amplifier index, for widgets that have multiple input amplifiers, such
  as Sum Widget
- HDA_OUTPUT or HDA_INPUT, telling if it is at the input or output of
  the widget


>=20
> Is there any documentation on just how this structure is composed for a
> new device?

I don't know if there is any documentation on those strucutures. But
basically you need to know which amplifiers you want to control, by
looking at the widget connections in the codec. Looking at
/proc/asound/card*/codec#* should be enough.

I use a small script to generate a graphviz output from the codec
information on /proc, to make this task easier. Maybe it helps. It is
in a GIT repository at:

http://raisama.net/gitweb?p=3Dhda-tools.git;a=3Dsummary
git clone http://git.raisama.net/hda-tools.git

--=20
Eduardo

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFF70/ZcaRJ66w1lWgRAlj2AJoCeE3ms6iBO2+IOjy0qXGROlmojgCdFGJk
0LGFf12lod2FSU72AnIQ0DI=
=zSrE
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


--===============0096352714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0096352714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0096352714==--
