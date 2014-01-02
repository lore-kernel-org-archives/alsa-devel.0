From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [alsa-devel] [PATCH] ASoC: generic: add generic compound card
 with DT support
Date: Thu, 2 Jan 2014 13:44:37 +0100
Message-ID: <20140102134437.1e39da55@armhf>
References: <20131231113138.102044cf@armhf>
	<52C466E1.3030302@metafoo.de>
	<20140101210814.31e3f3a9@armhf>
	<52C4766B.8080000@metafoo.de>
	<20140102102647.6efec89d@armhf>
	<20140102111056.GT31886@sirena.org.uk>
	<20140102124331.2bcfc172@armhf>
	<20140102115618.GW31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140102115618.GW31886@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Jan 2014 11:56:18 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Jan 02, 2014 at 12:43:31PM +0100, Jean-Francois Moine wrote:
> > Mark Brown <broonie@kernel.org> wrote:
>=20
> > > I think we want an explicit object in the card representing the D=
AIs.
> > > This will both be useful for making it easy to find the configura=
tion
> > > for the link and will be more extensible for the cases where mult=
iple
> > > devices are connected, you can't just assume there's just two.
>=20
> > I don't see the problem: the 'port' is the DAI. The associated
> > endpoints give the DAI links and the routing information.
>=20
> > As the DT definition has been done for video, some properties may b=
e
> > added at will for audio.
>=20
> > What kind of object were you thinking of?
>=20
> Like I say multiple devices on the same link - if you're just listing=
 a
> single remote device there can't be more than one.

I still don't understand. There is already such cases in the Cubox:
the S/PDIF output from the kirkwood audio controller is connected to
both the HDMI transmitter and the S/PDIF TOSLINK. So, in the audio
controller, the port @1 defines the S/PDIF DAI and the endpoints @0 and
@1 point to the remote DAIs, creating 2 snd DAI links:

	port@1 {
		audio_hdmi_spdif: endpoint@0 {
			remote-endpoint =3D <&hdmi_spdif_audio>;
		};
		audio_spdif: endpoint@1 {
			remote-endpoint =3D <&spdif_audio>;
		};
	};

in the snd card:

	- DAI link 1 =3D 'audio controller spdif out' <=3D> 'hdmi spdif'
	- DAI link 2 =3D 'audio controller spdif out' <=3D> 'spdif'

If I am wrong, may you give us an example for which such a DT would not
work?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
