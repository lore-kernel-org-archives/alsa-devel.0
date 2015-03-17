From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: Can iMX6SL supports different sampling rate for
 different SSIs?
Date: Tue, 17 Mar 2015 08:45:06 +0800
Message-ID: <55077912.1020102@gmail.com>
References: <5507743B.5040808@gmail.com> <20150317003830.GA552@Asurada-GSX>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f170.google.com (mail-qc0-f170.google.com
 [209.85.216.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 636D6261A18
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 01:45:13 +0100 (CET)
Received: by qcaz10 with SMTP id z10so60544204qca.1
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 17:45:10 -0700 (PDT)
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

Nicolin, thank you very much.


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
>
> Nicolin
>

-- 
Xuebing
