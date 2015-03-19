From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: Can iMX6SL supports different sampling rate for
 different SSIs?
Date: Fri, 20 Mar 2015 07:13:19 +0800
Message-ID: <550B580F.6070101@gmail.com>
References: <5507743B.5040808@gmail.com> <20150317003830.GA552@Asurada-GSX>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F157260695
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 00:13:25 +0100 (CET)
Received: by qcto4 with SMTP id o4so80405940qct.3
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 16:13:24 -0700 (PDT)
In-Reply-To: <20150317003830.GA552@Asurada-GSX>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, niranjan Patil <Niranjan.Patil@infocus.com>, Richard Jiang <Richard.Jiang@infocus.com>
List-Id: alsa-devel@alsa-project.org


On 03/17/2015 08:38 AM, Nicolin Chen wrote:
> On Tue, Mar 17, 2015 at 08:24:27AM +0800, Xuebing Wang wrote:
>
>> 2) As pll4_main_clk is global for all 3 SSIs, I think that we can *not* use
>> 8k for ssi1 and 44.1k for ssi2, right? Because 8k and 44.1k requires
>> different pll4 clock, right?
> True.
>
>>      -- However, as 48k, 32k, 16k, 8k can use same pll4, thus different SSI
>> can use different sampling rate in this subset (48k, 32k, 16k, 8k).
>>      -- Same principle applies for 44.1k, 22.050, 11.025 subset of sampling
>> rates.
> Correct. You need to choose 48K-group or 44.1K-group if only using PLL4.
>
> If you are so obsessed with full sample rate support in hardware level,
> you might need to do a trade-off like sacrificing video function -- you
> would then be allowed to use PLL5 to forge a rate for another rate group.
>
> I forgot if PLL3, another possible parent clock of SSI, is suitable for
> one of the groups. You may also take a look at it.

Nicolin,

Thanks a lot for your help.

I am using an unused PLL3_PFD (454.7M) for SSI3, and it is working ok.

1) 454.7M is actually 454.736842. For 48k sampling rate, I am using 
(clk_pred = 1, clk_podf = 37) to generate ssi baudclk.
-- 454.736842 / 1 / 37 = 12.290185 MHz

2) If I derive from PLL4, then ssi baudclk = 12.288000, which correspond 
to iMX6SL reference manual "Table 48-7. SSI Bit Clock and Frame Rate as 
a Function of PSR, PM, and DIV2".
-- This is very accurate down to 1Hz

3) There is some deviation of baudclk (12.290185 vs 12.288000 MHz), 
which translates to the deviation of bit_clock of (3.072546 MHz vs 
3.072000 MHz for 48k rate, 546Hz deviation).

Is this the most accurate clock we can get if we use PLL3_PFD? Thanks again.


> Nicolin
>

-- 
Xuebing
