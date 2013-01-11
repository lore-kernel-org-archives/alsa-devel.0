From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 2/8] ASoC: Add support
 for virtual switch controls
Date: Fri, 11 Jan 2013 16:08:39 +0100
Message-ID: <50F02AF7.9090700@metafoo.de>
References: <1357833977-3682-1-git-send-email-lars@metafoo.de>
	<1357833977-3682-2-git-send-email-lars@metafoo.de>
	<20130111121912.GY20956@opensource.wolfsonmicro.com>
	<50F007DF.9000606@metafoo.de>
	<20130111124535.GZ20956@opensource.wolfsonmicro.com>
	<50F00BF1.6090702@metafoo.de>
	<20130111135754.GB20956@opensource.wolfsonmicro.com>
	<50F02A51.3010108@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <50F02A51.3010108-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 01/11/2013 04:05 PM, Lars-Peter Clausen wrote:
> On 01/11/2013 02:57 PM, Mark Brown wrote:
>> On Fri, Jan 11, 2013 at 01:56:17PM +0100, Lars-Peter Clausen wrote:
>>> On 01/11/2013 01:45 PM, Mark Brown wrote:
>>
>>>> Virtual enums do actually end up routing, that's not what a mute control
>>>> usually does.  You can do the above in the manner I suggested, just have
>>>> the register forced to a particular value when the DAC is disabled.
>>
>>> Well, that's what the code does. The alternative is to implement more or
>>
>> No, it's not (at least not according to the changelog).  It implements a
>> totally separate virtual control.
> 
> What do you mean by 'separate'? Maybe this is was causes the confusion. Do
> you mean a separate DAPM control, like DAPM_SWITCH? That's not what the
> patch does it creates a virtual kcontrol, which can be used to control a
> mixers input. It's the pendant to SOC_DAPM_ENUM_VIRT not to

s/pendant/counterpart/ apparently this is a false friend

> SND_SOC_DAPM_VIRT_MUX. I realize that the commit message may have been a bit
> ambiguous in that regard.
> 
> - Lars
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
