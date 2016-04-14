From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 0/4] ASoC: add graph base connection on
 simple-card
Date: Thu, 14 Apr 2016 11:01:28 +0200
Message-ID: <20160414110128.56a0da97d526cdcb8d5f1ddf@free.fr>
References: <871t68wxxe.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <871t68wxxe.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Apr 2016 05:45:41 +0000
Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:

> Current simple-card is using "sound-dai" base connection on DT,
> but V4L2 is using graph base connection.
> For example HDMI case, we would like to use both connection.
> To above confusable connection method, and to reuse current resource,
> this patch adds new function, and detect both "sound-dai" and "remote=
-endpoint"
> on simple-card. like this
>=20
> 	sound {
> 		compatible =3D "simple-audio-card";
> 		...
> 		sndcpu: simple-audio-card,cpu {
> 			sound-dai =3D <&xxx>;
> 		};
> 		sndcodec: simple-audio-card,codec {
> =3D>			remote-endpoint =3D <&out_hdmi>;
> 		};
> 	};
>=20
> 	xxx {
> 		...
> 		ports {
> 			...
> 			port@0 {
> 				reg =3D <0>;
> 				out_rgb: endpoint {
> 				};
> 			};
> 			port@1 {
> 				reg =3D <1>;
> =3D>				out_hdmi: endpoint {
> 				};
> 			};
> 			...
> 		};
> 	};
	[snip]

Hi Kuninori,

Thanks for this first step towards the graph of ports in audio,
but I don't see exactly the use of this remote-endpoint.

According to Documentation/devicetree/bindings/graph.txt section
"Links between endpoints", the endpoint/remote-endpoint links are
bi-directional and describe the physical links: the audio port of the
codec is connected to the audio controller and reverse.
There is no reverse link from the codec to the 'simple-card'.

If the codec has only one DAI, using the remote-port just complexifies
the access to the codec (remote-port -> endpoint -> parent [->parent]).

If the codec has more than one audio input, a DT may look like:

	hdmi_transmitter {
		...
		port@1 {			/* audio from I2S */
			reg =3D <1>;
			...
			i2s: endpoint {
				remote-endpoint =3D <&audio_i2s>;
			};
		};
		port@2 {			 /* audio from S/PDIF */
			reg =3D <2>;
			...
			spdif: endpoint {
				remote-endpoint =3D <&audio_spdif>;
			};
		};
	};
(the video port is not shown and may be declared before, between or
after the audio ports)

The codec associated to the HDMI transmitter declares 2 DAIs.
It may choose to define the DAI numbers either in a fixed order
(say 0 is always S/PDIF and 1 is always I2S), or dynamically, following
the declaration of the ports (in the example, 0 is I2S and 1 is S/PDIF)=
=2E

As the DAI numbers are used by the simple card to get the DAI names,
their values must be know.

With the standard declaration of the codec DAIs in the simple card
(phandle to the codec - hdmi -  plus DAI number), either numbering
scheme works (the documentation of the hdmi transmitter tells which
scheme is used and the DAI number in the DT is set accordingly).

When using a phandle to the remote-endpoint (without DAI number), the
simple card has no direct way to find the DAI number:
- with a fixed order, some more information must be set in the DT
  (audio port type),
- with a dynamic order, a loop on all ports must be done, counting the
  audio ports and skipping the video port(s).

--=20
Ken ar c'henta=F1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
