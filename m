From: Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] Sound: SOC: TAS571x: added missing register
 literals
Date: Wed, 30 Mar 2016 10:14:56 +0200
Message-ID: <56FB8B00.4000408@barix.com>
References: <1459237178-12920-1-git-send-email-petr@barix.com>
 <20160329213305.GO2350@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160329213305.GO2350-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: cernekee-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 29.03.2016 23:33, Mark Brown wrote:
> On Tue, Mar 29, 2016 at 09:39:34AM +0200, Petr Kulhavy wrote:
>
>> The list of TAS571x registers was incomplete.
>> Added the missing register definitions up to register 0x25
> According to the driver the device has registers up to 0xff?

That is indeed true. But from address 0x29 on (0x26 to 0x28 are 
reserved) the register width varies between 20, 12 and 8 bytes, which 
I'm afraid the register map is unable to represent.

>>   /* device registers */
>> +#define TAS571X_CLK_CTRL_REG		0x00
>> +#define TAS571X_DEV_ID_REG		0x01
>> +#define TAS571X_ERR_STATUS_REG		0x02
>> +#define TAS571X_SYS_CTRL_1_REG		0x03
> These look like volatile registers but the device has a register cache
> and we're not adding a list of volatile registers (or readable registers
> for that matter).
That's a good point, thanks! 0x03 is a regular RW register but 0x00 to 
0x02 are indeed volatile.
Is it better to make them read-only, or volatile?

Petr
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
