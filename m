From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: Re: [PATCH] ASoC: jack: remove unused variable in snd_soc_jack_report()
Date: Mon, 22 Oct 2012 22:13:10 +0800
Message-ID: <CAPgLHd_Ee81ye-QqQj35ZpmzBdGpdGpdS8dUY7m=PUTFxHUVPw@mail.gmail.com>
References: <CAPgLHd-DCVsDnKG6uH=Pq7hABRmyEfJ30GxczD99cmjSQQiWDA@mail.gmail.com>
	<20121022135048.GI4477@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121022135048.GI4477@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: lrg@ti.com, perex@perex.cz, tiwai@suse.de, yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/22/2012 09:50 PM, Mark Brown wrote:
> On Thu, Oct 18, 2012 at 10:49:19PM +0800, Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>>
>> The variable oldstatus is initialized but never used
>> otherwise, so remove the unused variable.
> Applied, thanks.  However for changes like this you should really
> consider in your changelog why the variable is unused - is the bug that
> the result is ignored or that it is needlessly generated?

Yes, I will review every patch before send out them. I will try to
fix it if it is a bug, but some times, I does not have all of those
knowledge, many place have unused variables, but it is hard to
find why this is unused, so maybe some times I send the wrong
patch.

Like this patch:
https://patchwork.kernel.org/patch/1606481/
It is found by the same rule, but I fixed it as a bug.

Thanks,
Yongjun Wei
