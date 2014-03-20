From: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 4/4] ASoC: simple-card: Add DT documentation
 for multi-DAI links
Date: Thu, 20 Mar 2014 13:24:22 +0200
Message-ID: <532ACFE6.5060703@ti.com>
References: <cover.1394883134.git.moinejf@free.fr> <d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr> <20140317164339.GR11706@sirena.org.uk> <20140318091728.1d2240ca@armhf> <53296CB7.1000909@ti.com> <5329E749.6070900@metafoo.de> <5329ECC2.7040803@ti.com> <20140319192157.GW11706@sirena.org.uk> <5329F0A1.8020801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5329F0A1.8020801-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 03/19/2014 09:31 PM, Lars-Peter Clausen wrote:
> On 03/19/2014 08:21 PM, Mark Brown wrote:
>> On Wed, Mar 19, 2014 at 09:15:14PM +0200, Jyri Sarha wrote:
>>> On 03/19/2014 08:51 PM, Lars-Peter Clausen wrote:
>>
>>>> When does this make sense? Either the bitclock is inverted for all of
>>>> them or for none.
>>
>>> Definition of clock signal and it's inversion varies between chip
>>> manufacturers and sometimes it may not be possible to get all the dai
>>> drivers to work identically in this respect. Because of this in some
>>> cases
>>> there may be a need to set the inversion bit only at one end of the
>>> link.
>>
>> No, Linux has a definition of all the clock modes which applies to all
>> devices regardless of what the manufacturer documents in their
>> datasheet.
>>
>
> Yep. The clock properties are well defined for the different modes that
> can be specified in the format property. It's up to the driver to
> translate this to driver specific settings. If two drivers behave
> differently for the same mode one of them (or both) are broken.
>

After a little thinking it is clear to me too that only reason to have 
this overwrite capability is a badly written dai driver. Even with buggy 
HW it should always be possible to present the working modes in daifmt 
terms. Ok, let's remove it.

Here is an updated DT example with updated phandle for master settings:

sound {
     compatible = "simple-audio-card";
     simple-audio-card,name = "Simple Audio";
     simple-audio-card,widgets = ...
     simple-audio-card,routing = ...

     simple-audio-card,dai-link@0 {        /* I2S - codec */
         format = "i2s";
         bitclock-master = <&dai_link_master>
         frame-master = <&dai_link_master>;
         bitclock-inversion;
         simple-audio-card,cpu {
             sound-dai = <&audio1 0>;
         };
         dai_link_master: simple-audio-card,codec {
             sound-dai = <&codec 0>;
             system-clock-frequency = <12000000>;
         };
     };
...


> We should probably add the definitions for the different formats to the
> DT bindings. E.g. what is default, what is inverted polarity, etc.
>

That is a good idea.

Best regards,
Jyri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
