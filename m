From: "Porter, Matt" <mporter@ti.com>
Subject: Re: [PATCH v2 0/2] Convert davinci ASoC to genalloc
	SRAM
Date: Thu, 18 Oct 2012 14:41:43 +0000
Message-ID: <97AD915E-BA5A-4003-8ECC-0798C88222B1@ti.com>
References: <1349991229-32107-1-git-send-email-mporter@ti.com>
 <20121017135116.GU14199@opensource.wolfsonmicro.com>
 <507EBB65.2090100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id B97DA2652E5
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2012 16:41:45 +0200 (CEST)
In-Reply-To: <507EBB65.2090100@gmail.com>
Content-Language: en-US
Content-ID: <11A483E24BB65E4FAA5E274EFD77CA76@owa.mail.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Nori,
 Sekhar" <nsekhar@ti.com>, Alsa Devel List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ben Gardiner <bengardiner@nanometrics.ca>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>
List-Id: alsa-devel@alsa-project.org


On Oct 17, 2012, at 10:06 AM, Daniel Mack wrote:

> On 17.10.2012 15:51, Mark Brown wrote:
>> On Thu, Oct 11, 2012 at 05:33:47PM -0400, Matt Porter wrote:
>> 
>>> This series converts davinci ASoC to use genalloc and enables
>>> that support on DA850. It applies to mainline on top of the
>>> uio_pruss/genalloc series [1] which allows DaVinci to provide
>>> a gen_pool via pdata for driver use.
>> 
>> I tried to apply these patches but patch 2 doesn't apply against
>> v3.7-rc1 I guess due to the series you mention.  What's the plan for
>> merging that series?  It'd also be good to get Daniel's patch squashed
>> in.
> 
> I'll resend the rebased patches from my 3.7-rc1 development branch with
> my patch squashed into 1/2. Matt, hope you're ok with that?

Yes, thanks.

-Matt
