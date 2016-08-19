From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC: nau8810: Add driver for Nuvoton
	codec chip NAU88C10
Date: Fri, 19 Aug 2016 10:51:22 +0800
Message-ID: <57B6742A.7030301@nuvoton.com>
References: <1471251743-32084-1-git-send-email-KCHSU0@nuvoton.com>
 <20160815140604.GK9347@sirena.org.uk> <57B28F1D.8070409@nuvoton.com>
 <20160816103854.GP9347@sirena.org.uk> <57B3B107.9080702@nuvoton.com>
 <20160817094221.GG9347@sirena.org.uk> <57B5098C.7020102@nuvoton.com>
 <20160818182439.GT9347@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C6AA2664B3
 for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2016 04:51:26 +0200 (CEST)
In-Reply-To: <20160818182439.GT9347@sirena.org.uk>
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
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 8/19/2016 2:24 AM, Mark Brown wrote:
> On Thu, Aug 18, 2016 at 09:04:12AM +0800, John Hsu wrote:
>   
>> On 8/17/2016 5:42 PM, Mark Brown wrote:
>>     
>
>   
>>> The whole point with raw read is that it isn't reformatting the value.
>>>       
>
>   
>> I post the partial function. The format_val is not valid for our
>> codec driver and we can't use the regmap_raw_read(). It's the reason
>> that we need to make the function like regmap_raw_read().
>>     
>
> Hrm, and you can't just make raw read work because other users are
> relying on the native endianness for single reads so bulk_read() then
> for the actual I/O?  At a bare minimum you need to provide comments in
> the code explaining what's going on, at the minute it looks like
> something that needs cleaning up.
>   

I'll have comment for details. Thank you for the advice.
