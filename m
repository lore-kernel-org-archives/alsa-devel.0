From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8825: extend FLL function
Date: Tue, 8 Mar 2016 19:58:53 +0800
Message-ID: <56DEBE7D.70100@nuvoton.com>
References: <1456683827-6597-1-git-send-email-KCHSU0@nuvoton.com>
 <20160301032316.GG18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 89B6F2619D0
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 12:58:57 +0100 (CET)
In-Reply-To: <20160301032316.GG18327@sirena.org.uk>
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

Hi,

On 3/1/2016 11:23 AM, Mark Brown wrote:
> On Mon, Feb 29, 2016 at 02:23:47AM +0800, John Hsu wrote:
>   
>> Extend FLL clock source from MCLK/BCLK/FS.
>> Modify FLL calculation and parameter setting.
>>     
>
> I'm sorry but this really doesn't tell me very much about what this is
> supposed to do so it's very hard to tell if the change does it or not.
> It also sounds like there's multiple different changes going on here, if
> nothing else it sounds like there's the addition of some new sources for
> the FLL and also some unspecified changes to the calculations.  Separate
> changes should be in separate patches.
>
>   
In the patch, we add FLL clock source selection. The source can be from 
MCLK, BCLK or FS.
Besides, driver extend higher frequency for better performance in FLL 
calculation,
and has different register apply if fraction or not. Just separate it. 
Right?

>> +	/* We selected MCLK source but the clock itself managed externally */
>> +	if (!nau8825->mclk)
>> +		return 0;
>> +
>>     
>
> That comment sounds *very* suspicous, if we are using MCLK we should
> manage it via the clock API.  If the platform doesn't have good clock
> support we should fix the platform.
>
>   
In initiation, we get mclk object from platform as the following code.
If the mclk is not found, we don't need to prepare it in the driver.

    nau8825->mclk = devm_clk_get(dev, "mclk");
    ...
    } else if (PTR_ERR(nau8825->mclk) == -ENOENT) {
        /* The MCLK is managed externally or not used at all */
        nau8825->mclk = NULL;
        dev_info(dev, "No 'mclk' clock found, assume MCLK is managed 
externally");


>> +	if (nau8825->mclk_freq != freq) {
>> +		nau8825->mclk_freq = freq;
>> +
>> +		freq = clk_round_rate(nau8825->mclk, freq);
>> +		ret = clk_set_rate(nau8825->mclk, freq);
>> +		if (ret) {
>> +			dev_err(nau8825->dev, "Unable to set mclk rate\n");
>> +			return ret;
>> +		}
>>     
>
> We store the frequency even if we failed to set it.  This means that if
> we retry we'll skip over setting which is buggy.
>   
Yes, it's better to store it when everything get done correctly.
