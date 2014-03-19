From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 4/4] ASoC: simple-card: Add DT documentation for multi-DAI
 links
Date: Wed, 19 Mar 2014 12:08:55 +0200
Message-ID: <53296CB7.1000909@ti.com>
References: <cover.1394883134.git.moinejf@free.fr>	<d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr>	<20140317164339.GR11706@sirena.org.uk> <20140318091728.1d2240ca@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140318091728.1d2240ca@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 03/18/2014 10:17 AM, Jean-Francois Moine wrote:
> On Mon, 17 Mar 2014 16:43:39 +0000
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> On Sat, Mar 15, 2014 at 12:30:05PM +0100, Jean-Francois Moine wrote:
> 	[snip]
...

>
> I agree. I see two possible syntaxes:
>
> 1) keep the same definitions in the containers:
>
> sound {
> 	compatible = "simple-audio-card";
> 	simple-audio-card,name = "Cubox Audio";
>
> 	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
> 		simple-audio-card,cpu {
> 			sound-dai = <&audio1 0>;
> 			format = "i2s";
> 		};
> 		simple-audio-card,codec {
> 			sound-dai = <&tda998x 0>;
> 		};
> 	};
>
> 	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
> 		simple-audio-card,cpu {
> 			sound-dai = <&audio1 1>;
> 		};
> 		simple-audio-card,codec {
> 			sound-dai = <&tda998x 1>;
> 		}
> 	};
> 	...
>

I vote for the version above. As Mark said there is need for dai 
specific properties.

While we are at it we could update the bitclock-master and frame-master 
syntax to be like this:

bitclock-master = "cpu"
frame-master = "codec"

With the above explicit definition all the daifmt settings could be 
defined in link level. For backwards compatibility we could still define 
that omitting the value equals "codec" and omitting the property equals 
"cpu".

It may sometimes be helpful to allow overwriting link level settings in 
dai level. In order to do that it should be possible to write all daifmt 
settings explicitly like this:

bitclock-inversion = <0>; /* <0> = no bitclock-inversion */

If backward compatibility is necessary we could recognize the syntax 
version from the existence dai-link node.

sound {
	compatible = "simple-audio-card";
	simple-audio-card,name = "Simple Audio";
	simple-audio-card,widgets = ...
	simple-audio-card,routing = ...

	simple-audio-card,dai-link@0 {		/* I2S - codec */
		format = "i2s";
		bitclock-master = "codec";
		frame-master = "codec";
		bitclock-inversion = <1>;
		simple-audio-card,cpu {
			sound-dai = <&audio1 0>;
			bitclock-inversion = <0>;
		};
		simple-audio-card,codec {
			sound-dai = <&codec 0>;
			system-clock-frequency = <12000000>;
		};
	};
...

I can participate in the implementation too.

Best regards,
Jyro
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
