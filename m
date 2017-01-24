From: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [alsa-devel] [RFC][PATCH] ASoC: add simple-graph-card document
Date: Tue, 24 Jan 2017 15:10:48 +0100
Message-ID: <c4541388-904f-9886-7e8a-a609ed9feaa7@samsung.com>
References: <87r33z4maj.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_Jsq+pDkfijyKV0ALzZUrH-NVzmLaNj6ivAEFO98NUOXGojw@mail.gmail.com>
 <871svymrnt.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_JsqLOwQn_hz3B5gFL-zr-Pm_8PX+b-sAQhLwkioD7E-ODAw@mail.gmail.com>
 <87wpdm1cyq.wl%kuninori.morimoto.gx@renesas.com>
 <CGME20170123091136epcas2p15643b17d26e629545b3848b22e1afa68@epcas2p1.samsung.com>
 <87tw8q1bct.wl%kuninori.morimoto.gx@renesas.com>
 <6e3976e8-d26c-e39e-e886-4ab00ce79d01@samsung.com>
 <87sho9fgju.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <87sho9fgju.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-DT <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/24/2017 01:30 AM, Kuninori Morimoto wrote:
>>> +Simple-Graph-Card:
>>
>> This binding is likely going to cover most of existing sound system
>> configuration, at least it looks as it has a potential to be scalable
>> enough.  So perhaps we could treat is as a more generic binding and
>> could drop the "Simple" word now?  I'm not 100% sure it's a good idea,
>> but maybe we could make it "Generic Sound Card DT Binding"?
> (snip)
>>> +Required properties:
>>> +
>>> +- compatible				: "asoc-simple-graph-card";
>>
>> "asoc" is Linux related, we shouldn't be putting this in the compatible string.
>> Perhaps "generic-sound-card" ? Again, I'm sure if it is expected to have such
>> a generic kind of DT binding.
> 
> This is OF-graph version of existing "simple-card"
> (sound/soc/generic/simple-card.c).
> As you know, ASoC sound card can have many features, but what this sound card
> can do is just CPU-Codec connection and some small additional things.
> You can use this card if you want to just connect CPU-Codec,
> but if you want to use more advanced feature on your sound card,
> then, you need to create your own sound card.
> Of course we can expand simple card, but has some limitation.
> 
> For example, we have simple-scu-card.c which is for DPCM version of simple card.
> As you can see, these are using almost same DT bindings, but using different
> feature because normal sound card and DPCM sound card are totally different.

Is the main difference between "normal" and DPCM card that in case of the
former the data flow routes are static and the latter allows dynamic
reconfiguration of sound data routes? AFAIU DPCM stands here for Dynamic
PCM [1], rather than Differential Pulse Code Modulation.

It seems the graph based binding could cover above both cases.  Apologies
if this has been explained before, but what are main reasons for introducing
the graph based binding?

Is the SCU part in "ASoC simple SCU Sound Card" derived from "(S)ample Rate
(C)onverter (U)nit" ?

> Thus, unfortunately, using "generic" in compatible is a little bit over-kill.
> So I and Mark had named it as "simple" card.
> Thus I want to keep this "simple" on this OF-graph version driver too.
[...]
>> I wouldn't be making a separate case for single DAI. The 'ports' node can
>> be omitted, port@0, port@1 nodes could be put under respective device nodes
>> and in the 'sound' node we would have 'dais' property pointing to the CPU
>> DAI port,  not the endpoint.  The endpoint is supposed to describe one of
>> possible configurations of the port.  I think we want phandles to the 'port'
>> nodes, not phandles to the 'endpoint' nodes in the 'sound' node.
> 
> Last 2 line was unfortunately not clear for me. do you mean
> dais = <&cpu_port>; on card ?
> This driver want to handle both single/multi DAI connection,
> so, using same rule is more easy and simple.
> If my understanding was correct, do you mean like below ?

Yes, exactly.

> 	cpu: cpu {
> 		...
> 		cpu_port: port {
> 			cpu_out: endpoint {
> 				remote-endpoint = <&codec_in>;
> 			};
> 		};
> 	};
> 
> 	codec: codec {
> 		...
> 		codec_port: port {
> 			codec_in: endpoint {
> 				remote-endpoint = <&cpu_out>;
> 			};
> 		};
> 	};
> 
> 	card {
> 		compatible = "asoc-simple-graph-card";
> 
> 		dais = <&cpu_port>;
> 	};
> 
> If so, I want Multi DAI like this
> 
> 	cpu: cpu {
> 		...
> 		ports {
> 			cpu0_port: port {
> 				cpu0_out: endpoint {
> 					remote-endpoint = <&codec0_in>;
> 				};
> 			};
> 			cpu1_port: port {
> 				cpu1_out: endpoint {
> 					remote-endpoint = <&codec1_in>;
> 				};
> 			};
> 		};
> 	};
> 
> 	codec0: codec@0 {
> 		...
> 		codec0_port: port {
> 			codec0_in: endpoint {
> 				remote-endpoint = <&cpu0_out>;
> 			};
> 		};
> 	};
> 
> 	codec1: codec@1 {
> 		...
> 		codec1_port: port {
> 			codec1_in: endpoint {
> 				remote-endpoint = <&cpu1_out>;
> 			};
> 		};
> 	};
> 
> 	card {
> 		compatible = "asoc-simple-graph-card";
> 
> 		dais = <&cpu0_port
> 			&cpu1_port>;
> 	};

[1] https://kernel.org/doc/html/latest/sound/soc/dpcm.html

--
Thanks,
Sylwester
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
