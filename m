From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Fix wm8753 register cache size and
	initialization
Date: Fri, 03 Jul 2009 12:15:45 +0200
Message-ID: <4A4DDA51.3070401@metafoo.de>
References: <1246574768-11447-1-git-send-email-lars@metafoo.de>
	<20090703093250.GA29130@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-036.synserver.de (smtp-out-082.synserver.de
	[212.40.180.82]) by alsa0.perex.cz (Postfix) with SMTP id 75E91246FF
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 12:15:33 +0200 (CEST)
In-Reply-To: <20090703093250.GA29130@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Fri, Jul 03, 2009 at 12:46:08AM +0200, Lars-Peter Clausen wrote:
>
>   
>> The register cache size is of by one. There are 63 registers in use but the
>> register cache size has only space for 62.
>>     
>
> Only 62 of the registers are cached - please see the register cache
> access code.
>   
Yes. Thats the problem. The register cache holds place for 62 elements 
where as there are 63 register which should be cached.
In the register cache access code you subtract one from the registers 
index to get it's index in the register cache array, so the last 
register has the index 62. Which means it is the 63th element of the 
array and thus the array has to consist of 63 elements.

Currently reads to WM8753_ADCTL2 will always return -1 as it is out of 
the register cache bounds which causes the OUT4 control to be unusable 
and as a side effect audio volume will be quite low.
>   
>> Furthermore the codec's reg_cache_size is of by another one. Since the wm8753
>> register cache uses one-based indexing we have to add one to its size.
>>     
>
> I'm not 100% sure what you mean here but I suspect you're misreading the
> register cache access code?
>   
The register cache access code uses one-based indexing so the first 
element in the register cache array will be the register with the number 
1 and the last register has the number ARRAY_SIZE(wm8753_reg).
Now if you set reg_cache_size to ARRAY_SIZE(wm8753_reg) the last 
register will never show up in devices codec_reg sysfs file as its index 
is not lower the reg_cache_size.

- Lars
