From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: extend FLL function
Date: Thu, 10 Mar 2016 12:31:54 +0800
Message-ID: <56E0F8BA.4010209@nuvoton.com>
References: <1456683827-6597-1-git-send-email-KCHSU0@nuvoton.com>
 <20160301032316.GG18327@sirena.org.uk> <56DEBE7D.70100@nuvoton.com>
 <20160309024034.GC3898@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 27A1D260694
 for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2016 05:31:58 +0100 (CET)
In-Reply-To: <20160309024034.GC3898@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org

On 3/9/2016 10:40 AM, Mark Brown wrote:
> On Tue, Mar 08, 2016 at 07:58:53PM +0800, John Hsu wrote:
>
>   
>> In the patch, we add FLL clock source selection. The source can be from
>> MCLK, BCLK or FS.
>> Besides, driver extend higher frequency for better performance in FLL
>> calculation,
>> and has different register apply if fraction or not. Just separate it.
>> Right?
>>     
>
> I think that's what I was asking for, yes.
>   

I'll split these solution into two patches later and resubmit.

>   
>>> That comment sounds *very* suspicous, if we are using MCLK we should
>>> manage it via the clock API.  If the platform doesn't have good clock
>>> support we should fix the platform.
>>>       
>
>   
>> In initiation, we get mclk object from platform as the following code.
>> If the mclk is not found, we don't need to prepare it in the driver.
>>     
>
>   
>>    nau8825->mclk = devm_clk_get(dev, "mclk");
>>    ...
>>    } else if (PTR_ERR(nau8825->mclk) == -ENOENT) {
>>        /* The MCLK is managed externally or not used at all */
>>        nau8825->mclk = NULL;
>>        dev_info(dev, "No 'mclk' clock found, assume MCLK is managed
>> externally");
>>     
>
> This really isn't a good way to be handling things, you should be
> ensuring that platforms that have an MCLK provide one via the clock API.
> If the clock is missing that should indicate that it's the second case
> where it's not used at all.
>   

Do you mean I should use devm_clk_get to check mclk exist instead of
nau8825->mclk in nau8825_mclk_prepare function? And return a warn-
ing message if mclk is missing?
