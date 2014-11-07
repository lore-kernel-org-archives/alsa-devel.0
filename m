From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 2/2] ASoC: simple-card: add multi-CODECs
 in DT
Date: Fri, 07 Nov 2014 21:07:03 +0100
Message-ID: <545D2667.4070707@metafoo.de>
References: <cover.1415096705.git.moinejf@free.fr> <53ef077d2174f8eb5b861d6cebe7c9e732f06d52.1415096705.git.moinejf@free.fr> <20141107123035.GO8509@sirena.org.uk> <20141107200557.78971e08@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141107200557.78971e08@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 11/07/2014 08:05 PM, Jean-Francois Moine wrote:
> On Fri, 7 Nov 2014 12:30:35 +0000
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>>>   	} else {
>>> -		clk = of_clk_get(args.np, 0);
>>> +		clk = of_clk_get((struct device_node *) dai_np, 0);
>>
>> Adding this cast looks suspicous - why?  As far as I can tell the
>> original code didn't need one.
>
> Right, 'args.np' was (struct device_node *), but, now, 'dai_np' is
> (const struct device_node *).
>
> Changing 'dai_np' to (struct device_node *) in the
> asoc_simple_card_sub_parse_of() argument asks for a cast in calling
> this function because the field 'of_node' of the struct
> snd_soc_dai_link_component is (const struct device_node *).
>
> Do you better like this last cast?

Casting const away is usually a sign that something is wrong and has the 
potential to result in undefined behavior. The correct fix in this case is 
probably to make the np argument for of_clk_get() const.

- Lars

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
