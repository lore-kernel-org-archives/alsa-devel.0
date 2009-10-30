From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add support for CLKOUT to wm8731 codec
	driver
Date: Fri, 30 Oct 2009 18:32:07 +0000
Message-ID: <B3102D86-255A-4DC5-BEDA-28356E5F57AD@opensource.wolfsonmicro.com>
References: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
	<1256829202-2508-2-git-send-email-bgat@billgatliff.com>
	<20091029160534.GE15559@sirena.org.uk>
	<4AEB194C.700@billgatliff.com>
	<20091030170003.GA28420@rakim.wolfsonmicro.main>
	<4AEB2EDA.8080008@billgatliff.com>
	(sfid-20091030_182231_835396_A571493E)
Mime-Version: 1.0 (iPhone Mail 7D11)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D00F91037F9
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 19:32:16 +0100 (CET)
In-Reply-To: <4AEB2EDA.8080008@billgatliff.com>
	(sfid-20091030_182231_835396_A571493E)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On 30 Oct 2009, at 18:22, Bill Gatliff <bgat@billgatliff.com> wrote:

> Mark Brown wrote:
>> On Fri, Oct 30, 2009 at 11:50:20AM -0500, Bill Gatliff wrote:
>>
>>> Mark Brown wrote:
>>>
>>
>>
>>>> It'd be better define a new clock for the CLKOUT pin rather than  
>>>> munging
>>>> it in with the master clock.  MCLK is always an input on the  
>>>> WM8731, the
>>>> CLKOUT output is a separate pin and so including it in MCLK is  
>>>> likely to
>>>> make things confusing and could well introduce errors.
>>>>
>>
>>
>>> Could you explain more about what you meant by this?  I'm trying to
>>> rework these patches now, and I don't understand how to implement  
>>> what
>>> you are suggesting.
>>>
>>
>> Define two clock IDs and then use a switch statement in the  
>> function to
>> determine which to act on, allowing the master clock to be controlled
>> separately to the output clock.
>>
>
> Can you refer me to an existing example?

wm8993 supports multiple internal options for sysclk usig the id  
parameter. Could you be more explicit about what you can't follow here  
please? I might be able to help more if I could see what's confusing  
you.

>
>
> b.g.
>
> -- 
> Bill Gatliff
> bgat@billgatliff.com
>
