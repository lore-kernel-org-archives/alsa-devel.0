From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [RFC][PATCH] ASoC: add simple-graph-card document
Date: Wed, 25 Jan 2017 11:27:24 +0100
Message-ID: <b1626b5a-31f0-5d82-1c73-633ca85996d0@samsung.com>
References: <87r33z4maj.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+pDkfijyKV0ALzZUrH-NVzmLaNj6ivAEFO98NUOXGojw@mail.gmail.com>
 <871svymrnt.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_JsqLOwQn_hz3B5gFL-zr-Pm_8PX+b-sAQhLwkioD7E-ODAw@mail.gmail.com>
 <87wpdm1cyq.wl%kuninori.morimoto.gx@renesas.com>
 <CGME20170123091136epcas2p15643b17d26e629545b3848b22e1afa68@epcas2p1.samsung.com>
 <87tw8q1bct.wl%kuninori.morimoto.gx@renesas.com>
 <6e3976e8-d26c-e39e-e886-4ab00ce79d01@samsung.com>
 <87sho9fgju.wl%kuninori.morimoto.gx@renesas.com>
 <c4541388-904f-9886-7e8a-a609ed9feaa7@samsung.com>
 <87mveg9f4x.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <87mveg9f4x.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/25/2017 01:09 AM, Kuninori Morimoto wrote:
>> It seems the graph based binding could cover above both cases.  Apologies
>> if this has been explained before, but what are main reasons for introducing
>> the graph based binding?
>
> The big reason why I want to introduce OF-graph simple card is that
> I need to support HDMI sound. HDMI video side is already using
> OF-graph base DT binding. So it is useful if HDMI sound side can follow
> same style.

OK, thanks, as I understood something which covers more than simple
CPU<->CODEC point-to-point connections is needed.

I have also been working on adding proper HDMI audio support for Exynos. 
One issue I can see with proposed binding is that when we use the graph 
binding for both video and audio with a device that supports both, 
e.g. HDMI transmitter we need to somehow differentiate the purpose 
of each port.  To avoid the sound subsystem parsing video port/endpoint 
nodes and the other way around.

For instance in arch/arm/boot/dts/rk3036.dtsi we have already:

	hdmi: hdmi@20034000 {
		compatible = "rockchip,rk3036-inno-hdmi";
		reg = <0x20034000 0x4000>;
		...

		hdmi_in: port {
			#address-cells = <1>;
			#size-cells = <0>;
			hdmi_in_vop: endpoint@0 {
				reg = <0>;
				remote-endpoint = <&vop_out_hdmi>;
			};
		};
	};

And with the sound binding added it could have become:

	hdmi: hdmi@20034000 {
		compatible = "rockchip,rk3036-inno-hdmi";
		..
		ports {
			#address-cells = <1>;
			#size-cells = <0>;

			/* video */
			hdmi_in: port@0 {
				reg = <0>;
				hdmi_in_vop: endpoint {
					remote-endpoint = <&vop_out_hdmi>;
				};
			};

			/* audio */
			hdmi_audio_out: port@? {
				reg = <?>;	
				endpoint {
					remote-endpoint = <&i2s>;
				};
			};
	};

	i2s: i2s@10220000 {
		compatible = "rockchip,rk3036-i2s", "rockchip,rk3066-i2s";
		reg = <0x10220000 0x4000>;
		...
	};

Now within individual device bindings the type of the port (audio, 
video) could be determined by reg property, by assigning specific 
values for video and audio.  But if we wanted to make this more generic 
we would probably need something like a property determining the port's 
purpose, e.g.

	type = "audio";

Regarding compatible string for the card, how about "soc-sound-card-v1"
instead of "asoc-simple-graph-card" ? Or "soc-simple-graph-card"? 
Appending version now could let us avoid inventing funny names when 
it turns we need some different binding in future.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
