From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v9 1/4] drm/i2c: tda998x: Add DT support
 for audio
Date: Sat, 10 Jan 2015 16:47:11 +0100
Message-ID: <20150110164711.637892fc@armhf>
References: <54AE99F5.1010404@ti.com>
 <20150108174257.557f7ea5@armhf>
 <54AFA9B0.6040405@ti.com>
 <20150109123036.4bc4bbf6@armhf>
 <20150109114529.GH12302@n2100.arm.linux.org.uk>
 <20150109135401.5b270d46@armhf>
 <20150109130725.GN12302@n2100.arm.linux.org.uk>
 <54AFDE8D.3000504@arm.com>
 <20150109145741.GP12302@n2100.arm.linux.org.uk>
 <20150109183857.53d701a4@armhf>
 <20150109200127.GD12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150109200127.GD12302-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 9 Jan 2015 20:01:27 +0000
Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:

> > I proposed:
> >=20
> > 	audio-ports =3D <0x04>, <0x03>;
> > 	audio-port-names =3D "spdif", "i2s";
> >=20
> > Do you better like:
> >=20
> > 	audio-spdif-port =3D <0x04>;
> > 	audio-i2s-port =3D <0x03>; =20
>=20
> Neither; we know that there are TDA998x devices which allow SPDIF to =
be
> input via two separate pins, but only one to be active at any one tim=
e.
> Given that the hardware is flexible in that regard, a binding which
> artificially restricts that flexibility would seem unwise.
>=20
> If we were to come across a setup which did route two SPDIF streams t=
o
> the TDA998x, and we had to make the decision at run time which to rou=
te
> to the HDMI sink, we'd have to rework the binding, and we'd have to
> support the new binding and the old binding in the driver.
>=20
> Can you please look at Documentation/devicetree/bindings/graph.txt ?
>=20
> I think we may be able to use something like this:
>=20
> tda998x: hdmi-encoder {
> 	compatible =3D "nxp,tda998x";
> 	reg =3D <0x70>;
> 	video-ports =3D <0x234501>;
>=20
> 	port {
> 		tda998x_video: endpoint {
> 			remote-endpoint =3D <&lcd0_rgb>;
> 		};
> 	};
>=20
> 	port {
> 		#address-cells =3D <1>;
> 		#size-cells =3D <0>;
>=20
> 		tda998x_spdif0: endpoint@02 {
> 			reg =3D <0x02>;
> 			remote-endpoint =3D <&spdif0>;
> 		};
>=20
> 		tda998x_spdif1: endpoint@04 {
> 			reg =3D <0x04>;
> 			remote-endpoint =3D <&spdif0>;
> 		};
>=20
> 		tda998x_i2s: endpoint@03 {
> 			reg =3D <0x03>;
> 			remote-endpoint =3D <&i2s>;
> 		};
> 	};
> };
>=20
> I'm adding Philipp Zabel for comment.  The issue I see with this is t=
hat
> we have two ports here which are not mutually exclusive, and it's not
> obvious how they are dealt with.

Very interesting idea!

That's a detail, but I don't fully agree your endpoint description:

- pin description
	AP1 is the first S/PDIF input - ok
	AP2 is the second S/PDIF input - ok
	then, the I2S input may go only to AP3 or AP4.

- source input nodes
	You declare the same external S/PDIF source on AP1 and AP2.
	I would have better seen a kirkwood-like audio device as one of
	the S/PDIF input, say the second one.

To complexify a bit, I also connect the spdif wire of the kirkwood-like
device to a S/PDIF optical output ;)

spdif_in -------------+
                      v
       + i2s -----> tda998x ---> HDMI
audio1 |              ^
       + spdif -------+--------> spdif_out


Here are the modified ports of
- the HDMI transmitter (I removed the #xxx_cells):

	port@0 { // AP 1
		tda998x_spdif0: endpoint@02 {
			reg =3D <0x02>;
			remote-endpoint =3D <&spdif_in_port>;
		};
	};
	port@1 { //AP 2
		tda998x_spdif1: endpoint@04 {
			reg =3D <0x04>;
			remote-endpoint =3D <&audio1_spdif0>;
		};
	};
	port@2 { //AP 3
		tda998x_i2s: endpoint@08 {
			reg =3D <0x09>;
			remote-endpoint =3D <&audio1_i2s>;
		};
	};

- the (internal) audio device (audio1):

	port@0 {
		audio1_spdif0: endpoint@0 {
			reg =3D 0;
			remote-endpoint =3D <&tda998x_spdif1>;
		};
		audio1_spdif1: endpoint@1 {
			reg =3D 0;
			remote-endpoint =3D <&spdif_out_port>;
		};
	};
	port@1 {
		audio1_i2s: endpoint@1 {
			reg =3D 1;
			remote-endpoint =3D <&tda998x_i2s>;
		};
	};

- and the S/PDIF external input (spdif_in):

	port {
		spdif_in_port: endpoint@0 {
			reg =3D 0;
			remote-endpoint =3D <&tda998x_spdif0>;
		};
	};

- and the S/PDIF external output (spdif_out):

	port {
		spdif_out_port: endpoint@0 {
			reg =3D 0;
			remote-endpoint =3D <&audio1_spdif1>;
		};
	};

All the hardware is described. There is nothing more to add in the DT.

Especially, there is no 'simple-card' which is pure software and rather
Linux specific.

And, now, from this DT description, ASoC expects a sound card to be
built.

It seems that this creation should be done in the same way the video
cards are built, i.e. from the source devices, i.e. the kirkwood-like
device, and also from the spdif_in (which could be some other internal
audio device outputting s/pdif instead of a simple S/PDIF input
connector)! Is there one or two cards, and if 2 cards, how do they
share the tda998x?

Well, I will have a look at how to get audio out of my machine with
these new DT definitions (hopefully, there is only one audio source!).

Mark, you may forget about my other patch adding multi-codecs in the
simple-card...

Thanks.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
