From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] Add support for CLKOUT to wm8731 codec
	driver
Date: Fri, 30 Oct 2009 13:22:18 -0500
Message-ID: <4AEB2EDA.8080008@billgatliff.com>
References: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
	<1256829202-2508-2-git-send-email-bgat@billgatliff.com>
	<20091029160534.GE15559@sirena.org.uk>
	<4AEB194C.700@billgatliff.com>
	<20091030170003.GA28420@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 204B1243A5
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 19:22:21 +0100 (CET)
Received: by bwz9 with SMTP id 9so10051713bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 11:22:20 -0700 (PDT)
In-Reply-To: <20091030170003.GA28420@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Oct 30, 2009 at 11:50:20AM -0500, Bill Gatliff wrote:
>   
>> Mark Brown wrote:
>>     
>
>   
>>> It'd be better define a new clock for the CLKOUT pin rather than munging
>>> it in with the master clock.  MCLK is always an input on the WM8731, the
>>> CLKOUT output is a separate pin and so including it in MCLK is likely to
>>> make things confusing and could well introduce errors.
>>>       
>
>   
>> Could you explain more about what you meant by this?  I'm trying to
>> rework these patches now, and I don't understand how to implement what
>> you are suggesting.
>>     
>
> Define two clock IDs and then use a switch statement in the function to
> determine which to act on, allowing the master clock to be controlled
> separately to the output clock.
>   

Can you refer me to an existing example?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
