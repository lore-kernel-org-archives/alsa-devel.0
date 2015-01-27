From: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ASoC: codecs: wm8904: add dt ids
 table
Date: Tue, 27 Jan 2015 09:35:13 +0800
Message-ID: <54C6EB51.80005@atmel.com>
References: <1418614273-2303-1-git-send-email-voice.shen@atmel.com> <20150115115425.GX3043@sirena.org.uk> <54B866B9.8000900@atmel.com> <54C65C36.9050106@atmel.com> <20150126164229.GB21293@sirena.org.uk> <54C67007.6000708@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C67007.6000708-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sound-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexander Morozov <linux-lCH5ugpmZSMox3rIn2DAYQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark, Lars-Perter,

On 01/27/2015 12:49 AM, Lars-Peter Clausen wrote:
> On 01/26/2015 05:42 PM, Mark Brown wrote:
>> On Mon, Jan 26, 2015 at 04:24:38PM +0100, Nicolas Ferre wrote:
>>> Le 16/01/2015 02:17, Bo Shen a =E9crit :
>>
>>>>> Does this end up in the i2c_driver_id driver data or do we need s=
ome
>>>>> extra code when devtype is assigned to check for an of_node and
>>>>> look at
>>>>> the DT data instead?  That certainly used to be the case...
>>
>>>> At the beginning I think as the same as you, and also add the code=
 to
>>>> get the data as I do in <drivers/misc/atmel-ssc.c>. However, as I
>>>> remember, I2C seems only use the compatible string after the comma=
,
>>>> that
>>>> means only for "wlf,wm8904", it uses "wm8904" to match. So, I remo=
ve
>>>> all
>>>> the code I added, and just keep these, and it can get the device t=
ype
>>>> correctly.
>>
>>>> So, when I submit the patch and keep the code as simple as possibl=
e.
>>
>>> I don't understand what's keeping this patch from being applied. Vo=
ice,
>>> do you mind re-sending?
>>
>> I need to convince myself that the above actually works and is doing=
 the
>> right thing; the above explanation sounds like if it works it might =
be
>> relying on a bug.
>
> I'd call it a undocumented feature. But I wouldn't rely on it being
> around for ever. In my opinion to be future proof the driver should
> explicitly handle the OF case in the probe function.
>

I will add this into probe function in next version.
Thanks.

Best Regards,
Bo Shen
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
