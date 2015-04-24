From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [alsa-devel] [PATCH 6/8] extcon: arizona: Add support for	WM8998
 and WM1814
Date: Fri, 24 Apr 2015 09:59:37 +0900
Message-ID: <55399579.9090104@samsung.com>
References: <1429619636-25478-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1429619636-25478-7-git-send-email-rf@opensource.wolfsonmicro.com>
 <55373766.6060106@samsung.com>
 <20150422091941.GA4303@opensource.wolfsonmicro.com>
 <553775D9.9080606@samsung.com>
 <20150423141540.GA17323@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <20150423141540.GA17323@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: gnurou@gmail.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linus.walleij@linaro.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org, myungjoo.ham@samsung.com, ckeepax@opensource.wolfsonmicro.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org

On 04/23/2015 11:15 PM, Richard Fitzgerald wrote:
> On Wed, Apr 22, 2015 at 07:20:09PM +0900, Chanwoo Choi wrote:
>> On 04/22/2015 06:19 PM, Richard Fitzgerald wrote:
>>> On Wed, Apr 22, 2015 at 02:53:42PM +0900, Chanwoo Choi wrote:
>>>> Hi Richard,
>>>>
>>>>> @@ -1176,6 +1182,11 @@ static int arizona_extcon_probe(struct platform_device *pdev)
>>>>>  			break;
>>>>>  		}
>>>>>  		break;
>>>>> +	case WM8998:
>>>>> +	case WM1814:
>>>>> +		info->micd_clamp = true;
>>>>> +		info->hpdet_ip = 2;
>>>>
>>>> What is meaning of '2'? I prefer to use the definition for '2'.
>>>>
>>>
>>> '2' is the version number of the hpdet ip block in silicon. We're already using
>>> it as a raw number '0', '1' or '2' all over extcon-arizona.c so changing it here
>>> would mean making other patches to the file that aren't really part of adding
>>> WM8998 support, so I'd prefer not to change that as a side-effect of adding WM8998.
>>
>> I think that just you can define following definitions and use HPDET_IP_VER_V2 instead of '2'.
>>
>> 	#define HPDET_IP_VER_V0		0
>> 	#define HPDET_IP_VER_V1		1
>> 	#define HPDET_IP_VER_V2		2
>>
> 
> Can we deal with that as a separate patch from this series? Like I said,
> the code already uses '0' '1' and '2' for the existing codecs so making a
> change to use #define means patching the code for the other codecs. That
> is not part of adding WM8998 support and I don't like patches that make
> unexpected extra side-effect changes that are not relevant to the actual
> functionality being added by the patch. It's specially annoying when
> cherry-picking or reverting those patches if they included some extra
> code change.
> 
> If we can get this series submitted I can look at making a later patch
> to improve readbility, but since this really is just a version number I
> think it would be enough to rename the variable to hpdet_ip_version rather
> than effectively doing #define TWO 2

OK. I agree that rename the variable name (hpdet_ip_version)
or add the definitions for version on later patch.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi

